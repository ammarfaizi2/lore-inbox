Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVBQCrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVBQCrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 21:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVBQCrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 21:47:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:41907 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262197AbVBQCrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 21:47:31 -0500
X-Authenticated: #26200865
Message-ID: <4214062D.1040903@gmx.net>
Date: Thu, 17 Feb 2005 03:49:17 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Greg KH <greg@kroah.com>
Subject: [PATCH] pci/quirks.c: unhide SMBus device on Samsung P35 laptop
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch is needed to make the SMBus device on my Samsung P35
laptop visible. By default, it doesn't appear as a pci device.

Patch tested, works perfectly for me. Please apply.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>

===== drivers/pci/quirks.c 1.68 vs edited =====
--- 1.68/drivers/pci/quirks.c	2005-02-03 07:42:20 +01:00
+++ edited/drivers/pci/quirks.c	2005-02-16 23:50:49 +01:00
@@ -801,6 +801,12 @@
 			case 0x12bc: /* HP D330L */
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
===== include/linux/pci_ids.h 1.200 vs edited =====
--- 1.200/include/linux/pci_ids.h	2005-01-31 07:33:43 +01:00
+++ edited/include/linux/pci_ids.h	2005-02-16 23:48:09 +01:00
@@ -1905,6 +1905,8 @@
 #define PCI_DEVICE_ID_OXSEMI_16PCI954PP	0x9513
 #define PCI_DEVICE_ID_OXSEMI_16PCI952	0x9521

+#define PCI_VENDOR_ID_SAMSUNG		0x144d
+
 #define PCI_VENDOR_ID_AIRONET		0x14b9
 #define PCI_DEVICE_ID_AIRONET_4800_1	0x0001
 #define PCI_DEVICE_ID_AIRONET_4800	0x4500 // values switched?  see

