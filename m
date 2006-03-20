Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965461AbWCTPro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965461AbWCTPro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965262AbWCTPrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:47:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42978 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965261AbWCTPVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:21:07 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 104/141] V4L/DVB (3372): Fix a small bug when constructing
	fps and line numbers
Date: Mon, 20 Mar 2006 12:08:54 -0300
Message-id: <20060320150854.PS323905000104@infradead.org>
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

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1141009732 -0300

Previously, only NTSC and PAL/M were associated to 30fps and
525 lines, so, PAL/60 were not handled properly.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/v4l2-common.c b/drivers/media/video/v4l2-common.c
diff --git a/drivers/media/video/v4l2-common.c b/drivers/media/video/v4l2-common.c
index a241bf7..4908dab 100644
--- a/drivers/media/video/v4l2-common.c
+++ b/drivers/media/video/v4l2-common.c
@@ -97,7 +97,7 @@ int v4l2_video_std_construct(struct v4l2
 	memset(vs, 0, sizeof(struct v4l2_standard));
 	vs->index = index;
 	vs->id    = id;
-	if (id & (V4L2_STD_NTSC | V4L2_STD_PAL_M)) {
+	if (id & V4L2_STD_525_60) {
 		vs->frameperiod.numerator = 1001;
 		vs->frameperiod.denominator = 30000;
 		vs->framelines = 525;
@@ -110,7 +110,6 @@ int v4l2_video_std_construct(struct v4l2
 	return 0;
 }
 
-
 /* ----------------------------------------------------------------- */
 /* priority handling                                                 */
 

