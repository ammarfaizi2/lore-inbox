Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSGXALh>; Tue, 23 Jul 2002 20:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSGXALh>; Tue, 23 Jul 2002 20:11:37 -0400
Received: from smtp.mujoskar.cz ([217.77.161.140]:55749 "EHLO smtp.mujoskar.cz")
	by vger.kernel.org with ESMTP id <S315445AbSGXALg>;
	Tue, 23 Jul 2002 20:11:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: workaround for buggy BIOSes and i845 chipsets
Date: Wed, 24 Jul 2002 02:14:06 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17X9n7-0000SV-00@notas>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Vojtech Pavlik helped me to workaround this issue. This patch is backport 
from 2.5 to 2.4 and is applicable into 2.4.19-rc3. Maybe somebody will need 
it too. It works correctly on my system.

Michal

Patch:

--- linux/drivers/pci/quirks.c  Sat Jul 20 11:08:15 2002
+++ linux/drivers/pci/quirks.c  Tue Jul 23 14:51:43 2002
@@ -471,6 +471,15 @@
        r -> end = 0xffffff;
 }

+static void __init quirk_ide_trash(struct pci_dev *dev)
+{
+        int i;
+        for(i = 0; i < 4; i++)
+                dev->resource[i].start = dev->resource[i].end = 
dev->resource[i].flags = 0;
+}
+
+#define PCI_DEVICE_ID_INTEL_82801DB_9   0x24cb
+
 /*
  *  The main table of quirks.
  */
@@ -498,6 +507,9 @@
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    
PCI_DEVICE_ID_INTEL_82443BX_0,  quirk_natoma },
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    
PCI_DEVICE_ID_INTEL_82443BX_1,  quirk_natoma },
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    
PCI_DEVICE_ID_INTEL_82443BX_2,  quirk_natoma },
+       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    
PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_trash },
+        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    
PCI_DEVICE_ID_INTEL_82801CA_11, quirk_ide_trash },
+        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    
PCI_DEVICE_ID_INTEL_82801DB_9,  quirk_ide_trash },
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_SI,       
PCI_DEVICE_ID_SI_5597, quirk_nopcipci },
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_SI,       PCI_DEVICE_ID_SI_496, 
 quirk_nopcipci },
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_VIA,      
PCI_DEVICE_ID_VIA_8363_0,       quirk_vialatency },
