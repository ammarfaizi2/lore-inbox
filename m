Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbVDBANG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbVDBANG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVDBAMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:12:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:44252 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262953AbVDAXsU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:20 -0500
Cc: kimball.murray@stratus.com
Subject: [PATCH] PCI: Patch for Serverworks chips in hotplug environment
In-Reply-To: <11123992704154@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:50 -0800
Message-Id: <11123992702166@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.6, 2005/03/17 10:23:26-08:00, kimball.murray@stratus.com

[PATCH] PCI: Patch for Serverworks chips in hotplug environment

From: Kimball Murray <kimball.murray@stratus.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/ide/pci/serverworks.c |    8 ++++----
 drivers/pci/quirks.c          |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)


diff -Nru a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverworks.c
--- a/drivers/ide/pci/serverworks.c	2005-04-01 15:38:06 -08:00
+++ b/drivers/ide/pci/serverworks.c	2005-04-01 15:38:06 -08:00
@@ -341,7 +341,7 @@
 	return __ide_dma_end(drive);
 }
 
-static unsigned int __init init_chipset_svwks (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_svwks (struct pci_dev *dev, const char *name)
 {
 	unsigned int reg;
 	u8 btr;
@@ -508,7 +508,7 @@
 }
 
 #undef CAN_SW_DMA
-static void __init init_hwif_svwks (ide_hwif_t *hwif)
+static void __devinit init_hwif_svwks (ide_hwif_t *hwif)
 {
 	u8 dma_stat = 0;
 
@@ -556,7 +556,7 @@
 /*
  * We allow the BM-DMA driver to only work on enabled interfaces.
  */
-static void __init init_dma_svwks (ide_hwif_t *hwif, unsigned long dmabase)
+static void __devinit init_dma_svwks (ide_hwif_t *hwif, unsigned long dmabase)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 
@@ -568,7 +568,7 @@
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static int __init init_setup_svwks (struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_svwks (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	return ide_setup_pci_device(dev, d);
 }
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-04-01 15:38:06 -08:00
+++ b/drivers/pci/quirks.c	2005-04-01 15:38:06 -08:00
@@ -700,7 +700,7 @@
 /*
  *	Serverworks CSB5 IDE does not fully support native mode
  */
-static void __init quirk_svwks_csb5ide(struct pci_dev *pdev)
+static void __devinit quirk_svwks_csb5ide(struct pci_dev *pdev)
 {
 	u8 prog;
 	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);

