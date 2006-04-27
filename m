Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWD0UeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWD0UeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWD0UeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:34:11 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28167 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751410AbWD0Udq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:33:46 -0400
Date: Thu, 27 Apr 2006 22:33:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/ide/: possible cleanups
Message-ID: <20060427203344.GO3570@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible clenups:
- setup-pci.c: #if 0 the unused ide_pci_unregister_driver()
- ide.c: remove the unused EXPORT_SYMBOL(ide_register_hw)
- ide-dma.c: remove the unused EXPORT_SYMBOL_GPL(ide_in_drive_list)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Apr 2006
- 11 Apr 2006

 drivers/ide/ide-dma.c   |    2 --
 drivers/ide/ide.c       |    2 --
 drivers/ide/setup-pci.c |    4 +++-
 include/linux/ide.h     |    1 -
 4 files changed, 3 insertions(+), 6 deletions(-)

--- linux-2.6.17-rc1-mm2-full/include/linux/ide.h.old	2006-04-10 22:46:27.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/include/linux/ide.h	2006-04-10 22:46:36.000000000 +0200
@@ -1188,7 +1188,6 @@
 extern void ide_scan_pcibus(int scan_direction) __init;
 extern int __ide_pci_register_driver(struct pci_driver *driver, struct module *owner);
 #define ide_pci_register_driver(d) __ide_pci_register_driver(d, THIS_MODULE)
-extern void ide_pci_unregister_driver(struct pci_driver *driver);
 void ide_pci_setup_ports(struct pci_dev *, struct ide_pci_device_s *, int, ata_index_t *);
 extern void ide_setup_pci_noise (struct pci_dev *dev, struct ide_pci_device_s *d);
 
--- linux-2.6.17-rc1-mm2-full/drivers/ide/ide.c.old	2006-04-10 22:43:31.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/ide/ide.c	2006-04-10 22:43:41.000000000 +0200
@@ -826,8 +826,6 @@
 	return ide_register_hw_with_fixup(hw, hwifp, NULL);
 }
 
-EXPORT_SYMBOL(ide_register_hw);
-
 /*
  *	Locks for IDE setting functionality
  */
--- linux-2.6.17-rc1-mm2-full/drivers/ide/ide-dma.c.old	2006-04-10 22:44:21.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/ide/ide-dma.c	2006-04-10 22:44:28.000000000 +0200
@@ -152,8 +152,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ide_in_drive_list);
-
 /**
  *	ide_dma_intr	-	IDE DMA interrupt handler
  *	@drive: the drive the interrupt is for
--- linux-2.6.17-rc1-mm2-full/drivers/ide/setup-pci.c.old	2006-04-10 22:46:46.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/ide/setup-pci.c	2006-04-10 22:47:03.000000000 +0200
@@ -807,7 +807,8 @@
  *	Unregister a currently installed IDE driver. Returns are the same
  *	as for pci_unregister_driver
  */
- 
+
+#if 0
 void ide_pci_unregister_driver(struct pci_driver *driver)
 {
 	if(!pre_init)
@@ -817,6 +818,7 @@
 }
 
 EXPORT_SYMBOL_GPL(ide_pci_unregister_driver);
+#endif  /*  0  */
 
 /**
  *	ide_scan_pcidev		-	find an IDE driver for a device


