Return-Path: <linux-kernel-owner+w=401wt.eu-S932443AbXAPICP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbXAPICP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 03:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbXAPICP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 03:02:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:53916 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443AbXAPICN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 03:02:13 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=M1/jQ98mcr6/efKsKWfznTYysPnq1P1asV9r3bYmJrCaVMV3AFFTkqdIJUsBwRuqc8rFtxhrVlEYeG08pvBXs/GyrfgAX1si/vd35z5uabDTBYZ0uv/fFNfpLFK/9Kd+ie0twWxeAsUNfiRF/UIX6RrEMUWuISz2hI4Nzf3E5Uo=
Date: Tue, 16 Jan 2007 10:01:54 +0200
To: isely@pobox.com, video4linux-list@redhat.com
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH 2.6.20-rc5 3/4] pvrusb2: Use ARRAY_SIZE macro
Message-ID: <20070116080154.GB30133@Ahmed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARRAY_SIZE macro in pvrusb2-std.c file

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---
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

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
