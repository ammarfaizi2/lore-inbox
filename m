Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUHFCea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUHFCea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUHFCea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:34:30 -0400
Received: from c3-1d224.neo.rr.com ([24.93.233.224]:21890 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S268071AbUHFCdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:33:18 -0400
Date: Thu, 5 Aug 2004 22:24:51 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: rmk@arm.linux.org.uk
Cc: linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: [PATCH] pcmcia driver model support [2/5]
Message-ID: <20040805222451.GC11641@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, rmk@arm.linux.org.uk,
	linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
	linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PCMCIA] update network drivers

This patch updates pcmcia network drivers so that their class devices are linked
to the correct physical device.

diff -urw a/drivers/net/pcmcia/3c574_cs.c b/drivers/net/pcmcia/3c574_cs.c
--- a/drivers/net/pcmcia/3c574_cs.c	2004-08-05 13:05:35.000000000 +0000
+++ b/drivers/net/pcmcia/3c574_cs.c	2004-08-05 13:30:37.000000000 +0000
@@ -519,6 +519,7 @@
 
 	link->state &= ~DEV_CONFIG_PENDING;
 	link->dev = &lp->node;
+	SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
 	if (register_netdev(dev) != 0) {
 		printk(KERN_NOTICE "3c574_cs: register_netdev() failed\n");
diff -urw a/drivers/net/pcmcia/3c589_cs.c b/drivers/net/pcmcia/3c589_cs.c
--- a/drivers/net/pcmcia/3c589_cs.c	2004-08-05 13:05:35.000000000 +0000
+++ b/drivers/net/pcmcia/3c589_cs.c	2004-08-05 13:30:37.000000000 +0000
@@ -391,6 +391,7 @@
     
     link->dev = &lp->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     if (register_netdev(dev) != 0) {
 	printk(KERN_ERR "3c589_cs: register_netdev() failed\n");
diff -urw a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
--- a/drivers/net/pcmcia/axnet_cs.c	2004-08-05 13:05:35.000000000 +0000
+++ b/drivers/net/pcmcia/axnet_cs.c	2004-08-05 13:30:37.000000000 +0000
@@ -458,6 +458,7 @@
     info->phy_id = (i < 32) ? i : -1;
     link->dev = &info->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     if (register_netdev(dev) != 0) {
 	printk(KERN_NOTICE "axnet_cs: register_netdev() failed\n");
diff -urw a/drivers/net/pcmcia/com20020_cs.c b/drivers/net/pcmcia/com20020_cs.c
--- a/drivers/net/pcmcia/com20020_cs.c	2004-08-05 13:05:35.000000000 +0000
+++ b/drivers/net/pcmcia/com20020_cs.c	2004-08-05 13:30:37.000000000 +0000
@@ -394,6 +394,7 @@
 
     link->dev = &info->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     i = com20020_found(dev, 0);	/* calls register_netdev */
     
diff -urw a/drivers/net/pcmcia/fmvj18x_cs.c b/drivers/net/pcmcia/fmvj18x_cs.c
--- a/drivers/net/pcmcia/fmvj18x_cs.c	2004-08-05 13:05:35.000000000 +0000
+++ b/drivers/net/pcmcia/fmvj18x_cs.c	2004-08-05 13:30:37.000000000 +0000
@@ -591,6 +591,7 @@
     lp->cardtype = cardtype;
     link->dev = &lp->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     if (register_netdev(dev) != 0) {
 	printk(KERN_NOTICE "fmvj18x_cs: register_netdev() failed\n");
diff -urw a/drivers/net/pcmcia/ibmtr_cs.c b/drivers/net/pcmcia/ibmtr_cs.c
--- a/drivers/net/pcmcia/ibmtr_cs.c	2004-08-05 13:05:35.000000000 +0000
+++ b/drivers/net/pcmcia/ibmtr_cs.c	2004-08-05 13:30:37.000000000 +0000
@@ -366,6 +366,7 @@
 
     link->dev = &info->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     i = ibmtr_probe_card(dev);
     if (i != 0) {
diff -urw a/drivers/net/pcmcia/nmclan_cs.c b/drivers/net/pcmcia/nmclan_cs.c
--- a/drivers/net/pcmcia/nmclan_cs.c	2004-08-05 13:05:35.000000000 +0000
+++ b/drivers/net/pcmcia/nmclan_cs.c	2004-08-05 13:30:37.000000000 +0000
@@ -775,6 +775,7 @@
 
   link->dev = &lp->node;
   link->state &= ~DEV_CONFIG_PENDING;
+  SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
   i = register_netdev(dev);
   if (i != 0) {
diff -urw a/drivers/net/pcmcia/pcnet_cs.c b/drivers/net/pcmcia/pcnet_cs.c
--- a/drivers/net/pcmcia/pcnet_cs.c	2004-08-05 13:05:35.000000000 +0000
+++ b/drivers/net/pcmcia/pcnet_cs.c	2004-08-05 13:30:37.000000000 +0000
@@ -722,6 +722,7 @@
 
     link->dev = &info->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
     dev->poll_controller = ei_poll;
diff -urw a/drivers/net/pcmcia/smc91c92_cs.c b/drivers/net/pcmcia/smc91c92_cs.c
--- a/drivers/net/pcmcia/smc91c92_cs.c	2004-08-05 13:05:35.000000000 +0000
+++ b/drivers/net/pcmcia/smc91c92_cs.c	2004-08-05 13:30:37.000000000 +0000
@@ -1022,6 +1022,7 @@
 
     link->dev = &smc->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     if (register_netdev(dev) != 0) {
 	printk(KERN_ERR "smc91c92_cs: register_netdev() failed\n");
diff -urw a/drivers/net/pcmcia/xirc2ps_cs.c b/drivers/net/pcmcia/xirc2ps_cs.c
--- a/drivers/net/pcmcia/xirc2ps_cs.c	2004-08-05 13:05:35.000000000 +0000
+++ b/drivers/net/pcmcia/xirc2ps_cs.c	2004-08-05 13:30:37.000000000 +0000
@@ -1121,6 +1121,7 @@
 
     link->dev = &local->node;
     link->state &= ~DEV_CONFIG_PENDING;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 
     if ((err=register_netdev(dev))) {
 	printk(KNOT_XIRC "register_netdev() failed\n");
