Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVK3DTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVK3DTq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 22:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVK3DTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 22:19:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39621 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750825AbVK3DTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 22:19:46 -0500
Date: Wed, 30 Nov 2005 01:02:32 -0200
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com
Subject: [PATCH 00/40] V4L/DVB bug fixes.
Message-Id: <1133320776.7487.111.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.2 NO_REAL_NAME           From: does not include a real name
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[200.181.83.63 listed in dnsbl.sorbs.net]
	0.4 DNS_FROM_RFC_ABUSE     RBL: Envelope sender in abuse.rfc-ignorant.org
	1.4 DNS_FROM_RFC_POST      RBL: Envelope sender in postmaster.rfc-ignorant.org
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[200.181.83.63 listed in combined.njabl.org]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Starting from now, v4l/dvb patches will be at a common quilt
repository at: http://linuxtv.org/download/quilt.

	The main significative change is that compat32 code was moved from
fs to v4l in order to make easier to fix. There are still some V4L2 ioctl 
not handled by the driver. This should go on a next patchset.

        This patch series fixes several small bugs:

- Moves compat32 functions from fs to v4l subsystem
- Compat ioctl32 license fix
- Explicit compat_ioctl32 handler to em28xx
- More build fixes for compat_ioctl32.c
- Another build fix for compat_ioctl32.c
- 64-bit fixes for removing warnings on compat_ioctl32
- Fixes maximum number of VBI devices
- Fix hotplugging issues with saa7134
- Fixes warning at bttv-driver.c
- Added Secam L' std on tda9887 and common macros moved to videodev2.h
- Include comments for DVB models and includes missing ones
- tveeprom MAC address parsing/cleanup
- Fixes nicam sound
- Removed audio DMA enabling from cx88-core
- Fix read() bugs in bttv driver
- Bttv bytes per line fix
- Enables audio DMA setting on cx88 chips, even when dma not in use
- Some funcions now static and I2C hw code for IR
- Makes needlessly global code static
- Fixes Bttv raw format to fix VIDIOCSPICT ioctl
- Write cached value to correct register for SECAM
- Fix crash when not compiled as module
- Fix bttv ioctls VIDIOC_ENUMINPUT, VIDIOCGTUNER, VIDIOC_QUERYCAP
- Fixed eeprom handling for cx88 and added Nova-T PCI model 90003
- Added basic support (tv + radio) for TerraTec Cinergy 250 PCI
- Added Hauppauge ImpactVCB board
- Add workaround for Hauppauge PVR150 with certain NTSC tuner models
- Fixed DiSEqC timing for saa7146-based budget cards
- Fix locking problems and code cleanup
- Fixed mistake of an incorrect usage of pid filter-callbacks inside the private state of the dvb-usb-devices
- Include fixes for 2.6.15-rc1 for removing sched.h from
- Update Steve's email address.
- Small cleanups:
- Fix locking to prevent Oops on SMP systems when starting/stopping
- Remove stray semicolons after if (foo); in ves1820 set symbolrate().
- BUDGET CI card depends on STV0297 demodulator.
- Fix kernel message (print of %s from random pointer)
- Restore missing tuner definition for Hauppauge tuner type 0x103
- Fix typo, removing incorrect info from CONFIG_BT848_DVB kconfig entry.

---------

 Documentation/video4linux/CARDLIST.bttv     |    1 
 Documentation/video4linux/CARDLIST.saa7134  |    2 
 MAINTAINERS                                 |    3 
 drivers/media/dvb/b2c2/flexcop-hw-filter.c  |    2 
 drivers/media/dvb/dvb-core/dvb_ca_en50221.c |   69 +---
 drivers/media/dvb/dvb-core/dvb_net.c        |   31 +
 drivers/media/dvb/dvb-usb/a800.c            |    2 
 drivers/media/dvb/dvb-usb/dibusb-common.c   |   18 -
 drivers/media/dvb/dvb-usb/digitv.c          |    2 
 drivers/media/dvb/dvb-usb/dvb-usb-init.c    |    2 
 drivers/media/dvb/frontends/cx22702.c       |    2 
 drivers/media/dvb/frontends/cx22702.h       |    2 
 drivers/media/dvb/frontends/nxt200x.c       |    2 
 drivers/media/dvb/frontends/ves1820.c       |   14 
 drivers/media/dvb/ttpci/Kconfig             |    1 
 drivers/media/dvb/ttpci/av7110_ca.c         |    1 
 drivers/media/dvb/ttpci/budget-av.c         |    2 
 drivers/media/dvb/ttpci/budget-ci.c         |    2 
 drivers/media/dvb/ttpci/budget.c            |    2 
 drivers/media/dvb/ttpci/ttpci-eeprom.c      |    1 
 drivers/media/radio/miropcm20-radio.c       |    1 
 drivers/media/radio/radio-aimslab.c         |    1 
 drivers/media/radio/radio-aztech.c          |    1 
 drivers/media/radio/radio-cadet.c           |    1 
 drivers/media/radio/radio-gemtek-pci.c      |    1 
 drivers/media/radio/radio-gemtek.c          |    1 
 drivers/media/radio/radio-maestro.c         |    1 
 drivers/media/radio/radio-maxiradio.c       |    1 
 drivers/media/radio/radio-rtrack2.c         |    1 
 drivers/media/radio/radio-sf16fmi.c         |    1 
 drivers/media/radio/radio-sf16fmr2.c        |    1 
 drivers/media/radio/radio-terratec.c        |    1 
 drivers/media/radio/radio-trust.c           |    1 
 drivers/media/radio/radio-typhoon.c         |    1 
 drivers/media/radio/radio-zoltrix.c         |    1 
 drivers/media/video/Kconfig                 |    3 
 drivers/media/video/Makefile                |    2 
 drivers/media/video/arv.c                   |    1 
 drivers/media/video/bttv-cards.c            |   40 ++
 drivers/media/video/bttv-driver.c           |   68 +++-
 drivers/media/video/bttv.h                  |    1 
 drivers/media/video/bw-qcam.c               |    1 
 drivers/media/video/c-qcam.c                |    1 
 drivers/media/video/compat_ioctl32.c        |  328 +++++++++++++++++++-
 drivers/media/video/cpia.c                  |    1 
 drivers/media/video/cx25840/cx25840-core.c  |   38 ++
 drivers/media/video/cx25840/cx25840.h       |    9 
 drivers/media/video/cx88/cx88-cards.c       |   53 +--
 drivers/media/video/cx88/cx88-core.c        |   35 +-
 drivers/media/video/cx88/cx88-tvaudio.c     |   28 -
 drivers/media/video/cx88/cx88-video.c       |    2 
 drivers/media/video/cx88/cx88.h             |    4 
 drivers/media/video/em28xx/em28xx-core.c    |    8 
 drivers/media/video/em28xx/em28xx-video.c   |    4 
 drivers/media/video/ir-kbd-i2c.c            |    2 
 drivers/media/video/meye.c                  |    1 
 drivers/media/video/pms.c                   |    1 
 drivers/media/video/saa5249.c               |    1 
 drivers/media/video/saa7115.c               |   14 
 drivers/media/video/saa711x.c               |    2 
 drivers/media/video/saa7127.c               |    6 
 drivers/media/video/saa7134/saa7134-alsa.c  |   36 +-
 drivers/media/video/saa7134/saa7134-cards.c |   34 ++
 drivers/media/video/saa7134/saa7134-core.c  |   25 +
 drivers/media/video/saa7134/saa7134-oss.c   |   81 ++--
 drivers/media/video/saa7134/saa7134-video.c |    2 
 drivers/media/video/saa7134/saa7134.h       |    5 
 drivers/media/video/stradis.c               |    1 
 drivers/media/video/tda8290.c               |    6 
 drivers/media/video/tda9887.c               |    9 
 drivers/media/video/tveeprom.c              |   74 +++-
 drivers/media/video/video-buf.c             |    9 
 drivers/media/video/videodev.c              |   26 -
 drivers/media/video/w9966.c                 |    1 
 drivers/media/video/zoran_driver.c          |    1 
 drivers/media/video/zr36120.c               |    1 
 drivers/usb/media/dsbr100.c                 |    1 
 drivers/usb/media/ov511.c                   |    1 
 drivers/usb/media/pwc/pwc-if.c              |    1 
 drivers/usb/media/se401.c                   |    1 
 drivers/usb/media/stv680.c                  |    1 
 drivers/usb/media/usbvideo.c                |    1 
 drivers/usb/media/vicam.c                   |    1 
 drivers/usb/media/w9968cf.c                 |    1 
 fs/compat_ioctl.c                           |  246 ---------------
 include/linux/compat_ioctl.h                |   26 -
 include/linux/i2c-id.h                      |    1 
 include/linux/videodev2.h                   |   12 
 include/media/tveeprom.h                    |    4 
 89 files changed, 897 insertions(+), 541 deletions(-)

