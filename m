Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTDXWAY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 18:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTDXWAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 18:00:24 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:17672 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S264460AbTDXWAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 18:00:20 -0400
Date: Thu, 24 Apr 2003 17:12:08 -0500
From: mikem@beardog.cca.cpqcorp.net
Message-Id: <200304242212.h3OMC8n01140@beardog.cca.cpqcorp.net>
To: axboe@suse.de
Subject: RE:cciss patches for 2.4.21-rc1, 3 of 4
Cc: linux-kernel@vger.kernel.org, mike.miller@hp.com, steve.cameron@hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2003/04/24

Changes:
	1: Replaces the bit shifting in cciss_get_geometry() & 
	   register_new_disk() with be32_to_cpu() to ensure correct
	   endian-ness across platforms.

diff -urN lx2421p7-1/drivers/block/cciss.c lx2421p7-1.1/drivers/block/cciss.c
--- lx2421p7-1/drivers/block/cciss.c	Mon Apr  7 13:11:04 2003
+++ lx2421p7-1.1/drivers/block/cciss.c	Mon Apr  7 13:12:28 2003
@@ -1348,15 +1348,7 @@
 			sizeof(ReportLunData_struct), 0, 0, 0 );
 
 	if (return_code == IO_OK) {
-		/* printk("LUN Data\n--------------------------\n"); */
-		listlength |= (0xff &
-			(unsigned int)(ld_buff->LUNListLength[0])) << 24;
-		listlength |= (0xff &
-			(unsigned int)(ld_buff->LUNListLength[1])) << 16;
-		listlength |= (0xff &
-			(unsigned int)(ld_buff->LUNListLength[2])) << 8;
-		listlength |= 0xff &
-			(unsigned int)(ld_buff->LUNListLength[3]);
+		listlength = be32_to_cpu(*((__u32 *) &ld_buff->LUNListLength[0]));
 	} else {
 		/* reading number of logical volumes failed */
 		printk(KERN_WARNING "cciss: report logical volume"
@@ -2699,10 +2691,7 @@
 		printk("LUN Data\n--------------------------\n");
 #endif /* CCISS_DEBUG */ 
 
-		listlength |= (0xff & (unsigned int)(ld_buff->LUNListLength[0])) << 24;
-		listlength |= (0xff & (unsigned int)(ld_buff->LUNListLength[1])) << 16;
-		listlength |= (0xff & (unsigned int)(ld_buff->LUNListLength[2])) << 8;	
-		listlength |= 0xff & (unsigned int)(ld_buff->LUNListLength[3]);
+		listlength = be32_to_cpu(*((__u32 *) &ld_buff->LUNListLength[0]));
 	} else { /* reading number of logical volumes failed */
 		printk(KERN_WARNING "cciss: report logical volume"
 			" command failed\n");
