Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWF3TFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWF3TFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWF3TFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:05:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25491 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964918AbWF3TFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:05:33 -0400
Message-Id: <20060630190354.PS37470900000@infradead.org>
Date: Fri, 30 Jun 2006 16:03:54 -0300
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 00/18] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull these from master branch at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

It contains the following stuff:

   - Cx88-blackbird: implement VIDIOC_QUERYCTRL and VIDIOC_QUERYMENU
   - Remove all instances of request_module("tda9887")
   - Subject: videocodec: make 1-bit fields unsigned
   - Add tda9887-specific tuner configuration
   - Fix tveeprom supported standards
   - Always log pvrusb2 device register / unregister events
   - Eliminate use of tda9887 from pvrusb2 driver
   - The FE_SET_FRONTEND_TUNE_MODE ioctl always returns EOPNOTSUPP
   - Fix CI on old KNC1 DVBC cards
   - Fix CI interface on PRO KNC1 cards
   - TDA9887_SET_CONFIG should only be handled by the tda9887.
   - Fix: use swzigzag for swalgo
   - Cx24123: fix set_voltage function according to the specs
   - Cx88: add support for Geniatech Digistar / Digiwave 103g
   - Pvrusb2/: possible cleanups
   - Clean out a zillion sparse warnings in pvrusb2
   - Missing statement in drivers/media/dvb/frontends/cx22700.c
   - Add support for the TCL M2523_3DB_E tuner.

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 Documentation/video4linux/CARDLIST.cx88              |    1 
 drivers/media/dvb/dvb-core/dvb_frontend.c            |    4 
 drivers/media/dvb/frontends/cx22700.c                |    1 
 drivers/media/dvb/frontends/cx24123.c                |    4 
 drivers/media/dvb/ttpci/budget-av.c                  |   15 
 drivers/media/video/bt8xx/bttv-cards.c               |    5 
 drivers/media/video/cx88/cx88-blackbird.c            |   43 ++
 drivers/media/video/cx88/cx88-cards.c                |   19 +
 drivers/media/video/cx88/cx88-dvb.c                  |   28 +
 drivers/media/video/cx88/cx88-video.c                |   61 ++-
 drivers/media/video/cx88/cx88.h                      |    3 
 drivers/media/video/em28xx/em28xx-video.c            |    2 
 drivers/media/video/msp3400-driver.h                 |    4 
 drivers/media/video/pvrusb2/Makefile                 |    2 
 drivers/media/video/pvrusb2/pvrusb2-audio.c          |    4 
 drivers/media/video/pvrusb2/pvrusb2-context.c        |   14 
 drivers/media/video/pvrusb2/pvrusb2-ctrl.c           |    6 
 drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c    |    6 
 drivers/media/video/pvrusb2/pvrusb2-debugifc.c       |    6 
 drivers/media/video/pvrusb2/pvrusb2-demod.c          |  126 --------
 drivers/media/video/pvrusb2/pvrusb2-demod.h          |   38 --
 drivers/media/video/pvrusb2/pvrusb2-eeprom.c         |    4 
 drivers/media/video/pvrusb2/pvrusb2-encoder.c        |    4 
 drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h   |   17 -
 drivers/media/video/pvrusb2/pvrusb2-hdw.c            |  172 ++++-------
 drivers/media/video/pvrusb2/pvrusb2-hdw.h            |   32 --
 drivers/media/video/pvrusb2/pvrusb2-i2c-chips-v4l2.c |    6 
 drivers/media/video/pvrusb2/pvrusb2-i2c-cmd-v4l2.c   |    4 
 drivers/media/video/pvrusb2/pvrusb2-i2c-core.c       |   34 +-
 drivers/media/video/pvrusb2/pvrusb2-i2c-core.h       |    3 
 drivers/media/video/pvrusb2/pvrusb2-io.c             |   57 ---
 drivers/media/video/pvrusb2/pvrusb2-io.h             |   13 
 drivers/media/video/pvrusb2/pvrusb2-ioread.c         |   34 --
 drivers/media/video/pvrusb2/pvrusb2-ioread.h         |    1 
 drivers/media/video/pvrusb2/pvrusb2-main.c           |   10 
 drivers/media/video/pvrusb2/pvrusb2-std.c            |    6 
 drivers/media/video/pvrusb2/pvrusb2-sysfs.c          |   14 
 drivers/media/video/pvrusb2/pvrusb2-tuner.c          |    2 
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c           |   42 +-
 drivers/media/video/pvrusb2/pvrusb2-video-v4l.c      |    4 
 drivers/media/video/pvrusb2/pvrusb2-wm8775.c         |    2 
 drivers/media/video/saa7134/saa7134-core.c           |    2 
 drivers/media/video/tda9887.c                        |    4 
 drivers/media/video/tuner-core.c                     |   12 
 drivers/media/video/tuner-simple.c                   |   74 ++++
 drivers/media/video/tuner-types.c                    |   38 ++
 drivers/media/video/tveeprom.c                       |   18 -
 drivers/media/video/videocodec.h                     |   16 -
 include/media/tuner-types.h                          |   55 +++
 49 files changed, 524 insertions(+), 548 deletions(-)

