Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTKMX7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 18:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTKMX7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 18:59:37 -0500
Received: from syseng.anu.edu.au ([150.203.126.44]:10900 "EHLO
	syseng.anu.edu.au") by vger.kernel.org with ESMTP id S264459AbTKMX7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 18:59:16 -0500
Message-Id: <200311132359.KAA07694@syseng.anu.edu.au>
X-Mailer: exmh version 2.5 07/13/2001 (debian 2.5-1) with nmh-1.1-RC1
To: linux-kernel@vger.kernel.org
Subject: Uninterruptible sleep probs 2.6.0-test8
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_12922415790"
Date: Fri, 14 Nov 2003 10:59:12 +1100
From: David Austin <david@forde.anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_12922415790
Content-Type: text/plain; charset=us-ascii

Hi all,

Is anyone else having problems with processes going into 
seemingly infinite uninterruptible sleeps?

I have experienced this with plaympeg, gtv and mozilla.

I'm running on a new Dell Optiplex GX270.  This has the
Intel 82801EB AC'97 Audio Controller (rev 02).  A 
feature of these that I have noticed before is contention
for the audio device.  So, previously, under a 2.4.20 
kernel, when listening to music using alsaplayer,
plaympeg and gtv both would hang trying to get audio
access (quitting alsaplayer immediately freed things
up).  However, under the 2.6.0-test8 kernel, the
blocked processes go into uninterruptible sleeps
and never come out (even if I quit alsaplayer).
So, I've now had a gtv hanging around for more than a 
day.

Also, perhaps more alarming, I found the same problem
with mozilla this morning.  It seemed to be reproducible,
go to Slashdot, and middle-click on the article link in
the "Forbes Examines SCO Subpoenas" story. Happens
every time for me.  It's very annoying because I have
to create new profiles or reboot!

forde:~>ps axfwl > ps.log
forde:~>find /proc/13875 -ls -perm a+r -exec cat {} \; > proc.log
(attached)

Also, I did a console Ctrl+ScrollLock

Nov 14 10:50:25 forde vmunix: mozilla-bin   S C5009C48     0 13911  13875       
        13896 (NOTLB)
Nov 14 10:50:25 forde vmunix: d026be94 00200082 e9af46ec c5009c48 c5009c00 c5009
c20 d026be8c c01358e7 
Nov 14 10:50:25 forde vmunix:        080ff000 d3cb6080 0001316e d7843393 00003b8
7 c06386a0 d026a000 7fffffff 
Nov 14 10:50:25 forde vmunix:        d026bee8 d026bed0 c0125d45 eb595780 080ff00
0 c5009c20 d026bf6c c0135ce1 
Nov 14 10:50:25 forde vmunix: Call Trace:
Nov 14 10:50:25 forde vmunix:  [<c01358e7>] file_read_actor+0x0/0xfc
Nov 14 10:50:25 forde vmunix:  [<c0125d45>] schedule_timeout+0xad/0xaf
Nov 14 10:50:25 forde vmunix:  [<c0135ce1>] generic_file_read+0x90/0xa7
Nov 14 10:50:25 forde vmunix:  [<c01303ef>] futex_wait+0x178/0x1f0
Nov 14 10:50:25 forde vmunix:  [<c011a694>] default_wake_function+0x0/0x2e
Nov 14 10:50:25 forde vmunix:  [<c014e6e7>] dentry_open+0x13b/0x1fe
Nov 14 10:50:25 forde vmunix:  [<c011a694>] default_wake_function+0x0/0x2e
Nov 14 10:50:25 forde vmunix:  [<c0165124>] dput+0x24/0x21a
Nov 14 10:50:25 forde vmunix:  [<c0130776>] do_futex+0x6d/0x7d
Nov 14 10:50:25 forde vmunix:  [<c013089c>] sys_futex+0x116/0x12f
Nov 14 10:50:25 forde vmunix:  [<c014eb41>] sys_close+0x63/0x94
Nov 14 10:50:25 forde vmunix:  [<c010a22b>] syscall_call+0x7/0xb

System info follows...

Cheers,
David

forde:~>uname -a 
Linux forde 2.6.0-test8 #2 Thu Nov 13 15:48:22 EST 2003 i686 GNU/Linux
forde:~>mozilla -v
Mozilla 1.5, Copyright (c) 2003 mozilla.org, build 2003110712forde:~>ps aux
forde:~>gcc -v
Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.2/specs
Configured with: ../src/configure -v --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared --with-system-zlib --enable-nls --without-included-gettext --enable-__cxa_atexit --enable-clocale=gnu --enable-debug --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
Thread model: posix
gcc version 3.3.2 (Debian)
forde:~>ld -v
GNU ld version 2.14.90.0.7 20031029 Debian GNU/Linux



--==_Exmh_12922415790
Content-Type: text/plain ; name="ps.log"; charset=us-ascii
Content-Description: ps.log
Content-Disposition: attachment; filename="ps.log"

F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
4     0     1     0  16   0  1516  512 schedu S    ?          0:04 init [2]       
1     0     2     1  34  19     0    0 ksofti SWN  ?          0:00 [ksoftirqd/0]
1     0     3     1   5 -10     0    0 worker SW<  ?          0:00 [events/0]
1     0     4     1   5 -10     0    0 worker SW<  ?          0:00 [kblockd/0]
1     0     5     1  15   0     0    0 hub_th SW   ?          0:00 [khubd]
1     0     6     1  25   0     0    0 pdflus SW   ?          0:00 [pdflush]
1     0     7     1  15   0     0    0 pdflus SW   ?          0:00 [pdflush]
1     0     8     1  15   0     0    0 kswapd SW   ?          0:03 [kswapd0]
1     0     9     1  10 -10     0    0 worker SW<  ?          0:00 [aio/0]
1     0    10     1  15   0     0    0 serio_ SW   ?          0:00 [kseriod]
5     1   132     1  15   0  1740  600 schedu S    ?          0:00 /sbin/portmap
5     0   231     1  16   0  2292 1300 syslog S    ?          0:00 /sbin/klogd
5     0   276     1  16   0  1816  572 schedu S    ?          0:05 /usr/sbin/gpm -m /dev/input/mice -t imps2 -Rraw
5     0   284     1  16   0  2504  852 schedu S    ?          0:00 /usr/sbin/inetutils-inetd
5     0   288     1  16   0  2432  864 schedu S    ?          0:00 /usr/sbin/syslogd
0    31   324     1  16   0 15924 2132 schedu S    ?          0:00 /usr/lib/postgresql/bin/postmaster
1    31   326   324  15   0 16916 2108 schedu S    ?          0:00  \_ postgres: stats buffer process    
1    31   327   326  15   0 16060 2212 schedu S    ?          0:00      \_ postgres: stats collector process   
1 65534   337     1  18   0  2300  872 schedu S    ?          0:00 /usr/sbin/rplayd
5     0   341     1  17   0  1540  480 clock_ S    ?          0:00 /usr/sbin/smartd
5     0   374     1  15   0  3100 1460 schedu S    ?          0:00 /usr/sbin/sshd
5     0  3190   374  16   0  6740 2220 schedu S    ?          0:00  \_ sshd: nmb [priv]
5  1015  3192  3190  15   0  7236 2520 schedu S    ?          0:01      \_ sshd: nmb@pts/6
0  1015  3195  3192  16   0  2608 1412 wait4  S    pts/6      0:00          \_ -bash
0  1015  3197  3195  15   0 26340 15600 schedu S   pts/6      0:06              \_ /usr/bin/wish -f /usr/bin/exmh
0  1015  3339  3197  16   0 15516 5132 schedu S    pts/6      0:00                  \_ /usr/bin/wish -f /usr/bin/exmh-bg exmh /usr/lib/exmh /usr/bin/mh
0  1015 13464  3197  15   0  3064 1716 pipe_w S    pts/6      0:00                  \_ ispell -a -S
4   104   379     1  16   0  1512  384 schedu S    ?          0:00 /usr/bin/uml_switch -unix /var/run/uml-utilities/uml_switch.ctl
5     0   388     1  18   0  2548 1020 schedu S    ?          0:00 /usr/bin/xfstt --daemon --notcp
5     0   391     1  18   0  2340  924 schedu S    ?          0:00 /sbin/rpc.statd
5     0   397     1  16   0  2272 2264 schedu SL   ?          0:00 /usr/sbin/ntpd
5     0   402     1  16   0  2700 1012 schedu S    ?          0:00 /usr/sbin/rpc.nfsd
5     0   404     1  16   0  2700 1024 schedu S    ?          0:00 /usr/sbin/rpc.mountd
1     1   407     1  16   0  1708  628 clock_ S    ?          0:00 /usr/sbin/atd
5     0   410     1  16   0  1780  736 clock_ S    ?          0:00 /usr/sbin/cron
5     0   416     1  16   0 142172 5716 schedu S   ?          0:00 /usr/sbin/apache
5    33   456   416  16   0 142308 5852 schedu S   ?          0:00  \_ /usr/sbin/apache
5    33   457   416  16   0 142308 5852 schedu S   ?          0:00  \_ /usr/sbin/apache
5    33   458   416  16   0 142308 5852 schedu S   ?          0:00  \_ /usr/sbin/apache
5    33   459   416  16   0 142308 5852 schedu S   ?          0:00  \_ /usr/sbin/apache
5    33   460   416  16   0 142308 5848 schedu S   ?          0:00  \_ /usr/sbin/apache
5    33  3592   416  16   0 142308 5852 schedu S   ?          0:00  \_ /usr/sbin/apache
5    33 11414   416  16   0 142308 5844 schedu S   ?          0:00  \_ /usr/sbin/apache
4     0   448     1  16   0  1512  440 schedu S    tty2       0:00 /sbin/getty 38400 tty2
4     0   449     1  16   0  1512  440 schedu S    tty3       0:00 /sbin/getty 38400 tty3
4     0   450     1  16   0  1512  440 schedu S    tty4       0:00 /sbin/getty 38400 tty4
4     0   451     1  16   0  1512  440 schedu S    tty5       0:00 /sbin/getty 38400 tty5
4     0   452     1  16   0  1512  440 schedu S    tty6       0:00 /sbin/getty 38400 tty6
5     0   453     1  16   0  9068 6336 schedu S    ?          0:00 /usr/bin/perl /usr/share/webmin/miniserv.pl /etc/webmin/miniserv.conf
5     0  2798     1  16   0  3332 1092 rt_sig S    ?          0:00 /usr/bin/X11/xdm
4     0  2800  2798   5 -10 291800 25624 schedu S<L ?         3:04  \_ /usr/X11R6/bin/X -auth /var/lib/xdm/authdir/authfiles/A:0-5svizN
5     0  2801  2798  16   0  3836 2116 wait4  S    ?          0:00  \_ -:0             
4  1000  2816  2801  15   0  4836 2840 schedu S    ?          0:03      \_ /usr/bin/WindowMaker
1  1000  2841  2816  16   0  2688  876 schedu S    ?          0:00          \_ /usr/bin/ssh-agent x-session-manager
5     0  2813     1  16   0  3836 1964 schedu S    ?          0:00 xconsole -geometry 480x130-0-0 -daemon -notify -verbose -fn fixed -exitOnFail
0  1000  2850     1  15   0  3540 1884 -      R    ?          0:00 wmfire
5     0  2857     1  18   0  5212 2264 pause  S    ?          0:00 /sbin/mount.smbfs //robot/music /junk/robot -o rw noauto user credentials /home/david/.robot
1     0  2859     1  15   0     0    0 smbiod SW   ?          0:00 [smbiod]
0  1000  2863     1  15   0 131992 54680 down D    ?          1:25 /usr/lib/mozilla/mozilla-bin
0  1000  3155  2863  18   0  8156 3420 down   D    ?          0:00  \_ /usr/bin/gtv /tmp/slam_full_high.mpg
0  1000 10770  2863  16   0     0    0 exit   Z    ?          0:00  \_ [acroread] <defunct>
0  1000  3042     1  16   0     0    0 exit   Z    ?          0:00 [alsaplayer] <defunct>
0  1000  3044     1  16   0  3392 1524 schedu S    ?          0:00 xclock
4     0  3646     1  15   0  2820 1388 schedu S    tty1       0:00 -tcsh
0  1000 13184     1  16   0 110260 32264 down D    ?          0:02 /usr/lib/mozilla/mozilla-bin
0  1000 13240     1  16   0  6308 4240 schedu S    ?          0:00 /usr/lib/gconf2/gconfd-2 32
0  1000 13305     1  15   0  6540 3412 schedu S    ?          0:00 xterm -sl 5000 -sb
0  1000 13306 13305  15   0  2848 1540 -      R    pts/12     0:00  \_ -csh
0  1000 13399 13306  16   0  7864 5536 schedu S    pts/12     0:00      \_ emacs
0  1000 13489 13306  16   0 24324 13468 schedu S   pts/12     0:02      \_ /usr/bin/wish -f /usr/bin/exmh
0  1000 13626 13489  16   0 15332 5000 schedu S    pts/12     0:00      |   \_ /usr/bin/wish -f /usr/bin/exmh-bg exmh /usr/lib/exmh /usr/bin/mh
0  1000 13636 13489  17   0     0    0 exit   Z    pts/12     0:00      |   \_ [ispell] <defunct>
0  1000 13820 13306  16   0 101736 31372 down D    pts/12     0:03      \_ /usr/lib/mozilla/mozilla-bin
0  1000 13875 13306  16   0 99776 30932 down  D    pts/12     0:03      \_ /usr/lib/mozilla/mozilla-bin
0  1000 14092 13306  15   0  2308  684 -      R    pts/12     0:00      \_ ps axfwl

--==_Exmh_12922415790
Content-Type: text/plain ; name="proc.log"; charset=us-ascii
Content-Description: proc.log
Content-Disposition: attachment; filename="proc.log"

909312002    0 dr-xr-xr-x   3 david    david           0 Nov 14 10:11 /proc/13875
909312003    0 dr-xr-xr-x   3 david    david           0 Nov 14 10:52 /proc/13875/task
909312019    0 dr-xr-xr-x   3 david    david           0 Nov 14 10:52 /proc/13875/task/13875
909312025    0 dr-x------   2 david    david           0 Nov 14 10:52 /proc/13875/task/13875/fd
909344768    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/0 -> /dev/pts/12
909344769    0 l-wx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/1 -> /dev/null
909344770    0 l-wx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/2 -> /dev/null
909344771    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/3 -> socket:[32202]
909344772    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/4 -> pipe:[32204]
909344773    0 l-wx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/5 -> pipe:[32204]
909344774    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/6 -> pipe:[32205]
909344775    0 l-wx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/7 -> pipe:[32205]
909344776    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/8 -> /home/david/.mozilla/Default\ User2/otrf1b8h.slt/history.dat
909344777    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/9 -> /usr/lib/mozilla/chrome/comm.jar
909344778    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/10 -> /usr/lib/mozilla/chrome/en-US.jar
909344779    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/11 -> /usr/lib/mozilla/chrome/embed-sample.jar
909344780    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/12 -> /usr/lib/mozilla/chrome/US.jar
909344781    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/13 -> /usr/lib/mozilla/chrome/en-unix.jar
909344782    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/14 -> /usr/lib/mozilla/chrome/toolkit.jar
909344783    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/15 -> /usr/lib/mozilla/chrome/classic.jar
909344784    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/16 -> /usr/lib/mozilla/chrome/modern.jar
909344785    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/17 -> /usr/lib/mozilla/chrome/content-packs.jar
909344786    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/18 -> /usr/lib/mozilla/chrome/help.jar
909344787    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/19 -> /usr/lib/mozilla/chrome/cview.jar
909344788    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/20 -> /usr/lib/mozilla/chrome/layoutdebug.jar
909344789    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/21 -> /usr/lib/mozilla/chrome/messenger.jar
909344790    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/22 -> /usr/lib/mozilla/chrome/pipnss.jar
909344791    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/23 -> /usr/lib/mozilla/chrome/pippki.jar
909344792    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/24 -> /home/david/.mozilla/Default\ User2/otrf1b8h.slt/XUL.mfasl
909344793    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/25 -> pipe:[32208]
909344794    0 l-wx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/26 -> pipe:[32208]
909344795    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/27 -> pipe:[32209]
909344796    0 l-wx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/28 -> pipe:[32209]
909344797    0 lr-x------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/29 -> pipe:[32210]
909344798    0 l-wx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/30 -> pipe:[32210]
909344799    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/31 -> socket:[32211]
909344800    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/32 -> socket:[32213]
909344801    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/33 -> socket:[32216]
909344802    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/34 -> /home/david/.mozilla/Default\ User2/otrf1b8h.slt/Cache/_CACHE_MAP_
909344803    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/35 -> /home/david/.mozilla/Default\ User2/otrf1b8h.slt/Cache/_CACHE_001_
909344804    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/36 -> /home/david/.mozilla/Default\ User2/otrf1b8h.slt/Cache/_CACHE_002_
909344805    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/37 -> /home/david/.mozilla/Default\ User2/otrf1b8h.slt/Cache/_CACHE_003_
909344806    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/38 -> socket:[32318]
909344807    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/39 -> socket:[32335]
909344808    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/40 -> socket:[32314]
909344809    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/41 -> socket:[32315]
909344810    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/42 -> socket:[32336]
909344811    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/43 -> socket:[32339]
909344812    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/44 -> socket:[32355]
909344816    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/48 -> socket:[32350]
909344817    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/49 -> socket:[32351]
909344818    0 lrwx------   1 david    david          64 Nov 14 10:52 /proc/13875/task/13875/fd/50 -> socket:[32354]
909312026    0 -r--------   1 david    david           0 Nov 14 10:52 /proc/13875/task/13875/environ
909312027    0 -r--------   1 david    david           0 Nov 14 10:52 /proc/13875/task/13875/auxv
909312020    0 -r--r--r--   1 david    david           0 Nov 14 10:52 /proc/13875/task/13875/status
Name:	mozilla-bin
State:	D (disk sleep)
SleepAVG:	101%
Tgid:	13875
Pid:	13875
PPid:	13306
TracerPid:	0
Uid:	1000	1000	1000	1000
Gid:	1000	1000	1000	1000
FDSize:	256
Groups:	1000 29 44 101 
VmSize:	   99776 kB
VmLck:	       0 kB
VmRSS:	   30932 kB
VmData:	   69860 kB
VmStk:	      64 kB
VmExe:	     220 kB
VmLib:	   26316 kB
Threads:	5
SigPnd:	0000000000000000
ShdPnd:	0000000000000000
SigBlk:	0000000000000000
SigIgn:	8000000000001000
SigCgt:	000000008000442f
CapInh:	0000000000000000
CapPrm:	0000000000000000
CapEff:	0000000000000000
909312028    0 -r--r--r--   1 david    david           0 Nov 14 10:52 /proc/13875/task/13875/cmdline
/usr/lib/mozilla/mozilla-binlibpthread-0.60.so
400f1000-400f3000 rw-p 00000000 00:00 0 
400f3000-400f5000 r-xp 00000000 03:01 1226983    /lib/tls/libdl-2.3.2.so
400f5000-400f6000 rw-p 00001000 03:01 1226983    /lib/tls/libdl-2.3.2.so
400f6000-4033d000 r-xp 00000000 03:01 2109592    /usr/lib/libgtk-x11-2.0.so.0.200.4
4033d000-40345000 rw-p 00246000 03:01 2109592    /usr/lib/libgtk-x11-2.0.so.0.200.4
40345000-40349000 rw-p 00000000 00:00 0 
40349000-403b1000 r-xp 00000000 03:01 2109591    /usr/lib/libgdk-x11-2.0.so.0.200.4
403b1000-403b6000 rw-p 00068000 03:01 2109591    /usr/lib/libgdk-x11-2.0.so.0.200.4
403b6000-403ce000 r-xp 00000000 03:01 2109561    /usr/lib/libatk-1.0.so.0.400.1
403ce000-403d0000 rw-p 00017000 03:01 2109561    /usr/lib/libatk-1.0.so.0.400.1
403d0000-403e2000 r-xp 00000000 03:01 2109589    /usr/lib/libgdk_pixbuf-2.0.so.0.200.4
403e2000-403e3000 rw-p 00011000 03:01 2109589    /usr/lib/libgdk_pixbuf-2.0.so.0.200.4
403e3000-40403000 r-xp 00000000 03:01 2109582    /usr/lib/libpangoxft-1.0.so.0.200.5
40403000-40404000 rw-p 0001f000 03:01 2109582    /usr/lib/libpangoxft-1.0.so.0.200.5
40404000-40410000 r-xp 00000000 03:01 2109581    /usr/lib/libpangox-1.0.so.0.200.5
40410000-40411000 rw-p 0000b000 03:01 2109581    /usr/lib/libpangox-1.0.so.0.200.5
40411000-40438000 r-xp 00000000 03:01 2109579    /usr/lib/libpango-1.0.so.0.200.5
40438000-40444000 rw-p 00026000 03:01 2109579    /usr/lib/libpango-1.0.so.0.200.5
40444000-40445000 rw-p 00000000 00:00 0 
40445000-40473000 r-xp 00000000 03:01 2111101    /usr/lib/libgobject-2.0.so.0.200.3
40473000-40475000 rw-p 0002d000 03:01 2111101    /usr/lib/libgobject-2.0.so.0.200.3
40475000-40478000 r-xp 00000000 03:01 2111102    /usr/lib/libgmodule-2.0.so.0.200.3
40478000-40479000 rw-p 00002000 03:01 2111102    /usr/lib/libgmodule-2.0.so.0.200.3
40479000-404dc000 r-xp 00000000 03:01 2111100    /usr/lib/libglib-2.0.so.0.200.3
404dc000-404dd000 rw-p 00063000 03:01 2111100    /usr/lib/libglib-2.0.so.0.200.3
404dd000-404ff000 r-xp 00000000 03:01 1226984    /lib/tls/libm-2.3.2.so
404ff000-40500000 rw-p 00022000 03:01 1226984    /lib/tls/libm-2.3.2.so
40500000-4059d000 r-xp 00000000 03:01 2109608    /usr/lib/libstdc++.so.5.0.5
4059d000-405b2000 rw-p 0009d000 03:01 2109608    /usr/lib/libstdc++.so.5.0.5
405b2000-405b7000 rw-p 00000000 00:00 0 
405b7000-406e5000 r-xp 00000000 03:01 1226981    /lib/tls/libc-2.3.2.so
406e5000-406ee000 rw-p 0012d000 03:01 1226981    /lib/tls/libc-2.3.2.so
406ee000-406f1000 rw-p 00000000 00:00 0 
406f1000-406f8000 r-xp 00000000 03:01 1226402    /lib/libgcc_s.so.1
406f8000-406f9000 rw-p 00007000 03:01 1226402    /lib/libgcc_s.so.1
406f9000-407bd000 r-xp 00000000 03:01 1325344    /usr/X11R6/lib/libX11.so.6.2
407bd000-407c0000 rw-p 000c4000 03:01 1325344    /usr/X11R6/lib/libX11.so.6.2
407c0000-407c7000 r-xp 00000000 03:01 1325348    /usr/X11R6/lib/libXi.so.6.0
407c7000-407c8000 rw-p 00006000 03:01 1325348    /usr/X11R6/lib/libXi.so.6.0
407c8000-407d5000 r-xp 00000000 03:01 1325346    /usr/X11R6/lib/libXext.so.6.4
407d5000-407d6000 rw-p 0000c000 03:01 1325346    /usr/X11R6/lib/libXext.so.6.4
407d6000-407e7000 r-xp 00000000 03:01 2109467    /usr/lib/libXft.so.2.1.1
407e7000-407e8000 rw-p 00010000 03:01 2109467    /usr/lib/libXft.so.2.1.1
407e8000-407e9000 rw-p 00000000 00:00 0 
407e9000-407f0000 r-xp 00000000 03:01 2109463    /usr/lib/libXrender.so.1.2.2
407f0000-407f1000 rw-p 00006000 03:01 2109463    /usr/lib/libXrender.so.1.2.2
407f1000-40814000 r-xp 00000000 03:01 2109460    /usr/lib/libfontconfig.so.1.0.4
40814000-40817000 rw-p 00023000 03:01 2109460    /usr/lib/libfontconfig.so.1.0.4
40817000-40818000 rw-p 00000000 00:00 0 
40818000-4087b000 r-xp 00000000 03:01 2109465    /usr/lib/libfreetype.so.6.3.4
4087b000-40882000 rw-p 00063000 03:01 2109465    /usr/lib/libfreetype.so.6.3.4
40882000-4088f000 r-xp 00000000 03:01 2109515    /usr/lib/libz.so.1.1.4
4088f000-40891000 rw-p 0000c000 03:01 2109515    /usr/lib/libz.so.1.1.4
40891000-408ab000 r-xp 00000000 03:01 2110278    /usr/lib/libexpat.so.1.0.0
408ab000-408ae000 rw-p 0001a000 03:01 2110278    /usr/lib/libexpat.so.1.0.0
408ae000-408b0000 rw-p 00000000 00:00 0 
408c0000-408c7000 r-xp 00000000 03:01 1226987    /lib/tls/libnss_compat-2.3.2.so
408c7000-408c8000 rw-p 00006000 03:01 1226987    /lib/tls/libnss_compat-2.3.2.so
408c8000-408da000 r-xp 00000000 03:01 1226986    /lib/tls/libnsl-2.3.2.so
408da000-408db000 rw-p 00011000 03:01 1226986    /lib/tls/libnsl-2.3.2.so
408db000-408dd000 rw-p 00000000 00:00 0 
408dd000-408e6000 r-xp 00000000 03:01 1226991    /lib/tls/libnss_nis-2.3.2.so
408e6000-408e7000 rw-p 00008000 03:01 1226991    /lib/tls/libnss_nis-2.3.2.so
408e7000-408f0000 r-xp 00000000 03:01 1226989    /lib/tls/libnss_files-2.3.2.so
408f0000-408f1000 rw-p 00008000 03:01 1226989    /lib/tls/libnss_files-2.3.2.so
408f1000-409d4000 r-xp 00000000 03:01 4382405    /usr/lib/mozilla/libxpcom.so
409d4000-409dc000 rw-p 000e2000 03:01 4382405    /usr/lib/mozilla/libxpcom.so
409dc000-40a09000 r-xp 00000000 03:01 2388290    /usr/lib/mozilla/components/libembedcomponents.so
40a09000-40a0b000 rw-p 0002d000 03:01 2388290    /usr/lib/mozilla/components/libembedcomponents.so
40a0b000-40a31000 r-xp 00000000 03:01 2110626    /usr/lib/libgkgfx.so
40a31000-40a33000 rw-p 00025000 03:01 2110626    /usr/lib/libgkgfx.so
40a33000-40a45000 r-xp 00000000 03:01 2388361    /usr/lib/mozilla/components/libtypeaheadfind.so
40a45000-40a46000 rw-p 00011000 03:01 2388361    /usr/lib/mozilla/components/libtypeaheadfind.so
40a46000-40a5b000 r-xp 00000000 03:01 2387880    /usr/lib/mozilla/components/libpref.so
40a5b000-40a5d000 rw-p 00014000 03:01 2387880    /usr/lib/mozilla/components/libpref.so
40a5d000-40aa2000 r-xp 00000000 03:01 2387531    /usr/lib/mozilla/components/libxpconnect.so
40aa2000-40aa6000 rw-p 00045000 03:01 2387531    /usr/lib/mozilla/components/libxpconnect.so
40aa6000-40b67000 r-xp 00000000 03:01 2387874    /usr/lib/mozilla/components/libnecko.so
40b67000-40b6e000 rw-p 000c0000 03:01 2387874    /usr/lib/mozilla/components/libnecko.so
40b6e000-41060000 r-xp 00000000 03:01 2388269    /usr/lib/mozilla/components/libgklayout.so
41060000-410a5000 rw-p 004f2000 03:01 2388269    /usr/lib/mozilla/components/libgklayout.so
410a5000-410ab000 rw-p 00000000 00:00 0 
410ab000-410bf000 r-xp 00000000 03:01 2110931    /usr/lib/libmoz_art_lgpl.so
410bf000-410c0000 rw-p 00013000 03:01 2110931    /usr/lib/libmoz_art_lgpl.so
410c0000-410da000 r-xp 00000000 03:01 2387882    /usr/lib/mozilla/components/libcaps.so
410da000-410dc000 rw-p 00019000 03:01 2387882    /usr/lib/mozilla/components/libcaps.so
410dc000-41117000 r-xp 00000000 03:01 2387541    /usr/lib/mozilla/components/libi18n.so
41117000-4111a000 rw-p 0003b000 03:01 2387541    /usr/lib/mozilla/components/libi18n.so
4111a000-4111b000 ---p 00000000 00:00 0 
4111b000-4191a000 rwxp 00001000 00:00 0 
4191a000-4191b000 ---p 00800000 00:00 0 
4191b000-4211a000 rwxp 00801000 00:00 0 
4211a000-42145000 r-xp 00000000 03:01 2387884    /usr/lib/mozilla/components/librdf.so
42145000-42147000 rw-p 0002b000 03:01 2387884    /usr/lib/mozilla/components/librdf.so
42147000-42175000 r-xp 00000000 03:01 2387895    /usr/lib/mozilla/components/libimglib2.so
42175000-42177000 rw-p 0002d000 03:01 2387895    /usr/lib/mozilla/components/libimglib2.so
42177000-4217f000 r-xp 00000000 03:01 2388356    /usr/lib/mozilla/components/libsystem-pref.so
4217f000-42180000 rw-p 00008000 03:01 2388356    /usr/lib/mozilla/components/libsystem-pref.so
42180000-421a2000 r-xp 00000000 03:01 2388301    /usr/lib/mozilla/components/libnsappshell.so
421a2000-421a4000 rw-p 00021000 03:01 2388301    /usr/lib/mozilla/components/libnsappshell.so
421a4000-421d8000 r-xp 00000000 03:01 2388257    /usr/lib/mozilla/components/libwidget_gtk2.so
421d8000-421dc000 rw-p 00033000 03:01 2388257    /usr/lib/mozilla/components/libwidget_gtk2.so
421dc000-421f3000 r-xp 00000000 03:01 2388276    /usr/lib/mozilla/components/libprofile.so
421f3000-421f4000 rw-p 00017000 03:01 2388276    /usr/lib/mozilla/components/libprofile.so
421f4000-42211000 r-xp 00000000 03:01 2110937    /usr/lib/libxpcom_compat.so
42211000-42212000 rw-p 0001d000 03:01 2110937    /usr/lib/libxpcom_compat.so
42212000-42218000 r-xp 00000000 03:01 2387528    /usr/lib/mozilla/components/libxpcom_compat_c.so
42218000-42219000 rw-p 00005000 03:01 2387528    /usr/lib/mozilla/components/libxpcom_compat_c.so
4221a000-4221c000 r-xp 00000000 03:01 2192505    /usr/lib/gconv/UTF-16.so
4221c000-4221d000 rw-p 00002000 03:01 2192505    /usr/lib/gconv/UTF-16.so
4221d000-42238000 r-xp 00000000 03:01 2387886    /usr/lib/mozilla/components/libchrome.so
42238000-42239000 rw-p 0001a000 03:01 2387886    /usr/lib/mozilla/components/libchrome.so
42239000-42291000 r-xp 00000000 03:01 2387888    /usr/lib/mozilla/components/libhtmlpars.so
42291000-42296000 rw-p 00058000 03:01 2387888    /usr/lib/mozilla/components/libhtmlpars.so
42296000-42358000 r-xp 00000000 03:01 2387535    /usr/lib/mozilla/components/libuconv.so
42358000-4235f000 rw-p 000c1000 03:01 2387535    /usr/lib/mozilla/components/libuconv.so
4235f000-42369000 rw-p 00000000 00:00 0 
42369000-423b4000 r-xp 00000000 03:01 2388273    /usr/lib/mozilla/components/libdocshell.so
423b4000-423b7000 rw-p 0004b000 03:01 2388273    /usr/lib/mozilla/components/libdocshell.so
423b7000-423c3000 r-xp 00000000 03:01 2387542    /usr/lib/mozilla/components/libjar50.so
423c3000-423c4000 rw-p 0000c000 03:01 2387542    /usr/lib/mozilla/components/libjar50.so
423c4000-42435000 r-xp 00000000 03:01 2387484    /usr/lib/mozilla/components/libgfx_gtk.so
42435000-4243a000 rw-p 00070000 03:01 2387484    /usr/lib/mozilla/components/libgfx_gtk.so
4243a000-42444000 rw-p 00000000 00:00 0 
42445000-4244b000 r-xp 00000000 03:01 2551191    /usr/lib/gtk-2.0/2.2.0/loaders/libpixbufloader-xpm.so
4244b000-4244d000 rw-p 00006000 03:01 2551191    /usr/lib/gtk-2.0/2.2.0/loaders/libpixbufloader-xpm.so
4244d000-4244f000 r-xp 00000000 03:01 2192455    /usr/lib/gconv/ISO8859-1.so
4244f000-42450000 rw-p 00001000 03:01 2192455    /usr/lib/gconv/ISO8859-1.so
42454000-4245b000 r-xp 00000000 03:01 1325353    /usr/X11R6/lib/libXp.so.6.2
4245b000-4245c000 rw-p 00006000 03:01 1325353    /usr/X11R6/lib/libXp.so.6.2
4245c000-424bc000 rw-s 00000000 00:06 82444299   /SYSV00000000\040(deleted)
424bc000-424e2000 r-xp 00000000 03:01 2110357    /usr/lib/libgconf-2.so.4.1.0
424e2000-424e5000 rw-p 00025000 03:01 2110357    /usr/lib/libgconf-2.so.4.1.0
424e5000-4252a000 r-xp 00000000 03:01 2109507    /usr/lib/libORBit-2.so.0.0.0
4252a000-42533000 rw-p 00045000 03:01 2109507    /usr/lib/libORBit-2.so.0.0.0
42533000-42537000 r-xp 00000000 03:01 2111103    /usr/lib/libgthread-2.0.so.0.200.3
42537000-42538000 rw-p 00003000 03:01 2111103    /usr/lib/libgthread-2.0.so.0.200.3
42548000-4254e000 r-xp 00000000 03:01 1226428    /lib/libpopt.so.0.0.0
4254e000-4254f000 rw-p 00005000 03:01 1226428    /lib/libpopt.so.0.0.0
4254f000-425a5000 r-xp 00000000 03:01 2388255    /usr/lib/mozilla/components/libjsdom.so
425a5000-425ab000 rw-p 00056000 03:01 2388255    /usr/lib/mozilla/components/libjsdom.so
425ab000-425ac000 rw-p 00000000 00:00 0 
425ac000-425b4000 r-xp 00000000 03:01 2388312    /usr/lib/mozilla/components/libpipboot.so
425b4000-425b5000 rw-p 00007000 03:01 2388312    /usr/lib/mozilla/components/libpipboot.so
425b5000-425ce000 r-xp 00000000 03:01 2387545    /usr/lib/mozilla/components/liboji.so
425ce000-425d0000 rw-p 00018000 03:01 2387545    /usr/lib/mozilla/components/liboji.so
425d0000-425ea000 r-xp 00000000 03:01 2110928    /usr/lib/libjsj.so
425ea000-425ec000 rw-p 00019000 03:01 2110928    /usr/lib/libjsj.so
425ec000-4261d000 r-xp 00000000 03:01 2388239    /usr/lib/mozilla/components/libgkplugin.so
4261d000-4261f000 rw-p 00030000 03:01 2388239    /usr/lib/mozilla/components/libgkplugin.so
4261f000-42623000 r-xp 00000000 03:01 2110632    /usr/lib/libgtkxtbin.so
42623000-42624000 rw-p 00003000 03:01 2110632    /usr/lib/libgtkxtbin.so
42624000-42671000 r-xp 00000000 03:01 1325357    /usr/X11R6/lib/libXt.so.6.0
42671000-42674000 rw-p 0004d000 03:01 1325357    /usr/X11R6/lib/libXt.so.6.0
42674000-42675000 rw-p 00000000 00:00 0 
42685000-4268d000 r-xp 00000000 03:01 1325343    /usr/X11R6/lib/libSM.so.6.0
4268d000-4268e000 rw-p 00007000 03:01 1325343    /usr/X11R6/lib/libSM.so.6.0
4268e000-426a2000 r-xp 00000000 03:01 1325342    /usr/X11R6/lib/libICE.so.6.3
426a2000-426a3000 rw-p 00013000 03:01 1325342    /usr/X11R6/lib/libICE.so.6.3
426a3000-426a5000 rw-p 00000000 00:00 0 
426a5000-426ba000 r-xp 00000000 03:01 2388339    /usr/lib/mozilla/components/libcookie.so
426ba000-426bb000 rw-p 00015000 03:01 2388339    /usr/lib/mozilla/components/libcookie.so
426bb000-426cf000 r-xp 00000000 03:01 2388292    /usr/lib/mozilla/components/libwebbrwsr.so
426cf000-426d1000 rw-p 00013000 03:01 2388292    /usr/lib/mozilla/components/libwebbrwsr.so
426d1000-426d2000 ---p 00000000 00:00 0 
426d2000-42ed1000 rwxp 00001000 00:00 0 
42ed1000-42ed2000 ---p 00800000 00:00 0 
42ed2000-436d1000 rwxp 00801000 00:00 0 
436f4000-436f6000 r-xp 00000000 03:01 3728426    /usr/lib/pango/1.2.0/modules/pango-basic-xft.so
436f6000-436f7000 rw-p 00001000 03:01 3728426    /usr/lib/pango/1.2.0/modules/pango-basic-xft.so
436f7000-43711000 r--p 00000000 03:01 4856824    /usr/share/fonts/truetype/Andale_Mono.ttf
43733000-43793000 rw-s 00000000 00:06 82477068   /SYSV00000000\040(deleted)
43794000-43795000 ---p 00000000 00:00 0 
43795000-43f94000 rwxp 00001000 00:00 0 
43f94000-43f95000 ---p 00800000 00:00 0 
43f95000-44794000 rwxp 00801000 00:00 0 
44794000-44795000 ---p 01000000 00:00 0 
44795000-44f94000 rwxp 01001000 00:00 0 
44f94000-44fcb000 r--p 00000000 03:01 4856828    /usr/share/fonts/truetype/Arial_Bold_Italic.ttf
44fe5000-450aa000 r-xp 00000000 03:01 2388295    /usr/lib/mozilla/components/libeditor.so
450aa000-450ae000 rw-p 000c4000 03:01 2388295    /usr/lib/mozilla/components/libeditor.so
450ae000-450b3000 r-xp 00000000 03:01 2388296    /usr/lib/mozilla/components/libtxmgr.so
450b3000-450b4000 rw-p 00004000 03:01 2388296    /usr/lib/mozilla/components/libtxmgr.so
450b4000-450bc000 r-xp 00000000 03:01 2110129    /usr/lib/libesd.so.0.2.29
450bc000-450bd000 rw-p 00007000 03:01 2110129    /usr/lib/libesd.so.0.2.29
450bd000-450d8000 r-xp 00000000 03:01 2109991    /usr/lib/libaudiofile.so.0.0.2
450d8000-450db000 rw-p 0001a000 03:01 2109991    /usr/lib/libaudiofile.so.0.0.2
450db000-45175000 r-xp 00000000 03:01 2110389    /usr/lib/libasound.so.2.0.0
45175000-45179000 rw-p 0009a000 03:01 2110389    /usr/lib/libasound.so.2.0.0
45179000-4518c000 r-xp 00000000 03:01 2388278    /usr/lib/mozilla/components/libnsprefm.so
4518c000-4518d000 rw-p 00013000 03:01 2388278    /usr/lib/mozilla/components/libnsprefm.so
4518d000-45205000 r-xp 00000000 03:01 2388334    /usr/lib/mozilla/components/libappcomps.so
45205000-45209000 rw-p 00077000 03:01 2388334    /usr/lib/mozilla/components/libappcomps.so
45209000-45210000 r-xp 00000000 03:01 2388333    /usr/lib/mozilla/components/libxremoteservice.so
45210000-45211000 rw-p 00007000 03:01 2388333    /usr/lib/mozilla/components/libxremoteservice.so
45211000-45219000 r-xp 00000000 03:01 2388353    /usr/lib/mozilla/components/libp3p.so
45219000-4521a000 rw-p 00008000 03:01 2388353    /usr/lib/mozilla/components/libp3p.so
4521a000-45250000 r-xp 00000000 03:01 2388270    /usr/lib/mozilla/components/libmork.so
45250000-45253000 rw-p 00035000 03:01 2388270    /usr/lib/mozilla/components/libmork.so
45253000-45254000 rw-p 00000000 00:00 0 
45254000-45276000 r--p 00000000 03:01 4856850    /usr/share/fonts/truetype/Verdana_Bold.ttf
452a6000-452c8000 rw-p 00000000 00:00 0 
452d8000-452db000 r-xp 00000000 03:01 1226988    /lib/tls/libnss_dns-2.3.2.so
452db000-452dc000 rw-p 00002000 03:01 1226988    /lib/tls/libnss_dns-2.3.2.so
452dc000-452eb000 r-xp 00000000 03:01 1226995    /lib/tls/libresolv-2.3.2.so
452eb000-452ec000 rw-p 0000f000 03:01 1226995    /lib/tls/libresolv-2.3.2.so
452ec000-45326000 rw-p 00000000 00:00 0 
45334000-45354000 r-xp 00000000 03:01 2388342    /usr/lib/mozilla/components/libwallet.so
45354000-45356000 rw-p 0001f000 03:01 2388342    /usr/lib/mozilla/components/libwallet.so
45378000-453df000 r-xp 00000000 03:01 2387496    /usr/lib/mozilla/components/libmsgcompose.so
453df000-453e2000 rw-p 00067000 03:01 2387496    /usr/lib/mozilla/components/libmsgcompose.so
453e2000-45438000 r-xp 00000000 03:01 2110933    /usr/lib/libmsgbaseutil.so
45438000-4543b000 rw-p 00056000 03:01 2110933    /usr/lib/libmsgbaseutil.so
45478000-454bc000 r--p 00000000 03:01 4856826    /usr/share/fonts/truetype/Arial.ttf
454ef000-45512000 r--p 00000000 03:01 4856849    /usr/share/fonts/truetype/Verdana.ttf
45512000-4554a000 rw-p 00000000 00:00 0 
4554a000-45590000 r--p 00000000 03:01 4856827    /usr/share/fonts/truetype/Arial_Bold.ttf
45590000-456e7000 r-xp 00000000 03:01 458248     /usr/lib/flashplugin-nonfree/libflashplayer.so
456e7000-456f5000 rw-p 00156000 03:01 458248     /usr/lib/flashplugin-nonfree/libflashplayer.so
456f5000-457b8000 rw-p 00000000 00:00 0 
457b8000-457ee000 r-xp 00000000 03:01 2109439    /usr/lib/libstdc++-3-libc6.2-2-2.10.0.so
457ee000-457ff000 rw-p 00036000 03:01 2109439    /usr/lib/libstdc++-3-libc6.2-2-2.10.0.so
457ff000-45801000 rw-p 00000000 00:00 0 
bfff0000-c0000000 rwxp ffff1000 00:00 0 
909312021    0 -rw-------   1 david    david           0 Nov 14 10:52 /proc/13875/task/13875/mem
909312022    0 lrwxrwxrwx   1 david    david           0 Nov 14 10:52 /proc/13875/task/13875/cwd -> /home/david
909312023    0 lrwxrwxrwx   1 david    david           0 Nov 14 10:52 /proc/13875/task/13875/root -> /
909312024    0 lrwxrwxrwx   1 david    david           0 Nov 14 10:52 /proc/13875/task/13875/exe -> /usr/lib/mozilla/mozilla-bin
909312032    0 -r--r--r--   1 david    david           0 Nov 14 10:52 /proc/13875/task/13875/mounts
rootfs / rootfs rw 0 0
/dev/root / ext2 rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
//robot/music /junk/robot smbfs rw,file_mode=0744,dir_mode=0755 0 0
909312033    0 -r--r--r--   1 david    david           0 Nov 14 10:52 /proc/13875/task/13875/wchan
__down910491667    0 dr-xr-xr-x   3 david    david           0 Nov 14 10:52 /proc/13875/task/13893
910557203    0 dr-xr-xr-x   3 david    david           0 Nov 14 10:52 /proc/13875/task/13894
910688275    0 dr-xr-xr-x   3 david    david           0 Nov 14 10:52 /proc/13875/task/13896
911671315    0 dr-xr-xr-x   3 david    david           0 Nov 14 10:52 /proc/13875/task/13911
909312009    0 dr-x------   2 david    david           0 Nov 14 10:11 /proc/13875/fd
909312010    0 -r--------   1 david    david           0 Nov 14 10:52 /proc/13875/environ
909312011    0 -r--------   1 david    david           0 Nov 14 10:52 /proc/13875/auxv
909312004    0 -r--r--r--   1 david    david           0 Nov 14 10:13 /proc/13875/status
Name:	mozilla-bin
State:	D (disk sleep)
SleepAVG:	101%
Tgid:	13875
Pid:	13875
PPid:	13306
TracerPid:	0
Uid:	1000	1000	1000	1000
Gid:	1000	1000	1000	1000
FDSize:	256
Groups:	1000 29 44 101 
VmSize:	   99776 kB
VmLck:	       0 kB
VmRSS:	   30932 kB
VmData:	   69860 kB
VmStk:	      64 kB
VmExe:	     220 kB
VmLib:	   26316 kB
Threads:	5
SigPnd:	0000000000000000
ShdPnd:	0000000000000000
SigBlk:	0000000000000000
SigIgn:	8000000000001000
SigCgt:	000000008000442f
CapInh:	0000000000000000
CapPrm:	0000000000000000
CapEff:	0000000000000000
909312012    0 -r--r--r--   1 david    david           0 Nov 14 10:13 /proc/13875/cmdline
/usr/lib/mozilla/mozilla-bin932    /usr/lib/libmozjs.so
40097000-40098000 rw-p 00000000 00:00 0 
40098000-4009a000 r-xp 00000000 03:01 2110622    /usr/lib/libplds4.so
4009a000-4009b000 rw-p 00002000 03:01 2110622    /usr/lib/libplds4.so
4009b000-4009f000 r-xp 00000000 03:01 2110154    /usr/lib/libplc4.so
4009f000-400a0000 rw-p 00003000 03:01 2110154    /usr/lib/libplc4.so
400a0000-400d1000 r-xp 00000000 03:01 2109931    /usr/lib/libnspr4.so
400d1000-400d3000 rw-p 00030000 03:01 2109931    /usr/lib/libnspr4.so
400d3000-400d4000 rw-p 00000000 00:00 0 
400d4000-400d6000 r-xp 00000000 03:01 2093390    /usr/X11R6/lib/X11/locale/common/xlcDef.so.2
400d6000-400d7000 rw-p 00001000 03:01 2093390    /usr/X11R6/lib/X11/locale/common/xlcDef.so.2
400e4000-400f0000 r-xp 00000000 03:01 1226994    /lib/tls/libpthread-0.60.so
400f0000-400f1000 rw-p 0000c000 03:01 1226994    /lib/tls/libpthread-0.60.so
400f1000-400f3000 rw-p 00000000 00:00 0 
400f3000-400f5000 r-xp 00000000 03:01 1226983    /lib/tls/libdl-2.3.2.so
400f5000-400f6000 rw-p 00001000 03:01 1226983    /lib/tls/libdl-2.3.2.so
400f6000-4033d000 r-xp 00000000 03:01 2109592    /usr/lib/libgtk-x11-2.0.so.0.200.4
4033d000-40345000 rw-p 00246000 03:01 2109592    /usr/lib/libgtk-x11-2.0.so.0.200.4
40345000-40349000 rw-p 00000000 00:00 0 
40349000-403b1000 r-xp 00000000 03:01 2109591    /usr/lib/libgdk-x11-2.0.so.0.200.4
403b1000-403b6000 rw-p 00068000 03:01 2109591    /usr/lib/libgdk-x11-2.0.so.0.200.4
403b6000-403ce000 r-xp 00000000 03:01 2109561    /usr/lib/libatk-1.0.so.0.400.1
403ce000-403d0000 rw-p 00017000 03:01 2109561    /usr/lib/libatk-1.0.so.0.400.1
403d0000-403e2000 r-xp 00000000 03:01 2109589    /usr/lib/libgdk_pixbuf-2.0.so.0.200.4
403e2000-403e3000 rw-p 00011000 03:01 2109589    /usr/lib/libgdk_pixbuf-2.0.so.0.200.4
403e3000-40403000 r-xp 00000000 03:01 2109582    /usr/lib/libpangoxft-1.0.so.0.200.5
40403000-40404000 rw-p 0001f000 03:01 2109582    /usr/lib/libpangoxft-1.0.so.0.200.5
40404000-40410000 r-xp 00000000 03:01 2109581    /usr/lib/libpangox-1.0.so.0.200.5
40410000-40411000 rw-p 0000b000 03:01 2109581    /usr/lib/libpangox-1.0.so.0.200.5
40411000-40438000 r-xp 00000000 03:01 2109579    /usr/lib/libpango-1.0.so.0.200.5
40438000-40444000 rw-p 00026000 03:01 2109579    /usr/lib/libpango-1.0.so.0.200.5
40444000-40445000 rw-p 00000000 00:00 0 
40445000-40473000 r-xp 00000000 03:01 2111101    /usr/lib/libgobject-2.0.so.0.200.3
40473000-40475000 rw-p 0002d000 03:01 2111101    /usr/lib/libgobject-2.0.so.0.200.3
40475000-40478000 r-xp 00000000 03:01 2111102    /usr/lib/libgmodule-2.0.so.0.200.3
40478000-40479000 rw-p 00002000 03:01 2111102    /usr/lib/libgmodule-2.0.so.0.200.3
40479000-404dc000 r-xp 00000000 03:01 2111100    /usr/lib/libglib-2.0.so.0.200.3
404dc000-404dd000 rw-p 00063000 03:01 2111100    /usr/lib/libglib-2.0.so.0.200.3
404dd000-404ff000 r-xp 00000000 03:01 1226984    /lib/tls/libm-2.3.2.so
404ff000-40500000 rw-p 00022000 03:01 1226984    /lib/tls/libm-2.3.2.so
40500000-4059d000 r-xp 00000000 03:01 2109608    /usr/lib/libstdc++.so.5.0.5
4059d000-405b2000 rw-p 0009d000 03:01 2109608    /usr/lib/libstdc++.so.5.0.5
405b2000-405b7000 rw-p 00000000 00:00 0 
405b7000-406e5000 r-xp 00000000 03:01 1226981    /lib/tls/libc-2.3.2.so
406e5000-406ee000 rw-p 0012d000 03:01 1226981    /lib/tls/libc-2.3.2.so
406ee000-406f1000 rw-p 00000000 00:00 0 
406f1000-406f8000 r-xp 00000000 03:01 1226402    /lib/libgcc_s.so.1
406f8000-406f9000 rw-p 00007000 03:01 1226402    /lib/libgcc_s.so.1
406f9000-407bd000 r-xp 00000000 03:01 1325344    /usr/X11R6/lib/libX11.so.6.2
407bd000-407c0000 rw-p 000c4000 03:01 1325344    /usr/X11R6/lib/libX11.so.6.2
407c0000-407c7000 r-xp 00000000 03:01 1325348    /usr/X11R6/lib/libXi.so.6.0
407c7000-407c8000 rw-p 00006000 03:01 1325348    /usr/X11R6/lib/libXi.so.6.0
407c8000-407d5000 r-xp 00000000 03:01 1325346    /usr/X11R6/lib/libXext.so.6.4
407d5000-407d6000 rw-p 0000c000 03:01 1325346    /usr/X11R6/lib/libXext.so.6.4
407d6000-407e7000 r-xp 00000000 03:01 2109467    /usr/lib/libXft.so.2.1.1
407e7000-407e8000 rw-p 00010000 03:01 2109467    /usr/lib/libXft.so.2.1.1
407e8000-407e9000 rw-p 00000000 00:00 0 
407e9000-407f0000 r-xp 00000000 03:01 2109463    /usr/lib/libXrender.so.1.2.2
407f0000-407f1000 rw-p 00006000 03:01 2109463    /usr/lib/libXrender.so.1.2.2
407f1000-40814000 r-xp 00000000 03:01 2109460    /usr/lib/libfontconfig.so.1.0.4
40814000-40817000 rw-p 00023000 03:01 2109460    /usr/lib/libfontconfig.so.1.0.4
40817000-40818000 rw-p 00000000 00:00 0 
40818000-4087b000 r-xp 00000000 03:01 2109465    /usr/lib/libfreetype.so.6.3.4
4087b000-40882000 rw-p 00063000 03:01 2109465    /usr/lib/libfreetype.so.6.3.4
40882000-4088f000 r-xp 00000000 03:01 2109515    /usr/lib/libz.so.1.1.4
4088f000-40891000 rw-p 0000c000 03:01 2109515    /usr/lib/libz.so.1.1.4
40891000-408ab000 r-xp 00000000 03:01 2110278    /usr/lib/libexpat.so.1.0.0
408ab000-408ae000 rw-p 0001a000 03:01 2110278    /usr/lib/libexpat.so.1.0.0
408ae000-408b0000 rw-p 00000000 00:00 0 
408c0000-408c7000 r-xp 00000000 03:01 1226987    /lib/tls/libnss_compat-2.3.2.so
408c7000-408c8000 rw-p 00006000 03:01 1226987    /lib/tls/libnss_compat-2.3.2.so
408c8000-408da000 r-xp 00000000 03:01 1226986    /lib/tls/libnsl-2.3.2.so
408da000-408db000 rw-p 00011000 03:01 1226986    /lib/tls/libnsl-2.3.2.so
408db000-408dd000 rw-p 00000000 00:00 0 
408dd000-408e6000 r-xp 00000000 03:01 1226991    /lib/tls/libnss_nis-2.3.2.so
408e6000-408e7000 rw-p 00008000 03:01 1226991    /lib/tls/libnss_nis-2.3.2.so
408e7000-408f0000 r-xp 00000000 03:01 1226989    /lib/tls/libnss_files-2.3.2.so
408f0000-408f1000 rw-p 00008000 03:01 1226989    /lib/tls/libnss_files-2.3.2.so
408f1000-409d4000 r-xp 00000000 03:01 4382405    /usr/lib/mozilla/libxpcom.so
409d4000-409dc000 rw-p 000e2000 03:01 4382405    /usr/lib/mozilla/libxpcom.so
409dc000-40a09000 r-xp 00000000 03:01 2388290    /usr/lib/mozilla/components/libembedcomponents.so
40a09000-40a0b000 rw-p 0002d000 03:01 2388290    /usr/lib/mozilla/components/libembedcomponents.so
40a0b000-40a31000 r-xp 00000000 03:01 2110626    /usr/lib/libgkgfx.so
40a31000-40a33000 rw-p 00025000 03:01 2110626    /usr/lib/libgkgfx.so
40a33000-40a45000 r-xp 00000000 03:01 2388361    /usr/lib/mozilla/components/libtypeaheadfind.so
40a45000-40a46000 rw-p 00011000 03:01 2388361    /usr/lib/mozilla/components/libtypeaheadfind.so
40a46000-40a5b000 r-xp 00000000 03:01 2387880    /usr/lib/mozilla/components/libpref.so
40a5b000-40a5d000 rw-p 00014000 03:01 2387880    /usr/lib/mozilla/components/libpref.so
40a5d000-40aa2000 r-xp 00000000 03:01 2387531    /usr/lib/mozilla/components/libxpconnect.so
40aa2000-40aa6000 rw-p 00045000 03:01 2387531    /usr/lib/mozilla/components/libxpconnect.so
40aa6000-40b67000 r-xp 00000000 03:01 2387874    /usr/lib/mozilla/components/libnecko.so
40b67000-40b6e000 rw-p 000c0000 03:01 2387874    /usr/lib/mozilla/components/libnecko.so
40b6e000-41060000 r-xp 00000000 03:01 2388269    /usr/lib/mozilla/components/libgklayout.so
41060000-410a5000 rw-p 004f2000 03:01 2388269    /usr/lib/mozilla/components/libgklayout.so
410a5000-410ab000 rw-p 00000000 00:00 0 
410ab000-410bf000 r-xp 00000000 03:01 2110931    /usr/lib/libmoz_art_lgpl.so
410bf000-410c0000 rw-p 00013000 03:01 2110931    /usr/lib/libmoz_art_lgpl.so
410c0000-410da000 r-xp 00000000 03:01 2387882    /usr/lib/mozilla/components/libcaps.so
410da000-410dc000 rw-p 00019000 03:01 2387882    /usr/lib/mozilla/components/libcaps.so
410dc000-41117000 r-xp 00000000 03:01 2387541    /usr/lib/mozilla/components/libi18n.so
41117000-4111a000 rw-p 0003b000 03:01 2387541    /usr/lib/mozilla/components/libi18n.so
4111a000-4111b000 ---p 00000000 00:00 0 
4111b000-4191a000 rwxp 00001000 00:00 0 
4191a000-4191b000 ---p 00800000 00:00 0 
4191b000-4211a000 rwxp 00801000 00:00 0 
4211a000-42145000 r-xp 00000000 03:01 2387884    /usr/lib/mozilla/components/librdf.so
42145000-42147000 rw-p 0002b000 03:01 2387884    /usr/lib/mozilla/components/librdf.so
42147000-42175000 r-xp 00000000 03:01 2387895    /usr/lib/mozilla/components/libimglib2.so
42175000-42177000 rw-p 0002d000 03:01 2387895    /usr/lib/mozilla/components/libimglib2.so
42177000-4217f000 r-xp 00000000 03:01 2388356    /usr/lib/mozilla/components/libsystem-pref.so
4217f000-42180000 rw-p 00008000 03:01 2388356    /usr/lib/mozilla/components/libsystem-pref.so
42180000-421a2000 r-xp 00000000 03:01 2388301    /usr/lib/mozilla/components/libnsappshell.so
421a2000-421a4000 rw-p 00021000 03:01 2388301    /usr/lib/mozilla/components/libnsappshell.so
421a4000-421d8000 r-xp 00000000 03:01 2388257    /usr/lib/mozilla/components/libwidget_gtk2.so
421d8000-421dc000 rw-p 00033000 03:01 2388257    /usr/lib/mozilla/components/libwidget_gtk2.so
421dc000-421f3000 r-xp 00000000 03:01 2388276    /usr/lib/mozilla/components/libprofile.so
421f3000-421f4000 rw-p 00017000 03:01 2388276    /usr/lib/mozilla/components/libprofile.so
421f4000-42211000 r-xp 00000000 03:01 2110937    /usr/lib/libxpcom_compat.so
42211000-42212000 rw-p 0001d000 03:01 2110937    /usr/lib/libxpcom_compat.so
42212000-42218000 r-xp 00000000 03:01 2387528    /usr/lib/mozilla/components/libxpcom_compat_c.so
42218000-42219000 rw-p 00005000 03:01 2387528    /usr/lib/mozilla/components/libxpcom_compat_c.so
4221a000-4221c000 r-xp 00000000 03:01 2192505    /usr/lib/gconv/UTF-16.so
4221c000-4221d000 rw-p 00002000 03:01 2192505    /usr/lib/gconv/UTF-16.so
4221d000-42238000 r-xp 00000000 03:01 2387886    /usr/lib/mozilla/components/libchrome.so
42238000-42239000 rw-p 0001a000 03:01 2387886    /usr/lib/mozilla/components/libchrome.so
42239000-42291000 r-xp 00000000 03:01 2387888    /usr/lib/mozilla/components/libhtmlpars.so
42291000-42296000 rw-p 00058000 03:01 2387888    /usr/lib/mozilla/components/libhtmlpars.so
42296000-42358000 r-xp 00000000 03:01 2387535    /usr/lib/mozilla/components/libuconv.so
42358000-4235f000 rw-p 000c1000 03:01 2387535    /usr/lib/mozilla/components/libuconv.so
4235f000-42369000 rw-p 00000000 00:00 0 
42369000-423b4000 r-xp 00000000 03:01 2388273    /usr/lib/mozilla/components/libdocshell.so
423b4000-423b7000 rw-p 0004b000 03:01 2388273    /usr/lib/mozilla/components/libdocshell.so
423b7000-423c3000 r-xp 00000000 03:01 2387542    /usr/lib/mozilla/components/libjar50.so
423c3000-423c4000 rw-p 0000c000 03:01 2387542    /usr/lib/mozilla/components/libjar50.so
423c4000-42435000 r-xp 00000000 03:01 2387484    /usr/lib/mozilla/components/libgfx_gtk.so
42435000-4243a000 rw-p 00070000 03:01 2387484    /usr/lib/mozilla/components/libgfx_gtk.so
4243a000-42444000 rw-p 00000000 00:00 0 
42445000-4244b000 r-xp 00000000 03:01 2551191    /usr/lib/gtk-2.0/2.2.0/loaders/libpixbufloader-xpm.so
4244b000-4244d000 rw-p 00006000 03:01 2551191    /usr/lib/gtk-2.0/2.2.0/loaders/libpixbufloader-xpm.so
4244d000-4244f000 r-xp 00000000 03:01 2192455    /usr/lib/gconv/ISO8859-1.so
4244f000-42450000 rw-p 00001000 03:01 2192455    /usr/lib/gconv/ISO8859-1.so
42454000-4245b000 r-xp 00000000 03:01 1325353    /usr/X11R6/lib/libXp.so.6.2
4245b000-4245c000 rw-p 00006000 03:01 1325353    /usr/X11R6/lib/libXp.so.6.2
4245c000-424bc000 rw-s 00000000 00:06 82444299   /SYSV00000000\040(deleted)
424bc000-424e2000 r-xp 00000000 03:01 2110357    /usr/lib/libgconf-2.so.4.1.0
424e2000-424e5000 rw-p 00025000 03:01 2110357    /usr/lib/libgconf-2.so.4.1.0
424e5000-4252a000 r-xp 00000000 03:01 2109507    /usr/lib/libORBit-2.so.0.0.0
4252a000-42533000 rw-p 00045000 03:01 2109507    /usr/lib/libORBit-2.so.0.0.0
42533000-42537000 r-xp 00000000 03:01 2111103    /usr/lib/libgthread-2.0.so.0.200.3
42537000-42538000 rw-p 00003000 03:01 2111103    /usr/lib/libgthread-2.0.so.0.200.3
42548000-4254e000 r-xp 00000000 03:01 1226428    /lib/libpopt.so.0.0.0
4254e000-4254f000 rw-p 00005000 03:01 1226428    /lib/libpopt.so.0.0.0
4254f000-425a5000 r-xp 00000000 03:01 2388255    /usr/lib/mozilla/components/libjsdom.so
425a5000-425ab000 rw-p 00056000 03:01 2388255    /usr/lib/mozilla/components/libjsdom.so
425ab000-425ac000 rw-p 00000000 00:00 0 
425ac000-425b4000 r-xp 00000000 03:01 2388312    /usr/lib/mozilla/components/libpipboot.so
425b4000-425b5000 rw-p 00007000 03:01 2388312    /usr/lib/mozilla/components/libpipboot.so
425b5000-425ce000 r-xp 00000000 03:01 2387545    /usr/lib/mozilla/components/liboji.so
425ce000-425d0000 rw-p 00018000 03:01 2387545    /usr/lib/mozilla/components/liboji.so
425d0000-425ea000 r-xp 00000000 03:01 2110928    /usr/lib/libjsj.so
425ea000-425ec000 rw-p 00019000 03:01 2110928    /usr/lib/libjsj.so
425ec000-4261d000 r-xp 00000000 03:01 2388239    /usr/lib/mozilla/components/libgkplugin.so
4261d000-4261f000 rw-p 00030000 03:01 2388239    /usr/lib/mozilla/components/libgkplugin.so
4261f000-42623000 r-xp 00000000 03:01 2110632    /usr/lib/libgtkxtbin.so
42623000-42624000 rw-p 00003000 03:01 2110632    /usr/lib/libgtkxtbin.so
42624000-42671000 r-xp 00000000 03:01 1325357    /usr/X11R6/lib/libXt.so.6.0
42671000-42674000 rw-p 0004d000 03:01 1325357    /usr/X11R6/lib/libXt.so.6.0
42674000-42675000 rw-p 00000000 00:00 0 
42685000-4268d000 r-xp 00000000 03:01 1325343    /usr/X11R6/lib/libSM.so.6.0
4268d000-4268e000 rw-p 00007000 03:01 1325343    /usr/X11R6/lib/libSM.so.6.0
4268e000-426a2000 r-xp 00000000 03:01 1325342    /usr/X11R6/lib/libICE.so.6.3
426a2000-426a3000 rw-p 00013000 03:01 1325342    /usr/X11R6/lib/libICE.so.6.3
426a3000-426a5000 rw-p 00000000 00:00 0 
426a5000-426ba000 r-xp 00000000 03:01 2388339    /usr/lib/mozilla/components/libcookie.so
426ba000-426bb000 rw-p 00015000 03:01 2388339    /usr/lib/mozilla/components/libcookie.so
426bb000-426cf000 r-xp 00000000 03:01 2388292    /usr/lib/mozilla/components/libwebbrwsr.so
426cf000-426d1000 rw-p 00013000 03:01 2388292    /usr/lib/mozilla/components/libwebbrwsr.so
426d1000-426d2000 ---p 00000000 00:00 0 
426d2000-42ed1000 rwxp 00001000 00:00 0 
42ed1000-42ed2000 ---p 00800000 00:00 0 
42ed2000-436d1000 rwxp 00801000 00:00 0 
436f4000-436f6000 r-xp 00000000 03:01 3728426    /usr/lib/pango/1.2.0/modules/pango-basic-xft.so
436f6000-436f7000 rw-p 00001000 03:01 3728426    /usr/lib/pango/1.2.0/modules/pango-basic-xft.so
436f7000-43711000 r--p 00000000 03:01 4856824    /usr/share/fonts/truetype/Andale_Mono.ttf
43733000-43793000 rw-s 00000000 00:06 82477068   /SYSV00000000\040(deleted)
43794000-43795000 ---p 00000000 00:00 0 
43795000-43f94000 rwxp 00001000 00:00 0 
43f94000-43f95000 ---p 00800000 00:00 0 
43f95000-44794000 rwxp 00801000 00:00 0 
44794000-44795000 ---p 01000000 00:00 0 
44795000-44f94000 rwxp 01001000 00:00 0 
44f94000-44fcb000 r--p 00000000 03:01 4856828    /usr/share/fonts/truetype/Arial_Bold_Italic.ttf
44fe5000-450aa000 r-xp 00000000 03:01 2388295    /usr/lib/mozilla/components/libeditor.so
450aa000-450ae000 rw-p 000c4000 03:01 2388295    /usr/lib/mozilla/components/libeditor.so
450ae000-450b3000 r-xp 00000000 03:01 2388296    /usr/lib/mozilla/components/libtxmgr.so
450b3000-450b4000 rw-p 00004000 03:01 2388296    /usr/lib/mozilla/components/libtxmgr.so
450b4000-450bc000 r-xp 00000000 03:01 2110129    /usr/lib/libesd.so.0.2.29
450bc000-450bd000 rw-p 00007000 03:01 2110129    /usr/lib/libesd.so.0.2.29
450bd000-450d8000 r-xp 00000000 03:01 2109991    /usr/lib/libaudiofile.so.0.0.2
450d8000-450db000 rw-p 0001a000 03:01 2109991    /usr/lib/libaudiofile.so.0.0.2
450db000-45175000 r-xp 00000000 03:01 2110389    /usr/lib/libasound.so.2.0.0
45175000-45179000 rw-p 0009a000 03:01 2110389    /usr/lib/libasound.so.2.0.0
45179000-4518c000 r-xp 00000000 03:01 2388278    /usr/lib/mozilla/components/libnsprefm.so
4518c000-4518d000 rw-p 00013000 03:01 2388278    /usr/lib/mozilla/components/libnsprefm.so
4518d000-45205000 r-xp 00000000 03:01 2388334    /usr/lib/mozilla/components/libappcomps.so
45205000-45209000 rw-p 00077000 03:01 2388334    /usr/lib/mozilla/components/libappcomps.so
45209000-45210000 r-xp 00000000 03:01 2388333    /usr/lib/mozilla/components/libxremoteservice.so
45210000-45211000 rw-p 00007000 03:01 2388333    /usr/lib/mozilla/components/libxremoteservice.so
45211000-45219000 r-xp 00000000 03:01 2388353    /usr/lib/mozilla/components/libp3p.so
45219000-4521a000 rw-p 00008000 03:01 2388353    /usr/lib/mozilla/components/libp3p.so
4521a000-45250000 r-xp 00000000 03:01 2388270    /usr/lib/mozilla/components/libmork.so
45250000-45253000 rw-p 00035000 03:01 2388270    /usr/lib/mozilla/components/libmork.so
45253000-45254000 rw-p 00000000 00:00 0 
45254000-45276000 r--p 00000000 03:01 4856850    /usr/share/fonts/truetype/Verdana_Bold.ttf
452a6000-452c8000 rw-p 00000000 00:00 0 
452d8000-452db000 r-xp 00000000 03:01 1226988    /lib/tls/libnss_dns-2.3.2.so
452db000-452dc000 rw-p 00002000 03:01 1226988    /lib/tls/libnss_dns-2.3.2.so
452dc000-452eb000 r-xp 00000000 03:01 1226995    /lib/tls/libresolv-2.3.2.so
452eb000-452ec000 rw-p 0000f000 03:01 1226995    /lib/tls/libresolv-2.3.2.so
452ec000-45326000 rw-p 00000000 00:00 0 
45334000-45354000 r-xp 00000000 03:01 2388342    /usr/lib/mozilla/components/libwallet.so
45354000-45356000 rw-p 0001f000 03:01 2388342    /usr/lib/mozilla/components/libwallet.so
45378000-453df000 r-xp 00000000 03:01 2387496    /usr/lib/mozilla/components/libmsgcompose.so
453df000-453e2000 rw-p 00067000 03:01 2387496    /usr/lib/mozilla/components/libmsgcompose.so
453e2000-45438000 r-xp 00000000 03:01 2110933    /usr/lib/libmsgbaseutil.so
45438000-4543b000 rw-p 00056000 03:01 2110933    /usr/lib/libmsgbaseutil.so
45478000-454bc000 r--p 00000000 03:01 4856826    /usr/share/fonts/truetype/Arial.ttf
454ef000-45512000 r--p 00000000 03:01 4856849    /usr/share/fonts/truetype/Verdana.ttf
45512000-4554a000 rw-p 00000000 00:00 0 
4554a000-45590000 r--p 00000000 03:01 4856827    /usr/share/fonts/truetype/Arial_Bold.ttf
45590000-456e7000 r-xp 00000000 03:01 458248     /usr/lib/flashplugin-nonfree/libflashplayer.so
456e7000-456f5000 rw-p 00156000 03:01 458248     /usr/lib/flashplugin-nonfree/libflashplayer.so
456f5000-457b8000 rw-p 00000000 00:00 0 
457b8000-457ee000 r-xp 00000000 03:01 2109439    /usr/lib/libstdc++-3-libc6.2-2-2.10.0.so
457ee000-457ff000 rw-p 00036000 03:01 2109439    /usr/lib/libstdc++-3-libc6.2-2-2.10.0.so
457ff000-45801000 rw-p 00000000 00:00 0 
bfff0000-c0000000 rwxp ffff1000 00:00 0 
909312005    0 -rw-------   1 david    david           0 Nov 14 10:52 /proc/13875/mem
909312006    0 lrwxrwxrwx   1 david    david           0 Nov 14 10:11 /proc/13875/cwd -> /home/david
909312007    0 lrwxrwxrwx   1 david    david           0 Nov 14 10:11 /proc/13875/root -> /
909312008    0 lrwxrwxrwx   1 david    david           0 Nov 14 10:11 /proc/13875/exe -> /usr/lib/mozilla/mozilla-bin
909312016    0 -r--r--r--   1 david    david           0 Nov 14 10:52 /proc/13875/mounts
rootfs / rootfs rw 0 0
/dev/root / ext2 rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
//robot/music /junk/robot smbfs rw,file_mode=0744,dir_mode=0755 0 0
909312017    0 -r--r--r--   1 david    david           0 Nov 14 10:44 /proc/13875/wchan
__down

--==_Exmh_12922415790
Content-Type: text/plain; charset=us-ascii

David Austin

---
d.austin@computer.org

Robotic Systems Laboratory,                          Hiroshima '45  
Department of Systems Engineering,                   Chernobyl '86
RSISE, Australian National University                  Windows '95


--==_Exmh_12922415790--


