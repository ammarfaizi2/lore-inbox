Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273043AbRIOUpD>; Sat, 15 Sep 2001 16:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273041AbRIOUoy>; Sat, 15 Sep 2001 16:44:54 -0400
Received: from f191.pav1.hotmail.com ([64.4.31.191]:27655 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S273040AbRIOUoq>;
	Sat, 15 Sep 2001 16:44:46 -0400
X-Originating-IP: [128.61.74.37]
From: "Scott McLeod" <halcyon_blue@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: AMD 760 support
Date: Sat, 15 Sep 2001 16:45:04 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F191TgVt6u81bMM2rUS0000759d@hotmail.com>
X-OriginalArrivalTime: 15 Sep 2001 20:45:04.0617 (UTC) FILETIME=[4C336D90:01C13E27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't mean to step on anybody's toes but I spent my Friday learning what I 
could about how to get the gart to support the 761 northbridge
reading up on kernel coding style etc... I then patched against 2.4.9 and 
tested.  I would have posted this last night but to my dismay I've been 
unable to determine who the maintainer of the gart is.  Feel free to test 
this, and if you can point me in the right direction of the maintainer for 
this code I'd really appreciate it.  This patch also allows one to pass 
AGP_TRYUNSUPPORTED as a kernel param.

Thanks,
-Scott



diff -ur linux-2.4.9.orig/drivers/char/agp/agp.h 
linux-2.4.9.agpgart-amd760/drivers/char/agp/agp.h
--- linux-2.4.9.orig/drivers/char/agp/agp.h	Wed Aug 15 08:22:15 2001
+++ linux-2.4.9.agpgart-amd760/drivers/char/agp/agp.h	Fri Sep 14 16:01:18 
2001
@@ -195,6 +195,9 @@
#ifndef PCI_DEVICE_ID_AMD_IRONGATE_0
#define PCI_DEVICE_ID_AMD_IRONGATE_0    0x7006
#endif
+#ifndef PCI_DEVICE_ID_AMD_761_0
+#define PCI_DEVICE_ID_AMD_761_0		0x700e
+#endif
#ifndef PCI_VENDOR_ID_AL
#define PCI_VENDOR_ID_AL		0x10b9
#endif
diff -ur linux-2.4.9.orig/drivers/char/agp/agpgart_be.c 
linux-2.4.9.agpgart-amd760/drivers/char/agp/agpgart_be.c
--- linux-2.4.9.orig/drivers/char/agp/agpgart_be.c	Wed Aug 15 08:22:15 2001
+++ linux-2.4.9.agpgart-amd760/drivers/char/agp/agpgart_be.c	Fri Sep 14 
17:11:58 2001
@@ -2877,6 +2877,12 @@
		"AMD",
		"Irongate",
		amd_irongate_setup },
+	{ PCI_DEVICE_ID_AMD_761_0,
+		PCI_VENDOR_ID_AMD,
+		AMD_760,
+		"AMD",
+		"760",
+		amd_irongate_setup },
	{ 0,
		PCI_VENDOR_ID_AMD,
		AMD_GENERIC,
@@ -3457,3 +3463,15 @@

module_init(agp_init);
module_exit(agp_cleanup);
+
+/* kernel args */
+#ifndef MODULE
+static int __init agp_parms(char* str)
+{
+	int ints[2];
+	str = get_options(str, ARRAY_SIZE(ints), ints);
+	agp_try_unsupported = ints[1];
+        return 1;
+}
+__setup("agpgart.agp_try_unsupported=", agp_parms);
+#endif
diff -ur linux-2.4.9.orig/include/linux/agp_backend.h 
linux-2.4.9.agpgart-amd760/include/linux/agp_backend.h
--- linux-2.4.9.orig/include/linux/agp_backend.h	Mon Jul  2 22:27:56 2001
+++ linux-2.4.9.agpgart-amd760/include/linux/agp_backend.h	Fri Sep 14 
16:51:36 2001
@@ -58,6 +58,7 @@
	SIS_GENERIC,
	AMD_GENERIC,
	AMD_IRONGATE,
+	AMD_760,
	ALI_M1541,
	ALI_M1621,
	ALI_M1631,

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

