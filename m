Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWF3Szo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWF3Szo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWF3Szo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:55:44 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:3543 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751046AbWF3Szm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:55:42 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] IRQ: Use SA_PERCPU_IRQ, not IRQ_PER_CPU, for irqaction.flags
Date: Fri, 30 Jun 2006 12:55:37 -0600
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301255.37638.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ_PER_CPU is a bit in the struct irq_desc "status" field, not
in the struct irqaction "flags", so the previous code checked the
wrong bit.

SA_PERCPU_IRQ is only used by drivers/char/mmtimer.c for SGI ia64 boxes.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm7/kernel/irq/manage.c
===================================================================
--- work-mm7.orig/kernel/irq/manage.c	2006-06-30 11:52:21.000000000 -0600
+++ work-mm7/kernel/irq/manage.c	2006-06-30 11:59:13.000000000 -0600
@@ -237,7 +237,8 @@
 
 #if defined(CONFIG_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
 		/* All handlers must agree on per-cpuness */
-		if ((old->flags & IRQ_PER_CPU) != (new->flags & IRQ_PER_CPU))
+		if ((old->flags & SA_PERCPU_IRQ) !=
+		    (new->flags & SA_PERCPU_IRQ))
 			goto mismatch;
 #endif
 
