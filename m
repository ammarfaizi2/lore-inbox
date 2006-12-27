Return-Path: <linux-kernel-owner+w=401wt.eu-S932915AbWL0RIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915AbWL0RIr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932962AbWL0RIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:08:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41736 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932915AbWL0RIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:08:46 -0500
Message-Id: <20061227165016.PS89442900000@infradead.org>
Date: Wed, 27 Dec 2006 14:50:16 -0200
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       V4L <video4linux-list@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/28] V4L/DVB fixes
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull 'master' from:
        git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git master

It fixes some OOPS and compilation troubles on non x86 platforms and some Kconfig
broken dependencies. There are several fixes at the drivers, including some fixes
to support some not so common standards, like PAL/60.
The biggest changes are some required fixes on usbvision. There's no risk of causing
regression, since this driver were just introduced at kernel.

   - Fix autosearch index
   - Put remote-debugging in the right place
   - Fix namespace conflict between w9968cf.c on MIPS
   - Usbvision: possible cleanups
   - Removal of unused code from usbvision-i2c.c
   - VIDEO_PALETTE_YUYV and VIDEO_PALETTE_YUV422 are the same palette
   - Add missing tuner module option pal=60 for PAL-60 support.
   - Add PAL-60 support for cx2584x.
   - Usbvision memory fixes
   - Dvb-core: fix bug in CRC-32 checking on 64-bit systems
   - Dvb-core: fix printk type warning
   - Fixes compilation when CONFIG_V4L1_COMPAT is not selected
   - Fixes bug 7267: PAL/60 is not working
   - Fix broken audio mode handling for line-in in msp3400.
   - Force temporal filter to 0 when scaling to prevent ghosting.
   - LOG_STATUS should show the real temporal filter value.
   - Cx2341x audio_properties is an u16, not u8
   - Cpia2/cpia2_usb.c: fix error-path leak
   - Cafe_ccic.c: fix NULL dereference
   - Fix typo in saa7134-dvb.c
   - Vivi: fix use after free in list_for_each()
   - Vivi: fix kthread_run() error check
   - Msp3400: fix kthread_run error check
   - Bttv: delete duplicated ioremap()
   - Allyesconfig build fixes on some non x86 arch
   - Add two required headers on kernel 2.6.20-rc1
   - Usbvision fix: It was using "&&" instead "&"
   - Cx88: Fix leadtek_eeprom tagging

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 drivers/media/common/ir-functions.c             |    1 
 drivers/media/dvb/dvb-core/dvb_net.c            |    4 -
 drivers/media/dvb/dvb-usb/nova-t-usb2.c         |    4 -
 drivers/media/dvb/frontends/dib3000mc.c         |    2 
 drivers/media/video/Kconfig                     |    2 
 drivers/media/video/bt8xx/bttv-driver.c         |    4 -
 drivers/media/video/cafe_ccic.c                 |    2 
 drivers/media/video/cpia2/cpia2_usb.c           |    4 +
 drivers/media/video/cx2341x.c                   |   21 ++-
 drivers/media/video/cx25840/cx25840-vbi.c       |    9 +
 drivers/media/video/cx88/cx88-cards.c           |    2 
 drivers/media/video/cx88/cx88-core.c            |   35 +++--
 drivers/media/video/cx88/cx88.h                 |    2 
 drivers/media/video/em28xx/em28xx-video.c       |    4 -
 drivers/media/video/meye.c                      |    4 -
 drivers/media/video/msp3400-driver.c            |    8 -
 drivers/media/video/msp3400-kthreads.c          |   11 +-
 drivers/media/video/saa7134/saa7134-dvb.c       |    8 +
 drivers/media/video/tuner-core.c                |    4 +
 drivers/media/video/usbvision/usbvision-cards.c |   11 +-
 drivers/media/video/usbvision/usbvision-core.c  |   83 +++++--------
 drivers/media/video/usbvision/usbvision-i2c.c   |   35 +----
 drivers/media/video/usbvision/usbvision-video.c |  150 ++++++++++++++---------
 drivers/media/video/usbvision/usbvision.h       |   27 ----
 drivers/media/video/vivi.c                      |    8 +
 drivers/media/video/w9966.c                     |    2 
 drivers/media/video/w9968cf.c                   |   24 ++--
 drivers/media/video/zoran_device.c              |    3 
 include/media/cx2341x.h                         |    2 
 include/media/ir-common.h                       |    1 
 30 files changed, 242 insertions(+), 235 deletions(-)

