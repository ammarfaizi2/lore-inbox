Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267140AbTGKWcp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267106AbTGKWcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:32:43 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:12553 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S267108AbTGKWbU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:31:20 -0400
Date: Sat, 12 Jul 2003 00:45:01 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] Re: PATCH: Merge AD1889 driver from 2.4
Message-ID: <20030712004501.B25528@electric-eye.fr.zoreil.com>
References: <200307111821.h6BILFpr017428@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307111821.h6BILFpr017428@hraefn.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Jul 11, 2003 at 07:21:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch may help:

- include/linux/wrapper.h doesn't exist in 2.5.75 and none of it's content
  is used by the driver;
- s/MINOR/minor/;
- KConfig/Makefile update.


 sound/oss/Kconfig  |    7 +++++++
 sound/oss/Makefile |    1 +
 sound/oss/ad1889.c |    6 +++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff -puN sound/oss/ad1889.c~ahum-merge-ad1889 sound/oss/ad1889.c
--- linux-2.5.75-20030711_0808/sound/oss/ad1889.c~ahum-merge-ad1889	Sat Jul 12 00:40:26 2003
+++ linux-2.5.75-20030711_0808-fr/sound/oss/ad1889.c	Sat Jul 12 00:40:26 2003
@@ -37,7 +37,7 @@
 #include <linux/soundcard.h>
 #include <linux/ac97_codec.h>
 #include <linux/sound.h>
-#include <linux/wrapper.h>
+#include <linux/interrupt.h>
 
 #include <asm/delay.h>
 #include <asm/io.h>
@@ -749,7 +749,7 @@ static int ad1889_ioctl(struct inode *in
 static int ad1889_open(struct inode *inode, struct file *file)
 {
 	/* check minor; only support /dev/dsp atm */
-	if (MINOR(inode->i_rdev) != 3)
+	if (minor(inode->i_rdev) != 3)
 		return -ENXIO;
 	
 	file->private_data = ad1889_dev;
@@ -782,7 +782,7 @@ static struct file_operations ad1889_fop
 /************************* /dev/mixer interfaces ************************ */
 static int ad1889_mixer_open(struct inode *inode, struct file *file)
 {
-	if (ad1889_dev->ac97_codec->dev_mixer != MINOR(inode->i_rdev))
+	if (ad1889_dev->ac97_codec->dev_mixer != minor(inode->i_rdev))
 		return -ENODEV;
 
 	file->private_data = ad1889_dev->ac97_codec;
diff -puN sound/oss/Kconfig~ahum-merge-ad1889 sound/oss/Kconfig
--- linux-2.5.75-20030711_0808/sound/oss/Kconfig~ahum-merge-ad1889	Sat Jul 12 00:40:26 2003
+++ linux-2.5.75-20030711_0808-fr/sound/oss/Kconfig	Sat Jul 12 00:40:26 2003
@@ -598,6 +598,13 @@ config SOUND_AD1816
 	  If you compile the driver into the kernel, you have to add
 	  "ad1816=<io>,<irq>,<dma>,<dma2>" to the kernel command line.
 
+config SOUND_AD1889
+	tristate "AD1889 based cards (AD1819 codec) (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && SOUND_OSS
+	help
+	  Say M here if you have a sound card based on the Analog Devices
+	  AD1889 chip.
+
 config SOUND_SGALAXY
 	tristate "Aztech Sound Galaxy (non-PnP) cards"
 	depends on SOUND_OSS
diff -puN sound/oss/Makefile~ahum-merge-ad1889 sound/oss/Makefile
--- linux-2.5.75-20030711_0808/sound/oss/Makefile~ahum-merge-ad1889	Sat Jul 12 00:40:26 2003
+++ linux-2.5.75-20030711_0808-fr/sound/oss/Makefile	Sat Jul 12 00:40:26 2003
@@ -33,6 +33,7 @@ obj-$(CONFIG_SOUND_VIDC)	+= vidc_mod.o
 obj-$(CONFIG_SOUND_WAVEARTIST)	+= waveartist.o
 obj-$(CONFIG_SOUND_SGALAXY)	+= sgalaxy.o ad1848.o
 obj-$(CONFIG_SOUND_AD1816)	+= ad1816.o
+obj-$(CONFIG_SOUND_AD1889)	+= ad1889.o ac97_codec.o
 obj-$(CONFIG_SOUND_ACI_MIXER)	+= aci.o
 obj-$(CONFIG_SOUND_AWE32_SYNTH)	+= awe_wave.o
 

_
