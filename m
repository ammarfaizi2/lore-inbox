Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWB0Du5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWB0Du5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 22:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWB0Du5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 22:50:57 -0500
Received: from xenotime.net ([66.160.160.81]:63667 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750820AbWB0Du4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 22:50:56 -0500
Date: Sun, 26 Feb 2006 19:52:10 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH/RFC] consolidated graphics config
Message-Id: <20060226195210.30498852.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Put AGP and DRM (DRI) under the Graphics config menu.
Rearrange 2 of the backlight entries so that they are not orphaned.
Tested with menuconfig, xconfig, & gconfig.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/char/Kconfig            |    4 ----
 drivers/char/agp/Kconfig        |    3 +++
 drivers/char/drm/Kconfig        |    3 +++
 drivers/video/Kconfig           |    9 +++++++++
 drivers/video/backlight/Kconfig |   33 ++++++++++++++++-----------------
 5 files changed, 31 insertions(+), 21 deletions(-)

--- linux-2616-rc4.orig/drivers/char/Kconfig
+++ linux-2616-rc4/drivers/char/Kconfig
@@ -885,10 +885,6 @@ source "drivers/char/ftape/Kconfig"
 
 endmenu
 
-source "drivers/char/agp/Kconfig"
-
-source "drivers/char/drm/Kconfig"
-
 source "drivers/char/pcmcia/Kconfig"
 
 config MWAVE
--- linux-2616-rc4.orig/drivers/video/Kconfig
+++ linux-2616-rc4/drivers/video/Kconfig
@@ -4,6 +4,12 @@
 
 menu "Graphics support"
 
+source "drivers/char/agp/Kconfig"
+
+source "drivers/char/drm/Kconfig"
+
+menu "Frame buffer driver support"
+
 config FB
 	tristate "Support for frame buffer devices"
 	---help---
@@ -1446,6 +1452,9 @@ config FB_VIRTUAL
 	  module will be called vfb.
 
 	  If unsure, say N.
+
+endmenu
+
 if VT
 	source "drivers/video/console/Kconfig"
 endif
--- linux-2616-rc4.orig/drivers/char/agp/Kconfig
+++ linux-2616-rc4/drivers/char/agp/Kconfig
@@ -1,3 +1,5 @@
+menu "AGP driver support"
+
 config AGP
 	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU
 	depends on ALPHA || IA64 || PPC || X86
@@ -169,3 +171,4 @@ config AGP_SGI_TIOCA
           This option gives you AGP GART support for the SGI TIO chipset
           for IA64 processors.
 
+endmenu
--- linux-2616-rc4.orig/drivers/char/drm/Kconfig
+++ linux-2616-rc4/drivers/char/drm/Kconfig
@@ -5,6 +5,8 @@
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 #
 
+menu "Direct Rendering Infrastructure (DRI) support"
+
 config DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
 	depends on (AGP || AGP=n) && PCI
@@ -104,3 +106,4 @@ config DRM_SAVAGE
 	  Choose this option if you have a Savage3D/4/SuperSavage/Pro/Twister
 	  chipset. If M is selected the module will be called savage.
 
+endmenu
--- linux-2616-rc4.orig/drivers/video/backlight/Kconfig
+++ linux-2616-rc4/drivers/video/backlight/Kconfig
@@ -24,6 +24,22 @@ config BACKLIGHT_DEVICE
 	depends on BACKLIGHT_CLASS_DEVICE
 	default y
 
+config BACKLIGHT_CORGI
+	tristate "Sharp Corgi Backlight Driver (SL-C7xx Series)"
+	depends on BACKLIGHT_DEVICE && PXA_SHARPSL
+	default y
+	help
+	  If you have a Sharp Zaurus SL-C7xx, say y to enable the
+	  backlight driver.
+
+config BACKLIGHT_HP680
+	tristate "HP Jornada 680 Backlight Driver"
+	depends on BACKLIGHT_DEVICE && SH_HP6XX
+	default y
+	help
+	  If you have a HP Jornada 680, say y to enable the
+	  backlight driver.
+
 config LCD_CLASS_DEVICE
         tristate "Lowlevel LCD controls"
 	depends on BACKLIGHT_LCD_SUPPORT
@@ -41,20 +57,3 @@ config LCD_DEVICE
 	bool
 	depends on LCD_CLASS_DEVICE
 	default y
-
-config BACKLIGHT_CORGI
-	tristate "Sharp Corgi Backlight Driver (SL-C7xx Series)"
-	depends on BACKLIGHT_DEVICE && PXA_SHARPSL
-	default y
-	help
-	  If you have a Sharp Zaurus SL-C7xx, say y to enable the
-	  backlight driver.
-
-config BACKLIGHT_HP680
-	tristate "HP Jornada 680 Backlight Driver"
-	depends on BACKLIGHT_DEVICE && SH_HP6XX
-	default y
-	help
-	  If you have a HP Jornada 680, say y to enable the
-	  backlight driver.
-


---
