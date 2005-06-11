Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVFKIoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVFKIoo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVFKImp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:42:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:7108 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261653AbVFKHsy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:54 -0400
Subject: [PATCH] Remove the scsi_disk devfs_name field as it's no longer needed
In-Reply-To: <11184761123233@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:32 -0700
Message-Id: <11184761122195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/scsi/scsi_scan.c   |    6 +-----
 include/scsi/scsi_device.h |    1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

--- gregkh-2.6.orig/drivers/scsi/scsi_scan.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/scsi/scsi_scan.c	2005-06-10 23:37:25.000000000 -0700
@@ -666,12 +666,8 @@
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
--- gregkh-2.6.orig/include/scsi/scsi_device.h	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/include/scsi/scsi_device.h	2005-06-10 23:37:25.000000000 -0700
@@ -64,7 +64,6 @@
 	unsigned sector_size;	/* size in bytes */
 
 	void *hostdata;		/* available to low-level driver */
-	char devfs_name[256];	/* devfs junk */
 	char type;
 	char scsi_level;
 	char inq_periph_qual;	/* PQ from INQUIRY data */	

