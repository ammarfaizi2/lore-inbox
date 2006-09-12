Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbWILJjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbWILJjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 05:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWILJjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 05:39:55 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:39013 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S965167AbWILJjy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 05:39:54 -0400
Date: Tue, 12 Sep 2006 11:39:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cborntra@de.ibm.com
Subject: [S390] xpram off by one error.
Message-ID: <20060912093952.GB15641@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[S390] xpram off by one error.

The xpram driver shows and uses 4096 bytes less than available.

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/xpram.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/block/xpram.c linux-2.6-patched/drivers/s390/block/xpram.c
--- linux-2.6/drivers/s390/block/xpram.c	2006-09-12 10:57:06.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/xpram.c	2006-09-12 10:57:53.000000000 +0200
@@ -453,7 +453,7 @@ static int __init xpram_init(void)
 		PRINT_WARN("No expanded memory available\n");
 		return -ENODEV;
 	}
-	xpram_pages = xpram_highest_page_index();
+	xpram_pages = xpram_highest_page_index() + 1;
 	PRINT_INFO("  %u pages expanded memory found (%lu KB).\n",
 		   xpram_pages, (unsigned long) xpram_pages*4);
 	rc = xpram_setup_sizes(xpram_pages);
