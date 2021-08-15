Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BD7C4338F
	for <io-uring@archiver.kernel.org>; Sun, 15 Aug 2021 09:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D7561042
	for <io-uring@archiver.kernel.org>; Sun, 15 Aug 2021 09:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbhHOJlj (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 15 Aug 2021 05:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhHOJli (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 15 Aug 2021 05:41:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF33C061764
        for <io-uring@vger.kernel.org>; Sun, 15 Aug 2021 02:41:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso12741142wmq.3
        for <io-uring@vger.kernel.org>; Sun, 15 Aug 2021 02:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IBhp/60Ij7oAT+C45bQy8DLuvnGEA0O5hOjBF91b3do=;
        b=Ep+n8OLJfQxBQL4IbVImsWbdcrxGIthoPGiBWDgc927WTbnkN6HcVNlj9px2XcIPK7
         dkbeGutX4Xc75cVxar9GE+NzMiF03oAo7aGFko+lvh399UXtSlkbE6fvl8nTTtojtvtt
         vt9gnAJ4Y30u/qVwVIfbhpVG5Nwd5LNrr6QB0ViXaTs2bhoCQbFryi8pV3vneWv30Bgr
         mXEpRAmLB33WSz21ZepY/mEX/DhBjujZrtF3TWIdI6oKSRrBDS2EuvA+xYaeC+UU10Ed
         3KTFQK3EF9JjAA1WKSQlMoPxK4lZJSH3VUS5GCCRkXA/iGH8YZmMAB+7H0a7PbxvAEYn
         xYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBhp/60Ij7oAT+C45bQy8DLuvnGEA0O5hOjBF91b3do=;
        b=P84ASTG5G3eCNAlO5b3YaMv/wWKmAqJR8XNW+O4W7FVrtJvzJnoj75YGnnMLVXtsnN
         8ExlVecjdEuoWOur87dJZjkQWkT7b0lQDiWeuzPucaFdpOZUTv3jBnqABJ9tHliDo99Q
         jyQ4LU/2b1zPMd5bknyIaioLiigaBGvkYyaTdW2TPTJICMMVcMtASpN0s3/iF6WslBXi
         yNyGU2wUu1ZAYRp0GwQwLF33QWP0LU16WWIVrXBmqYtDyf05LHZCsVTUtaSarT8CUoKs
         /0YhS3WnN+i007u2CM69+yDIyyhjANpCpn7jVdPCTMsnx7+oBjTK0PtvOGH6jv0sSV6l
         V50g==
X-Gm-Message-State: AOAM53141sU2nbSc2Um4pwP1SUmehxM18ZtQLuL7RZCeNTiYYoT+D+Sd
        Mk68+n3SPm8Vn1XLo0nrBv4=
X-Google-Smtp-Source: ABdhPJwvdb5Q7b0MaHMKe4+SVGzin9FC/7T7TzskqAbSduhEavNLM0QlHM+umFEX9zgDwmhYuoIDrQ==
X-Received: by 2002:a1c:c918:: with SMTP id f24mr10243311wmb.92.1629020467465;
        Sun, 15 Aug 2021 02:41:07 -0700 (PDT)
Received: from localhost.localdomain ([148.252.133.97])
        by smtp.gmail.com with ESMTPSA id t8sm8828815wrx.27.2021.08.15.02.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 02:41:07 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH v2 5/9] io_uring: deduplicate cancellation code
Date:   Sun, 15 Aug 2021 10:40:22 +0100
Message-Id: <900122b588e65b637e71bfec80a260726c6a54d6.1628981736.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628981736.git.asml.silence@gmail.com>
References: <cover.1628981736.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

IORING_OP_ASYNC_CANCEL and IORING_OP_LINK_TIMEOUT have enough of
overlap, so extract a helper for request cancellation and use in both.
Also, removes some amount of ugliness because of success_ret.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index fb3b07c0f15a..a0d081dca389 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5790,32 +5790,24 @@ static int io_async_cancel_one(struct io_uring_task *tctx, u64 user_data,
 	return ret;
 }
 
-static void io_async_find_and_cancel(struct io_ring_ctx *ctx,
-				     struct io_kiocb *req, __u64 sqe_addr,
-				     int success_ret)
+static int io_try_cancel_userdata(struct io_kiocb *req, u64 sqe_addr)
+	__acquires(&req->ctx->completion_lock)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
 
+	WARN_ON_ONCE(req->task != current);
+
 	ret = io_async_cancel_one(req->task->io_uring, sqe_addr, ctx);
 	spin_lock(&ctx->completion_lock);
 	if (ret != -ENOENT)
-		goto done;
+		return ret;
 	spin_lock_irq(&ctx->timeout_lock);
 	ret = io_timeout_cancel(ctx, sqe_addr);
 	spin_unlock_irq(&ctx->timeout_lock);
 	if (ret != -ENOENT)
-		goto done;
-	ret = io_poll_cancel(ctx, sqe_addr, false);
-done:
-	if (!ret)
-		ret = success_ret;
-	io_cqring_fill_event(ctx, req->user_data, ret, 0);
-	io_commit_cqring(ctx);
-	spin_unlock(&ctx->completion_lock);
-	io_cqring_ev_posted(ctx);
-
-	if (ret < 0)
-		req_set_fail(req);
+		return ret;
+	return io_poll_cancel(ctx, sqe_addr, false);
 }
 
 static int io_async_cancel_prep(struct io_kiocb *req,
@@ -5839,17 +5831,7 @@ static int io_async_cancel(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_tctx_node *node;
 	int ret;
 
-	/* tasks should wait for their io-wq threads, so safe w/o sync */
-	ret = io_async_cancel_one(req->task->io_uring, sqe_addr, ctx);
-	spin_lock(&ctx->completion_lock);
-	if (ret != -ENOENT)
-		goto done;
-	spin_lock_irq(&ctx->timeout_lock);
-	ret = io_timeout_cancel(ctx, sqe_addr);
-	spin_unlock_irq(&ctx->timeout_lock);
-	if (ret != -ENOENT)
-		goto done;
-	ret = io_poll_cancel(ctx, sqe_addr, false);
+	ret = io_try_cancel_userdata(req, sqe_addr);
 	if (ret != -ENOENT)
 		goto done;
 	spin_unlock(&ctx->completion_lock);
@@ -6416,9 +6398,17 @@ static void io_req_task_link_timeout(struct io_kiocb *req)
 {
 	struct io_kiocb *prev = req->timeout.prev;
 	struct io_ring_ctx *ctx = req->ctx;
+	int ret;
 
 	if (prev) {
-		io_async_find_and_cancel(ctx, req, prev->user_data, -ETIME);
+		ret = io_try_cancel_userdata(req, prev->user_data);
+		if (!ret)
+			ret = -ETIME;
+		io_cqring_fill_event(ctx, req->user_data, ret, 0);
+		io_commit_cqring(ctx);
+		spin_unlock(&ctx->completion_lock);
+		io_cqring_ev_posted(ctx);
+
 		io_put_req(prev);
 		io_put_req(req);
 	} else {
-- 
2.32.0

