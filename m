Return-Path: <linux-kernel-owner+w=401wt.eu-S932446AbXAPICv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbXAPICv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 03:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbXAPICv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 03:02:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:53916 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446AbXAPICt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 03:02:49 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=n0ZEXasIklHIKusj0EGlgDnyNm0i9V7yAstkE1DRewld42mqMKxgZhJeg4hDC7w2O7jes469KS8516dRWZbmbUwbV7G8mN2SKXaKR1//DlWTxfZ9j0kdA9EJnGnyu3kEDMUakStM7vUjP+nxbBfAKwliXtk247qaitOYbc8iCII=
Date: Tue, 16 Jan 2007 10:02:29 +0200
To: isely@pobox.com, video4linux-list@redhat.com
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH 2.6.20-rc5 1/4] pvrusb2: Use ARRAY_SIZE macro
Message-ID: <20070116080229.GD30133@Ahmed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

A cleanup series for the pvrusb2 code to use the ARRAY_SIZE macro. Since
The size of the patch is big, I've splitted it to 4 pieces according to
the files they touch.

PATCH 1/4: Use ARRAY_SIZE in pvrusb2-encoder.c

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---
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
 

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
