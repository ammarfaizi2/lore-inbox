Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbTDPPnM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTDPPnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:43:11 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:28168 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264551AbTDPPmR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:42:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: FW: cciss patches for 2.4.21pre7
Date: Wed, 16 Apr 2003 10:54:03 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF102399B33@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss patches for 2.4.21pre7
Thread-Index: AcMEL5KjU6uBrT/xSPKYfoH7H5vQBwAAEVxw
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Cameron, Steve" <Steve.Cameron@hp.com>
X-OriginalArrivalTime: 16 Apr 2003 15:54:03.0523 (UTC) FILETIME=[67576D30:01C30430]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third of 3 patches to update the HP cciss driver to version 2.4.44 for the 2.4.21pre7 kernel. Patches should be applied in order.

Thanks,
mikem

2003/04/15

Changes:
	1: Replaces the bit shifting in cciss_get_geometry() & 
	   register_new_disk() with be32_to_cpu().

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
