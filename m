Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271805AbTGRPGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271829AbTGRPDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:03:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39301
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271799AbTGRORt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:17:49 -0400
Date: Fri, 18 Jul 2003 15:32:09 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181432.h6IEW9Mt017886@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: Makefile bits for audio resync
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/sound/oss/Kconfig linux-2.6.0-test1-ac2/sound/oss/Kconfig
--- linux-2.6.0-test1/sound/oss/Kconfig	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test1-ac2/sound/oss/Kconfig	2003-07-14 14:25:18.000000000 +0100
@@ -1126,3 +1126,19 @@
 	  Support for audio mixer facilities on the BT848 TV frame-grabber
 	  card.
 
+config SOUND_ALI5455
+	tristate "ALi5455 audio support"
+	depends on SOUND_PRIME!=n && PCI
+
+config SOUND_FORTE
+	tristate "ForteMedia FM801 driver"
+	depends on SOUND_PRIME!=n && PCI
+
+config SOUND_RME96XX
+	tristate "RME Hammerfall (RME96XX) support"
+	depends on SOUND_PRIME!=n && PCI
+
+config SOUND_AD1980
+	tristate "AD1980 front/back switch plugin"
+	depends on SOUND_PRIME!=n
+
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/sound/oss/Makefile linux-2.6.0-test1-ac2/sound/oss/Makefile
--- linux-2.6.0-test1/sound/oss/Makefile	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test1-ac2/sound/oss/Makefile	2003-07-14 14:25:22.000000000 +0100
@@ -63,7 +63,12 @@
 obj-$(CONFIG_SOUND_EMU10K1)	+= ac97_codec.o
 obj-$(CONFIG_SOUND_RME96XX)     += rme96xx.o
 obj-$(CONFIG_SOUND_BT878)	+= btaudio.o
+obj-$(CONFIG_SOUND_ALI5455)	+= ali5455.o ac97_codec.o
 obj-$(CONFIG_SOUND_IT8172)	+= ite8172.o ac97_codec.o
+obj-$(CONFIG_SOUND_FORTE)	+= forte.o
+
+obj-$(CONFIG_SOUND_AD1980)	+= ac97_plugin_ad1980.o
+obj-$(CONFIG_SOUND_WM97XX)	+= ac97_plugin_wm97xx.o
 
 ifeq ($(CONFIG_MIDI_EMU10K1),y)
   obj-$(CONFIG_SOUND_EMU10K1)	+= sound.o
