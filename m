Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273254AbRIWEBH>; Sun, 23 Sep 2001 00:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273256AbRIWEA5>; Sun, 23 Sep 2001 00:00:57 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:25872 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273254AbRIWEAv>; Sun, 23 Sep 2001 00:00:51 -0400
Subject: [PATCH] 2.4.10-pre14: AMD 761 AGP GART (again and again)
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.21.20.26 (Preview Release)
Date: 23 Sep 2001 00:01:26 -0400
Message-Id: <1001217687.1466.28.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My AMD 761 patch was applied in 2.4.10-pre10 but removed during a later
merge with Alan's tree.  Now Alan's 2.4.9-ac14 has this patch.  It is
pending in Linus's tree, but I have received some requests for it, so
here it is.  It applies fine to 2.4.10-pre13 and 14.


diff -urN linux-2.4.10-pre14/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.10-pre14/Documentation/Configure.help	Thu Sep 20 13:32:23 2001
+++ linux/Documentation/Configure.help	Thu Sep 20 13:33:42 2001
@@ -2578,10 +2578,10 @@
   the GLX component for XFree86 3.3.6, which can be downloaded from
   http://utah-glx.sourceforge.net/ .
 
-AMD Irongate support
+AMD Irongate, 761, and 762 support
 CONFIG_AGP_AMD
   This option gives you AGP support for the GLX component of the
-  XFree86 4.x on AMD Irongate and 761 chipsets.
+  XFree86 4.x on AMD Irongate, 761, and 762 chipsets.
 
   For the moment, you should probably say N, unless you want to test
   the GLX component for XFree86 3.3.6, which can be downloaded from
diff -urN linux-2.4.10-pre14/drivers/char/Config.in linux/drivers/char/Config.in
--- linux-2.4.10-pre14/drivers/char/Config.in	Thu Sep 20 13:31:44 2001
+++ linux/drivers/char/Config.in	Thu Sep 20 13:34:03 2001
@@ -208,7 +208,7 @@
    bool '  Intel 440LX/BX/GX and I815/I840/I850 support' CONFIG_AGP_INTEL
    bool '  Intel I810/I815 (on-board) support' CONFIG_AGP_I810
    bool '  VIA chipset support' CONFIG_AGP_VIA
-   bool '  AMD Irongate and 761 support' CONFIG_AGP_AMD
+   bool '  AMD Irongate, 761, and 762 support' CONFIG_AGP_AMD
    bool '  Generic SiS support' CONFIG_AGP_SIS
    bool '  ALI chipset support' CONFIG_AGP_ALI
    bool '  Serverworks LE/HE support' CONFIG_AGP_SWORKS
diff -urN linux-2.4.10-pre14/drivers/char/agp/agp.h linux/drivers/char/agp/agp.h
--- linux-2.4.10-pre14/drivers/char/agp/agp.h	Thu Sep 20 13:31:44 2001
+++ linux/drivers/char/agp/agp.h	Thu Sep 20 13:35:12 2001
@@ -202,6 +202,9 @@
 #ifndef PCI_DEVICE_ID_AMD_IRONGATE_0
 #define PCI_DEVICE_ID_AMD_IRONGATE_0    0x7006
 #endif
+#ifndef PCI_DEVICE_ID_AMD_761_0
+#define PCI_DEVICE_ID_AMD_761_0         0x700e
+#endif
 #ifndef PCI_DEVICE_ID_AMD_762_0
 #define PCI_DEVICE_ID_AMD_762_0		0x700C
 #endif
diff -urN linux-2.4.10-pre14/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/agpgart_be.c
--- linux-2.4.10-pre14/drivers/char/agp/agpgart_be.c	Thu Sep 20 13:31:44 2001
+++ linux/drivers/char/agp/agpgart_be.c	Thu Sep 20 13:37:26 2001
@@ -388,8 +388,8 @@
  * Driver routines - start
  * Currently this module supports the following chipsets:
  * i810, i815, 440lx, 440bx, 440gx, i840, i850, via vp3, via mvp3,
- * via kx133, via kt133, amd irongate, amd 761, ALi M1541, and generic
- * support for the SiS chipsets.
+ * via kx133, via kt133, amd irongate, amd 761, amd 762, ALi M1541,
+ * and generic support for the SiS chipsets.
  */
 
 /* Generic Agp routines - Start */
@@ -2931,9 +2931,15 @@
 		"AMD",
 		"Irongate",
 		amd_irongate_setup },
+	{ PCI_DEVICE_ID_AMD_761_0,
+		PCI_VENDOR_ID_AMD,
+		AMD_761,
+		"AMD",
+		"761",
+		amd_irongate_setup },
 	{ PCI_DEVICE_ID_AMD_762_0,
 		PCI_VENDOR_ID_AMD,
-		AMD_IRONGATE,
+		AMD_762,
 		"AMD",
 		"AMD 760MP",
 		amd_irongate_setup },
diff -urN linux-2.4.10-pre14/include/linux/agp_backend.h linux/include/linux/agp_backend.h
--- linux-2.4.10-pre14/include/linux/agp_backend.h	Thu Sep 20 13:31:33 2001
+++ linux/include/linux/agp_backend.h	Thu Sep 20 13:37:23 2001
@@ -59,6 +59,7 @@
 	AMD_GENERIC,
 	AMD_IRONGATE,
 	AMD_761,
+	AMD_762,
 	ALI_M1541,
 	ALI_M1621,
 	ALI_M1631,



-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

