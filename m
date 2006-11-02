Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752561AbWKBDLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbWKBDLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 22:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbWKBDLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 22:11:09 -0500
Received: from havoc.gtf.org ([69.61.125.42]:3971 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1752544AbWKBDLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 22:11:07 -0500
Date: Wed, 1 Nov 2006 22:11:06 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata fixes
Message-ID: <20061102031106.GA4586@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/ahci.c     |    3 +--
 drivers/ata/ata_piix.c |    1 -
 drivers/ata/sata_nv.c  |   12 ++++++++----
 3 files changed, 9 insertions(+), 7 deletions(-)

Jeff Garzik:
      Revert "Add 0x7110 piix to ata_piix.c"

Peer Chen:
      [libata] sata_nv: Add PCI IDs

Tejun Heo:
      ahci: fix status register check in ahci_softreset

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index cef2e70..988f8bb 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -736,8 +736,7 @@ static int ahci_softreset(struct ata_por
 	}
 
 	/* check BUSY/DRQ, perform Command List Override if necessary */
-	ahci_tf_read(ap, &tf);
-	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
+	if (ahci_check_status(ap) & (ATA_BUSY | ATA_DRQ)) {
 		rc = ahci_clo(ap);
 
 		if (rc == -EOPNOTSUPP) {
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 8385387..720174d 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -168,7 +168,6 @@ static const struct pci_device_id piix_p
 #ifdef ATA_ENABLE_PATA
 	/* Intel PIIX4 for the 430TX/440BX/MX chipset: UDMA 33 */
 	/* Also PIIX4E (fn3 rev 2) and PIIX4M (fn3 rev 3) */
-	{ 0x8086, 0x7110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
 	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
 	{ 0x8086, 0x24db, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	{ 0x8086, 0x25a2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 323b607..d65ebfd 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -117,10 +117,14 @@ static const struct pci_device_id nv_pci
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA), GENERIC },
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2), GENERIC },
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3), GENERIC },
-	{ PCI_VDEVICE(NVIDIA, 0x045c), GENERIC },
-	{ PCI_VDEVICE(NVIDIA, 0x045d), GENERIC },
-	{ PCI_VDEVICE(NVIDIA, 0x045e), GENERIC },
-	{ PCI_VDEVICE(NVIDIA, 0x045f), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, 0x045c), GENERIC }, /* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x045d), GENERIC }, /* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x045e), GENERIC }, /* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x045f), GENERIC }, /* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x0550), GENERIC }, /* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0551), GENERIC }, /* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0552), GENERIC }, /* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0553), GENERIC }, /* MCP67 */
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
