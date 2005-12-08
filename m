Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932713AbVLHXYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbVLHXYS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbVLHXYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:24:18 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:46671 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932718AbVLHXYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:24:17 -0500
Date: Thu, 08 Dec 2005 21:12:44 -0200
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: mchehab@infradead.org, js@linuxtv.org, akpm@osdl.org,
       linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 0/7] V4L/DVB bug fixes for 2.6.15
Message-Id: <1134083966.7047.165.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch series is also available at: 
		http://linuxtv.org/downloads/quilt.

	It contains the following stuff:

   - Lots of Whitespace cleanups
   - Fix tuner init for Pinnacle PCTV Stereo
   - Convert em28xx to use vm_insert_page instead of remap_pfn_range
   - I2C ID renamed to I2C_DRIVERID_INFRARED

---------

 Documentation/dvb/README.dvb-usb                       |   50 
 Documentation/dvb/README.flexcop                       |    2 
 Documentation/dvb/avermedia.txt                        |    2 
 Documentation/dvb/cards.txt                            |    8 
 Documentation/dvb/contributors.txt                     |    4 
 Documentation/dvb/readme.txt                           |    4 
 drivers/media/common/Kconfig                           |    6 
 drivers/media/common/Makefile                          |    4 
 drivers/media/common/ir-common.c                       |    1 
 drivers/media/common/saa7146_core.c                    |    6 
 drivers/media/common/saa7146_fops.c                    |   32 
 drivers/media/common/saa7146_i2c.c                     |   16 
 drivers/media/common/saa7146_vbi.c                     |    4 
 drivers/media/common/saa7146_video.c                   |   46 
 drivers/media/dvb/b2c2/flexcop-common.h                |    2 
 drivers/media/dvb/b2c2/flexcop-fe-tuner.c              |    4 
 drivers/media/dvb/bt8xx/dvb-bt8xx.c                    |    6 
 drivers/media/dvb/dvb-core/demux.h                     |   92 
 drivers/media/dvb/dvb-core/dmxdev.c                    |    2 
 drivers/media/dvb/dvb-core/dmxdev.h                    |   64 
 drivers/media/dvb/dvb-core/dvb_ca_en50221.c            |    2 
 drivers/media/dvb/dvb-core/dvb_filter.c                |  318 
 drivers/media/dvb/dvb-core/dvb_filter.h                |  100 
 drivers/media/dvb/dvb-core/dvb_frontend.c              |    8 
 drivers/media/dvb/dvb-core/dvb_frontend.h              |    8 
 drivers/media/dvb/dvb-core/dvb_net.c                   |   42 
 drivers/media/dvb/dvb-core/dvb_ringbuffer.c            |  250 
 drivers/media/dvb/dvb-core/dvb_ringbuffer.h            |   20 
 drivers/media/dvb/dvb-core/dvbdev.c                    |  142 
 drivers/media/dvb/dvb-core/dvbdev.h                    |    6 
 drivers/media/dvb/dvb-usb/vp702x-fe.c                  |    2 
 drivers/media/dvb/dvb-usb/vp7045-fe.c                  |    2 
 drivers/media/dvb/frontends/at76c651.c                 |    6 
 drivers/media/dvb/frontends/bcm3510.c                  |    4 
 drivers/media/dvb/frontends/cx22700.c                  |   10 
 drivers/media/dvb/frontends/cx22702.c                  |    2 
 drivers/media/dvb/frontends/cx22702.h                  |    2 
 drivers/media/dvb/frontends/cx24110.c                  |  326 
 drivers/media/dvb/frontends/l64781.c                   |   26 
 drivers/media/dvb/frontends/l64781.h                   |    2 
 drivers/media/dvb/frontends/lgdt330x.c                 |    8 
 drivers/media/dvb/frontends/mt312.c                    |    4 
 drivers/media/dvb/frontends/nxt2002.c                  |    6 
 drivers/media/dvb/frontends/nxt200x.c                  |    4 
 drivers/media/dvb/frontends/nxt6000.c                  |   10 
 drivers/media/dvb/frontends/or51132.c                  |    2 
 drivers/media/dvb/frontends/s5h1420.c                  |    6 
 drivers/media/dvb/frontends/s5h1420.h                  |    2 
 drivers/media/dvb/frontends/sp8870.c                   |   16 
 drivers/media/dvb/frontends/sp887x.c                   |   14 
 drivers/media/dvb/frontends/stv0299.c                  |   36 
 drivers/media/dvb/frontends/tda10021.c                 |   10 
 drivers/media/dvb/frontends/tda10021.h                 |    4 
 drivers/media/dvb/frontends/tda1004x.c                 |    2 
 drivers/media/dvb/frontends/tda8083.c                  |   20 
 drivers/media/dvb/ttpci/av7110.c                       |   26 
 drivers/media/dvb/ttpci/av7110_hw.c                    |   20 
 drivers/media/dvb/ttpci/av7110_v4l.c                   |    4 
 drivers/media/dvb/ttpci/budget-core.c                  |    2 
 drivers/media/dvb/ttpci/budget-patch.c                 |  328 -
 drivers/media/dvb/ttpci/budget.c                       |    6 
 drivers/media/dvb/ttpci/budget.h                       |    2 
 drivers/media/dvb/ttpci/fdump.c                        |    2 
 drivers/media/dvb/ttpci/ttpci-eeprom.c                 |   38 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c      |  126 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-dspbootcode.h | 3276 +++++-----
 drivers/media/dvb/ttusb-dec/ttusb_dec.c                |    4 
 drivers/media/video/Kconfig                            |   14 
 drivers/media/video/bt832.c                            |   14 
 drivers/media/video/bttv-driver.c                      |   94 
 drivers/media/video/bttvp.h                            |    1 
 drivers/media/video/cx88/cx88-blackbird.c              |    2 
 drivers/media/video/cx88/cx88-input.c                  |    2 
 drivers/media/video/cx88/cx88.h                        |    1 
 drivers/media/video/em28xx/em28xx-core.c               |   56 
 drivers/media/video/em28xx/em28xx-i2c.c                |    4 
 drivers/media/video/em28xx/em28xx-video.c              |   23 
 drivers/media/video/em28xx/em28xx.h                    |    8 
 drivers/media/video/ir-kbd-gpio.c                      |    8 
 drivers/media/video/ir-kbd-i2c.c                       |   11 
 drivers/media/video/msp3400.c                          |   18 
 drivers/media/video/saa6588.c                          |    1 
 drivers/media/video/saa711x.c                          |    2 
 drivers/media/video/saa7134/saa6752hs.c                |   17 
 drivers/media/video/saa7134/saa7134-alsa.c             |   18 
 drivers/media/video/saa7134/saa7134-cards.c            |    2 
 drivers/media/video/saa7134/saa7134-core.c             |    1 
 drivers/media/video/saa7134/saa7134-empress.c          |    1 
 drivers/media/video/saa7134/saa7134-i2c.c              |    2 
 drivers/media/video/saa7134/saa7134-oss.c              |  105 
 drivers/media/video/tda9887.c                          |   15 
 drivers/media/video/tvaudio.c                          |   36 
 drivers/media/video/tveeprom.c                         |    3 
 drivers/media/video/tvp5150.c                          |    3 
 drivers/media/video/video-buf-dvb.c                    |    2 
 include/linux/dvb/audio.h                              |   28 
 include/linux/dvb/ca.h                                 |   36 
 include/linux/dvb/dmx.h                                |   26 
 include/linux/dvb/osd.h                                |   58 
 include/linux/dvb/video.h                              |   60 
 include/linux/i2c-id.h                                 |    2 
 include/media/saa7146.h                                |    6 
 include/media/saa7146_vv.h                             |   10 
 103 files changed, 3135 insertions(+), 3166 deletions(-)

