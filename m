Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbTLFTMW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 14:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbTLFTMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 14:12:21 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:55438 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S265230AbTLFTMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 14:12:18 -0500
Subject: Re: i875p
From: Danny Brow <fms@ca.istop.com>
To: Kernel-Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312061549450.6871-100000@logos.cnet>
References: <Pine.LNX.4.44.0312061549450.6871-100000@logos.cnet>
Content-Type: multipart/mixed; boundary="=-7/E6nBKaxLRs8le311x0"
Message-Id: <1070737989.3822.2.camel@zeus.fullmotionsolutions.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 14:13:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7/E6nBKaxLRs8le311x0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

It's not much different then the original creators patch for 2.4.22, I
just modified the last hunk.  I can't remember who posted it though.  

On Sat, 2003-12-06 at 12:50, Marcelo Tosatti wrote:
> Would like to have it.
> 
> On Sat, 29 Nov 2003, Danny Brow wrote:
> 
> > Fixed this issue, I found a patch for 2.4.22 in the mailing list archive
> > I just had to updated it a little to get it to apply to the 2.4.23
> > kernel. If any one wants it I will post it latter and credit the
> > original creator.
> > 
> > On Sat, 2003-11-29 at 13:07, Joshua Schmidlkofer wrote:
> > > You have a dual p3 850 with an i875?
> > > 
> > > On Sat, 2003-11-29 at 10:03, Danny Brow wrote:
> > > > ATI Radeon DDR VIVO, it's a little old but even with my dual p3 850 I
> > > > was able to play a lot of current games.
> > > > 
> > > > On Sat, 2003-11-29 at 13:00, Joshua Schmidlkofer wrote:
> > > > > On Sat, 2003-11-29 at 08:56, Danny Brow wrote:
> > > > > > Is there going to be support for the i875p chipset in 2.4.24? I can't
> > > > > > load agpgart with 2.4.23, nor with 2..4.22. 
> > > > > 
> > > > > 
> > > > > What video card do you have?
> > > > > 
> > > > > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=-7/E6nBKaxLRs8le311x0
Content-Disposition: attachment; filename=i875p.diff
Content-Type: text/x-patch; name=i875p.diff; charset=
Content-Transfer-Encoding: 7bit

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
	INTEL_I7205,
	INTEL_I7505,
	INTEL_460GX, 	
	VIA_GENERIC,
 	VIA_VP3,
 	VIA_MVP3,

--=-7/E6nBKaxLRs8le311x0--

