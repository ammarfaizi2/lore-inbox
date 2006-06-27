Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933076AbWF0Jcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933076AbWF0Jcr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933385AbWF0Jcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:32:47 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:53134 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933076AbWF0Jcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:32:46 -0400
Date: Tue, 27 Jun 2006 11:28:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [patch] irq: fix arch/i386/kernel/irq.c gcc warning
Message-ID: <20060627092801.GA4196@elte.hu>
References: <20060627015211.ce480da6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627015211.ce480da6.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm3/

> Changes since 2.6.17-mm2:
> 
>  origin.patch

upstream grew a new compiler warning in i386 irq.c. Patch below fixes 
it. No change in resulting irq.o code.

	Ingo

-------------
Subject: irq: fix arch/i386/kernel/irq.c gcc warning
From: Ingo Molnar <mingo@elte.hu>

add parantheses. (code was fine because & has a higher precedence than |,
but it's a dangerous construct in general and gcc also emits a warning)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/i386/kernel/irq.c
===================================================================
--- linux.orig/arch/i386/kernel/irq.c
+++ linux/arch/i386/kernel/irq.c
@@ -104,8 +104,8 @@ fastcall unsigned int do_IRQ(struct pt_r
 		 * softirq checks work in the hardirq context.
 		 */
 		irqctx->tinfo.preempt_count =
-			irqctx->tinfo.preempt_count & ~SOFTIRQ_MASK |
-			curctx->tinfo.preempt_count & SOFTIRQ_MASK;
+			(irqctx->tinfo.preempt_count & ~SOFTIRQ_MASK) |
+			(curctx->tinfo.preempt_count & SOFTIRQ_MASK);
 
 		asm volatile(
 			"       xchgl   %%ebx,%%esp      \n"
