Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276877AbRJCGZV>; Wed, 3 Oct 2001 02:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276879AbRJCGZN>; Wed, 3 Oct 2001 02:25:13 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.121.12]:1771 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S276876AbRJCGZB>; Wed, 3 Oct 2001 02:25:01 -0400
From: rwhron@earthlink.net
Date: Wed, 3 Oct 2001 02:27:15 -0400
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: linux test project results on 2.4.11-pre2 and 2.4.10-ac4
Message-ID: <20011003022715.A15944@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux Test Project suite on 2.4.11-pre2 and 2.4.10-ac4.  

vmstat output at the bottom shows free memory and 
swap after the runs complete.

Kernel versions: 	2.4.10-ac4 and 2.4.11-pre2
.config files:		identical
Filesystem:		ext2
Distro: 		Linux From Scratch 3.0
glibc:			2.2.4
LTP version:		20010925

Hardware:
Toshiba Tecra 8000 
192 megs RAM
128 megs swap
400 mhz Pentium II 

Test process:
boot kernel
login 3 console ttys
run "vmstat 8 >logfile" and tail it
run "for" loop to repeat LTP 3 times and log results
tail -f LTP results files

There were 11697 - 11705 individual tests that PASS


LTP isn't a benchmark,  but I grabbed some growfile i/o results anyway.

Linux molehill 2.4.10-ac4   501161 iterations on 20 files in 400 seconds
Linux molehill 2.4.10-ac4   506526 iterations on 20 files in 400 seconds
Linux molehill 2.4.10-ac4   507885 iterations on 20 files in 400 seconds

Linux molehill 2.4.11-pre2  499002 iterations on 30 files in 520 seconds
Linux molehill 2.4.11-pre2  482127 iterations on 20 files in 400 seconds
Linux molehill 2.4.11-pre2  488833 iterations on 20 files in 400 seconds

Some of the growfile commands errored out each time.  growfile aborts 
when it detect an error.  Above the first run on 2.4.11-pre2 
completed one growfile command the others didn't.

growfile commands that didn't complete:

growfiles -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1
output:
growfiles: 3822 growfiles.c/2085: 14470 tlibio.c/912 writev(3, iov, 1) nbyte:38796 returned=34449
growfiles: 3822 growfiles.c/1622: 14470 Hit max errors value of 1

growfiles -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
output:
growfiles: 3837 growfiles.c/2085: 7970 tlibio.c/706 write(3, buf, 5000) returned=888
growfiles: 3837 growfiles.c/1622: 7970 Hit max errors value of 1

Unique test failures

2nd 2.4.11-pre2 run
nanosleep01    1  FAIL  :  Child execution not suspended for 2 seconds
nanosleep01    1  FAIL  :  Failures reported above

3rd 2.4.11-pre2 run
recvfrom01    5  FAIL  :  invalid recv buffer ; returned -1 (expected 0), errno 14 (expected 88)

These are the test cases that failed on all runs:

execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    0  INFO  :  Test FAILED
personality01    2  FAIL  :  returned persona was not expected
personality01    3  FAIL  :  returned persona was not expected
personality01    4  FAIL  :  returned persona was not expected
personality01    5  FAIL  :  returned persona was not expected
personality01    6  FAIL  :  returned persona was not expected
personality01    7  FAIL  :  returned persona was not expected
personality01    8  FAIL  :  returned persona was not expected
personality01    9  FAIL  :  returned persona was not expected
personality01   10  FAIL  :  returned persona was not expected
personality01   11  FAIL  :  returned persona was not expected
personality01   12  FAIL  :  returned persona was not expected
personality01   13  FAIL  :  returned persona was not expected
personality02    1  FAIL  :  call failed - errno = 0 - Success
pread02     2  FAIL  :  pread() returned 0, expected -1, errno:22
recv01      3  FAIL  :  invalid recv buffer ; returned 0 (expected -1), errno 88 (expected 14)
setpgid03    2  FAIL  :  setpgid FAILED, expect EACCES got 1
shmdt02     1  FAIL  :  call succeeded unexpectedly
vhangup02    1  FAIL  :  vhangup() failed, errno:1
waitpid05    6  FAIL  :  signal error: core dump bit not set for exception number 3
waitpid05    9  FAIL  :  signal error: core dump bit not set for exception number 4
waitpid05   12  FAIL  :  signal error: core dump bit not set for exception number 5
waitpid05   15  FAIL  :  signal error: core dump bit not set for exception number 6
waitpid05   18  FAIL  :  signal error: core dump bit not set for exception number 8
waitpid05   23  FAIL  :  signal error: core dump bit not set for exception number 11

/var/log/messages suggests I'm missing something for a few tests:
modprobe: Can't locate module personality-221 (12 like this)
modprobe: Can't locate module net-pf-0


vmstat steady state after the three runs:

2.4.11-pre2
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0   5304 168132    516  14576   0   0     0     0  100     7   0   0 100


2.4.10-ac4
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0  71800 109928    396   7492   0   0     0     0  100    11   0   0 100

That is a snippet from the logfile, not the result of just "vmstat"

Here are some earlier results that were not necessarily using the same
.config file, nor as carefully controlled.  I.E. I may (or may not) have 
been using the machine during the tests.  These were all with ext3.

Linux molehill 2.4.9-ac17   398456 iterations on 30 files in 520 seconds
Linux molehill 2.4.9-ac17   477585 iterations on 41 files in 760 seconds
Linux molehill 2.4.9-ac17   466445 iterations on 41 files in 760 seconds
Linux molehill 2.4.10-ac1   500033 iterations on 41 files in 760 seconds
Linux molehill 2.4.10-ac1   478288 iterations on 41 files in 760 seconds
Linux molehill 2.4.10-ac1   451056 iterations on 30 files in 520 seconds
Linux molehill 2.4.10-ac1   470089 iterations on 30 files in 520 seconds
Linux molehill 2.4.10-ac3   357026 iterations on 20 files in 400 seconds
Linux molehill 2.4.10-ac3   438938 iterations on 20 files in 400 seconds
Linux molehill 2.4.10-ac3   440438 iterations on 20 files in 400 seconds


I'll do a summary from another machine without duplicating to much.


-- 
Randy Hron
Linux News at http://lwn.net/

