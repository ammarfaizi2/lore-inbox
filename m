Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273053AbRIOU7E>; Sat, 15 Sep 2001 16:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273057AbRIOU6p>; Sat, 15 Sep 2001 16:58:45 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:52778 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273054AbRIOU6c>; Sat, 15 Sep 2001 16:58:32 -0400
Subject: [PATCH] (Updated) AMD 761 AGP GART Support
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, juhl@eisenstein.dk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.18.39 (Preview Release)
Date: 15 Sep 2001 16:59:31 -0400
Message-Id: <1000587574.32707.80.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

the following patch adds signature for the AMD 761 to the AGP GART
code.  It has been tested and works.  Please, apply.


diff -urN linux-2.4.10-pre9/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.10-pre9/Documentation/Configure.help	Thu Sep 13 21:03:36 2001
+++ linux/Documentation/Configure.help	Fri Sep 14 22:28:37 2001
@@ -2581,7 +2581,7 @@
 AMD Irongate support
 CONFIG_AGP_AMD
   This option gives you AGP support for the GLX component of the
-  XFree86 4.x on AMD Irongate chipset.
+  XFree86 4.x on AMD Irongate and 761 chipsets.
 
   For the moment, you should probably say N, unless you want to test
   the GLX component for XFree86 3.3.6, which can be downloaded from
diff -urN linux-2.4.10-pre9/drivers/char/agp/agp.h linux/drivers/char/agp/agp.h
--- linux-2.4.10-pre9/drivers/char/agp/agp.h	Thu Sep 13 21:03:40 2001
+++ linux/drivers/char/agp/agp.h	Sat Sep 15 16:32:44 2001
@@ -196,6 +196,9 @@
 #ifndef PCI_DEVICE_ID_AMD_IRONGATE_0
 #define PCI_DEVICE_ID_AMD_IRONGATE_0    0x7006
 #endif
+#ifndef PCI_DEVICE_ID_AMD_761_0
+#define PCI_DEVICE_ID_AMD_761_0         0x700e
+#endif
 #ifndef PCI_VENDOR_ID_AL
 #define PCI_VENDOR_ID_AL		0x10b9
 #endif
diff -urN linux-2.4.10-pre9/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/agpgart_be.c
--- linux-2.4.10-pre9/drivers/char/agp/agpgart_be.c	Thu Sep 13 21:03:40 2001
+++ linux/drivers/char/agp/agpgart_be.c	Sat Sep 15 16:31:58 2001
@@ -385,9 +385,9 @@
 /* 
  * Driver routines - start
  * Currently this module supports the following chipsets:
- * i810, 440lx, 440bx, 440gx, i840, i850, via vp3, via mvp3, via kx133, 
- * via kt133, amd irongate, ALi M1541, and generic support for the SiS 
- * chipsets.
+ * i810, i815, 440lx, 440bx, 440gx, i840, i850, via vp3, via mvp3,
+ * via kx133, via kt133, amd irongate, amd 761, ALi M1541, and generic
+ * support for the SiS chipsets.
  */
 
 /* Generic Agp routines - Start */
@@ -2895,6 +2895,12 @@
 		"AMD",
 		"Irongate",
 		amd_irongate_setup },
+	{ PCI_DEVICE_ID_AMD_761_0,
+		PCI_VENDOR_ID_AMD,
+		AMD_761,
+		"AMD",
+		"761",
+		amd_irongate_setup },
 	{ 0,
 		PCI_VENDOR_ID_AMD,
 		AMD_GENERIC,
@@ -2922,7 +2928,6 @@
 		"Intel",
 		"440GX",
 		intel_generic_setup },
-	/* could we add support for PCI_DEVICE_ID_INTEL_815_1 too ? */
 	{ PCI_DEVICE_ID_INTEL_815_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I815,
diff -urN linux-2.4.10-pre9/include/linux/agp_backend.h linux/include/linux/agp_backend.h
--- linux-2.4.10-pre9/include/linux/agp_backend.h	Thu Sep 13 21:03:50 2001
+++ linux/include/linux/agp_backend.h	Fri Sep 14 22:27:34 2001
@@ -58,6 +58,7 @@
 	SIS_GENERIC,
 	AMD_GENERIC,
 	AMD_IRONGATE,
+	AMD_761,
 	ALI_M1541,
 	ALI_M1621,
 	ALI_M1631,



P.S. Before anyone else whines about the removal of the i815 comment --
its my comment, I can remove it if I want to :)

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

