Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280200AbRJaNGQ>; Wed, 31 Oct 2001 08:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280199AbRJaNGH>; Wed, 31 Oct 2001 08:06:07 -0500
Received: from mail018.mail.bellsouth.net ([205.152.58.38]:31038 "EHLO
	imf18bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280193AbRJaNF5>; Wed, 31 Oct 2001 08:05:57 -0500
Message-ID: <3BDFF758.C5CC5A61@mandrakesoft.com>
Date: Wed, 31 Oct 2001 08:06:32 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: pre6 weird ps output
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alpha running 2.4.14-pre6.  The "...log" you see is where output is
redirected.  /proc/filesystems and /proc/mounts at end of output.

A devpts problem?  I usually don't enable devpts.


[jgarzik@brutus rpm]$ ps xf
  PID TTY      STAT   TIME COMMAND
16013 pts/1    S      0:00 -bash
32105 pts/1    R      0:00 ps xf
15858 pts/0    S      0:00 -bash
15889 pts/0    S      0:02 /bin/sh /usr/bin/rpm-rebuilder
30660 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00  \_
/usr/lib/rpm/rpmb 
30670 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00      \_
/bin/sh -e /tm
30671 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00          \_
/bin/sh ./
31942 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00             
\_ /bin/s
32098 pts/0    S      0:00                  \_ /bin/sh configure
--prefix=/usr
32099 pts/0    S      0:00                      \_ gcc -O -o conftest
conftest.c
32103 pts/0    S      0:00                          \_
/usr/lib/gcc-lib/alpha-ma
32104 pts/0    R      0:00                              \_ /usr/bin/ld
-m elf64a
[jgarzik@brutus rpm]$ ps xf
  PID TTY      STAT   TIME COMMAND
16013 pts/1    S      0:00 -bash
  518 pts/1    R      0:00 ps xf
15858 pts/0    S      0:00 -bash
15889 pts/0    S      0:02 /bin/sh /usr/bin/rpm-rebuilder
30660 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00  \_
/usr/lib/rpm/rpmb 
30670 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00      \_
/bin/sh -e /tm
30671 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00          \_
/bin/sh ./
31942 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00             
\_ /bin/s
  515 pts/0    S      0:00                  \_ /bin/sh configure
--prefix=/usr
  516 pts/0    S      0:00                      \_ gcc -O -c conftest.c
  517 pts/0    D      0:00                          \_
/usr/lib/gcc-lib/alpha-ma
[jgarzik@brutus rpm]$ ps xf
  PID TTY      STAT   TIME COMMAND
16013 pts/1    S      0:00 -bash
 5275 pts/1    R      0:00 ps xf
15858 pts/0    S      0:00 -bash
15889 pts/0    S      0:02 /bin/sh /usr/bin/rpm-rebuilder
30660 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00  \_
/usr/lib/rpm/rpmb 
30670 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00      \_
/bin/sh -e /tm
30671 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00          \_
/bin/sh ./
 5004 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00             
\_ make
 5201 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S  
0:00                  \_ /b
 5202 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S  
0:00                      \
 5203 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S  
0:00                       
 5272 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S  
0:00                       
 5274 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log R  
0:03                       


[jgarzik@brutus rpm]$ cat /proc/filesystems 
nodev   rootfs
nodev   bdev
nodev   proc
nodev   sockfs
nodev   tmpfs
nodev   shm
nodev   pipefs
        ext2
nodev   devfs
nodev   nfs
nodev   devpts



[jgarzik@brutus rpm]$ cat /proc/mounts 
/dev/ide/host0/bus0/target0/lun0/part2 / ext2 rw 0 0
/proc /proc proc rw 0 0
none /dev/pts devpts rw 0 0
none /dev/shm tmpfs rw 0 0
bum:/g /g nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=bum 0 0
cum:/cooker /cooker nfs
rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=cum 0 0


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

