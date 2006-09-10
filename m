Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWIJRJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWIJRJE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWIJRJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:09:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48102 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932309AbWIJRJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:09:01 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hermann Pitton <hermann-pitton@arcor.de>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 2/6] V4L/DVB (4511): Restore
	tuner_ymec_tvf66t5_b_dff_pal_ranges[] to fix UHF switch functionality
Date: Sun, 10 Sep 2006 14:06:45 -0300
Message-id: <20060910170645.PS4930050002@infradead.org>
In-Reply-To: <20060910170419.PS3030230000@infradead.org>
References: <20060910170419.PS3030230000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hermann Pitton <hermann-pitton@arcor.de>

The tena_9533_di_pal_ranges use 0x04 instead the original 0x08 for the
UHF (range 2) switching. This is wrong and therefore nothing happens.
Restore tuner_ymec_tvf66t5_b_dff_pal_ranges[] to make the UHF switch
working again.

Signed-off-by: Hermann Pitton <hermann-pitton@arcor.de>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/tuner-types.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index d7eadc2..8b54259 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -926,11 +926,17 @@ static struct tuner_params tuner_lg_tdvs
 
 /* ------------ TUNER_YMEC_TVF66T5_B_DFF - Philips PAL ------------ */
 
+static struct tuner_range tuner_ymec_tvf66t5_b_dff_pal_ranges[] = {
+	{ 16 * 160.25 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 464.25 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x08, },
+};
+
 static struct tuner_params tuner_ymec_tvf66t5_b_dff_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_PAL,
-		.ranges = tuner_tena_9533_di_pal_ranges,
-		.count  = ARRAY_SIZE(tuner_tena_9533_di_pal_ranges),
+		.ranges = tuner_ymec_tvf66t5_b_dff_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_ymec_tvf66t5_b_dff_pal_ranges),
 	},
 };
 

