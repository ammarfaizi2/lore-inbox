Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWC3L4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWC3L4W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWC3L4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:56:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:42690 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932082AbWC3Lz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:55:57 -0500
X-Authenticated: #31060655
Message-ID: <442BC74B.7060305@gmx.net>
Date: Thu, 30 Mar 2006 13:55:55 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Sam Ravnborg <sam@ravnborg.org>
Subject: Spurious rebuilds of raid6 and drivers/media/video in 2.6.16
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if I copy a compiled kernel tree to another location and run
make again in the new directory, a few files always get rebuilt.
These files only are rebuilt if the tree is a copy of another
tree and they are rebuilt only once.
Any ideas why this is the case?

arch=x86_64, make=3.80, filesystem=reiserfs

Log follows:
compiler@switch:/storage> cd linux-2.6.16/
compiler@switch:/storage/linux-2.6.16> make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
Kernel: arch/x86_64/boot/bzImage is ready  (#1)
  Building modules, stage 2.
  MODPOST
compiler@switch:/storage/linux-2.6.16> cd ..
compiler@switch:/storage> cp -ar linux-2.6.16/ linux-2.6.16-unmodified
compiler@switch:/storage> cd linux-2.6.16-unmodified/
compiler@switch:/storage/linux-2.6.16-unmodified> make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  OUI2C   drivers/ieee1394/oui.c
  CC [M]  drivers/ieee1394/oui.o
  LD [M]  drivers/ieee1394/ieee1394.o
  UNROLL  drivers/md/raid6int1.c
  CC [M]  drivers/md/raid6int1.o
  UNROLL  drivers/md/raid6int2.c
  CC [M]  drivers/md/raid6int2.o
  UNROLL  drivers/md/raid6int4.c
  CC [M]  drivers/md/raid6int4.o
  UNROLL  drivers/md/raid6int8.c
  CC [M]  drivers/md/raid6int8.o
  UNROLL  drivers/md/raid6int16.c
  CC [M]  drivers/md/raid6int16.o
  UNROLL  drivers/md/raid6int32.c
  CC [M]  drivers/md/raid6int32.o
  UNROLL  drivers/md/raid6altivec1.c
  CC [M]  drivers/md/raid6altivec1.o
  UNROLL  drivers/md/raid6altivec2.c
  CC [M]  drivers/md/raid6altivec2.o
  UNROLL  drivers/md/raid6altivec4.c
  CC [M]  drivers/md/raid6altivec4.o
  UNROLL  drivers/md/raid6altivec8.c
  CC [M]  drivers/md/raid6altivec8.o
  LD [M]  drivers/md/raid6.o
  LD [M]  drivers/md/dm-mod.o
  LD [M]  drivers/md/dm-multipath.o
  LD [M]  drivers/md/dm-snapshot.o
  LD [M]  drivers/md/dm-mirror.o
  CC [M]  drivers/media/video/videodev.o
  CC [M]  drivers/media/video/v4l2-common.o
  CC [M]  drivers/media/video/v4l1-compat.o
  CC [M]  drivers/media/video/compat_ioctl32.o
  CC [M]  drivers/media/video/bttv-driver.o
  CC [M]  drivers/media/video/bttv-cards.o
  CC [M]  drivers/media/video/bttv-if.o
  CC [M]  drivers/media/video/bttv-risc.o
  CC [M]  drivers/media/video/bttv-vbi.o
  CC [M]  drivers/media/video/bttv-i2c.o
  CC [M]  drivers/media/video/bttv-gpio.o
  CC [M]  drivers/media/video/bttv-input.o
  CC [M]  drivers/media/video/msp3400-driver.o
  CC [M]  drivers/media/video/msp3400-kthreads.o
  CC [M]  drivers/media/video/tuner-core.o
  CC [M]  drivers/media/video/tuner-types.o
  CC [M]  drivers/media/video/tuner-simple.o
  CC [M]  drivers/media/video/mt20xx.o
  CC [M]  drivers/media/video/tda8290.o
  CC [M]  drivers/media/video/tea5767.o
  CC [M]  drivers/media/video/zoran_procfs.o
  CC [M]  drivers/media/video/zoran_device.o
drivers/media/video/zoran_device.c: In function `zr36057_overlay':
drivers/media/video/zoran_device.c:539: warning: cast from pointer to integer of different size
  CC [M]  drivers/media/video/zoran_driver.o
  CC [M]  drivers/media/video/zoran_card.o
  LD [M]  drivers/media/video/bttv.o
  LD [M]  drivers/media/video/msp3400.o
  CC [M]  drivers/media/video/tvaudio.o
  CC [M]  drivers/media/video/tda7432.o
  CC [M]  drivers/media/video/tda9875.o
  CC [M]  drivers/media/video/ir-kbd-i2c.o
  CC [M]  drivers/media/video/tvmixer.o
  CC [M]  drivers/media/video/saa6588.o
  CC [M]  drivers/media/video/saa5246a.o
  CC [M]  drivers/media/video/saa5249.o
  CC [M]  drivers/media/video/c-qcam.o
  CC [M]  drivers/media/video/bw-qcam.o
  CC [M]  drivers/media/video/w9966.o
  CC [M]  drivers/media/video/saa7111.o
  CC [M]  drivers/media/video/saa7185.o
  CC [M]  drivers/media/video/zr36060.o
  CC [M]  drivers/media/video/saa7110.o
  CC [M]  drivers/media/video/adv7175.o
  CC [M]  drivers/media/video/vpx3220.o
  CC [M]  drivers/media/video/zr36050.o
  CC [M]  drivers/media/video/zr36016.o
  CC [M]  drivers/media/video/bt819.o
  CC [M]  drivers/media/video/bt856.o
  CC [M]  drivers/media/video/saa7114.o
  CC [M]  drivers/media/video/adv7170.o
  LD [M]  drivers/media/video/zr36067.o
  CC [M]  drivers/media/video/videocodec.o
  CC [M]  drivers/media/video/stradis.o
  CC [M]  drivers/media/video/cpia.o
  CC [M]  drivers/media/video/cpia_pp.o
  CC [M]  drivers/media/video/cpia_usb.o
  CC [M]  drivers/media/video/saa711x.o
  CC [M]  drivers/media/video/tvp5150.o
  CC [M]  drivers/media/video/wm8775.o
  CC [M]  drivers/media/video/cs53l32a.o
  LD [M]  drivers/media/video/tuner.o
  CC [M]  drivers/media/video/tda9840.o
  CC [M]  drivers/media/video/tea6415c.o
  CC [M]  drivers/media/video/tea6420.o
  CC [M]  drivers/media/video/mxb.o
  CC [M]  drivers/media/video/hexium_orion.o
  CC [M]  drivers/media/video/hexium_gemini.o
  CC [M]  drivers/media/video/dpc7146.o
  CC [M]  drivers/media/video/tuner-3036.o
  CC [M]  drivers/media/video/tda9887.o
  CC [M]  drivers/media/video/video-buf.o
  CC [M]  drivers/media/video/video-buf-dvb.o
  CC [M]  drivers/media/video/btcx-risc.o
  CC [M]  drivers/media/video/tveeprom.o
  CC [M]  drivers/media/video/saa7115.o
  CC [M]  drivers/media/video/saa7127.o
  CC [M]  drivers/media/video/cx88/cx88-video.o
  CC [M]  drivers/media/video/cx88/cx88-vbi.o
  CC [M]  drivers/media/video/cx88/cx88-mpeg.o
  CC [M]  drivers/media/video/cx88/cx88-cards.o
  CC [M]  drivers/media/video/cx88/cx88-core.o
  CC [M]  drivers/media/video/cx88/cx88-i2c.o
  CC [M]  drivers/media/video/cx88/cx88-tvaudio.o
  CC [M]  drivers/media/video/cx88/cx88-input.o
  LD [M]  drivers/media/video/cx88/cx88xx.o
  LD [M]  drivers/media/video/cx88/cx8800.o
  LD [M]  drivers/media/video/cx88/cx8802.o
  CC [M]  drivers/media/video/cx88/cx88-blackbird.o
  CC [M]  drivers/media/video/cx88/cx88-dvb.o
  CC [M]  drivers/media/video/cx88/cx88-alsa.o
  CC [M]  drivers/media/video/cx88/cx88-vp3054-i2c.o
  CC [M]  drivers/media/video/saa7134/saa7134-cards.o
  CC [M]  drivers/media/video/saa7134/saa7134-core.o
  CC [M]  drivers/media/video/saa7134/saa7134-i2c.o
  CC [M]  drivers/media/video/saa7134/saa7134-ts.o
  CC [M]  drivers/media/video/saa7134/saa7134-tvaudio.o
  CC [M]  drivers/media/video/saa7134/saa7134-vbi.o
  CC [M]  drivers/media/video/saa7134/saa7134-video.o
  CC [M]  drivers/media/video/saa7134/saa7134-input.o
  LD [M]  drivers/media/video/saa7134/saa7134.o
  CC [M]  drivers/media/video/saa7134/saa7134-empress.o
  CC [M]  drivers/media/video/saa7134/saa6752hs.o
  CC [M]  drivers/media/video/saa7134/saa7134-alsa.o
  CC [M]  drivers/media/video/saa7134/saa7134-dvb.o
  CC [M]  drivers/net/chelsio/cxgb2.o
  CC [M]  drivers/net/chelsio/espi.o
  CC [M]  drivers/net/chelsio/pm3393.o
  CC [M]  drivers/net/chelsio/sge.o
  CC [M]  drivers/net/chelsio/subr.o
  CC [M]  drivers/net/chelsio/mv88x201x.o
  LD [M]  drivers/net/chelsio/cxgb.o
Kernel: arch/x86_64/boot/bzImage is ready  (#1)
  Building modules, stage 2.
  MODPOST
  LD [M]  drivers/ieee1394/ieee1394.ko
  LD [M]  drivers/md/dm-mirror.ko
  LD [M]  drivers/md/dm-mod.ko
  LD [M]  drivers/md/dm-multipath.ko
  LD [M]  drivers/md/dm-snapshot.ko
  LD [M]  drivers/md/raid6.ko
  LD [M]  drivers/media/video/adv7170.ko
  LD [M]  drivers/media/video/adv7175.ko
  LD [M]  drivers/media/video/bt819.ko
  LD [M]  drivers/media/video/bt856.ko
  LD [M]  drivers/media/video/btcx-risc.ko
  LD [M]  drivers/media/video/bttv.ko
  LD [M]  drivers/media/video/bw-qcam.ko
  LD [M]  drivers/media/video/c-qcam.ko
  LD [M]  drivers/media/video/compat_ioctl32.ko
  LD [M]  drivers/media/video/cpia.ko
  LD [M]  drivers/media/video/cpia_pp.ko
  LD [M]  drivers/media/video/cpia_usb.ko
  LD [M]  drivers/media/video/cs53l32a.ko
  LD [M]  drivers/media/video/cx88/cx88-alsa.ko
  LD [M]  drivers/media/video/cx88/cx88-blackbird.ko
  LD [M]  drivers/media/video/cx88/cx88-dvb.ko
  LD [M]  drivers/media/video/cx88/cx88-vp3054-i2c.ko
  LD [M]  drivers/media/video/cx88/cx8800.ko
  LD [M]  drivers/media/video/cx88/cx8802.ko
  LD [M]  drivers/media/video/cx88/cx88xx.ko
  LD [M]  drivers/media/video/dpc7146.ko
  LD [M]  drivers/media/video/hexium_gemini.ko
  LD [M]  drivers/media/video/hexium_orion.ko
  LD [M]  drivers/media/video/ir-kbd-i2c.ko
  LD [M]  drivers/media/video/msp3400.ko
  LD [M]  drivers/media/video/mxb.ko
  LD [M]  drivers/media/video/saa5246a.ko
  LD [M]  drivers/media/video/saa5249.ko
  LD [M]  drivers/media/video/saa6588.ko
  LD [M]  drivers/media/video/saa7110.ko
  LD [M]  drivers/media/video/saa7111.ko
  LD [M]  drivers/media/video/saa7114.ko
  LD [M]  drivers/media/video/saa7115.ko
  LD [M]  drivers/media/video/saa711x.ko
  LD [M]  drivers/media/video/saa7127.ko
  LD [M]  drivers/media/video/saa7134/saa6752hs.ko
  LD [M]  drivers/media/video/saa7134/saa7134-alsa.ko
  LD [M]  drivers/media/video/saa7134/saa7134-dvb.ko
  LD [M]  drivers/media/video/saa7134/saa7134-empress.ko
  LD [M]  drivers/media/video/saa7134/saa7134.ko
  LD [M]  drivers/media/video/saa7185.ko
  LD [M]  drivers/media/video/stradis.ko
  LD [M]  drivers/media/video/tda7432.ko
  LD [M]  drivers/media/video/tda9840.ko
  LD [M]  drivers/media/video/tda9875.ko
  LD [M]  drivers/media/video/tda9887.ko
  LD [M]  drivers/media/video/tea6415c.ko
  LD [M]  drivers/media/video/tea6420.ko
  LD [M]  drivers/media/video/tuner-3036.ko
  LD [M]  drivers/media/video/tuner.ko
  LD [M]  drivers/media/video/tvaudio.ko
  LD [M]  drivers/media/video/tveeprom.ko
  LD [M]  drivers/media/video/tvmixer.ko
  LD [M]  drivers/media/video/tvp5150.ko
  LD [M]  drivers/media/video/v4l1-compat.ko
  LD [M]  drivers/media/video/v4l2-common.ko
  LD [M]  drivers/media/video/video-buf-dvb.ko
  LD [M]  drivers/media/video/video-buf.ko
  LD [M]  drivers/media/video/videocodec.ko
  LD [M]  drivers/media/video/videodev.ko
  LD [M]  drivers/media/video/vpx3220.ko
  LD [M]  drivers/media/video/w9966.ko
  LD [M]  drivers/media/video/wm8775.ko
  LD [M]  drivers/media/video/zr36016.ko
  LD [M]  drivers/media/video/zr36050.ko
  LD [M]  drivers/media/video/zr36060.ko
  LD [M]  drivers/media/video/zr36067.ko
  LD [M]  drivers/net/chelsio/cxgb.ko
compiler@switch:/storage/linux-2.6.16-unmodified> make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
Kernel: arch/x86_64/boot/bzImage is ready  (#1)
  Building modules, stage 2.
  MODPOST
compiler@switch:/storage/linux-2.6.16-unmodified>


Regards,
Carl-Daniel
