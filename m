Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWJRIZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWJRIZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWJRIZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:25:20 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:24772 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751054AbWJRIZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:25:18 -0400
Date: Wed, 18 Oct 2006 10:16:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Olaf Hering <olaf@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [patch] genirq: clean up irq-flow-type naming, fix
Message-ID: <20061018081659.GA5778@elte.hu>
References: <20061018080411.GA13340@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018080411.GA13340@aepfle.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Olaf Hering <olaf@aepfle.de> wrote:

> There is no prototype anymore, but still many users.
> 
> a460e745e8f9c75a0525ff94154a0629f9d3e05d is likely the culprit:
>  [PATCH] genirq: clean up irq-flow-type naming

oops, that was unintended. The patch below should fix this.

	Ingo

--------------->
Subject: genirq: clean up irq-flow-type naming, fix
From: Ingo Molnar <mingo@elte.hu>

re-add the set_irq_chip_and_handler() prototype, it's still widely used.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/irq.h |    3 +++
 1 file changed, 3 insertions(+)

Index: linux/include/linux/irq.h
===================================================================
--- linux.orig/include/linux/irq.h
+++ linux/include/linux/irq.h
@@ -322,6 +322,9 @@ extern struct irq_chip no_irq_chip;
 extern struct irq_chip dummy_irq_chip;
 
 extern void
+set_irq_chip_and_handler(unsigned int irq, struct irq_chip *chip,
+			 irq_flow_handler_t handle);
+extern void
 set_irq_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
 			      irq_flow_handler_t handle, const char *name);
 
