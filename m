Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263765AbTCUSn1>; Fri, 21 Mar 2003 13:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263763AbTCUSmK>; Fri, 21 Mar 2003 13:42:10 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14980
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263767AbTCUSlf>; Fri, 21 Mar 2003 13:41:35 -0500
Date: Fri, 21 Mar 2003 19:56:50 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211956.h2LJuox3026133@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: add another clock tick rate variant
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/asm-i386/timex.h linux-2.5.65-ac2/include/asm-i386/timex.h
--- linux-2.5.65/include/asm-i386/timex.h	2003-02-10 18:38:16.000000000 +0000
+++ linux-2.5.65-ac2/include/asm-i386/timex.h	2003-03-14 01:17:16.000000000 +0000
@@ -9,11 +9,15 @@
 #include <linux/config.h>
 #include <asm/msr.h>
 
+#ifdef CONFIG_X86_PC9800
+   extern int CLOCK_TICK_RATE;
+#else
 #ifdef CONFIG_MELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
 #else
 #  define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
 #endif
+#endif
 
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
