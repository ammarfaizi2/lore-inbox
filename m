Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbTHKQOI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbTHKQB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:01:56 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:14630 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272774AbTHKP7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:59:42 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing copy_to_user check in pc300 wan driver
Message-Id: <E19mF4Z-0005FA-00@tetrachloride>
Date: Mon, 11 Aug 2003 16:59:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/wan/pc300_drv.c linux-2.5/drivers/net/wan/pc300_drv.c
--- bk-linus/drivers/net/wan/pc300_drv.c	2003-08-04 01:00:28.000000000 +0100
+++ linux-2.5/drivers/net/wan/pc300_drv.c	2003-08-06 18:59:40.000000000 +0100
@@ -2623,7 +2623,8 @@ int cpc_ioctl(struct net_device *dev, st
 					       sizeof(struct net_device_stats));
 					if (card->hw.type == PC300_TE)
 						memcpy(&pc300stats.te_stats,&chan->falc,sizeof(falc_t));
-				    copy_to_user(arg, &pc300stats, sizeof(pc300stats_t));
+				    	if (copy_to_user(arg, &pc300stats, sizeof(pc300stats_t)))
+						return -EFAULT;
 				}
 				return 0;
 			}
