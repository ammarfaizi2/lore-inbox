Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267659AbRGPSom>; Mon, 16 Jul 2001 14:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267658AbRGPSod>; Mon, 16 Jul 2001 14:44:33 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:24837 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S267663AbRGPSoX>; Mon, 16 Jul 2001 14:44:23 -0400
Date: Mon, 16 Jul 2001 19:27:34 +0100 (BST)
From: Peter Denison <peterd@pnd-pc.demon.co.uk>
To: Andre Hedrick <andre@linux-ide.org>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.4.6] Use dev->slot_name in ide-pci.c
Message-ID: <Pine.LNX.4.33.0107160731420.1095-100000@pnd-pc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a simple patch to cleanup ide-pci.c, so as to use the uniform
pci_dev->slot_name string available as a description, rather than the
previous (inadequately specific) bus->number and devfn fields.

--- drivers/ide/ide-pci.c.old	Sun Jul 15 16:43:55 2001
+++ drivers/ide/ide-pci.c	Sun Jul 15 17:27:19 2001
@@ -760,7 +760,7 @@

 	switch(class_rev) {
 		case 4:
-		case 3:	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
+		case 3:	printk("%s: IDE controller on PCI slot %s\n", d->name, dev->slot_name);
 			ide_setup_pci_device(dev, d);
 			return;
 		default:	break;
@@ -783,12 +783,12 @@
 			break;
 		}
 	}
-	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
+	printk("%s: IDE controller on PCI slot %s\n", d->name, dev->slot_name);
 	ide_setup_pci_device(dev, d);
 	if (!dev2)
 		return;
 	d2 = d;
-	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d2->name, dev2->bus->number, dev2->devfn);
+	printk("%s: IDE controller on PCI slot %s\n", d2->name, dev2->slot_name);
 	ide_setup_pci_device(dev2, d2);
 }

@@ -816,10 +816,10 @@
 		hpt366_device_order_fixup(dev, d);
 	else if (!IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL) || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		if (IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL))
-			printk("%s: unknown IDE controller on PCI bus %02x device %02x, VID=%04x, DID=%04x\n",
-			       d->name, dev->bus->number, dev->devfn, devid.vid, devid.did);
+			printk("%s: unknown IDE controller on PCI slot %s, VID=%04x, DID=%04x\n",
+			       d->name, dev->slot_name, devid.vid, devid.did);
 		else
-			printk("%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
+			printk("%s: IDE controller on PCI slot %s\n", d->name, dev->slot_name);
 		ide_setup_pci_device(dev, d);
 	}
 }

-- 
Peter Denison <peterd@pnd-pc.demon.co.uk>
Linux Driver for Promise DC4030VL cards.
See http://www.pnd-pc.demon.co.uk/promise/promise.html for details

