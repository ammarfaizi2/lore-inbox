Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWFYWIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWFYWIl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 18:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWFYWIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 18:08:41 -0400
Received: from www.osadl.org ([213.239.205.134]:30379 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932378AbWFYWIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 18:08:41 -0400
Subject: [PATCH -mm] genirq: revert noisyness on spurious interrupts
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 00:10:29 +0200
Message-Id: <1151273429.25491.415.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Revert a leftover from the backed out i386 -> genirq conversion. This
led to noisy printk outputs about spurious interrupts. Move it back to
original behaviour. The handling of those spurious interrupts needs more
thought and should be fixed with the full genirq conversion of
i386/x86_64.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux-2.6.17-mm/kernel/irq/handle.c
===================================================================
--- linux-2.6.17-mm.orig/kernel/irq/handle.c	2006-06-25 23:16:27.000000000 +0200
+++ linux-2.6.17-mm/kernel/irq/handle.c	2006-06-25 23:36:46.000000000 +0200
@@ -149,12 +149,6 @@
 	struct irqaction *action;
 	unsigned int status;
 
-	if (unlikely(desc->handle_irq)) {
-		desc->handle_irq(irq, desc, regs);
-
-		return 1;
-	}
-
 	kstat_this_cpu.irqs[irq]++;
 	if (CHECK_IRQ_PER_CPU(desc->status)) {
 		irqreturn_t action_ret;



