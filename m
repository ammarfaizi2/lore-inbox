Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265539AbUBJADZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 19:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbUBJABF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 19:01:05 -0500
Received: from mail.kroah.org ([65.200.24.183]:57020 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265398AbUBIXWc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:32 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689403720@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:21 -0800
Message-Id: <10763689413661@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.16, 2004/02/03 16:54:54-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: make ibm_unconfigure_device void

ibm_unconfigure_device always returns 0, so we do not need to check for a
return value != 0 and can kill the warning. And if the return value is always
the same we don't need a return value. Also some whitespace fixing. And this
time not line wrapped. Really. Absolutely sure. Checked twice.


 drivers/pci/hotplug/ibmphp_core.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	Mon Feb  9 14:58:42 2004
+++ b/drivers/pci/hotplug/ibmphp_core.c	Mon Feb  9 14:58:42 2004
@@ -704,21 +704,20 @@
 	debug ("%s -- exit\n", __FUNCTION__);
 }
 
-static int ibm_unconfigure_device (struct pci_func *func)
+static void ibm_unconfigure_device(struct pci_func *func)
 {
 	struct pci_dev *temp;
 	u8 j;
 
-	debug ("inside %s\n", __FUNCTION__);
-	debug ("func->device = %x, func->function = %x\n", func->device, func->function);
-	debug ("func->device << 3 | 0x0  = %x\n", func->device << 3 | 0x0);
+	debug("inside %s\n", __FUNCTION__);
+	debug("func->device = %x, func->function = %x\n", func->device, func->function);
+	debug("func->device << 3 | 0x0  = %x\n", func->device << 3 | 0x0);
 
 	for (j = 0; j < 0x08; j++) {
-		temp = pci_find_slot (func->busno, (func->device << 3) | j);
+		temp = pci_find_slot(func->busno, (func->device << 3) | j);
 		if (temp)
 			pci_remove_bus_device(temp);
 	}
-	return 0;
 }
 
 /*
@@ -1192,12 +1191,7 @@
 		slot_cur->func->device = slot_cur->device;
 	}
 
-	if ((rc = ibm_unconfigure_device (slot_cur->func))) {
-		err ("removing from kernel failed... \n");
-		err ("Please check to see if it was statically linked or is "
-		     "in use otherwise. (perhaps the driver is not 'hot-removable')\n");
-		goto error;
-	}
+	ibm_unconfigure_device(slot_cur->func);
         
 	/* If we got here from latch suddenly opening on operating card or 
 	a power fault, there's no power to the card, so cannot

