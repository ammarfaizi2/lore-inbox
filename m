Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318194AbSIJWSm>; Tue, 10 Sep 2002 18:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318191AbSIJWSm>; Tue, 10 Sep 2002 18:18:42 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:44478 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318182AbSIJWRy>; Tue, 10 Sep 2002 18:17:54 -0400
Date: Tue, 10 Sep 2002 18:25:17 -0400
To: jonathan@buzzard.org.uk, john.weber@linuxhq.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Toshiba Laptop Support and IRQ Locks
Message-ID: <20020910222517.GA14056@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alrighty then, the patch below uses spinlocks instead of cli() and
> friends -- to conform to the new irq locking mechanism -- and some minor
> module changes while we're at it.

The patch seems mangled in:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102832986723995&w=2
I'd like to try it if someone has an unmangled version.

2.5.34 compile on my toshiba tecra 8000 stopped with:

drivers/built-in.o: In function `tosh_fn_status':
drivers/built-in.o(.text+0x17569): undefined reference to `save_flags'
drivers/built-in.o(.text+0x1756e): undefined reference to `cli'
drivers/built-in.o(.text+0x1757f): undefined reference to `restore_flags'
drivers/built-in.o: In function `tosh_emulate_fan':

The patch below gets it to compile and boot.

diff -ruN linux-2.5.34/drivers/char/toshiba.c linux/drivers/char/toshiba.c
--- linux-2.5.34/drivers/char/toshiba.c 2002-05-21 01:07:42.000000000 -0400
+++ linux/drivers/char/toshiba.c        2002-09-10 17:30:27.000000000 -0400
@@ -57,6 +57,7 @@
 #define TOSH_DEBUG 0

 #include <linux/module.h>
+#include <linux/interrupt.h>
 #include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>

The keyboard isn't working though.  That may be a config issue.

egrep ^C.*INPUT .config
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_KEYBOARD=y

I haven't tried 2.5 on the laptop for a long time.  
Anyone running 2.5 on a toshiba laptop?  A tecra 8000?

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

