Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271442AbTGRJfa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271567AbTGRJfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:35:30 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:48383 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S271442AbTGRJax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:30:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/7][v850]  Rename `nb85e' to `v850e' on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030718094531.DA83F3702@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 18 Jul 2003 18:45:31 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

The term `nb85e' is incorrect (caused by my confusion when starting the
v850 port), so this renames all occurances to `v850e'.

Because this change renames some files too, it contains a number of
whole-file add/removes.

diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/anna.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/anna.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/anna.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/anna.c	2003-07-16 17:23:42.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/anna.c -- Anna V850E2 evaluation chip/board
  *
- *  Copyright (C) 2002  NEC Corporation
- *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2002,03  NEC Electronics Corporation
+ *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -21,8 +21,8 @@
 #include <asm/machdep.h>
 #include <asm/atomic.h>
 #include <asm/page.h>
-#include <asm/nb85e_timer_d.h>
-#include <asm/nb85e_uart.h>
+#include <asm/v850e_timer_d.h>
+#include <asm/v850e_uart.h>
 
 #include "mach.h"
 
@@ -95,12 +97,12 @@
 void __init mach_sched_init (struct irqaction *timer_action)
 {
 	/* Start hardware timer.  */
-	nb85e_timer_d_configure (0, HZ);
+	v850e_timer_d_configure (0, HZ);
 	/* Install timer interrupt handler.  */
 	setup_irq (IRQ_INTCMD(0), timer_action);
 }
 
-static struct nb85e_intc_irq_init irq_inits[] = {
+static struct v850e_intc_irq_init irq_inits[] = {
 	{ "IRQ", 0, 		NUM_MACH_IRQS,	1, 7 },
 	{ "PIN", IRQ_INTP(0),   IRQ_INTP_NUM,   1, 4 },
 	{ "CCC", IRQ_INTCCC(0),	IRQ_INTCCC_NUM, 1, 5 },
@@ -118,7 +120,7 @@
 
 void __init mach_init_irqs (void)
 {
-	nb85e_intc_init_irq_types (irq_inits, hw_itypes);
+	v850e_intc_init_irq_types (irq_inits, hw_itypes);
 }
 
 void machine_restart (char *__unused)
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/as85ep1.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/as85ep1.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/as85ep1.c	2003-01-14 10:26:59.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/as85ep1.c	2003-07-16 17:23:42.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/as85ep1.c -- AS85EP1 V850E evaluation chip/board
  *
- *  Copyright (C) 2002  NEC Corporation
- *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2002,03  NEC Electronics Corporation
+ *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -21,8 +21,8 @@
 #include <asm/machdep.h>
 #include <asm/atomic.h>
 #include <asm/page.h>
-#include <asm/nb85e_timer_d.h>
-#include <asm/nb85e_uart.h>
+#include <asm/v850e_timer_d.h>
+#include <asm/v850e_uart.h>
 
 #include "mach.h"
 
@@ -90,7 +90,7 @@
 	AS85EP1_IRAMM = 0x0;	/* 内蔵命令RAMは「read-mode」になります */
 #endif /* !CONFIG_ROM_KERNEL */
 
-	nb85e_intc_disable_irqs ();
+	v850e_intc_disable_irqs ();
 }
 
 void __init mach_setup (char **cmdline)
@@ -147,12 +141,12 @@
 void __init mach_sched_init (struct irqaction *timer_action)
 {
 	/* Start hardware timer.  */
-	nb85e_timer_d_configure (0, HZ);
+	v850e_timer_d_configure (0, HZ);
 	/* Install timer interrupt handler.  */
 	setup_irq (IRQ_INTCMD(0), timer_action);
 }
 
-static struct nb85e_intc_irq_init irq_inits[] = {
+static struct v850e_intc_irq_init irq_inits[] = {
 	{ "IRQ", 0, 		NUM_MACH_IRQS,	1, 7 },
 	{ "CCC", IRQ_INTCCC(0),	IRQ_INTCCC_NUM, 1, 5 },
 	{ "CMD", IRQ_INTCMD(0), IRQ_INTCMD_NUM,	1, 5 },
@@ -166,7 +160,7 @@
 
 void __init mach_init_irqs (void)
 {
-	nb85e_intc_init_irq_types (irq_inits, hw_itypes);
+	v850e_intc_init_irq_types (irq_inits, hw_itypes);
 }
 
 void machine_restart (char *__unused)
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/fpga85e2c.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/fpga85e2c.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/fpga85e2c.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/fpga85e2c.c	2003-07-17 20:25:27.000000000 +0900
@@ -2,8 +2,8 @@
  * arch/v850/kernel/fpga85e2c.h -- Machine-dependent defs for
  *	FPGA implementation of V850E2/NA85E2C
  *
- *  Copyright (C) 2002  NEC Corporation
- *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2002,03  NEC Electronics Corporation
+ *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -134,7 +134,7 @@
 
 /* Interrupts */
 
-struct nb85e_intc_irq_init irq_inits[] = {
+struct v850e_intc_irq_init irq_inits[] = {
 	{ "IRQ", 0, 		NUM_MACH_IRQS,	1, 7 },
 	{ "RPU", IRQ_RPU(0),	IRQ_RPU_NUM,	1, 6 },
 	{ 0 }
@@ -146,7 +146,7 @@
 /* Initialize interrupts.  */
 void __init mach_init_irqs (void)
 {
-	nb85e_intc_init_irq_types (irq_inits, hw_itypes);
+	v850e_intc_init_irq_types (irq_inits, hw_itypes);
 }
 
 
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/gbus_int.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/gbus_int.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/gbus_int.c	2003-07-14 13:14:39.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/gbus_int.c	2003-07-15 19:06:36.000000000 +0900
@@ -247,7 +245,7 @@
 	/* First initialize the shared gint interrupts.  */
 	for (i = 0; i < NUM_USED_GINTS; i++) {
 		unsigned gint = used_gint[i].gint;
-		struct nb85e_intc_irq_init gint_irq_init[2];
+		struct v850e_intc_irq_init gint_irq_init[2];
 
 		/* We initialize one GINT interrupt at a time.  */
 		gint_irq_init[0].name = "GINT";
@@ -258,7 +256,7 @@
 
 		gint_irq_init[1].name = 0; /* Terminate the vector.  */
 
-		nb85e_intc_init_irq_types (gint_irq_init, gint_hw_itypes);
+		v850e_intc_init_irq_types (gint_irq_init, gint_hw_itypes);
 	}
 
 	/* Then the GBUS interrupts.  */
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/highres_timer.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/highres_timer.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/highres_timer.c	2002-11-05 11:25:22.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/highres_timer.c	2003-07-15 19:06:36.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/highres_timer.c -- High resolution timing routines
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -12,7 +12,7 @@
  */
 
 #include <asm/system.h>
-#include <asm/nb85e_timer_d.h>
+#include <asm/v850e_timer_d.h>
 #include <asm/highres_timer.h>
 
 #define HIGHRES_TIMER_USEC_SHIFT   12
@@ -42,7 +42,7 @@
 
 void highres_timer_reset (void)
 {
-	NB85E_TIMER_D_TMD (HIGHRES_TIMER_TIMER_D_UNIT) = 0;
+	V850E_TIMER_D_TMD (HIGHRES_TIMER_TIMER_D_UNIT) = 0;
 	HIGHRES_TIMER_SLOW_TICKS = 0;
 }
 
@@ -51,12 +51,12 @@
 	u32 fast_tick_rate;
 
 	/* Start hardware timer.  */
-	nb85e_timer_d_configure (HIGHRES_TIMER_TIMER_D_UNIT,
+	v850e_timer_d_configure (HIGHRES_TIMER_TIMER_D_UNIT,
 				 HIGHRES_TIMER_SLOW_TICK_RATE);
 
 	fast_tick_rate =
-		(NB85E_TIMER_D_BASE_FREQ
-		 >> NB85E_TIMER_D_DIVLOG2 (HIGHRES_TIMER_TIMER_D_UNIT));
+		(V850E_TIMER_D_BASE_FREQ
+		 >> V850E_TIMER_D_DIVLOG2 (HIGHRES_TIMER_TIMER_D_UNIT));
 
 	/* The obvious way of calculating microseconds from fast ticks
 	   is to do:
@@ -77,16 +77,16 @@
 
 	/* Enable the interrupt (which is hardwired to this use), and
 	   give it the highest priority.  */
-	NB85E_INTC_IC (IRQ_INTCMD (HIGHRES_TIMER_TIMER_D_UNIT)) = 0;
+	V850E_INTC_IC (IRQ_INTCMD (HIGHRES_TIMER_TIMER_D_UNIT)) = 0;
 }
 
 void highres_timer_stop (void)
 {
 	/* Stop the timer.  */
-	NB85E_TIMER_D_TMCD (HIGHRES_TIMER_TIMER_D_UNIT) =
-		NB85E_TIMER_D_TMCD_CAE;
+	V850E_TIMER_D_TMCD (HIGHRES_TIMER_TIMER_D_UNIT) =
+		V850E_TIMER_D_TMCD_CAE;
 	/* Disable its interrupt, just in case.  */
-	nb85e_intc_disable_irq (IRQ_INTCMD (HIGHRES_TIMER_TIMER_D_UNIT));
+	v850e_intc_disable_irq (IRQ_INTCMD (HIGHRES_TIMER_TIMER_D_UNIT));
 }
 
 inline void highres_timer_read_ticks (u32 *slow_ticks, u32 *fast_ticks)
@@ -95,9 +95,9 @@
 	u32 fast_ticks_1, fast_ticks_2, _slow_ticks;
 
 	local_irq_save (flags);
-	fast_ticks_1 = NB85E_TIMER_D_TMD (HIGHRES_TIMER_TIMER_D_UNIT);
+	fast_ticks_1 = V850E_TIMER_D_TMD (HIGHRES_TIMER_TIMER_D_UNIT);
 	_slow_ticks = HIGHRES_TIMER_SLOW_TICKS;
-	fast_ticks_2 = NB85E_TIMER_D_TMD (HIGHRES_TIMER_TIMER_D_UNIT);
+	fast_ticks_2 = V850E_TIMER_D_TMD (HIGHRES_TIMER_TIMER_D_UNIT);
 	local_irq_restore (flags);
 
 	if (fast_ticks_2 < fast_ticks_1)
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/ma.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/ma.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/ma.c	2003-06-16 14:52:16.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/ma.c	2003-07-15 19:06:36.000000000 +0900
@@ -22,19 +22,19 @@
 #include <asm/atomic.h>
 #include <asm/page.h>
 #include <asm/machdep.h>
-#include <asm/nb85e_timer_d.h>
+#include <asm/v850e_timer_d.h>
 
 #include "mach.h"
 
 void __init mach_sched_init (struct irqaction *timer_action)
 {
 	/* Start hardware timer.  */
-	nb85e_timer_d_configure (0, HZ);
+	v850e_timer_d_configure (0, HZ);
 	/* Install timer interrupt handler.  */
 	setup_irq (IRQ_INTCMD(0), timer_action);
 }
 
-static struct nb85e_intc_irq_init irq_inits[] = {
+static struct v850e_intc_irq_init irq_inits[] = {
 	{ "IRQ", 0, 		NUM_MACH_IRQS,	1, 7 },
 	{ "CMD", IRQ_INTCMD(0), IRQ_INTCMD_NUM,	1, 5 },
 	{ "DMA", IRQ_INTDMA(0), IRQ_INTDMA_NUM,	1, 2 },
@@ -51,7 +51,7 @@
 /* Initialize MA chip interrupts.  */
 void __init ma_init_irqs (void)
 {
-	nb85e_intc_init_irq_types (irq_inits, hw_itypes);
+	v850e_intc_init_irq_types (irq_inits, hw_itypes);
 }
 
 /* Called before configuring an on-chip UART.  */
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/nb85e_intc.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/nb85e_intc.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/nb85e_intc.c	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/nb85e_intc.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,104 +0,0 @@
-/*
- * arch/v850/kernel/nb85e_intc.c -- NB85E cpu core interrupt controller (INTC)
- *
- *  Copyright (C) 2001,02,03  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-
-#include <asm/nb85e_intc.h>
-
-static void irq_nop (unsigned irq) { }
-
-static unsigned nb85e_intc_irq_startup (unsigned irq)
-{
-	nb85e_intc_clear_pending_irq (irq);
-	nb85e_intc_enable_irq (irq);
-	return 0;
-}
-
-static void nb85e_intc_end_irq (unsigned irq)
-{
-	unsigned long psw, temp;
-
-	/* Clear the highest-level bit in the In-service priority register
-	   (ISPR), to allow this interrupt (or another of the same or
-	   lesser priority) to happen again.
-
-	   The `reti' instruction normally does this automatically when the
-	   PSW bits EP and NP are zero, but we can't always rely on reti
-	   being used consistently to return after an interrupt (another
-	   process can be scheduled, for instance, which can delay the
-	   associated reti for a long time, or this process may be being
-	   single-stepped, which uses the `dbret' instruction to return
-	   from the kernel).
-
-	   We also set the PSW EP bit, which prevents reti from also
-	   trying to modify the ISPR itself.  */
-
-	/* Get PSW and disable interrupts.  */
-	asm volatile ("stsr psw, %0; di" : "=r" (psw));
-	/* We don't want to do anything for NMIs (they don't use the ISPR).  */
-	if (! (psw & 0xC0)) {
-		/* Transition to `trap' state, so that an eventual real
-		   reti instruction won't modify the ISPR.  */
-		psw |= 0x40;
-		/* Fake an interrupt return, which automatically clears the
-		   appropriate bit in the ISPR.  */
-		asm volatile ("mov hilo(1f), %0;"
-			      "ldsr %0, eipc; ldsr %1, eipsw;"
-			      "reti;"
-			      "1:"
-			      : "=&r" (temp) : "r" (psw));
-	}
-}
-
-/* Initialize HW_IRQ_TYPES for INTC-controlled irqs described in array
-   INITS (which is terminated by an entry with the name field == 0).  */
-void __init nb85e_intc_init_irq_types (struct nb85e_intc_irq_init *inits,
-				       struct hw_interrupt_type *hw_irq_types)
-{
-	struct nb85e_intc_irq_init *init;
-	for (init = inits; init->name; init++) {
-		unsigned i;
-		struct hw_interrupt_type *hwit = hw_irq_types++;
-
-		hwit->typename = init->name;
-
-		hwit->startup  = nb85e_intc_irq_startup;
-		hwit->shutdown = nb85e_intc_disable_irq;
-		hwit->enable   = nb85e_intc_enable_irq;
-		hwit->disable  = nb85e_intc_disable_irq;
-		hwit->ack      = irq_nop;
-		hwit->end      = nb85e_intc_end_irq;
-		
-		/* Initialize kernel IRQ infrastructure for this interrupt.  */
-		init_irq_handlers(init->base, init->num, init->interval, hwit);
-
-		/* Set the interrupt priorities.  */
-		for (i = 0; i < init->num; i++) {
-			unsigned irq = init->base + i * init->interval;
-
-			/* If the interrupt is currently enabled (all
-			   interrupts are initially disabled), then
-			   assume whoever enabled it has set things up
-			   properly, and avoid messing with it.  */
-			if (! nb85e_intc_irq_enabled (irq))
-				/* This write also (1) disables the
-				   interrupt, and (2) clears any pending
-				   interrupts.  */
-				NB85E_INTC_IC (irq)
-					= (NB85E_INTC_IC_PR (init->priority)
-					   | NB85E_INTC_IC_MK);
-		}
-	}
-}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/nb85e_timer_d.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/nb85e_timer_d.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/nb85e_timer_d.c	2002-11-05 11:25:22.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/nb85e_timer_d.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,54 +0,0 @@
-/*
- * include/asm-v850/nb85e_timer_d.c -- `Timer D' component often used
- *	with the NB85E cpu core
- *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-#include <linux/kernel.h>
-
-#include <asm/nb85e_utils.h>
-#include <asm/nb85e_timer_d.h>
-
-/* Start interval timer TIMER (0-3).  The timer will issue the
-   corresponding INTCMD interrupt RATE times per second.
-   This function does not enable the interrupt.  */
-void nb85e_timer_d_configure (unsigned timer, unsigned rate)
-{
-	unsigned divlog2, count;
-
-	/* Calculate params for timer.  */
-	if (! calc_counter_params (
-		    NB85E_TIMER_D_BASE_FREQ, rate,
-		    NB85E_TIMER_D_TMCD_CS_MIN, NB85E_TIMER_D_TMCD_CS_MAX, 16,
-		    &divlog2, &count))
-		printk (KERN_WARNING
-			"Cannot find interval timer %d setting suitable"
-			" for rate of %dHz.\n"
-			"Using rate of %dHz instead.\n",
-			timer, rate,
-			(NB85E_TIMER_D_BASE_FREQ >> divlog2) >> 16);
-
-	/* Do the actual hardware timer initialization:  */
-
-	/* Enable timer.  */
-	NB85E_TIMER_D_TMCD(timer) = NB85E_TIMER_D_TMCD_CAE;
-	/* Set clock divider.  */
-	NB85E_TIMER_D_TMCD(timer)
-		= NB85E_TIMER_D_TMCD_CAE
-		| NB85E_TIMER_D_TMCD_CS(divlog2);
-	/* Set timer compare register.  */
-	NB85E_TIMER_D_CMD(timer) = count;
-	/* Start counting.  */
-	NB85E_TIMER_D_TMCD(timer)
-		= NB85E_TIMER_D_TMCD_CAE
-		| NB85E_TIMER_D_TMCD_CS(divlog2)
-		| NB85E_TIMER_D_TMCD_CE;
-}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/nb85e_utils.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/nb85e_utils.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/nb85e_utils.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/nb85e_utils.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,65 +0,0 @@
-/*
- * include/asm-v850/nb85e_utils.h -- Utility functions associated with
- *	the NB85E cpu core
- *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-/* Note: these functions are often associated with the N85E cpu core,
-   but not always, which is why they're not in `nb85e.c'.  */
-
-#include <asm/nb85e_utils.h>
-
-/* Calculate counter clock-divider and count values to attain the
-   desired frequency RATE from the base frequency BASE_FREQ.  The
-   counter is expected to have a clock-divider, which can divide the
-   system cpu clock by a power of two value from MIN_DIVLOG2 to
-   MAX_DIV_LOG2, and a word-size of COUNTER_SIZE bits (the counter
-   counts up and resets whenever it's equal to the compare register,
-   generating an interrupt or whatever when it does so).  The returned
-   values are: *DIVLOG2 -- log2 of the desired clock divider and *COUNT
-   -- the counter compare value to use.  Returns true if it was possible
-   to find a reasonable value, otherwise false (and the other return
-   values will be set to be as good as possible).  */
-int calc_counter_params (unsigned long base_freq,
-			 unsigned long rate,
-			 unsigned min_divlog2, unsigned max_divlog2,
-			 unsigned counter_size,
-			 unsigned *divlog2, unsigned *count)
-{
-	unsigned _divlog2;
-	int ok = 0;
-
-	/* Find the lowest clock divider setting that can represent RATE.  */
-	for (_divlog2 = min_divlog2; _divlog2 <= max_divlog2; _divlog2++) {
-		/* Minimum interrupt rate possible using this divider.  */
-		unsigned min_int_rate
-			= (base_freq >> _divlog2) >> counter_size;
-
-		if (min_int_rate <= rate) {
-			/* This setting is the highest resolution
-			   setting that's slow enough enough to attain
-			   RATE interrupts per second, so use it.  */
-			ok = 1;
-			break;
-		}
-	}
-
-	if (_divlog2 > max_divlog2)
-		/* Can't find correct setting.  */
-		_divlog2 = max_divlog2;
-
-	if (divlog2)
-		*divlog2 = _divlog2;
-	if (count)
-		*count = ((base_freq >> _divlog2) + rate/2) / rate;
-
-	return ok;
-}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/rte_cb.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/rte_cb.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/rte_cb.c	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/rte_cb.c	2003-07-16 17:23:42.000000000 +0900
@@ -17,7 +17,7 @@
 #include <linux/fs.h>
 
 #include <asm/machdep.h>
-#include <asm/nb85e_uart.h>
+#include <asm/v850e_uart.h>
 
 #include "mach.h"
 
@@ -34,7 +34,7 @@
 
 void __init rte_cb_early_init (void)
 {
-	nb85e_intc_disable_irqs ();
+	v850e_intc_disable_irqs ();
 
 #ifdef CONFIG_RTE_CB_MULTI
 	multi_init ();
@@ -43,6 +43,7 @@
 
 void __init mach_setup (char **cmdline)
 {
+#ifdef CONFIG_RTE_MB_A_PCI
 	/* Probe for Mother-A, and print a message if we find it.  */
 	*(volatile unsigned long *)MB_A_SRAM_ADDR = 0xDEADBEEF;
 	if (*(volatile unsigned long *)MB_A_SRAM_ADDR == 0xDEADBEEF) {
@@ -194,6 +183,7 @@
 
 #endif /* CONFIG_RTE_GBUS_INT */
 
+
 void __init rte_cb_init_irqs (void)
 {
 #ifdef CONFIG_RTE_GBUS_INT
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/rte_ma1_cb.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/rte_ma1_cb.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/rte_ma1_cb.c	2003-06-16 14:52:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/rte_ma1_cb.c	2003-07-15 19:06:36.000000000 +0900
@@ -20,7 +20,7 @@
 #include <asm/page.h>
 #include <asm/ma1.h>
 #include <asm/rte_ma1_cb.h>
-#include <asm/nb85e_timer_c.h>
+#include <asm/v850e_timer_c.h>
 
 #include "mach.h"
 
@@ -89,14 +89,14 @@
 	rte_cb_init_irqs ();
 
 	/* Use falling-edge-sensitivity for interrupts .  */
-	NB85E_TIMER_C_SESC (0) &= ~0xC;
-	NB85E_TIMER_C_SESC (1) &= ~0xF;
+	V850E_TIMER_C_SESC (0) &= ~0xC;
+	V850E_TIMER_C_SESC (1) &= ~0xF;
 
 	/* INTP000-INTP011 are shared with `Timer C', so we have to set
 	   up Timer C to pass them through as raw interrupts.  */
 	for (tc = 0; tc < 2; tc++)
 		/* Turn on the timer.  */
-		NB85E_TIMER_C_TMCC0 (tc) |= NB85E_TIMER_C_TMCC0_CAE;
+		V850E_TIMER_C_TMCC0 (tc) |= V850E_TIMER_C_TMCC0_CAE;
 
 	/* Make sure the relevant port0/port1 pins are assigned
 	   interrupt duty.  We used INTP001-INTP011 (don't screw with
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/rte_nb85e_cb.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/rte_nb85e_cb.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/rte_nb85e_cb.c	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/rte_nb85e_cb.c	2003-07-15 19:06:36.000000000 +0900
@@ -21,7 +21,7 @@
 
 #include <asm/atomic.h>
 #include <asm/page.h>
-#include <asm/nb85e.h>
+#include <asm/v850e.h>
 #include <asm/rte_nb85e_cb.h>
 
 #include "mach.h"
@@ -41,7 +41,7 @@
 
 	   Unfortunately, the dcache seems to be buggy, so we only use the
 	   icache for now.  */
-	nb85e_cache_enable (0x0040 /* BHC */, 0x0000 /* DCC */);
+	v850e_cache_enable (0x0040 /*BHC*/, 0x0003 /*ICC*/, 0x0000 /*DCC*/);
 
 	rte_cb_early_init ();
 }
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/teg.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/teg.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/teg.c	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/teg.c	2003-07-15 19:06:36.000000000 +0900
@@ -22,7 +22,7 @@
 #include <asm/atomic.h>
 #include <asm/page.h>
 #include <asm/machdep.h>
-#include <asm/nb85e_timer_d.h>
+#include <asm/v850e_timer_d.h>
 
 #include "mach.h"
 
@@ -31,12 +31,12 @@
 	/* Select timer interrupt instead of external pin.  */
 	TEG_ISS |= 0x1;
 	/* Start hardware timer.  */
-	nb85e_timer_d_configure (0, HZ);
+	v850e_timer_d_configure (0, HZ);
 	/* Install timer interrupt handler.  */
 	setup_irq (IRQ_INTCMD(0), timer_action);
 }
 
-static struct nb85e_intc_irq_init irq_inits[] = {
+static struct v850e_intc_irq_init irq_inits[] = {
 	{ "IRQ", 0,		NUM_CPU_IRQS,	1, 7 },
 	{ "CMD", IRQ_INTCMD(0),	IRQ_INTCMD_NUM,	1, 5 },
 	{ "SER", IRQ_INTSER(0),	IRQ_INTSER_NUM,	1, 3 },
@@ -51,7 +51,7 @@
 /* Initialize MA chip interrupts.  */
 void __init teg_init_irqs (void)
 {
-	nb85e_intc_init_irq_types (irq_inits, hw_itypes);
+	v850e_intc_init_irq_types (irq_inits, hw_itypes);
 }
 
 /* Called before configuring an on-chip UART.  */
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/v850e_intc.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/v850e_intc.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/v850e_intc.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/v850e_intc.c	2003-07-15 19:06:35.000000000 +0900
@@ -0,0 +1,104 @@
+/*
+ * arch/v850/kernel/v850e_intc.c -- V850E interrupt controller (INTC)
+ *
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+
+#include <asm/v850e_intc.h>
+
+static void irq_nop (unsigned irq) { }
+
+static unsigned v850e_intc_irq_startup (unsigned irq)
+{
+	v850e_intc_clear_pending_irq (irq);
+	v850e_intc_enable_irq (irq);
+	return 0;
+}
+
+static void v850e_intc_end_irq (unsigned irq)
+{
+	unsigned long psw, temp;
+
+	/* Clear the highest-level bit in the In-service priority register
+	   (ISPR), to allow this interrupt (or another of the same or
+	   lesser priority) to happen again.
+
+	   The `reti' instruction normally does this automatically when the
+	   PSW bits EP and NP are zero, but we can't always rely on reti
+	   being used consistently to return after an interrupt (another
+	   process can be scheduled, for instance, which can delay the
+	   associated reti for a long time, or this process may be being
+	   single-stepped, which uses the `dbret' instruction to return
+	   from the kernel).
+
+	   We also set the PSW EP bit, which prevents reti from also
+	   trying to modify the ISPR itself.  */
+
+	/* Get PSW and disable interrupts.  */
+	asm volatile ("stsr psw, %0; di" : "=r" (psw));
+	/* We don't want to do anything for NMIs (they don't use the ISPR).  */
+	if (! (psw & 0xC0)) {
+		/* Transition to `trap' state, so that an eventual real
+		   reti instruction won't modify the ISPR.  */
+		psw |= 0x40;
+		/* Fake an interrupt return, which automatically clears the
+		   appropriate bit in the ISPR.  */
+		asm volatile ("mov hilo(1f), %0;"
+			      "ldsr %0, eipc; ldsr %1, eipsw;"
+			      "reti;"
+			      "1:"
+			      : "=&r" (temp) : "r" (psw));
+	}
+}
+
+/* Initialize HW_IRQ_TYPES for INTC-controlled irqs described in array
+   INITS (which is terminated by an entry with the name field == 0).  */
+void __init v850e_intc_init_irq_types (struct v850e_intc_irq_init *inits,
+				       struct hw_interrupt_type *hw_irq_types)
+{
+	struct v850e_intc_irq_init *init;
+	for (init = inits; init->name; init++) {
+		unsigned i;
+		struct hw_interrupt_type *hwit = hw_irq_types++;
+
+		hwit->typename = init->name;
+
+		hwit->startup  = v850e_intc_irq_startup;
+		hwit->shutdown = v850e_intc_disable_irq;
+		hwit->enable   = v850e_intc_enable_irq;
+		hwit->disable  = v850e_intc_disable_irq;
+		hwit->ack      = irq_nop;
+		hwit->end      = v850e_intc_end_irq;
+		
+		/* Initialize kernel IRQ infrastructure for this interrupt.  */
+		init_irq_handlers(init->base, init->num, init->interval, hwit);
+
+		/* Set the interrupt priorities.  */
+		for (i = 0; i < init->num; i++) {
+			unsigned irq = init->base + i * init->interval;
+
+			/* If the interrupt is currently enabled (all
+			   interrupts are initially disabled), then
+			   assume whoever enabled it has set things up
+			   properly, and avoid messing with it.  */
+			if (! v850e_intc_irq_enabled (irq))
+				/* This write also (1) disables the
+				   interrupt, and (2) clears any pending
+				   interrupts.  */
+				V850E_INTC_IC (irq)
+					= (V850E_INTC_IC_PR (init->priority)
+					   | V850E_INTC_IC_MK);
+		}
+	}
+}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/v850e_timer_d.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/v850e_timer_d.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/v850e_timer_d.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/v850e_timer_d.c	2003-07-15 19:06:35.000000000 +0900
@@ -0,0 +1,54 @@
+/*
+ * include/asm-v850/v850e_timer_d.c -- `Timer D' component often used
+ *	with V850E CPUs
+ *
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#include <linux/kernel.h>
+
+#include <asm/v850e_utils.h>
+#include <asm/v850e_timer_d.h>
+
+/* Start interval timer TIMER (0-3).  The timer will issue the
+   corresponding INTCMD interrupt RATE times per second.
+   This function does not enable the interrupt.  */
+void v850e_timer_d_configure (unsigned timer, unsigned rate)
+{
+	unsigned divlog2, count;
+
+	/* Calculate params for timer.  */
+	if (! calc_counter_params (
+		    V850E_TIMER_D_BASE_FREQ, rate,
+		    V850E_TIMER_D_TMCD_CS_MIN, V850E_TIMER_D_TMCD_CS_MAX, 16,
+		    &divlog2, &count))
+		printk (KERN_WARNING
+			"Cannot find interval timer %d setting suitable"
+			" for rate of %dHz.\n"
+			"Using rate of %dHz instead.\n",
+			timer, rate,
+			(V850E_TIMER_D_BASE_FREQ >> divlog2) >> 16);
+
+	/* Do the actual hardware timer initialization:  */
+
+	/* Enable timer.  */
+	V850E_TIMER_D_TMCD(timer) = V850E_TIMER_D_TMCD_CAE;
+	/* Set clock divider.  */
+	V850E_TIMER_D_TMCD(timer)
+		= V850E_TIMER_D_TMCD_CAE
+		| V850E_TIMER_D_TMCD_CS(divlog2);
+	/* Set timer compare register.  */
+	V850E_TIMER_D_CMD(timer) = count;
+	/* Start counting.  */
+	V850E_TIMER_D_TMCD(timer)
+		= V850E_TIMER_D_TMCD_CAE
+		| V850E_TIMER_D_TMCD_CS(divlog2)
+		| V850E_TIMER_D_TMCD_CE;
+}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/v850e_utils.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/v850e_utils.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/v850e_utils.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/v850e_utils.c	2003-07-15 19:06:36.000000000 +0900
@@ -0,0 +1,62 @@
+/*
+ * include/asm-v850/v850e_utils.h -- Utility functions associated with
+ *	V850E CPUs
+ *
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#include <asm/v850e_utils.h>
+
+/* Calculate counter clock-divider and count values to attain the
+   desired frequency RATE from the base frequency BASE_FREQ.  The
+   counter is expected to have a clock-divider, which can divide the
+   system cpu clock by a power of two value from MIN_DIVLOG2 to
+   MAX_DIV_LOG2, and a word-size of COUNTER_SIZE bits (the counter
+   counts up and resets whenever it's equal to the compare register,
+   generating an interrupt or whatever when it does so).  The returned
+   values are: *DIVLOG2 -- log2 of the desired clock divider and *COUNT
+   -- the counter compare value to use.  Returns true if it was possible
+   to find a reasonable value, otherwise false (and the other return
+   values will be set to be as good as possible).  */
+int calc_counter_params (unsigned long base_freq,
+			 unsigned long rate,
+			 unsigned min_divlog2, unsigned max_divlog2,
+			 unsigned counter_size,
+			 unsigned *divlog2, unsigned *count)
+{
+	unsigned _divlog2;
+	int ok = 0;
+
+	/* Find the lowest clock divider setting that can represent RATE.  */
+	for (_divlog2 = min_divlog2; _divlog2 <= max_divlog2; _divlog2++) {
+		/* Minimum interrupt rate possible using this divider.  */
+		unsigned min_int_rate
+			= (base_freq >> _divlog2) >> counter_size;
+
+		if (min_int_rate <= rate) {
+			/* This setting is the highest resolution
+			   setting that's slow enough enough to attain
+			   RATE interrupts per second, so use it.  */
+			ok = 1;
+			break;
+		}
+	}
+
+	if (_divlog2 > max_divlog2)
+		/* Can't find correct setting.  */
+		_divlog2 = max_divlog2;
+
+	if (divlog2)
+		*divlog2 = _divlog2;
+	if (count)
+		*count = ((base_freq >> _divlog2) + rate/2) / rate;
+
+	return ok;
+}
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/anna.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/anna.h
--- linux-2.6.0-test1-moo/include/asm-v850/anna.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/anna.h	2003-07-17 20:25:27.000000000 +0900
@@ -145,16 +122,16 @@
 
 
 /* Timer C details.  */
-#define NB85E_TIMER_C_BASE_ADDR		0xFFFFF600
+#define V850E_TIMER_C_BASE_ADDR		0xFFFFF600
 
 /* Timer D details (the Anna actually has 5 of these; should change later). */
-#define NB85E_TIMER_D_BASE_ADDR		0xFFFFF540
-#define NB85E_TIMER_D_TMD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x0)
-#define NB85E_TIMER_D_CMD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x2)
-#define NB85E_TIMER_D_TMCD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x4)
+#define V850E_TIMER_D_BASE_ADDR		0xFFFFF540
+#define V850E_TIMER_D_TMD_BASE_ADDR 	(V850E_TIMER_D_BASE_ADDR + 0x0)
+#define V850E_TIMER_D_CMD_BASE_ADDR 	(V850E_TIMER_D_BASE_ADDR + 0x2)
+#define V850E_TIMER_D_TMCD_BASE_ADDR 	(V850E_TIMER_D_BASE_ADDR + 0x4)
 
-#define NB85E_TIMER_D_BASE_FREQ		SYS_CLOCK_FREQ
-#define NB85E_TIMER_D_TMCD_CS_MIN	1 /* min 2^1 divider */
+#define V850E_TIMER_D_BASE_FREQ		SYS_CLOCK_FREQ
+#define V850E_TIMER_D_TMCD_CS_MIN	1 /* min 2^1 divider */
 
 
 /* For <asm/param.h> */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/as85ep1.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/as85ep1.h
--- linux-2.6.0-test1-moo/include/asm-v850/as85ep1.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/as85ep1.h	2003-07-17 20:25:27.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/as85ep1.h -- AS85EP1 evaluation CPU chip/board
  *
- *  Copyright (C) 2001,2002  NEC Corporation
- *  Copyright (C) 2001,2002  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -139,16 +137,16 @@
 
 
 /* Timer C details.  */
-#define NB85E_TIMER_C_BASE_ADDR		0xFFFFF600
+#define V850E_TIMER_C_BASE_ADDR		0xFFFFF600
 
 /* Timer D details (the AS85EP1 actually has 5 of these; should change later). */
-#define NB85E_TIMER_D_BASE_ADDR		0xFFFFF540
-#define NB85E_TIMER_D_TMD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x0)
-#define NB85E_TIMER_D_CMD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x2)
-#define NB85E_TIMER_D_TMCD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x4)
+#define V850E_TIMER_D_BASE_ADDR		0xFFFFF540
+#define V850E_TIMER_D_TMD_BASE_ADDR 	(V850E_TIMER_D_BASE_ADDR + 0x0)
+#define V850E_TIMER_D_CMD_BASE_ADDR 	(V850E_TIMER_D_BASE_ADDR + 0x2)
+#define V850E_TIMER_D_TMCD_BASE_ADDR 	(V850E_TIMER_D_BASE_ADDR + 0x4)
 
-#define NB85E_TIMER_D_BASE_FREQ		SYS_CLOCK_FREQ
-#define NB85E_TIMER_D_TMCD_CS_MIN	2 /* min 2^2 divider */
+#define V850E_TIMER_D_BASE_FREQ		SYS_CLOCK_FREQ
+#define V850E_TIMER_D_TMCD_CS_MIN	2 /* min 2^2 divider */
 
 
 /* For <asm/param.h> */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/fpga85e2c.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/fpga85e2c.h
--- linux-2.6.0-test1-moo/include/asm-v850/fpga85e2c.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/fpga85e2c.h	2003-07-17 20:25:27.000000000 +0900
@@ -2,8 +2,8 @@
  * include/asm-v850/fpga85e2c.h -- Machine-dependent defs for
  *	FPGA implementation of V850E2/NA85E2C
  *
- *  Copyright (C) 2002  NEC Corporation
- *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2002,03  NEC Electronics Corporation
+ *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/highres_timer.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/highres_timer.h
--- linux-2.6.0-test1-moo/include/asm-v850/highres_timer.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/highres_timer.h	2003-07-15 19:06:37.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/highres_timer.h -- High resolution timing routines
  *
- *  Copyright (C) 2001  NEC Corporation
- *  Copyright (C) 2001  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -25,7 +25,7 @@
    counter overflows).  */
 #define HIGHRES_TIMER_SLOW_TICK_RATE	25
 
-/* Which timer in the nb85e `Timer D' we use.  */
+/* Which timer in the V850E `Timer D' we use.  */
 #define HIGHRES_TIMER_TIMER_D_UNIT	3
 
 
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/ma.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/ma.h
--- linux-2.6.0-test1-moo/include/asm-v850/ma.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/ma.h	2003-07-15 19:06:37.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/ma.h -- V850E/MA series of cpu chips
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -14,9 +14,8 @@
 #ifndef __V850_MA_H__
 #define __V850_MA_H__
 
-
-/* The MA series uses the NB85E cpu core.  */
-#include <asm/nb85e.h>
+/* The MA series uses the V850E cpu core.  */
+#include <asm/v850e.h>
 
 
 /* For <asm/entry.h> */
@@ -39,16 +38,16 @@
 
 
 /* MA series timer C details.  */
-#define NB85E_TIMER_C_BASE_ADDR		0xFFFFF600
+#define V850E_TIMER_C_BASE_ADDR		0xFFFFF600
 
 
 /* MA series timer D details.  */
-#define NB85E_TIMER_D_BASE_ADDR		0xFFFFF540
-#define NB85E_TIMER_D_TMD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x0)
-#define NB85E_TIMER_D_CMD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x2)
-#define NB85E_TIMER_D_TMCD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x4)
+#define V850E_TIMER_D_BASE_ADDR		0xFFFFF540
+#define V850E_TIMER_D_TMD_BASE_ADDR 	(V850E_TIMER_D_BASE_ADDR + 0x0)
+#define V850E_TIMER_D_CMD_BASE_ADDR 	(V850E_TIMER_D_BASE_ADDR + 0x2)
+#define V850E_TIMER_D_TMCD_BASE_ADDR 	(V850E_TIMER_D_BASE_ADDR + 0x4)
 
-#define NB85E_TIMER_D_BASE_FREQ		CPU_CLOCK_FREQ
+#define V850E_TIMER_D_BASE_FREQ		CPU_CLOCK_FREQ
 
 
 /* Port 0 */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/nb85e.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e.h
--- linux-2.6.0-test1-moo/include/asm-v850/nb85e.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,21 +0,0 @@
-/*
- * include/asm-v850/nb85e.h -- NB85E cpu core
- *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-#ifndef __V850_NB85E_H__
-#define __V850_NB85E_H__
-
-#include <asm/nb85e_intc.h>
-
-#define CPU_ARCH "v850e"
-
-#endif /* __V850_NB85E_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/nb85e_intc.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e_intc.h
--- linux-2.6.0-test1-moo/include/asm-v850/nb85e_intc.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e_intc.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,133 +0,0 @@
-/*
- * include/asm-v850/nb85e_intc.h -- NB85E cpu core interrupt controller (INTC)
- *
- *  Copyright (C) 2001,02,03  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-#ifndef __V850_NB85E_INTC_H__
-#define __V850_NB85E_INTC_H__
-
-
-/* There are 4 16-bit `Interrupt Mask Registers' located contiguously
-   starting from this base.  Each interrupt uses a single bit to
-   indicated enabled/disabled status.  */
-#define NB85E_INTC_IMR_BASE_ADDR  0xFFFFF100
-#define NB85E_INTC_IMR_ADDR(irq)  (NB85E_INTC_IMR_BASE_ADDR + ((irq) >> 3))
-#define NB85E_INTC_IMR_BIT(irq)	  ((irq) & 0x7)
-
-/* Each maskable interrupt has a single-byte control register at this
-   address.  */
-#define NB85E_INTC_IC_BASE_ADDR	  0xFFFFF110
-#define NB85E_INTC_IC_ADDR(irq)	  (NB85E_INTC_IC_BASE_ADDR + ((irq) << 1))
-#define NB85E_INTC_IC(irq)	  (*(volatile u8 *)NB85E_INTC_IC_ADDR(irq))
-/* Encode priority PR for storing in an interrupt control register.  */
-#define NB85E_INTC_IC_PR(pr)	  (pr)
-/* Interrupt disable bit in an interrupt control register.  */
-#define NB85E_INTC_IC_MK_BIT	  6
-#define NB85E_INTC_IC_MK	  (1 << NB85E_INTC_IC_MK_BIT)
-/* Interrupt pending flag in an interrupt control register.  */
-#define NB85E_INTC_IC_IF_BIT	  7
-#define NB85E_INTC_IC_IF	  (1 << NB85E_INTC_IC_IF_BIT)
-
-/* The ISPR (In-service priority register) contains one bit for each interrupt
-   priority level, which is set to one when that level is currently being
-   serviced (and thus blocking any interrupts of equal or lesser level).  */
-#define NB85E_INTC_ISPR_ADDR	  0xFFFFF1FA
-#define NB85E_INTC_ISPR		  (*(volatile u8 *)NB85E_INTC_ISPR_ADDR)
-
-
-#ifndef __ASSEMBLY__
-
-/* Enable interrupt handling for interrupt IRQ.  */
-static inline void nb85e_intc_enable_irq (unsigned irq)
-{
-	__asm__ __volatile__ ("clr1 %0, [%1]"
-			      :: "r" (NB85E_INTC_IMR_BIT (irq)),
-			         "r" (NB85E_INTC_IMR_ADDR (irq))
-			      : "memory");
-}
-
-/* Disable interrupt handling for interrupt IRQ.  Note that any
-   interrupts received while disabled will be delivered once the
-   interrupt is enabled again, unless they are explicitly cleared using
-   `nb85e_intc_clear_pending_irq'.  */
-static inline void nb85e_intc_disable_irq (unsigned irq)
-{
-	__asm__ __volatile__ ("set1 %0, [%1]"
-			      :: "r" (NB85E_INTC_IMR_BIT (irq)),
-			         "r" (NB85E_INTC_IMR_ADDR (irq))
-			      : "memory");
-}
-
-/* Return true if interrupt handling for interrupt IRQ is enabled.  */
-static inline int nb85e_intc_irq_enabled (unsigned irq)
-{
-	int rval;
-	__asm__ __volatile__ ("tst1 %1, [%2]; setf z, %0"
-			      : "=r" (rval)
-			      : "r" (NB85E_INTC_IMR_BIT (irq)),
-			        "r" (NB85E_INTC_IMR_ADDR (irq)));
-	return rval;
-}
-
-/* Disable irqs from 0 until LIMIT.  LIMIT must be a multiple of 8.  */
-static inline void _nb85e_intc_disable_irqs (unsigned limit)
-{
-	unsigned long addr;
-	for (addr = NB85E_INTC_IMR_BASE_ADDR; limit >= 8; addr++, limit -= 8)
-		*(char *)addr = 0xFF;
-}
-
-/* Disable all irqs.  This is purposely a macro, because NUM_MACH_IRQS
-   will be only be defined later.  */
-#define nb85e_intc_disable_irqs()   _nb85e_intc_disable_irqs (NUM_MACH_IRQS)
-
-/* Clear any pending interrupts for IRQ.  */
-static inline void nb85e_intc_clear_pending_irq (unsigned irq)
-{
-	__asm__ __volatile__ ("clr1 %0, 0[%1]"
-			      :: "i" (NB85E_INTC_IC_IF_BIT),
-			         "r" (NB85E_INTC_IC_ADDR (irq))
-			      : "memory");
-}
-
-/* Return true if interrupt IRQ is pending (but disabled).  */
-static inline int nb85e_intc_irq_pending (unsigned irq)
-{
-	int rval;
-	__asm__ __volatile__ ("tst1 %1, 0[%2]; setf nz, %0"
-			      : "=r" (rval)
-			      : "i" (NB85E_INTC_IC_IF_BIT),
-			        "r" (NB85E_INTC_IC_ADDR (irq)));
-	return rval;
-}
-
-
-struct nb85e_intc_irq_init {
-	const char *name;	/* name of interrupt type */
-
-	/* Range of kernel irq numbers for this type:
-	   BASE, BASE+INTERVAL, ..., BASE+INTERVAL*NUM  */
-	unsigned base, num, interval;
-
-	unsigned priority;	/* interrupt priority to assign */
-};
-struct hw_interrupt_type;	/* fwd decl */
-
-/* Initialize HW_IRQ_TYPES for INTC-controlled irqs described in array
-   INITS (which is terminated by an entry with the name field == 0).  */
-extern void nb85e_intc_init_irq_types (struct nb85e_intc_irq_init *inits,
-				       struct hw_interrupt_type *hw_irq_types);
-
-
-#endif /* !__ASSEMBLY__ */
-
-
-#endif /* __V850_NB85E_INTC_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/nb85e_timer_c.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e_timer_c.h
--- linux-2.6.0-test1-moo/include/asm-v850/nb85e_timer_c.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e_timer_c.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,48 +0,0 @@
-/*
- * include/asm-v850/nb85e_timer_c.h -- `Timer C' component often used
- *	with the NB85E cpu core
- *
- *  Copyright (C) 2001  NEC Corporation
- *  Copyright (C) 2001  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-/* NOTE: this include file currently contains only enough to allow us to
-   use timer C as an interrupt pass-through.  */
-
-#ifndef __V850_NB85E_TIMER_C_H__
-#define __V850_NB85E_TIMER_C_H__
-
-#include <asm/types.h>
-#include <asm/machdep.h>	/* Pick up chip-specific defs.  */
-
-
-/* Timer C (16-bit interval timers).  */
-
-/* Control register 0 for timer C.  */
-#define NB85E_TIMER_C_TMCC0_ADDR(n) (NB85E_TIMER_C_BASE_ADDR + 0x6 + 0x10 *(n))
-#define NB85E_TIMER_C_TMCC0(n)	  (*(volatile u8 *)NB85E_TIMER_C_TMCC0_ADDR(n))
-#define NB85E_TIMER_C_TMCC0_CAE	  0x01 /* clock action enable */
-#define NB85E_TIMER_C_TMCC0_CE	  0x02 /* count enable */
-/* ... */
-
-/* Control register 1 for timer C.  */
-#define NB85E_TIMER_C_TMCC1_ADDR(n) (NB85E_TIMER_C_BASE_ADDR + 0x8 + 0x10 *(n))
-#define NB85E_TIMER_C_TMCC1(n)	  (*(volatile u8 *)NB85E_TIMER_C_TMCC1_ADDR(n))
-#define NB85E_TIMER_C_TMCC1_CMS0  0x01 /* capture/compare mode select (ccc0) */
-#define NB85E_TIMER_C_TMCC1_CMS1  0x02 /* capture/compare mode select (ccc1) */
-/* ... */
-
-/* Interrupt edge-sensitivity control for timer C.  */
-#define NB85E_TIMER_C_SESC_ADDR(n) (NB85E_TIMER_C_BASE_ADDR + 0x9 + 0x10 *(n))
-#define NB85E_TIMER_C_SESC(n)	  (*(volatile u8 *)NB85E_TIMER_C_SESC_ADDR(n))
-
-/* ...etc... */
-
-
-#endif /* __V850_NB85E_TIMER_C_H__  */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/nb85e_timer_d.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e_timer_d.h
--- linux-2.6.0-test1-moo/include/asm-v850/nb85e_timer_d.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e_timer_d.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,62 +0,0 @@
-/*
- * include/asm-v850/nb85e_timer_d.h -- `Timer D' component often used
- *	with the NB85E cpu core
- *
- *  Copyright (C) 2001,02,03  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-#ifndef __V850_NB85E_TIMER_D_H__
-#define __V850_NB85E_TIMER_D_H__
-
-#include <asm/types.h>
-#include <asm/machdep.h>	/* Pick up chip-specific defs.  */
-
-
-/* Timer D (16-bit interval timers).  */
-
-/* Count registers for timer D.  */
-#define NB85E_TIMER_D_TMD_ADDR(n) (NB85E_TIMER_D_TMD_BASE_ADDR + 0x10 * (n))
-#define NB85E_TIMER_D_TMD(n)	  (*(volatile u16 *)NB85E_TIMER_D_TMD_ADDR(n))
-
-/* Count compare registers for timer D.  */
-#define NB85E_TIMER_D_CMD_ADDR(n) (NB85E_TIMER_D_CMD_BASE_ADDR + 0x10 * (n))
-#define NB85E_TIMER_D_CMD(n)	  (*(volatile u16 *)NB85E_TIMER_D_CMD_ADDR(n))
-
-/* Control registers for timer D.  */
-#define NB85E_TIMER_D_TMCD_ADDR(n) (NB85E_TIMER_D_TMCD_BASE_ADDR + 0x10 * (n))
-#define NB85E_TIMER_D_TMCD(n)	   (*(volatile u8 *)NB85E_TIMER_D_TMCD_ADDR(n))
-/* Control bits for timer D.  */
-#define NB85E_TIMER_D_TMCD_CE  	   0x2 /* count enable */
-#define NB85E_TIMER_D_TMCD_CAE	   0x1 /* clock action enable */
-/* Clock divider setting (log2).  */
-#define NB85E_TIMER_D_TMCD_CS(divlog2) (((divlog2) - NB85E_TIMER_D_TMCD_CS_MIN) << 4)
-/* Minimum clock divider setting (log2).  */
-#ifndef NB85E_TIMER_D_TMCD_CS_MIN /* Can be overridden by mach-specific hdrs */
-#define NB85E_TIMER_D_TMCD_CS_MIN  2 /* Default is correct for the v850e/ma1 */
-#endif
-/* Maximum clock divider setting (log2).  */
-#define NB85E_TIMER_D_TMCD_CS_MAX  (NB85E_TIMER_D_TMCD_CS_MIN + 7)
-
-/* Return the clock-divider (log2) of timer D unit N.  */
-#define NB85E_TIMER_D_DIVLOG2(n) \
-  (((NB85E_TIMER_D_TMCD(n) >> 4) & 0x7) + NB85E_TIMER_D_TMCD_CS_MIN)
-
-
-#ifndef __ASSEMBLY__
-
-/* Start interval timer TIMER (0-3).  The timer will issue the
-   corresponding INTCMD interrupt RATE times per second.  This function
-   does not enable the interrupt.  */
-extern void nb85e_timer_d_configure (unsigned timer, unsigned rate);
-
-#endif /* !__ASSEMBLY__ */
-
-
-#endif /* __V850_NB85E_TIMER_D_H__  */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/nb85e_utils.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e_utils.h
--- linux-2.6.0-test1-moo/include/asm-v850/nb85e_utils.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e_utils.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,35 +0,0 @@
-/*
- * include/asm-v850/nb85e_utils.h -- Utility functions associated with
- *	the NB85E cpu core
- *
- *  Copyright (C) 2001  NEC Corporation
- *  Copyright (C) 2001  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-#ifndef __V850_NB85E_UTILS_H__
-#define __V850_NB85E_UTILS_H__
-
-/* Calculate counter clock-divider and count values to attain the
-   desired frequency RATE from the base frequency BASE_FREQ.  The
-   counter is expected to have a clock-divider, which can divide the
-   system cpu clock by a power of two value from MIN_DIVLOG2 to
-   MAX_DIV_LOG2, and a word-size of COUNTER_SIZE bits (the counter
-   counts up and resets whenever it's equal to the compare register,
-   generating an interrupt or whatever when it does so).  The returned
-   values are: *DIVLOG2 -- log2 of the desired clock divider and *COUNT
-   -- the counter compare value to use.  Returns true if it was possible
-   to find a reasonable value, otherwise false (and the other return
-   values will be set to be as good as possible).  */
-extern int calc_counter_params (unsigned long base_freq,
-				unsigned long rate,
-				unsigned min_divlog2, unsigned max_divlog2,
-				unsigned counter_size,
-				unsigned *divlog2, unsigned *count);
-
-#endif /* __V850_NB85E_UTILS_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/rte_nb85e_cb.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/rte_nb85e_cb.h
--- linux-2.6.0-test1-moo/include/asm-v850/rte_nb85e_cb.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/rte_nb85e_cb.h	2003-07-15 19:06:37.000000000 +0900
@@ -17,6 +17,21 @@
 #include <asm/rte_cb.h>		/* Common defs for Midas RTE-CB boards.  */
 
 
+#define PLATFORM		"rte-v850e/nb85e-cb"
+#define PLATFORM_LONG		"Midas lab RTE-V850E/NB85E-CB"
+
+#define CPU_CLOCK_FREQ		50000000 /* 50MHz */
+
+/* 1MB of onboard SRAM.  Note that the monitor ROM uses parts of this
+   for its own purposes, so care must be taken.  */
+#define SRAM_ADDR		0x03C00000
+#define SRAM_SIZE		0x00100000 /* 1MB */
+
+/* 16MB of onbard SDRAM.  */
+#define SDRAM_ADDR		0x01000000
+#define SDRAM_SIZE		0x01000000 /* 16MB */
+
+
 /* CPU addresses of GBUS memory spaces.  */
 #define GCS0_ADDR		0x00400000 /* GCS0 - Common SRAM (2MB) */
 #define GCS0_SIZE		0x00400000 /*   4MB */
@@ -39,20 +54,8 @@
 #define IRQ_GINT(n)		(10 + (n))
 #define IRQ_GINT_NUM		3
 
-
-#define PLATFORM	"rte-v850e/nb85e-cb"
-#define PLATFORM_LONG	"Midas lab RTE-V850E/NB85E-CB"
-
-#define CPU_CLOCK_FREQ	50000000 /* 50MHz */
-
-/* 1MB of onboard SRAM.  Note that the monitor ROM uses parts of this
-   for its own purposes, so care must be taken.  */
-#define SRAM_ADDR	0x03C00000
-#define SRAM_SIZE	0x00100000 /* 1MB */
-
-/* 16MB of onbard SDRAM.  */
-#define SDRAM_ADDR	0x01000000
-#define SDRAM_SIZE	0x01000000 /* 16MB */
+/* Used by <asm/rte_cb.h> to derive NUM_MACH_IRQS.  */
+#define NUM_RTE_CB_IRQS		NUM_CPU_IRQS
 
 
 #ifdef CONFIG_ROM_KERNEL
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/teg.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/teg.h
--- linux-2.6.0-test1-moo/include/asm-v850/teg.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/teg.h	2003-07-15 19:06:37.000000000 +0900
@@ -15,9 +15,9 @@
 #define __V850_TEG_H__
 
 
-/* The TEG uses the NB85E cpu core.  */
-#include <asm/nb85e.h>
-#include <asm/nb85e_cache.h>
+/* The TEG uses the V850E cpu core.  */
+#include <asm/v850e.h>
+#include <asm/v850e_cache.h>
 
 
 #define CPU_MODEL	"v850e/nb85e-teg"
@@ -70,15 +70,15 @@
 
 
 /* The TEG RTPU.  */
-#define NB85E_RTPU_BASE_ADDR		0xFFFFF210
+#define V850E_RTPU_BASE_ADDR		0xFFFFF210
 
 
 /* TEG series timer D details.  */
-#define NB85E_TIMER_D_BASE_ADDR		0xFFFFF210
-#define NB85E_TIMER_D_TMCD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x0)
-#define NB85E_TIMER_D_TMD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x4)
-#define NB85E_TIMER_D_CMD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x8)
-#define NB85E_TIMER_D_BASE_FREQ		CPU_CLOCK_FREQ
+#define V850E_TIMER_D_BASE_ADDR		0xFFFFF210
+#define V850E_TIMER_D_TMCD_BASE_ADDR 	(V850E_TIMER_D_BASE_ADDR + 0x0)
+#define V850E_TIMER_D_TMD_BASE_ADDR 	(V850E_TIMER_D_BASE_ADDR + 0x4)
+#define V850E_TIMER_D_CMD_BASE_ADDR 	(V850E_TIMER_D_BASE_ADDR + 0x8)
+#define V850E_TIMER_D_BASE_FREQ		CPU_CLOCK_FREQ
 
 
 /* `Interrupt Source Select' control register.  */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/v850e.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e.h
--- linux-2.6.0-test1-moo/include/asm-v850/v850e.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e.h	2003-07-15 19:06:36.000000000 +0900
@@ -0,0 +1,21 @@
+/*
+ * include/asm-v850/v850e.h -- V850E CPU
+ *
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#ifndef __V850_V850E_H__
+#define __V850_V850E_H__
+
+#include <asm/v850e_intc.h>
+
+#define CPU_ARCH "v850e"
+
+#endif /* __V850_V850E_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/v850e_intc.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_intc.h
--- linux-2.6.0-test1-moo/include/asm-v850/v850e_intc.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_intc.h	2003-07-15 19:06:36.000000000 +0900
@@ -0,0 +1,133 @@
+/*
+ * include/asm-v850/v850e_intc.h -- V850E CPU interrupt controller (INTC)
+ *
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#ifndef __V850_V850E_INTC_H__
+#define __V850_V850E_INTC_H__
+
+
+/* There are 4 16-bit `Interrupt Mask Registers' located contiguously
+   starting from this base.  Each interrupt uses a single bit to
+   indicated enabled/disabled status.  */
+#define V850E_INTC_IMR_BASE_ADDR  0xFFFFF100
+#define V850E_INTC_IMR_ADDR(irq)  (V850E_INTC_IMR_BASE_ADDR + ((irq) >> 3))
+#define V850E_INTC_IMR_BIT(irq)	  ((irq) & 0x7)
+
+/* Each maskable interrupt has a single-byte control register at this
+   address.  */
+#define V850E_INTC_IC_BASE_ADDR	  0xFFFFF110
+#define V850E_INTC_IC_ADDR(irq)	  (V850E_INTC_IC_BASE_ADDR + ((irq) << 1))
+#define V850E_INTC_IC(irq)	  (*(volatile u8 *)V850E_INTC_IC_ADDR(irq))
+/* Encode priority PR for storing in an interrupt control register.  */
+#define V850E_INTC_IC_PR(pr)	  (pr)
+/* Interrupt disable bit in an interrupt control register.  */
+#define V850E_INTC_IC_MK_BIT	  6
+#define V850E_INTC_IC_MK	  (1 << V850E_INTC_IC_MK_BIT)
+/* Interrupt pending flag in an interrupt control register.  */
+#define V850E_INTC_IC_IF_BIT	  7
+#define V850E_INTC_IC_IF	  (1 << V850E_INTC_IC_IF_BIT)
+
+/* The ISPR (In-service priority register) contains one bit for each interrupt
+   priority level, which is set to one when that level is currently being
+   serviced (and thus blocking any interrupts of equal or lesser level).  */
+#define V850E_INTC_ISPR_ADDR	  0xFFFFF1FA
+#define V850E_INTC_ISPR		  (*(volatile u8 *)V850E_INTC_ISPR_ADDR)
+
+
+#ifndef __ASSEMBLY__
+
+/* Enable interrupt handling for interrupt IRQ.  */
+static inline void v850e_intc_enable_irq (unsigned irq)
+{
+	__asm__ __volatile__ ("clr1 %0, [%1]"
+			      :: "r" (V850E_INTC_IMR_BIT (irq)),
+			         "r" (V850E_INTC_IMR_ADDR (irq))
+			      : "memory");
+}
+
+/* Disable interrupt handling for interrupt IRQ.  Note that any
+   interrupts received while disabled will be delivered once the
+   interrupt is enabled again, unless they are explicitly cleared using
+   `v850e_intc_clear_pending_irq'.  */
+static inline void v850e_intc_disable_irq (unsigned irq)
+{
+	__asm__ __volatile__ ("set1 %0, [%1]"
+			      :: "r" (V850E_INTC_IMR_BIT (irq)),
+			         "r" (V850E_INTC_IMR_ADDR (irq))
+			      : "memory");
+}
+
+/* Return true if interrupt handling for interrupt IRQ is enabled.  */
+static inline int v850e_intc_irq_enabled (unsigned irq)
+{
+	int rval;
+	__asm__ __volatile__ ("tst1 %1, [%2]; setf z, %0"
+			      : "=r" (rval)
+			      : "r" (V850E_INTC_IMR_BIT (irq)),
+			        "r" (V850E_INTC_IMR_ADDR (irq)));
+	return rval;
+}
+
+/* Disable irqs from 0 until LIMIT.  LIMIT must be a multiple of 8.  */
+static inline void _v850e_intc_disable_irqs (unsigned limit)
+{
+	unsigned long addr;
+	for (addr = V850E_INTC_IMR_BASE_ADDR; limit >= 8; addr++, limit -= 8)
+		*(char *)addr = 0xFF;
+}
+
+/* Disable all irqs.  This is purposely a macro, because NUM_MACH_IRQS
+   will be only be defined later.  */
+#define v850e_intc_disable_irqs()   _v850e_intc_disable_irqs (NUM_MACH_IRQS)
+
+/* Clear any pending interrupts for IRQ.  */
+static inline void v850e_intc_clear_pending_irq (unsigned irq)
+{
+	__asm__ __volatile__ ("clr1 %0, 0[%1]"
+			      :: "i" (V850E_INTC_IC_IF_BIT),
+			         "r" (V850E_INTC_IC_ADDR (irq))
+			      : "memory");
+}
+
+/* Return true if interrupt IRQ is pending (but disabled).  */
+static inline int v850e_intc_irq_pending (unsigned irq)
+{
+	int rval;
+	__asm__ __volatile__ ("tst1 %1, 0[%2]; setf nz, %0"
+			      : "=r" (rval)
+			      : "i" (V850E_INTC_IC_IF_BIT),
+			        "r" (V850E_INTC_IC_ADDR (irq)));
+	return rval;
+}
+
+
+struct v850e_intc_irq_init {
+	const char *name;	/* name of interrupt type */
+
+	/* Range of kernel irq numbers for this type:
+	   BASE, BASE+INTERVAL, ..., BASE+INTERVAL*NUM  */
+	unsigned base, num, interval;
+
+	unsigned priority;	/* interrupt priority to assign */
+};
+struct hw_interrupt_type;	/* fwd decl */
+
+/* Initialize HW_IRQ_TYPES for INTC-controlled irqs described in array
+   INITS (which is terminated by an entry with the name field == 0).  */
+extern void v850e_intc_init_irq_types (struct v850e_intc_irq_init *inits,
+				       struct hw_interrupt_type *hw_irq_types);
+
+
+#endif /* !__ASSEMBLY__ */
+
+
+#endif /* __V850_V850E_INTC_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/v850e_timer_c.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_timer_c.h
--- linux-2.6.0-test1-moo/include/asm-v850/v850e_timer_c.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_timer_c.h	2003-07-15 19:06:36.000000000 +0900
@@ -0,0 +1,48 @@
+/*
+ * include/asm-v850/v850e_timer_c.h -- `Timer C' component often used
+ *	with the V850E cpu core
+ *
+ *  Copyright (C) 2001,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+/* NOTE: this include file currently contains only enough to allow us to
+   use timer C as an interrupt pass-through.  */
+
+#ifndef __V850_V850E_TIMER_C_H__
+#define __V850_V850E_TIMER_C_H__
+
+#include <asm/types.h>
+#include <asm/machdep.h>	/* Pick up chip-specific defs.  */
+
+
+/* Timer C (16-bit interval timers).  */
+
+/* Control register 0 for timer C.  */
+#define V850E_TIMER_C_TMCC0_ADDR(n) (V850E_TIMER_C_BASE_ADDR + 0x6 + 0x10 *(n))
+#define V850E_TIMER_C_TMCC0(n)	  (*(volatile u8 *)V850E_TIMER_C_TMCC0_ADDR(n))
+#define V850E_TIMER_C_TMCC0_CAE	  0x01 /* clock action enable */
+#define V850E_TIMER_C_TMCC0_CE	  0x02 /* count enable */
+/* ... */
+
+/* Control register 1 for timer C.  */
+#define V850E_TIMER_C_TMCC1_ADDR(n) (V850E_TIMER_C_BASE_ADDR + 0x8 + 0x10 *(n))
+#define V850E_TIMER_C_TMCC1(n)	  (*(volatile u8 *)V850E_TIMER_C_TMCC1_ADDR(n))
+#define V850E_TIMER_C_TMCC1_CMS0  0x01 /* capture/compare mode select (ccc0) */
+#define V850E_TIMER_C_TMCC1_CMS1  0x02 /* capture/compare mode select (ccc1) */
+/* ... */
+
+/* Interrupt edge-sensitivity control for timer C.  */
+#define V850E_TIMER_C_SESC_ADDR(n) (V850E_TIMER_C_BASE_ADDR + 0x9 + 0x10 *(n))
+#define V850E_TIMER_C_SESC(n)	  (*(volatile u8 *)V850E_TIMER_C_SESC_ADDR(n))
+
+/* ...etc... */
+
+
+#endif /* __V850_V850E_TIMER_C_H__  */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/v850e_timer_d.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_timer_d.h
--- linux-2.6.0-test1-moo/include/asm-v850/v850e_timer_d.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_timer_d.h	2003-07-15 19:06:36.000000000 +0900
@@ -0,0 +1,62 @@
+/*
+ * include/asm-v850/v850e_timer_d.h -- `Timer D' component often used
+ *	with the V850E cpu core
+ *
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#ifndef __V850_V850E_TIMER_D_H__
+#define __V850_V850E_TIMER_D_H__
+
+#include <asm/types.h>
+#include <asm/machdep.h>	/* Pick up chip-specific defs.  */
+
+
+/* Timer D (16-bit interval timers).  */
+
+/* Count registers for timer D.  */
+#define V850E_TIMER_D_TMD_ADDR(n) (V850E_TIMER_D_TMD_BASE_ADDR + 0x10 * (n))
+#define V850E_TIMER_D_TMD(n)	  (*(volatile u16 *)V850E_TIMER_D_TMD_ADDR(n))
+
+/* Count compare registers for timer D.  */
+#define V850E_TIMER_D_CMD_ADDR(n) (V850E_TIMER_D_CMD_BASE_ADDR + 0x10 * (n))
+#define V850E_TIMER_D_CMD(n)	  (*(volatile u16 *)V850E_TIMER_D_CMD_ADDR(n))
+
+/* Control registers for timer D.  */
+#define V850E_TIMER_D_TMCD_ADDR(n) (V850E_TIMER_D_TMCD_BASE_ADDR + 0x10 * (n))
+#define V850E_TIMER_D_TMCD(n)	   (*(volatile u8 *)V850E_TIMER_D_TMCD_ADDR(n))
+/* Control bits for timer D.  */
+#define V850E_TIMER_D_TMCD_CE  	   0x2 /* count enable */
+#define V850E_TIMER_D_TMCD_CAE	   0x1 /* clock action enable */
+/* Clock divider setting (log2).  */
+#define V850E_TIMER_D_TMCD_CS(divlog2) (((divlog2) - V850E_TIMER_D_TMCD_CS_MIN) << 4)
+/* Minimum clock divider setting (log2).  */
+#ifndef V850E_TIMER_D_TMCD_CS_MIN /* Can be overridden by mach-specific hdrs */
+#define V850E_TIMER_D_TMCD_CS_MIN  2 /* Default is correct for the v850e/ma1 */
+#endif
+/* Maximum clock divider setting (log2).  */
+#define V850E_TIMER_D_TMCD_CS_MAX  (V850E_TIMER_D_TMCD_CS_MIN + 7)
+
+/* Return the clock-divider (log2) of timer D unit N.  */
+#define V850E_TIMER_D_DIVLOG2(n) \
+  (((V850E_TIMER_D_TMCD(n) >> 4) & 0x7) + V850E_TIMER_D_TMCD_CS_MIN)
+
+
+#ifndef __ASSEMBLY__
+
+/* Start interval timer TIMER (0-3).  The timer will issue the
+   corresponding INTCMD interrupt RATE times per second.  This function
+   does not enable the interrupt.  */
+extern void v850e_timer_d_configure (unsigned timer, unsigned rate);
+
+#endif /* !__ASSEMBLY__ */
+
+
+#endif /* __V850_V850E_TIMER_D_H__  */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/v850e_utils.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_utils.h
--- linux-2.6.0-test1-moo/include/asm-v850/v850e_utils.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_utils.h	2003-07-15 19:06:36.000000000 +0900
@@ -0,0 +1,35 @@
+/*
+ * include/asm-v850/v850e_utils.h -- Utility functions associated with
+ *	V850E CPUs
+ *
+ *  Copyright (C) 2001,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#ifndef __V850_V850E_UTILS_H__
+#define __V850_V850E_UTILS_H__
+
+/* Calculate counter clock-divider and count values to attain the
+   desired frequency RATE from the base frequency BASE_FREQ.  The
+   counter is expected to have a clock-divider, which can divide the
+   system cpu clock by a power of two value from MIN_DIVLOG2 to
+   MAX_DIV_LOG2, and a word-size of COUNTER_SIZE bits (the counter
+   counts up and resets whenever it's equal to the compare register,
+   generating an interrupt or whatever when it does so).  The returned
+   values are: *DIVLOG2 -- log2 of the desired clock divider and *COUNT
+   -- the counter compare value to use.  Returns true if it was possible
+   to find a reasonable value, otherwise false (and the other return
+   values will be set to be as good as possible).  */
+extern int calc_counter_params (unsigned long base_freq,
+				unsigned long rate,
+				unsigned min_divlog2, unsigned max_divlog2,
+				unsigned counter_size,
+				unsigned *divlog2, unsigned *count);
+
+#endif /* __V850_V850E_UTILS_H__ */
