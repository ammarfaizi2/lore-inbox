Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbWCXULf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWCXULf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 15:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWCXULe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 15:11:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26563 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751388AbWCXULe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 15:11:34 -0500
Subject: [RFC] [PATCH] Move drivers/usb/media to drivers/media/video
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 17:11:26 -0300
Message-Id: <1143231086.4961.24.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because of historic reasons, there are two separate directories with
V4L stuff. Most drivers are located at driver/media/video. However, some
code for USB Webcams were inserted under drivers/usb/media.

This makes difficult for module authors to know were things should be.
Also, makes Kconfig menu confusing for normal users.

This patch moves all V4L content under drivers/usb/media to
drivers/media/video, and fixes Kconfig/Makefile entries.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>

The patch is at: http://www.linuxtv.org/~mchehab/usb/

---

 drivers/media/Kconfig                              |   14 
 drivers/media/video/Kconfig                        |  232 +
 drivers/media/video/Makefile                       |   19 
 drivers/media/video/dabfirmware.h                  | 1408 +++++
 drivers/media/video/dabusb.c                       |  874 +++
 drivers/media/video/dabusb.h                       |   85 
 drivers/media/video/dsbr100.c                      |  429 +
 drivers/media/video/et61x251/Makefile              |    4 
 drivers/media/video/et61x251/et61x251.h            |  234 +
 drivers/media/video/et61x251/et61x251_core.c       | 2630 +++++++++
 drivers/media/video/et61x251/et61x251_sensor.h     |  116 
 drivers/media/video/et61x251/et61x251_tas5130d1b.c |  141 
 drivers/media/video/ov511.c                        | 5932 ++++++++++++++++++++
 drivers/media/video/ov511.h                        |  568 ++
 drivers/media/video/pwc/Makefile                   |   20 
 drivers/media/video/pwc/philips.txt                |  236 +
 drivers/media/video/pwc/pwc-ctrl.c                 | 1541 +++++
 drivers/media/video/pwc/pwc-if.c                   | 2205 +++++++
 drivers/media/video/pwc/pwc-ioctl.h                |  292 +
 drivers/media/video/pwc/pwc-kiara.c                |  318 +
 drivers/media/video/pwc/pwc-kiara.h                |   45 
 drivers/media/video/pwc/pwc-misc.c                 |  140 
 drivers/media/video/pwc/pwc-nala.h                 |   66 
 drivers/media/video/pwc/pwc-timon.c                |  316 +
 drivers/media/video/pwc/pwc-timon.h                |   61 
 drivers/media/video/pwc/pwc-uncompress.c           |  146 
 drivers/media/video/pwc/pwc-uncompress.h           |   41 
 drivers/media/video/pwc/pwc.h                      |  272 +
 drivers/media/video/se401.c                        | 1435 +++++
 drivers/media/video/se401.h                        |  234 +
 drivers/media/video/sn9c102/Makefile               |    7 
 drivers/media/video/sn9c102/sn9c102.h              |  218 +
 drivers/media/video/sn9c102/sn9c102_core.c         | 2919 ++++++++++
 drivers/media/video/sn9c102/sn9c102_hv7131d.c      |  271 +
 drivers/media/video/sn9c102/sn9c102_mi0343.c       |  363 +
 drivers/media/video/sn9c102/sn9c102_ov7630.c       |  401 +
 drivers/media/video/sn9c102/sn9c102_pas106b.c      |  307 +
 drivers/media/video/sn9c102/sn9c102_pas202bca.c    |  238 +
 drivers/media/video/sn9c102/sn9c102_pas202bcb.c    |  293 +
 drivers/media/video/sn9c102/sn9c102_sensor.h       |  389 +
 drivers/media/video/sn9c102/sn9c102_tas5110c1b.c   |  159 +
 drivers/media/video/sn9c102/sn9c102_tas5130d1b.c   |  169 +
 drivers/media/video/stv680.c                       | 1508 +++++
 drivers/media/video/stv680.h                       |  227 +
 drivers/media/video/usbvideo/Makefile              |    4 
 drivers/media/video/usbvideo/ibmcam.c              | 3932 +++++++++++++
 drivers/media/video/usbvideo/konicawc.c            |  978 +++
 drivers/media/video/usbvideo/ultracam.c            |  679 ++
 drivers/media/video/usbvideo/usbvideo.c            | 2190 +++++++
 drivers/media/video/usbvideo/usbvideo.h            |  394 +
 drivers/media/video/usbvideo/vicam.c               | 1411 +++++
 drivers/media/video/w9968cf.c                      | 3691 ++++++++++++
 drivers/media/video/w9968cf.h                      |  330 +
 drivers/media/video/w9968cf_decoder.h              |   86 
 drivers/media/video/w9968cf_vpp.h                  |   40 
 drivers/media/video/zc0301/Makefile                |    3 
 drivers/media/video/zc0301/zc0301.h                |  192 +
 drivers/media/video/zc0301/zc0301_core.c           | 2055 +++++++
 drivers/media/video/zc0301/zc0301_pas202bcb.c      |  361 +
 drivers/media/video/zc0301/zc0301_sensor.h         |  103 
 drivers/usb/Kconfig                                |    2 
 drivers/usb/Makefile                               |   14 
 drivers/usb/media/Kconfig                          |  241 -
 drivers/usb/media/Makefile                         |   24 
 drivers/usb/media/dabfirmware.h                    | 1408 -----
 drivers/usb/media/dabusb.c                         |  874 ---
 drivers/usb/media/dabusb.h                         |   85 
 drivers/usb/media/dsbr100.c                        |  429 -
 drivers/usb/media/et61x251.h                       |  234 -
 drivers/usb/media/et61x251_core.c                  | 2630 ---------
 drivers/usb/media/et61x251_sensor.h                |  116 
 drivers/usb/media/et61x251_tas5130d1b.c            |  141 
 drivers/usb/media/ibmcam.c                         | 3932 -------------
 drivers/usb/media/konicawc.c                       |  978 ---
 drivers/usb/media/ov511.c                          | 5932 --------------------
 drivers/usb/media/ov511.h                          |  568 --
 drivers/usb/media/pwc/Makefile                     |   20 
 drivers/usb/media/pwc/philips.txt                  |  236 -
 drivers/usb/media/pwc/pwc-ctrl.c                   | 1541 -----
 drivers/usb/media/pwc/pwc-if.c                     | 2205 -------
 drivers/usb/media/pwc/pwc-ioctl.h                  |  292 -
 drivers/usb/media/pwc/pwc-kiara.c                  |  318 -
 drivers/usb/media/pwc/pwc-kiara.h                  |   45 
 drivers/usb/media/pwc/pwc-misc.c                   |  140 
 drivers/usb/media/pwc/pwc-nala.h                   |   66 
 drivers/usb/media/pwc/pwc-timon.c                  |  316 -
 drivers/usb/media/pwc/pwc-timon.h                  |   61 
 drivers/usb/media/pwc/pwc-uncompress.c             |  146 
 drivers/usb/media/pwc/pwc-uncompress.h             |   41 
 drivers/usb/media/pwc/pwc.h                        |  272 -
 drivers/usb/media/se401.c                          | 1435 -----
 drivers/usb/media/se401.h                          |  234 -
 drivers/usb/media/sn9c102.h                        |  218 -
 drivers/usb/media/sn9c102_core.c                   | 2919 ----------
 drivers/usb/media/sn9c102_hv7131d.c                |  271 -
 drivers/usb/media/sn9c102_mi0343.c                 |  363 -
 drivers/usb/media/sn9c102_ov7630.c                 |  401 -
 drivers/usb/media/sn9c102_pas106b.c                |  307 -
 drivers/usb/media/sn9c102_pas202bca.c              |  238 -
 drivers/usb/media/sn9c102_pas202bcb.c              |  293 -
 drivers/usb/media/sn9c102_sensor.h                 |  389 -
 drivers/usb/media/sn9c102_tas5110c1b.c             |  159 -
 drivers/usb/media/sn9c102_tas5130d1b.c             |  169 -
 drivers/usb/media/stv680.c                         | 1508 -----
 drivers/usb/media/stv680.h                         |  227 -
 drivers/usb/media/ultracam.c                       |  679 --
 drivers/usb/media/usbvideo.c                       | 2190 -------
 drivers/usb/media/usbvideo.h                       |  394 -
 drivers/usb/media/vicam.c                          | 1411 -----
 drivers/usb/media/w9968cf.c                        | 3691 ------------
 drivers/usb/media/w9968cf.h                        |  330 -
 drivers/usb/media/w9968cf_decoder.h                |   86 
 drivers/usb/media/w9968cf_vpp.h                    |   40 
 drivers/usb/media/zc0301.h                         |  192 -
 drivers/usb/media/zc0301_core.c                    | 2055 -------
 drivers/usb/media/zc0301_pas202bcb.c               |  361 -
 drivers/usb/media/zc0301_sensor.h                  |  103 
 117 files changed, 43970 insertions(+), 43972 deletions(-)


