Return-Path: <linux-kernel-owner+w=401wt.eu-S932445AbXAPICd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbXAPICd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 03:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbXAPICd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 03:02:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:53916 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932445AbXAPICc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 03:02:32 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=DJMXCxNAmAckUDD6aaWPnFq5P6RS+P2vtYFsDVcGKoCa76n7J3xfQfSYpQr73DxeMwPcSeJiPUv57IVkaHzeLlxsQ8XZvFxiYIpVNRyfCAM88SoyOZ03ytH+WPBYumWSvWxWQDwj3q1zhCbZ412nzU1AmuhDigAvrDI6Fn1/0r4=
Date: Tue, 16 Jan 2007 10:02:10 +0200
To: isely@pobox.com, video4linux-list@redhat.com
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH 2.6.20-rc5 4/4] pvrusb2: Use ARRAY_SIZE macro
Message-ID: <20070116080210.GC30133@Ahmed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARRAY_SIZE macro in miscellaneous pvrusb2 files found

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---
This patch ofcourse don't include previous patches in the set. I've just 
included the remaining modifications  in one patch/mail cause every file
touched here has only one or two lines of changes.

diff --git a/drivers/media/video/pvrusb2/pvrusb2-i2c-core.c b/drivers/media/video/pvrusb2/pvrusb2-i2c-core.c
index f9bb41d..83df9ee 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-i2c-core.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-i2c-core.c
@@ -948,8 +948,7 @@ static void do_i2c_scan(struct pvr2_hdw *hdw)
 	printk("%s: i2c scan beginning\n",hdw->name);
 	for (i = 0; i < 128; i++) {
 		msg[0].addr = i;
-		rc = i2c_transfer(&hdw->i2c_adap,msg,
-				  sizeof(msg)/sizeof(msg[0]));
+		rc = i2c_transfer(&hdw->i2c_adap,msg, ARRAY_SIZE(msg));
 		if (rc != 1) continue;
 		printk("%s: i2c scan: found device @ 0x%x\n",hdw->name,i);
 	}

diff --git a/drivers/media/video/pvrusb2/pvrusb2-sysfs.c b/drivers/media/video/pvrusb2/pvrusb2-sysfs.c
index c294f46..17b5a3e 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-sysfs.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-sysfs.c
@@ -491,7 +491,7 @@ static void pvr2_sysfs_add_control(struct pvr2_sysfs *sfp,int ctl_id)
 	unsigned int cnt,acnt;
 	int ret;
 
-	if ((ctl_id < 0) || (ctl_id >= (sizeof(funcs)/sizeof(funcs[0])))) {
+	if ((ctl_id < 0) || (ctl_id >= ARRAY_SIZE(funcs))) {
 		return;
 	}
 
diff --git a/drivers/media/video/pvrusb2/pvrusb2-video-v4l.c b/drivers/media/video/pvrusb2/pvrusb2-video-v4l.c
index 05f2cdd..b3eba8a 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-video-v4l.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-video-v4l.c
@@ -137,8 +137,7 @@ static int decoder_check(struct pvr2_v4l_decoder *ctxt)
 	unsigned long msk;
 	unsigned int idx;
 
-	for (idx = 0; idx < sizeof(decoder_ops)/sizeof(decoder_ops[0]);
-	     idx++) {
+	for (idx = 0; idx < ARRAY_SIZE(decoder_ops); idx++) {
 		msk = 1 << idx;
 		if (ctxt->stale_mask & msk) continue;
 		if (decoder_ops[idx].check(ctxt)) {
@@ -154,8 +153,7 @@ static void decoder_update(struct pvr2_v4l_decoder *ctxt)
 	unsigned long msk;
 	unsigned int idx;
 
-	for (idx = 0; idx < sizeof(decoder_ops)/sizeof(decoder_ops[0]);
-	     idx++) {
+	for (idx = 0; idx < ARRAY_SIZE(decoder_ops); idx++) {
 		msk = 1 << idx;
 		if (!(ctxt->stale_mask & msk)) continue;
 		ctxt->stale_mask &= ~msk;
@@ -230,8 +228,7 @@ int pvr2_i2c_decoder_v4l_setup(struct pvr2_hdw *hdw,
 	ctxt->ctrl.tuned = (int (*)(void *))decoder_is_tuned;
 	ctxt->client = cp;
 	ctxt->hdw = hdw;
-	ctxt->stale_mask = (1 << (sizeof(decoder_ops)/
-				  sizeof(decoder_ops[0]))) - 1;
+	ctxt->stale_mask = (1 << ARRAY_SIZE(decoder_ops)) - 1;
 	hdw->decoder_ctrl = &ctxt->ctrl;
 	cp->handler = &ctxt->handler;
 	pvr2_trace(PVR2_TRACE_CHIPS,"i2c 0x%x saa711x V4L2 handler set up",
diff --git a/drivers/media/video/pvrusb2/pvrusb2-wm8775.c b/drivers/media/video/pvrusb2/pvrusb2-wm8775.c
index 2413e51..3a29bb8 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-wm8775.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-wm8775.c
@@ -99,8 +99,7 @@ static int wm8775_check(struct pvr2_v4l_wm8775 *ctxt)
 	unsigned long msk;
 	unsigned int idx;
 
-	for (idx = 0; idx < sizeof(wm8775_ops)/sizeof(wm8775_ops[0]);
-	     idx++) {
+	for (idx = 0; idx < ARRAY_SIZE(wm8775_ops); idx++) {
 		msk = 1 << idx;
 		if (ctxt->stale_mask & msk) continue;
 		if (wm8775_ops[idx].check(ctxt)) {
@@ -116,8 +115,7 @@ static void wm8775_update(struct pvr2_v4l_wm8775 *ctxt)
 	unsigned long msk;
 	unsigned int idx;
 
-	for (idx = 0; idx < sizeof(wm8775_ops)/sizeof(wm8775_ops[0]);
-	     idx++) {
+	for (idx = 0; idx < ARRAY_SIZE(wm8775_ops); idx++) {
 		msk = 1 << idx;
 		if (!(ctxt->stale_mask & msk)) continue;
 		ctxt->stale_mask &= ~msk;
@@ -148,8 +146,7 @@ int pvr2_i2c_wm8775_setup(struct pvr2_hdw *hdw,struct pvr2_i2c_client *cp)
 	ctxt->handler.func_table = &hfuncs;
 	ctxt->client = cp;
 	ctxt->hdw = hdw;
-	ctxt->stale_mask = (1 << (sizeof(wm8775_ops)/
-				  sizeof(wm8775_ops[0]))) - 1;
+	ctxt->stale_mask = (1 << ARRAY_SIZE(wm8775_ops)) - 1;
 	cp->handler = &ctxt->handler;
 	pvr2_trace(PVR2_TRACE_CHIPS,"i2c 0x%x wm8775 V4L2 handler set up",
 		   cp->client->addr);

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
