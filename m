Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266871AbUHWTjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbUHWTjT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUHWTii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:38:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:53187 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266876AbUHWSg3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:29 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860842880@kroah.com>
Date: Mon, 23 Aug 2004 11:34:44 -0700
Message-Id: <10932860842875@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.54.9, 2004/08/02 16:12:12-07:00, akpm@osdl.org

[PATCH] I2C: activate SMBus device on hp d300l

From: Dominik Brodowski <linux@dominikbrodowski.de>

HP hides the SMBus on the HP D330L. Original patch by Stoyan Martinov.

Signed-off-by: Örjan Persson <orange@fobie.net>
Signed-off-by: Dominik Brodowski <linux@brodo.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/quirks.c |    7 +++++++
 1 files changed, 7 insertions(+)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-08-23 11:06:57 -07:00
+++ b/drivers/pci/quirks.c	2004-08-23 11:06:57 -07:00
@@ -730,6 +730,11 @@
 			case 0x0890: /* HP Compaq nc6000 */
 				asus_hides_smbus = 1;
 			}
+		if (dev->device == PCI_DEVICE_ID_INTEL_82865_HB)
+			switch (dev->subsystem_device) {
+			case 0x12bc: /* HP D330L */
+				asus_hides_smbus = 1;
+			}
 	}
 }
 
@@ -1023,12 +1028,14 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845G_HB,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82865_HB,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855PM_HB,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855GM_HB,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc },
 
 #ifdef CONFIG_SCSI_SATA
 	/* Fixup BIOSes that configure Parallel ATA (PATA / IDE) and

