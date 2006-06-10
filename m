Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWFJVkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWFJVkp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 17:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWFJVko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 17:40:44 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:18880 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1161025AbWFJVko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 17:40:44 -0400
Date: Sat, 10 Jun 2006 14:43:38 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [PATCH-rt] genirq error message clarification
Message-ID: <20060610214338.GA14760@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It makes it a bit easier to debug issues when we know what irq we're
having problems with.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


Index: linux-2.6-rt/kernel/irq/manage.c
===================================================================
--- linux-2.6-rt.orig/kernel/irq/manage.c
+++ linux-2.6-rt/kernel/irq/manage.c
@@ -328,7 +328,8 @@ int setup_irq(unsigned int irq, struct i
 mismatch:
 	spin_unlock_irqrestore(&desc->lock, flags);
 	if (!(new->flags & SA_PROBEIRQ)) {
-		printk(KERN_ERR "%s: irq handler mismatch\n", __FUNCTION__);
+		printk(KERN_ERR "%s: irq %d handler mismatch\n", __FUNCTION__,
+				irq);
 		dump_stack();
 	}
 	return -EBUSY;

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht
