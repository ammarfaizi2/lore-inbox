Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWIZB6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWIZB6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 21:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWIZB6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 21:58:09 -0400
Received: from havoc.gtf.org ([69.61.125.42]:31619 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750962AbWIZB6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 21:58:07 -0400
Date: Mon, 25 Sep 2006 21:58:02 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata fixes (incl. oops fix)
Message-ID: <20060926015802.GA9417@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/ata_piix.c |    2 +-
 drivers/ata/sata_nv.c  |    6 +++---
 drivers/ata/sata_sis.c |    6 +++---
 drivers/ata/sata_uli.c |    6 +++---
 drivers/ata/sata_via.c |    7 ++++---
 5 files changed, 14 insertions(+), 13 deletions(-)

Henne:
      ata-piix: fixes kerneldoc error

Jeff Garzik:
      [libata] Fix oops introduced in non-uniform port handling fix

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index ab2eccc..ffa111e 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -851,7 +851,7 @@ static void piix_set_piomode (struct ata
  *	@ap: Port whose timings we are configuring
  *	@adev: Drive in question
  *	@udma: udma mode, 0 - 6
- *	@is_ich: set if the chip is an ICH device
+ *	@isich: set if the chip is an ICH device
  *
  *	Set UDMA mode for device, in host controller PCI config space.
  *
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 27c22fe..8cd730f 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -484,7 +484,7 @@ static void nv_error_handler(struct ata_
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
-	struct ata_port_info *ppi;
+	struct ata_port_info *ppi[2];
 	struct ata_probe_ent *probe_ent;
 	int pci_dev_busy = 0;
 	int rc;
@@ -520,8 +520,8 @@ static int nv_init_one (struct pci_dev *
 
 	rc = -ENOMEM;
 
-	ppi = &nv_port_info[ent->driver_data];
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	ppi[0] = ppi[1] = &nv_port_info[ent->driver_data];
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
 		goto err_out_regions;
 
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 9b17375..18d49ff 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -240,7 +240,7 @@ static int sis_init_one (struct pci_dev 
 	struct ata_probe_ent *probe_ent = NULL;
 	int rc;
 	u32 genctl;
-	struct ata_port_info *ppi;
+	struct ata_port_info *ppi[2];
 	int pci_dev_busy = 0;
 	u8 pmr;
 	u8 port2_start;
@@ -265,8 +265,8 @@ static int sis_init_one (struct pci_dev 
 	if (rc)
 		goto err_out_regions;
 
-	ppi = &sis_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	ppi[0] = ppi[1] = &sis_port_info;
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent) {
 		rc = -ENOMEM;
 		goto err_out_regions;
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 8fc6e80..dd76f37 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -185,7 +185,7 @@ static int uli_init_one (struct pci_dev 
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent;
-	struct ata_port_info *ppi;
+	struct ata_port_info *ppi[2];
 	int rc;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int pci_dev_busy = 0;
@@ -211,8 +211,8 @@ static int uli_init_one (struct pci_dev 
 	if (rc)
 		goto err_out_regions;
 
-	ppi = &uli_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	ppi[0] = ppi[1] = &uli_port_info;
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent) {
 		rc = -ENOMEM;
 		goto err_out_regions;
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 7f087ae..a72a238 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -318,9 +318,10 @@ static void vt6421_init_addrs(struct ata
 static struct ata_probe_ent *vt6420_init_probe_ent(struct pci_dev *pdev)
 {
 	struct ata_probe_ent *probe_ent;
-	struct ata_port_info *ppi = &vt6420_port_info;
-
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	struct ata_port_info *ppi[2];
+	
+	ppi[0] = ppi[1] = &vt6420_port_info;
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
 		return NULL;
 
