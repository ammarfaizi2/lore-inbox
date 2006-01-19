Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWASWKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWASWKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbWASWKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:10:39 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27399 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422657AbWASWKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:10:37 -0500
Date: Thu, 19 Jan 2006 23:10:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/ide/ide-io.c: make __ide_end_request() static
Message-ID: <20060119221036.GA19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since there's no longer any external user, we can make 
__ide_end_request() static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 7 Jan 2006

 drivers/ide/ide-io.c |    5 ++---
 include/linux/ide.h  |    1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.15-mm2-full/include/linux/ide.h.old	2006-01-07 17:49:26.000000000 +0100
+++ linux-2.6.15-mm2-full/include/linux/ide.h	2006-01-07 17:49:31.000000000 +0100
@@ -1000,7 +1000,6 @@
 extern int noautodma;
 
 extern int ide_end_request (ide_drive_t *drive, int uptodate, int nrsecs);
-extern int __ide_end_request (ide_drive_t *drive, struct request *rq, int uptodate, int nrsecs);
 
 /*
  * This is used on exit from the driver to designate the next irq handler
--- linux-2.6.15-mm2-full/drivers/ide/ide-io.c.old	2006-01-07 17:49:38.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/ide/ide-io.c	2006-01-07 17:50:13.000000000 +0100
@@ -55,8 +55,8 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 
-int __ide_end_request(ide_drive_t *drive, struct request *rq, int uptodate,
-		      int nr_sectors)
+static int __ide_end_request(ide_drive_t *drive, struct request *rq,
+			     int uptodate, int nr_sectors)
 {
 	int ret = 1;
 
@@ -94,7 +94,6 @@
 	}
 	return ret;
 }
-EXPORT_SYMBOL(__ide_end_request);
 
 /**
  *	ide_end_request		-	complete an IDE I/O

