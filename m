Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965237AbWCTTXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbWCTTXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbWCTTXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:23:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28589 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965226AbWCTTXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:23:21 -0500
Message-Id: <20060320192044.PS58609000000@infradead.org>
Date: Mon, 20 Mar 2006 16:20:44 -0300
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 00/49] V4L/DVB updates part 2
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is available under v4l-dvb.git tree at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git.

To avoid a patchbomb traffic at the lists, I'll not send this time
all those emails to the list. Instead, please check at the tree.

Linus, please pull these from master branch.

It contains the following stuff:

   - This patch fixes Tuner TNF5335 family
   - Nskips maybe used uninitialized in bttv_risc_overlay
   - Fix cx88 error messages on balance change
   - Updated CARDLIST.tuner with newer tenna string
   - Correct gpio values for Aver 303 Studio in v4l-dvb tree
   - Remove 'pid' from struct dmxdev_filter
   - Remove 'dvbdev' from struct dmxdev_filter
   - Fix typo in enum name and use enum in struct dmxdev_filter
   - Optical cleanup for dmxdev.c
   - Added no_overlay option and quirks to saa7134
   - Thomson FE6600: add missing "count" array element
   - Saa7134: small whitespace cleanup
   - LG TALN series: add PAL / SECAM support
   - Saa7134: add support for AVerMedia A169 Dual Analog tuner card
   - Cx88-cards.c: fix values of gpio0 for card CX88_BOARD_PROLINK_PLAYTVPVR
   - Cx88-input.c: add IR remote control support to CX88_BOARD_PROLINK_PLAYTVPVR
   - Cx88 default picture controls values
   - Cleanup mangled whitespace
   - Make dvb_ringbuffer compatible to dmxdev_buffer
   - BUG_ON() Conversion in drivers/video/media
   - Snd_cx88_create: don't dereference NULL core
   - Kconfig: select VIDEO_CX25840 to build cx25840 a/v decoder module
   - Cpia2: move Kconfig build logic into cpia2/Kconfig
   - Remove redundant makefile inclusion of tuner.o
   - Fix a bug when more than MAXBOARDS were plugged on em28xx
   - Ringbuffer: don't reset pointers to zero
   - Dmxdev: use dvb_ringbuffer
   - Saa7134: make unsupported secondary decoder message generic
   - Whitespace: fix incorrect indentation of curly bracket
   - Medion 7134: Autodetect second bridge chip
   - Cinergy T2 dmx cleanup on disconnect
   - Make a needlessly global function static.
   - Remove saa711x driver
   - SAA7113 doesn't have auto std chroma detection mode
   - Avoid warnings at video-buf.c
   - Fixed a trouble with other PAL standards
   - Kconfig: select VIDEO_MSP3400 to build msp3400.ko
   - Kconfig: add menu items for saa7115 and saa7127
   - Kconfig: remove VIDEO_DECODER
   - VIDEO_CPIA2 must depend on USB
   - Kconfig: fix ATSC frontend menu item names by manufacturer
   - Kconfig: add menu items for cs53l32a and wm8775 A/D converters
   - Kconfig: remove VIDEO_AUDIO_DECODER
   - Moved duplicated code of ALPS BSRU6 tuner to a standalone file.
   - Add WSS (wide screen signalling) module parameters
   - Whitespace cleanup
   - Bt8xx documentation update
   - Fix Makefile to adapt to bt8xx/ conversion
   - Fixed no_overlay option and quirks on saa7134 driver

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
Development Mercurial trees are available at http://linuxtv.org/hg
---

 Documentation/dvb/bt8xx.txt                       |  143 --
 Documentation/video4linux/CARDLIST.saa7134        |    3 
 Documentation/video4linux/CARDLIST.tuner          |    4 
 drivers/media/common/saa7146_core.c               |    3 
 drivers/media/common/saa7146_fops.c               |    6 
 drivers/media/dvb/bt8xx/Makefile                  |    2 
 drivers/media/dvb/cinergyT2/cinergyT2.c           |    4 
 drivers/media/dvb/dvb-core/dmxdev.c               |  830 ++++++--------
 drivers/media/dvb/dvb-core/dmxdev.h               |   22 
 drivers/media/dvb/dvb-core/dvb_ringbuffer.c       |    6 
 drivers/media/dvb/dvb-core/dvb_ringbuffer.h       |    1 
 drivers/media/dvb/frontends/Kconfig               |    6 
 drivers/media/dvb/frontends/bsru6.h               |  140 ++
 drivers/media/dvb/frontends/zl10353.c             |    2 
 drivers/media/dvb/ttpci/av7110.c                  |  123 --
 drivers/media/dvb/ttpci/av7110_v4l.c              |   11 
 drivers/media/dvb/ttpci/budget-ci.c               |  118 -
 drivers/media/dvb/ttpci/budget-patch.c            |   99 -
 drivers/media/dvb/ttpci/budget.c                  |   98 -
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    3 
 drivers/media/video/Kconfig                       |   90 -
 drivers/media/video/Makefile                      |   18 
 drivers/media/video/bttv-cards.c                  |   10 
 drivers/media/video/bttv-risc.c                   |    5 
 drivers/media/video/cpia2/Kconfig                 |   11 
 drivers/media/video/cx25840/Kconfig               |    9 
 drivers/media/video/cx25840/Makefile              |    2 
 drivers/media/video/cx88/cx88-alsa.c              |   10 
 drivers/media/video/cx88/cx88-cards.c             |   23 
 drivers/media/video/cx88/cx88-core.c              |    3 
 drivers/media/video/cx88/cx88-input.c             |    1 
 drivers/media/video/cx88/cx88-video.c             |   17 
 drivers/media/video/cx88/cx88.h                   |    2 
 drivers/media/video/dpc7146.c                     |   58 
 drivers/media/video/em28xx/Kconfig                |    1 
 drivers/media/video/em28xx/em28xx-video.c         |  220 ---
 drivers/media/video/hexium_gemini.c               |   10 
 drivers/media/video/hexium_orion.c                |   18 
 drivers/media/video/mxb.c                         |  146 +-
 drivers/media/video/mxb.h                         |    2 
 drivers/media/video/saa7115.c                     |  125 +-
 drivers/media/video/saa7134/saa7134-alsa.c        |    3 
 drivers/media/video/saa7134/saa7134-cards.c       |   91 +
 drivers/media/video/saa7134/saa7134-core.c        |   37 
 drivers/media/video/saa7134/saa7134-oss.c         |    6 
 drivers/media/video/saa7134/saa7134-video.c       |   30 
 drivers/media/video/saa7134/saa7134.h             |    4 
 drivers/media/video/tda9840.c                     |    3 
 drivers/media/video/tea6415c.c                    |    5 
 drivers/media/video/tea6420.c                     |    5 
 drivers/media/video/tuner-simple.c                |    3 
 drivers/media/video/tuner-types.c                 |   58 
 drivers/media/video/video-buf.c                   |   17 
 include/media/tuner.h                             |    2 
 include/media/v4l2-common.h                       |    1 
 55 files changed, 1205 insertions(+), 1465 deletions(-)

