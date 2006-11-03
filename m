Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753066AbWKCEEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbWKCEEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbWKCEEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:04:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47819 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753066AbWKCEEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:04:46 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 3/7] V4L/DVB (4786): Pvrusb2: use NULL instead of 0
Date: Fri, 03 Nov 2006 01:02:13 -0300
Message-id: <20061103040213.PS8770730003@infradead.org>
In-Reply-To: <20061103035925.PS9047100000@infradead.org>
References: <20061103035925.PS9047100000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Randy Dunlap <randy.dunlap@oracle.com>

Fix sparse NULL usage warnings:
drivers/media/video/pvrusb2/pvrusb2-v4l2.c:714:14: warning: Using plain integer as NULL pointer
drivers/media/video/pvrusb2/pvrusb2-v4l2.c:715:16: warning: Using plain integer as NULL pointer
drivers/media/video/pvrusb2/pvrusb2-v4l2.c:1079:10: warning: Using plain integer as NULL pointer
drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c:224:58: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c |    2 +-
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c        |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c b/drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c
index df8feac..c80c26b 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c
@@ -221,7 +221,7 @@ static unsigned int decoder_describe(str
 static void decoder_reset(struct pvr2_v4l_cx2584x *ctxt)
 {
 	int ret;
-	ret = pvr2_i2c_client_cmd(ctxt->client,VIDIOC_INT_RESET,0);
+	ret = pvr2_i2c_client_cmd(ctxt->client,VIDIOC_INT_RESET,NULL);
 	pvr2_trace(PVR2_TRACE_CHIPS,"i2c cx25840 decoder_reset (ret=%d)",ret);
 }
 
diff --git a/drivers/media/video/pvrusb2/pvrusb2-v4l2.c b/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
index 97e974d..bb40e90 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
@@ -711,8 +711,8 @@ static void pvr2_v4l2_dev_destroy(struct
 	       dip->devbase.minor,pvr2_config_get_name(dip->config));
 
 	/* Paranoia */
-	dip->v4lp = 0;
-	dip->stream = 0;
+	dip->v4lp = NULL;
+	dip->stream = NULL;
 
 	/* Actual deallocation happens later when all internal references
 	   are gone. */
@@ -1076,7 +1076,7 @@ struct pvr2_v4l2 *pvr2_v4l2_create(struc
 	vp->vdev = kmalloc(sizeof(*vp->vdev),GFP_KERNEL);
 	if (!vp->vdev) {
 		kfree(vp);
-		return 0;
+		return NULL;
 	}
 	memset(vp->vdev,0,sizeof(*vp->vdev));
 	pvr2_channel_init(&vp->channel,mnp);

