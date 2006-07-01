Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751896AbWGAO6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbWGAO6j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbWGAO6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:58:10 -0400
Received: from www.osadl.org ([213.239.205.134]:48036 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751621AbWGAO5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:18 -0400
Message-Id: <20060701145225.996178000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:47 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, ak@suse.de
Subject: [RFC][patch 24/44] x86_64: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-x86_64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/x86_64/kernel/time.c   |    2 +-
 include/asm-x86_64/floppy.h |    8 ++++----
 include/asm-x86_64/signal.h |    2 --
 3 files changed, 5 insertions(+), 7 deletions(-)

Index: linux-2.6.git/include/asm-x86_64/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-x86_64/floppy.h	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/include/asm-x86_64/floppy.h	2006-07-01 16:51:38.000000000 +0200
@@ -144,11 +144,11 @@ static int vdma_get_dma_residue(unsigned
 static int fd_request_irq(void)
 {
 	if(can_use_virtual_dma)
-		return request_irq(FLOPPY_IRQ, floppy_hardint,SA_INTERRUPT,
-						   "floppy", NULL);
+		return request_irq(FLOPPY_IRQ, floppy_hardint,
+				   IRQF_DISABLED, "floppy", NULL);
 	else
-		return request_irq(FLOPPY_IRQ, floppy_interrupt, SA_INTERRUPT,
-				   "floppy", NULL);
+		return request_irq(FLOPPY_IRQ, floppy_interrupt,
+				   IRQF_DISABLED, "floppy", NULL);
 }
 
 static unsigned long dma_mem_alloc(unsigned long size)
Index: linux-2.6.git/include/asm-x86_64/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-x86_64/signal.h	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/include/asm-x86_64/signal.h	2006-07-01 16:51:38.000000000 +0200
@@ -83,7 +83,6 @@ typedef unsigned long sigset_t;
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -103,7 +102,6 @@ typedef unsigned long sigset_t;
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000
 
Index: linux-2.6.git/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.git.orig/arch/x86_64/kernel/time.c	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/arch/x86_64/kernel/time.c	2006-07-01 16:51:38.000000000 +0200
@@ -889,7 +889,7 @@ int __init time_setup(char *str)
 }
 
 static struct irqaction irq0 = {
-	timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL
+	timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "timer", NULL, NULL
 };
 
 void __init time_init(void)

--

