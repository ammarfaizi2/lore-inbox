Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWCAPBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWCAPBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWCAPAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 10:00:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31140 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030212AbWCAPAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 10:00:00 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Ricardo Cerqueira <v4l@cerqueira.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 06/13] Fixed saa7134 ALSA initialization with multiple cards
Date: Wed, 01 Mar 2006 09:05:38 -0300
Message-id: <20060301120538.PS40997900006@infradead.org>
In-Reply-To: <20060301120529.PS80375900000@infradead.org>
References: <20060301120529.PS80375900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ricardo Cerqueira <v4l@cerqueira.org>
Date: 1141009691 \-0300

When multiple cards were installed, only the first card would have
audio initialized, because only the first position in the array parameter
defaulted to "1"
To make things worse, the "enable" parameter wasn't enabled, so there
was no workaround.

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7134/saa7134-alsa.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/saa7134/saa7134-alsa.c b/drivers/media/video/saa7134/saa7134-alsa.c
index a7a6ab9..7df5e08 100644
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

