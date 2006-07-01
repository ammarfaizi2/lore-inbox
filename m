Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751895AbWGAO5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbWGAO5V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWGAO5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:19 -0400
Received: from www.osadl.org ([213.239.205.134]:33444 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751540AbWGAO5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:06 -0400
Message-Id: <20060701145224.834697000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:35 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, matthew@wil.cx
Subject: [RFC][patch 14/44] PARISC: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-parisc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/parisc/kernel/irq.c    |    4 ++--
 include/asm-parisc/floppy.h |    8 ++++----
 include/asm-parisc/signal.h |    2 --
 3 files changed, 6 insertions(+), 8 deletions(-)

Index: linux-2.6.git/include/asm-parisc/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-parisc/floppy.h	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/include/asm-parisc/floppy.h	2006-07-01 16:51:35.000000000 +0200
@@ -156,11 +156,11 @@ static int vdma_get_dma_residue(unsigned
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
Index: linux-2.6.git/include/asm-parisc/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-parisc/signal.h	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/include/asm-parisc/signal.h	2006-07-01 16:51:35.000000000 +0200
@@ -48,7 +48,6 @@
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -69,7 +68,6 @@
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000 /* obsolete -- ignored */
 
Index: linux-2.6.git/arch/parisc/kernel/irq.c
===================================================================
--- linux-2.6.git.orig/arch/parisc/kernel/irq.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/parisc/kernel/irq.c	2006-07-01 16:51:35.000000000 +0200
@@ -366,14 +366,14 @@ void do_cpu_irq_mask(struct pt_regs *reg
 static struct irqaction timer_action = {
 	.handler = timer_interrupt,
 	.name = "timer",
-	.flags = SA_INTERRUPT,
+	.flags = IRQF_DISABLED,
 };
 
 #ifdef CONFIG_SMP
 static struct irqaction ipi_action = {
 	.handler = ipi_interrupt,
 	.name = "IPI",
-	.flags = SA_INTERRUPT,
+	.flags = IRQF_DISABLED,
 };
 #endif
 

--

