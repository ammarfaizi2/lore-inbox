Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263179AbUJ2AT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbUJ2AT7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbUJ2AT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:19:56 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50693 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263153AbUJ2ANx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:13:53 -0400
Date: Fri, 29 Oct 2004 02:13:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: bcrl@redhat.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] aio: remove an unused function
Message-ID: <20041029001319.GA29142@stusta.de>
References: <20041028220659.GG3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028220659.GG3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a signature... ]

The patch below removes an unsed function from fs/aio.c


diffstat output:
 fs/aio.c |   18 +-----------------
 1 files changed, 1 insertion(+), 17 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/fs/aio.c.old	2004-10-28 22:36:18.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/fs/aio.c	2004-10-28 22:39:38.000000000 +0200
@@ -816,27 +816,11 @@
 
 
 /*
- * aio_run_iocbs:
  * 	Process all pending retries queued on the ioctx
  * 	run list.
  * Assumes it is operating within the aio issuer's mm
  * context.
- */
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
+ * It keeps running them until the list stays empty.
  */
 static inline void aio_run_all_iocbs(struct kioctx *ctx)
 {
