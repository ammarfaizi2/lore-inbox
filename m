Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTKRRQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 12:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbTKRRQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 12:16:53 -0500
Received: from mhs.swan.ac.uk ([137.44.1.33]:2487 "EHLO mhs.swan.ac.uk")
	by vger.kernel.org with ESMTP id S263726AbTKRRQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 12:16:49 -0500
Date: Tue, 18 Nov 2003 17:16:35 +0000
From: =?iso-8859-15?Q?Jos=E9?= Fonseca <jrfonseca@tungstengraphics.com>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] AGPGART, kernel 2.4.22 -- add support for Intel 875P
Message-ID: <20031118171635.GA7507@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
X-SA-Exim-Mail-From: jrfonseca@tungstengraphics.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

As far as I can understand from Dave Jone's 2.5.69-dj1 patch in
<http://www.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.69/>,
Matt Tolentino's AGPGART patch for Intel 875P patch support simply binds
the i845 driver in the presence of the Intel 875P PCI ID. 

The patch attached does the same thing for kernel 2.4.22. No attempt to
verify this from the 845G/875P specifications was made, since 3D
acceleration in my machine has been working faultlessly with it.

José Fonseca

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.22-agpgart-i875p.diff"

diff -ur linux-2.4.22.orig/Documentation/Configure.help linux-2.4.22/Documentation/Configure.help
--- linux-2.4.22.orig/Documentation/Configure.help	2003-09-13 11:48:23.000000000 +0100
+++ linux-2.4.22/Documentation/Configure.help	2003-11-11 17:57:13.000000000 +0000
@@ -3678,10 +3678,11 @@
   a module, say M here and read <file:Documentation/modules.txt>.  The
   module will be called agpgart.o.
 
-Intel 440LX/BX/GX/815/820/830/840/845/850/860 support
+Intel 440LX/BX/GX/815/820/830/840/845/850/860/875 support
 CONFIG_AGP_INTEL
   This option gives you AGP support for the GLX component of the
-  XFree86 4.x on Intel 440LX/BX/GX, 815, 820, 830, 840, 845, 850 and 860 chipsets.
+  XFree86 4.x on Intel 440LX/BX/GX, 815, 820, 830, 840, 845, 850, 860 and 875
+  chipsets.
 
   You should say Y here if you use XFree86 3.3.6 or 4.x and want to
   use GLX or DRI.  If unsure, say N.
diff -ur linux-2.4.22.orig/drivers/char/agp/agp.h linux-2.4.22/drivers/char/agp/agp.h
--- linux-2.4.22.orig/drivers/char/agp/agp.h	2003-07-18 11:49:34.000000000 +0100
+++ linux-2.4.22/drivers/char/agp/agp.h	2003-11-11 17:48:57.000000000 +0000
@@ -205,6 +205,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_865_G_1
 #define PCI_DEVICE_ID_INTEL_865_G_1	0x2572
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_875_P_0
+#define PCI_DEVICE_ID_INTEL_875_P_0	0x2578
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_820_0
 #define PCI_DEVICE_ID_INTEL_820_0       0x2500
 #endif
diff -ur linux-2.4.22.orig/drivers/char/agp/agpgart_be.c linux-2.4.22/drivers/char/agp/agpgart_be.c
--- linux-2.4.22.orig/drivers/char/agp/agpgart_be.c	2003-09-03 11:27:04.000000000 +0100
+++ linux-2.4.22/drivers/char/agp/agpgart_be.c	2003-11-11 17:51:20.000000000 +0000
@@ -4918,6 +4918,13 @@
 		"865G",
 		 intel_845_setup },
 
+	{ PCI_DEVICE_ID_INTEL_875_P_0,
+		PCI_VENDOR_ID_INTEL,
+		INTEL_I875_P,
+		"Intel(R)",
+		"875P",
+		 intel_845_setup },
+
 	{ PCI_DEVICE_ID_INTEL_840_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I840,
diff -ur linux-2.4.22.orig/include/linux/agp_backend.h linux-2.4.22/include/linux/agp_backend.h
--- linux-2.4.22.orig/include/linux/agp_backend.h	2003-11-11 17:59:03.000000000 +0000
+++ linux-2.4.22/include/linux/agp_backend.h	2003-11-11 17:53:01.000000000 +0000
@@ -55,6 +55,7 @@
 	INTEL_I855_PM,
 	INTEL_I860,
 	INTEL_I865_G,
+	INTEL_I875_P,
 	VIA_GENERIC,
 	VIA_VP3,
 	VIA_MVP3,

--FCuugMFkClbJLl1L--
