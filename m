Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265565AbTGCIZN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 04:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265567AbTGCIZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 04:25:13 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:20728 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S265565AbTGCIZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 04:25:11 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] (trivial 2.5.74) compilation fix drivers/mtd/mtd_blkdevs.c
From: junkio@cox.net
Date: Thu, 03 Jul 2003 01:39:31 -0700
Message-ID: <7vbrwc3sxo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C does not let us declar variables in the middle of a block (yet).

--- 2.5.74/drivers/mtd/mtd_blkdevs.c	2003-07-03 01:32:27.000000000 -0700
+++ 2.5.74/drivers/mtd/mtd_blkdevs.c	2003-07-03 01:32:56.000000000 -0700
@@ -211,9 +211,10 @@
 	case HDIO_GETGEO:
 		if (tr->getgeo) {
 			struct hd_geometry g;
+			int ret;
 
 			memset(&g, 0, sizeof(g));
-			int ret = tr->getgeo(dev, &g);
+			ret = tr->getgeo(dev, &g);
 			if (ret)
 				return ret;

                                

