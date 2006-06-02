Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWFBIdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWFBIdi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWFBIdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:33:38 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:38627 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751326AbWFBIdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:33:38 -0400
Date: Fri, 2 Jun 2006 10:33:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm2] genirq: change handle_percpu_irq() to use chip->eoi()
Message-ID: <20060602083358.GA17417@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5055]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: genirq: change handle_percpu_irq() to use chip->eoi()
From: Ingo Molnar <mingo@elte.hu>

Ben noticed that handle_percpu_irq() [which he uses in his irqchips port 
of ppc] should be using the ->eoi() chip method, not the old-style 
->end() method.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/kernel/irq/chip.c
===================================================================
--- linux.orig/kernel/irq/chip.c
+++ linux/kernel/irq/chip.c
@@ -435,8 +435,8 @@ handle_percpu_irq(unsigned int irq, stru
 	if (!noirqdebug)
 		note_interrupt(irq, desc, action_ret, regs);
 
-	if (desc->chip->end)
-		desc->chip->end(irq);
+	if (desc->chip->eoi)
+		desc->chip->eoi(irq);
 }
 
 #endif /* CONFIG_SMP */
