Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUDLIGS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 04:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUDLIGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 04:06:17 -0400
Received: from pD9E57A79.dip.t-dialin.net ([217.229.122.121]:40202 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S262625AbUDLIFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 04:05:10 -0400
Date: Mon, 12 Apr 2004 07:57:05 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, davidm@hpl.hp.com, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH][RFC] sort out CLOCK_TICK_RATE usage [1/3]
Message-ID: <20040412075704.B5198@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: linux-kernel@vger.kernel.org, rth@twiddle.net,
	spyro@f2s.com, rmk@arm.linux.org.uk, davidm@hpl.hp.com,
	paulus@au.ibm.com, benh@kernel.crashing.org, jes@trained-monkey.org,
	ralf@gnu.org, matthew@wil.cx, davem@redhat.com,
	wesolows@foobazco.org, jdike@karaya.com, ak@suse.de
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>; from dl8bcu@dl8bcu.de on Mon, Apr 12, 2004 at 07:55:19AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Introducing PIC_TIC_RATE.



diff -ur linux-2.6.5-th/arch/alpha/kernel/time.c linux-2.6.5-1/arch/alpha/kernel/time.c
--- linux-2.6.5-th/arch/alpha/kernel/time.c	Sun Apr 11 14:24:42 2004
+++ linux-2.6.5-1/arch/alpha/kernel/time.c	Sun Apr 11 14:28:18 2004
@@ -254,7 +254,6 @@
  * arch/i386/time.c.
  */
 
-#define PIC_TICK_RATE	1193180UL
 #define CALIBRATE_LATCH	0xffff
 #define TIMEOUT_COUNT	0x100000
 
diff -ur linux-2.6.5-th/include/asm-alpha/timex.h linux-2.6.5-1/include/asm-alpha/timex.h
--- linux-2.6.5-th/include/asm-alpha/timex.h	Thu Dec 18 02:58:56 2003
+++ linux-2.6.5-1/include/asm-alpha/timex.h	Sun Apr 11 14:17:48 2004
@@ -10,6 +10,8 @@
    the 32.768kHz reference clock, which nicely divides down to our HZ.  */
 #define CLOCK_TICK_RATE	32768
 
+#define PIC_TICK_RATE	1193180UL
+
 /*
  * Standard way to access the cycle counter.
  * Currently only used on SMP for scheduling.
diff -ur linux-2.6.5-th/include/asm-arm/timex.h linux-2.6.5-1/include/asm-arm/timex.h
--- linux-2.6.5-th/include/asm-arm/timex.h	Thu Dec 18 02:58:17 2003
+++ linux-2.6.5-1/include/asm-arm/timex.h	Sun Apr 11 14:11:25 2004
@@ -23,4 +23,6 @@
 	return 0;
 }
 
+#define PIC_TICK_RATE	1193182UL
+
 #endif
diff -ur linux-2.6.5-th/include/asm-arm26/timex.h linux-2.6.5-1/include/asm-arm26/timex.h
--- linux-2.6.5-th/include/asm-arm26/timex.h	Thu Dec 18 02:59:05 2003
+++ linux-2.6.5-1/include/asm-arm26/timex.h	Sun Apr 11 14:11:57 2004
@@ -12,6 +12,9 @@
 #ifndef _ASMARM_TIMEX_H
 #define _ASMARM_TIMEX_H
 
+
+#define PIC_TICK_RATE		1193182UL
+
 /*
  * On the RiscPC, the clock ticks at 2MHz.
  */
diff -ur linux-2.6.5-th/include/asm-cris/timex.h linux-2.6.5-1/include/asm-cris/timex.h
--- linux-2.6.5-th/include/asm-cris/timex.h	Thu Dec 18 02:59:30 2003
+++ linux-2.6.5-1/include/asm-cris/timex.h	Sun Apr 11 14:14:35 2004
@@ -9,6 +9,8 @@
 
 #include <asm/arch/timex.h>
 
+#define PIC_TICK_RATE	1193182UL
+
 /*
  * We don't have a cycle-counter.. but we do not support SMP anyway where this is
  * used so it does not matter.
diff -ur linux-2.6.5-th/include/asm-h8300/timex.h linux-2.6.5-1/include/asm-h8300/timex.h
--- linux-2.6.5-th/include/asm-h8300/timex.h	Thu Dec 18 02:58:49 2003
+++ linux-2.6.5-1/include/asm-h8300/timex.h	Sun Apr 11 14:14:56 2004
@@ -10,6 +10,8 @@
 #include <asm/machine-depend.h>
 #undef  H8300_TIMER_DEFINE
 
+#define PIC_TICK_RATE	1193182UL
+
 #define CLOCK_TICK_RATE H8300_TIMER_FREQ
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
diff -ur linux-2.6.5-th/include/asm-i386/timex.h linux-2.6.5-1/include/asm-i386/timex.h
--- linux-2.6.5-th/include/asm-i386/timex.h	Sun Apr 11 14:24:36 2004
+++ linux-2.6.5-1/include/asm-i386/timex.h	Sun Apr 11 13:47:57 2004
@@ -19,6 +19,9 @@
 #endif
 #endif
 
+#define PIC_TICK_RATE CLOCK_TICK_RATE
+
+
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -ur linux-2.6.5-th/include/asm-ia64/timex.h linux-2.6.5-1/include/asm-ia64/timex.h
--- linux-2.6.5-th/include/asm-ia64/timex.h	Thu Dec 18 02:59:27 2003
+++ linux-2.6.5-1/include/asm-ia64/timex.h	Sun Apr 11 13:54:39 2004
@@ -28,6 +28,8 @@
  */
 #define CLOCK_TICK_RATE		(HZ * 100000UL)
 
+#define PIC_TICK_RATE		1193182UL
+
 static inline cycles_t
 get_cycles (void)
 {
diff -ur linux-2.6.5-th/include/asm-m68k/timex.h linux-2.6.5-1/include/asm-m68k/timex.h
--- linux-2.6.5-th/include/asm-m68k/timex.h	Thu Dec 18 02:58:07 2003
+++ linux-2.6.5-1/include/asm-m68k/timex.h	Sun Apr 11 13:55:55 2004
@@ -6,7 +6,9 @@
 #ifndef _ASMm68k_TIMEX_H
 #define _ASMm68k_TIMEX_H
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define PIC_TICK_RATE	1193180UL
+
+#define CLOCK_TICK_RATE	PIC_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -ur linux-2.6.5-th/include/asm-mips/timex.h linux-2.6.5-1/include/asm-mips/timex.h
--- linux-2.6.5-th/include/asm-mips/timex.h	Sun Apr 11 14:24:36 2004
+++ linux-2.6.5-1/include/asm-mips/timex.h	Sun Apr 11 14:02:21 2004
@@ -31,6 +31,9 @@
  * no reason to make this a separate architecture.
  */
 
+#define PIC_TICK_RATE	1193182UL
+
+
 #include <timex.h>
 
 /*
diff -ur linux-2.6.5-th/include/asm-parisc/timex.h linux-2.6.5-1/include/asm-parisc/timex.h
--- linux-2.6.5-th/include/asm-parisc/timex.h	Thu Dec 18 02:58:49 2003
+++ linux-2.6.5-1/include/asm-parisc/timex.h	Sun Apr 11 14:03:23 2004
@@ -8,7 +8,8 @@
 
 #include <asm/system.h>
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define	PIC_TICK_RATE	1193180UL
+#define CLOCK_TICK_RATE	PIC_TICK_RATE	/* Underlying HZ */
 
 typedef unsigned long cycles_t;
 
diff -ur linux-2.6.5-th/include/asm-ppc/timex.h linux-2.6.5-1/include/asm-ppc/timex.h
--- linux-2.6.5-th/include/asm-ppc/timex.h	Thu Dec 18 02:58:49 2003
+++ linux-2.6.5-1/include/asm-ppc/timex.h	Sun Apr 11 14:04:06 2004
@@ -10,7 +10,8 @@
 #include <linux/config.h>
 #include <asm/cputable.h>
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define PIC_TICK_RATE	1193180UL
+#define CLOCK_TICK_RATE	PIC_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -ur linux-2.6.5-th/include/asm-ppc64/timex.h linux-2.6.5-1/include/asm-ppc64/timex.h
--- linux-2.6.5-th/include/asm-ppc64/timex.h	Thu Dec 18 02:59:59 2003
+++ linux-2.6.5-1/include/asm-ppc64/timex.h	Sun Apr 11 14:04:45 2004
@@ -11,7 +11,8 @@
 #ifndef _ASMPPC64_TIMEX_H
 #define _ASMPPC64_TIMEX_H
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define PIC_TICK_RATE	1193180UL
+#define CLOCK_TICK_RATE	PIC_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -ur linux-2.6.5-th/include/asm-s390/timex.h linux-2.6.5-1/include/asm-s390/timex.h
--- linux-2.6.5-th/include/asm-s390/timex.h	Sun Apr 11 14:23:27 2004
+++ linux-2.6.5-1/include/asm-s390/timex.h	Sun Apr 11 14:05:25 2004
@@ -11,7 +11,8 @@
 #ifndef _ASM_S390_TIMEX_H
 #define _ASM_S390_TIMEX_H
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define PIC_TICK_RATE	1193180UL
+#define CLOCK_TICK_RATE	PIC_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -ur linux-2.6.5-th/include/asm-sh/timex.h linux-2.6.5-1/include/asm-sh/timex.h
--- linux-2.6.5-th/include/asm-sh/timex.h	Sun Apr 11 14:23:27 2004
+++ linux-2.6.5-1/include/asm-sh/timex.h	Sun Apr 11 14:06:38 2004
@@ -6,6 +6,7 @@
 #ifndef __ASM_SH_TIMEX_H
 #define __ASM_SH_TIMEX_H
 
+#define PIC_TICK_RATE	1193182UL
 #define CLOCK_TICK_RATE		(CONFIG_SH_PCLK_FREQ / 4) /* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
diff -ur linux-2.6.5-th/include/asm-sparc/timex.h linux-2.6.5-1/include/asm-sparc/timex.h
--- linux-2.6.5-th/include/asm-sparc/timex.h	Thu Dec 18 02:59:05 2003
+++ linux-2.6.5-1/include/asm-sparc/timex.h	Sun Apr 11 14:07:08 2004
@@ -6,7 +6,8 @@
 #ifndef _ASMsparc_TIMEX_H
 #define _ASMsparc_TIMEX_H
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define PIC_TICK_RATE	1193180UL
+#define CLOCK_TICK_RATE	PIC_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -ur linux-2.6.5-th/include/asm-sparc64/timex.h linux-2.6.5-1/include/asm-sparc64/timex.h
--- linux-2.6.5-th/include/asm-sparc64/timex.h	Thu Dec 18 02:58:49 2003
+++ linux-2.6.5-1/include/asm-sparc64/timex.h	Sun Apr 11 14:07:37 2004
@@ -8,7 +8,8 @@
 
 #include <asm/timer.h>
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define PIC_TICK_RATE	1193180UL
+#define CLOCK_TICK_RATE	PIC_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -ur linux-2.6.5-th/include/asm-um/timex.h linux-2.6.5-1/include/asm-um/timex.h
--- linux-2.6.5-th/include/asm-um/timex.h	Thu Dec 18 02:59:05 2003
+++ linux-2.6.5-1/include/asm-um/timex.h	Sun Apr 11 14:09:13 2004
@@ -12,6 +12,7 @@
 	return 0;
 }
 
+#define PIC_TICK_RATE	1193182UL
 #define CLOCK_TICK_RATE (HZ)
 
 #endif
diff -ur linux-2.6.5-th/include/asm-v850/timex.h linux-2.6.5-1/include/asm-v850/timex.h
--- linux-2.6.5-th/include/asm-v850/timex.h	Thu Dec 18 02:59:40 2003
+++ linux-2.6.5-1/include/asm-v850/timex.h	Sun Apr 11 14:10:00 2004
@@ -6,7 +6,8 @@
 #ifndef __V850_TIMEX_H__
 #define __V850_TIMEX_H__
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define PIC_TICK_RATE	1193180UL
+#define CLOCK_TICK_RATE	PIC_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
diff -ur linux-2.6.5-th/include/asm-x86_64/timex.h linux-2.6.5-1/include/asm-x86_64/timex.h
--- linux-2.6.5-th/include/asm-x86_64/timex.h	Sun Apr 11 14:23:27 2004
+++ linux-2.6.5-1/include/asm-x86_64/timex.h	Sun Apr 11 14:10:35 2004
@@ -11,7 +11,8 @@
 #include <asm/vsyscall.h>
 #include <asm/hpet.h>
 
-#define CLOCK_TICK_RATE	1193182 /* Underlying HZ */
+#define PIC_TICK_RATE	1193182UL
+#define CLOCK_TICK_RATE	PIC_TICK_RATE	/* Underlying HZ */
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((int)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
 	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \


-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
