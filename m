Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWJXDeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWJXDeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 23:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWJXDeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 23:34:21 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:27976 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932410AbWJXDeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 23:34:21 -0400
Date: Mon, 23 Oct 2006 20:28:13 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: video4linux-list@redhat.com, lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, isely@pobox.com, slts@free.fr
Subject: [PATCH] pvrusb2: use NULL instead of 0
Message-Id: <20061023202813.ff01fc74.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix sparse NULL usage warnings:
drivers/media/video/pvrusb2/pvrusb2-v4l2.c:714:14: warning: Using plain integer as NULL pointer
drivers/media/video/pvrusb2/pvrusb2-v4l2.c:715:16: warning: Using plain integer as NULL pointer
drivers/media/video/pvrusb2/pvrusb2-v4l2.c:1079:10: warning: Using plain integer as NULL pointer
drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c:224:58: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c |    2 +-
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c        |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.19-rc2-git8.orig/drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c
+++ linux-2.6.19-rc2-git8/drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c
@@ -221,7 +221,7 @@ static unsigned int decoder_describe(str
 static void decoder_reset(struct pvr2_v4l_cx2584x *ctxt)
 {
 	int ret;
-	ret = pvr2_i2c_client_cmd(ctxt->client,VIDIOC_INT_RESET,0);
+	ret = pvr2_i2c_client_cmd(ctxt->client,VIDIOC_INT_RESET,NULL);
 	pvr2_trace(PVR2_TRACE_CHIPS,"i2c cx25840 decoder_reset (ret=%d)",ret);
 }
 
--- linux-2.6.19-rc2-git8.orig/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
+++ linux-2.6.19-rc2-git8/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
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


---
