Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285261AbRLMXl3>; Thu, 13 Dec 2001 18:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285263AbRLMXlT>; Thu, 13 Dec 2001 18:41:19 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:9398 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S285261AbRLMXlO>; Thu, 13 Dec 2001 18:41:14 -0500
Date: Thu, 13 Dec 2001 18:41:13 -0500 (EST)
From: Keith Warno <krjw@optonline.net>
Subject: make modules_install: chokes on emu10k1 module install
X-X-Sender: kw@behemoth.hobitch.com
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.40.0112131826480.28354-100000@behemoth.hobitch.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a minor annoyance in at least 2.4.16 and 2.4.17-rc1 (don't know
about others).

If emu10k1 sound support is configured to be built and installed as a
module, make modules_install will yack like:

make[2]: Entering directory `/usr/src/linux-2.4.17-rc1/drivers/sound'
mkdir -p /lib/modules/2.4.17-rc1/kernel/drivers/sound/
cp soundcore.o ac97_codec.o ac97_codec.o
/lib/modules/2.4.17-rc1/kernel/drivers/sound/
cp: will not overwrite just-created
`/lib/modules/2.4.17-rc1/kernel/drivers/sound/ac97_codec.o' with
`ac97_codec.o'
make[2]: *** [_modinst__] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.17-rc1/drivers/sound'

Nuke line 75 in drivers/sound/Makefile .

--- linux-2.4.17-rc1/drivers/sound/Makefile     Thu Dec 13 18:36:18 2001
+++ linux/drivers/sound/Makefile        Thu Dec 13 18:37:18 2001
@@ -72,7 +72,6 @@
 obj-$(CONFIG_SOUND_EMU10K1)    += ac97_codec.o
 obj-$(CONFIG_SOUND_RME96XX)     += rme96xx.o
 obj-$(CONFIG_SOUND_BT878)      += btaudio.o
-obj-$(CONFIG_SOUND_EMU10K1)    += ac97_codec.o
 obj-$(CONFIG_SOUND_IT8172)     += ite8172.o ac97_codec.o

 ifeq ($(CONFIG_MIDI_EMU10K1),y)




