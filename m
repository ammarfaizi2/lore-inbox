Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263628AbVCEEfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbVCEEfb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 23:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbVCDXRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:17:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:40098 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263187AbVCDUy4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:56 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] PCI: Add PCI quirk for SMBus on the Toshiba Satellite A40
In-Reply-To: <1109969637954@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:57 -0800
Message-Id: <11099696373308@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.18, 2005/02/17 15:05:53-08:00, khali@linux-fr.org

[PATCH] PCI: Add PCI quirk for SMBus on the Toshiba Satellite A40

The Toshiba Satellite A40 laptop hides its SMBus device, much like a
number of Asus boards reputedly do. This prevents access to the LM90
hardware monitoring chip. This simple patch extends the PCI quirk used
for the Asus and HP systems to this Toshiba laptop.

Signed-off-by: Frans Pop <aragorn@tiscali.nl>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/quirks.c |    6 ++++++
 1 files changed, 6 insertions(+)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-03-04 12:42:11 -08:00
+++ b/drivers/pci/quirks.c	2005-03-04 12:42:11 -08:00
@@ -801,6 +801,12 @@
 			case 0x12bc: /* HP D330L */
 				asus_hides_smbus = 1;
 			}
+	} else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_TOSHIBA)) {
+		if (dev->device == PCI_DEVICE_ID_INTEL_82855GM_HB)
+			switch(dev->subsystem_device) {
+			case 0x0001: /* Toshiba Satellite A40 */
+				asus_hides_smbus = 1;
+			}
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge );

