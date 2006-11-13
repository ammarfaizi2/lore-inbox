Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754551AbWKMMXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbWKMMXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbWKMMXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:23:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14033 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754551AbWKMMXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:23:16 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, "pasky@ucw.cz" <pasky@ucw.cz>,
       Jose Alberto Reguero <jareguero@telefonica.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 4/8] V4L/DVB (4814): Remote support for Avermedia 777
Date: Mon, 13 Nov 2006 10:18:44 -0200
Message-id: <20061113121844.PS0409020004@infradead.org>
In-Reply-To: <20061113121504.PS7687690000@infradead.org>
References: <20061113121504.PS7687690000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: pasky@ucw.cz <pasky@ucw.cz>

I didn't test it personally since I don't have this card, but A16AR uses the
same interface and that one certainly does work perfectly (see the next patch).
This patch was originally sent in
	http://marc.theaimsgroup.com/?l=linux-video&m=114743413825375&w=2
	https://www.redhat.com/mailman/private/video4linux-list/2006-May/msg00103.html
but never got applied. This version has some trivial modifications and drops
the weird gpio hack (it's not clear what practical purpose does it serve).

Signed-off-by: Jose Alberto Reguero <jareguero@telefonica.net>
Signed-off-by: Petr Baudis <pasky@ucw.cz>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7134/saa7134-cards.c |    1 +
 drivers/media/video/saa7134/saa7134-input.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index c9d8e3b..94324b3 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -3718,6 +3718,7 @@ int saa7134_board_init1(struct saa7134_d
 	case SAA7134_BOARD_AVERMEDIA_STUDIO_307:
 	case SAA7134_BOARD_AVERMEDIA_307:
 	case SAA7134_BOARD_AVERMEDIA_GO_007_FM:
+	case SAA7134_BOARD_AVERMEDIA_777:
 /*      case SAA7134_BOARD_SABRENT_SBTTVFM:  */ /* not finished yet */
 	case SAA7134_BOARD_VIDEOMATE_TV_PVR:
 	case SAA7134_BOARD_VIDEOMATE_GOLD_PLUS:
diff --git a/drivers/media/video/saa7134/saa7134-input.c b/drivers/media/video/saa7134/saa7134-input.c
index ff59911..e8dcb6f 100644
--- a/drivers/media/video/saa7134/saa7134-input.c
+++ b/drivers/media/video/saa7134/saa7134-input.c
@@ -194,6 +194,14 @@ int saa7134_input_init1(struct saa7134_d
 		saa_setb(SAA7134_GPIO_GPMODE0, 0x4);
 		saa_setb(SAA7134_GPIO_GPSTATUS0, 0x4);
 		break;
+	case SAA7134_BOARD_AVERMEDIA_777:
+		ir_codes     = ir_codes_avermedia;
+		mask_keycode = 0x02F200;
+		mask_keydown = 0x000400;
+		polling      = 50; // ms
+		/* Without this we won't receive key up events */
+		saa_setb(SAA7134_GPIO_GPMODE1, 0x1);
+		saa_setb(SAA7134_GPIO_GPSTATUS1, 0x1);
 	case SAA7134_BOARD_KWORLD_TERMINATOR:
 		ir_codes     = ir_codes_pixelview;
 		mask_keycode = 0x00001f;

