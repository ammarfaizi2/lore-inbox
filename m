Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261641AbTCZLkz>; Wed, 26 Mar 2003 06:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbTCZLkz>; Wed, 26 Mar 2003 06:40:55 -0500
Received: from paja.kn.vutbr.cz ([147.229.191.135]:64268 "EHLO
	paja.kn.vutbr.cz") by vger.kernel.org with ESMTP id <S261641AbTCZLkv>;
	Wed, 26 Mar 2003 06:40:51 -0500
Message-ID: <3E81945C.4010102@kn.vutbr.cz>
Date: Wed, 26 Mar 2003 12:51:56 +0100
From: Michal Schmidt <schmidt@kn.vutbr.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: cs, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reproducible terrible interactivity since 2.5.64bk2
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC me your answers, thank you)

I'm seeing serious interactivity problems in 2.5.65, 2.5.66, 2.5.65-mm4 
and 2.5.64-bk2.
I couldn't reproduce it on 2.5.64, 2.5.64-bk1.

I noticed that when I was archiving a directory with some CD ISO images 
with tar & bzip2. After a while (~5 minutes) many programs took a long 
time to respond, XMMS paused for several seconds, starting simple 
programs (mc, ps, ls) took sometimes even 40s. Disk is idle most of the 
time.

To reproduce I wrote a simple script:

#!/bin/sh
cat cedo.iso | bzip2 > /tmp/cedo.iso.bz2 &
for i in `seq 1 20`; do
   sleep 30
   date
   ps x
   date
   echo -----
done


... where cedo.iso is a 700MB CD ISO image.
When run on 2.5.64-bk2 (and no X running) I've got this output:


Wed Mar 26 10:47:50 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     R      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     R      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:00 cat cedo.iso
   716 tty2     R      0:33 bzip2
   720 tty2     R      0:00 ps x
Wed Mar 26 10:47:50 CET 2003
-----
Wed Mar 26 10:48:22 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:00 cat cedo.iso
   716 tty2     R      1:05 bzip2
   724 tty2     R      0:00 ps x
Wed Mar 26 10:48:23 CET 2003
-----
Wed Mar 26 10:48:55 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:00 cat cedo.iso
   716 tty2     R      1:38 bzip2
   728 tty2     R      0:00 ps x
Wed Mar 26 10:48:55 CET 2003
-----
Wed Mar 26 10:49:28 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     R      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:00 cat cedo.iso
   716 tty2     R      2:10 bzip2
   732 tty2     R      0:00 ps x
Wed Mar 26 10:49:28 CET 2003
-----
Wed Mar 26 10:50:01 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:00 cat cedo.iso
   716 tty2     R      2:42 bzip2
   736 tty2     R      0:00 ps x
Wed Mar 26 10:50:01 CET 2003
-----
Wed Mar 26 10:50:34 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:00 cat cedo.iso
   716 tty2     R      3:15 bzip2
   740 tty2     R      0:00 ps x
Wed Mar 26 10:50:34 CET 2003
-----
Wed Mar 26 10:51:06 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     R      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:00 cat cedo.iso
   716 tty2     R      3:47 bzip2
   744 tty2     R      0:00 ps x
Wed Mar 26 10:51:06 CET 2003
-----
Wed Mar 26 10:51:39 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:00 cat cedo.iso
   716 tty2     R      4:19 bzip2
   748 tty2     R      0:00 ps x
Wed Mar 26 10:51:39 CET 2003
-----
Wed Mar 26 10:52:12 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:01 cat cedo.iso
   716 tty2     R      4:52 bzip2
   752 tty2     R      0:00 ps x
Wed Mar 26 10:52:12 CET 2003
-----
Wed Mar 26 10:52:45 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     R      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:01 cat cedo.iso
   716 tty2     R      5:24 bzip2
   756 tty2     R      0:00 ps x
Wed Mar 26 10:52:45 CET 2003
-----
Wed Mar 26 10:53:17 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:01 cat cedo.iso
   716 tty2     R      5:57 bzip2
   760 tty2     R      0:00 ps x
Wed Mar 26 10:53:17 CET 2003
-----
Wed Mar 26 10:53:50 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:01 cat cedo.iso
   716 tty2     R      6:29 bzip2
   764 tty2     R      0:00 ps x
Wed Mar 26 10:53:50 CET 2003
-----
Wed Mar 26 10:54:23 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     R      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:01 cat cedo.iso
   716 tty2     R      7:01 bzip2
   768 tty2     R      0:00 ps x
Wed Mar 26 10:54:23 CET 2003
-----
Wed Mar 26 10:54:56 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     D      0:01 cat cedo.iso
   716 tty2     S      7:41 bzip2
   772 tty2     R      0:00 ps x
Wed Mar 26 10:55:03 CET 2003
-----
Wed Mar 26 10:55:45 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     D      0:01 cat cedo.iso
   716 tty2     S      8:50 bzip2
   776 tty2     R      0:00 ps x
Wed Mar 26 10:56:13 CET 2003
-----
Wed Mar 26 10:56:50 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     R      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     S      0:01 cat cedo.iso
   716 tty2     R      9:27 bzip2
   780 tty2     R      0:00 ps x
Wed Mar 26 10:56:50 CET 2003
-----
Wed Mar 26 10:57:23 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     D      0:02 cat cedo.iso
   716 tty2     S     10:23 bzip2
   784 tty2     R      0:00 ps x
Wed Mar 26 10:57:47 CET 2003
-----
Wed Mar 26 10:58:29 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     D      0:02 cat cedo.iso
   716 tty2     S     11:09 bzip2
   788 tty2     R      0:00 ps x
Wed Mar 26 10:58:33 CET 2003
-----
Wed Mar 26 10:59:19 CET 2003
   PID TTY      STAT   TIME COMMAND
   325 tty2     S      0:00 -bash
   713 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   714 tty2     S      0:00 tee inter-2.5.64bk2.log
   715 tty2     D      0:02 cat cedo.iso
   716 tty2     S     11:59 bzip2
   792 tty2     R      0:00 ps x
Wed Mar 26 10:59:24 CET 2003
-----

(I interrupted the script here)

You can see that after less then 8 minutes running date, ps, and date 
again takes a very long time. When this happens, ps shows cat process in 
D-state and bzip2 in S-state.

I use Debian Woody on UP Athlon 800MHz, Asus A7V, 384MB RAM, disk WDC 
WD800JB-00CRA1 connected to on-board Promise 20265, nVidia Geforce2 MX, 
Realtek RTL-8139C, SB Live.
GCC is 2.95.4.

Let me know if you want me to provide more information/testing.

Michal Schmidt.

