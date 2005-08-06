Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263234AbVHFQPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbVHFQPm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 12:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbVHFQPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 12:15:41 -0400
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:37206 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263234AbVHFQPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 12:15:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Disposition:Message-Id:Cc:Content-Type:Content-Transfer-Encoding;
  b=J7P6SoPe9gPiYvFkFqqgS0ViUXoTAlg5e82S1RUE58GBEDnX6NhnzO75ytKJNU3FJqVXT1L2UEsqlStXYRvyQmjraBXcy9jfvVIA3exVR22gCWeP8ltpM1semI+Lai7Gl2xUXrjeCkJB0de+KoPksnYEvakO6mhtbxf+LKejMhk=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] ARCH_HAS_IRQ_PER_CPU avoids dead code in __do_IRQ()
Date: Sat, 6 Aug 2005 18:14:31 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508061814.31719.annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

from the bitkeeper logs I found you made the last
global-arch-relevant changes in this area.
Please comment or pass it on as appropriate.
Patch is for mainline 2.6.13-rc5.

    Thanks,
    Karsten 

From: Karsten Wiese <annabellesgarden@yahoo.de>

IRQ_PER_CPU is not used by all architectures.
To avoid dead code generation in __do_IRQ()
this patch introduces the macro ARCH_HAS_IRQ_PER_CPU.

ARCH_HAS_IRQ_PER_CPU is defined by architectures using
IRQ_PER_CPU in their
	include/asm_ARCH/irq.h
file.

Through grepping the tree I found the following
architectures currently use IRQ_PER_CPU:

	cris, ia64, ppc, ppc64 and parisc. 

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>



diff -upr linux-2.6.13_orig/include/asm-cris/irq.h linux-2.6.13/include/asm-cris/irq.h
--- linux-2.6.13_orig/include/asm-cris/irq.h	2005-08-06 16:44:41.000000000 +0200
+++ linux-2.6.13/include/asm-cris/irq.h	2005-08-06 18:06:48.000000000 +0200
@@ -1,6 +1,11 @@
 #ifndef _ASM_IRQ_H
 #define _ASM_IRQ_H
 
+/*
+ * IRQ line status macro IRQ_PER_CPU is used
+ */
+#define ARCH_HAS_IRQ_PER_CPU
+
 #include <asm/arch/irq.h>
 
 extern __inline__ int irq_canonicalize(int irq)
diff -upr linux-2.6.13_orig/include/asm-ia64/irq.h linux-2.6.13/include/asm-ia64/irq.h
--- linux-2.6.13_orig/include/asm-ia64/irq.h	2005-08-06 16:47:24.000000000 +0200
+++ linux-2.6.13/include/asm-ia64/irq.h	2005-08-06 18:06:53.000000000 +0200
@@ -14,6 +14,11 @@
 #define NR_IRQS		256
 #define NR_IRQ_VECTORS	NR_IRQS
 
+/*
+ * IRQ line status macro IRQ_PER_CPU is used
+ */
+#define ARCH_HAS_IRQ_PER_CPU
+
 static __inline__ int
 irq_canonicalize (int irq)
 {
diff -upr linux-2.6.13_orig/include/asm-parisc/irq.h linux-2.6.13/include/asm-parisc/irq.h
--- linux-2.6.13_orig/include/asm-parisc/irq.h	2005-08-06 16:50:29.000000000 +0200
+++ linux-2.6.13/include/asm-parisc/irq.h	2005-08-06 18:05:22.000000000 +0200
@@ -26,6 +26,11 @@
 
 #define NR_IRQS		(CPU_IRQ_MAX + 1)
 
+/*
+ * IRQ line status macro IRQ_PER_CPU is used
+ */
+#define ARCH_HAS_IRQ_PER_CPU
+
 static __inline__ int irq_canonicalize(int irq)
 {
 	return (irq == 2) ? 9 : irq;
diff -upr linux-2.6.13_orig/include/asm-ppc/irq.h linux-2.6.13/include/asm-ppc/irq.h
--- linux-2.6.13_orig/include/asm-ppc/irq.h	2005-08-02 13:55:51.000000000 +0200
+++ linux-2.6.13/include/asm-ppc/irq.h	2005-08-06 18:10:19.000000000 +0200
@@ -19,6 +19,11 @@
 #define IRQ_POLARITY_POSITIVE	0x2	/* high level or low->high edge */
 #define IRQ_POLARITY_NEGATIVE	0x0	/* low level or high->low edge */
 
+/*
+ * IRQ line status macro IRQ_PER_CPU is used
+ */
+#define ARCH_HAS_IRQ_PER_CPU
+
 #if defined(CONFIG_40x)
 #include <asm/ibm4xx.h>
 
diff -upr linux-2.6.13_orig/include/asm-ppc64/irq.h linux-2.6.13/include/asm-ppc64/irq.h
--- linux-2.6.13_orig/include/asm-ppc64/irq.h	2005-08-06 16:41:14.000000000 +0200
+++ linux-2.6.13/include/asm-ppc64/irq.h	2005-08-06 18:06:58.000000000 +0200
@@ -33,6 +33,11 @@
 #define IRQ_POLARITY_POSITIVE	0x2	/* high level or low->high edge */
 #define IRQ_POLARITY_NEGATIVE	0x0	/* low level or high->low edge */
 
+/*
+ * IRQ line status macro IRQ_PER_CPU is used
+ */
+#define ARCH_HAS_IRQ_PER_CPU
+
 #define get_irq_desc(irq) (&irq_desc[(irq)])
 
 /* Define a way to iterate across irqs. */
diff -upr linux-2.6.13_orig/include/linux/irq.h linux-2.6.13/include/linux/irq.h
--- linux-2.6.13_orig/include/linux/irq.h	2005-08-06 16:36:14.000000000 +0200
+++ linux-2.6.13/include/linux/irq.h	2005-08-06 16:36:30.000000000 +0200
@@ -32,7 +32,9 @@
 #define IRQ_WAITING	32	/* IRQ not yet seen - for autodetection */
 #define IRQ_LEVEL	64	/* IRQ level triggered */
 #define IRQ_MASKED	128	/* IRQ masked - shouldn't be seen again */
+#if defined(ARCH_HAS_IRQ_PER_CPU)
 #define IRQ_PER_CPU	256	/* IRQ is per CPU */
+#endif
 
 /*
  * Interrupt controller descriptor. This is all we need
diff -upr linux-2.6.13_orig/kernel/irq/handle.c linux-2.6.13/kernel/irq/handle.c
--- linux-2.6.13_orig/kernel/irq/handle.c	2005-08-06 15:53:37.000000000 +0200
+++ linux-2.6.13/kernel/irq/handle.c	2005-08-06 15:19:57.000000000 +0200
@@ -112,6 +112,7 @@ fastcall unsigned int __do_IRQ(unsigned 
 
 	kstat_this_cpu.irqs[irq]++;
 
+#if defined(ARCH_HAS_IRQ_PER_CPU)
 	if (desc->status & IRQ_PER_CPU) {
 		irqreturn_t action_ret;
 
@@ -123,6 +124,7 @@ fastcall unsigned int __do_IRQ(unsigned 
 		desc->handler->end(irq);
 		return 1;
 	}
+#endif
 
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
