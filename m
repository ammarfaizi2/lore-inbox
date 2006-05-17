Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWEQAQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWEQAQn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWEQAQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:16:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:25040 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932303AbWEQAQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:16:08 -0400
Date: Wed, 17 May 2006 02:15:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 10/50] genirq: debug: better debug printout in enable_irq()
Message-ID: <20060517001554.GK12877@elte.hu>
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

From: Thomas Gleixner <tglx@linutronix.de>

make enable_irq() debug printouts user-readable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/irq/manage.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -114,6 +114,7 @@ void enable_irq(unsigned int irq)
 	spin_lock_irqsave(&desc->lock, flags);
 	switch (desc->depth) {
 	case 0:
+		printk(KERN_WARNING "Unablanced enable_irq(%d)\n", irq);
 		WARN_ON(1);
 		break;
 	case 1: {
