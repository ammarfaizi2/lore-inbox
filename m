Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVE0WBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVE0WBW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVE0WBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:01:22 -0400
Received: from mail.dif.dk ([193.138.115.101]:13020 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262616AbVE0WBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:01:16 -0400
Date: Sat, 28 May 2005 00:05:48 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: build failure; CONFIG_HZ* unset if power management is not selected
 (2.6.12-rc5-mm1)
Message-ID: <Pine.LNX.4.62.0505280000020.2370@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just did a "make randconfig" in 2.6.12-rc5-mm1 to see if it would turn 
up some unexpected failures - and indeed it did. The randomly generated 
config didn't set CONFIG_PM and that in turn resulted in none of 
CONFIG_HZ, CONFIG_HZ_100, CONFIG_HZ_250 or CONFIG_HZ_1000 being set 
either. This resultes in the following spectacular build failure :


juhl@dragon:~/download/kernel/linux-2.6.12-rc5-mm1$ make
  CHK     include/linux/version.h
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/i386/kernel/asm-offsets.s
In file included from include/linux/sched.h:12,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/jiffies.h:42:3: #error You lose.
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:213:31: division by zero in #if
include/linux/jiffies.h:257:30: division by zero in #if
In file included from include/linux/sched.h:12,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/jiffies.h: In function `jiffies_to_msecs':
include/linux/jiffies.h:262: error: `CONFIG_HZ' undeclared (first use in this function)
include/linux/jiffies.h:262: error: (Each undeclared identifier is reported only once
include/linux/jiffies.h:262: error: for each function it appears in.)
include/linux/jiffies.h:268:36: division by zero in #if
include/linux/jiffies.h: In function `jiffies_to_usecs':
include/linux/jiffies.h:273: error: `CONFIG_HZ' undeclared (first use in this function)
include/linux/jiffies.h:281:30: division by zero in #if
include/linux/jiffies.h: In function `msecs_to_jiffies':
include/linux/jiffies.h:286: error: `CONFIG_HZ' undeclared (first use in this function)
include/linux/jiffies.h:294:36: division by zero in #if
include/linux/jiffies.h: In function `usecs_to_jiffies':
include/linux/jiffies.h:299: error: `CONFIG_HZ' undeclared (first use in this function)
include/linux/jiffies.h: In function `timespec_to_jiffies':
include/linux/jiffies.h:318: error: `CONFIG_HZ' undeclared (first use in this function)
include/linux/jiffies.h:324: error: `SHIFT_HZ' undeclared (first use in this function)
include/linux/jiffies.h: In function `jiffies_to_timespec':
include/linux/jiffies.h:337: error: `CONFIG_HZ' undeclared (first use in this function)
include/linux/jiffies.h: In function `timeval_to_jiffies':
include/linux/jiffies.h:359: error: `CONFIG_HZ' undeclared (first use in this function)
include/linux/jiffies.h:363: error: `SHIFT_HZ' undeclared (first use in this function)
include/linux/jiffies.h: In function `jiffies_to_timeval':
include/linux/jiffies.h:375: error: `CONFIG_HZ' undeclared (first use in this function)
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h:385:6: division by zero in #if
include/linux/jiffies.h: In function `jiffies_to_clock_t':
include/linux/jiffies.h:386: error: `CONFIG_HZ' undeclared (first use in this function)
include/linux/jiffies.h: In function `clock_t_to_jiffies':
include/linux/jiffies.h:397: error: `CONFIG_HZ' undeclared (first use in this function)
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h:416:6: division by zero in #if
include/linux/jiffies.h: In function `jiffies_64_to_clock_t':
include/linux/jiffies.h:417: error: `CONFIG_HZ' undeclared (first use in this function)
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
make: *** [arch/i386/kernel/asm-offsets.s] Error 2

