Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUGSITN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUGSITN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 04:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbUGSITN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 04:19:13 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:56965 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S264791AbUGSITK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 04:19:10 -0400
Date: Mon, 19 Jul 2004 09:15:49 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Asus M2N notebook hides SMBus device
Message-ID: <20040719071549.GA8801@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Asus also "hides" the LPC bridge on M2N notebooks. Add it to
the asus_hides_smbus PCI quirk. 

Fixes bug #2976 @ http://bugme.osdl.org/show_bug.cgi?id=2976

Signed-off-by: Dominik Brodowski <linux@brodo.de>

diff -ruN linux-original/drivers/pci/quirks.c linux/drivers/pci/quirks.c
--- linux-original/drivers/pci/quirks.c	2004-07-15 14:01:07.000000000 +0200
+++ linux/drivers/pci/quirks.c	2004-07-16 10:03:09.098042896 +0200
@@ -718,6 +718,11 @@
 			case 0x8070: /* P4G8X Deluxe */
 				asus_hides_smbus = 1;
 			}
+		if (dev->device == PCI_DEVICE_ID_INTEL_82855GM_HB)
+			switch (dev->subsystem_device) {
+			case 0x1751: /* M2N notebook */
+				asus_hides_smbus = 1;
+			}
 	} else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_HP)) {
 		if (dev->device ==  PCI_DEVICE_ID_INTEL_82855PM_HB)
 			switch(dev->subsystem_device) {
@@ -1020,6 +1025,7 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_HB,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855PM_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855GM_HB,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc },
