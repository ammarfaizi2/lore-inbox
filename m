Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271352AbTG2JkB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271363AbTG2JbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:31:08 -0400
Received: from mail.convergence.de ([212.84.236.4]:39134 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S271356AbTG2Jaf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:30:35 -0400
Subject: [PATCH 1/6] [DVB] Kconfig and Makefile updates
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 29 Jul 2003 11:30:30 +0200
Message-Id: <10594710302828@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

here comes a set of 6 small patches for the DVB subsystem against
2.6.0-test2, sized between 1kB and 6kB.

They fix various aspects in different parts of
the driver. Detailed descriptions are at the top of each patch.

Please apply. Thanks!

CU
Michael.

[V4L] - make sure saa7146 module gets build for Hexium drivers
[V4L] - make Hexium drivers depend on the i2c layer
[DVB] - fix typo which prevented the mt312 driver from being build (obi <=> obj)
diff -uNrwB --new-file linux-2.6.0-test2.work/drivers/media/common/Kconfig linux-2.6.0-test2.patch/drivers/media/common/Kconfig
--- linux-2.6.0-test2.work/drivers/media/common/Kconfig	2003-07-29 09:10:19.000000000 +0200
+++ linux-2.6.0-test2.patch/drivers/media/common/Kconfig	2003-07-17 11:03:08.000000000 +0200
@@ -1,8 +1,8 @@
 config VIDEO_SAA7146
         tristate
-        default y if DVB_AV7110=y || DVB_BUDGET=y || DVB_BUDGET_AV=y || VIDEO_MXB=y || VIDEO_DPC=y
-        default m if DVB_AV7110=m || DVB_BUDGET=m || DVB_BUDGET_AV=m || VIDEO_MXB=m || VIDEO_DPC=m
-        depends on VIDEO_DEV && PCI
+        default y if DVB_AV7110=y || DVB_BUDGET=y || DVB_BUDGET_AV=y || VIDEO_MXB=y || VIDEO_DPC=y || VIDEO_HEXIUM_ORION=y || VIDEO_HEXIUM_GEMINI=y
+        default m if DVB_AV7110=m || DVB_BUDGET=m || DVB_BUDGET_AV=m || VIDEO_MXB=m || VIDEO_DPC=m || VIDEO_HEXIUM_ORION=m || VIDEO_HEXIUM_GEMINI=m
+        depends on VIDEO_DEV && PCI && I2C
 
 config VIDEO_VIDEOBUF
         tristate
diff -uNrwB --new-file linux-2.6.0-test2.work/drivers/media/dvb/frontends/Makefile linux-2.6.0-test2.patch/drivers/media/dvb/frontends/Makefile
--- linux-2.6.0-test2.work/drivers/media/dvb/frontends/Makefile	2003-07-29 09:10:18.000000000 +0200
+++ linux-2.6.0-test2.patch/drivers/media/dvb/frontends/Makefile	2003-07-29 09:17:53.000000000 +0200
@@ -12,6 +12,6 @@
 obj-$(CONFIG_DVB_CX24110) += cx24110.o
 obj-$(CONFIG_DVB_GRUNDIG_29504_491) += grundig_29504-491.o
 obj-$(CONFIG_DVB_GRUNDIG_29504_401) += grundig_29504-401.o
-obi-$(CONFIG_DVB_MT312) += mt312.o
+obj-$(CONFIG_DVB_MT312) += mt312.o
 obj-$(CONFIG_DVB_VES1820) += ves1820.o
 obj-$(CONFIG_DVB_TDA1004X) += tda1004x.o
diff -uNrwB --new-file linux-2.6.0-test2.work/drivers/media/video/Kconfig linux-2.6.0-test2.patch/drivers/media/video/Kconfig
--- linux-2.6.0-test2.work/drivers/media/video/Kconfig	2003-07-29 09:10:18.000000000 +0200
+++ linux-2.6.0-test2.patch/drivers/media/video/Kconfig	2003-07-17 11:03:08.000000000 +0200
@@ -259,7 +259,7 @@
 
 config VIDEO_HEXIUM_ORION
 	tristate "Hexium HV-PCI6 and Orion frame grabber"
-	depends on VIDEO_DEV && PCI
+	depends on VIDEO_DEV && PCI && I2C
 	---help---
 	  This is a video4linux driver for the Hexium HV-PCI6 and
 	  Orion frame grabber cards by Hexium.
@@ -271,7 +271,7 @@
 
 config VIDEO_HEXIUM_GEMINI
 	tristate "Hexium Gemini frame grabber"
-	depends on VIDEO_DEV && PCI
+	depends on VIDEO_DEV && PCI && I2C
 	---help---
 	  This is a video4linux driver for the Hexium Gemini frame
 	  grabber card by Hexium. Please note that the Gemini Dual

