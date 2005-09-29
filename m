Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVI2TvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVI2TvD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVI2TvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:51:02 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:43227 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751184AbVI2TvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:51:00 -0400
Date: Thu, 29 Sep 2005 12:52:05 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH] Fix IXP4xx MTD driver no cast warning
Message-ID: <20050929195205.GA30002@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix following warning:

drivers/mtd/maps/ixp4xx.c: In function 'ixp4xx_flash_probe':
drivers/mtd/maps/ixp4xx.c:199: warning: assignment makes integer from
pointer without a cast

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/drivers/mtd/maps/ixp4xx.c b/drivers/mtd/maps/ixp4xx.c
--- a/drivers/mtd/maps/ixp4xx.c
+++ b/drivers/mtd/maps/ixp4xx.c
@@ -196,7 +196,7 @@ static int ixp4xx_flash_probe(struct dev
 		goto Error;
 	}
 
-	info->map.map_priv_1 = ioremap(dev->resource->start,
+	info->map.map_priv_1 = (unsigned long)ioremap(dev->resource->start,
 			    dev->resource->end - dev->resource->start + 1);
 	if (!info->map.map_priv_1) {
 		printk(KERN_ERR "IXP4XXFlash: Failed to ioremap region\n");

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
