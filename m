Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVCHCUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVCHCUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVCHCTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 21:19:32 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:60853 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261929AbVCHCPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 21:15:46 -0500
Date: Tue, 8 Mar 2005 03:15:42 +0100
From: Michal Januszewski <spock@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: [announce 6/7] fbsplash - kconfig and makefiles
Message-ID: <20050308021542.GG26249@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Januszewski <spock@gentoo.org>

---
diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2005-03-07 16:50:34 +01:00
+++ b/drivers/video/Kconfig	2005-03-07 16:50:34 +01:00
@@ -1140,5 +1140,15 @@
 	source "drivers/video/backlight/Kconfig"
 endif
 
-endmenu
+config FB_SPLASH
+	bool "Support for the framebuffer splash"
+	depends on FRAMEBUFFER_CONSOLE=y && !FB_TILEBLITTING
+	default n
+	---help---
+	  This option enables support for graphical backgrounds on consoles. 
+	  Note that you will need userspace splash utilities in order to take
+	  advantage of these features. Refer to Documentation/fb/splash.txt 
+	  for more information.
 
+	  If unsure, say N.
+endmenu
diff -Nru a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	2005-03-07 16:50:34 +01:00
+++ b/drivers/Makefile	2005-03-07 16:50:34 +01:00
@@ -7,15 +7,14 @@
 
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_PARISC)		+= parisc/
+# char/ comes before serial/ etc so that the VT console is the boot-time
+# default.
+obj-y				+= char/
 obj-y				+= video/
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
 obj-$(CONFIG_PNP)		+= pnp/
-
-# char/ comes before serial/ etc so that the VT console is the boot-time
-# default.
-obj-y				+= char/
 
 # i810fb and intelfb depend on char/agp/
 obj-$(CONFIG_FB_I810)           += video/i810/
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	2005-03-07 16:50:34 +01:00
+++ b/drivers/video/Makefile	2005-03-07 16:50:34 +01:00
@@ -7,6 +7,7 @@
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
 obj-$(CONFIG_SYSFS)		  += backlight/
+obj-$(CONFIG_FB_SPLASH)	  += fbsplash.o cfbsplash.o
 
 obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o softcursor.o
 # Only include macmodes.o if we have FB support and are PPC



