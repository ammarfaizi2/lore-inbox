Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbTLYVP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 16:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTLYVP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 16:15:59 -0500
Received: from ssmtp.aster.pl ([212.76.33.39]:31017 "EHLO mail2.astercity.net")
	by vger.kernel.org with ESMTP id S264366AbTLYVPy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 16:15:54 -0500
Date: Thu, 25 Dec 2003 22:15:56 +0100
From: =?iso-8859-2?Q?=A3ukasz?= Osipiuk <l.osipiuk@zodiac.mimuw.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Pasza <pasza@zodiac.mimuw.edu.pl>, Paulinka <ofca@astercity.net>
Subject: Strange process hangs on 2.6.0
Message-ID: <20031225211556.GA26469@lucash.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone,

I am getting strange process hangs on 2.6.0 (stable). The same problem
also occurred on many of test kernels (all that i checked out).

Problem occurs when i run text-mode emacs using a wrapper script:

runemacs.sh:
#!/bin/sh
emacs -q -nw $*

it happens only if i login to my ordinary user, then switch user to root by
calling:
# su -

and then execute ./runemacs.sh anyfile

emacs draws himself in the terminal but is not responding.
Only SIGKILL manages to terminate it.

The problem magically does not happen if:
1. i directly call emacs -q -nw anyfile (without wrapper script)
2. i precede the command line in wrapper script with exec
3. if i change the root shell from bash to zsh
4. after running emacs without wrapper script the wrapper works fine
   too (but only in the same terminal)
5. i call strace ./runemacs.sh anyfile ;)
6. probably many others

I'm not sure if it is really a bug in kernel but it did not happen
when i used 2.4 line.

I'm running PLD linux with home-compiled kernel from www.kernel.org
without any additional patches.

Here follows the info about such hung emacs from /proc:

# cat cmdline
emacs
# cat wchan
finish_stop

# cat status
Name:	emacs
State:	T (stopped)
SleepAVG:	70%
Tgid:	23542
Pid:	23542
PPid:	23541
TracerPid:	0
Uid:	0	0	0	0
Gid:	0	0	0	0
FDSize:	256
Groups:	0 1 2 3 4 6 10 
VmSize:	   11484 kB
VmLck:	       0 kB
VmRSS:	    5372 kB
VmData:	     424 kB
VmStk:	     192 kB
VmExe:	    1304 kB
VmLib:	    4092 kB
Threads:	1
SigPnd:	0000000000000000
ShdPnd:	0000000000000000
SigBlk:	0000000008000000
SigIgn:	8000000000000000
SigCgt:	0000000059816eff
CapInh:	0000000000000000
CapPrm:	00000000fffffeff
CapEff:	00000000fffffeff

# cat stat
23542 (emacs) T 23541 23542 23453 1027 23541 256 1542 0 1265 0 9 2 0 0 18 0 1 0 1591106 11759616 1343 4294967295 134512640 135846344 3221222704 3221218524 1077556839 0 134217728 0 1501654783 3222426827 0 0 17 0 0 0

# cat statm
2871 1343 2717 1069 0 1802 0

# cat maps
08048000-0818e000 r-xp 00000000 03:06 114203     /usr/bin/emacs
0818e000-08475000 rw-p 00145000 03:06 114203     /usr/bin/emacs
08475000-084d2000 rwxp 00000000 00:00 0 
40000000-40013000 r-xp 00000000 03:06 88133      /lib/ld-2.3.2.so
40013000-40014000 rw-p 00012000 03:06 88133      /lib/ld-2.3.2.so
40014000-40015000 rw-p 00000000 00:00 0 
40015000-40057000 r-xp 00000000 03:06 88533      /usr/X11R6/lib/libXaw3d.so.7.0
40057000-4005d000 rw-p 00042000 03:06 88533      /usr/X11R6/lib/libXaw3d.so.7.0
4005d000-4005f000 rw-p 00000000 00:00 0 
4005f000-40074000 r-xp 00000000 03:06 750692     /usr/X11R6/lib/libXmu.so.6.2
40074000-40075000 rw-p 00014000 03:06 750692     /usr/X11R6/lib/libXmu.so.6.2
40075000-400c1000 r-xp 00000000 03:06 750696     /usr/X11R6/lib/libXt.so.6.0
400c1000-400c4000 rw-p 0004c000 03:06 750696     /usr/X11R6/lib/libXt.so.6.0
400c4000-400c5000 rw-p 00000000 00:00 0 
400c5000-400cd000 r-xp 00000000 03:06 750686     /usr/X11R6/lib/libSM.so.6.0
400cd000-400ce000 rw-p 00007000 03:06 750686     /usr/X11R6/lib/libSM.so.6.0
400ce000-400cf000 rw-p 00000000 00:00 0 
400cf000-400e3000 r-xp 00000000 03:06 71487      /usr/X11R6/lib/libICE.so.6.3
400e3000-400e4000 rw-p 00014000 03:06 71487      /usr/X11R6/lib/libICE.so.6.3
400e4000-400e6000 rw-p 00000000 00:00 0 
400e6000-400f3000 r-xp 00000000 03:06 498959     /usr/X11R6/lib/libXext.so.6.4
400f3000-400f4000 rw-p 0000c000 03:06 498959     /usr/X11R6/lib/libXext.so.6.4
40109000-40152000 r-xp 00000000 03:06 414438     /usr/lib/libtiff.so.3.6.0
40152000-40154000 rw-p 00048000 03:06 414438     /usr/lib/libtiff.so.3.6.0
40154000-40171000 r-xp 00000000 03:06 555124     /usr/lib/libjpeg.so.62.0.0
40171000-40172000 rw-p 0001c000 03:06 555124     /usr/lib/libjpeg.so.62.0.0
40172000-401a5000 r-xp 00000000 03:06 38644      /usr/lib/libpng12.so.0.1.2.6beta2
401a5000-401a6000 rw-p 00033000 03:06 38644      /usr/lib/libpng12.so.0.1.2.6beta2
401a6000-401b5000 r-xp 00000000 03:06 72425      /lib/libz.so.1.2.1
401b5000-401b6000 rw-p 0000f000 03:06 72425      /lib/libz.so.1.2.1
401b6000-401b7000 rw-p 00000000 00:00 0 
401b7000-401d8000 r-xp 00000000 03:06 124395     /lib/libm-2.3.2.so
401d8000-401d9000 rw-p 00020000 03:06 124395     /lib/libm-2.3.2.so
401d9000-401e0000 r-xp 00000000 03:06 37627      /usr/lib/libungif.so.4.1.0
401e0000-401e1000 rw-p 00006000 03:06 37627      /usr/lib/libungif.so.4.1.0
401e1000-401ef000 r-xp 00000000 03:06 704272     /usr/X11R6/lib/libXpm.so.4.11
401ef000-401f0000 rw-p 0000d000 03:06 704272     /usr/X11R6/lib/libXpm.so.4.11
401f0000-402b4000 r-xp 00000000 03:06 750687     /usr/X11R6/lib/libX11.so.6.2
402b4000-402b8000 rw-p 000c3000 03:06 750687     /usr/X11R6/lib/libX11.so.6.2
402b8000-402d2000 r-xp 00000000 03:06 485182     /lib/libncurses.so.5.3
402d2000-402d3000 rw-p 00019000 03:06 485182     /lib/libncurses.so.5.3
402d3000-4040d000 r-xp 00000000 03:06 111554     /lib/libc-2.3.2.so
4040d000-40425000 rw-p 0013a000 03:06 111554     /lib/libc-2.3.2.so
40425000-40428000 rw-p 00000000 00:00 0 
40428000-40447000 r-xp 00000000 03:06 485356     /lib/libtinfo.so.5.3
40447000-4044f000 rw-p 0001e000 03:06 485356     /lib/libtinfo.so.5.3
4044f000-40450000 rw-p 00000000 00:00 0 
40450000-40452000 r-xp 00000000 03:06 124334     /lib/libdl-2.3.2.so
40452000-40453000 rw-p 00001000 03:06 124334     /lib/libdl-2.3.2.so
40453000-40454000 rw-p 00000000 00:00 0 
40454000-40654000 r--p 00000000 03:06 103087     /usr/lib/locale/locale-archive
40654000-40681000 r--p 0043d000 03:06 103087     /usr/lib/locale/locale-archive
40681000-40688000 r--p 00487000 03:06 103087     /usr/lib/locale/locale-archive
4069d000-406a6000 r-xp 00000000 03:06 374158     /lib/libnss_files-2.3.2.so
406a6000-406a7000 rw-p 00008000 03:06 374158     /lib/libnss_files-2.3.2.so
bffd0000-c0000000 rwxp fffd1000 00:00 0 



And here is some system info:

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2500+
stepping        : 0
cpu MHz         : 1830.418
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3620.86

# uname -a
Linux lucash 2.6.0 #8 Thu Dec 25 12:12:27 CET 2003 i686 AMD_Athlon(tm)_XP_2500+ unknown PLD Linux


-- 
Pozdrawiam Lucash
mailto: l.osipiuk@zodiac.mimuw.edu.pl
http://www.sourceforge.net/projects/subconv

 LocalWords:  everyone
