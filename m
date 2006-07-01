Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751904AbWGAPMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbWGAPMT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbWGAPMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:12:18 -0400
Received: from www.osadl.org ([213.239.205.134]:45476 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751720AbWGAO5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:17 -0400
Message-Id: <20060701145225.877515000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:46 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, uclinux-v850@lsi.nec.co.jp
Subject: [RFC][patch 23/44] V850: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-v850.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/v850/kernel/gbus_int.c   |    2 +-
 arch/v850/kernel/rte_me2_cb.c |    2 +-
 arch/v850/kernel/time.c       |    2 +-
 include/asm-v850/signal.h     |    2 --
 4 files changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6.git/include/asm-v850/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-v850/signal.h	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/include/asm-v850/signal.h	2006-07-01 16:51:38.000000000 +0200
@@ -77,7 +77,6 @@ typedef unsigned long sigset_t;
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -97,7 +96,6 @@ typedef unsigned long sigset_t;
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000
 
Index: linux-2.6.git/arch/v850/kernel/gbus_int.c
===================================================================
--- linux-2.6.git.orig/arch/v850/kernel/gbus_int.c	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/arch/v850/kernel/gbus_int.c	2006-07-01 16:51:38.000000000 +0200
@@ -154,7 +154,7 @@ static unsigned gbus_int_startup_irq (un
 		/* First enable the CPU interrupt.  */
 		int rval =
 			request_irq (IRQ_GINT(gint), gbus_int_handle_irq,
-				     SA_INTERRUPT,
+				     IRQF_DISABLED,
 				     "gbus_int_handler",
 				     &gint_num_active_irqs[gint]);
 		if (rval != 0)
Index: linux-2.6.git/arch/v850/kernel/rte_me2_cb.c
===================================================================
--- linux-2.6.git.orig/arch/v850/kernel/rte_me2_cb.c	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/arch/v850/kernel/rte_me2_cb.c	2006-07-01 16:51:38.000000000 +0200
@@ -263,7 +263,7 @@ static unsigned cb_pic_startup_irq (unsi
 
 	if (cb_pic_active_irqs == 0) {
 		rval = request_irq (IRQ_CB_PIC, cb_pic_handle_irq,
-				    SA_INTERRUPT, "cb_pic_handler", 0);
+				    IRQF_DISABLED, "cb_pic_handler", 0);
 		if (rval != 0)
 			return rval;
 	}
Index: linux-2.6.git/arch/v850/kernel/time.c
===================================================================
--- linux-2.6.git.orig/arch/v850/kernel/time.c	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/arch/v850/kernel/time.c	2006-07-01 16:51:38.000000000 +0200
@@ -177,7 +177,7 @@ EXPORT_SYMBOL(do_settimeofday);
 static int timer_dev_id;
 static struct irqaction timer_irqaction = {
 	timer_interrupt,
-	SA_INTERRUPT,
+	IRQF_DISABLED,
 	CPU_MASK_NONE,
 	"timer",
 	&timer_dev_id,

--

