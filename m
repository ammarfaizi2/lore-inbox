Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbUKNKqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbUKNKqk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 05:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbUKNKqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 05:46:40 -0500
Received: from verein.lst.de ([213.95.11.210]:60598 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261281AbUKNKqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 05:46:33 -0500
Date: Sun, 14 Nov 2004 11:46:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill unused call_irq()
Message-ID: <20041114104627.GA32234@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These routine in arm and arm26 is unused (in fact not even compiled).

Inatead of converting it to local_softirq_pending I'd suggest just
removing it as below as it's been there totally unused for a long time.


Inatead of converting it to local_softirq_pending I'd suggest just
removing it as below as it's been there totally unused for a long time.


--- 1.8/include/asm-arm/mach/irq.h	2003-08-05 21:35:12 +02:00
+++ edited/include/asm-arm/mach/irq.h	2004-11-14 11:48:41 +01:00
@@ -97,23 +97,6 @@ void __set_irq_handler(unsigned int irq,
 void set_irq_chip(unsigned int irq, struct irqchip *);
 void set_irq_flags(unsigned int irq, unsigned int flags);
 
-#ifdef not_yet
-/*
- * This is to be used by the top-level machine IRQ decoder only.
- */
-static inline void call_irq(struct pt_regs *regs, unsigned int irq)
-{
-	struct irqdesc *desc = irq_desc + irq;
-
-	spin_lock(&irq_controller_lock);
-	desc->handle(irq, desc, regs);
-	spin_unlock(&irq_controller_lock);
-
-	if (softirq_pending(smp_processor_id()))
-		do_softirq();
-}
-#endif
-
 #define IRQF_VALID	(1 << 0)
 #define IRQF_PROBE	(1 << 1)
 #define IRQF_NOAUTOEN	(1 << 2)
--- 1.1/include/asm-arm26/irqchip.h	2003-06-04 13:14:10 +02:00
+++ edited/include/asm-arm26/irqchip.h	2004-11-14 11:48:53 +01:00
@@ -85,23 +85,6 @@ void __set_irq_handler(unsigned int irq,
 void set_irq_chip(unsigned int irq, struct irqchip *);
 void set_irq_flags(unsigned int irq, unsigned int flags);
 
-#ifdef not_yet
-/*
- * This is to be used by the top-level machine IRQ decoder only.
- */
-static inline void call_irq(struct pt_regs *regs, unsigned int irq)
-{
-	struct irqdesc *desc = irq_desc + irq;
-
-	spin_lock(&irq_controller_lock);
-	desc->handle(irq, desc, regs);
-	spin_unlock(&irq_controller_lock);
-
-	if (softirq_pending(smp_processor_id()))
-		do_softirq();
-}
-#endif
-
 #define IRQF_VALID	(1 << 0)
 #define IRQF_PROBE	(1 << 1)
 #define IRQF_NOAUTOEN	(1 << 2)
