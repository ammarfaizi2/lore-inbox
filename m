Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbWGAPCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWGAPCB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbWGAO5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:42 -0400
Received: from www.osadl.org ([213.239.205.134]:29860 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751518AbWGAO5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:00 -0400
Message-Id: <20060701145224.370665000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:30 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>
Subject: [RFC][patch 10/44] M32R: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-m32r.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/m32r/kernel/time.c   |    2 +-
 include/asm-m32r/signal.h |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6.git/include/asm-m32r/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-m32r/signal.h	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/include/asm-m32r/signal.h	2006-07-01 16:51:33.000000000 +0200
@@ -81,7 +81,6 @@ typedef unsigned long sigset_t;
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -101,7 +100,6 @@ typedef unsigned long sigset_t;
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000
 
Index: linux-2.6.git/arch/m32r/kernel/time.c
===================================================================
--- linux-2.6.git.orig/arch/m32r/kernel/time.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/m32r/kernel/time.c	2006-07-01 16:51:33.000000000 +0200
@@ -237,7 +237,7 @@ irqreturn_t timer_interrupt(int irq, voi
 	return IRQ_HANDLED;
 }
 
-struct irqaction irq0 = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE,
+struct irqaction irq0 = { timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE,
 			  "MFT2", NULL, NULL };
 
 void __init time_init(void)

--

