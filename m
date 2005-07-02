Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVGBWDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVGBWDL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 18:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVGBWBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 18:01:41 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12042 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261296AbVGBV6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 17:58:02 -0400
Date: Sat, 2 Jul 2005 23:58:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@brturbo.com.br
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] VIDEO_SAA7134 must depend on SOUND
Message-ID: <20050702215800.GI5346@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VIDEO_SAA7134=y and SOUND=n results in the following compile error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x4fafcb): In function `saa7134_initdev':
: undefined reference to `unregister_sound_dsp'
drivers/built-in.o(.text+0x4fb141): In function `saa7134_initdev':
: undefined reference to `register_sound_dsp'
drivers/built-in.o(.text+0x4fb17c): In function `saa7134_initdev':
: undefined reference to `register_sound_mixer'
drivers/built-in.o(.text+0x4fb339): In function `saa7134_finidev':
: undefined reference to `unregister_sound_mixer'
drivers/built-in.o(.text+0x4fb341): In function `saa7134_finidev':
: undefined reference to `unregister_sound_dsp'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc1-mm1-full/drivers/media/video/Kconfig.old	2005-07-02 19:57:04.000000000 +0200
+++ linux-2.6.13-rc1-mm1-full/drivers/media/video/Kconfig	2005-07-02 20:01:33.000000000 +0200
@@ -249,7 +249,7 @@
 
 config VIDEO_SAA7134
 	tristate "Philips SAA7134 support"
-	depends on VIDEO_DEV && PCI && I2C
+	depends on VIDEO_DEV && PCI && I2C && SOUND
 	select VIDEO_BUF
 	select VIDEO_IR
 	select VIDEO_TUNER

