Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTJWPvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 11:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbTJWPvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 11:51:46 -0400
Received: from eva.fit.vutbr.cz ([147.229.10.14]:33038 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S263612AbTJWPvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 11:51:42 -0400
Date: Thu, 23 Oct 2003 17:51:38 +0200
From: David Jez <dave.jez@seznam.cz>
To: Hannu Mallat <hmallat@cc.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: TRIVIAL tdfxfb new IDs
Message-ID: <20031023155138.GA1740@stud.fit.vutbr.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi Hannu,

  I send you small trivial patch which supports some exotics voodoo cards.
Please aply.

Regards,
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tdfxfb.diff"

--- tdfxfb.c.orig	Mon Dec  2 14:29:13 2002
+++ tdfxfb.c	Fri Apr 18 21:55:58 2003
@@ -94,6 +94,14 @@
 #define PCI_DEVICE_ID_3DFX_VOODOO5	0x0009
 #endif
 
+#ifndef PCI_DEVICE_ID_3DFX_BANSHEE_VELOCITY
+#define PCI_DEVICE_ID_3DFX_BANSHEE_VELOCITY 0x0004
+#endif
+
+#ifndef PCI_DEVICE_ID_3DFX_VOODOO3_AVENGER
+#define PCI_DEVICE_ID_3DFX_VOODOO3_AVENGER 0x0057
+#endif
+
 /* membase0 register offsets */
 #define STATUS		0x00
 #define PCIINIT0	0x04
@@ -482,12 +490,18 @@
 	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_BANSHEE,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
 	  0xff0000, 0 },
+	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_BANSHEE_VELOCITY,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
+	  0xff0000, 0 },
 	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO3,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
 	  0xff0000, 0 },
 	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO5,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
 	  0xff0000, 0 },
+	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO3_AVENGER,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
+	  0xff0000, 0 },
 	{ 0, }
 };
 
@@ -978,6 +992,8 @@
   draminit1 = tdfx_inl(DRAMINIT1);
 
   if ((fb_info.dev == PCI_DEVICE_ID_3DFX_BANSHEE) ||
+      (fb_info.dev == PCI_DEVICE_ID_3DFX_BANSHEE_VELOCITY) ||
+      (fb_info.dev == PCI_DEVICE_ID_3DFX_VOODOO3_AVENGER) ||
       (fb_info.dev == PCI_DEVICE_ID_3DFX_VOODOO3)) {
     sgram_p = (draminit1 & DRAMINIT1_MEM_SDRAM) ? 0 : 1;
   
@@ -1526,8 +1542,10 @@
 
   switch(i->dev) {
   case PCI_DEVICE_ID_3DFX_BANSHEE:
+  case PCI_DEVICE_ID_3DFX_BANSHEE_VELOCITY:
   case PCI_DEVICE_ID_3DFX_VOODOO3:
   case PCI_DEVICE_ID_3DFX_VOODOO5:
+  case PCI_DEVICE_ID_3DFX_VOODOO3_AVENGER:
     par->width       = (var->xres + 15) & ~15; /* could sometimes be 8 */
     par->width_virt  = par->width;
     par->height      = var->yres;
@@ -1652,9 +1670,15 @@
   case PCI_DEVICE_ID_3DFX_BANSHEE:
     strcpy(fix->id, "3Dfx Banshee");
     break;
+  case PCI_DEVICE_ID_3DFX_BANSHEE_VELOCITY:
+    strcpy(fix->id, "3Dfx Banshee [Velocity 100]");
+    break;
   case PCI_DEVICE_ID_3DFX_VOODOO3:
     strcpy(fix->id, "3Dfx Voodoo3");
     break;
+  case PCI_DEVICE_ID_3DFX_VOODOO3_AVENGER:
+    strcpy(fix->id, "3Dfx Voodoo3/3000 [Avenger]");
+    break;
   case PCI_DEVICE_ID_3DFX_VOODOO5:
     strcpy(fix->id, "3Dfx Voodoo5");
     break;
@@ -1912,10 +1936,12 @@
 	
 	switch (pdev->device) {
 		case PCI_DEVICE_ID_3DFX_BANSHEE:
+		case PCI_DEVICE_ID_3DFX_BANSHEE_VELOCITY:
 			fb_info.max_pixclock = BANSHEE_MAX_PIXCLOCK;
 			name = "Banshee";
 			break;
 		case PCI_DEVICE_ID_3DFX_VOODOO3:
+		case PCI_DEVICE_ID_3DFX_VOODOO3_AVENGER:
 			fb_info.max_pixclock = VOODOO3_MAX_PIXCLOCK;
 			name = "Voodoo3";
 			break;

--dDRMvlgZJXvWKvBx--
