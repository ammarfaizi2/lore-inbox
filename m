Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbUKNKnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbUKNKnh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 05:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbUKNKnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 05:43:37 -0500
Received: from verein.lst.de ([213.95.11.210]:52918 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261280AbUKNKnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 05:43:35 -0500
Date: Sun, 14 Nov 2004 11:43:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: mikael.starvik@axis.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove bogus double softirq processing in cris
Message-ID: <20041114104327.GA32182@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this out long ago already, but it's still not in:

  These days irq_exit does all softirq processing, so there's no need to
  call do_softirq again in cris.

Also is there any chance you could switch cris to use the new
CONFIG_GENERIC_HARDIRQS code in 2.6.10-rc that would replace most of
arch/cris/kernel/irq.c with generic code from kernel/irq/* ?


--- 1.17/arch/cris/kernel/irq.c	2004-10-20 10:37:14 +02:00
+++ edited/arch/cris/kernel/irq.c	2004-11-14 11:39:14 +01:00
@@ -158,11 +158,6 @@ asmlinkage void do_IRQ(int irq, struct p
 		local_irq_disable();
         }
         irq_exit();
-
-	if (softirq_pending(cpu))
-                do_softirq();
-
-        /* unmasking and bottom half handling is done magically for us. */
 }
 
 /* this function links in a handler into the chain of handlers for the
