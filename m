Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271877AbRIOCiO>; Fri, 14 Sep 2001 22:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271892AbRIOChy>; Fri, 14 Sep 2001 22:37:54 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:26939 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271877AbRIOCho>; Fri, 14 Sep 2001 22:37:44 -0400
Subject: Re: AGP Bridge support for AMD 761
From: Robert Love <rml@ufl.edu>
To: DevilKin@gmx.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <761E23C7F09AD51188990008C74C26141226@fgl00exh01.atitech.com>
In-Reply-To: <761E23C7F09AD51188990008C74C26141226@fgl00exh01.atitech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.18.39 (Preview Release)
Date: 14 Sep 2001 22:38:38 -0400
Message-Id: <1000521528.31713.7.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to put together a patch for AMD 761 support.  I don't have an
AMD 761, but this should work fine.

it is against 2.4.10-pre1, but it should apply cleanly to your kernel.

Please let me know if it works, so we can submit it for inclusion in the
kernel.


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
+++ linux/drivers/char/agp/agp.h	Fri Sep 14 22:33:37 2001
@@ -196,6 +196,9 @@
 #ifndef PCI_DEVICE_ID_AMD_IRONGATE_0
 #define PCI_DEVICE_ID_AMD_IRONGATE_0    0x7006
 #endif
+#ifndef PCI_DEVICE_ID_AMD_761_0
+#define PCI_DEVICE_ID_AMD_761_0		0x700E
+#endif
 #ifndef PCI_VENDOR_ID_AL
 #define PCI_VENDOR_ID_AL		0x10b9
 #endif
diff -urN linux-2.4.10-pre9/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/agpgart_be.c
--- linux-2.4.10-pre9/drivers/char/agp/agpgart_be.c	Thu Sep 13 21:03:40 2001
+++ linux/drivers/char/agp/agpgart_be.c	Fri Sep 14 22:33:48 2001
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



-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

