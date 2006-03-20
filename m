Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966571AbWCTPSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966571AbWCTPSW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966568AbWCTPSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:18:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56984 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965225AbWCTPST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:18:19 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Ricardo Cerqueira <v4l@cerqueira.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 092/141] V4L/DVB (3348): Fixed saa7134 ALSA initialization
	with multiple cards
Date: Mon, 20 Mar 2006 12:08:52 -0300
Message-id: <20060320150852.PS360147000092@infradead.org>
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

From: Ricardo Cerqueira <v4l@cerqueira.org>
Date: 1141009691 -0300

When multiple cards were installed, only the first card would have
audio initialized, because only the first position in the array parameter
defaulted to "1"
To make things worse, the "enable" parameter wasn't enabled, so there
was no workaround.

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/saa7134/saa7134-alsa.c b/drivers/media/video/saa7134/saa7134-alsa.c
diff --git a/drivers/media/video/saa7134/saa7134-alsa.c b/drivers/media/video/saa7134/saa7134-alsa.c
index d3c7345..614f7b9 100644
--- a/drivers/media/video/saa7134/saa7134-alsa.c
+++ b/drivers/media/video/saa7134/saa7134-alsa.c
@@ -54,10 +54,12 @@ MODULE_PARM_DESC(debug,"enable debug mes
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
-static int enable[SNDRV_CARDS] = {1, [1 ... (SNDRV_CARDS - 1)] = 0};
+static int enable[SNDRV_CARDS] = {1, [1 ... (SNDRV_CARDS - 1)] = 1};
 
 module_param_array(index, int, NULL, 0444);
+module_param_array(enable, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for SAA7134 capture interface(s).");
+MODULE_PARM_DESC(enable, "Enable (or not) the SAA7134 capture interface(s).");
 
 #define dprintk(fmt, arg...)    if (debug) \
 	printk(KERN_DEBUG "%s/alsa: " fmt, dev->name , ##arg)

