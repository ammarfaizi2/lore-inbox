Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbUCYUCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 15:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUCYUCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 15:02:07 -0500
Received: from mailout.zma.compaq.com ([161.114.64.103]:45323 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S263591AbUCYUCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 15:02:04 -0500
Date: Thu, 25 Mar 2004 14:14:55 -0600
From: mike.miller@hp.com
To: akpm@osdl.org, arjanv@redhat.com
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: cciss update for 2.6 [1 of 2]
Message-ID: <20040325201455.GD4456@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider this update for 2.6.

This change is required to support the new MSA30 storage enclosure.
If you do a SCSI inquiry to a SATA disk bad things happen. This patch prevents the inquiry from going to SATA disks.

 cciss_scsi.c |    1 +
 1 files changed, 1 insertion(+)
-------------------------------------------------------------------------------
diff -burpN lx265-rc2.orig/drivers/block/cciss_scsi.c lx265-rc2-test/drivers/block/cciss_scsi.c
--- lx265-rc2.orig/drivers/block/cciss_scsi.c	2004-03-24 14:22:15.000000000 -0600
+++ lx265-rc2-test/drivers/block/cciss_scsi.c	2004-03-25 13:45:12.000000000 -0600
@@ -1058,6 +1058,7 @@ cciss_update_non_disk_devices(int cntl_n
 		int devtype;
 
 		/* for each physical lun, do an inquiry */
+		if (ld_buff->LUN[i][3] & 0xC0) continue;
 		memset(inq_buff, 0, sizeof(InquiryData_struct));
 		memcpy(&scsi3addr[0], &ld_buff->LUN[i][0], 8);
 
