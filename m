Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWJAQQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWJAQQo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWJAQQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:16:44 -0400
Received: from havoc.gtf.org ([69.61.125.42]:60396 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751227AbWJAQQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:16:43 -0400
Date: Sun, 1 Oct 2006 12:16:00 -0400
From: Jeff Garzik <jeff@garzik.org>
To: dwmw2@infradead.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Cc: axboe@kernel.dk
Subject: [PATCH] MTD: fix printk warning
Message-ID: <20061001161600.GA7636@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc spits out this warning:

drivers/mtd/mtd_blkdevs.c: In function ‘do_blktrans_request’:
drivers/mtd/mtd_blkdevs.c:72: warning: format ‘%ld’ expects type ‘long int’, but argument 2 has type ‘unsigned int’

This could be fixed any number of ways, including use of BUG().
rq_data_dir() only returns 0 or 1, so this entire case is superfluous.
I did the most simple fix.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 6baf5fe..178b53b 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -69,7 +69,7 @@ static int do_blktrans_request(struct mt
 		return 1;
 
 	default:
-		printk(KERN_NOTICE "Unknown request %ld\n", rq_data_dir(req));
+		printk(KERN_NOTICE "Unknown request %u\n", rq_data_dir(req));
 		return 0;
 	}
 }
