Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277714AbRJIEIS>; Tue, 9 Oct 2001 00:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277713AbRJIEIJ>; Tue, 9 Oct 2001 00:08:09 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:15248 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S277716AbRJIEIC>; Tue, 9 Oct 2001 00:08:02 -0400
From: rwhron@earthlink.net
Date: Tue, 9 Oct 2001 00:10:42 -0400
To: ltp-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: linux test project results on 2.4.11-pre6 and 2.4.10-ac10
Message-ID: <20011009001042.A7980@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Summary
-------

2.4.11-pre6 PASS on 10870 and 10874 test cases on Athlon.
2.4.10-ac10 PASS on 25174 and 25175 test cases on Athlon.

2.4.11-pre6 PASS on 11869 and 11870 test cases on Toshiba.
2.4.10-ac10 PASS on 14948 and 14949 test cases on Toshiba.

The difference in PASS cases is primarily from the fork07
test which creates processes until max-threads.  
2.4.10-ac10 has a higher max-thread value.

Tests run twice on each kernel on two machines:
Second test started immediately after the first completed.

Hardware
--------
Athlon 1333 with 512 mb RAM, reiserfs
Toshiba Tecra 8000, Pentium II with 192 mb RAM, ext2

ver_linux
---------
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11l
mount                  2.11l
modutils               2.4.10
e2fsprogs              1.25
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0


Recent PASS cases
------ ---- -----
The 4 tests below failed on 2.4.10-ac4 but now PASS on 2.4.10-ac10 
and 2.4.11-pre6.

fcntl07     3  FAIL  :  setreuid to user nobody failed, errno: 1
fcntl07     3  FAIL  :  child returned bad exit status
vhangup01   1  FAIL  :  setreuid failed
vhangup02   1  FAIL  :  vhangup() failed, errno:1

Hmm.  I didn't have a "nobody" account until recently.  That explains
at least one of those FAILs.


ftruncate03
-----------
2.4.10-ac10 uniquely gives FAIL on this test:

ftruncate03    1  FAIL  :  ftruncate() fails, File descriptor not open for writing, errno=22, expected errno:13


ioctl02 
-------
Intermitantly the test suite pauses with this test (2 ioctl02 processes).
"ps aux" shows ioctl02 processes in STAT T.

ioctl02 -D /dev/tty0

kill -9 on the parent ioctl02 allows test to continue.

I've seen this test hang before, approximately 10% of the time.
(One hang on Toshiba running 2.4.11-pre6 in this set of runs)

growfiles
---------

This indicates the Athlon completed all timed growfiles tests.

Linux rushmore 2.4.11-pre6 897121 iterations on 41 files in 760 seconds
Linux rushmore 2.4.11-pre6 895800 iterations on 41 files in 760 seconds
Linux rushmore 2.4.10-ac10 925176 iterations on 41 files in 760 seconds
Linux rushmore 2.4.10-ac10 907735 iterations on 41 files in 760 seconds


The laptop did not complete all the timed runs:

Linux molehill 2.4.11-pre6  503734 iterations on 40 files in 640 seconds
Linux molehill 2.4.11-pre6  506124 iterations on 40 files in 640 seconds
Linux molehill 2.4.10-ac10  512558 iterations on 30 files in 520 seconds
Linux molehill 2.4.10-ac10  513130 iterations on 30 files in 520 seconds


growfiles -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
growfiles: 5380 growfiles.c/2085: 9203 tlibio.c/706 write(3, buf, 5000) returned=4464
growfiles: 5380 growfiles.c/1622: 9203 Hit max errors value of 1

growfiles -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
growfiles: 5378 growfiles.c/2085: 16829 tlibio.c/706 write(3, buf, 37537) returned=37123
growfiles: 5378 growfiles.c/1622: 16829 Hit max errors value of 1

Actually, the laptop is short of disk space (331 megs free at the moment).  
These look like long hand for "out of space".  I'll do better next time.


Intermitent FAIL cases
----------------------
First run on 2.4.10-ac10 on Toshiba laptop produced:
nanosleep02    1  FAIL  :  Remaining sleep time doesn't match with the expected 4 time
nanosleep02    1  FAIL  :  child process exited abnormally

Second run on 2.4.10-ac10
recvmsg01    5  FAIL  :  invalid recv buffer ; returned -1 (expected 0), errno 14 (expected 88)

First run on 2.4.11-pre6
readlink04    1  FAIL  :  readlink() on slink_file failed, errno=2 : No such file or directory


common FAIL cases
------ ---- -----
2.4.11-pre6 and 2.4.10-ac10 produced FAIL on these tests for both computers:

execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
personality02    1  FAIL  :  call failed - errno = 0 - Success
pread02     2  FAIL  :  pread() returned 0, expected -1, errno:22
recv01      3  FAIL  :  invalid recv buffer ; returned 0 (expected -1), errno 88 (expected 14)
setpgid03    2  FAIL  :  setpgid FAILED, expect EACCES got 1
shmdt02     1  FAIL  :  call succeeded unexpectedly
waitpid05    6  FAIL  :  signal error: core dump bit not set for exception number 3
waitpid05    9  FAIL  :  signal error: core dump bit not set for exception number 4
waitpid05   12  FAIL  :  signal error: core dump bit not set for exception number 5
waitpid05   15  FAIL  :  signal error: core dump bit not set for exception number 6
waitpid05   18  FAIL  :  signal error: core dump bit not set for exception number 8
waitpid05   23  FAIL  :  signal error: core dump bit not set for exception number 11


Currently BROKen tests in my configuration
-----------------------------------------
These tests currently don't run.  If you know why, please enlighten me.

fcntl05     1  BROK  :  Unexpected signal 15 received.
fcntl05     1  BROK  :  Unexpected signal 15 received.
sched_getscheduler01    1  BROK  :  Unexpected signal 11 received.
sched_getscheduler01    2  BROK  :  Remaining cases broken
sched_getscheduler01    3  BROK  :  Remaining cases broken
sched_setscheduler02    1  BROK  :  Unexpected signal 11 received.


Unique BROK results
-------------------
First run of 2.4.10-ac10 on laptop:

shmctl01    4  BROK  :  shmctl succeeded on expected fail

First run of 2.4.11-pre6 on laptop:

readlink04    1  BROK  :  Unexpected signal 15 received.
shmctl01    4  BROK  :  shmctl succeeded on expected fail


-- 
Randy Hron

