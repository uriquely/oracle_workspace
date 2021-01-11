show user;

--한줄 주석, 주석 이후코드는 해석하지 않는다.
/*
여러줄 주석
*/

/*
    sys
    슈퍼관리자, 데이터베이스 생성/삭제 권한.
    로그인시 sysdba role선택 후 접속해야 함.
    
    system
    일반관리자, 데이터베이스 생성/삭제 권한 없음.
    데이터베이스 일반적인 유지보수 담당.
*/

--일반사용자 kh계정 생성
--username : kh
--password : kh
--default tablespace 실제 데이터가 저장될 공간 system / users

--오라클에서는 예약어가 파랑색이네요. 
--자바와는 달리 현재 커서가 가리키는 곳에 대하여 실행한다.
create user kh
identified by kh
default tablespace users;

--사용자 조회 : 실행해보면 위에서 추가한 kh계정도 보인다.
select username, account_status
from dba_users;

--상태: 실패 -테스트 실패: ORA-01045: user KH lacks CREATE SESSION privilege; logon denied
--user kh가 create이라는 권한을 가지고 있지 않다는 경고(접속 권한이 없음)

--권한 부여
--grant create session to kh; < 잘 쓰이지 않는다

--connect : create session 권한
--resource : create table 객체를 생성할 수 있는 권한 묶음.

grant connect, resource to kh;

--chun 계정
create user chun
identified by chun
default tablespace users;

--connect, resource 권한 부여
grant connect, resource to chun;

--------------------------------------------------------
-- GRANT
--------------------------------------------------------

-- qwerty 계정 생성
create user qwerty
identified by qwerty
default tablespace users;

-- create session 권한 부여
-- connect 롤을 부여
grant create session to qwerty;
grant connect to qwerty;

-- create table 권한 부여
grant create table to qwerty;

-- tablespace 공간 사용 권한 부여(alter)
alter user qwerty quota unlimited on users;

-- resource 롤부여
grant resource to qwerty;

-- Data Dictionary에서 권한/롤 조회

select *
from dba_sys_privs
where grantee in ('CONNECT', 'RESOURCE')
order by 1;

--------------------------------------------------------
-- Data Dictionary
--------------------------------------------------------
select * from dba_tables;

-- 일반사용자의 테이블 조회가능

select *
from dba_tables
where owner = 'CHUN';

-- 권한 조회

select * 
from dba_sys_privs
where grantee = 'QWERTY';

-- 롤 조회

select *
from dba_role_privs
where grantee = 'QWERTY';

-- 테이블 관련 권한 조회

select *
from dba_tab_privs
where owner = 'KH';

--------------------------------------------------------
-- VIEW
--------------------------------------------------------
-- view 권한 부여

grant create view to kh;