Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263125AbUKTRgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUKTRgQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 12:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbUKTRgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 12:36:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22794 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263125AbUKTRgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 12:36:10 -0500
Date: Sat, 20 Nov 2004 17:35:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>, Ian Molton <spyro@f2s.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill unused call_irq()
Message-ID: <20041120173559.H13550@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
References: <20041114104627.GA32234@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041114104627.GA32234@lst.de>; from hch@lst.de on Sun, Nov 14, 2004 at 11:46:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 11:46:27AM +0100, Christoph Hellwig wrote:
> These routine in arm and arm26 is unused (in fact not even compiled).
> 
> Inatead of converting it to local_softirq_pending I'd suggest just
> removing it as below as it's been there totally unused for a long time.

I've applied the ARM bit... Ian - please handle ARM26 bit below.  Thanks.

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

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
