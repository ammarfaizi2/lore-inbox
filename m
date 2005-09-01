Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbVIABay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVIABay (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVIABaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:30:23 -0400
Received: from ozlabs.org ([203.10.76.45]:39312 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965024AbVIAB3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:30 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 18/18] iseries_veth: Be consistent about driver name, increment version
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012929.4B45F68249@ozlabs.org>
Date: Thu,  1 Sep 2005 11:29:29 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The iseries_veth driver tells sysfs that it's called 'iseries_veth', but if
you ask it via ethtool it thinks it's called 'veth'. I think this comes from
2.4 when the driver was called 'veth', but it's definitely called
'iseries_veth' now, so fix it.

To make sure we don't do it again define DRV_NAME and use it everywhere.

While we're at it, change the version number to 2.0, to reflect the changes
made in this patch series.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -125,6 +125,9 @@ struct veth_lpevent {
 
 };
 
+#define DRV_NAME	"iseries_veth"
+#define DRV_VERSION	"2.0"
+
 #define VETH_NUMBUFFERS		(120)
 #define VETH_ACKTIMEOUT 	(1000000) /* microseconds */
 #define VETH_MAX_MCAST		(12)
@@ -227,14 +230,14 @@ static void veth_timed_reset(unsigned lo
  */
 
 #define veth_info(fmt, args...) \
-	printk(KERN_INFO "iseries_veth: " fmt, ## args)
+	printk(KERN_INFO DRV_NAME ": " fmt, ## args)
 
 #define veth_error(fmt, args...) \
-	printk(KERN_ERR "iseries_veth: Error: " fmt, ## args)
+	printk(KERN_ERR DRV_NAME ": Error: " fmt, ## args)
 
 #ifdef DEBUG
 #define veth_debug(fmt, args...) \
-	printk(KERN_DEBUG "iseries_veth: " fmt, ## args)
+	printk(KERN_DEBUG DRV_NAME ": " fmt, ## args)
 #else
 #define veth_debug(fmt, args...) do {} while (0)
 #endif
@@ -997,9 +1000,10 @@ static void veth_set_multicast_list(stru
 
 static void veth_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
 {
-	strncpy(info->driver, "veth", sizeof(info->driver) - 1);
+	strncpy(info->driver, DRV_NAME, sizeof(info->driver) - 1);
 	info->driver[sizeof(info->driver) - 1] = '\0';
-	strncpy(info->version, "1.0", sizeof(info->version) - 1);
+	strncpy(info->version, DRV_VERSION, sizeof(info->version) - 1);
+	info->version[sizeof(info->version) - 1] = '\0';
 }
 
 static int veth_get_settings(struct net_device *dev, struct ethtool_cmd *ecmd)
@@ -1642,7 +1646,7 @@ static struct vio_device_id veth_device_
 MODULE_DEVICE_TABLE(vio, veth_device_table);
 
 static struct vio_driver veth_driver = {
-	.name = "iseries_veth",
+	.name = DRV_NAME,
 	.id_table = veth_device_table,
 	.probe = veth_probe,
 	.remove = veth_remove
