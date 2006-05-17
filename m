Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWEQA3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWEQA3A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWEQARg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:17:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57296 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932334AbWEQARW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:17:22 -0400
Date: Wed, 17 May 2006 02:17:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 25/50] genirq: cleanup: no_irq_type -> no_irq_chip rename
Message-ID: <20060517001711.GZ12877@elte.hu>
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

rename no_irq_type to no_irq_chip.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/irq/handle.c |    4 ++--
 kernel/irq/manage.c |    2 +-
 kernel/irq/proc.c   |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-genirq.q/kernel/irq/handle.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/handle.c
+++ linux-genirq.q/kernel/irq/handle.c
@@ -47,7 +47,7 @@ handle_bad_irq(unsigned int irq, struct 
 struct irq_desc irq_desc[NR_IRQS] __cacheline_aligned = {
 	[0 ... NR_IRQS-1] = {
 		.status = IRQ_DISABLED,
-		.handler = &no_irq_type,
+		.handler = &no_irq_chip,
 		.handle = handle_bad_irq,
 		.lock = SPIN_LOCK_UNLOCKED,
 		.depth = 1,
@@ -76,7 +76,7 @@ static void noop(unsigned int irq)
 /*
  * Generic no controller implementation
  */
-struct hw_interrupt_type no_irq_type = {
+struct irq_chip no_irq_chip = {
 	.typename =	"none",
 	.enable =	noop,
 	.disable =	noop,
Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -188,7 +188,7 @@ int setup_irq(unsigned int irq, struct i
 	if (irq >= NR_IRQS)
 		return -EINVAL;
 
-	if (desc->handler == &no_irq_type)
+	if (desc->handler == &no_irq_chip)
 		return -ENOSYS;
 	/*
 	 * Some drivers like serial.c use request_irq() heavily,
Index: linux-genirq.q/kernel/irq/proc.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/proc.c
+++ linux-genirq.q/kernel/irq/proc.c
@@ -119,7 +119,7 @@ void register_irq_proc(unsigned int irq)
 	char name [MAX_NAMELEN];
 
 	if (!root_irq_dir ||
-		(irq_desc[irq].handler == &no_irq_type) ||
+		(irq_desc[irq].handler == &no_irq_chip) ||
 			irq_dir[irq])
 		return;
 
