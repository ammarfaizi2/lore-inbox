Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266916AbUHMThl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266916AbUHMThl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUHMTdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:33:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54520 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267335AbUHMTcc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:32:32 -0400
Date: Fri, 13 Aug 2004 12:32:25 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtdblockd nofreeze
Message-ID: <20040813193225.GA22079@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mtdblockd doesn't respond to process freeze requests, preventing system
suspend.  It seems likely that mtdblockd should continue to flush blocks
during the device suspend phase, so a patch to spare the thread from
attempted freeze follows.  If, on the other hand, mtdblockd does need to
implement freeze proper then I can send a patch for that instead, thanks
for any insight into this.

--- linux-2.6.8-rc4-orig/drivers/mtd/mtd_blkdevs.c	2004-08-10 18:51:15.000000000 -0700
+++ linux-2.6.8-rc4-mtdfix/drivers/mtd/mtd_blkdevs.c	2004-08-13 11:39:54.000000000 -0700
@@ -81,7 +81,7 @@
 	struct request_queue *rq = tr->blkcore_priv->rq;
 
 	/* we might get involved when memory gets low, so use PF_MEMALLOC */
-	current->flags |= PF_MEMALLOC;
+	current->flags |= PF_MEMALLOC | PF_NOFREEZE;
 
 	daemonize("%sd", tr->name);
 


-- 
Todd Poynor
MontaVista Software

