Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbVJ1HAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVJ1HAe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbVJ1HAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:00:34 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:28076 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S965130AbVJ1HAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:00:33 -0400
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'Deepak Saxena'" <dsaxena@plexity.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.arm.linux.org.uk>,
       <trivial@rustcorp.com.au>
Subject: [PATCH] 2.6.14 drivers/mtd/maps/ixp4xx.c: remove compiler warning from ioremap assignment
Date: Thu, 27 Oct 2005 23:13:59 -0700
Message-ID: <000f01c5db86$ca148450$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix for a compiler warning: info->map.map_priv_1 is
(unsigned long), ioremap returns a pointer.  (Probably the
result of improved compiler warnings in >2.6.12).

Signed-off-by: John Bowler <jbowler@acm.org>

--- linux-2.6.14-rc5/drivers/mtd/maps/ixp4xx.c	2005-10-26 08:37:21.960361430 -0700
+++ patched/drivers/mtd/maps/ixp4xx.c	2005-10-26 12:13:13.879374310 -0700
@@ -227,7 +227,7 @@ static int ixp4xx_flash_probe(struct dev
 		goto Error;
 	}
 
-	info->map.map_priv_1 = ioremap(dev->resource->start,
+	info->map.map_priv_1 = (unsigned long)ioremap(dev->resource->start,
 			    dev->resource->end - dev->resource->start + 1);
 	if (!info->map.map_priv_1) {
 		printk(KERN_ERR "IXP4XXFlash: Failed to ioremap region\n");

