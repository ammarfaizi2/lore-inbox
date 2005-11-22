Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbVKVOXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbVKVOXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVKVOXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:23:33 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:41888 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S964949AbVKVOXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:23:32 -0500
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, David Howells <dhowells@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2a/5] Ensure NO_IRQ is appropriately defined on all architectures
Message-Id: <E1EeZ3F-0005Is-1T@localhost.localdomain>
Date: Tue, 22 Nov 2005 09:23:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a default definition of NO_IRQ to <linux/hardirq.h> and move the
definition from <asm/irq.h> to <asm/hardirq.h> for all architectures which
override it.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/include/asm-arm/hardirq.h b/include/asm-arm/hardirq.h
index 1cbb173..890f1da 100644
--- a/include/asm-arm/hardirq.h
+++ b/include/asm-arm/hardirq.h
@@ -13,6 +13,9 @@ typedef struct {
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
+/* Device has no interrupt */
+#define NO_IRQ		((unsigned int)(-1))
+
 #if NR_IRQS > 256
 #define HARDIRQ_BITS	9
 #else
diff --git a/include/asm-arm/irq.h b/include/asm-arm/irq.h
index 59975ee..0545e36 100644
--- a/include/asm-arm/irq.h
+++ b/include/asm-arm/irq.h
@@ -11,14 +11,6 @@
 #define NR_IRQS	128
 #endif
 
-/*
- * Use this value to indicate lack of interrupt
- * capability
- */
-#ifndef NO_IRQ
-#define NO_IRQ	((unsigned int)(-1))
-#endif
-
 struct irqaction;
 
 extern void disable_irq_nosync(unsigned int);
diff --git a/include/asm-arm26/hardirq.h b/include/asm-arm26/hardirq.h
index dc28daa..58e9ab5 100644
--- a/include/asm-arm26/hardirq.h
+++ b/include/asm-arm26/hardirq.h
@@ -11,6 +11,9 @@ typedef struct {
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
+/* Device has no interrupt */
+#define NO_IRQ		((unsigned int)(-1))
+
 #define HARDIRQ_BITS	8
 
 /*
diff --git a/include/asm-arm26/irq.h b/include/asm-arm26/irq.h
index 06bd5a5..dcdfd50 100644
--- a/include/asm-arm26/irq.h
+++ b/include/asm-arm26/irq.h
@@ -13,15 +13,6 @@
 #define irq_canonicalize(i)     (i)
 #endif
 
-
-/*
- * Use this value to indicate lack of interrupt
- * capability
- */
-#ifndef NO_IRQ
-#define NO_IRQ	((unsigned int)(-1))
-#endif
-
 struct irqaction;
 
 #define disable_irq_nosync(i) disable_irq(i)
diff --git a/include/asm-frv/hardirq.h b/include/asm-frv/hardirq.h
index 5248ca0..7b10618 100644
--- a/include/asm-frv/hardirq.h
+++ b/include/asm-frv/hardirq.h
@@ -22,6 +22,9 @@ typedef struct {
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
+/* Device has no interrupt */
+#define NO_IRQ		((unsigned int)(-1))
+
 #ifdef CONFIG_SMP
 #error SMP not available on FR-V
 #endif /* CONFIG_SMP */
diff --git a/include/asm-frv/irq.h b/include/asm-frv/irq.h
index 2c16d8d..fbc5bd7 100644
--- a/include/asm-frv/irq.h
+++ b/include/asm-frv/irq.h
@@ -20,9 +20,6 @@
  * drivers
  */
 
-/* this number is used when no interrupt has been assigned */
-#define NO_IRQ				(-1)
-
 #define NR_IRQ_LOG2_ACTIONS_PER_GROUP	5
 #define NR_IRQ_ACTIONS_PER_GROUP	(1 << NR_IRQ_LOG2_ACTIONS_PER_GROUP)
 #define NR_IRQ_GROUPS			4
diff --git a/include/asm-parisc/hardirq.h b/include/asm-parisc/hardirq.h
index ce93133..d269f3e 100644
--- a/include/asm-parisc/hardirq.h
+++ b/include/asm-parisc/hardirq.h
@@ -24,6 +24,9 @@ typedef struct {
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
+/* Device has no interrupt */
+#define NO_IRQ		((unsigned int)(-1))
+
 void ack_bad_irq(unsigned int irq);
 
 #endif /* _PARISC_HARDIRQ_H */
diff --git a/include/asm-parisc/irq.h b/include/asm-parisc/irq.h
index b0a30e2..26ab3be 100644
--- a/include/asm-parisc/irq.h
+++ b/include/asm-parisc/irq.h
@@ -11,8 +11,6 @@
 #include <linux/cpumask.h>
 #include <asm/types.h>
 
-#define NO_IRQ		(-1)
-
 #ifdef CONFIG_GSC
 #define GSC_IRQ_BASE	16
 #define GSC_IRQ_MAX	63
diff --git a/include/asm-powerpc/hardirq.h b/include/asm-powerpc/hardirq.h
index 3b3e3b4..9271c40 100644
--- a/include/asm-powerpc/hardirq.h
+++ b/include/asm-powerpc/hardirq.h
@@ -18,6 +18,9 @@ typedef struct {
 
 #define last_jiffy_stamp(cpu) __IRQ_STAT((cpu), __last_jiffy_stamp)
 
+/* Device has no interrupt */
+#define NO_IRQ		((unsigned int)(-1))
+
 static inline void ack_bad_irq(int irq)
 {
 	printk(KERN_CRIT "illegal vector %d received!\n", irq);
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 8eb7e85..1b41206 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -15,9 +15,6 @@
 #include <asm/types.h>
 #include <asm/atomic.h>
 
-/* this number is used when no interrupt has been assigned */
-#define NO_IRQ			(-1)
-
 /*
  * These constants are used for passing information about interrupt
  * signal polarity and level/edge sensing to the low-level PIC chip
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 71d2b8a..26ef810 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -87,6 +87,15 @@ extern void synchronize_irq(unsigned int
 # define synchronize_irq(irq)	barrier()
 #endif
 
+/*
+ * This value means "Device has no interrupt".  The value 0 has
+ * historically been used, but it's a legal interrupt number on some
+ * architectures.  These architectures typically define it to be -1 instead.
+ */
+#ifndef NO_IRQ
+#define NO_IRQ			((unsigned int)0)
+#endif
+
 #define nmi_enter()		irq_enter()
 #define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
 
