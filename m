Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbVIEVaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbVIEVaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbVIEV3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:29:14 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:38223 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932589AbVIEV3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:29:08 -0400
Date: Mon, 05 Sep 2005 18:26:15 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 10/24] V4L: cx88-dvb incorrectly reporting fixed and
 Removed bad PCI ID for Sabrent
Message-ID: <431cb7f7.BAcp1jNih9/PneFx%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f7.WLMt2rHBnSYk63uXPw/8hg0MRWRIXPIVYklukIGDuyoazuL/"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f7.WLMt2rHBnSYk63uXPw/8hg0MRWRIXPIVYklukIGDuyoazuL/
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f7.WLMt2rHBnSYk63uXPw/8hg0MRWRIXPIVYklukIGDuyoazuL/
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-10-patch.diff"

- cx88-dvb has been incorrectly reporting the card name instead of frontend name
- Removes a bad PCI subsystem ID for saa713x Sabrent card
- Renames DVICO --> DViCO for bttv.
- #include <linux/config.h> no longer needed.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/Documentation/video4linux/CARDLIST.bttv     |    4 ++--
 linux/drivers/media/video/bttv-cards.c            |    4 ++--
 linux/drivers/media/video/cx88/cx88-dvb.c         |    6 ------
 linux/drivers/media/video/saa7134/saa7134-cards.c |    6 ------
 4 files changed, 4 insertions(+), 16 deletions(-)

diff -u /tmp/dst.32438 linux/drivers/media/video/bttv-cards.c
--- /tmp/dst.32438	2005-09-05 11:42:50.000000000 -0300
+++ linux/drivers/media/video/bttv-cards.c	2005-09-05 11:42:50.000000000 -0300
@@ -2260,7 +2260,7 @@
 
 	/* ---- card 0x80 ---------------------------------- */
 	/* Chris Pascoe <c.pascoe@itee.uq.edu.au> */
-	.name           = "DVICO FusionHDTV DVB-T Lite",
+	.name           = "DViCO FusionHDTV DVB-T Lite",
 	.tuner          = -1,
 	.no_msp34xx     = 1,
 	.no_tda9875     = 1,
@@ -2391,7 +2391,7 @@
 {
 	/* ---- card 0x87---------------------------------- */
 	/* Michael Krufky <mkrufky@m1k.net> */
-	.name           = "DVICO FusionHDTV 5 Lite",
+	.name           = "DViCO FusionHDTV 5 Lite",
 	.tuner          = 0,
 	.tuner_type     = TUNER_LG_TDVS_H062F,
 	.tuner_addr	= ADDR_UNSET,
diff -u /tmp/dst.32438 linux/drivers/media/video/cx88/cx88-dvb.c
--- /tmp/dst.32438	2005-09-05 11:42:50.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-09-05 11:42:50.000000000 -0300
@@ -28,7 +28,6 @@
 #include <linux/kthread.h>
 #include <linux/file.h>
 #include <linux/suspend.h>
-#include <linux/config.h>
 
 
 #include "cx88.h"
@@ -403,11 +402,6 @@
 		dev->dvb.frontend->ops->info.frequency_max = dev->core->pll_desc->max;
 	}
 
-	/* Copy the board name into the DVB structure */
-	strlcpy(dev->dvb.frontend->ops->info.name,
-		cx88_boards[dev->core->board].name,
-		sizeof(dev->dvb.frontend->ops->info.name));
-
 	/* register everything */
 	return videobuf_dvb_register(&dev->dvb, THIS_MODULE, dev);
 }
diff -u /tmp/dst.32438 linux/drivers/media/video/saa7134/saa7134-cards.c
--- /tmp/dst.32438	2005-09-05 11:42:51.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2005-09-05 11:42:51.000000000 -0300
@@ -2380,12 +2380,6 @@
 		.driver_data  = SAA7134_BOARD_VIDEOMATE_TV_PVR,
 	},{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
-		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
-		.subvendor    = 0x1131,
-		.subdevice    = 0,
-		.driver_data  = SAA7134_BOARD_SABRENT_SBTTVFM,
-	},{
-		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
 		.subvendor    = 0x1461, /* Avermedia Technologies Inc */
 		.subdevice    = 0x9715,
diff -u /tmp/dst.32438 linux/Documentation/video4linux/CARDLIST.bttv
--- /tmp/dst.32438	2005-09-05 11:42:51.000000000 -0300
+++ linux/Documentation/video4linux/CARDLIST.bttv	2005-09-05 11:42:51.000000000 -0300
@@ -126,12 +126,12 @@
 card=125 - MATRIX Vision Sigma-SQ
 card=126 - MATRIX Vision Sigma-SLC
 card=127 - APAC Viewcomp 878(AMAX)
-card=128 - DVICO FusionHDTV DVB-T Lite
+card=128 - DViCO FusionHDTV DVB-T Lite
 card=129 - V-Gear MyVCD
 card=130 - Super TV Tuner
 card=131 - Tibet Systems 'Progress DVR' CS16
 card=132 - Kodicom 4400R (master)
 card=133 - Kodicom 4400R (slave)
 card=134 - Adlink RTV24
-card=135 - DVICO FusionHDTV 5 Lite
+card=135 - DViCO FusionHDTV 5 Lite
 card=136 - Acorp Y878F

--=_431cb7f7.WLMt2rHBnSYk63uXPw/8hg0MRWRIXPIVYklukIGDuyoazuL/--
