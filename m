Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263826AbTCUTFV>; Fri, 21 Mar 2003 14:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263854AbTCUTFJ>; Fri, 21 Mar 2003 14:05:09 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38532
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263826AbTCUS5f>; Fri, 21 Mar 2003 13:57:35 -0500
Date: Fri, 21 Mar 2003 20:12:49 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212012.h2LKCnNi026328@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: config glue for pc98xx audio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/core/Makefile linux-2.5.65-ac2/sound/core/Makefile
--- linux-2.5.65/sound/core/Makefile	2003-02-10 18:38:46.000000000 +0000
+++ linux-2.5.65-ac2/sound/core/Makefile	2003-03-06 23:28:34.000000000 +0000
@@ -93,6 +93,7 @@
 obj-$(CONFIG_SND_YMFPCI) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_POWERMAC) += snd-pcm.o snd-timer.o snd.o
 obj-$(CONFIG_SND_SA11XX_UDA1341) += snd-pcm.o snd-timer.o snd.o
+obj-$(CONFIG_SND_PC98_CS4232) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
 ifeq ($(CONFIG_SND_SB16_CSP),y)
   obj-$(CONFIG_SND_SB16) += snd-hwdep.o
   obj-$(CONFIG_SND_SBAWE) += snd-hwdep.o
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/drivers/mpu401/Makefile linux-2.5.65-ac2/sound/drivers/mpu401/Makefile
--- linux-2.5.65/sound/drivers/mpu401/Makefile	2003-02-10 18:39:14.000000000 +0000
+++ linux-2.5.65-ac2/sound/drivers/mpu401/Makefile	2003-03-06 23:28:34.000000000 +0000
@@ -37,5 +37,6 @@
 obj-$(CONFIG_SND_ALI5451) += snd-mpu401-uart.o
 obj-$(CONFIG_SND_TRIDENT) += snd-mpu401-uart.o
 obj-$(CONFIG_SND_YMFPCI) += snd-mpu401-uart.o
+obj-$(CONFIG_SND_PC98_CS4232) += snd-mpu401-uart.o
 
 obj-m := $(sort $(obj-m))
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/drivers/opl3/Makefile linux-2.5.65-ac2/sound/drivers/opl3/Makefile
--- linux-2.5.65/sound/drivers/opl3/Makefile	2003-02-10 18:37:56.000000000 +0000
+++ linux-2.5.65-ac2/sound/drivers/opl3/Makefile	2003-03-06 23:28:34.000000000 +0000
@@ -24,6 +24,7 @@
 obj-$(CONFIG_SND_OPL3SA2) += $(OPL3_OBJS)
 obj-$(CONFIG_SND_AD1816A) += $(OPL3_OBJS)
 obj-$(CONFIG_SND_CS4232) += $(OPL3_OBJS)
+obj-$(CONFIG_SND_PC98_CS4232) += $(OPL3_OBJS)
 obj-$(CONFIG_SND_CS4236) += $(OPL3_OBJS)
 obj-$(CONFIG_SND_ES1688) += $(OPL3_OBJS)
 obj-$(CONFIG_SND_GUSEXTREME) += $(OPL3_OBJS)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/isa/cs423x/Makefile linux-2.5.65-ac2/sound/isa/cs423x/Makefile
--- linux-2.5.65/sound/isa/cs423x/Makefile	2003-02-10 18:38:51.000000000 +0000
+++ linux-2.5.65-ac2/sound/isa/cs423x/Makefile	2003-03-06 23:28:34.000000000 +0000
@@ -8,6 +8,7 @@
 snd-cs4231-objs := cs4231.o
 snd-cs4232-objs := cs4232.o
 snd-cs4236-objs := cs4236.o
+snd-pc98-cs4232-objs := pc98.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_AZT2320) += snd-cs4231-lib.o
@@ -20,5 +21,6 @@
 obj-$(CONFIG_SND_INTERWAVE_STB) += snd-cs4231-lib.o
 obj-$(CONFIG_SND_OPTI92X_CS4231) += snd-cs4231-lib.o
 obj-$(CONFIG_SND_WAVEFRONT) += snd-cs4231-lib.o
+obj-$(CONFIG_SND_PC98_CS4232) += snd-pc98-cs4232.o snd-cs4231-lib.o
 
 obj-m := $(sort $(obj-m))
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/isa/Kconfig linux-2.5.65-ac2/sound/isa/Kconfig
--- linux-2.5.65/sound/isa/Kconfig	2003-02-10 18:38:52.000000000 +0000
+++ linux-2.5.65-ac2/sound/isa/Kconfig	2003-03-06 23:28:34.000000000 +0000
@@ -39,6 +39,12 @@
 	  Say 'Y' or 'M' to include support for CS4235,CS4236,CS4237B,CS4238B,CS4239
 	  chips from Cirrus Logic - Crystal Semiconductors.
 
+config SND_PC98_CS4232
+	tristate "NEC PC9800 CS4232 driver"
+	depends on SND
+	help
+	  Say 'Y' or 'M' to include support for NEC PC-9801/PC-9821 sound cards
+
 config SND_ES968
 	tristate "Generic ESS ES968 driver"
 	depends on SND && ISAPNP
