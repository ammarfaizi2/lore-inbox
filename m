Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267657AbSLSWVw>; Thu, 19 Dec 2002 17:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbSLSWUf>; Thu, 19 Dec 2002 17:20:35 -0500
Received: from ulima.unil.ch ([130.223.144.143]:1229 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S267424AbSLSWT2>;
	Thu, 19 Dec 2002 17:19:28 -0500
Date: Thu, 19 Dec 2002 23:27:30 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-dvb@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: How to compil dvb CVS with 2.5.52?
Message-ID: <20021219222730.GA3324@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am too stupid to understand the README: with 2.5.52 should I patch
with both :

greg@localhost:linux >patch -p1 < /usr/src/CVS/dvb-kernel/00_knorr_v4l1_compat.patch
patching file drivers/media/video/Makefile
Hunk #1 succeeded at 5 with fuzz 1.
patching file drivers/media/video/v4l1-compat.c
patching file kernel/ksyms.c
Hunk #1 succeeded at 323 (offset 2 lines).
greg@localhost:linux >patch -p1 < /usr/src/CVS/dvb-kernel/01_video-buf.patch
patching file drivers/media/Makefile
patching file drivers/media/Kconfig
patching file drivers/media/common/Kconfig
patching file drivers/media/common/Makefile
patching file drivers/media/common/video-buf.c
patching file drivers/media/common/video-buf.h
patching file drivers/media/video/Makefile
Hunk #2 succeeded at 38 with fuzz 2.
patching file drivers/media/video/saa7134/Makefile
patching file drivers/media/video/video-buf.c
patching file drivers/media/video/video-buf.h

And then the makelinks /usr/src/linux-2.5.52-dvb

It then don't compil and i have to patch with the patch sent to this
list the Wed, 11 Dec 2002 10:53:43 +1100 from Rusty Russell:

--- drivers/media/dvb/dvb-core/dvb_i2c.c	2002-12-19 23:21:07.000000000 +0100
+++ drivers/media/dvb/dvb-core/dvb_i2c.c~	2002-11-28 19:57:09.000000000 +0100
@@ -64,8 +64,10 @@
 void try_attach_device (struct dvb_i2c_bus *i2c, struct dvb_i2c_device *dev)
 {
 	if (dev->owner) {
-		if (!try_inc_mod_count(dev->owner))
+		if (!MOD_CAN_QUERY(dev->owner))
 			return;
+
+		__MOD_INC_USE_COUNT(dev->owner);
 	}
 
 	if (dev->attach (i2c) == 0) {

And then:

  ld -m elf_i386  -r -o drivers/media/common/saa7146.ko drivers/media/common/saa7146_core.o drivers/media/common/saa7146_hlp.o drivers/media/common/saa7146_i2c.o drivers/media/common/saa7146_vbi.o drivers/media/common/saa7146_video.o
make -f scripts/Makefile.build obj=drivers/media/dvb
make -f scripts/Makefile.build obj=drivers/media/dvb/av7110
make[4]: *** No rule to make target `drivers/media/dvb/av7110/saa7146_core.s', needed by `drivers/media/dvb/av7110/saa7146_core.o'.  Stop.
make[3]: *** [drivers/media/dvb/av7110] Error 2
make[2]: *** [drivers/media/dvb] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

>From my .config:

CONFIG_DVB=y
CONFIG_DVB_CORE=y
CONFIG_DVB_DEVFS_ONLY=y
CONFIG_DVB_ALPS_BSRV2=m
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_VIDEOBUF=m

Well, could you explain me what's wrong with my way to compil it?

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
