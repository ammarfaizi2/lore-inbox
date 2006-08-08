Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWHHLqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWHHLqW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWHHLqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:46:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59613 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964788AbWHHLqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:46:21 -0400
Subject: PATCH: just a small update for the ALi driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Aug 2006 13:06:05 +0100
Message-Id: <1155038765.5729.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct register for high dma mode
Turn on MWDMA
Correct linuxdoc

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.18-rc3-mm2/drivers/scsi/pata_ali.c	2006-08-07 16:20:34.000000000 +0100
+++ linux-2.6.18-rc3-mm2/drivers/scsi/pata_ali.c	2006-08-07 16:36:32.000000000 +0100
@@ -34,7 +34,7 @@
 #include <linux/dmi.h>
 
 #define DRV_NAME "pata_ali"
-#define DRV_VERSION "0.6.4"
+#define DRV_VERSION "0.6.5"
 
 /*
  *	Cable special cases
@@ -198,10 +198,10 @@
  *	@adev: Device the timing is for
  *	@cmd: Command timing
  *	@data: Data timing
- *	@udma: UDMA timing or zero for off
+ *	@ultra: UDMA timing or zero for off
  *
  *	Loads the timing registers for cmd/data and disable UDMA if
- *	udma is zero. If udma is set then load and enable the UDMA
+ *	ultra is zero. If ultra is set then load and enable the UDMA
  *	timing but do not touch the command/data timing.
  */
 
@@ -292,10 +292,10 @@
 	if (adev->dma_mode >= XFER_UDMA_0) {
 		ali_program_modes(ap, adev, NULL, udma_timing[adev->dma_mode - XFER_UDMA_0]);
 		if (adev->dma_mode >= XFER_UDMA_3) {
-			u8 reg54;
-			pci_read_config_byte(pdev, 0x54, &reg54);
-			reg54 |= 1;
-			pci_write_config_byte(pdev, 0x54, reg54);
+			u8 reg4b;
+			pci_read_config_byte(pdev, 0x4B, &reg4b);
+			reg4b |= 1;
+			pci_write_config_byte(pdev, 0x4B, reg4b);
 		}
 	} else {
 		ata_timing_compute(adev, adev->dma_mode, &t, T, 1);
@@ -518,7 +518,7 @@
 		.sht = &ali_sht,
 		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
-		/*.mwdma_mask = 0x07,*/
+		.mwdma_mask = 0x07,
 		.port_ops = &ali_20_port_ops
 	};
 	/* Revision 0x20 with support logic added UDMA */
@@ -526,7 +526,7 @@
 		.sht = &ali_sht,
 		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
-		/*.mwdma_mask = 0x07, */
+		.mwdma_mask = 0x07, 
 		.udma_mask = 0x07,	/* UDMA33 */
 		.port_ops = &ali_20_port_ops
 	};
@@ -535,7 +535,7 @@
 		.sht = &ali_sht,
 		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
-		/*.mwdma_mask = 0x07, */
+		.mwdma_mask = 0x07,
 		.udma_mask = 0x1f,
 		.port_ops = &ali_c2_port_ops
 	};
@@ -544,7 +544,7 @@
 		.sht = &ali_sht,
 		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
-		/* .mwdma_mask = 0x07, */
+		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
 		.port_ops = &ali_c2_port_ops
 	};
@@ -553,7 +553,7 @@
 		.sht = &ali_sht,
 		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
-		/* .mwdma_mask = 0x07, */
+		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,
 		.port_ops = &ali_c2_port_ops
 	};
@@ -562,7 +562,7 @@
 		.sht = &ali_sht,
 		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask = 0x1f,
-		/* .mwdma_mask = 0x07, */
+		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,
 		.port_ops = &ali_c5_port_ops
 	};

