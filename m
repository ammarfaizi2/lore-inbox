Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVIEVql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVIEVql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVIEVnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:43:47 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:19282 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932656AbVIEVnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:43:40 -0400
Date: Mon, 05 Sep 2005 18:26:16 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 17/24] V4L: The Microtune 4049FM5 uses an IF frequency of
 33.3 MHz for FM radio.
Message-ID: <431cb7f8.1JP6qgnqRq28lnB3%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f8.w5EanaMQaG7qHr/w5O2Wrg98FftPR3lwBxtcRsD4uwrFJQpj"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f8.w5EanaMQaG7qHr/w5O2Wrg98FftPR3lwBxtcRsD4uwrFJQpj
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f8.w5EanaMQaG7qHr/w5O2Wrg98FftPR3lwBxtcRsD4uwrFJQpj
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-17-patch.diff"

- The Microtune 4049FM5 uses an IF frequency of 33.3 MHz for FM radio.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

 linux/drivers/media/video/bttv-cards.c      |    4 ++--
 linux/drivers/media/video/cx88/cx88-video.c |    2 +-
 linux/drivers/media/video/tuner-simple.c    |    4 ++++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff -u /tmp/dst.689 linux/drivers/media/video/bttv-cards.c
--- /tmp/dst.689	2005-09-05 11:43:04.000000000 -0300
+++ linux/drivers/media/video/bttv-cards.c	2005-09-05 11:43:04.000000000 -0300
@@ -299,8 +299,8 @@
 	{ 0x00011822, BTTV_TWINHAN_DST,   "Twinhan VisionPlus DVB" },
 	{ 0xfc00270f, BTTV_TWINHAN_DST,   "ChainTech digitop DST-1000 DVB-S" },
 	{ 0x07711461, BTTV_AVDVBT_771,    "AVermedia AverTV DVB-T 771" },
-	{ 0xdb1018ac, BTTV_DVICO_DVBT_LITE,    "DVICO FusionHDTV DVB-T Lite" },
-	{ 0xd50018ac, BTTV_DVICO_FUSIONHDTV_5_LITE,    "DVICO FusionHDTV 5 Lite" },
+	{ 0xdb1018ac, BTTV_DVICO_DVBT_LITE,    "DViCO FusionHDTV DVB-T Lite" },
+	{ 0xd50018ac, BTTV_DVICO_FUSIONHDTV_5_LITE,    "DViCO FusionHDTV 5 Lite" },
 
 	{ 0, -1, NULL }
 };
diff -u /tmp/dst.689 linux/drivers/media/video/cx88/cx88-video.c
--- /tmp/dst.689	2005-09-05 11:43:04.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-video.c	2005-09-05 11:43:04.000000000 -0300
@@ -2024,7 +2024,7 @@
 
 		pci_disable_device(pci_dev);
 		dev->state.disabled = 1;
-	
+
 		return err;
 	}
 	pci_restore_state(pci_dev);
diff -u /tmp/dst.689 linux/drivers/media/video/tuner-simple.c
--- /tmp/dst.689	2005-09-05 11:43:04.000000000 -0300
+++ linux/drivers/media/video/tuner-simple.c	2005-09-05 11:43:04.000000000 -0300
@@ -468,6 +468,10 @@
 	case TUNER_LG_PAL_FM:
 		buffer[3] = 0xa5;
 		break;
+	case TUNER_MICROTUNE_4049FM5:
+		div = (20 * freq) / 16000 + (int)(33.3 * 20); /* IF 33.3 MHz */
+		buffer[3] = 0xa4;
+		break;
 	default:
 		buffer[3] = 0xa4;
 		break;

--=_431cb7f8.w5EanaMQaG7qHr/w5O2Wrg98FftPR3lwBxtcRsD4uwrFJQpj--
