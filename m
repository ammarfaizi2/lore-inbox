Return-Path: <linux-kernel-owner+w=401wt.eu-S932749AbXABLnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbXABLnA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932872AbXABLnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:43:00 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:2440 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932749AbXABLm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:42:59 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: isely@pobox.com
Subject: [PATCH] video: pvrusb2-hdw kfree cleanup
Date: Tue, 2 Jan 2007 12:44:21 +0100
User-Agent: KMail/1.9.5
Cc: pvrusb2@isely.net, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021244.21728.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes redundant argument check for kfree().

 drivers/media/video/pvrusb2/pvrusb2-hdw.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/drivers/media/video/pvrusb2/pvrusb2-hdw.c linux-2.6.20-rc2-mm1-b/drivers/media/video/pvrusb2/pvrusb2-hdw.c
--- linux-2.6.20-rc2-mm1-a/drivers/media/video/pvrusb2/pvrusb2-hdw.c	2006-12-28 12:57:37.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/drivers/media/video/pvrusb2/pvrusb2-hdw.c	2007-01-02 01:48:31.000000000 +0100
@@ -1926,10 +1926,10 @@ struct pvr2_hdw *pvr2_hdw_create(struct 
 	if (hdw) {
 		usb_free_urb(hdw->ctl_read_urb);
 		usb_free_urb(hdw->ctl_write_urb);
-		if (hdw->ctl_read_buffer) kfree(hdw->ctl_read_buffer);
-		if (hdw->ctl_write_buffer) kfree(hdw->ctl_write_buffer);
-		if (hdw->controls) kfree(hdw->controls);
-		if (hdw->mpeg_ctrl_info) kfree(hdw->mpeg_ctrl_info);
+		kfree(hdw->ctl_read_buffer);
+		kfree(hdw->ctl_write_buffer);
+		kfree(hdw->controls);
+		kfree(hdw->mpeg_ctrl_info);
 		kfree(hdw);
 	}
 	return NULL;
@@ -1994,10 +1994,10 @@ void pvr2_hdw_destroy(struct pvr2_hdw *h
 			unit_pointers[hdw->unit_number] = NULL;
 		}
 	} while (0); up(&pvr2_unit_sem);
-	if (hdw->controls) kfree(hdw->controls);
-	if (hdw->mpeg_ctrl_info) kfree(hdw->mpeg_ctrl_info);
-	if (hdw->std_defs) kfree(hdw->std_defs);
-	if (hdw->std_enum_names) kfree(hdw->std_enum_names);
+	kfree(hdw->controls);
+	kfree(hdw->mpeg_ctrl_info);
+	kfree(hdw->std_defs);
+	kfree(hdw->std_enum_names);
 	kfree(hdw);
 }
 


-- 
Regards,

	Mariusz Kozlowski
