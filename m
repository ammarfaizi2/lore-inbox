Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVLACgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVLACgB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 21:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVLACgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 21:36:01 -0500
Received: from smtp1.brturbo.com.br ([200.199.201.163]:31875 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751362AbVLACgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 21:36:00 -0500
Date: Wed, 30 Nov 2005 23:31:15 -0200
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org, torvards@osdl.org
Cc: akpm@osdl, org@vger.kernel.org, mchehab@infradead.org, js@linuxtv.org
Subject: [PATCH 00/31] V4L/DVB fixes
Message-Id: <1133400730.21135.61.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-3mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Fixes maximum number of VBI devices
- Fix hotplugging issues with saa7134
- Fixes warning at bttv-driver.c
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
- Add workaround for Hauppauge PVR150 with certain NTSC tuner models
- Fixed DiSEqC timing for saa7146-based budget cards
- Fix locking problems and code cleanup
- Fixed incorrect usage at the private state of the dvb-usb-devices
- Include fixes for 2.6.15-rc1 for removing sched.h from module.h
- Update Steve's email address.
- Small cleanups and CodeStyle fixes
- Fix locking to prevent Oops on SMP systems
- Fixes ifs in ves1820 set symbolrate().
- BUDGET CI card depends on STV0297 demodulator.
Subject: V4L/DVB SCM update
- fix kernel message (print of %s from random pointer)
- Restore missing tuner definition for Hauppauge tuner type 0x103
- Fix typo, removing incorrect info from CONFIG_BT848_DVB kconfig entry.

---------

 MAINTAINERS                                 |    3 
 drivers/media/dvb/b2c2/flexcop-hw-filter.c  |    2 
 drivers/media/dvb/dvb-core/dvb_ca_en50221.c |   69 +++++------------
 drivers/media/dvb/dvb-core/dvb_net.c        |   31 ++++---
 drivers/media/dvb/dvb-usb/a800.c            |    2 
 drivers/media/dvb/dvb-usb/dibusb-common.c   |   18 ++--
 drivers/media/dvb/dvb-usb/digitv.c          |    2 
 drivers/media/dvb/dvb-usb/dvb-usb-init.c    |    2 
 drivers/media/dvb/frontends/cx22702.c       |    2 
 drivers/media/dvb/frontends/cx22702.h       |    2 
 drivers/media/dvb/frontends/nxt200x.c       |    2 
 drivers/media/dvb/frontends/ves1820.c       |   14 +--
 drivers/media/dvb/ttpci/Kconfig             |    1 
 drivers/media/dvb/ttpci/av7110_ca.c         |    1 
 drivers/media/dvb/ttpci/budget-av.c         |    2 
 drivers/media/dvb/ttpci/budget-ci.c         |    2 
 drivers/media/dvb/ttpci/budget.c            |    2 
 drivers/media/dvb/ttpci/ttpci-eeprom.c      |    1 
 drivers/media/video/Kconfig                 |    3 
 drivers/media/video/bttv-cards.c            |    6 -
 drivers/media/video/bttv-driver.c           |   67 ++++++++++++----
 drivers/media/video/cx25840/cx25840-core.c  |   38 ++++++++-
 drivers/media/video/cx25840/cx25840.h       |    9 +-
 drivers/media/video/cx88/cx88-cards.c       |   53 ++++---------
 drivers/media/video/cx88/cx88-core.c        |   35 +++++++-
 drivers/media/video/cx88/cx88-tvaudio.c     |   28 +++---
 drivers/media/video/cx88/cx88.h             |    4 
 drivers/media/video/em28xx/em28xx-core.c    |    6 -
 drivers/media/video/em28xx/em28xx-video.c   |    2 
 drivers/media/video/ir-kbd-i2c.c            |    2 
 drivers/media/video/saa7115.c               |   14 +--
 drivers/media/video/saa711x.c               |    2 
 drivers/media/video/saa7127.c               |    6 -
 drivers/media/video/saa7134/saa7134-alsa.c  |   36 ++++++--
 drivers/media/video/saa7134/saa7134-core.c  |   25 ++++--
 drivers/media/video/saa7134/saa7134-oss.c   |   81 +++++++++++---------
 drivers/media/video/saa7134/saa7134.h       |    4 
 drivers/media/video/tveeprom.c              |   74 ++++++++++++++----
 drivers/media/video/video-buf.c             |    9 +-
 drivers/media/video/videodev.c              |   26 +++---
 include/linux/i2c-id.h                      |    1 
 include/media/tveeprom.h                    |    4 
 42 files changed, 437 insertions(+), 256 deletions(-)

