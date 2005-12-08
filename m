Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932719AbVLHXZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbVLHXZy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbVLHXZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:25:53 -0500
Received: from smtp2.brturbo.com.br ([200.199.201.158]:60135 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932719AbVLHXZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:25:53 -0500
Date: Thu, 08 Dec 2005 21:20:26 -0200
From: mchehab@brturbo.com.br
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mchehab@infradead.org, js@linuxtv.org,
       akpm@osdl.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 00/56] V4L/DVB Patch series for -mm kernel
Message-Id: <1134084177.7047.179.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch series is also available at:
		 http://linuxtv.org/downloads/quilt.

	This series does contain improvements intended to 2.6.16 kernels, 
and should be kept at -mm series for now.

	It contain the following stuff:

   - Moves compat32 functions from fs to v4l subsystem
   - Compat ioctl32 license fix
   - Explicit compat_ioctl32 handler to em28xx
   - More build fixes for compat_ioctl32.c
   - Another build fix for compat_ioctl32.c
   - 64-bit fixes for removing warnings on compat_ioctl32
   - Adds 32-bit compatibility for v4l2 framegrabber ioctls.
   - Fixes some troubles at v4l2 compat stuff
   - Added Secam L' std on tda9887 and common macros moved to videodev2.h
   - Added basic support (tv + radio) for TerraTec Cinergy 250 PCI
   - Added Hauppauge ImpactVCB board
   - Added V4L support for the Nova-S-Plus and Nova-SE2 DVB-S products
   - Enable IR support for the Nova-S-Plus
   - Add support for KWorld DVB-S 100
   - Tuner cleanups by removing Video IF from tuners struct
   - Tuner description now follows the same CodingStyle as the others
   - Makes integration of future devices easier
   - Fixed oddities at firmware download
   - Fixes for the topuptv/SCM mediaguard CAM module in KNC1 CI module
   - Fixed dishnetwork support for Nexus-S rev 2.3
   - LNB power can now be switched off for Activy Budget-S rev GR/AL.
   - Fixed mpeg audio on spdif from Nexus-CA card (rev 2.3),
   - Driver support for live-ac3, firmware >= 2621 required.
   - Implement frontend-specific tuning and the ability to disable zigzag
   - Added demodulator driver for Nova-S-Plus and Nova-SE2 DVB-S support.
   - Minor cleanups.
   - Add support for KWorld DVB-S 100, based on the same chips as Hauppauge
   - Port code for SU1278/SH2 (TUA6100) from pre-refactored code
   - Adds a time-delay to IR remote button presses for av7110 ir input,
   - Fix wrong tuner.h define for tuner 46
   - Some cleanups on msp3400
   - Fix gcc-4.0.2 compile error in msp3400.c
   - added offset parameter for adjusting tuner offset by hand
   - Added a new debug msg to help identifying tuner Problems
   - vfree(NULL) is legal.
   - Adding support for the Hauppauge HVR1100 and HVR1100-LP products.
   - Cleanup check for dvb.
   - Add support for another Nova-T-PCI PCI subdevice 0x9001
   - Fixed device controls for em28xx on WinTV USB2 devices
   - fix compile error, remove dead code and volume scaling
   - Add VIDIOC_LOG_STATUS to tuner-core.c
   - MSP3400 miscelaneous fixes
   - Remove AUDC_CONFIG_PINNACLE horror, fix mt20xx radio support.
   - tveeprom cleanup of hardcoded tuner format values.
   - Replace all uses of pci_module_init with pci_register_driver
   - Several fixes for Hauppauge Roselyn Design (blackbird)
   - Add missing VIDEO_ADV_DEBUG config option.
   - tda9887 improvements: better defaults, better configurability.
   - Fix broken TV standard check.
   - Enable remote control on AVERTV STUDIO 303
   - include reorder to be in sync with V4L tree
   - remove uneeded #if from V4L subsystem
   - syncs V4L subsystem tree with kernel
   - correct FE_READ_UNCORRECTED_BLOCKS
   - cx24123: cleanup timout handling
   - syncronizes some changes between v4l and dvb

---------

 Documentation/video4linux/CARDLIST.bttv      |    1 
 Documentation/video4linux/CARDLIST.cx88      |   11 
 Documentation/video4linux/CARDLIST.saa7134   |    2 
 drivers/media/dvb/b2c2/flexcop-reg.h         |    4 
 drivers/media/dvb/bt8xx/dst.c                |   54 
 drivers/media/dvb/cinergyT2/cinergyT2.c      |   11 
 drivers/media/dvb/dvb-core/dvb_ca_en50221.c  |    4 
 drivers/media/dvb/dvb-core/dvb_frontend.c    |  307 +++--
 drivers/media/dvb/dvb-core/dvb_frontend.h    |   12 
 drivers/media/dvb/dvb-usb/digitv.c           |    2 
 drivers/media/dvb/dvb-usb/dtt200u.c          |    4 
 drivers/media/dvb/dvb-usb/dvb-usb-common.h   |    2 
 drivers/media/dvb/dvb-usb/dvb-usb-firmware.c |  155 +-
 drivers/media/dvb/dvb-usb/dvb-usb-init.c     |   54 
 drivers/media/dvb/dvb-usb/dvb-usb.h          |   28 
 drivers/media/dvb/dvb-usb/vp7045.c           |    2 
 drivers/media/dvb/frontends/Kconfig          |    6 
 drivers/media/dvb/frontends/Makefile         |    1 
 drivers/media/dvb/frontends/cx22702.c        |   22 
 drivers/media/dvb/frontends/cx24110.c        |    1 
 drivers/media/dvb/frontends/cx24123.c        | 1069 +++++++++++++++++-
 drivers/media/dvb/frontends/cx24123.h        |  337 +++--
 drivers/media/dvb/frontends/lgdt330x.c       |    2 
 drivers/media/dvb/frontends/stv0299.c        |    8 
 drivers/media/dvb/frontends/stv0299.h        |    1 
 drivers/media/dvb/frontends/tda1004x.c       |  138 +-
 drivers/media/dvb/ttpci/av7110.c             |   25 
 drivers/media/dvb/ttpci/av7110.h             |    3 
 drivers/media/dvb/ttpci/av7110_av.c          |   12 
 drivers/media/dvb/ttpci/av7110_ir.c          |   14 
 drivers/media/dvb/ttpci/av7110_v4l.c         |    2 
 drivers/media/dvb/ttpci/budget-av.c          |  184 +++
 drivers/media/dvb/ttpci/budget-core.c        |    4 
 drivers/media/dvb/ttpci/budget.c             |   11 
 drivers/media/radio/miropcm20-radio.c        |    1 
 drivers/media/radio/radio-aimslab.c          |    1 
 drivers/media/radio/radio-aztech.c           |    1 
 drivers/media/radio/radio-cadet.c            |    1 
 drivers/media/radio/radio-gemtek-pci.c       |    1 
 drivers/media/radio/radio-gemtek.c           |    1 
 drivers/media/radio/radio-maestro.c          |    1 
 drivers/media/radio/radio-maxiradio.c        |    1 
 drivers/media/radio/radio-rtrack2.c          |    1 
 drivers/media/radio/radio-sf16fmi.c          |    1 
 drivers/media/radio/radio-sf16fmr2.c         |    1 
 drivers/media/radio/radio-terratec.c         |    1 
 drivers/media/radio/radio-trust.c            |    1 
 drivers/media/radio/radio-typhoon.c          |    1 
 drivers/media/radio/radio-zoltrix.c          |    1 
 drivers/media/video/Kconfig                  |    9 
 drivers/media/video/Makefile                 |    3 
 drivers/media/video/arv.c                    |    1 
 drivers/media/video/bt832.c                  |    5 
 drivers/media/video/bttv-cards.c             |   52 
 drivers/media/video/bttv-driver.c            |    8 
 drivers/media/video/bttv-i2c.c               |   10 
 drivers/media/video/bttv.h                   |    1 
 drivers/media/video/bttvp.h                  |    2 
 drivers/media/video/bw-qcam.c                |    1 
 drivers/media/video/c-qcam.c                 |    1 
 drivers/media/video/compat_ioctl32.c         |  780 +++++++++++++
 drivers/media/video/cpia.c                   |    1 
 drivers/media/video/cs53l32a.c               |    4 
 drivers/media/video/cx25840/cx25840-core.c   |    4 
 drivers/media/video/cx88/Kconfig             |   10 
 drivers/media/video/cx88/Makefile            |    1 
 drivers/media/video/cx88/cx88-blackbird.c    |   15 
 drivers/media/video/cx88/cx88-cards.c        |  146 ++
 drivers/media/video/cx88/cx88-dvb.c          |   69 +
 drivers/media/video/cx88/cx88-i2c.c          |   24 
 drivers/media/video/cx88/cx88-input.c        |   63 +
 drivers/media/video/cx88/cx88-mpeg.c         |    5 
 drivers/media/video/cx88/cx88-tvaudio.c      |    6 
 drivers/media/video/cx88/cx88-video.c        |    2 
 drivers/media/video/cx88/cx88.h              |   11 
 drivers/media/video/em28xx/em28xx-core.c     |    8 
 drivers/media/video/em28xx/em28xx-i2c.c      |    2 
 drivers/media/video/em28xx/em28xx-video.c    |  165 ++
 drivers/media/video/ir-kbd-gpio.c            |    8 
 drivers/media/video/ir-kbd-i2c.c             |   16 
 drivers/media/video/meye.c                   |    1 
 drivers/media/video/msp3400.c                |  627 ++++++-----
 drivers/media/video/mt20xx.c                 |    7 
 drivers/media/video/pms.c                    |    1 
 drivers/media/video/saa5249.c                |    1 
 drivers/media/video/saa6588.c                |   10 
 drivers/media/video/saa7115.c                |    4 
 drivers/media/video/saa7127.c                |    4 
 drivers/media/video/saa7134/saa7134-alsa.c   |    2 
 drivers/media/video/saa7134/saa7134-cards.c  |   34 
 drivers/media/video/saa7134/saa7134-core.c   |    4 
 drivers/media/video/saa7134/saa7134-i2c.c    |    2 
 drivers/media/video/saa7134/saa7134-video.c  |    2 
 drivers/media/video/saa7134/saa7134.h        |    8 
 drivers/media/video/stradis.c                |    1 
 drivers/media/video/tda7432.c                |    5 
 drivers/media/video/tda8290.c                |    6 
 drivers/media/video/tda9875.c                |    5 
 drivers/media/video/tda9887.c                |  226 ++-
 drivers/media/video/tuner-core.c             |   48 
 drivers/media/video/tuner-simple.c           | 1074 +++++++++++++------
 drivers/media/video/tvaudio.c                |    9 
 drivers/media/video/tveeprom.c               |   24 
 drivers/media/video/tvmixer.c                |   14 
 drivers/media/video/tvp5150.c                |   81 -
 drivers/media/video/videodev.c               |    6 
 drivers/media/video/w9966.c                  |    1 
 drivers/media/video/wm8775.c                 |    4 
 drivers/media/video/zoran_driver.c           |    1 
 drivers/media/video/zr36120.c                |    1 
 drivers/usb/media/dsbr100.c                  |    1 
 drivers/usb/media/ov511.c                    |    1 
 drivers/usb/media/pwc/pwc-if.c               |    1 
 drivers/usb/media/se401.c                    |    1 
 drivers/usb/media/stv680.c                   |    1 
 drivers/usb/media/usbvideo.c                 |    1 
 drivers/usb/media/vicam.c                    |    1 
 drivers/usb/media/w9968cf.c                  |    1 
 fs/compat_ioctl.c                            |  246 ----
 include/linux/compat_ioctl.h                 |   26 
 include/linux/dvb/frontend.h                 |   10 
 include/linux/videodev2.h                    |   14 
 include/media/audiochip.h                    |   11 
 include/media/tuner.h                        |   57 -
 124 files changed, 4747 insertions(+), 1779 deletions(-)

