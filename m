Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965416AbWI1NJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965416AbWI1NJh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965421AbWI1NJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:09:37 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:1226 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S965417AbWI1NJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:09:35 -0400
Date: Thu, 28 Sep 2006 15:09:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, jan.glauber@de.ibm.com
Subject: [S390] init_timer in tty3270.
Message-ID: <20060928130933.GF1120@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jan.glauber@de.ibm.com>

[S390] init_timer in tty3270.

Call init_timer only once fpr tp->timer in tty3270.

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tty3270.c |    1 -
 1 files changed, 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/char/tty3270.c linux-2.6-patched/drivers/s390/char/tty3270.c
--- linux-2.6/drivers/s390/char/tty3270.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tty3270.c	2006-09-28 14:58:56.000000000 +0200
@@ -698,7 +698,6 @@ tty3270_alloc_view(void)
 	if (!tp->freemem_pages)
 		goto out_tp;
 	INIT_LIST_HEAD(&tp->freemem);
-	init_timer(&tp->timer);
 	for (pages = 0; pages < TTY3270_STRING_PAGES; pages++) {
 		tp->freemem_pages[pages] = (void *)
 			__get_free_pages(GFP_KERNEL|GFP_DMA, 0);
