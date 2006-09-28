Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031301AbWI1AjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031301AbWI1AjA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031299AbWI1AjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:39:00 -0400
Received: from havoc.gtf.org ([69.61.125.42]:58833 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1031296AbWI1Ai6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:38:58 -0400
Date: Wed, 27 Sep 2006 20:38:57 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] SCSI: quiet device_reprobe warning
Message-ID: <20060928003857.GA23981@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This quiets a huge explosion of warnings that appeared with the
__must_check patch, by shifting the burden to the caller.

Incidentally, there is only a single user of this function: mptsas

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 895d212..b401c82 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -298,9 +298,9 @@ extern int scsi_execute_async(struct scs
 			      void (*done)(void *, char *, int, int),
 			      gfp_t gfp);
 
-static inline void scsi_device_reprobe(struct scsi_device *sdev)
+static inline int __must_check scsi_device_reprobe(struct scsi_device *sdev)
 {
-	device_reprobe(&sdev->sdev_gendev);
+	return device_reprobe(&sdev->sdev_gendev);
 }
 
 static inline unsigned int sdev_channel(struct scsi_device *sdev)
