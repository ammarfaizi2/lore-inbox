Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272442AbRIOVKi>; Sat, 15 Sep 2001 17:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273072AbRIOVKS>; Sat, 15 Sep 2001 17:10:18 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:25360 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272442AbRIOVKD>; Sat, 15 Sep 2001 17:10:03 -0400
Subject: Re: [PATCH] (Updated) AMD 761 AGP GART Support
From: Robert Love <rml@ufl.edu>
To: laughing@shared-source.org
Cc: linux-kernel@vger.kernel.org, juhl@eisenstein.dk, jgarzik@mandrakesoft.com
In-Reply-To: <1000587574.32707.80.camel@phantasy>
In-Reply-To: <1000587574.32707.80.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.18.39 (Preview Release)
Date: 15 Sep 2001 17:10:41 -0400
Message-Id: <1000588267.32707.86.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-15 at 16:59, Robert Love wrote:
> Linus,
> 
> the following patch adds signature for the AMD 761 to the AGP GART
> code.  It has been tested and works.  Please, apply.

Alan, this is a diff against your tree, 2.4.9-ac10.  Please, apply.


diff -urN linux-2.4.9-ac10/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.9-ac10/Documentation/Configure.help	Sat Sep 15 17:03:21 2001
+++ linux/Documentation/Configure.help	Sat Sep 15 17:03:53 2001
@@ -3094,7 +3094,7 @@
 AMD Irongate support
 CONFIG_AGP_AMD
   This option gives you AGP support for the GLX component of the
-  XFree86 4.x on AMD Irongate chipset.
+  XFree86 4.x on AMD Irongate and 761 chipsets.
 
   For the moment, you should probably say N, unless you want to test
   the GLX component for XFree86 3.3.6, which can be downloaded from
diff -urN linux-2.4.9-ac10/drivers/char/agp/agp.h linux/drivers/char/agp/agp.h
--- linux-2.4.9-ac10/drivers/char/agp/agp.h	Sat Sep 15 17:02:51 2001
+++ linux/drivers/char/agp/agp.h	Sat Sep 15 17:03:53 2001
@@ -209,6 +209,9 @@
 #ifndef PCI_DEVICE_ID_AMD_762_0
 #define PCI_DEVICE_ID_AMD_762_0		0x700C
 #endif
+#ifndef PCI_DEVICE_ID_AMD_761_0
+#define PCI_DEVICE_ID_AMD_761_0         0x700e
+#endif
 #ifndef PCI_VENDOR_ID_AL
 #define PCI_VENDOR_ID_AL		0x10b9
 #endif
diff -urN linux-2.4.9-ac10/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/agpgart_be.c
--- linux-2.4.9-ac10/drivers/char/agp/agpgart_be.c	Sat Sep 15 17:02:51 2001
+++ linux/drivers/char/agp/agpgart_be.c	Sat Sep 15 17:03:53 2001
@@ -387,9 +387,9 @@
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
@@ -2937,6 +2937,12 @@
 		"AMD",
 		"AMD 760MP",
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
@@ -2964,7 +2970,6 @@
 		"Intel",
 		"440GX",
 		intel_generic_setup },
-	/* could we add support for PCI_DEVICE_ID_INTEL_815_1 too ? */
 	{ PCI_DEVICE_ID_INTEL_815_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I815,
diff -urN linux-2.4.9-ac10/include/linux/agp_backend.h linux/include/linux/agp_backend.h
--- linux-2.4.9-ac10/include/linux/agp_backend.h	Sat Sep 15 17:02:40 2001
+++ linux/include/linux/agp_backend.h	Sat Sep 15 17:03:53 2001
@@ -58,6 +58,7 @@
 	SIS_GENERIC,
 	AMD_GENERIC,
 	AMD_IRONGATE,
+	AMD_761,
 	ALI_M1541,
 	ALI_M1621,
 	ALI_M1631,


> P.S. Before anyone else whines about the removal of the i815 comment --
> its my comment, I can remove it if I want to :)

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

