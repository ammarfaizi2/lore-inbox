Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWEQAdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWEQAdH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWEQAcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:32:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31440 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932302AbWEQAQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:16:20 -0400
Date: Wed, 17 May 2006 02:16:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 13/50] genirq: doc: handle_IRQ_event() and __do_IRQ() comments
Message-ID: <20060517001611.GN12877@elte.hu>
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

document handle_IRQ_event() and __do_IRQ().

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/handle.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

Index: linux-genirq.q/kernel/irq/handle.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/handle.c
+++ linux-genirq.q/kernel/irq/handle.c
@@ -76,8 +76,13 @@ irqreturn_t no_action(int cpl, void *dev
 	return IRQ_NONE;
 }
 
-/*
- * Have got an event to handle:
+/**
+ * handle_IRQ_event - irq action chain handler
+ * @irq:	the interrupt number
+ * @regs:	pointer to a register structure
+ * @action:	the interrupt action chain for this irq
+ *
+ * Handles the action chain of an irq event
  */
 int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
 		     struct irqaction *action)
@@ -102,10 +107,17 @@ int handle_IRQ_event(unsigned int irq, s
 	return retval;
 }
 
-/*
- * do_IRQ handles all normal device IRQ's (the special
+/**
+ * __do_IRQ - original all in one highlevel IRQ handler
+ * @irq:	the interrupt number
+ * @regs:	pointer to a register structure
+ *
+ * __do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
  * handlers).
+ *
+ * This is the original x86 implementation which is used for every
+ * interrupt type.
  */
 fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs)
 {
