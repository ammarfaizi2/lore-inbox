Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274951AbRJFENR>; Sat, 6 Oct 2001 00:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274965AbRJFENI>; Sat, 6 Oct 2001 00:13:08 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:35554 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S274951AbRJFEM4>; Sat, 6 Oct 2001 00:12:56 -0400
From: rwhron@earthlink.net
Date: Sat, 6 Oct 2001 00:12:22 -0400
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Linux Test Project results on 2.4.10-ac7
Message-ID: <20011006001222.A5530@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Results from one test run:

10692 test cases PASS
   12 test cases that FAIL in 2.4.10-ac4 now PASS (personality)
   24 test cases FAIL


This VFS message displayed on the console about 1 minute into the test:

2  0  2      0 476912   3744  15368   0   0   102    57  121   627   1  47  52
0  0  0      0 474128   5304  16364   0   0   197   337  146   252   1   9  90
VFS: brelse: Trying to free free buffer
VFS: brelse: Trying to free free buffer
0  0  0      0 462392  13304  19788   0   0   428  1030  178   192   2   3  95
1  0  0      0 462000  13304  20160   0   0    47    36  110    90   0   0 100

I/O
---

These tests, as usual, cause the most noticeable delays in keyboard response.  Keystrokes
are not lost, but I can type several things in vim and it takes a few seconds for them
to eventually blast on the display.  At one point I looked at "top" during one of these
pauses and saw kupdated and vim with D STAT.

growfiles -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_
growfiles -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_
growfiles -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_


This shows that all of the growfiles tests succeeded:

Linux rushmore 2.4.10-ac7 948921 iterations on 41 files in 760 seconds

Memory
------
Near the end of ltp, this test runs twice:

Filling up 80%  of ram which is 1177360793d bytes
PASS ... 1177550848 bytes allocated.
cmdline="mtest01 -p80"

Both tests succeed at memory allocation.  Interestingly, the swpd vmstat column 
stays large after the tests completes:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  2  0    120 455316  17852   9132   0   0     0  2847  642   714   0   5  95
2  0  0    120 344976  61852  10268   0   0   148  6260  335   307  18  21  61
0  1  1 415424   1740  53168   2336   8 20256    10 20277  208  5032  54  26  20
1  0  0 118984 327592  53496   5548 506 77067  1076 77076 1314 16533  19  16  65
1  0  0 118984 322068  53796  11268  16   0   746    51  167   836   5   5  90
0  0  0 118984 321508  53796  11724   0   0    52     9  109  1460   0  72  27
0  0  0 118984 321480  53796  11752   0   0     4    17  103    77   0   1  99
0  0  0 118984 321480  53796  11752   0   0     0    12  103    69   0   0 100
0  0  0 118984 320596  53796  12420  23   0   107     5  118    86   0   0 100


Log notes
---------
/var/log/messages file shows:

Oct  5 23:16:29 rushmore modprobe: modprobe: Can't locate module personality-1

Repeats 12 times for personalities 1-11 and 221
Note: 12 of 13 personality tests now PASS

Oct  5 23:16:48 rushmore modprobe: modprobe: Can't locate module net-pf-0

I thought the net-pf-0 module might be enabled by CONFIG_RTNETLINK, but
perhaps it is something else:

root@rushmore:/usr/src/linux# grep NETLINK .config
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
root@rushmore:/usr/src/linux# ls -l /dev/tap0
crw-r--r--    1 root     root      36,  16 Jul 23 03:28 /dev/tap0


Hardware:
AMD Athlon 1333
512 Mb RAM
IWill KK266 motherboard (via chipset)
1024 Mb swap

Linux rushmore 2.4.10-ac7 #1 Fri Oct 5 22:56:36 EDT 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11
util-linux             2.11k
mount                  2.11k
modutils               2.4.8
e2fsprogs              1.24a
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         ppp_deflate bsd_comp ppp_async ipt_state ipt_limit ipt_MASQUERADE iptable_nat ip_conntrack iptable_filter ip_tables

All reiserfs filesystems


Summary of FAIL tests

execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
execve06    1  FAIL  :  Execve fail, execve06, errno = 2
fcntl07     3  FAIL  :  setreuid to user nobody failed, errno: 1
fcntl07     3  FAIL  :  child returned bad exit status
personality02    1  FAIL  :  call failed - errno = 0 - Success
pread02     2  FAIL  :  pread() returned 0, expected -1, errno:22
recv01      3  FAIL  :  invalid recv buffer ; returned 0 (expected -1), errno 88 (expected 14)
setpgid03    2  FAIL  :  setpgid FAILED, expect EACCES got 1
shmdt02     1  FAIL  :  call succeeded unexpectedly
vhangup01    1  FAIL  :  setreuid failed
vhangup02    1  FAIL  :  vhangup() failed, errno:1
waitpid05    6  FAIL  :  signal error: core dump bit not set for exception number 3
waitpid05    9  FAIL  :  signal error: core dump bit not set for exception number 4
waitpid05   12  FAIL  :  signal error: core dump bit not set for exception number 5
waitpid05   15  FAIL  :  signal error: core dump bit not set for exception number 6
waitpid05   18  FAIL  :  signal error: core dump bit not set for exception number 8
waitpid05   23  FAIL  :  signal error: core dump bit not set for exception number 11

Thanks to the folks at the Linux Test Project:  http://ltp.sf.net/
Thanks to all the kernel hackers.

-- 
Randy Hron
Linux News at http://lwn.net/

