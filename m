Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132226AbRAFTz2>; Sat, 6 Jan 2001 14:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132806AbRAFTzS>; Sat, 6 Jan 2001 14:55:18 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:51215 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S132226AbRAFTzO>; Sat, 6 Jan 2001 14:55:14 -0500
Date: Sat, 6 Jan 2001 18:34:02 +0000 (GMT)
From: Peter Denison <peterd@pnd-pc.demon.co.uk>
To: andre@linux-ide.org
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] Cleanup of PCI device reporting in IDE driver (2.4.0)
Message-ID: <Pine.LNX.4.21.0101061820310.21275-100000@pnd-pc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
Cleans up the reporting of PCI device numbers when they are printed out by
the PCI IDE driver. The dev->devfn value holds both the device number and
the function number, so it's nicer if they are split out and displayed
separately to the user.

Applies against 2.4.0

--- drivers/ide/ide-pci.c.old	Sat Jan  6 17:51:09 2001
+++ drivers/ide/ide-pci.c	Sat Jan  6 18:09:18 2001
@@ -734,7 +734,7 @@
 
 	switch(class_rev) {
 		case 4:
-		case 3:	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
+		case 3:	printk("%s: IDE controller on PCI bus %02x dev %02x fn %02x\n", d->name, dev->bus->number, dev->devfn >> 3, dev->devfn & 7);
 			ide_setup_pci_device(dev, d);
 			return;
 		default:	break;
@@ -757,12 +757,12 @@
 			break;
 		}
 	}
-	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
+	printk("%s: IDE controller on PCI bus %02x dev %02x fn %02x\n", d->name, dev->bus->number, dev->devfn >> 3, dev->devfn & 7);
 	ide_setup_pci_device(dev, d);
 	if (!dev2)
 		return;
 	d2 = d;
-	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d2->name, dev2->bus->number, dev2->devfn);
+	printk("%s: IDE controller on PCI bus %02x dev %02x fn %02x\n", d2->name, dev2->bus->number, dev2->devfn >> 3, dev2->devfn & 7);
 	ide_setup_pci_device(dev2, d2);
 }
 
@@ -790,10 +790,10 @@
 		hpt366_device_order_fixup(dev, d);
 	else if (!IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL) || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		if (IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL))
-			printk("%s: unknown IDE controller on PCI bus %02x device %02x, VID=%04x, DID=%04x\n",
-			       d->name, dev->bus->number, dev->devfn, devid.vid, devid.did);
+			printk("%s: unknown IDE controller on PCI bus %02x device %02x fn %02x, VID=%04x, DID=%04x\n",
+			       d->name, dev->bus->number, dev->devfn >> 3, dev->devfn & 7, devid.vid, devid.did);
 		else
-			printk("%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
+			printk("%s: IDE controller on PCI bus %02x dev %02x fn %02x\n", d->name, dev->bus->number, dev->devfn >> 3, dev->devfn & 7);
 		ide_setup_pci_device(dev, d);
 	}
 }

-- 
Peter Denison <peterd@pnd-pc.demon.co.uk>
Linux Driver for Promise DC4030VL cards.
See http://www.pnd-pc.demon.co.uk/promise/promise.html for details

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
