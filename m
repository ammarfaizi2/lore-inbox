Return-Path: <linux-kernel-owner+w=401wt.eu-S1751387AbXAOTMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbXAOTMt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXAOTMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:12:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51493 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbXAOTMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:12:48 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       hermann pitton <hermann-pitton@arcor.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 6/9] V4L/DVB (5033): MSI TV@nywhere Plus fixes
Date: Mon, 15 Jan 2007 16:37:06 -0200
Message-id: <20070115183706.PS4442930006@infradead.org>
In-Reply-To: <20070115183647.PS0588920000@infradead.org>
References: <20070115183647.PS0588920000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: hermann pitton <hermann-pitton@arcor.de>

- MSI TV@nywhere Plus. Fix radio, S-Video and external analog audio in
  as far we can know currently.

Signed-off-by: Hermann Pitton <hermann-pitton@arcor.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7134/saa7134-cards.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 4dead84..ae984bb 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2570,6 +2570,7 @@ struct saa7134_board saa7134_boards[] = 
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
+		.gpiomask       = 1 << 21,
 		.inputs = {{
 			.name   = name_tv,
 			.vmux   = 1,
@@ -2578,15 +2579,20 @@ struct saa7134_board saa7134_boards[] = 
 		},{
 			.name   = name_comp1,
 			.vmux   = 3,
-			.amux   = LINE1,
+			.amux   = LINE2,	/* unconfirmed, taken from Philips driver */
+		},{
+			.name   = name_comp2,
+			.vmux   = 0,		/* untested, Composite over S-Video */
+			.amux   = LINE2,
 		},{
 			.name   = name_svideo,
-			.vmux   = 0,
-			.amux   = LINE1,
+			.vmux   = 8,
+			.amux   = LINE2,
 		}},
 		.radio = {
 			.name   = name_radio,
-			.amux   = LINE1,
+			.amux   = TV,
+			.gpio   = 0x0200000,
 		},
 	},
 	[SAA7134_BOARD_CINERGY250PCI] = {

