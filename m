Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUCKQBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUCKQBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:01:44 -0500
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:41314 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261496AbUCKQBD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:01:03 -0500
Subject: [PATCH] 2.6.4 synclink.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1079020863.1950.5.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Mar 2004 10:01:04 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for synclink.c against 2.6.4

* track driver API changes
* remove cast (kernel janitor)

Please apply.

-- 
Paul Fulghum
paulkf@microgate.com

--- linux-2.6.4/drivers/char/synclink.c	2004-03-11 08:37:38.000000000 -0600
+++ linux-2.6.4-mg1/drivers/char/synclink.c	2004-03-11 08:46:15.000000000 -0600
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 4.16 2003/09/05 15:26:02 paulkf Exp $
+ * $Id: synclink.c,v 4.21 2004/03/08 15:29:22 paulkf Exp $
  *
  * Device driver for Microgate SyncLink ISA and PCI
  * high speed multiprotocol serial adapters.
@@ -909,7 +909,7 @@
 MODULE_PARM(txholdbufs,"1-" __MODULE_STRING(MAX_TOTAL_DEVICES) "i");
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 4.16 $";
+static char *driver_version = "$Revision: 4.21 $";
 
 static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -7846,13 +7846,14 @@
 	info->if_ptr = &info->pppdev;
 	info->netdev = info->pppdev.dev = d;
 
-	sppp_attach(&info->pppdev);
-
 	d->base_addr = info->io_base;
 	d->irq = info->irq_level;
 	d->dma = info->dma_level;
 	d->priv = info;
 
+	sppp_attach(&info->pppdev);
+	mgsl_setup(d);
+
 	if (register_netdev(d)) {
 		printk(KERN_WARNING "%s: register_netdev failed.\n", d->name);
 		sppp_detach(info->netdev);
@@ -8022,7 +8023,7 @@
 
 int mgsl_sppp_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	struct mgsl_struct *info = (struct mgsl_struct *)dev->priv;
+	struct mgsl_struct *info = dev->priv;
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_ioctl %s cmd=%08X\n", __FILE__,__LINE__,
 			info->netname, cmd );



