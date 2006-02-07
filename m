Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWBGPmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWBGPmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWBGPlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:41:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28098 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751136AbWBGPlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:41:40 -0500
Message-Id: <20060207153248.PS50860900000@infradead.org>
Date: Tue, 07 Feb 2006 13:32:48 -0200
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 00/16] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        This patch series is also available under v4l-dvb.git tree at:
                kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

	Linus, please pull these from master branch.

	It contains the following stuff:

   - Kconfig: DVB_USB_CXUSB depends on DVB_LGDT330X and DVB_MT352
   - Fix NICAM buzz on analog sound
   - Added signal detection support to tvp5150
   - Fix [Bug 5895] to correct snd_87x autodetect
   - Add IR support to KWorld DVB-T (cx22702-based)
   - Add standard for South Korean NTSC-M using A2 audio.
   - Fixed i2c return value, conversion mdelay to msleep
   - Support for Galaxis DVB-S rev1.3
   - Use parallel transport for FusionHDTV Dual Digital USB
   - Use MT352 parallel transport function for all Bluebird FusionHDTV DVB-T boxes.
   - FIX: Multiple usage of VP7045-based devices
   - FIX: Check if FW was downloaded or not + new firmware file
   - Makes Some symbols static.
   - fix saa7146 kobject register failure
   - DVB: remove the at76c651/tda80xx frontends
   - Disabled debug on by default in tvp5150

The following stuff is also pending to be pulled from v4l-dvb.git:
   - Activate remote control on HVR1100
   - Add bttv card MagicTV (rebranded MachTV)
   - whitespace cleanup: insert missing space before curly brackets
   - More whitespace cleanup in bttv-cards.c
   - Add support for DViCO FusionHDTV DVB-T USB devices
   - Conversions from kmalloc+memset to k(z|c)alloc
   - don't ignore return from i2c_add_driver() for tuner-3036
   - Pci probing for stradis driver
   - Stradis video little cleanup
   - Enable microtune for Pinnacle 300i boards
   - Stradis Lindent
   - Stradis Kconfig url changed
   - Fixes some bad global variables
   - debug renamed to cx25840_debug
   - Add PCI ID for UltraView DVB-T Plus, rebranded DViCO FusionHDTV DVB-T Plus
   - Added USB ID for DigitalNow DVB-T Dual USB, DViCO clone
   - adding support for knc1 Tv Star dvb-s
   - Some fixes to compat_ioctl32
   - VIDEO_SAA7134_ALSA shouldn't select SND_PCM_OSS

Cheers,
Mauro

   Diffstat from newer stuff follows.

---

 drivers/media/dvb/bt8xx/bt878.c            |   44 +
 drivers/media/dvb/bt8xx/bt878.h            |   17 
 drivers/media/dvb/dvb-usb/Kconfig          |   12 
 drivers/media/dvb/dvb-usb/cxusb.c          |    4 
 drivers/media/dvb/dvb-usb/digitv.c         |   13 
 drivers/media/dvb/dvb-usb/vp7045-fe.c      |    6 
 drivers/media/dvb/frontends/Kconfig        |   12 
 drivers/media/dvb/frontends/Makefile       |    2 
 drivers/media/dvb/frontends/at76c651.c     |  450 ------------
 drivers/media/dvb/frontends/at76c651.h     |   47 -
 drivers/media/dvb/frontends/tda80xx.c      |  734 ---------------------
 drivers/media/dvb/frontends/tda80xx.h      |   51 -
 drivers/media/dvb/ttpci/av7110.c           |   14 
 drivers/media/video/bttv-driver.c          |    2 
 drivers/media/video/cx25840/cx25840-core.c |   50 -
 drivers/media/video/cx88/cx88-alsa.c       |    6 
 drivers/media/video/cx88/cx88-core.c       |   10 
 drivers/media/video/cx88/cx88-input.c      |    1 
 drivers/media/video/em28xx/em28xx-core.c   |   15 
 drivers/media/video/em28xx/em28xx-i2c.c    |    8 
 drivers/media/video/hexium_orion.c         |    2 
 drivers/media/video/tda9887.c              |    7 
 drivers/media/video/tuner-core.c           |    5 
 drivers/media/video/tvp5150.c              |   11 
 include/linux/videodev2.h                  |    4 
 25 files changed, 170 insertions(+), 1357 deletions(-)

