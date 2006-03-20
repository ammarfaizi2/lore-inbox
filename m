Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965366AbWCTPlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965366AbWCTPlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbWCTPlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:41:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23736 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965291AbWCTPZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:25:00 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 048/141] V4L/DVB (3277): Use default tuner_params if
	desired_type not available
Date: Mon, 20 Mar 2006 12:08:45 -0300
Message-id: <20060320150844.PS991770000048@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1139300739 -0200

If a given tuner definition contains more than one tuner_params array members,
it will try to select the appropriate tuner_params based on the video standard
in use. If there is no tuner_params defined for the current video standard, it
will select the default, tuner_params[0]

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
index 2e680cf..61dd26a 100644
--- a/drivers/media/video/tuner-simple.c
+++ b/drivers/media/video/tuner-simple.c
@@ -163,6 +163,10 @@ static void default_set_tv_freq(struct i
 			continue;
 		break;
 	}
+	/* use default tuner_params if desired_type not available */
+	if (desired_type != tun->params[j].type)
+		j = 0;
+
 	for (i = 0; i < tun->params[j].count; i++) {
 		if (freq > tun->params[j].ranges[i].limit)
 			continue;
@@ -340,6 +344,9 @@ static void default_set_radio_freq(struc
 			continue;
 		break;
 	}
+	/* use default tuner_params if desired_type not available */
+	if (desired_type != tun->params[j].type)
+		j = 0;
 
 	div = (20 * freq / 16000) + (int)(20*10.7); /* IF 10.7 MHz */
 	buffer[2] = (tun->params[j].ranges[0].config & ~TUNER_RATIO_MASK) | TUNER_RATIO_SELECT_50; /* 50 kHz step */

