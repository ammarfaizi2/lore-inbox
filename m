Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932769AbWCQVAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbWCQVAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 16:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932783AbWCQU57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:57:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7595 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932775AbWCQU5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:57:44 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Duncan Sands <baldrick@free.fr>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 01/21] Nskips maybe used uninitialized in bttv_risc_overlay
Date: Fri, 17 Mar 2006 17:54:32 -0300
Message-id: <20060317205432.PS54911700001@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Duncan Sands <baldrick@free.fr>
Date: 1141914014 \-0300

The Coverity checker (previously Stanford checker) noticed that
the value of nskips could be read even if it was never written.

Signed-off-by: Duncan Sands <baldrick@free.fr>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/bttv-risc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/bttv-risc.c b/drivers/media/video/bttv-risc.c
index b40e973..af66a8d 100644
--- a/drivers/media/video/bttv-risc.c
+++ b/drivers/media/video/bttv-risc.c
@@ -274,6 +274,8 @@ bttv_risc_overlay(struct bttv *btv, stru
 		if (line > maxy)
 			btcx_calc_skips(line, ov->w.width, &maxy,
 					skips, &nskips, ov->clips, ov->nclips);
+		else
+			nskips = 0;
 
 		/* write out risc code */
 		for (start = 0, skip = 0; start < ov->w.width; start = end) {

