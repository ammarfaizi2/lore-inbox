Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271003AbTG1CZO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271002AbTG1AAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:00:47 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272951AbTG0XCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:20 -0400
Date: Sun, 27 Jul 2003 21:01:36 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272001.h6RK1aNo029580@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: re-enable SiS direct render
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

((Gaël Le Mignot)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/char/drm/Kconfig linux-2.6.0-test2-ac1/drivers/char/drm/Kconfig
--- linux-2.6.0-test2/drivers/char/drm/Kconfig	2003-07-10 21:13:38.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/char/drm/Kconfig	2003-07-23 18:48:09.000000000 +0100
@@ -72,3 +72,12 @@
 	  Choose this option if you have a Matrox G200, G400 or G450 graphics
 	  card.  If M is selected, the module will be called mga.  AGP
 	  support is required for this driver to work.
+
+config DRM_SIS
+	tristate "SiS video cards"
+	depends on DRM && AGP
+	help
+	  Choose this option if you have a SiS 630 or compatibel video 
+          chipset. If M is selected the module will be called sis. AGP
+          support is required for this driver to work.
+
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/char/drm/Makefile linux-2.6.0-test2-ac1/drivers/char/drm/Makefile
--- linux-2.6.0-test2/drivers/char/drm/Makefile	2003-07-10 21:14:54.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/char/drm/Makefile	2003-07-23 18:48:09.000000000 +0100
@@ -10,6 +10,7 @@
 i830-objs   := i830_drv.o i830_dma.o i830_irq.o
 radeon-objs := radeon_drv.o radeon_cp.o radeon_state.o radeon_mem.o radeon_irq.o
 ffb-objs    := ffb_drv.o ffb_context.o
+sis-objs    := sis_drv.o sis_ds.o sis_mm.o
 
 obj-$(CONFIG_DRM_GAMMA) += gamma.o
 obj-$(CONFIG_DRM_TDFX)	+= tdfx.o
@@ -19,3 +20,5 @@
 obj-$(CONFIG_DRM_I810)	+= i810.o
 obj-$(CONFIG_DRM_I830)	+= i830.o
 obj-$(CONFIG_DRM_FFB)   += ffb.o
+obj-$(CONFIG_DRM_SIS)   += sis.o
+
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/char/drm/sis_mm.c linux-2.6.0-test2-ac1/drivers/char/drm/sis_mm.c
--- linux-2.6.0-test2/drivers/char/drm/sis_mm.c	2003-07-10 21:12:16.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/char/drm/sis_mm.c	2003-07-23 18:48:09.000000000 +0100
@@ -28,8 +28,9 @@
  * 
  */
 
+#include <linux/config.h>
 #include "sis.h"
-#include <linux/sisfb.h>
+#include "video/sisfb.h"
 #include "drmP.h"
 #include "sis_drm.h"
 #include "sis_drv.h"
