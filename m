Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVB1WBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVB1WBO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 17:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVB1WBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 17:01:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9225 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261770AbVB1WAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 17:00:24 -0500
Date: Mon, 28 Feb 2005 23:00:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/scsi_transport_fc.c: #0 unused code
Message-ID: <20050228220020.GR4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch #if 0's the following EXPORT_SYMBOL'ed but unused functions:
- fc_target_block
- fc_target_unblock
- fc_host_block
- fc_host_unblock

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

If the inclusion of code using these functions into the kernel is 
pending, please ignore my patch.

 drivers/scsi/scsi_transport_fc.c |   10 ++++++++++
 include/scsi/scsi_transport_fc.h |    4 ----
 2 files changed, 10 insertions(+), 4 deletions(-)

--- linux-2.6.11-rc4-mm1-full/include/scsi/scsi_transport_fc.h.old	2005-02-28 20:24:09.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/scsi/scsi_transport_fc.h	2005-02-28 20:24:30.000000000 +0100
@@ -316,9 +316,5 @@
 
 struct scsi_transport_template *fc_attach_transport(struct fc_function_template *);
 void fc_release_transport(struct scsi_transport_template *);
-int fc_target_block(struct scsi_target *starget);
-void fc_target_unblock(struct scsi_target *starget);
-int fc_host_block(struct Scsi_Host *shost);
-void fc_host_unblock(struct Scsi_Host *shost);
 
 #endif /* SCSI_TRANSPORT_FC_H */
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_transport_fc.c.old	2005-02-28 20:24:39.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_transport_fc.c	2005-02-28 20:40:02.000000000 +0100
@@ -845,10 +845,12 @@
  * @dev:	scsi device
  * @data:	unused
  **/
+#if 0
 static void fc_device_block(struct scsi_device *sdev, void *data)
 {
 	scsi_internal_device_block(sdev);
 }
+#endif  /*  0  */
 
 /**
  * fc_device_unblock - called by target functions to unblock a scsi device
@@ -880,6 +882,8 @@
 	starget_for_each_device(starget, NULL, fc_device_unblock);
 }
 
+#if 0
+
 /**
  * fc_target_block - block a target by temporarily putting all its scsi devices
  *		into the SDEV_BLOCK state.
@@ -940,6 +944,8 @@
 }
 EXPORT_SYMBOL(fc_target_unblock);
 
+#endif  /*  0  */
+
 /**
  * fc_timeout_blocked_host - Timeout handler for blocked scsi hosts
  *			 that fail to recover in the alloted time.
@@ -964,6 +970,8 @@
 	}
 }
 
+#if 0
+
 /**
  * fc_host_block - block all scsi devices managed by the calling host temporarily 
  *		by putting each device in the SDEV_BLOCK state.
@@ -1031,6 +1039,8 @@
 }
 EXPORT_SYMBOL(fc_host_unblock);
 
+#endif  /*  0  */
+
 MODULE_AUTHOR("Martin Hicks");
 MODULE_DESCRIPTION("FC Transport Attributes");
 MODULE_LICENSE("GPL");

