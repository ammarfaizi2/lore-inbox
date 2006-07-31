Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbWGaWMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbWGaWMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 18:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWGaWMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 18:12:30 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:4528 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751401AbWGaWM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 18:12:29 -0400
From: Zach Brown <zach.brown@oracle.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>
Message-Id: <20060731221229.18058.82700.sendpatchset@tetsuo.zabbo.net>
Subject: [PATCH] [AIO] remove unused aio_run_iocbs()
Date: Mon, 31 Jul 2006 15:12:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[AIO] remove unused aio_run_iocbs()

Nothing is calling the aio_run_iocbs() variant of *aio_run_*iocb*().  Let's try
and make life just a little less complicated by getting rid of it.

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 fs/aio.c |   21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

Index: 2.6.18-rc3-trivialaio/fs/aio.c
===================================================================
--- 2.6.18-rc3-trivialaio.orig/fs/aio.c
+++ 2.6.18-rc3-trivialaio/fs/aio.c
@@ -814,30 +814,13 @@ static void aio_queue_work(struct kioctx
 	queue_delayed_work(aio_wq, &ctx->wq, timeout);
 }
 
-
 /*
- * aio_run_iocbs:
+ * aio_run_all_iocbs:
  * 	Process all pending retries queued on the ioctx
- * 	run list.
+ * 	run list.  It will retry until the list stays empty.
  * Assumes it is operating within the aio issuer's mm
  * context.
  */
-static inline void aio_run_iocbs(struct kioctx *ctx)
-{
-	int requeue;
-
-	spin_lock_irq(&ctx->ctx_lock);
-
-	requeue = __aio_run_iocbs(ctx);
-	spin_unlock_irq(&ctx->ctx_lock);
-	if (requeue)
-		aio_queue_work(ctx);
-}
-
-/*
- * just like aio_run_iocbs, but keeps running them until
- * the list stays empty
- */
 static inline void aio_run_all_iocbs(struct kioctx *ctx)
 {
 	spin_lock_irq(&ctx->ctx_lock);
