Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWEQAdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWEQAdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWEQAdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:33:01 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:29904 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932305AbWEQAQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:16:15 -0400
Date: Wed, 17 May 2006 02:16:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 12/50] genirq: doc: comment include/linux/irq.h structures
Message-ID: <20060517001606.GM12877@elte.hu>
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

better document the hw_interrupt_type and irq_desc structures.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |   44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -40,9 +40,27 @@
 # define CHECK_IRQ_PER_CPU(var) 0
 #endif
 
-/*
- * Interrupt controller descriptor. This is all we need
- * to describe about the low-level hardware. 
+/**
+ * struct hw_interrupt_type - hardware interrupt type descriptor
+ *
+ * @name:		name for /proc/interrupts
+ * @startup:		start up the interrupt (defaults to ->enable if NULL)
+ * @shutdown:		shut down the interrupt (defaults to ->disable if NULL)
+ * @enable:		enable the interrupt (defaults to chip->unmask if NULL)
+ * @disable:		disable the interrupt (defaults to chip->mask if NULL)
+ * @handle_irq:		irq flow handler called from the arch IRQ glue code
+ * @ack:		start of a new interrupt
+ * @mask:		mask an interrupt source
+ * @mask_ack:		ack and mask an interrupt source
+ * @unmask:		unmask an interrupt source
+ * @hold:		same interrupt while the handler is running
+ * @end:		end of interrupt
+ * @set_affinity:	set the CPU affinity on SMP machines
+ * @retrigger:		resend an IRQ to the CPU
+ * @set_type:		set the flow type (IRQ_TYPE_LEVEL/etc.) of an IRQ
+ * @set_wake:		enable/disable power-management wake-on of an IRQ
+ *
+ * @release:		release function solely used by UML
  */
 struct hw_interrupt_type {
 	const char	*typename;
@@ -65,10 +83,22 @@ typedef struct hw_interrupt_type  hw_irq
 
 struct proc_dir_entry;
 
-/*
- * This is the "IRQ descriptor", which contains various information
- * about the irq, including what kind of hardware handling it has,
- * whether it is disabled etc etc.
+/**
+ * struct irq_desc - interrupt descriptor
+ *
+ * @handler:		interrupt type dependent handler functions
+ * @handler_data:	data for the type handlers
+ * @action:		the irq action chain
+ * @status:		status information
+ * @depth:		disable-depth, for nested irq_disable() calls
+ * @irq_count:		stats field to detect stalled irqs
+ * @irqs_unhandled:	stats field for spurious unhandled interrupts
+ * @lock:		locking for SMP
+ * @affinity:		IRQ affinity on SMP
+ * @pending_mask:	pending rebalanced interrupts
+ * @move_irq:		need to re-target IRQ destination
+ * @dir:		/proc/irq/ procfs entry
+ * @affinity_entry:	/proc/irq/smp_affinity procfs entry on SMP
  *
  * Pad this out to 32 bytes for cache and indexing reasons.
  */
