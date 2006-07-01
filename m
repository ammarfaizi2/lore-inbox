Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbWGAPBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbWGAPBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWGAO5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:47 -0400
Received: from www.osadl.org ([213.239.205.134]:26532 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751462AbWGAO44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:56:56 -0400
Message-Id: <20060701145224.022214000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:27 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, ysato@users.sourceforge.jp
Subject: [RFC][patch 07/44] H8300: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-h8300.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/h8300/kernel/ints.c       |    4 ++--
 arch/h8300/platform/h8s/ints.c |    4 ++--
 include/asm-h8300/signal.h     |    2 --
 3 files changed, 4 insertions(+), 6 deletions(-)

Index: linux-2.6.git/include/asm-h8300/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-h8300/signal.h	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/include/asm-h8300/signal.h	2006-07-01 16:51:32.000000000 +0200
@@ -74,7 +74,6 @@ typedef unsigned long sigset_t;
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -94,7 +93,6 @@ typedef unsigned long sigset_t;
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000
 
Index: linux-2.6.git/arch/h8300/kernel/ints.c
===================================================================
--- linux-2.6.git.orig/arch/h8300/kernel/ints.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/h8300/kernel/ints.c	2006-07-01 16:51:32.000000000 +0200
@@ -158,7 +158,7 @@ int request_irq(unsigned int irq, 
 	irq_handle->devname = devname;
 	irq_list[irq] = irq_handle;
 
-	if (irq_handle->flags & SA_SAMPLE_RANDOM)
+	if (irq_handle->flags & IRQF_SAMPLE_RANDOM)
 		rand_initialize_irq(irq);
 
 	enable_irq(irq);
@@ -222,7 +222,7 @@ asmlinkage void process_int(int irq, str
 		if (irq_list[irq]) {
 			irq_list[irq]->handler(irq, irq_list[irq]->dev_id, fp);
 			irq_list[irq]->count++;
-			if (irq_list[irq]->flags & SA_SAMPLE_RANDOM)
+			if (irq_list[irq]->flags & IRQF_SAMPLE_RANDOM)
 				add_interrupt_randomness(irq);
 		}
 	} else {
Index: linux-2.6.git/arch/h8300/platform/h8s/ints.c
===================================================================
--- linux-2.6.git.orig/arch/h8300/platform/h8s/ints.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/h8300/platform/h8s/ints.c	2006-07-01 16:51:32.000000000 +0200
@@ -192,7 +192,7 @@ int request_irq(unsigned int irq,
 	irq_handle->dev_id  = dev_id;
 	irq_handle->devname = devname;
 	irq_list[irq] = irq_handle;
-	if (irq_handle->flags & SA_SAMPLE_RANDOM)
+	if (irq_handle->flags & IRQF_SAMPLE_RANDOM)
 		rand_initialize_irq(irq);
 	
 	/* enable interrupt */
@@ -270,7 +270,7 @@ asmlinkage void process_int(unsigned lon
 		if (irq_list[vec]) {
 			irq_list[vec]->handler(vec, irq_list[vec]->dev_id, fp);
 			irq_list[vec]->count++;
-			if (irq_list[vec]->flags & SA_SAMPLE_RANDOM)
+			if (irq_list[vec]->flags & IRQF_SAMPLE_RANDOM)
 				add_interrupt_randomness(vec);
 		}
 	} else {

--

