Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D367C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 08:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E819E20855
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 08:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb9ZmaE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfKUIzI (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:55:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53908 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUIzI (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 03:55:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id u18so2774799wmc.3
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 00:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eE0kHtbU0qnrwtoAFWn3xpQ8VUTXp4rmY9Royu3gnw8=;
        b=jb9ZmaE3dkweJuCksIsGGLlso+/O8P0qUZBIKezDLsDarCeWb7j/Snl5A9U9g1QLNK
         8MFmEroEDwx7kJxUXXaSG+bxUj1hZxLBJ57KcZ3o6aElODA1a/4fbUFJ312ru+DfacMy
         OpUTgk3hfrM3jljVmryjWY4rwxuDgfIhRg/CH55tWGUQItjg/nWsEWqjQlpvHabJCzOt
         tATBykwyqA1E/XrZrjLQ/ci99IKjQs+gCFe8HJYh5x3WUv4NrsFdne2v7rRzvihUyrjs
         LVFE/q20HW/SSK9q5zuT9zJrQJkavQfy8J7rMhMoZqbRTMSsWf7m2yeMzqE5oa/W74am
         RHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eE0kHtbU0qnrwtoAFWn3xpQ8VUTXp4rmY9Royu3gnw8=;
        b=Sa0FaqBJ5PbTCFvpxz8dQTDBCJFwYQUthwi0owGw3NGeOtBLcb/K37CuNEkQyIxceu
         BJ4gcyD3veideZzFlA2gDtW70gkm0kudtBgAHf6j9kPtSDadKLhXjt2nIjaYv2Q5W/3o
         b1g7wJPf2ELrMztr7xEclSoktZ4qP4+Ys8jpNNuyk5BNbLiav2+zd8VAV8YUDxoFVzCU
         O/hdJn2ROgUUCxJ42pXNcaXN3mPLvpDNMRiefu1ZOESYhR5+/ib7yMYQVZQCOQoh8IwE
         dMS0yoRJWwoQv8RnnFP9qTGVfEb/9+FqbcAC4yDsgeDJceLoLCp/9FDPzFfElIXZY+C2
         nZNg==
X-Gm-Message-State: APjAAAX7wk7AgFhDzISNXPjyE3s/PWX06E1pvPueBtEsdv03nJgkw4tH
        oQqFa2aWIr61wtsm0tFxVmk82mXp
X-Google-Smtp-Source: APXvYqxxyIn7vjkhinfvSVl8gex8PiyLKola4/XqZq9EScC/yY1e/h8cTdPzcIhJXBbkLG3kw7izGA==
X-Received: by 2002:a1c:9646:: with SMTP id y67mr8286607wmd.79.1574326505115;
        Thu, 21 Nov 2019 00:55:05 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id u187sm2259860wme.15.2019.11.21.00.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 00:55:03 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        iuyun01@kylinos.cn
Subject: [PATCH] io_uring: drain next sqe instead of shadowing
Date:   Thu, 21 Nov 2019 11:54:28 +0300
Message-Id: <5e8a8176e29a61ec79004521bc2ef28e4d9715b1.1574325863.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <2005c339-5ed3-6c2e-f011-5bc89dac3f5c@kernel.dk>
References: <2005c339-5ed3-6c2e-f011-5bc89dac3f5c@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

If there is a DRAIN in the middle of a link, it uses shadow req. Defer
the next request/link instead. This:

Pros:
1. removes semi-duplicated code
2. doesn't allocate memory for shadows
3. works better if only the head marked for drain
4. doesn't need complex synchronisation

Cons:
1. removes shadow->seq = last_draind_in_link->seq optimisation
It shouldn't be a common case, and can be added back

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

---
Hmm... How about to go in another way and just remove this shadow
requests? I think this patch makes things easier.


 fs/io_uring.c | 86 +++++++++++----------------------------------------
 1 file changed, 18 insertions(+), 68 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6175e2e195c0..dd220f415c39 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -186,6 +186,7 @@ struct io_ring_ctx {
 		bool			compat;
 		bool			account_mem;
 		bool			cq_overflow_flushed;
+		bool			drain_next;
 
 		/*
 		 * Ring buffer of indices into array of io_uring_sqe, which is
@@ -346,7 +347,7 @@ struct io_kiocb {
 #define REQ_F_LINK		64	/* linked sqes */
 #define REQ_F_LINK_TIMEOUT	128	/* has linked timeout */
 #define REQ_F_FAIL_LINK		256	/* fail rest of links */
-#define REQ_F_SHADOW_DRAIN	512	/* link-drain shadow req */
+#define REQ_F_DRAIN_LINK	512	/* link should be fully drained */
 #define REQ_F_TIMEOUT		1024	/* timeout request */
 #define REQ_F_ISREG		2048	/* regular file */
 #define REQ_F_MUST_PUNT		4096	/* must be punted even for NONBLOCK */
@@ -615,11 +616,6 @@ static void io_commit_cqring(struct io_ring_ctx *ctx)
 	__io_commit_cqring(ctx);
 
 	while ((req = io_get_deferred_req(ctx)) != NULL) {
-		if (req->flags & REQ_F_SHADOW_DRAIN) {
-			/* Just for drain, free it. */
-			__io_free_req(req);
-			continue;
-		}
 		req->flags |= REQ_F_IO_DRAINED;
 		io_queue_async_work(req);
 	}
@@ -2956,6 +2952,12 @@ static void io_queue_sqe(struct io_kiocb *req)
 {
 	int ret;
 
+	if (unlikely(req->ctx->drain_next)) {
+		req->flags |= REQ_F_IO_DRAIN;
+		req->ctx->drain_next = false;
+	}
+	req->ctx->drain_next = (req->flags & REQ_F_DRAIN_LINK);
+
 	ret = io_req_defer(req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
@@ -2968,57 +2970,16 @@ static void io_queue_sqe(struct io_kiocb *req)
 		__io_queue_sqe(req);
 }
 
-static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
+static inline void io_queue_link_head(struct io_kiocb *req)
 {
-	int ret;
-	int need_submit = false;
-	struct io_ring_ctx *ctx = req->ctx;
-
 	if (unlikely(req->flags & REQ_F_FAIL_LINK)) {
-		ret = -ECANCELED;
-		goto err;
-	}
-	if (!shadow) {
+		io_cqring_add_event(req, -ECANCELED);
+		io_double_put_req(req);
+	} else
 		io_queue_sqe(req);
-		return;
-	}
-
-	/*
-	 * Mark the first IO in link list as DRAIN, let all the following
-	 * IOs enter the defer list. all IO needs to be completed before link
-	 * list.
-	 */
-	req->flags |= REQ_F_IO_DRAIN;
-	ret = io_req_defer(req);
-	if (ret) {
-		if (ret != -EIOCBQUEUED) {
-err:
-			io_cqring_add_event(req, ret);
-			if (req->flags & REQ_F_LINK)
-				req->flags |= REQ_F_FAIL_LINK;
-			io_double_put_req(req);
-			if (shadow)
-				__io_free_req(shadow);
-			return;
-		}
-	} else {
-		/*
-		 * If ret == 0 means that all IOs in front of link io are
-		 * running done. let's queue link head.
-		 */
-		need_submit = true;
-	}
-
-	/* Insert shadow req to defer_list, blocking next IOs */
-	spin_lock_irq(&ctx->completion_lock);
-	trace_io_uring_defer(ctx, shadow, true);
-	list_add_tail(&shadow->list, &ctx->defer_list);
-	spin_unlock_irq(&ctx->completion_lock);
-
-	if (need_submit)
-		__io_queue_sqe(req);
 }
 
+
 #define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK)
 
 static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
@@ -3055,6 +3016,9 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 		struct io_kiocb *prev = *link;
 		struct io_uring_sqe *sqe_copy;
 
+		if (s->sqe->flags & IOSQE_IO_DRAIN)
+			(*link)->flags |= REQ_F_DRAIN_LINK | REQ_F_IO_DRAIN;
+
 		if (READ_ONCE(s->sqe->opcode) == IORING_OP_LINK_TIMEOUT) {
 			ret = io_timeout_setup(req);
 			/* common setup allows offset being set, we don't */
@@ -3173,7 +3137,6 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 {
 	struct io_submit_state state, *statep = NULL;
 	struct io_kiocb *link = NULL;
-	struct io_kiocb *shadow_req = NULL;
 	int i, submitted = 0;
 	bool mm_fault = false;
 
@@ -3212,18 +3175,6 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 
 		sqe_flags = req->submit.sqe->flags;
 
-		if (link && (sqe_flags & IOSQE_IO_DRAIN)) {
-			if (!shadow_req) {
-				shadow_req = io_get_req(ctx, NULL);
-				if (unlikely(!shadow_req))
-					goto out;
-				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
-				refcount_dec(&shadow_req->refs);
-			}
-			shadow_req->sequence = req->submit.sequence;
-		}
-
-out:
 		req->submit.ring_file = ring_file;
 		req->submit.ring_fd = ring_fd;
 		req->submit.has_user = *mm != NULL;
@@ -3239,14 +3190,13 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		 * that's the end of the chain. Submit the previous link.
 		 */
 		if (!(sqe_flags & IOSQE_IO_LINK) && link) {
-			io_queue_link_head(link, shadow_req);
+			io_queue_link_head(link);
 			link = NULL;
-			shadow_req = NULL;
 		}
 	}
 
 	if (link)
-		io_queue_link_head(link, shadow_req);
+		io_queue_link_head(link);
 	if (statep)
 		io_submit_state_end(&state);
 
-- 
2.24.0

