Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274893AbRIZJdB>; Wed, 26 Sep 2001 05:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274894AbRIZJcv>; Wed, 26 Sep 2001 05:32:51 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:14341 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S274893AbRIZJcl>; Wed, 26 Sep 2001 05:32:41 -0400
Date: Wed, 26 Sep 2001 10:00:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Fix for 2.4.10's broken char/joystick/analog.c
Message-ID: <20010926100024.A1651@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

My x86_64 fixes broke my own analog.c in 2.4.10 on machines with TSC.
Here is a patch that adds the missing braces. With this patch it is
verified to work fine. My apologies.

--- linux-2.4.10/drivers/char/joystick/analog.c	Fri Sep 14 23:40:00 2001
+++ linux/drivers/char/joystick/analog.c	Wed Sep 26 09:56:35 2001
@@ -138,7 +138,7 @@
 
 #ifdef __i386__
 #define TSC_PRESENT	(test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability))
-#define GET_TIME(x)	do { if (TSC_PRESENT) rdtscl(x); else outb(0, 0x43); x = inb(0x40); x |= inb(0x40) << 8; } while (0)
+#define GET_TIME(x)	do { if (TSC_PRESENT) rdtscl(x); else { outb(0, 0x43); x = inb(0x40); x |= inb(0x40) << 8; } } while (0)
 #define DELTA(x,y)	(TSC_PRESENT?((y)-(x)):((x)-(y)+((x)<(y)?1193180L/HZ:0)))
 #define TIME_NAME	(TSC_PRESENT?"TSC":"PIT")
 #elif __x86_64__

-- 
Vojtech Pavlik
SuSE Labs
