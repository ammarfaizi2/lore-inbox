Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271786AbTGRKCD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 06:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271738AbTGRJr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:47:57 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:29167 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S271564AbTGRJa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:30:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Update AS85EP1 port on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030718094540.0FEF43702@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 18 Jul 2003 18:45:40 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/as85ep1.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/as85ep1.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/as85ep1.c	2003-01-14 10:26:59.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/as85ep1.c	2003-07-16 17:23:42.000000000 +0900
@@ -107,8 +103,6 @@
 	AS85EP1_PORT_PMC (LEDS_PORT) = 0; /* Make the LEDs port an I/O port. */
 	AS85EP1_PORT_PM (LEDS_PORT) = 0; /* Make all the bits output pins.  */
 	mach_tick = as85ep1_led_tick;
-
-	ROOT_DEV = MKDEV (BLKMEM_MAJOR, 0);
 }
 
 void __init mach_get_physical_ram (unsigned long *ram_start,
@@ -137,10 +131,10 @@
 				 root_fs_image_end - root_fs_image_start);
 }
 
-void mach_gettimeofday (struct timeval *tv)
+void mach_gettimeofday (struct timespec *tv)
 {
 	tv->tv_sec = 0;
-	tv->tv_usec = 0;
+	tv->tv_nsec = 0;
 }
 
 void __init mach_sched_init (struct irqaction *timer_action)
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/as85ep1.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/as85ep1.h
--- linux-2.6.0-test1-moo/include/asm-v850/as85ep1.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/as85ep1.h	2003-07-17 20:25:27.000000000 +0900
@@ -14,8 +14,9 @@
 #ifndef __V850_AS85EP1_H__
 #define __V850_AS85EP1_H__
 
+#include <asm/v850e.h>
+
 
-#define CPU_ARCH 	"v850e"
 #define CPU_MODEL	"as85ep1"
 #define CPU_MODEL_LONG	"NEC V850E/AS85EP1"
 #define PLATFORM	"AS85EP1"
@@ -86,9 +87,6 @@
 #define AS85EP1_PORT_PMC(n)	(*(volatile u8 *)AS85EP1_PORT_PMC_ADDR(n))
 
 
-/* NB85E-style interrupt system.  */
-#include <asm/nb85e_intc.h>
-
 /* Hardware-specific interrupt numbers (in the kernel IRQ namespace).  */
 #define IRQ_INTCCC(n)	(0x0C + (n))
 #define IRQ_INTCCC_NUM	8
