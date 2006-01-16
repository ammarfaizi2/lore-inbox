Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWAPJYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWAPJYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWAPJYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:24:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47851 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932263AbWAPJXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:23:40 -0500
Message-Id: <20060116091105.PS83611600000@infradead.org>
Date: Mon, 16 Jan 2006 07:11:05 -0200
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 00/25] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        This patch series is also available under v4l-dvb.git tree at:
                kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

	Linus, please push these from master branch.

	It contains the following stuff:

   - Remove old MODULE_PARM in media/video/
   - bttv semaphore to mutex conversion
   - removed uneeded init on structs like static int foo=0
   - Include missing MODULE_* macros
   - Build cx88-alsa when CONFIG_VIDEO_CX88_ALSA is selected.
   - Updated MODULE_AUTHOR
   - Redesign tuners struct for maximum flexibility
   - Add support for Samsung tuner TCPN 2121P30A
   - disable all dvb tuner param_types until we need them
   - i2c ids for upd64031a saa717x upd64083 wm8739
   - Turn frame locked sound on, basic support for FM radio with TDA8275(a)
   - git dvb callbacks fix
   - cx88 Kconfig fixes for cx88-alsa
   - make some code static
   - Fix for lack of analog output on some cx88 boards
   - Semaphore to mutex conversion on drivers/media
   - Fix compilation with Alpha
   - Move tda988x options into tuner_params struct.
   - Separate tv & radio freqs, fix cb/freq transmit order for tuners that need this.
   - Return -EINVAL for unknown commands in msp3400 module.
   - fix some sound quality & distortion problems.
   - clean up some comments
   - tuner_params->tda988x is currently unused, so disable
   - Samsung TBMV30111IN has 6 entries
   - Added remote control support for pinnacle pctv

Cheers,
Mauro

---

 Documentation/video4linux/CARDLIST.tuner      |    1 
 drivers/media/dvb/bt8xx/bt878.c               |    2 
 drivers/media/dvb/dvb-core/dvbdev.c           |   22 
 drivers/media/dvb/dvb-usb/cxusb.c             |    2 
 drivers/media/dvb/frontends/dvb-pll.c         |    2 
 drivers/media/dvb/ttpci/av7110.c              |    4 
 drivers/media/dvb/ttpci/av7110_hw.c           |   40 
 drivers/media/dvb/ttpci/av7110_hw.h           |   12 
 drivers/media/video/Makefile                  |    3 
 drivers/media/video/arv.c                     |    6 
 drivers/media/video/bt832.c                   |    2 
 drivers/media/video/btcx-risc.c               |    2 
 drivers/media/video/bttv-cards.c              |    6 
 drivers/media/video/bttv-driver.c             |   87 -
 drivers/media/video/bttv-i2c.c                |    6 
 drivers/media/video/bttvp.h                   |    5 
 drivers/media/video/cx25840/cx25840-core.c    |    4 
 drivers/media/video/cx88/Kconfig              |    3 
 drivers/media/video/cx88/Makefile             |    1 
 drivers/media/video/cx88/cx88-alsa.c          |    9 
 drivers/media/video/cx88/cx88-core.c          |   15 
 drivers/media/video/cx88/cx88-tvaudio.c       |    8 
 drivers/media/video/cx88/cx88-vp3054-i2c.c    |    4 
 drivers/media/video/em28xx/em28xx-input.c     |   77 
 drivers/media/video/em28xx/em28xx-video.c     |    7 
 drivers/media/video/msp3400-driver.c          |   14 
 drivers/media/video/msp3400.h                 |    8 
 drivers/media/video/mt20xx.c                  |   12 
 drivers/media/video/planb.c                   |    4 
 drivers/media/video/saa6588.c                 |   10 
 drivers/media/video/saa711x.c                 |    2 
 drivers/media/video/saa7134/saa7134-cards.c   |    6 
 drivers/media/video/saa7134/saa7134-core.c    |   21 
 drivers/media/video/saa7134/saa7134-tvaudio.c |   11 
 drivers/media/video/tda8290.c                 |    4 
 drivers/media/video/tea5767.c                 |   18 
 drivers/media/video/tuner-core.c              |   85 -
 drivers/media/video/tuner-simple.c            |  794 ----------
 drivers/media/video/tuner-types.c             | 1406 ++++++++++++++++++
 drivers/media/video/tveeprom.c                |    2 
 drivers/media/video/tvp5150.c                 |    2 
 drivers/media/video/v4l2-common.c             |    1 
 drivers/media/video/videodev.c                |   25 
 include/linux/i2c-id.h                        |    4 
 include/media/tuner-types.h                   |   73 
 include/media/tuner.h                         |   10 
 include/media/v4l2-common.h                   |    7 
 47 files changed, 1870 insertions(+), 979 deletions(-)

