Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263696AbVCEEfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263696AbVCEEfm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 23:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbVCDXRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:17:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:41634 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263188AbVCDUy5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:57 -0500
Cc: c-d.hailfinger.devel.2005@gmx.net
Subject: [PATCH] pci/quirks.c: unhide SMBus device on Samsung P35 laptop
In-Reply-To: <11099696373155@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:57 -0800
Message-Id: <1109969637195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.20, 2005/02/17 15:06:37-08:00, c-d.hailfinger.devel.2005@gmx.net

[PATCH] pci/quirks.c: unhide SMBus device on Samsung P35 laptop

this patch is needed to make the SMBus device on my Samsung P35
laptop visible. By default, it doesn't appear as a pci device.

Patch tested, works perfectly for me. Please apply.

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/quirks.c    |    6 ++++++
 include/linux/pci_ids.h |    2 ++
 2 files changed, 8 insertions(+)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-03-04 12:41:55 -08:00
+++ b/drivers/pci/quirks.c	2005-03-04 12:41:55 -08:00
@@ -807,6 +807,12 @@
 			case 0x0001: /* Toshiba Satellite A40 */
 				asus_hides_smbus = 1;
 			}
+       } else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG)) {
+               if (dev->device ==  PCI_DEVICE_ID_INTEL_82855PM_HB)
+                       switch(dev->subsystem_device) {
+                       case 0xC00C: /* Samsung P35 notebook */
+                               asus_hides_smbus = 1;
+                       }
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge );
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-03-04 12:41:55 -08:00
+++ b/include/linux/pci_ids.h	2005-03-04 12:41:55 -08:00
@@ -1905,6 +1905,8 @@
 #define PCI_DEVICE_ID_OXSEMI_16PCI954PP	0x9513
 #define PCI_DEVICE_ID_OXSEMI_16PCI952	0x9521
 
+#define PCI_VENDOR_ID_SAMSUNG		0x144d
+
 #define PCI_VENDOR_ID_AIRONET		0x14b9
 #define PCI_DEVICE_ID_AIRONET_4800_1	0x0001
 #define PCI_DEVICE_ID_AIRONET_4800	0x4500 // values switched?  see

