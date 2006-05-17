Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWEQAQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWEQAQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWEQAQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:16:09 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:50844 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932300AbWEQAQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:16:00 -0400
Date: Wed, 17 May 2006 02:15:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 09/50] genirq: cleanup: turn ARCH_HAS_IRQ_PER_CPU into CONFIG_IRQ_PER_CPU
Message-ID: <20060517001549.GJ12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

cleanup: change ARCH_HAS_IRQ_PER_CPU into a Kconfig method.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/cris/Kconfig                |    4 ++++
 arch/ia64/Kconfig                |    4 ++++
 arch/mips/Kconfig                |    5 +++++
 arch/parisc/Kconfig              |    4 ++++
 arch/powerpc/Kconfig             |    4 ++++
 include/asm-cris/irq.h           |    5 -----
 include/asm-ia64/irq.h           |    5 -----
 include/asm-mips/mach-mips/irq.h |    6 ------
 include/asm-parisc/irq.h         |    5 -----
 include/asm-powerpc/irq.h        |    5 -----
 include/linux/irq.h              |    2 +-
 kernel/irq/manage.c              |    4 ++--
 12 files changed, 24 insertions(+), 29 deletions(-)

Index: linux-genirq.q/arch/cris/Kconfig
===================================================================
--- linux-genirq.q.orig/arch/cris/Kconfig
+++ linux-genirq.q/arch/cris/Kconfig
@@ -28,6 +28,10 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
+config IRQ_PER_CPU
+	bool
+	default y
+
 config CRIS
 	bool
 	default y
Index: linux-genirq.q/arch/ia64/Kconfig
===================================================================
--- linux-genirq.q.orig/arch/ia64/Kconfig
+++ linux-genirq.q/arch/ia64/Kconfig
@@ -483,6 +483,10 @@ config GENERIC_PENDING_IRQ
 	depends on GENERIC_HARDIRQS && SMP
 	default y
 
+config IRQ_PER_CPU
+	bool
+	default y
+
 source "arch/ia64/hp/sim/Kconfig"
 
 menu "Instrumentation Support"
Index: linux-genirq.q/arch/mips/Kconfig
===================================================================
--- linux-genirq.q.orig/arch/mips/Kconfig
+++ linux-genirq.q/arch/mips/Kconfig
@@ -1582,6 +1582,11 @@ config GENERIC_IRQ_PROBE
 	bool
 	default y
 
+config IRQ_PER_CPU
+	depends on SMP
+	bool
+	default y
+
 #
 # - Highmem only makes sense for the 32-bit kernel.
 # - The current highmem code will only work properly on physically indexed
Index: linux-genirq.q/arch/parisc/Kconfig
===================================================================
--- linux-genirq.q.orig/arch/parisc/Kconfig
+++ linux-genirq.q/arch/parisc/Kconfig
@@ -51,6 +51,10 @@ config GENERIC_HARDIRQS
 config GENERIC_IRQ_PROBE
 	def_bool y
 
+config IRQ_PER_CPU
+	bool
+	default y
+
 # unless you want to implement ACPI on PA-RISC ... ;-)
 config PM
 	bool
Index: linux-genirq.q/arch/powerpc/Kconfig
===================================================================
--- linux-genirq.q.orig/arch/powerpc/Kconfig
+++ linux-genirq.q/arch/powerpc/Kconfig
@@ -30,6 +30,10 @@ config GENERIC_HARDIRQS
 	bool
 	default y
 
+config IRQ_PER_CPU
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
Index: linux-genirq.q/include/asm-cris/irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-cris/irq.h
+++ linux-genirq.q/include/asm-cris/irq.h
@@ -1,11 +1,6 @@
 #ifndef _ASM_IRQ_H
 #define _ASM_IRQ_H
 
-/*
- * IRQ line status macro IRQ_PER_CPU is used
- */
-#define ARCH_HAS_IRQ_PER_CPU
-
 #include <asm/arch/irq.h>
 
 static inline int irq_canonicalize(int irq)
Index: linux-genirq.q/include/asm-ia64/irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-ia64/irq.h
+++ linux-genirq.q/include/asm-ia64/irq.h
@@ -14,11 +14,6 @@
 #define NR_IRQS		256
 #define NR_IRQ_VECTORS	NR_IRQS
 
-/*
- * IRQ line status macro IRQ_PER_CPU is used
- */
-#define ARCH_HAS_IRQ_PER_CPU
-
 static __inline__ int
 irq_canonicalize (int irq)
 {
Index: linux-genirq.q/include/asm-mips/mach-mips/irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-mips/mach-mips/irq.h
+++ linux-genirq.q/include/asm-mips/mach-mips/irq.h
@@ -5,10 +5,4 @@
 
 #define NR_IRQS	256
 
-#ifdef CONFIG_SMP
-
-#define ARCH_HAS_IRQ_PER_CPU
-
-#endif
-
 #endif /* __ASM_MACH_MIPS_IRQ_H */
Index: linux-genirq.q/include/asm-parisc/irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-parisc/irq.h
+++ linux-genirq.q/include/asm-parisc/irq.h
@@ -27,11 +27,6 @@
 
 #define NR_IRQS		(CPU_IRQ_MAX + 1)
 
-/*
- * IRQ line status macro IRQ_PER_CPU is used
- */
-#define ARCH_HAS_IRQ_PER_CPU
-
 static __inline__ int irq_canonicalize(int irq)
 {
 	return (irq == 2) ? 9 : irq;
Index: linux-genirq.q/include/asm-powerpc/irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-powerpc/irq.h
+++ linux-genirq.q/include/asm-powerpc/irq.h
@@ -31,11 +31,6 @@
 #define IRQ_POLARITY_POSITIVE	0x2	/* high level or low->high edge */
 #define IRQ_POLARITY_NEGATIVE	0x0	/* low level or high->low edge */
 
-/*
- * IRQ line status macro IRQ_PER_CPU is used
- */
-#define ARCH_HAS_IRQ_PER_CPU
-
 #define get_irq_desc(irq) (&irq_desc[(irq)])
 
 /* Define a way to iterate across irqs. */
Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -33,7 +33,7 @@
 #define IRQ_WAITING	32	/* IRQ not yet seen - for autodetection */
 #define IRQ_LEVEL	64	/* IRQ level triggered */
 #define IRQ_MASKED	128	/* IRQ masked - shouldn't be seen again */
-#ifdef ARCH_HAS_IRQ_PER_CPU
+#ifdef CONFIG_IRQ_PER_CPU
 # define IRQ_PER_CPU	256	/* IRQ is per CPU */
 # define CHECK_IRQ_PER_CPU(var) ((var) & IRQ_PER_CPU)
 #else
Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -198,7 +198,7 @@ int setup_irq(unsigned int irq, struct i
 		if (!(old->flags & new->flags & SA_SHIRQ))
 			goto mismatch;
 
-#if defined(ARCH_HAS_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
+#if defined(CONFIG_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
 		/* All handlers must agree on per-cpuness */
 		if ((old->flags & IRQ_PER_CPU) != (new->flags & IRQ_PER_CPU))
 			goto mismatch;
@@ -213,7 +213,7 @@ int setup_irq(unsigned int irq, struct i
 	}
 
 	*p = new;
-#if defined(ARCH_HAS_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
+#if defined(CONFIG_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
 	if (new->flags & SA_PERCPU_IRQ)
 		desc->status |= IRQ_PER_CPU;
 #endif
