Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbVLMSZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVLMSZG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVLMSZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:25:06 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:24878 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S932582AbVLMSZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:25:04 -0500
Date: Tue, 13 Dec 2005 13:24:14 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 2/2] ide/sis5513: Add support for 965 chipset
In-reply-to: <1134498192250-git-send-email-bcollins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Cc: Ben Collins <bcollins@ubuntu.com>
Reply-to: Ben Collins <bcollins@ubuntu.com>
Message-id: <1134498254295-git-send-email-bcollins@ubuntu.com>
MIME-version: 1.0
X-Mailer: git-send-email
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested by Ubuntu user.

http://bugzilla.ubuntu.com/17236

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 drivers/ide/pci/sis5513.c |    8 +++++++-
 include/linux/pci_ids.h   |    1 +
 2 files changed, 8 insertions(+), 1 deletions(-)

applies-to: a3b21d3b4c1fc36a94b3ffd9e722254ea2a8a950
3f0c8c36457e8f67471e1d0432f8cc1c5a6bedac
diff --git a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
index 75a2253..c838648 100644
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -766,7 +766,7 @@ static unsigned int __devinit init_chips
 			pci_read_config_word(dev, PCI_DEVICE_ID, &trueid);
 			pci_write_config_dword(dev, 0x54, idemisc);
 
-			if (trueid == 0x5518) {
+			if (trueid == PCI_DEVICE_ID_SI_5518) {
 				printk(KERN_INFO "SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller\n");
 				chipset_family = ATA_133;
 
@@ -779,6 +779,11 @@ static unsigned int __devinit init_chips
 					printk(KERN_INFO "SIS5513: Switching to 5513 register mapping\n");
 				}
 			}
+
+			if (trueid == PCI_DEVICE_ID_SI_180) {
+				chipset_family = ATA_133;
+				printk(KERN_INFO "SIS5513: SiS 965 IDE UDMA133 controller\n");
+			}
 	}
 
 	if (!chipset_family) { /* Belongs to pci-quirks */
@@ -953,6 +958,7 @@ static int __devinit sis5513_init_one(st
 static struct pci_device_id sis5513_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5518, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_180,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, sis5513_pci_tbl);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1e737e2..724a98e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -581,6 +581,7 @@
 #define PCI_DEVICE_ID_SI_ACPI		0x0009
 #define PCI_DEVICE_ID_SI_SMBUS		0x0016
 #define PCI_DEVICE_ID_SI_LPC		0x0018
+#define PCI_DEVICE_ID_SI_180		0x0180
 #define PCI_DEVICE_ID_SI_5597_VGA	0x0200
 #define PCI_DEVICE_ID_SI_6205		0x0205
 #define PCI_DEVICE_ID_SI_501		0x0406
---
0.99.9k


