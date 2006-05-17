Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWEQAeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWEQAeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWEQAQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:16:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14288 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932294AbWEQAPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:15:52 -0400
Date: Wed, 17 May 2006 02:15:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 06/50] genirq: cleanup: include/linux/irq.h
Message-ID: <20060517001535.GG12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

small cleanups in include/linux/irq.h.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |   56 ++++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -45,17 +45,17 @@
  * to describe about the low-level hardware. 
  */
 struct hw_interrupt_type {
-	const char *typename;
-	unsigned int (*startup)(unsigned int irq);
-	void (*shutdown)(unsigned int irq);
-	void (*enable)(unsigned int irq);
-	void (*disable)(unsigned int irq);
-	void (*ack)(unsigned int irq);
-	void (*end)(unsigned int irq);
-	void (*set_affinity)(unsigned int irq, cpumask_t dest);
+	const char	*typename;
+	unsigned int	(*startup)(unsigned int irq);
+	void		(*shutdown)(unsigned int irq);
+	void		(*enable)(unsigned int irq);
+	void		(*disable)(unsigned int irq);
+	void		(*ack)(unsigned int irq);
+	void		(*end)(unsigned int irq);
+	void		(*set_affinity)(unsigned int irq, cpumask_t dest);
 	/* Currently used only by UML, might disappear one day.*/
 #ifdef CONFIG_IRQ_RELEASE_METHOD
-	void (*release)(unsigned int irq, void *dev_id);
+	void		(*release)(unsigned int irq, void *dev_id);
 #endif
 };
 
@@ -69,19 +69,19 @@ typedef struct hw_interrupt_type  hw_irq
  * Pad this out to 32 bytes for cache and indexing reasons.
  */
 struct irq_desc {
-	hw_irq_controller *handler;
-	void *handler_data;
-	struct irqaction *action;	/* IRQ action list */
-	unsigned int status;		/* IRQ status */
-	unsigned int depth;		/* nested irq disables */
-	unsigned int irq_count;		/* For detecting broken interrupts */
-	unsigned int irqs_unhandled;
-	spinlock_t lock;
+	hw_irq_controller	*handler;
+	void			*handler_data;
+	struct irqaction	*action;	/* IRQ action list */
+	unsigned int		status;		/* IRQ status */
+	unsigned int		depth;		/* nested irq disables */
+	unsigned int		irq_count;	/* For detecting broken IRQs */
+	unsigned int		irqs_unhandled;
+	spinlock_t		lock;
 #ifdef CONFIG_SMP
-	cpumask_t affinity;
+	cpumask_t		affinity;
 #endif
 #if defined(CONFIG_GENERIC_PENDING_IRQ) || defined(CONFIG_IRQBALANCE)
-	unsigned int move_irq;		/* Flag need to re-target intr dest*/
+	unsigned int		move_irq;	/* need to re-target IRQ dest */
 #endif
 } ____cacheline_aligned;
 
@@ -178,6 +178,15 @@ static inline void set_irq_info(int irq,
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_AUTO_IRQ_AFFINITY
+extern int select_smp_affinity(unsigned int irq);
+#else
+static inline int select_smp_affinity(unsigned int irq)
+{
+	return 1;
+}
+#endif
+
 extern int no_irq_affinity;
 extern int noirqdebug_setup(char *str);
 
@@ -195,15 +204,6 @@ extern int can_request_irq(unsigned int 
 
 extern void init_irq_proc(void);
 
-#ifdef CONFIG_AUTO_IRQ_AFFINITY
-extern int select_smp_affinity(unsigned int irq);
-#else
-static inline int select_smp_affinity(unsigned int irq)
-{
-	return 1;
-}
-#endif
-
 #endif /* CONFIG_GENERIC_HARDIRQS */
 
 extern hw_irq_controller no_irq_type;  /* needed in every arch ? */
