Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbTABTom>; Thu, 2 Jan 2003 14:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266438AbTABTol>; Thu, 2 Jan 2003 14:44:41 -0500
Received: from 177-2.SPEEDe.golden.net ([216.75.177.2]:51464 "EHLO
	thebeever.com") by vger.kernel.org with ESMTP id <S266435AbTABTok>;
	Thu, 2 Jan 2003 14:44:40 -0500
Date: Thu, 2 Jan 2003 14:53:46 -0500
From: Richard Baverstock <beaver@gto.net>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH] AGPGART for VIA vt8235, kernel 2.4.21-pre2
Message-Id: <20030102145346.27a21ed9.beaver@gto.net>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that enables AGPGART for the VIA vt8235 chipset on P4X400 motherboards. Rather trivial, adds the pci id, then a few lines in the agp sources to get it identified. I've only been able to test this on my computer, where it works.

Rich


--BEGIN--

diff -ur linux/drivers/char/agp/agp.h linux-2.4.21-pre2/drivers/char/agp/agp.h
--- linux/drivers/char/agp/agp.h 2003-01-02 14:36:15.000000000 -0500
+++ linux-2.4.21-pre2/drivers/char/agp/agp.h 2003-01-02 14:35:02.000000000 -0500
@@ -157,6 +157,9 @@

 #define PGE_EMPTY(p) (!(p) || (p) == (unsigned long) agp_bridge.scratch_page)

+#ifndef PCI_DEVICE_ID_VIA_8235_0
+#define PCI_DEVICE_ID_VIA_8235_0       0x3168
+#endif
 #ifndef PCI_DEVICE_ID_VIA_82C691_0
 #define PCI_DEVICE_ID_VIA_82C691_0      0x0691
 #endif
diff -ur linux/drivers/char/agp/agpgart_be.c linux-2.4.21-pre2/drivers/char/agp/agpgart_be.c
--- linux/drivers/char/agp/agpgart_be.c   2003-01-02 14:36:15.000000000 -0500
+++ linux-2.4.21-pre2/drivers/char/agp/agpgart_be.c   2003-01-02 14:35:02.000000000 -0500
@@ -4640,6 +4640,12 @@
 #endif /* CONFIG_AGP_SIS */

 #ifdef CONFIG_AGP_VIA
+  { PCI_DEVICE_ID_VIA_8235_0,
+     PCI_VENDOR_ID_VIA,
+     VIA_P4X400,
+     "Via",
+     "P4X400",
+     via_generic_setup },
   { PCI_DEVICE_ID_VIA_8501_0,
      PCI_VENDOR_ID_VIA,
      VIA_MVP4,
diff -ur linux/drivers/pci/pci.ids linux-2.4.21-pre2/drivers/pci/pci.ids
--- linux/drivers/pci/pci.ids 2003-01-02 14:36:16.000000000 -0500
+++ linux-2.4.21-pre2/drivers/pci/pci.ids 2003-01-02 14:35:02.000000000 -0500
@@ -2751,6 +2751,7 @@
   3147  VT8233A ISA Bridge
   3148  P4M266 Host Bridge
   3156  P/KN266 Host Bridge
+  3168  VT8235 [P4X400 AGP]
   3177  VT8233A ISA Bridge
      1458 5001 GA-7VAX Mainboard
   3189  VT8377 [KT400 AGP] Host Bridge
diff -ur linux/include/linux/agp_backend.h linux-2.4.21-pre2/include/linux/agp_backend.h
--- linux/include/linux/agp_backend.h  2003-01-02 14:36:17.000000000 -0500
+++ linux-2.4.21-pre2/include/linux/agp_backend.h  2003-01-02 14:35:02.000000000 -0500
@@ -54,6 +54,7 @@
   INTEL_I850,
   INTEL_I860,
   VIA_GENERIC,
+  VIA_P4X400,
   VIA_VP3,
   VIA_MVP3,
   VIA_MVP4,

--END--


