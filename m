Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWDBIUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWDBIUX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 04:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWDBIUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 04:20:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50882 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932126AbWDBIUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 04:20:22 -0400
Message-Id: <20060402081653.PS95365700000@infradead.org>
Date: Sun, 02 Apr 2006 05:16:53 -0300
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 00/49] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull these from master branch at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

It contains the following stuff:

   - Add support for I2C_HW_B_CX2341X board adapter
   - Minor layout changes to make it consistent
   - Implement routing command for saa7115.c
   - Implement new routing commands in saa7127.c
   - Remove VIDIOC_S_AUDIO from tvaudio: no longer used.
   - Added the new routing commands to cx25840.
   - Fix compilation warning at powerpc platform
   - Saa7134: select FW_LOADER
   - cpia cleanups
   - Bt8xx: select FW_LOADER
   - Cxusb: add support for FusionHDTV USB portable remote control
   - Whitespace cleanup
   - Fix video-buf PCI wrappers
   - Fix camera key on FusionHDTV portable remote control
   - Reduce FWSEND due to certain I2C bus adapter limits
   - Fix default values for tvp5150 controls
   - Added PCI IDs of 2 LifeView Cards
   - Corrected CVBS input for the AVERMEDIA 777 DVB-T
   - Added support for the new Lifeview hybrid cardbus modules
   - Kconfig: clean up media/usb menus
   - et61x251: fixed Kconfig menu and Makefile build configuration
   - zc0301: fixed Kconfig menu and Makefile build configuration
   - sn9c102: fixed Kconfig menu and Makefile build configuration
   - pwc: fixed Kconfig menu and Makefile build configuration
   - usbvideo: fixed Kconfig menu and Makefile build configuration
   - put v4l encoder/decoder configuration into a separate menu
   - Support for a new revision of the WT220U-stick
   - Kconfig: Add firmware download comments for or51211 and or51132
   - Kconfig: Fix PCI ID typo in VIDEO_CX88_ALSA help text
   - Add wm8739 stereo audio ADC i2c driver
   - Don't set msp3400c-non-existent register
   - Fix msp3400c wait time and better audio mode fallbacks
   - Add new NEC uPD64031A and uPD64083 i2c drivers
   - Remove trailing newlines
   - Fix SAP + stereo mode at msp3400
   - Move usb v4l docs into Documentation/video4linux
   - Configurable dma buffer size for saa7146-based budget dvb cards
   - Fix typo in comment
   - New module parameter 'tv_standard' (dvb-ttpci driver)
   - Fix memory leak in dvr open
   - Fix budget-av CAM reset
   - Kconfig: fix VP-3054 Secondary I2C Bus build configuration menu dependencies
   - Keep experimental SLICED_VBI defines under an #if 0
   - Fix msp3400c and bttv stereo/mono/bilingual detection/handling
   - Previous change for cx2341X boards broke the remote support
   - More msp3400 and bttv fixes
   - Remove obsolete commands from tvp5150.c
   - Make msp3400 routing defines more consistent
   - cpia2: fix function prototype

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 Documentation/usb/et61x251.txt                 |  314 ----------
 Documentation/usb/ibmcam.txt                   |  324 ----------
 Documentation/usb/ov511.txt                    |  289 ---------
 Documentation/usb/se401.txt                    |   54 -
 Documentation/usb/sn9c102.txt                  |  518 -----------------
 Documentation/usb/stv680.txt                   |   55 -
 Documentation/usb/w9968cf.txt                  |  461 ---------------
 Documentation/usb/zc0301.txt                   |  254 --------
 Documentation/video4linux/CARDLIST.saa7134     |    5 
 Documentation/video4linux/et61x251.txt         |  314 ++++++++++
 Documentation/video4linux/ibmcam.txt           |  324 ++++++++++
 Documentation/video4linux/ov511.txt            |  288 +++++++++
 Documentation/video4linux/se401.txt            |   54 +
 Documentation/video4linux/sn9c102.txt          |  518 +++++++++++++++++
 Documentation/video4linux/stv680.txt           |   53 +
 Documentation/video4linux/w9968cf.txt          |  461 +++++++++++++++
 Documentation/video4linux/zc0301.txt           |  254 ++++++++
 drivers/media/Kconfig                          |   22 
 drivers/media/dvb/bt8xx/Kconfig                |    1 
 drivers/media/dvb/dvb-core/dmxdev.c            |   12 
 drivers/media/dvb/dvb-core/dvb_frontend.c      |   18 
 drivers/media/dvb/dvb-core/dvb_frontend.h      |    2 
 drivers/media/dvb/dvb-usb/cxusb.c              |   64 +-
 drivers/media/dvb/dvb-usb/dtt200u.c            |   47 +
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h        |    2 
 drivers/media/dvb/dvb-usb/vp702x-fe.c          |    5 
 drivers/media/dvb/frontends/Kconfig            |   12 
 drivers/media/dvb/frontends/tda1004x.c         |   12 
 drivers/media/dvb/ttpci/av7110.c               |    8 
 drivers/media/dvb/ttpci/av7110_av.c            |    2 
 drivers/media/dvb/ttpci/budget-av.c            |   13 
 drivers/media/dvb/ttpci/budget-core.c          |   78 ++
 drivers/media/dvb/ttpci/budget-patch.c         |   24 
 drivers/media/dvb/ttpci/budget.h               |   13 
 drivers/media/video/Kconfig                    |  237 ++-----
 drivers/media/video/Makefile                   |    6 
 drivers/media/video/bt8xx/bttv-driver.c        |  170 ++---
 drivers/media/video/bt8xx/bttv-vbi.c           |    2 
 drivers/media/video/cpia.c                     |   13 
 drivers/media/video/cpia2/cpia2.h              |    2 
 drivers/media/video/cx25840/cx25840-audio.c    |    3 
 drivers/media/video/cx25840/cx25840-core.c     |   24 
 drivers/media/video/cx25840/cx25840-core.h     |   67 ++
 drivers/media/video/cx25840/cx25840-firmware.c |   15 
 drivers/media/video/cx25840/cx25840-vbi.c      |    9 
 drivers/media/video/cx25840/cx25840.h          |  107 ---
 drivers/media/video/cx88/Kconfig               |   15 
 drivers/media/video/em28xx/em28xx-cards.c      |    4 
 drivers/media/video/em28xx/em28xx-video.c      |   33 -
 drivers/media/video/et61x251/Kconfig           |   16 
 drivers/media/video/ir-kbd-i2c.c               |    7 
 drivers/media/video/msp3400-driver.c           |   91 +-
 drivers/media/video/msp3400-driver.h           |    6 
 drivers/media/video/msp3400-kthreads.c         |  163 ++---
 drivers/media/video/pwc/Kconfig                |   28 
 drivers/media/video/saa7115.c                  |   65 +-
 drivers/media/video/saa7127.c                  |   43 -
 drivers/media/video/saa7134/Kconfig            |    1 
 drivers/media/video/saa7134/saa7134-cards.c    |   66 ++
 drivers/media/video/saa7134/saa7134-dvb.c      |    4 
 drivers/media/video/saa7134/saa7134.h          |    1 
 drivers/media/video/sn9c102/Kconfig            |   13 
 drivers/media/video/tuner-core.c               |   12 
 drivers/media/video/tvaudio.c                  |   15 
 drivers/media/video/tveeprom.c                 |    6 
 drivers/media/video/tvp5150.c                  |  140 ----
 drivers/media/video/upd64031a.c                |  288 +++++++++
 drivers/media/video/upd64083.c                 |  262 ++++++++
 drivers/media/video/usbvideo/Kconfig           |   44 +
 drivers/media/video/usbvideo/Makefile          |    8 
 drivers/media/video/v4l2-common.c              |    8 
 drivers/media/video/video-buf.c                |   14 
 drivers/media/video/wm8739.c                   |  355 +++++++++++
 drivers/media/video/zc0301/Kconfig             |   13 
 include/linux/videodev2.h                      |   61 --
 include/media/cx25840.h                        |   64 ++
 include/media/msp3400.h                        |   60 -
 include/media/saa7115.h                        |   37 +
 include/media/saa7127.h                        |   41 +
 include/media/upd64031a.h                      |   42 +
 include/media/upd64083.h                       |   60 +
 81 files changed, 4426 insertions(+), 3190 deletions(-)

