Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbTGAU6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 16:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTGAU6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 16:58:48 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:44302 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S263802AbTGAU6r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 16:58:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] 2.5.73, cciss, io hang
Date: Tue, 1 Jul 2003 16:13:09 -0500
Message-ID: <CBD6B29E2DA6954FABAC137771769D6504E157BD@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.5.73, cciss, io hang
Thread-Index: AcNAFboI1qWqZYhtRw+Ky2WgDJABZw==
From: "Wiran, Francis" <francis.wiran@hp.com>
To: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
X-OriginalArrivalTime: 01 Jul 2003 21:13:10.0515 (UTC) FILETIME=[933B8C30:01C34015]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Changes:
	* Fix for random hang doing large io on cciss driver in 2.5.x
kernel



 drivers/block/cciss.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.5.73/drivers/block/cciss.c~cciss_2.5_iohang	Thu Jun 26
14:25:11 2003
+++ linux-2.5.73-root/drivers/block/cciss.c	Thu Jun 26 19:44:16 2003
@@ -1961,7 +1961,6 @@ queue:
 
 	goto queue;
 startio:
-	blk_stop_queue(q);
 	start_io(h);
 }
 
@@ -2021,7 +2020,7 @@ static irqreturn_t do_cciss_intr(int irq
 	/*
 	 * See if we can queue up some more IO
 	 */
-	blk_start_queue(&h->queue);
+	do_cciss_request(&h->queue);
 	spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
 	return IRQ_HANDLED;
 }
