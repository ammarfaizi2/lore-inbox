Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSI2Q6I>; Sun, 29 Sep 2002 12:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSI2Q6H>; Sun, 29 Sep 2002 12:58:07 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:51388 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262806AbSI2Q6G>;
	Sun, 29 Sep 2002 12:58:06 -0400
Date: Sun, 29 Sep 2002 19:03:24 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209291703.TAA28572@harpo.it.uu.se>
To: mochel@osdl.org, perex@suse.cz
Subject: [PATCH] 2.5.39 isapnp causes drivers/base/core.c:attach() oops
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.39, isapnp's call to device_register() causes an oops in
drivers/base/core.c:attach() since the isapnp_device_driver.devices
list isn't initialised. The patch below initialises this list, which
cures the oops but may or may not be the preferred long-term fix.

/Mikael

--- linux-2.5.39/drivers/pnp/isapnp.c.~1~	Sat Sep 28 11:40:04 2002
+++ linux-2.5.39/drivers/pnp/isapnp.c	Sun Sep 29 16:41:42 2002
@@ -2288,6 +2288,8 @@
 	struct pci_bus *card;
 	struct pci_dev *parent = pci_find_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
 
+	INIT_LIST_HEAD(&isapnp_device_driver.devices);
+
 	isapnp_for_each_card(card) {
 		struct list_head *devlist;
 
