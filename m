Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268667AbUILLTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268667AbUILLTx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268669AbUILLTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:19:53 -0400
Received: from verein.lst.de ([213.95.11.210]:39082 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268667AbUILLTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:19:51 -0400
Date: Sun, 12 Sep 2004 13:19:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: bjornw@axis.com
Cc: dev-etrax@axis.com, linux-kernel@vger.kernel.org
Subject: [PATCH] superflous do_softirq invocation in cris do_IRQ()
Message-ID: <20040912111934.GA32506@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, bjornw@axis.com,
	dev-etrax@axis.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irq_exit already does softirq processing, no need to do it a second
time.


--- 1.16/arch/cris/kernel/irq.c	2004-08-31 09:57:57 +02:00
+++ edited/arch/cris/kernel/irq.c	2004-09-11 21:21:15 +02:00
@@ -159,9 +159,6 @@
         }
         irq_exit();
 
-	if (softirq_pending(cpu))
-                do_softirq();
-
         /* unmasking and bottom half handling is done magically for us. */
 }
 
