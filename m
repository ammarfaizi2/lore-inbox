Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWJKMuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWJKMuo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWJKMun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:50:43 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:58348 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751245AbWJKMum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:50:42 -0400
Subject: [PATCH 3/3] drivers/scsi/NCR5380.c: Replacing yield() with a
	better alternative
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: James.Bottomley@steeleye.com,
       kernel Janitors <kernel-janitors@lists.osdl.org>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 18:24:02 +0530
Message-Id: <1160571242.19143.320.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For this driver schedule_timeout_schedule() seems to be a better
alternative. 

*Please see if the function should be called with 1 jiffy delay or more
is better*

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/scsi/NCR5380.c linux-2.6.19-rc1/drivers/scsi/NCR5380.c
--- linux-2.6.19-rc1-orig/drivers/scsi/NCR5380.c	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.19-rc1/drivers/scsi/NCR5380.c	2006-10-11 17:57:02.000000000 +0530
@@ -347,7 +347,7 @@ static int NCR5380_poll_politely(struct 
 		if((r & bit) == val)
 			return 0;
 		if(!in_interrupt())
-			yield();
+			schedule_timeout_interruptible(1);
 		else
 			cpu_relax();
 	}


