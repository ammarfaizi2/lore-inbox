Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263249AbVCDVXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263249AbVCDVXw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbVCDVM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:12:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:56993 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263147AbVCDUyZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:25 -0500
Cc: hfvogt@gmx.net
Subject: [PATCH] I2C i2c-nforce2: add support for nForce4 (patch against 2.6.11-rc4)
In-Reply-To: <11099685961094@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:36 -0800
Message-Id: <11099685963905@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2105, 2005/03/02 12:18:53-08:00, hfvogt@gmx.net

[PATCH] I2C i2c-nforce2: add support for nForce4 (patch against 2.6.11-rc4)

can you please apply the attached patch (against 2.6.11-rc4, but works
as well for 2.6.11-rc3-mm2),  that adds support for the two SMBusses of
the nForce4 to the i2c-nforce2 i2c bus driver.  The patch is reported to
work on the standard nForce4 (i.e. non-Ultra, non-SLI), but I expect
that it works as well for the other nForce4 chipsets, that seem to have
the same PCI-id for the SMBus-device.

This patch was proposed by Chuck <chunkeey@web.de>, thanks to him for the
information, testing and his patch.

Signed-off-by: Hans-Frieder Vogt <hfvogt@arcor.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-nforce2.c |    6 ++++--
 include/linux/pci_ids.h          |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	2005-03-04 12:23:55 -08:00
+++ b/drivers/i2c/busses/i2c-nforce2.c	2005-03-04 12:23:55 -08:00
@@ -29,9 +29,10 @@
     nForce2 Ultra 400 MCP	0084
     nForce3 Pro150 MCP		00D4
     nForce3 250Gb MCP		00E4
+    nForce4 MCP			0052
 
-    This driver supports the 2 SMBuses that are included in the MCP2 of the
-    nForce2 chipset.
+    This driver supports the 2 SMBuses that are included in the MCP of the
+    nForce2/3/4 chipsets.
 */
 
 /* Note: we assume there can only be one nForce2, with two SMBus interfaces */
@@ -295,6 +296,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE4_SMBUS) },
 	{ 0 }
 };
 
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-03-04 12:23:55 -08:00
+++ b/include/linux/pci_ids.h	2005-03-04 12:23:55 -08:00
@@ -1098,6 +1098,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_10		0x0037
 #define PCI_DEVICE_ID_NVIDIA_NVENET_11		0x0038
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2	0x003e
+#define PCI_DEVICE_ID_NVIDIA_NFORCE4_SMBUS	0x0052
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE	0x0053
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA	0x0054
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2	0x0055

