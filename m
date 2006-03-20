Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965757AbWCTQFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965757AbWCTQFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965754AbWCTQFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:05:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31896 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964969AbWCTPPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:15:25 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 049/141] V4L/DVB (3278): Show debug for tuners trying to
	use unsupported video standards
Date: Mon, 20 Mar 2006 12:08:45 -0300
Message-id: <20060320150845.PS155803000049@infradead.org>
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
Date: 1139300740 -0200

With tuner_debug enabled, if a tuner tries to use a video standard that doesn't
have a matching tuner_params defined, the IFPCoff value and tuner number will
be displayed, and the default tuner_params entry will be used.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
index 61dd26a..aba0688 100644
--- a/drivers/media/video/tuner-simple.c
+++ b/drivers/media/video/tuner-simple.c
@@ -164,8 +164,11 @@ static void default_set_tv_freq(struct i
 		break;
 	}
 	/* use default tuner_params if desired_type not available */
-	if (desired_type != tun->params[j].type)
+	if (desired_type != tun->params[j].type) {
+		tuner_dbg("IFPCoff = %d: tuner_params undefined for tuner %d\n",
+			  IFPCoff,t->type);
 		j = 0;
+	}
 
 	for (i = 0; i < tun->params[j].count; i++) {
 		if (freq > tun->params[j].ranges[i].limit)

