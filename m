Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268285AbUIKTBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268285AbUIKTBG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 15:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268288AbUIKTBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 15:01:06 -0400
Received: from verein.lst.de ([213.95.11.210]:35481 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268285AbUIKS7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:59:23 -0400
Date: Sat, 11 Sep 2004 20:59:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] small <linux/hardirq.h> tweaks
Message-ID: <20040911185918.GA22494@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - I misspelled CONFIG_PREEMPT CONFIG_PREEPT as various people noticed.
   But in fact that ifdef should just go, else we'll get drivers that
   compile with CONFIG_PREEMPT but not without sooner or later.
 - remove unused hardirq_trylock and hardirq_endlock


--- 1.1/include/linux/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/linux/hardirq.h	2004-09-10 16:11:31 +02:00
@@ -2,9 +2,7 @@
 #define LINUX_HARDIRQ_H
 
 #include <linux/config.h>
-#ifdef CONFIG_PREEPT
 #include <linux/smp_lock.h>
-#endif
 #include <asm/hardirq.h>
 
 #define __IRQ_MASK(x)	((1UL << (x))-1)
@@ -28,9 +26,6 @@
 #define in_irq()		(hardirq_count())
 #define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
 
 #ifdef CONFIG_PREEMPT
 # define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
