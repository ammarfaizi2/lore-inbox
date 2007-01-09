Return-Path: <linux-kernel-owner+w=401wt.eu-S932242AbXAIS2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbXAIS2e (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbXAIS2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:28:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59299 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118AbXAIS2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:28:32 -0500
Date: Tue, 9 Jan 2007 10:26:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Cc: "Jeff Garzik" <jeff@garzik.org>, "Conke Hu" <conke.hu@gmail.com>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 3/3] atiixp.c: add cable detection support for ATI IDE
Message-Id: <20070109102618.e2c35b9c.akpm@osdl.org>
In-Reply-To: <58cb370e0701090554s6aa3d1derc7d2188598644d79@mail.gmail.com>
References: <5767b9100701060422p1abd1d21x606b758220815551@mail.gmail.com>
	<58cb370e0701061816s308155abw719a00d499f504ea@mail.gmail.com>
	<5767b9100701090453g51448661td14e4c05a4eceb2a@mail.gmail.com>
	<45A392C7.1030309@garzik.org>
	<58cb370e0701090554s6aa3d1derc7d2188598644d79@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 14:54:01 +0100
"Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com> wrote:

> The good news is that it doesn't matter now as Andrew fixed Conke's patches
> manually and applied them to -mm

I applied three pathces, but there's been such a storm of inadequately
changelogged mangled patches that I have little confidence that what I
applied was complete and up-to-date.

> [ but without my Acked-by-s :( ].

oop.

Here are the three patches.  Conke, can you please tell us whether this is
all correct and complete?


From: "Conke Hu" <conke.hu@gmail.com>

A previous patch to atiixp.c was removed but some code has not been
cleaned. Now we remove these code sine they are no use any longer.

Signed-off-by: Conke Hu <conke.hu@amd.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ide/pci/atiixp.c |   21 +--------------------
 1 files changed, 1 insertion(+), 20 deletions(-)

diff -puN drivers/ide/pci/atiixp.c~atiixpc-remove-unused-code drivers/ide/pci/atiixp.c
--- a/drivers/ide/pci/atiixp.c~atiixpc-remove-unused-code
+++ a/drivers/ide/pci/atiixp.c
@@ -320,19 +320,6 @@ static void __devinit init_hwif_atiixp(i
 	hwif->drives[0].autodma = hwif->autodma;
 }
 
-static void __devinit init_hwif_sb600_legacy(ide_hwif_t *hwif)
-{
-
-	hwif->atapi_dma = 1;
-	hwif->ultra_mask = 0x7f;
-	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
-}
 
 static ide_pci_device_t atiixp_pci_info[] __devinitdata = {
 	{	/* 0 */
@@ -342,13 +329,7 @@ static ide_pci_device_t atiixp_pci_info[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
 		.bootable	= ON_BOARD,
-	},{	/* 1 */
-		.name		= "ATI SB600 SATA Legacy IDE",
-		.init_hwif	= init_hwif_sb600_legacy,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
+	},
 };
 
 /**
_



From: "Conke Hu" <conke.hu@gmail.com>

AMD/ATI SB600 IDE/PATA controller only has one channel.

Signed-off-by: Conke Hu <conke.hu@amd.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ide/pci/atiixp.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff -puN drivers/ide/pci/atiixp.c~atiixpc-sb600-ide-only-has-one-channel drivers/ide/pci/atiixp.c
--- a/drivers/ide/pci/atiixp.c~atiixpc-sb600-ide-only-has-one-channel
+++ a/drivers/ide/pci/atiixp.c
@@ -329,7 +329,14 @@ static ide_pci_device_t atiixp_pci_info[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
 		.bootable	= ON_BOARD,
-	},
+	},{	/* 1 */
+		.name		= "SB600_PATA",
+		.init_hwif	= init_hwif_atiixp,
+		.channels	= 1,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x48,0x01,0x00}, {0x00,0x00,0x00}},
+ 		.bootable	= ON_BOARD,
+ 	},
 };
 
 /**
@@ -350,7 +357,7 @@ static struct pci_device_id atiixp_pci_t
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP200_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
_


From: "Conke Hu" <conke.hu@gmail.com>

IDE HDD does not work if it uses a 40-pin PATA cable on ATI chipset.
This patch fixes the bug.

Signed-off-by: Conke Hu <conke.hu@amd.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ide/pci/atiixp.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff -puN drivers/ide/pci/atiixp.c~atiixpc-add-cable-detection-support-for-ati-ide drivers/ide/pci/atiixp.c
--- a/drivers/ide/pci/atiixp.c~atiixpc-add-cable-detection-support-for-ati-ide
+++ a/drivers/ide/pci/atiixp.c
@@ -291,8 +291,12 @@ fast_ata_pio:
 
 static void __devinit init_hwif_atiixp(ide_hwif_t *hwif)
 {
+	u8 udma_mode = 0;
+	u8 ch = hwif->channel;
+	struct pci_dev *pdev = hwif->pci_dev;
+
 	if (!hwif->irq)
-		hwif->irq = hwif->channel ? 15 : 14;
+		hwif->irq = ch ? 15 : 14;
 
 	hwif->autodma = 0;
 	hwif->tuneproc = &atiixp_tuneproc;
@@ -308,8 +312,12 @@ static void __devinit init_hwif_atiixp(i
 	hwif->mwdma_mask = 0x06;
 	hwif->swdma_mask = 0x04;
 
-	/* FIXME: proper cable detection needed */
-	hwif->udma_four = 1;
+	pci_read_config_byte(pdev, ATIIXP_IDE_UDMA_MODE + ch, &udma_mode);
+	if ((udma_mode & 0x07) >= 0x04 || (udma_mode & 0x70) >= 0x40)
+		hwif->udma_four = 1;
+	else
+		hwif->udma_four = 0;
+
 	hwif->ide_dma_host_on = &atiixp_ide_dma_host_on;
 	hwif->ide_dma_host_off = &atiixp_ide_dma_host_off;
 	hwif->ide_dma_check = &atiixp_dma_check;
_

