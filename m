Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280788AbRKOMpH>; Thu, 15 Nov 2001 07:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280817AbRKOMo5>; Thu, 15 Nov 2001 07:44:57 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:34832 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S280788AbRKOMon>;
	Thu, 15 Nov 2001 07:44:43 -0500
Message-ID: <3BF3B8BA.3070804@epfl.ch>
Date: Thu, 15 Nov 2001 13:44:42 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
CC: venza@iol.it, lists@sapience.com, Marvin Justice <mjustice@austin.rr.com>
Subject: [PATCH]AGP incorrect PCI id fix
Content-Type: multipart/mixed;
 boundary="------------050805010705040004070001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050805010705040004070001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all

Here is a patch that fixes a few things for AGPGART in 2.4.15-pre4 :
- Added the device 0x2501 which is the UP version of the i820 chipset 
AGP bridge (according to Intel Specs)
- The entry for i860 in 'agp.h' was incorrect (was 0x2532 instead of 0x2531)

The previous patches (as well as this one) remain available through :
http://ltswww.epfl.ch/~aspert/patches

Best regards.
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

--------------050805010705040004070001
Content-Type: text/plain;
 name="patch-agp_i8xx-2.4.15-pre4_fix_pci_ids"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-agp_i8xx-2.4.15-pre4_fix_pci_ids"

diff -Nru linux-2.4.15-pre4.clean/drivers/char/Config.in linux-2.4.15-pre4/drivers/char/Config.in
--- linux-2.4.15-pre4.clean/drivers/char/Config.in	Thu Nov 15 13:29:04 2001
+++ linux-2.4.15-pre4/drivers/char/Config.in	Tue Nov 13 16:28:31 2001
@@ -210,7 +210,7 @@
 
 dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
 if [ "$CONFIG_AGP" != "n" ]; then
-   bool '  Intel 440LX/BX/GX and I815/I830M/I840/I850 support' CONFIG_AGP_INTEL
+   bool '  Intel 440LX/BX/GX and I815/I820/I830M/I840/I845/I850/I860 support' CONFIG_AGP_INTEL
    bool '  Intel I810/I815/I830M (on-board) support' CONFIG_AGP_I810
    bool '  VIA chipset support' CONFIG_AGP_VIA
    bool '  AMD Irongate, 761, and 762 support' CONFIG_AGP_AMD
diff -Nru linux-2.4.15-pre4.clean/drivers/char/agp/agp.h linux-2.4.15-pre4/drivers/char/agp/agp.h
--- linux-2.4.15-pre4.clean/drivers/char/agp/agp.h	Thu Nov 15 13:29:04 2001
+++ linux-2.4.15-pre4/drivers/char/agp/agp.h	Thu Nov 15 13:24:49 2001
@@ -179,6 +179,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_820_0
 #define PCI_DEVICE_ID_INTEL_820_0       0x2500
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_820_UP_0
+#define PCI_DEVICE_ID_INTEL_820_UP_0    0x2501
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_840_0
 #define PCI_DEVICE_ID_INTEL_840_0		0x1a21
 #endif
@@ -189,7 +192,7 @@
 #define PCI_DEVICE_ID_INTEL_850_0     0x2530
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_860_0
-#define PCI_DEVICE_ID_INTEL_860_0	0x2532
+#define PCI_DEVICE_ID_INTEL_860_0	0x2531
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_810_DC100_0
 #define PCI_DEVICE_ID_INTEL_810_DC100_0 0x7122
diff -Nru linux-2.4.15-pre4.clean/drivers/char/agp/agpgart_be.c linux-2.4.15-pre4/drivers/char/agp/agpgart_be.c
--- linux-2.4.15-pre4.clean/drivers/char/agp/agpgart_be.c	Thu Nov 15 13:29:04 2001
+++ linux-2.4.15-pre4/drivers/char/agp/agpgart_be.c	Thu Nov 15 13:21:00 2001
@@ -3552,6 +3552,12 @@
 		"Intel",
 		"i820",
 		intel_820_setup },
+	{ PCI_DEVICE_ID_INTEL_820_UP_0,
+		PCI_VENDOR_ID_INTEL,
+		INTEL_I820,
+		"Intel",
+		"i820",
+		intel_820_setup },
 	{ PCI_DEVICE_ID_INTEL_830_M_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I830_M,

--------------050805010705040004070001--

