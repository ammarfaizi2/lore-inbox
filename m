Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUCKQJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUCKQJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:09:00 -0500
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:7267 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261497AbUCKQG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:06:56 -0500
Subject: [PATCH] 2.6.4 synclink_cs.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1079021215.1950.14.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Mar 2004 10:06:56 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for synclink_cs.c against 2.6.4

* Track driver API changes
* Remove cast (kernel janitor)

Please apply.

-- 
Paul Fulghum
paulkf@microgate.com

--- linux-2.6.4/drivers/char/pcmcia/synclink_cs.c	2004-03-11 08:37:38.000000000 -0600
+++ linux-2.6.4-mg1/drivers/char/pcmcia/synclink_cs.c	2004-03-11 08:46:43.000000000 -0600
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/pcmcia/synclink_cs.c
  *
- * $Id: synclink_cs.c,v 4.15 2003/09/05 15:26:02 paulkf Exp $
+ * $Id: synclink_cs.c,v 4.21 2004/03/08 15:29:23 paulkf Exp $
  *
  * Device driver for Microgate SyncLink PC Card
  * multiprotocol serial adapter.
@@ -489,7 +489,7 @@
 MODULE_LICENSE("GPL");
 
 static char *driver_name = "SyncLink PC Card driver";
-static char *driver_version = "$Revision: 4.15 $";
+static char *driver_version = "$Revision: 4.21 $";
 
 static struct tty_driver *serial_driver;
 
@@ -4233,12 +4233,13 @@
 	info->if_ptr = &info->pppdev;
 	info->netdev = info->pppdev.dev = d;
 
-	sppp_attach(&info->pppdev);
-
 	d->base_addr = info->io_base;
 	d->irq = info->irq_level;
 	d->priv = info;
 
+	sppp_attach(&info->pppdev);
+	mgslpc_setup(d);
+
 	if (register_netdev(d)) {
 		printk(KERN_WARNING "%s: register_netdev failed.\n", d->name);
 		sppp_detach(info->netdev);
@@ -4413,7 +4414,7 @@
 
 int mgslpc_sppp_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	MGSLPC_INFO *info = (MGSLPC_INFO *)dev->priv;
+	MGSLPC_INFO *info = dev->priv;
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_ioctl %s cmd=%08X\n", __FILE__,__LINE__,
 			info->netname, cmd );



