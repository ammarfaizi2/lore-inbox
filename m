Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUCYPXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 10:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbUCYPXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 10:23:48 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:50694 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S263204AbUCYPXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 10:23:40 -0500
Date: Thu, 25 Mar 2004 09:36:31 -0600
From: mikem@beardog.cca.cpqcorp.net
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates [1 of 2]
Message-ID: <20040325153631.GA4456@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider this change for inclusion in the 2.4 kernel.

This change is required to support the new MSA30 storage enclosure.
If you do a SCSI inquiry to a SATA disk bad things happen. This patch prevents 
the inquiry from going to SATA disks.

 cciss_scsi.c |    2 ++
 1 files changed, 2 insertions(+)
------------------------------------------------------------------------------
diff -burN lx2425.orig/drivers/block/cciss_scsi.c lx2425/drivers/block/cciss_scsi.c
--- lx2425.orig/drivers/block/cciss_scsi.c	2003-11-28 12:26:19.000000000 -0600
+++ lx2425/drivers/block/cciss_scsi.c	2004-03-04 10:21:33.000000000 -0600
@@ -589,6 +589,8 @@
 
 	for(i=0; i<num_luns; i++) {
 		/* Execute an inquiry to figure the device type */
+		/* Skip over masked devices */
+		if (ld_buff->LUN[i][3] & 0xC0) continue;
 		memset(inq_buff, 0, sizeof(InquiryData_struct));
 		memcpy(scsi3addr, ld_buff->LUN[i], 8); /* ugly... */
 		return_code = sendcmd(CISS_INQUIRY, cntl_num, inq_buff,
