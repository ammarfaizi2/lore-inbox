Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbTGJVoz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbTGJVoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:44:55 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:41476 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266479AbTGJVox convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:44:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: FW: cciss updates for 2.4.22-pre3 [2 of 6]
Date: Thu, 10 Jul 2003 16:59:33 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF104052A64@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss updates for 2.4.22-pre3 [2 of 6]
Thread-Index: AcNHLKvfNOWt2Q6CR+yy7bsK3/MmFwAAdQ3A
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Jul 2003 21:59:34.0015 (UTC) FILETIME=[8C0BB0F0:01C3472E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Miller, Mike (OS Dev) 
Sent: Thursday, July 10, 2003 4:46 PM
To: 'axboe@suse.de'; 'marcelo@conectiva.com.br'
Cc: 'alan@lxorguk.ukuu.org.uk'; 'linuxkernel@vger.kernel.org'
Subject: cciss updates for 2.4.22-pre3 [2 of 6]


These patches can be installed in any order EXCEPT the final 2 of the 6. They are name p1* & p2* respectively.

This patch was built & tested using kernel 2.4.21 with the 2.4.22pre3 patch
applied. It is intended for inclusion in the 2.4.22 kernel.
Patch name: cciss_2447_PCI_BAR_fix.patch
Changes:
	1. Changes the PCI_BASE_ADDRESS_MEM_PREFETCH case in the 
	   find_PCI_BAR_index() function to a default case. This
	   should never happen in PCI version 2.2. Bug fix.
--------------------------------------------------------------------------------------------------------------------
diff -burN lx2422p3/drivers/block/cciss.c lx2422p3.test/drivers/block/cciss.c
--- lx2422p3/drivers/block/cciss.c	2003-07-07 13:49:34.000000000 -0500
+++ lx2422p3.test/drivers/block/cciss.c	2003-07-07 14:43:05.000000000 -0500
@@ -2460,7 +2460,9 @@
 				case PCI_BASE_ADDRESS_MEM_TYPE_64:
 					offset += 8;
 					break;
-				case PCI_BASE_ADDRESS_MEM_PREFETCH:
+				default: /* reserved in PCI 2.2 */
+					printk(KERN_WARNING "Base address is invalid\n");
+					return -1;	
 				break;
 			}
 		}
