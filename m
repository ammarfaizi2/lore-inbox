Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWGAO6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWGAO6k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbWGAO6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:58:04 -0400
Received: from www.osadl.org ([213.239.205.134]:48804 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751745AbWGAO5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:19 -0400
Message-Id: <20060701145226.112861000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:48 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, joe@tensilica.com
Subject: [RFC][patch 25/44] XTENSA: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-xtensa.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/xtensa/kernel/time.c   |    2 +-
 include/asm-xtensa/signal.h |   15 ---------------
 2 files changed, 1 insertion(+), 16 deletions(-)

Index: linux-2.6.git/include/asm-xtensa/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-xtensa/signal.h	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/include/asm-xtensa/signal.h	2006-07-01 16:51:38.000000000 +0200
@@ -75,7 +75,6 @@ typedef struct {
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -95,7 +94,6 @@ typedef struct {
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000
 
@@ -109,19 +107,6 @@ typedef struct {
 #define SIGSTKSZ	8192
 
 #ifndef __ASSEMBLY__
-#ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#define SA_PROBEIRQ		0x08000000
-#endif
 
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
Index: linux-2.6.git/arch/xtensa/kernel/time.c
===================================================================
--- linux-2.6.git.orig/arch/xtensa/kernel/time.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/arch/xtensa/kernel/time.c	2006-07-01 16:51:38.000000000 +0200
@@ -52,7 +52,7 @@ unsigned long long sched_clock(void)
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static struct irqaction timer_irqaction = {
 	.handler =	timer_interrupt,
-	.flags =	SA_INTERRUPT,
+	.flags =	IRQF_DISABLED,
 	.name =		"timer",
 };
 

--

