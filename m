Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbTFECIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTFECDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:03:42 -0400
Received: from granite.he.net ([216.218.226.66]:57094 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264393AbTFECCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:02:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10547787472227@kroah.com>
Subject: Re: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
In-Reply-To: <10547787472909@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jun 2003 19:05:47 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1254.4.5, 2003/06/03 17:08:26-07:00, greg@kroah.com

[PATCH] IBM PCI hotplug: remove hand made pci_find_bus function.


 drivers/hotplug/ibmphp_core.c |   25 +++----------------------
 1 files changed, 3 insertions(+), 22 deletions(-)


diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Wed Jun  4 18:12:06 2003
+++ b/drivers/hotplug/ibmphp_core.c	Wed Jun  4 18:12:06 2003
@@ -724,25 +724,6 @@
 	return NULL;
 }
 
-/* This routine is to find the pci_bus from kernel structures.
- * Parameters: bus number
- * Returns : pci_bus *  or NULL if not found
- */
-static struct pci_bus *ibmphp_find_bus (u8 busno)
-{
-	const struct list_head *tmp;
-	struct pci_bus *bus;
-	debug ("inside %s, busno = %x \n", __FUNCTION__, busno);
-
-	list_for_each (tmp, &pci_root_buses) {
-		bus = (struct pci_bus *) pci_bus_b (tmp);
-		if (bus)
-			if (bus->number == busno)
-				return bus;
-	}
-	return NULL;
-}
-
 /*************************************************************
  * This routine frees up memory used by struct slot, including
  * the pointers to pci_func, bus, hotplug_slot, controller,
@@ -810,7 +791,7 @@
 	struct pci_dev *dev;
 	u16 l;
 
-	if (ibmphp_find_bus (busno) || !(ibmphp_find_same_bus_num (busno)))
+	if (pci_find_bus(busno) || !(ibmphp_find_same_bus_num (busno)))
 		return 1;
 
 	bus = kmalloc (sizeof (*bus), GFP_KERNEL);
@@ -855,7 +836,7 @@
 		func->dev = pci_find_slot (func->busno, PCI_DEVFN(func->device, func->function));
 
 	if (func->dev == NULL) {
-		struct pci_bus *bus = ibmphp_find_bus (func->busno);
+		struct pci_bus *bus = pci_find_bus(func->busno);
 		if (!bus)
 			return 0;
 
@@ -1377,7 +1358,7 @@
 		goto exit;
 	}
 
-	bus = ibmphp_find_bus (0);
+	bus = pci_find_bus(0);
 	if (!bus) {
 		err ("Can't find the root pci bus, can not continue\n");
 		rc = -ENODEV;

