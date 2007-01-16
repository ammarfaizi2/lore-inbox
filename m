Return-Path: <linux-kernel-owner+w=401wt.eu-S1751063AbXAPTIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbXAPTIM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 14:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbXAPTIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 14:08:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:37542 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbXAPTIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 14:08:10 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=LuTsPIJXss9lj8ugqrQKPX4p+2pxC/xF3Zn5p2lDuWlfkd3XIacVqWy1bqUyN52Xle4VjTneDlmOHmccyH3T0lFrhFv5AcOCK5iTiRf75woujjq26jaugx04MnbMW9Fwl3j3ddphMgsQiovUB587Ba2fyxSEB9xLWL7cEBjEr5U=
Date: Tue, 16 Jan 2007 21:07:38 +0200
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>, isely@pobox.com,
       video4linux-list@redhat.com, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: Re: [PATCH 2.6.20-rc5 2/4] pvrusb2: Use ARRAY_SIZE macro
Message-ID: <20070116190738.GD718@Ahmed>
References: <20070116080136.GA30133@Ahmed> <Pine.LNX.4.64.0701160334350.20244@CPE00045a9c397f-CM001225dbafb6> <20070116101633.39e57884.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070116101633.39e57884.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 10:16:33AM -0800, Randy Dunlap wrote:
> On Tue, 16 Jan 2007 03:36:16 -0500 (EST) Robert P. J. Day wrote:
> 
> > On Tue, 16 Jan 2007, Ahmed S. Darwish wrote:
> > 
> > > Use ARRAY_SIZE macro in pvrusb2-hdw.c file
> > >
> > > Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> > 
> > ... snip ...
> > 
> > i'm not sure it's worth submitting multiple patches to convert code
> > expressions to the ARRAY_SIZE() macro since i was going to wait for
> > the next kernel release, and do that in one fell swoop with a single
> > patch.
> > 
> > but if people higher up the food chain think it's a better idea to do
> > it a little at a time, that's fine.
> 
> I'm not strictly on the food chain, but these 4 patches to
> pvrusb2 should have been sent as one patch IMO.

Here's the same patch in one file as suggested.

A patch to use ARRAY_SIZE macro when appropriate. 

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---

pvrusb2-encoder.c   |   19 ++++++++-----------
pvrusb2-hdw.c       |   22 ++++++++--------------
pvrusb2-i2c-core.c  |    3 +--
pvrusb2-std.c       |   25 +++++++++----------------
pvrusb2-sysfs.c     |    2 +-
pvrusb2-video-v4l.c |    9 +++------
pvrusb2-wm8775.c    |    9 +++------
7 files changed, 33 insertions(+), 56 deletions(-)

diff --git a/drivers/media/video/pvrusb2/pvrusb2-encoder.c b/drivers/media/video/pvrusb2/pvrusb2-encoder.c
index c94f97b..4ec937a 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-encoder.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-encoder.c
@@ -169,25 +169,23 @@ static int pvr2_encoder_cmd(void *ctxt,
 
 	*/
 
-	if (arg_cnt_send > (sizeof(wrData)/sizeof(wrData[0]))-4) {
+	if (arg_cnt_send > (ARRAY_SIZE(wrData) - 4)) {
 		pvr2_trace(
 			PVR2_TRACE_ERROR_LEGS,
 			"Failed to write cx23416 command"
 			" - too many input arguments"
 			" (was given %u limit %u)",
-			arg_cnt_send,
-			(unsigned int)(sizeof(wrData)/sizeof(wrData[0])) - 4);
+			arg_cnt_send, ARRAY_SIZE(wrData) - 4);
 		return -EINVAL;
 	}
 
-	if (arg_cnt_recv > (sizeof(rdData)/sizeof(rdData[0]))-4) {
+	if (arg_cnt_recv > (ARRAY_SIZE(rdData) - 4)) {
 		pvr2_trace(
 			PVR2_TRACE_ERROR_LEGS,
 			"Failed to write cx23416 command"
 			" - too many return arguments"
 			" (was given %u limit %u)",
-			arg_cnt_recv,
-			(unsigned int)(sizeof(rdData)/sizeof(rdData[0])) - 4);
+			arg_cnt_recv, ARRAY_SIZE(rdData) - 4);
 		return -EINVAL;
 	}
 
@@ -201,7 +199,7 @@ static int pvr2_encoder_cmd(void *ctxt,
 		for (idx = 0; idx < arg_cnt_send; idx++) {
 			wrData[idx+4] = argp[idx];
 		}
-		for (; idx < (sizeof(wrData)/sizeof(wrData[0]))-4; idx++) {
+		for (; idx < ARRAY_SIZE(wrData) - 4; idx++) {
 			wrData[idx+4] = 0;
 		}
 
@@ -245,8 +243,7 @@ static int pvr2_encoder_cmd(void *ctxt,
 		if (ret) break;
 		wrData[0] = 0x7;
 		ret = pvr2_encoder_read_words(
-			hdw,0,rdData,
-			sizeof(rdData)/sizeof(rdData[0]));
+			hdw,0,rdData, ARRAY_SIZE(rdData));
 		if (ret) break;
 		for (idx = 0; idx < arg_cnt_recv; idx++) {
 			argp[idx] = rdData[idx+4];
@@ -269,13 +266,13 @@ static int pvr2_encoder_vcmd(struct pvr2_hdw *hdw, int cmd,
 	unsigned int idx;
 	u32 data[12];
 
-	if (args > sizeof(data)/sizeof(data[0])) {
+	if (args > ARRAY_SIZE(data)) {
 		pvr2_trace(
 			PVR2_TRACE_ERROR_LEGS,
 			"Failed to write cx23416 command"
 			" - too many arguments"
 			" (was given %u limit %u)",
-			args,(unsigned int)(sizeof(data)/sizeof(data[0])));
+			args, ARRAY_SIZE(data));
 		return -EINVAL;
 	}
 
diff --git a/drivers/media/video/pvrusb2/pvrusb2-hdw.c b/drivers/media/video/pvrusb2/pvrusb2-hdw.c
index d200496..f66f7c6 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-hdw.c
@@ -71,12 +71,10 @@ static const char *pvr2_client_29xxx[] = {
 
 static struct pvr2_string_table pvr2_client_lists[] = {
 	[PVR2_HDW_TYPE_29XXX] = {
-		pvr2_client_29xxx,
-		sizeof(pvr2_client_29xxx)/sizeof(pvr2_client_29xxx[0]),
+		pvr2_client_29xxx, ARRAY_SIZE(pvr2_client_29xxx)
 	},
 	[PVR2_HDW_TYPE_24XXX] = {
-		pvr2_client_24xxx,
-		sizeof(pvr2_client_24xxx)/sizeof(pvr2_client_24xxx[0]),
+		pvr2_client_24xxx, ARRAY_SIZE(pvr2_client_24xxx)
 	},
 };
 
@@ -212,7 +210,7 @@ static const struct pvr2_mpeg_ids mpeg_ids[] = {
 		.id = V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_BOTTOM,
 	}
 };
-#define MPEGDEF_COUNT (sizeof(mpeg_ids)/sizeof(mpeg_ids[0]))
+#define MPEGDEF_COUNT ARRAY_SIZE(mpeg_ids)
 
 
 static const char *control_values_srate[] = {
@@ -846,7 +844,7 @@ static const struct pvr2_ctl_info control_defs[] = {
 	}
 };
 
-#define CTRLDEF_COUNT (sizeof(control_defs)/sizeof(control_defs[0]))
+#define CTRLDEF_COUNT ARRAY_SIZE(control_defs)
 
 
 const char *pvr2_config_get_name(enum pvr2_config cfg)
@@ -960,12 +958,10 @@ static int pvr2_upload_firmware1(struct pvr2_hdw *hdw)
 	};
 	static const struct pvr2_string_table fw_file_defs[] = {
 		[PVR2_HDW_TYPE_29XXX] = {
-			fw_files_29xxx,
-			sizeof(fw_files_29xxx)/sizeof(fw_files_29xxx[0]),
+			fw_files_29xxx, ARRAY_SIZE(fw_files_29xxx)
 		},
 		[PVR2_HDW_TYPE_24XXX] = {
-			fw_files_24xxx,
-			sizeof(fw_files_24xxx)/sizeof(fw_files_24xxx[0]),
+			fw_files_24xxx, ARRAY_SIZE(fw_files_24xxx)
 		},
 	};
 	hdw->fw1_state = FW1_STATE_FAILED; // default result
@@ -1052,8 +1048,7 @@ int pvr2_upload_firmware2(struct pvr2_hdw *hdw)
 	trace_firmware("pvr2_upload_firmware2");
 
 	ret = pvr2_locate_firmware(hdw,&fw_entry,"encoder",
-				   sizeof(fw_files)/sizeof(fw_files[0]),
-				   fw_files);
+				   ARRAY_SIZE(fw_files), fw_files);
 	if (ret < 0) return ret;
 	fwidx = ret;
 	ret = 0;
@@ -1750,8 +1745,7 @@ struct pvr2_hdw *pvr2_hdw_create(struct usb_interface *intf,
 	struct pvr2_ctl_info *ciptr;
 
 	hdw_type = devid - pvr2_device_table;
-	if (hdw_type >=
-	    sizeof(pvr2_device_names)/sizeof(pvr2_device_names[0])) {
+	if (hdw_type >= ARRAY_SIZE(pvr2_device_names)) {
 		pvr2_trace(PVR2_TRACE_ERROR_LEGS,
 			   "Bogus device type of %u reported",hdw_type);
 		return NULL;
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
diff --git a/drivers/media/video/pvrusb2/pvrusb2-std.c b/drivers/media/video/pvrusb2/pvrusb2-std.c
index f95c598..677f126 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-std.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-std.c
@@ -141,10 +141,8 @@ int pvr2_std_str_to_id(v4l2_std_id *idPtr,const char *bufPtr,
 			cnt = 0;
 			while ((cnt < bufSize) && (bufPtr[cnt] != '-')) cnt++;
 			if (cnt >= bufSize) return 0; // No more characters
-			sp = find_std_name(
-				std_groups,
-				sizeof(std_groups)/sizeof(std_groups[0]),
-				bufPtr,cnt);
+			sp = find_std_name(std_groups, ARRAY_SIZE(std_groups),
+					   bufPtr,cnt);
 			if (!sp) return 0; // Illegal color system name
 			cnt++;
 			bufPtr += cnt;
@@ -163,8 +161,7 @@ int pvr2_std_str_to_id(v4l2_std_id *idPtr,const char *bufPtr,
 			if (ch == '/') break;
 			cnt++;
 		}
-		sp = find_std_name(std_items,
-				   sizeof(std_items)/sizeof(std_items[0]),
+		sp = find_std_name(std_items, ARRAY_SIZE(std_items),
 				   bufPtr,cnt);
 		if (!sp) return 0; // Illegal modulation system ID
 		t = sp->id & cmsk;
@@ -189,14 +186,10 @@ unsigned int pvr2_std_id_to_str(char *bufPtr, unsigned int bufSize,
 	unsigned int c1,c2;
 	cfl = 0;
 	c1 = 0;
-	for (idx1 = 0;
-	     idx1 < sizeof(std_groups)/sizeof(std_groups[0]);
-	     idx1++) {
+	for (idx1 = 0; idx1 < ARRAY_SIZE(std_groups); idx1++) {
 		gp = std_groups + idx1;
 		gfl = 0;
-		for (idx2 = 0;
-		     idx2 < sizeof(std_items)/sizeof(std_items[0]);
-		     idx2++) {
+		for (idx2 = 0; idx2 < ARRAY_SIZE(std_items); idx2++) {
 			ip = std_items + idx2;
 			if (!(gp->id & ip->id & id)) continue;
 			if (!gfl) {
@@ -279,7 +272,7 @@ static struct v4l2_standard generic_standards[] = {
 	}
 };
 
-#define generic_standards_cnt (sizeof(generic_standards)/sizeof(generic_standards[0]))
+#define generic_standards_cnt ARRAY_SIZE(generic_standards)
 
 static struct v4l2_standard *match_std(v4l2_std_id id)
 {
@@ -348,7 +341,7 @@ struct v4l2_standard *pvr2_std_create_enum(unsigned int *countptr,
 		fmsk |= idmsk;
 	}
 
-	for (idx2 = 0; idx2 < sizeof(std_mixes)/sizeof(std_mixes[0]); idx2++) {
+	for (idx2 = 0; idx2 < ARRAY_SIZE(std_mixes); idx2++) {
 		if ((id & std_mixes[idx2]) == std_mixes[idx2]) std_cnt++;
 	}
 
@@ -374,8 +367,8 @@ struct v4l2_standard *pvr2_std_create_enum(unsigned int *countptr,
 	idx = 0;
 
 	/* Enumerate potential special cases */
-	for (idx2 = 0; ((idx2 < sizeof(std_mixes)/sizeof(std_mixes[0])) &&
-			(idx < std_cnt)); idx2++) {
+	for (idx2 = 0; (idx2 < ARRAY_SIZE(std_mixes)) && (idx < std_cnt);
+	     idx2++) {
 		if (!(id & std_mixes[idx2])) continue;
 		if (pvr2_std_fill(stddefs+idx,std_mixes[idx2])) idx++;
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
