Return-Path: <linux-kernel-owner+w=401wt.eu-S1751265AbXANMqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbXANMqs (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 07:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbXANMqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 07:46:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48239 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbXANMqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 07:46:47 -0500
Date: Sun, 14 Jan 2007 13:42:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2/3] Scheduled removal of SA_xxx interrupt flags fixups
Message-ID: <20070114124252.GA4809@elte.hu>
References: <20070114081905.135797900@inhelltoy.tec.linutronix.de> <20070114081926.967534281@inhelltoy.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114081926.967534281@inhelltoy.tec.linutronix.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> The obsolete SA_xxx interrupt flags have been used despite the 
> scheduled removal. Fixup the remaining users.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

i have tested your patch-queue ontop of rc4-mm1 (trivial reject fixups 
are below), it builds and boots fine.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo

---
 drivers/char/nozomi.c |    2 +-
 drivers/net/qla3xxx.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux/drivers/char/nozomi.c
===================================================================
--- linux.orig/drivers/char/nozomi.c
+++ linux/drivers/char/nozomi.c
@@ -1378,7 +1378,7 @@ static int nozomi_setup_interrupt(struct
 {
 	int rval;
 
-	rval = request_irq(dc->pdev->irq, &interrupt_handler, SA_SHIRQ,
+	rval = request_irq(dc->pdev->irq, &interrupt_handler, IRQF_SHARED,
 			   NOZOMI_NAME, dc);
 	if (rval)
 		dev_err(&dc->pdev->dev, "Cannot open because IRQ %d "
Index: linux/drivers/net/qla3xxx.c
===================================================================
--- linux.orig/drivers/net/qla3xxx.c
+++ linux/drivers/net/qla3xxx.c
@@ -2999,7 +2999,7 @@ static int ql_adapter_up(struct ql3_adap
 {
 	struct net_device *ndev = qdev->ndev;
 	int err;
-	unsigned long irq_flags = SA_SAMPLE_RANDOM | SA_SHIRQ;
+	unsigned long irq_flags = IRQF_SAMPLE_RANDOM | IRQF_SHARED;
 	unsigned long hw_flags;
 
 	if (ql_alloc_mem_resources(qdev)) {
@@ -3018,7 +3018,7 @@ static int ql_adapter_up(struct ql3_adap
 		} else {
 			printk(KERN_INFO PFX "%s: MSI Enabled...\n", qdev->ndev->name);
 			set_bit(QL_MSI_ENABLED,&qdev->flags);
-			irq_flags &= ~SA_SHIRQ;
+			irq_flags &= ~IRQF_SHARED;
 		}
 	}
 
