Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbUCPASr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbUCPAHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:07:01 -0500
Received: from mail.kroah.org ([65.200.24.183]:10415 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262886AbUCPACH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:07 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913921416@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:32 -0800
Message-Id: <10793913921004@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.18, 2004/02/23 16:47:10-08:00, mhoffman@lightlink.com

[PATCH] PCI: fix i2c quirk for SiS735 chipset SMBus driver


 drivers/pci/quirks.c    |    8 +++++---
 include/linux/pci_ids.h |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Mon Mar 15 14:36:10 2004
+++ b/drivers/pci/quirks.c	Mon Mar 15 14:36:10 2004
@@ -757,7 +757,7 @@
 
 #define SIS_DETECT_REGISTER 0x40
 
-static void __init quirk_sis_503_smbus(struct pci_dev *dev)
+static void __init quirk_sis_503(struct pci_dev *dev)
 {
 	u8 reg;
 	u16 devid;
@@ -765,7 +765,7 @@
 	pci_read_config_byte(dev, SIS_DETECT_REGISTER, &reg);
 	pci_write_config_byte(dev, SIS_DETECT_REGISTER, reg | (1 << 6));
 	pci_read_config_word(dev, PCI_DEVICE_ID, &devid);
-	if ((devid & 0xfff0) != 0x0960) {
+	if (((devid & 0xfff0) != 0x0960) && (devid != 0x0018)) {
 		pci_write_config_byte(dev, SIS_DETECT_REGISTER, reg);
 		return;
 	}
@@ -877,12 +877,14 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_2, 	quirk_natoma },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503_smbus },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_645,		quirk_sis_96x_compatible },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_646,		quirk_sis_96x_compatible },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_648,		quirk_sis_96x_compatible },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_650,		quirk_sis_96x_compatible },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_651,		quirk_sis_96x_compatible },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_735,		quirk_sis_96x_compatible },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus },
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Mon Mar 15 14:36:10 2004
+++ b/include/linux/pci_ids.h	Mon Mar 15 14:36:10 2004
@@ -569,6 +569,7 @@
 #define PCI_DEVICE_ID_SI_6202		0x0002
 #define PCI_DEVICE_ID_SI_503		0x0008
 #define PCI_DEVICE_ID_SI_ACPI		0x0009
+#define PCI_DEVICE_ID_SI_LPC		0x0018
 #define PCI_DEVICE_ID_SI_5597_VGA	0x0200
 #define PCI_DEVICE_ID_SI_6205		0x0205
 #define PCI_DEVICE_ID_SI_501		0x0406

