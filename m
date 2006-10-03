Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030509AbWJCTTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbWJCTTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWJCTTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:19:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17868 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030508AbWJCTTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:19:08 -0400
Message-Id: <20061003182228.PS25158600000@infradead.org>
Date: Tue, 03 Oct 2006 15:22:28 -0300
From: mchehab@infradead.org
To: torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/43] V4L/DVB updates for 2.6.19
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull these from master branch at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

Those series contains several fixes over the previous series, some newer board
support, adds multi-input support for DVB-USB and some experimental api improvement
to better handling webcams.

It contains the following stuff:

   - Multi-input patch for DVB-USB device
   - Multi-input fix for dtt200u
   - Added new file for multiple input rewrite
   - Misc. changes, DiB3000MC, MT2060
   - Added module for DiB0700 based devices
   - Hauppauge Nova-T 500 support added
   - Merged VP702x support to dvb-usb multi input
   - Misc fixes for dib0700 download
   - Adding another USB product ID for Nova-T 500
   - Misc fixes for DiB3000MC and Nova-T 500
   - Misc fixes for Nova-T 500
   - dib700m is not yet ready.
   - Added module parameter force_lna_activation
   - Removed compilation warnings
   - Fixed dvb_attach for dib3000mc in dibusb
   - Power control of the device for dual board
   - Another fix because of dvb_attach
   - Some cleanups at helper chips menu
   - Pvrusb2: improve 24XXX config option description
   - Pvrusb2: Implement VIDIOC_INT_[G|S]_REGISTER
   - Pvrusb2: Get rid of private global context array brain damage
   - Pvrusb2: Don't use videodev.h; use v4l2-dev.h in its place
   - Add frontend structure callback for bus acquisition.
   - Ensure the WM8775 driver is loaded generically for any board.
   - Changed cx88_board .dvb and .register to an enum.
   - Cx88: rename mpeg capability flags from CX88_BOARD_FOO to CX88_MPEG_FOO
   - Cx88: autodetect Club3D Zap TV2100 by subsystem id 12ab:2300
   - Allow RC5 codes 64 - 127 in ir-kbd-i2c.c
   - Support for SAA7134-based AVerTV Hybrid A16AR
   - Frame format enumeration (1/2)
   - Mark the two newer ioctls as experimental
   - Use NULL instead of 0 for ptrs
   - Pvrusb2: Fix VIDIOC_INT_[G|S]_REGISTER so that it actually works now
   - Fix for NULL pointer dereference oops during boot.
   - Cx88: fix analog capture notch filter
   - Norm_notchfilter is used on just one point and argument is bogus
   - Drivers/media/video/cx88: Remove unused defined FALSE/TRUE
   - Fix compiler warning in drivers/media/video/video-buf.c
   - Cxusb: add support for DViCO FusionHDTV DVB-T Dual Digital 2
   - Fix msp343xG handling (regression from 2.6.16)
   - Adding support for Nova-T-PCI PCI ID 0070:9000
   - Fix S-Video configuration for Pinnacle PCTV-Sat
   - CX24109 patch to eliminate the weird mis-tunings

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 Documentation/video4linux/CARDLIST.cx88            |    4 
 Documentation/video4linux/CARDLIST.saa7134         |    1 
 drivers/media/dvb/dvb-core/dvb_frontend.c          |   10 +
 drivers/media/dvb/dvb-core/dvb_frontend.h          |    1 
 drivers/media/dvb/dvb-usb/Kconfig                  |   41 ++-
 drivers/media/dvb/dvb-usb/Makefile                 |    5 
 drivers/media/dvb/dvb-usb/a800.c                   |   48 ++-
 drivers/media/dvb/dvb-usb/cxusb.c                  |  257 +++++++++++-------
 drivers/media/dvb/dvb-usb/dib0700.h                |   49 ++++
 drivers/media/dvb/dvb-usb/dib0700_core.c           |  279 ++++++++++++++++++++
 drivers/media/dvb/dvb-usb/dib0700_devices.c        |  212 +++++++++++++++
 drivers/media/dvb/dvb-usb/dib07x0.h                |   21 ++
 drivers/media/dvb/dvb-usb/dibusb-common.c          |   71 +++--
 drivers/media/dvb/dvb-usb/dibusb-mb.c              |  198 ++++++++------
 drivers/media/dvb/dvb-usb/dibusb-mc.c              |   40 ++-
 drivers/media/dvb/dvb-usb/dibusb.h                 |   13 +
 drivers/media/dvb/dvb-usb/digitv.c                 |   57 ++--
 drivers/media/dvb/dvb-usb/dtt200u.c                |  160 ++++++-----
 drivers/media/dvb/dvb-usb/dvb-usb-common.h         |   41 ++-
 drivers/media/dvb/dvb-usb/dvb-usb-dvb.c            |  170 ++++++------
 drivers/media/dvb/dvb-usb/dvb-usb-firmware.c       |   10 -
 drivers/media/dvb/dvb-usb/dvb-usb-i2c.c            |   49 ++--
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h            |   17 +
 drivers/media/dvb/dvb-usb/dvb-usb-init.c           |  165 +++++++++---
 drivers/media/dvb/dvb-usb/dvb-usb-remote.c         |    2 
 drivers/media/dvb/dvb-usb/dvb-usb-urb.c            |  268 +------------------
 drivers/media/dvb/dvb-usb/dvb-usb.h                |  280 ++++++++++++--------
 drivers/media/dvb/dvb-usb/gp8psk.c                 |   32 +-
 drivers/media/dvb/dvb-usb/nova-t-usb2.c            |   43 ++-
 drivers/media/dvb/dvb-usb/umt-010.c                |   38 ++-
 drivers/media/dvb/dvb-usb/usb-urb.c                |  242 +++++++++++++++++
 drivers/media/dvb/dvb-usb/vp702x-fe.c              |   39 ++-
 drivers/media/dvb/dvb-usb/vp702x.c                 |  204 +++++++++------
 drivers/media/dvb/dvb-usb/vp702x.h                 |    2 
 drivers/media/dvb/dvb-usb/vp7045.c                 |   40 ++-
 drivers/media/dvb/frontends/cx24123.c              |    4 
 drivers/media/dvb/frontends/dib3000mc.c            |  238 +++++++----------
 drivers/media/dvb/frontends/dib3000mc.h            |    8 -
 drivers/media/dvb/frontends/mt2060.c               |   17 +
 drivers/media/dvb/frontends/mt2060.h               |    4 
 drivers/media/video/Kconfig                        |  130 +++++----
 drivers/media/video/bt8xx/bttv-cards.c             |    2 
 drivers/media/video/cx88/cx88-blackbird.c          |    4 
 drivers/media/video/cx88/cx88-cards.c              |   81 +++---
 drivers/media/video/cx88/cx88-core.c               |    9 -
 drivers/media/video/cx88/cx88-dvb.c                |    2 
 drivers/media/video/cx88/cx88-i2c.c                |    4 
 drivers/media/video/cx88/cx88-mpeg.c               |   13 +
 drivers/media/video/cx88/cx88-tvaudio.c            |    4 
 drivers/media/video/cx88/cx88-video.c              |    3 
 drivers/media/video/cx88/cx88.h                    |   17 +
 drivers/media/video/ir-kbd-i2c.c                   |   19 +
 drivers/media/video/msp3400-driver.c               |    2 
 drivers/media/video/msp3400-driver.h               |    1 
 drivers/media/video/msp3400-kthreads.c             |    5 
 drivers/media/video/pvrusb2/Kconfig                |   13 -
 drivers/media/video/pvrusb2/pvrusb2-hdw.c          |   37 +++
 drivers/media/video/pvrusb2/pvrusb2-hdw.h          |    8 +
 .../media/video/pvrusb2/pvrusb2-i2c-chips-v4l2.c   |    4 
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c         |  125 ++++-----
 drivers/media/video/saa7134/saa7134-cards.c        |   36 +++
 drivers/media/video/saa7134/saa7134-dvb.c          |    1 
 drivers/media/video/saa7134/saa7134-input.c        |    1 
 drivers/media/video/saa7134/saa7134.h              |    1 
 drivers/media/video/video-buf.c                    |    7 -
 include/linux/videodev2.h                          |   80 ++++++
 include/media/audiochip.h                          |    4 
 67 files changed, 2522 insertions(+), 1471 deletions(-)
 create mode 100644 drivers/media/dvb/dvb-usb/dib0700.h
 create mode 100644 drivers/media/dvb/dvb-usb/dib0700_core.c
 create mode 100644 drivers/media/dvb/dvb-usb/dib0700_devices.c
 create mode 100644 drivers/media/dvb/dvb-usb/dib07x0.h
 create mode 100644 drivers/media/dvb/dvb-usb/usb-urb.c

