Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbVIUViX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbVIUViX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVIUViX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:38:23 -0400
Received: from iits01137.inlink.com ([209.135.140.137]:5543 "EHLO robertk.com")
	by vger.kernel.org with ESMTP id S965026AbVIUViW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:38:22 -0400
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH 2.6.13] drivers/ide: Enable basic VIA VT6410 IDE functionality
Date: Wed, 21 Sep 2005 16:38:11 -0500
From: "Robert Kesterson" <robertk@robertk.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.sxg2dxd5wc4mme@new.robertk.com>
User-Agent: Opera M2/8.50 (Linux, build 1358)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables plain IDE functionality on the VIA VT6410 IDE controller
(such as used on the Asus P4P800 Deluxe motherboard).  This is not a RAID
driver, but you can use Linux's software RAID once the drives are visible.
I did not write the original version of this patch, which I found on the
internet back in the days of kernel 2.6.2.  I have been unable to identify
the original author to give him/her proper credit.  I have been maintaining
and updating this patch since then and have released several updates which
have been successfully used by others who have downloaded it from my
website.

It seems appropriate that this minimal functionality should be in the
mainstream kernel.

Signed-off-by: Robert Kesterson <robertk@robertk.com>

diff -rup linux-2.6.13.2.orig/drivers/ide/pci/generic.c linux-2.6.13.2/drivers/ide/pci/generic.c
--- linux-2.6.13.2.orig/drivers/ide/pci/generic.c	2005-09-16 20:02:12.000000000 -0500
+++ linux-2.6.13.2/drivers/ide/pci/generic.c	2005-09-21 16:27:38.000000000 -0500
@@ -179,6 +179,12 @@ static ide_pci_device_t generic_chipsets
  		.channels	= 2,
  		.autodma	= AUTODMA,
  		.bootable	= OFF_BOARD,
+	},{	/* 15 */
+		.name		= "VIA_610",
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
  	}
  };

@@ -238,6 +244,7 @@ static struct pci_device_id generic_pci_
  	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
  	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13},
  	{ PCI_VENDOR_ID_NETCELL,PCI_DEVICE_ID_REVOLUTION,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14},
+	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_610,             PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15},
  	/* Must come last. If you add entries adjust this table appropriately and the init_one code */
  	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 0},
  	{ 0, },
diff -rup linux-2.6.13.2.orig/include/linux/pci_ids.h linux-2.6.13.2/include/linux/pci_ids.h
--- linux-2.6.13.2.orig/include/linux/pci_ids.h	2005-09-16 20:02:12.000000000 -0500
+++ linux-2.6.13.2/include/linux/pci_ids.h	2005-09-21 16:27:38.000000000 -0500
@@ -1413,6 +1413,7 @@
  #define PCI_DEVICE_ID_VIA_8703_51_0	0x3148
  #define PCI_DEVICE_ID_VIA_8237_SATA	0x3149
  #define PCI_DEVICE_ID_VIA_XN266		0x3156
+#define PCI_DEVICE_ID_VIA_610		0x3164
  #define PCI_DEVICE_ID_VIA_8754C_0	0x3168
  #define PCI_DEVICE_ID_VIA_8235		0x3177
  #define PCI_DEVICE_ID_VIA_P4N333	0x3178
