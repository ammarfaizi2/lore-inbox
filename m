Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274871AbTHPQvq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 12:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274880AbTHPQvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 12:51:46 -0400
Received: from AMarseille-201-1-3-2.w193-253.abo.wanadoo.fr ([193.253.250.2]:25640
	"EHLO gaston") by vger.kernel.org with ESMTP id S274871AbTHPQvp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 12:51:45 -0400
Subject: [PATCH] PowerMac: Update for removal of device->name
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061052662.598.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Aug 2003 18:51:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

This patch fix build of PowerMac driver core with the removal
of struct device "name" field. Please apply. It doesn't depend
not breaks the other pending PowerMac patches.

Ben.

===== arch/ppc/syslib/of_device.c 1.1 vs edited =====
--- 1.1/arch/ppc/syslib/of_device.c	Sat Aug  9 18:40:04 2003
+++ edited/arch/ppc/syslib/of_device.c	Sat Aug 16 18:48:20 2003
@@ -227,8 +227,6 @@
 	dev->dev.parent = NULL;
 	dev->dev.bus = &of_platform_bus_type;
 
-	/* XXX Make something better here ? */
-	snprintf(dev->dev.name, DEVICE_NAME_SIZE, "Platform device %s", np->name);
 	reg = (u32 *)get_property(np, "reg", NULL);
 	strlcpy(dev->dev.bus_id, bus_id, BUS_ID_SIZE);
 
===== drivers/macintosh/macio_asic.c 1.1 vs edited =====
--- 1.1/drivers/macintosh/macio_asic.c	Sat Aug  9 18:40:04 2003
+++ edited/drivers/macintosh/macio_asic.c	Sat Aug 16 18:47:51 2003
@@ -141,9 +141,6 @@
 	dev->ofdev.dev.parent = parent;
 	dev->ofdev.dev.bus = &macio_bus_type;
 
-	/* XXX Make something better here ? */
-	snprintf(dev->ofdev.dev.name, DEVICE_NAME_SIZE, "MacIO device %s", np->name);
-
 	/* MacIO itself has a different reg, we use it's PCI base */
 	if (np == chip->of_node) {
 		sprintf(dev->ofdev.dev.bus_id, "%1d.%08lx:%.8s", chip->lbus.index,

