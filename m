Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290851AbSARWM2>; Fri, 18 Jan 2002 17:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290852AbSARWMS>; Fri, 18 Jan 2002 17:12:18 -0500
Received: from ppp-69-10.28-151.libero.it ([151.28.10.69]:7940 "HELO
	gateway.milesteg.arr") by vger.kernel.org with SMTP
	id <S290851AbSARWMC>; Fri, 18 Jan 2002 17:12:02 -0500
Date: Fri, 18 Jan 2002 23:11:53 +0100
From: Daniele Venzano <venza@iol.it>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Subject: [PATCH] AGP update for i820 and i860 chipsets
Message-ID: <20020118221153.GA1263@renditai.milesteg.arr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes the ID for i860 chipset and adds support for the UP
version of i820 AGP bridge. I made it against kernel 2.4.17. It compiles
and works both builin or as a module.

It was submitted long ago by Nicolas Aspert and works well for
me, I'm running XFree with DRI and AGP 4x without problems.

This is my first patch, so there could be problems, however you could
find it also at:
http://digilander.iol.it/webvenza/agp_patch.html

Best regards.
-- 
-----------------------------------------------------
Daniele Venzano
Senior member of the Linux User Group Genova (LUGGe)
E-Mail: venza@iol.it
Web: http://digilander.iol.it/webvenza/
LUGGe: http://lugge.ziobudda.net


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-agp_i8xx-2.4.17_fix_pci_ids"

diff -urN -X dontdiff linux/drivers/char/Config.in linux-agp/drivers/char/Config.in
--- linux/drivers/char/Config.in	Fri Jan 18 19:58:09 2002
+++ linux-agp/drivers/char/Config.in	Fri Jan 18 20:10:14 2002
@@ -210,7 +210,7 @@
 
 dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
 if [ "$CONFIG_AGP" != "n" ]; then
-   bool '  Intel 440LX/BX/GX and I815/I830M/I840/I850 support' CONFIG_AGP_INTEL
+   bool '  Intel 440LX/BX/GX and I815/I820/I830M/I840/I845/I850/I860 support' CONFIG_AGP_INTEL
    bool '  Intel I810/I815/I830M (on-board) support' CONFIG_AGP_I810
    bool '  VIA chipset support' CONFIG_AGP_VIA
    bool '  AMD Irongate, 761, and 762 support' CONFIG_AGP_AMD
diff -urN -X dontdiff linux/drivers/char/agp/agp.h linux-agp/drivers/char/agp/agp.h
--- linux/drivers/char/agp/agp.h	Fri Jan 18 19:58:09 2002
+++ linux-agp/drivers/char/agp/agp.h	Fri Jan 18 20:11:36 2002
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
diff -urN -X dontdiff linux/drivers/char/agp/agpgart_be.c linux-agp/drivers/char/agp/agpgart_be.c
--- linux/drivers/char/agp/agpgart_be.c	Fri Jan 18 19:58:18 2002
+++ linux-agp/drivers/char/agp/agpgart_be.c	Fri Jan 18 20:11:46 2002
@@ -1800,7 +1800,7 @@
        agp_bridge.needs_scratch_page = FALSE;
        agp_bridge.configure = intel_820_configure;
        agp_bridge.fetch_size = intel_8xx_fetch_size;
-       agp_bridge.cleanup = intel_cleanup;
+       agp_bridge.cleanup = intel_820_cleanup;
        agp_bridge.tlb_flush = intel_820_tlbflush;
        agp_bridge.mask_memory = intel_mask_memory;
        agp_bridge.agp_enable = agp_generic_agp_enable;
@@ -3567,6 +3567,12 @@
 		"i815",
 		intel_generic_setup },
 	{ PCI_DEVICE_ID_INTEL_820_0,
+		PCI_VENDOR_ID_INTEL,
+		INTEL_I820,
+		"Intel",
+		"i820",
+		intel_820_setup },
+	{ PCI_DEVICE_ID_INTEL_820_UP_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I820,
 		"Intel",

--vkogqOf2sHV7VnPd--
