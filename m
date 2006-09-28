Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWI1BIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWI1BIZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWI1BIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:08:25 -0400
Received: from havoc.gtf.org ([69.61.125.42]:45522 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964979AbWI1BIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:08:24 -0400
Date: Wed, 27 Sep 2006 21:08:24 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH] SCSI: shift device_reprobe() warning explosion
Message-ID: <20060928010824.GA26438@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SCSI warns about device_reprobe() for _every file_, even though there is
only a single caller in the entirety of SCSI.

The need to check return code is valid, so we update the warning area to
shift the burden to the [only] caller, mptsas.

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

