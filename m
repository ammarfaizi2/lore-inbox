Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262911AbVAQWVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbVAQWVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbVAQWUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:20:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:22961 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262927AbVAQWCG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:02:06 -0500
Cc: jbarnes@sgi.com
Subject: [PATCH] PCI: rom.c cleanups
In-Reply-To: <11059993122763@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 14:01:52 -0800
Message-Id: <11059993121957@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.5, 2005/01/14 15:58:13-08:00, jbarnes@sgi.com

[PATCH] PCI: rom.c cleanups

Greg, here's some whitespace and long line cleanup I wanted to do last time I
touched rom.c, but forgot.  Does it look ok to you, Jon?

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/rom.c |   80 +++++++++++++++++++++++++++---------------------------
 1 files changed, 41 insertions(+), 39 deletions(-)


diff -Nru a/drivers/pci/rom.c b/drivers/pci/rom.c
--- a/drivers/pci/rom.c	2005-01-17 13:55:59 -08:00
+++ b/drivers/pci/rom.c	2005-01-17 13:55:59 -08:00
@@ -5,10 +5,7 @@
  * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
  *
  * PCI ROM access routines
- *
  */
-
-
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -24,11 +21,10 @@
  * between the ROM and other resources, so enabling it may disable access
  * to MMIO registers or other card memory.
  */
-static void
-pci_enable_rom(struct pci_dev *pdev)
+static void pci_enable_rom(struct pci_dev *pdev)
 {
 	u32 rom_addr;
-	
+
 	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
 	rom_addr |= PCI_ROM_ADDRESS_ENABLE;
 	pci_write_config_dword(pdev, pdev->rom_base_reg, rom_addr);
@@ -41,8 +37,7 @@
  * Disable ROM decoding on a PCI device by turning off the last bit in the
  * ROM BAR.
  */
-static void
-pci_disable_rom(struct pci_dev *pdev)
+static void pci_disable_rom(struct pci_dev *pdev)
 {
 	u32 rom_addr;
 	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
@@ -57,7 +52,7 @@
  * @return: kernel virtual pointer to image of ROM
  *
  * Map a PCI ROM into kernel space. If ROM is boot video ROM,
- * the shadow BIOS copy will be returned instead of the 
+ * the shadow BIOS copy will be returned instead of the
  * actual ROM.
  */
 void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
@@ -67,10 +62,12 @@
 	void __iomem *rom;
 	void __iomem *image;
 	int last_image;
-	
-	if (res->flags & IORESOURCE_ROM_SHADOW) {	/* IORESOURCE_ROM_SHADOW only set on x86 */
-		start = (loff_t)0xC0000; 	/* primary video rom always starts here */
-		*size = 0x20000;		/* cover C000:0 through E000:0 */
+
+	/* IORESOURCE_ROM_SHADOW only set on x86 */
+	if (res->flags & IORESOURCE_ROM_SHADOW) {
+		/* primary video rom always starts here */
+		start = (loff_t)0xC0000;
+		*size = 0x20000; /* cover C000:0 through E000:0 */
 	} else {
 		if (res->flags & IORESOURCE_ROM_COPY) {
 			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
@@ -79,28 +76,32 @@
 			/* assign the ROM an address if it doesn't have one */
 			if (res->parent == NULL)
 				pci_assign_resource(pdev, PCI_ROM_RESOURCE);
-	
+
 			start = pci_resource_start(pdev, PCI_ROM_RESOURCE);
 			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
 			if (*size == 0)
 				return NULL;
-			
+
 			/* Enable ROM space decodes */
 			pci_enable_rom(pdev);
 		}
 	}
-	
+
 	rom = ioremap(start, *size);
 	if (!rom) {
 		/* restore enable if ioremap fails */
-		if (!(res->flags & (IORESOURCE_ROM_ENABLE | IORESOURCE_ROM_SHADOW | IORESOURCE_ROM_COPY)))
+		if (!(res->flags & (IORESOURCE_ROM_ENABLE |
+				    IORESOURCE_ROM_SHADOW |
+				    IORESOURCE_ROM_COPY)))
 			pci_disable_rom(pdev);
 		return NULL;
-	}		
+	}
 
-	/* Try to find the true size of the ROM since sometimes the PCI window */
-	/* size is much larger than the actual size of the ROM. */
-	/* True size is important if the ROM is going to be copied. */
+	/*
+	 * Try to find the true size of the ROM since sometimes the PCI window
+	 * size is much larger than the actual size of the ROM.
+	 * True size is important if the ROM is going to be copied.
+	 */
 	image = rom;
 	do {
 		void __iomem *pds;
@@ -136,30 +137,30 @@
  * @return: kernel virtual pointer to image of ROM
  *
  * Map a PCI ROM into kernel space. If ROM is boot video ROM,
- * the shadow BIOS copy will be returned instead of the 
+ * the shadow BIOS copy will be returned instead of the
  * actual ROM.
  */
 void __iomem *pci_map_rom_copy(struct pci_dev *pdev, size_t *size)
 {
 	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
 	void __iomem *rom;
-	
+
 	rom = pci_map_rom(pdev, size);
 	if (!rom)
 		return NULL;
-		
+
 	if (res->flags & (IORESOURCE_ROM_COPY | IORESOURCE_ROM_SHADOW))
 		return rom;
-		
+
 	res->start = (unsigned long)kmalloc(*size, GFP_KERNEL);
-	if (!res->start) 
+	if (!res->start)
 		return rom;
 
-	res->end = res->start + *size; 
+	res->end = res->start + *size;
 	memcpy_fromio((void*)res->start, rom, *size);
 	pci_unmap_rom(pdev, rom);
 	res->flags |= IORESOURCE_ROM_COPY;
-	
+
 	return (void __iomem *)res->start;
 }
 
@@ -170,16 +171,15 @@
  *
  * Remove a mapping of a previously mapped ROM
  */
-void 
-pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom)
+void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom)
 {
 	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
 
 	if (res->flags & IORESOURCE_ROM_COPY)
 		return;
-		
+
 	iounmap(rom);
-		
+
 	/* Disable again before continuing, leave enabled if pci=rom */
 	if (!(res->flags & (IORESOURCE_ROM_ENABLE | IORESOURCE_ROM_SHADOW)))
 		pci_disable_rom(pdev);
@@ -189,26 +189,28 @@
  * pci_remove_rom - disable the ROM and remove its sysfs attribute
  * @dev: pointer to pci device struct
  *
+ * Remove the rom file in sysfs and disable ROM decoding.
  */
-void 
-pci_remove_rom(struct pci_dev *pdev) 
+void pci_remove_rom(struct pci_dev *pdev)
 {
 	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
-	
+
 	if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
 		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
-	if (!(res->flags & (IORESOURCE_ROM_ENABLE | IORESOURCE_ROM_SHADOW | IORESOURCE_ROM_COPY)))
+	if (!(res->flags & (IORESOURCE_ROM_ENABLE |
+			    IORESOURCE_ROM_SHADOW |
+			    IORESOURCE_ROM_COPY)))
 		pci_disable_rom(pdev);
 }
 
 /**
- * pci_cleanup_rom - internal routine for freeing the ROM copy created 
+ * pci_cleanup_rom - internal routine for freeing the ROM copy created
  * by pci_map_rom_copy called from remove.c
  * @dev: pointer to pci device struct
  *
+ * Free the copied ROM if we allocated one.
  */
-void 
-pci_cleanup_rom(struct pci_dev *pdev) 
+void pci_cleanup_rom(struct pci_dev *pdev)
 {
 	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
 	if (res->flags & IORESOURCE_ROM_COPY) {

