Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269527AbUINRoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269527AbUINRoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269495AbUINRke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:40:34 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:26805 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269460AbUINRjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:39:32 -0400
Date: Tue, 14 Sep 2004 10:39:20 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Update IXP4xx MTD driver from CVS MTD
Message-ID: <20040914173920.GA12350@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, Linus,

The following patch updates the IXP4xx MTD driver with a compile 
fix from the CVS repository. David has given me the OK to push 
this upstream.

Please apply,
~Deepak

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

===== drivers/mtd/maps/ixp4xx.c 1.2 vs edited =====
--- 1.2/drivers/mtd/maps/ixp4xx.c	Thu Jul 15 10:31:47 2004
+++ edited/drivers/mtd/maps/ixp4xx.c	Tue Sep 14 10:25:26 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: ixp4xx.c,v 1.3 2004/07/12 22:38:29 dwmw2 Exp $
+ * $Id: ixp4xx.c,v 1.4 2004/08/31 22:55:51 dsaxena Exp $
  *
  * drivers/mtd/maps/ixp4xx.c
  *
@@ -88,6 +88,7 @@
 	struct platform_device *dev = to_platform_device(_dev);
 	struct flash_platform_data *plat = dev->dev.platform_data;
 	struct ixp4xx_flash_info *info = dev_get_drvdata(&dev->dev);
+	map_word d;
 
 	dev_set_drvdata(&dev->dev, NULL);
 
@@ -97,7 +98,8 @@
 	/*
 	 * This is required for a soft reboot to work.
 	 */
-	ixp4xx_write16(&info->map, 0xff, 0x55 * 0x2);
+	d.x[0] = 0xff;
+	ixp4xx_write16(&info->map, d, 0x55 * 0x2);
 
 	if (info->mtd) {
 		del_mtd_partitions(info->mtd);



-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment
and will die here like rotten cabbages." - Number 6
