Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWEQAXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWEQAXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWEQAW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:22:56 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:42141 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932378AbWEQATA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:19:00 -0400
Date: Wed, 17 May 2006 02:18:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 44/50] genirq: ARM: Convert versatile to generic irq handling
Message-ID: <20060517001836.GS12877@elte.hu>
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

From: Thomas Gleixner <tglx@linutronix.de>

Fixup the conversion to generic irq subsystem.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/arm/mach-versatile/core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-genirq.q/arch/arm/mach-versatile/core.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-versatile/core.c
+++ linux-genirq.q/arch/arm/mach-versatile/core.c
@@ -114,8 +114,7 @@ void __init versatile_init_irq(void)
 
 	vic_init(VA_VIC_BASE, IRQ_VIC_START, ~(1 << 31));
 
-	set_irq_handler(IRQ_VICSOURCE31, sic_handle_irq);
-	enable_irq(IRQ_VICSOURCE31);
+	set_irq_chained_handler(IRQ_VICSOURCE31, sic_handle_irq);
 
 	/* Do second interrupt controller */
 	writel(~0, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
