Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265294AbUF2AT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbUF2AT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 20:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbUF2AT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 20:19:27 -0400
Received: from cpe-024-033-224-95.neo.rr.com ([24.33.224.95]:34946 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265294AbUF2ATW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 20:19:22 -0400
Date: Mon, 28 Jun 2004 20:15:04 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk, linux@dominikbrodowski.de, akpm@osdl.org,
       rml@ximian.com, greg@kroah.com
Subject: [RFC][PATCH] update drivers/net/pcmcia (2/3)
Message-ID: <20040628201504.GA9446@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
	linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
	greg@kroah.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is needed for class devices to bind to physical devices detected in
drivers/net/pcmcia.

Thanks,
Adam

diff -urw a/drivers/net/pcmcia/3c574_cs.c b/drivers/net/pcmcia/3c574_cs.c
--- a/drivers/net/pcmcia/3c574_cs.c	2004-05-10 02:32:26.000000000 +0000
+++ b/drivers/net/pcmcia/3c574_cs.c	2004-06-24 14:16:47.000000000 +0000
@@ -518,6 +518,7 @@
 
 	link->state &= ~DEV_CONFIG_PENDING;
 	link->dev = &lp->node;
+	SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
 	if (register_netdev(dev) != 0) {
 		printk(KERN_NOTICE "3c574_cs: register_netdev() failed\n");
diff -urw a/drivers/net/pcmcia/3c589_cs.c b/drivers/net/pcmcia/3c589_cs.c
--- a/drivers/net/pcmcia/3c589_cs.c	2004-05-10 02:33:20.000000000 +0000
+++ b/drivers/net/pcmcia/3c589_cs.c	2004-06-24 14:17:36.000000000 +0000
@@ -390,6 +390,7 @@
     
     link->dev = &lp->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     if (register_netdev(dev) != 0) {
 	printk(KERN_ERR "3c589_cs: register_netdev() failed\n");
diff -urw a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
--- a/drivers/net/pcmcia/axnet_cs.c	2004-05-10 02:32:38.000000000 +0000
+++ b/drivers/net/pcmcia/axnet_cs.c	2004-06-24 14:18:09.000000000 +0000
@@ -457,6 +457,7 @@
     info->phy_id = (i < 32) ? i : -1;
     link->dev = &info->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     if (register_netdev(dev) != 0) {
 	printk(KERN_NOTICE "axnet_cs: register_netdev() failed\n");
diff -urw a/drivers/net/pcmcia/com20020_cs.c b/drivers/net/pcmcia/com20020_cs.c
--- a/drivers/net/pcmcia/com20020_cs.c	2004-05-10 02:32:29.000000000 +0000
+++ b/drivers/net/pcmcia/com20020_cs.c	2004-06-24 14:19:22.000000000 +0000
@@ -396,6 +396,7 @@
 
     link->dev = &info->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     i = com20020_found(dev, 0);	/* calls register_netdev */
     
diff -urw a/drivers/net/pcmcia/fmvj18x_cs.c b/drivers/net/pcmcia/fmvj18x_cs.c
--- a/drivers/net/pcmcia/fmvj18x_cs.c	2004-05-10 02:32:53.000000000 +0000
+++ b/drivers/net/pcmcia/fmvj18x_cs.c	2004-06-24 14:19:52.000000000 +0000
@@ -590,6 +590,7 @@
     lp->cardtype = cardtype;
     link->dev = &lp->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     if (register_netdev(dev) != 0) {
 	printk(KERN_NOTICE "fmvj18x_cs: register_netdev() failed\n");
diff -urw a/drivers/net/pcmcia/ibmtr_cs.c b/drivers/net/pcmcia/ibmtr_cs.c
--- a/drivers/net/pcmcia/ibmtr_cs.c	2004-05-10 02:32:37.000000000 +0000
+++ b/drivers/net/pcmcia/ibmtr_cs.c	2004-06-24 14:21:33.000000000 +0000
@@ -366,6 +366,7 @@
 
     link->dev = &info->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     i = ibmtr_probe_card(dev);
     if (i != 0) {
diff -urw a/drivers/net/pcmcia/nmclan_cs.c b/drivers/net/pcmcia/nmclan_cs.c
--- a/drivers/net/pcmcia/nmclan_cs.c	2004-05-10 02:32:00.000000000 +0000
+++ b/drivers/net/pcmcia/nmclan_cs.c	2004-06-24 14:22:21.000000000 +0000
@@ -774,6 +774,7 @@
 
   link->dev = &lp->node;
   link->state &= ~DEV_CONFIG_PENDING;
+  SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
   i = register_netdev(dev);
   if (i != 0) {
diff -urw a/drivers/net/pcmcia/pcnet_cs.c b/drivers/net/pcmcia/pcnet_cs.c
--- a/drivers/net/pcmcia/pcnet_cs.c	2004-05-10 02:33:13.000000000 +0000
+++ b/drivers/net/pcmcia/pcnet_cs.c	2004-06-24 14:25:38.000000000 +0000
@@ -721,6 +721,7 @@
 
     link->dev = &info->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
     dev->poll_controller = ei_poll;
diff -urw a/drivers/net/pcmcia/smc91c92_cs.c b/drivers/net/pcmcia/smc91c92_cs.c
--- a/drivers/net/pcmcia/smc91c92_cs.c	2004-05-10 02:32:53.000000000 +0000
+++ b/drivers/net/pcmcia/smc91c92_cs.c	2004-06-24 14:27:25.000000000 +0000
@@ -1021,6 +1021,7 @@
 
     link->dev = &smc->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     if (register_netdev(dev) != 0) {
 	printk(KERN_ERR "smc91c92_cs: register_netdev() failed\n");
diff -urw a/drivers/net/pcmcia/xirc2ps_cs.c b/drivers/net/pcmcia/xirc2ps_cs.c
--- a/drivers/net/pcmcia/xirc2ps_cs.c	2004-05-10 02:32:28.000000000 +0000
+++ b/drivers/net/pcmcia/xirc2ps_cs.c	2004-06-24 14:29:03.000000000 +0000
@@ -1120,6 +1120,7 @@
 
     link->dev = &local->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     if ((err=register_netdev(dev))) {
 	printk(KNOT_XIRC "register_netdev() failed\n");
