Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271855AbTGRWLV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271844AbTGRWHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:07:11 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:43780 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S271903AbTGRWBK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:01:10 -0400
Date: Sat, 19 Jul 2003 00:12:56 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] 2.6.0-test1-after-alan-s-patch - More Makefile/Kconfig bits
Message-ID: <20030719001256.C780@electric-eye.fr.zoreil.com>
References: <200307181432.h6IEW9Mt017886@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307181432.h6IEW9Mt017886@hraefn.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Jul 18, 2003 at 03:32:09PM +0100
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds kahlua, harmony and hal2 drivers amongst the build options.


 sound/oss/Kconfig  |   12 ++++++++++++
 sound/oss/Makefile |    3 +++
 2 files changed, 15 insertions(+)

diff -puN sound/oss/Makefile~doh-sync-oss-build sound/oss/Makefile
--- linux-2.6.0-test1-20030718_0517/sound/oss/Makefile~doh-sync-oss-build	Fri Jul 18 23:43:22 2003
+++ linux-2.6.0-test1-20030718_0517-fr/sound/oss/Makefile	Fri Jul 18 23:45:47 2003
@@ -10,6 +10,7 @@ obj-$(CONFIG_SOUND_CS4232)	+= cs4232.o a
 
 # Please leave it as is, cause the link order is significant !
 
+obj-$(CONFIG_SOUND_HAL2)	+= hal2.o
 obj-$(CONFIG_SOUND_AEDSP16)	+= aedsp16.o
 obj-$(CONFIG_SOUND_PSS)		+= pss.o ad1848.o mpu401.o
 obj-$(CONFIG_SOUND_TRIX)	+= trix.o ad1848.o sb_lib.o uart401.o
@@ -21,6 +22,7 @@ obj-$(CONFIG_SOUND_MSS)		+= ad1848.o
 obj-$(CONFIG_SOUND_OPL3SA2)	+= opl3sa2.o ad1848.o mpu401.o
 obj-$(CONFIG_SOUND_PAS)		+= pas2.o sb.o sb_lib.o uart401.o
 obj-$(CONFIG_SOUND_SB)		+= sb.o sb_lib.o uart401.o
+obj-$(CONFIG_SOUND_KAHLUA)	+= kahlua.o
 obj-$(CONFIG_SOUND_WAVEFRONT)	+= wavefront.o
 obj-$(CONFIG_SOUND_MAUI)	+= maui.o mpu401.o
 obj-$(CONFIG_SOUND_MPU401)	+= mpu401.o
@@ -60,6 +62,7 @@ obj-$(CONFIG_SOUND_FUSION)	+= cs46xx.o a
 obj-$(CONFIG_SOUND_MAESTRO)	+= maestro.o
 obj-$(CONFIG_SOUND_MAESTRO3)	+= maestro3.o ac97_codec.o
 obj-$(CONFIG_SOUND_TRIDENT)	+= trident.o ac97_codec.o
+obj-$(CONFIG_SOUND_HARMONY)	+= harmony.o
 obj-$(CONFIG_SOUND_EMU10K1)	+= ac97_codec.o
 obj-$(CONFIG_SOUND_RME96XX)     += rme96xx.o
 obj-$(CONFIG_SOUND_BT878)	+= btaudio.o
diff -puN sound/oss/Kconfig~doh-sync-oss-build sound/oss/Kconfig
--- linux-2.6.0-test1-20030718_0517/sound/oss/Kconfig~doh-sync-oss-build	Fri Jul 18 23:43:28 2003
+++ linux-2.6.0-test1-20030718_0517-fr/sound/oss/Kconfig	Sat Jul 19 00:02:51 2003
@@ -233,6 +233,10 @@ config SOUND_ICH
 	  Support for integral audio in Intel's I/O Controller Hub (ICH)
 	  chipset, as used on the 810/820/840 motherboards.
 
+config SOUND_HARMONY
+	tristate "PA Harmony audio driver"
+	depends on GSC_LASI && SOUND
+
 config SOUND_RME96XX
 	tristate "RME Hammerfall (RME96XX) support (EXPERIMENTAL)"
 	depends on SOUND_PRIME!=n && SOUND && PCI && EXPERIMENTAL
@@ -260,6 +264,10 @@ config SOUND_VWSND
 	  <file:Documentation/sound/oss/vwsnd> for more info on this driver's
 	  capabilities.
 
+config SOUND_HAL2
+	tristate "SGI HAL2 sound (EXPERIMENTAL)"
+	depends on SGI_IP22 && SOUND && EXPERIMENTAL
+
 config SOUND_VRC5477
 	tristate "NEC Vrc5477 AC97 sound"
 	depends on SOUND_PRIME!=n && DDB5477 && SOUND
@@ -1125,4 +1133,8 @@ config SOUND_TVMIXER
 	help
 	  Support for audio mixer facilities on the BT848 TV frame-grabber
 	  card.
+
+config SOUND_KAHLUA
+	tristate "XpressAudio Sound Blaster emulation"
+	depends on SOUND_SB
 

_
