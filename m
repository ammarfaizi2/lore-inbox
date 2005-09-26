Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbVIZAMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbVIZAMt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 20:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbVIZAMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 20:12:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:52412 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751574AbVIZAMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 20:12:48 -0400
Subject: [PATCH] orinoco: Fix flood of kernel log with stupid WE warnings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 10:12:15 +1000
Message-Id: <1127693536.15882.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latest wireless extensions moved a field from netdev ->
wireless_handlers. The WE core will now printk a warning on every call
to get_wireless_stats() on a driver that still uses the old field. This
patch fixes orinoco.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/net/wireless/orinoco.c
===================================================================
--- linux-work.orig/drivers/net/wireless/orinoco.c	2005-09-22 14:06:50.000000000 +1000
+++ linux-work/drivers/net/wireless/orinoco.c	2005-09-26 09:59:44.000000000 +1000
@@ -2458,7 +2458,6 @@
 	dev->watchdog_timeo = HZ; /* 1 second timeout */
 	dev->get_stats = orinoco_get_stats;
 	dev->ethtool_ops = &orinoco_ethtool_ops;
-	dev->get_wireless_stats = orinoco_get_wireless_stats;
 	dev->wireless_handlers = (struct iw_handler_def *)&orinoco_handler_def;
 	dev->change_mtu = orinoco_change_mtu;
 	dev->set_multicast_list = orinoco_set_multicast_list;
@@ -4399,6 +4398,7 @@
 	.standard = orinoco_handler,
 	.private = orinoco_private_handler,
 	.private_args = orinoco_privtab,
+	.get_wireless_stats = orinoco_get_wireless_stats,
 };
 
 static void orinoco_get_drvinfo(struct net_device *dev,


