Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWJKNfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWJKNfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWJKNfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:35:20 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:65304 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751305AbWJKNfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:35:19 -0400
Date: Wed, 11 Oct 2006 15:35:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, melissah@us.ibm.com
Subject: [S390] monwriter kzalloc size.
Message-ID: <20061011133522.GC9305@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Melissa Howland <melissah@us.ibm.com>

[S390] monwriter kzalloc size.

Fix length on kzalloc for data buffer so as to not overwrite
unallocated storage.

Signed-off-by: Melissa Howland <melissah@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/monwriter.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/char/monwriter.c linux-2.6-patched/drivers/s390/char/monwriter.c
--- linux-2.6/drivers/s390/char/monwriter.c	2006-10-11 15:23:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/monwriter.c	2006-10-11 15:23:36.000000000 +0200
@@ -110,7 +110,7 @@ static int monwrite_new_hdr(struct mon_p
 		monbuf = kzalloc(sizeof(struct mon_buf), GFP_KERNEL);
 		if (!monbuf)
 			return -ENOMEM;
-		monbuf->data = kzalloc(monbuf->hdr.datalen,
+		monbuf->data = kzalloc(monhdr->datalen,
 				       GFP_KERNEL | GFP_DMA);
 		if (!monbuf->data) {
 			kfree(monbuf);
