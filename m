Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVAPL6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVAPL6u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 06:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVAPL6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 06:58:50 -0500
Received: from verein.lst.de ([213.95.11.210]:49117 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262486AbVAPL6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 06:58:47 -0500
Date: Sun, 16 Jan 2005 12:58:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] switch frw to use local_soft_irq_pending
Message-ID: <20050116115841.GB13716@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The newly merged frv do_IRQ code calls softirq_pending(), but always with
the current cpu as argument - switch to local_softirq_pending().

Btw, this usage look bogus to me, any reason you need to call do_softirq
again after you did four lines above in irq_exit(), David?


--- 1.1/arch/frv/kernel/irq.c	2005-01-05 03:48:04 +01:00
+++ edited/arch/frv/kernel/irq.c	2005-01-07 12:27:31 +01:00
@@ -312,7 +312,7 @@
 
 	/* only process softirqs if we didn't interrupt another interrupt handler */
 	if ((__frame->psr & PSR_PIL) == PSR_PIL_0)
-		if (softirq_pending(cpu))
+		if (local_softirq_pending())
 			do_softirq();
 
 #ifdef CONFIG_PREEMPT
