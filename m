Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVFUHqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVFUHqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVFUHqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:46:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:50403 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261985AbVFUGav convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:51 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove the scsi_disk devfs_name field as it's no longer needed
In-Reply-To: <1119335444907@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:44 -0700
Message-Id: <11193354443273@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove the scsi_disk devfs_name field as it's no longer needed

Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 556f38ebd8f2209a27cee28bc1ca8f84eef048e6
tree f5aeee4135f2f141a00ae2101121aa6b6a114c8b
parent d354272923879e42604925270dd950a94a5306c8
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:39 -0700

 drivers/scsi/scsi_scan.c   |    6 +-----
 include/scsi/scsi_device.h |    1 -
 2 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -685,12 +685,8 @@ static int scsi_add_lun(struct scsi_devi
 	if (inq_result[7] & 0x10)
 		sdev->sdtr = 1;
 
-	sprintf(sdev->devfs_name, "scsi/host%d/bus%d/target%d/lun%d",
-				sdev->host->host_no, sdev->channel,
-				sdev->id, sdev->lun);
-
 	/*
-	 * End driverfs/devfs code.
+	 * End driverfs code.
 	 */
 
 	if ((sdev->scsi_level >= SCSI_2) && (inq_result[7] & 2) &&
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -64,7 +64,6 @@ struct scsi_device {
 	unsigned sector_size;	/* size in bytes */
 
 	void *hostdata;		/* available to low-level driver */
-	char devfs_name[256];	/* devfs junk */
 	char type;
 	char scsi_level;
 	char inq_periph_qual;	/* PQ from INQUIRY data */	

