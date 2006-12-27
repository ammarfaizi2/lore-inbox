Return-Path: <linux-kernel-owner+w=401wt.eu-S932933AbWL0RL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932933AbWL0RL4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933013AbWL0RLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:11:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41449 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932997AbWL0RLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:11:01 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 16/28] V4L/DVB (4984): LOG_STATUS should show the real
	temporal filter value.
Date: Wed, 27 Dec 2006 14:57:30 -0200
Message-id: <20061227165730.PS35389100016@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hans Verkuil <hverkuil@xs4all.nl>

The temporal filter is forced off when scaling. The VIDIOC_LOG_STATUS
handler still showed the old temporal filter. It is now consistent with
the real temporal filter value.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx2341x.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/cx2341x.c b/drivers/media/video/cx2341x.c
index e796afd..2f5ca71 100644
--- a/drivers/media/video/cx2341x.c
+++ b/drivers/media/video/cx2341x.c
@@ -863,6 +863,7 @@ invalid:
 void cx2341x_log_status(struct cx2341x_mpeg_params *p, const char *prefix)
 {
 	int is_mpeg1 = p->video_encoding == V4L2_MPEG_VIDEO_ENCODING_MPEG_1;
+	int temporal = p->video_temporal_filter;
 
 	/* Stream */
 	printk(KERN_INFO "%s: Stream: %s\n",
@@ -919,10 +920,13 @@ void cx2341x_log_status(struct cx2341x_m
 		cx2341x_menu_item(p, V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE),
 		cx2341x_menu_item(p, V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE),
 		p->video_spatial_filter);
+	if (p->width != 720 || p->height != (p->is_50hz ? 576 : 480)) {
+		temporal = 0;
+	}
 	printk(KERN_INFO "%s: Temporal Filter: %s, %d\n",
 		prefix,
 		cx2341x_menu_item(p, V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE),
-		p->video_temporal_filter);
+		temporal);
 	printk(KERN_INFO "%s: Median Filter:   %s, Luma [%d, %d], Chroma [%d, %d]\n",
 		prefix,
 		cx2341x_menu_item(p, V4L2_CID_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE),

