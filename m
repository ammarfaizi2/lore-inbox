Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbTGJVpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbTGJVpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:45:31 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:39696 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266498AbTGJVpS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:45:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: FW: cciss updates for 2.4.22-pre3  [3 of 6]
Date: Thu, 10 Jul 2003 16:59:59 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF104052A65@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss updates for 2.4.22-pre3  [3 of 6]
Thread-Index: AcNHLQzt2ED3nHfxRMa0wCi1MUXgPAAAYQ/g
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Jul 2003 21:59:59.0195 (UTC) FILETIME=[9B0DDAB0:01C3472E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Miller, Mike (OS Dev) 
Sent: Thursday, July 10, 2003 4:49 PM
To: 'axboe@suse.de'; 'marcelo@conectiva.com.br'
Cc: 'alan@lxorguk.ukuu.org.uk'; 'linuxkernel@vger.kernel.org'
Subject: cciss updates for 2.4.22-pre3 [3 of 6]


These patches can be installed in any order EXCEPT the final 2 of the 6. They are named p1* & p2* respectively.

This patch was built & tested using kernel 2.4.21 with the 2.4.22pre3 patch
applied. It is intended for inclusion in the 2.4.22 kernel.
Patch name: cciss_2447_scsi_overrun_fix_for_lx2422p3.patch
Changes:
	1. Fixes a potential overrun if a medium changer is attached.
	   Bug fix.
--------------------------------------------------------------------------------------------------------------------
diff -burN lx2422p3.test/drivers/block/cciss_scsi.c lx2422p3/drivers/block/cciss_scsi.c
--- lx2422p3.test/drivers/block/cciss_scsi.c	2003-06-13 09:51:32.000000000 -0500
+++ lx2422p3/drivers/block/cciss_scsi.c	2003-07-07 16:54:58.000000000 -0500
@@ -1182,6 +1182,12 @@
 		{
 		  case 0x01: /* sequential access, (tape) */
 		  case 0x08: /* medium changer */
+			if (ncurrent >= CCISS_MAX_SCSI_DEVS_PER_HBA) {
+				printk(KERN_INFO "cciss%d: %s ignored, "
+					"too many devices.\n", cntl_num,
+					DEVICETYPE(devtype));
+				break;
+			}
 			memcpy(&currentsd[ncurrent].scsi3addr[0],
 				&scsi3addr[0], 8);
 			currentsd[ncurrent].devtype = devtype;
