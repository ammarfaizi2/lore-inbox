Return-Path: <SRS0=jlnN=ZZ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7798C43215
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 02:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFE6206E1
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 02:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ewhS/Yzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfLCCy4 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:54:56 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38524 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfLCCy4 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 2 Dec 2019 21:54:56 -0500
Received: by mail-pj1-f68.google.com with SMTP id l4so859577pjt.5
        for <io-uring@vger.kernel.org>; Mon, 02 Dec 2019 18:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G3ZNEqiC4qwbeSxGDEp01+81zuRqbv5d+UMn+1E9uCQ=;
        b=ewhS/YzybyAzxIQS0PRBFktFUzefxZEcUYlZ/OlKpBpS5aYefbmrndhvxhk+Gtbb26
         ftjlGpVUnlKy9at1DrjVhW2M21Zq6a6ro2cXSPgJd4UMQkGRhERY0fRMQdAtSJYKlzsl
         wYIW/nsy3HGWkqQ3ckR6qd3ihzMVsqeeMiCV+i4EQzR5F95Bxr6+6f27HmTgifRfystC
         BtYssOrCVoK7H3NfgAEykttUA8cfJKk5RTkui+dyeaROMaXrxJrN5vke9iOq+uLDFw5p
         nCODwdsKGoqS/vuEfCl7NKQ4iyG9n51doqk54uMnNgDtdy7W6/65FW+IcvnU8WYU1TFy
         syOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G3ZNEqiC4qwbeSxGDEp01+81zuRqbv5d+UMn+1E9uCQ=;
        b=JKAFBKISgI+fge9gf1vR+EUVAvrDEQ4uMj+8FEQSMUfHThu1YdQ9PeQ/aSnCFVvHf8
         2Ogv2laNWAAKiM8JkOnVLX2IqGxUPQyY5+n7PtIgxIzpw451D3YploxRZ8H6wHStHxwu
         AiaGJJ6l//wb+LnFPgEVaxPlZOI4mjA/RvXwWd89liM4TDkxEOIHfRNwSVXxocG/zxqX
         sQYXw2y1gBwitiAUjCzlYWQyhGKv2MEjjCDEmur02gz1omtABkqll1iQnN+pCDWNJQmP
         cKe9erT8aapvKTRJ2QKFOiN7MA8kPanqPF4f9rjjAKnzXdtNUuhhN/igjHMoVOsOLR9B
         OAxQ==
X-Gm-Message-State: APjAAAXeM2e2eXhGKbTdBREgKqpsmU9i2FcqngVAARd4Xn3BXsfonyRD
        vhI9JE0qVc6VV00Ym8BFMid8pMy2Adx3eA==
X-Google-Smtp-Source: APXvYqxlFBzVRjyHMRFEw1/cQ5CSEARl7/VFDYsPIP3BMm8q5f/3jd3kRi0ZrnpfsqDfEh1psSuanQ==
X-Received: by 2002:a17:902:12c:: with SMTP id 41mr2749780plb.224.1575341694615;
        Mon, 02 Dec 2019 18:54:54 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z7sm959364pfk.41.2019.12.02.18.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 18:54:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     netdev@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] io_uring: add general async offload context
Date:   Mon,  2 Dec 2019 19:54:40 -0700
Message-Id: <20191203025444.29344-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203025444.29344-1-axboe@kernel.dk>
References: <20191203025444.29344-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Right now we just copy the sqe for async offload, but we want to store
more context across an async punt. In preparation for doing so, put the
sqe copy inside a structure that we can expand. With this pointer added,
we can get rid of REQ_F_FREE_SQE, as that is now indicated by whether
req->io is NULL or not.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 56 +++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a91743e1fa2c..bbbd9f664b1e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -308,6 +308,10 @@ struct io_timeout {
 	struct io_timeout_data		*data;
 };
 
+struct io_async_ctx {
+	struct io_uring_sqe		sqe;
+};
+
 /*
  * NOTE! Each of the iocb union members has the file pointer
  * as the first entry in their struct definition. So you can
@@ -323,6 +327,7 @@ struct io_kiocb {
 	};
 
 	const struct io_uring_sqe	*sqe;
+	struct io_async_ctx		*io;
 	struct file			*ring_file;
 	int				ring_fd;
 	bool				has_user;
@@ -353,7 +358,6 @@ struct io_kiocb {
 #define REQ_F_TIMEOUT_NOSEQ	8192	/* no timeout sequence */
 #define REQ_F_INFLIGHT		16384	/* on inflight list */
 #define REQ_F_COMP_LOCKED	32768	/* completion under lock */
-#define REQ_F_FREE_SQE		65536	/* free sqe if not async queued */
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -806,6 +810,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	}
 
 got_it:
+	req->io = NULL;
 	req->ring_file = NULL;
 	req->file = NULL;
 	req->ctx = ctx;
@@ -836,8 +841,8 @@ static void __io_free_req(struct io_kiocb *req)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 
-	if (req->flags & REQ_F_FREE_SQE)
-		kfree(req->sqe);
+	if (req->io)
+		kfree(req->io);
 	if (req->file && !(req->flags & REQ_F_FIXED_FILE))
 		fput(req->file);
 	if (req->flags & REQ_F_INFLIGHT) {
@@ -1079,9 +1084,9 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			 * completions for those, only batch free for fixed
 			 * file and non-linked commands.
 			 */
-			if (((req->flags &
-				(REQ_F_FIXED_FILE|REQ_F_LINK|REQ_F_FREE_SQE)) ==
-			    REQ_F_FIXED_FILE) && !io_is_fallback_req(req)) {
+			if (((req->flags & (REQ_F_FIXED_FILE|REQ_F_LINK)) ==
+			    REQ_F_FIXED_FILE) && !io_is_fallback_req(req) &&
+			    !req->io) {
 				reqs[to_free++] = req;
 				if (to_free == ARRAY_SIZE(reqs))
 					io_free_req_many(ctx, reqs, &to_free);
@@ -2259,7 +2264,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (!poll->wait)
 		return -ENOMEM;
 
-	req->sqe = NULL;
+	req->io = NULL;
 	INIT_IO_WORK(&req->work, io_poll_complete_work);
 	events = READ_ONCE(sqe->poll_events);
 	poll->events = demangle_poll(events) | EPOLLERR | EPOLLHUP;
@@ -2602,27 +2607,27 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 static int io_req_defer(struct io_kiocb *req)
 {
-	struct io_uring_sqe *sqe_copy;
 	struct io_ring_ctx *ctx = req->ctx;
+	struct io_async_ctx *io;
 
 	/* Still need defer if there is pending req in defer list. */
 	if (!req_need_defer(req) && list_empty(&ctx->defer_list))
 		return 0;
 
-	sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);
-	if (!sqe_copy)
+	io = kmalloc(sizeof(*io), GFP_KERNEL);
+	if (!io)
 		return -EAGAIN;
 
 	spin_lock_irq(&ctx->completion_lock);
 	if (!req_need_defer(req) && list_empty(&ctx->defer_list)) {
 		spin_unlock_irq(&ctx->completion_lock);
-		kfree(sqe_copy);
+		kfree(io);
 		return 0;
 	}
 
-	memcpy(sqe_copy, req->sqe, sizeof(*sqe_copy));
-	req->flags |= REQ_F_FREE_SQE;
-	req->sqe = sqe_copy;
+	memcpy(&io->sqe, req->sqe, sizeof(io->sqe));
+	req->sqe = &io->sqe;
+	req->io = io;
 
 	trace_io_uring_defer(ctx, req, req->user_data);
 	list_add_tail(&req->list, &ctx->defer_list);
@@ -2955,14 +2960,16 @@ static void __io_queue_sqe(struct io_kiocb *req)
 	 */
 	if (ret == -EAGAIN && (!(req->flags & REQ_F_NOWAIT) ||
 	    (req->flags & REQ_F_MUST_PUNT))) {
-		struct io_uring_sqe *sqe_copy;
+		struct io_async_ctx *io;
 
-		sqe_copy = kmemdup(req->sqe, sizeof(*sqe_copy), GFP_KERNEL);
-		if (!sqe_copy)
+		io = kmalloc(sizeof(*io), GFP_KERNEL);
+		if (!io)
 			goto err;
 
-		req->sqe = sqe_copy;
-		req->flags |= REQ_F_FREE_SQE;
+		memcpy(&io->sqe, req->sqe, sizeof(io->sqe));
+
+		req->sqe = &io->sqe;
+		req->io = io;
 
 		if (req->work.flags & IO_WQ_WORK_NEEDS_FILES) {
 			ret = io_grab_files(req);
@@ -3063,7 +3070,7 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 	 */
 	if (*link) {
 		struct io_kiocb *prev = *link;
-		struct io_uring_sqe *sqe_copy;
+		struct io_async_ctx *io;
 
 		if (req->sqe->flags & IOSQE_IO_DRAIN)
 			(*link)->flags |= REQ_F_DRAIN_LINK | REQ_F_IO_DRAIN;
@@ -3079,14 +3086,15 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 			}
 		}
 
-		sqe_copy = kmemdup(req->sqe, sizeof(*sqe_copy), GFP_KERNEL);
-		if (!sqe_copy) {
+		io = kmalloc(sizeof(*io), GFP_KERNEL);
+		if (!io) {
 			ret = -EAGAIN;
 			goto err_req;
 		}
 
-		req->sqe = sqe_copy;
-		req->flags |= REQ_F_FREE_SQE;
+		memcpy(&io->sqe, req->sqe, sizeof(io->sqe));
+		req->sqe = &io->sqe;
+		req->io = io;
 		trace_io_uring_link(ctx, req, prev);
 		list_add_tail(&req->list, &prev->link_list);
 	} else if (req->sqe->flags & IOSQE_IO_LINK) {
-- 
2.24.0

