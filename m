Return-Path: <linux-kernel-owner+w=401wt.eu-S932442AbXAPICA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbXAPICA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 03:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbXAPICA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 03:02:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:53916 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442AbXAPIB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 03:01:59 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=W8IdM/qC6bYoagFMJGFuEx3Qed5leoVme+yLnBb8dV31HJ2zNpY5os2Su/4Nm0D6Nfb7A+oFxzptj/ZUice8lfZRL2ufSQBHW40k7j2M0/LbckxuKk9JyNicPrbsGEps6+KQ36f/oibQR/GArcELitoCvpSfI82sIx/68rWSdBA=
Date: Tue, 16 Jan 2007 10:01:36 +0200
To: isely@pobox.com, video4linux-list@redhat.com
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH 2.6.20-rc5 2/4] pvrusb2: Use ARRAY_SIZE macro
Message-ID: <20070116080136.GA30133@Ahmed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARRAY_SIZE macro in pvrusb2-hdw.c file

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---
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

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
