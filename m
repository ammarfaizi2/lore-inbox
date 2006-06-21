Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751608AbWFUO0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbWFUO0d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbWFUO0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:26:06 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751449AbWFUOZl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:25:41 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 02/21] [MMC] Print device id
Date: Wed, 21 Jun 2006 16:25:41 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142541.8857.84201.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As sdhci is a generic driver, it is helpful to see some more specific
identification of the actual hardware in dmesg. PCI vendor, device and
revision is sufficient in most cases.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 681cbb8..efbece3 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -1151,13 +1151,18 @@ static int __devinit sdhci_probe(struct 
 	const struct pci_device_id *ent)
 {
 	int ret, i;
-	u8 slots;
+	u8 slots, rev;
 	struct sdhci_chip *chip;
 
 	BUG_ON(pdev == NULL);
 	BUG_ON(ent == NULL);
 
-	DBG("found at %s\n", pci_name(pdev));
+	pci_read_config_byte(pdev, PCI_CLASS_REVISION, &rev);
+
+	printk(KERN_INFO DRIVER_NAME
+		": SDHCI controller found at %s [%04x:%04x] (rev %x)\n",
+		pci_name(pdev), (int)pdev->vendor, (int)pdev->device,
+		(int)rev);
 
 	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &slots);
 	if (ret)

