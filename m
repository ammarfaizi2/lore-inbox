Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWEQAcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWEQAcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWEQAQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:16:17 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47004 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932298AbWEQAPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:15:53 -0400
Date: Wed, 17 May 2006 02:15:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 07/50] genirq: cleanup: merge irq_dir[], smp_affinity_entry[] into irq_desc[]
Message-ID: <20060517001540.GH12877@elte.hu>
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

consolidation: remove the irq_dir[NR_IRQS] and the
smp_affinity_entry[NR_IRQS] arrays and move them
into the irq_desc[] array.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -61,6 +61,8 @@ struct hw_interrupt_type {
 
 typedef struct hw_interrupt_type  hw_irq_controller;
 
+struct proc_dir_entry;
+
 /*
  * This is the "IRQ descriptor", which contains various information
  * about the irq, including what kind of hardware handling it has,
@@ -83,6 +85,12 @@ struct irq_desc {
 #if defined(CONFIG_GENERIC_PENDING_IRQ) || defined(CONFIG_IRQBALANCE)
 	unsigned int		move_irq;	/* need to re-target IRQ dest */
 #endif
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry *dir;
+# ifdef CONFIG_SMP
+	struct proc_dir_entry *affinity_entry;
+# endif
+#endif
 } ____cacheline_aligned;
 
 extern struct irq_desc irq_desc[NR_IRQS];
