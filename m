Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWJLEZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWJLEZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 00:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWJLEZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 00:25:46 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:6790 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751186AbWJLEZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 00:25:45 -0400
Subject: Re: [PATCH 3/3] drivers/scsi/NCR5380.c: Replacing yield() with a
	better alternative
From: Amol Lad <amol@verismonetworks.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel <linux-kernel@vger.kernel.org>, James.Bottomley@steeleye.com,
       kernel Janitors <kernel-janitors@lists.osdl.org>
In-Reply-To: <1160589175.16513.58.camel@localhost.localdomain>
References: <1160571242.19143.320.camel@amol.verismonetworks.com>
	 <1160589175.16513.58.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 09:59:04 +0530
Message-Id: <1160627344.19143.351.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You want cond_resched() for this driver as its polling the hardware for
> a change that should occur very soon. (Actually you want to throw the
> hardware in the bin)
> 

Replaced schedule_timeout_interruptible() with cond_resched()

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
+			cond_resched();
 		else
 			cpu_relax();
 	}


