Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVEQVBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVEQVBh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 17:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVEQVBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:01:37 -0400
Received: from hammer.engin.umich.edu ([141.213.40.79]:56000 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S261977AbVEQVBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:01:17 -0400
Date: Tue, 17 May 2005 17:01:14 -0400 (EDT)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: linux-kernel@vger.kernel.org
cc: davej@redhat.com
Subject: [PATCH 2.6.12-rc4] support i945G as i915G in intel-agp.c
Message-ID: <Pine.LNX.4.58.0505171656460.20677@hammer.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am currently testing a x86_64 machine with an Intel i945G chipset. The
intel-agp.c driver seems to work okay if I treat it as a i915G. (I can get
OpenGL to work with the DRI driver)

Is someone else (with documentation perhaps) looking into the newer Intel
chipsets, or is a patch like this okay?


Thanks,

Chris Wing
wingc@engin.umich.edu



diff -uNr linux-2.6.12-rc4.orig/drivers/char/agp/intel-agp.c linux-2.6.12-rc4/drivers/char/agp/intel-agp.c
--- linux-2.6.12-rc4.orig/drivers/char/agp/intel-agp.c	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4/drivers/char/agp/intel-agp.c	2005-05-17 16:56:26.763582464 -0400
@@ -418,7 +418,8 @@
 		case I915_GMCH_GMS_STOLEN_48M:
 			/* Check it's really I915G */
 			if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB ||
-			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB)
+			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB ||
+			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82945G_HB)
 				gtt_entries = MB(48) - KB(size);
 			else
 				gtt_entries = 0;
@@ -426,7 +427,8 @@
 		case I915_GMCH_GMS_STOLEN_64M:
 			/* Check it's really I915G */
 			if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB ||
-			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB)
+			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB ||
+			    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82945G_HB)
 				gtt_entries = MB(64) - KB(size);
 			else
 				gtt_entries = 0;
@@ -1662,6 +1664,14 @@
 		}
 		name = "915GM";
 		break;
+	case PCI_DEVICE_ID_INTEL_82945G_HB:
+		if (find_i830(PCI_DEVICE_ID_INTEL_82945G_IG)) {
+			bridge->driver = &intel_915_driver;
+		} else {
+			bridge->driver = &intel_845_driver;
+		}
+		name = "945G";
+		break;
 	case PCI_DEVICE_ID_INTEL_7505_0:
 		bridge->driver = &intel_7505_driver;
 		name = "E7505";
@@ -1801,6 +1811,7 @@
 	ID(PCI_DEVICE_ID_INTEL_7205_0),
 	ID(PCI_DEVICE_ID_INTEL_82915G_HB),
 	ID(PCI_DEVICE_ID_INTEL_82915GM_HB),
+	ID(PCI_DEVICE_ID_INTEL_82945G_HB),
 	{ }
 };

diff -uNr linux-2.6.12-rc4.orig/include/linux/pci_ids.h linux-2.6.12-rc4/include/linux/pci_ids.h
--- linux-2.6.12-rc4.orig/include/linux/pci_ids.h	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4/include/linux/pci_ids.h	2005-05-17 16:53:54.000000000 -0400
@@ -2412,6 +2412,8 @@
 #define PCI_DEVICE_ID_INTEL_ESB2_16	0x269a
 #define PCI_DEVICE_ID_INTEL_ESB2_17	0x269b
 #define PCI_DEVICE_ID_INTEL_ESB2_18	0x269e
+#define PCI_DEVICE_ID_INTEL_82945G_HB	0x2770
+#define PCI_DEVICE_ID_INTEL_82945G_IG	0x2772
 #define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b8
 #define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b9
 #define PCI_DEVICE_ID_INTEL_ICH7_2	0x27c0
