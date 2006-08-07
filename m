Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWHGPFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWHGPFT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWHGPFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:05:19 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:10700 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932112AbWHGPFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:05:18 -0400
Date: Mon, 7 Aug 2006 17:05:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: tape class return value handling.
Message-ID: <20060807150516.GA10416@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] tape class return value handling.

Without this patch register_tape_dev() will always fail, but might
return a value that is not an error number. This will lead to accesses
to already freed memory areas...

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tape_class.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/char/tape_class.c linux-2.6-patched/drivers/s390/char/tape_class.c
--- linux-2.6/drivers/s390/char/tape_class.c	2006-08-07 14:14:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape_class.c	2006-08-07 14:14:42.000000000 +0200
@@ -76,7 +76,7 @@ struct tape_class_device *register_tape_
 				device,
 				"%s", tcd->device_name
 			);
-	rc = PTR_ERR(tcd->class_device);
+	rc = IS_ERR(tcd->class_device) ? PTR_ERR(tcd->class_device) : 0;
 	if (rc)
 		goto fail_with_cdev;
 	rc = sysfs_create_link(
