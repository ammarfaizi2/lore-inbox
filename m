Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286159AbRLZFSz>; Wed, 26 Dec 2001 00:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286160AbRLZFSq>; Wed, 26 Dec 2001 00:18:46 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:17876 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S286159AbRLZFSh>; Wed, 26 Dec 2001 00:18:37 -0500
Message-ID: <3C295D5C.50EE365D@home.com>
Date: Wed, 26 Dec 2001 00:17:16 -0500
From: Paul Boley <pboley@home.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: severe slowdown with 2.4 series w/heavy disk access
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been having this problem with the whole 2.4 kernel series.. Under
heavy disk access, the entire system will slow down and almost all of my
memory, save 5 megs, gets used up, never to return.  I am currently
running 2.4.17 on a machine with 416 megs of ram, Duron 750, not
overclocked.  Cpu temp does not exceed 107 deg F ever, so I don't think
its a heat issue.  I have an MSI K7T Pro2 motherboard, using the KT133
chipset.  Anyway, the following is how I can duplicate the problem, in
about 5 minutes.  I only used mozilla for this because I was working
with it when I decided to isolate the problem.  Also note this happens
more than just with tar, and sometimes it happens for no apparent reason
at all.

*** free and ps -ax, before the slowdown:

             total       used       free     shared    buffers
cached
Mem:        417472      30104     387368          0       1264
21748
-/+ buffers/cache:       7092     410380
Swap:       136544          0     136544

  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:04 init
    2 ?        SW     0:00 [keventd]
    3 ?        SWN    0:00 [ksoftirqd_CPU0]
    4 ?        SW     0:00 [kswapd]
    5 ?        SW     0:00 [bdflush]
    6 ?        SW     0:00 [kupdated]
   63 ?        S      0:00 /usr/sbin/syslogd
   66 ?        S      0:00 /usr/sbin/klogd -c 3
   78 ?        S      0:00 /usr/sbin/atd -b 15 -l 1
   90 tty1     S      0:00 -bash
   91 tty2     S      0:00 -bash
   92 tty3     S      0:00 /sbin/agetty 38400 tty3 linux
   93 tty4     S      0:00 /sbin/agetty 38400 tty4 linux
   94 tty5     S      0:00 /sbin/agetty 38400 tty5 linux
   95 tty6     S      0:00 /sbin/agetty 38400 tty6 linux
  192 tty2     S      0:00 top
  200 tty1     R      0:00 ps -ax

*** I then rm -rf'd mozilla, and tar -zxvf mozilla-source-0.9.7.tar.gz,
*** and immediately after, ran free and ps -ax again.  The system
started
*** losing memory and slowing down about 10 seconds into the
*** decompression.

             total       used       free     shared    buffers
cached
Mem:        417472     412192       5280          0      20632
315680
-/+ buffers/cache:      75880     341592
Swap:       136544          0     136544

  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:04 init
    2 ?        SW     0:00 [keventd]
    3 ?        SWN    0:00 [ksoftirqd_CPU0]
    4 ?        SW     0:00 [kswapd]
    5 ?        SW     0:00 [bdflush]
    6 ?        SW     0:02 [kupdated]
   63 ?        S      0:00 /usr/sbin/syslogd
   66 ?        S      0:00 /usr/sbin/klogd -c 3
   78 ?        S      0:00 /usr/sbin/atd -b 15 -l 1
   90 tty1     S      0:00 -bash
   91 tty2     S      0:00 -bash
   92 tty3     S      0:00 /sbin/agetty 38400 tty3 linux
   93 tty4     S      0:00 /sbin/agetty 38400 tty4 linux
   94 tty5     S      0:00 /sbin/agetty 38400 tty5 linux
   95 tty6     S      0:00 /sbin/agetty 38400 tty6 linux
  192 tty2     S      0:01 top
  207 tty1     R      0:00 ps -ax


