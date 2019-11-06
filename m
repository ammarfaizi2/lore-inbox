Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B0FC6195
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D6F2166E
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kbs9K218"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfKFWlq (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:41:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45416 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfKFWlq (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 17:41:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id h3so496832wrx.12;
        Wed, 06 Nov 2019 14:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jwjfQFNjybCwXyKlJJfea7OwtJQZMOzZX8AfBr361mw=;
        b=Kbs9K2180U+uXqjgO7CEhCf9LhwdP+iOLxPfyKIrI3KLss2wv4YkQ8/oUKzC6a0R0m
         Ku5fZ+xIPpqug81sfe7ribyCFy4AaU+I7XIhOYurOdo9C3TjNXQoOw18oF8g4uF+56B7
         6ragxiXtlDnKMBqMs/Rv/dvZp57eZPv7yEZjNC/ZwF5qqKCCLcQ1jbN52X3xO7GxieiL
         an1Tsu85YquBAb+/rHaKvwmBc6zviaP3DikCZKAJf6PKGCG16KIfi/4O9HOMuUpn7R35
         pXebp/UvDGq+ybQHmbGSwuDbuGLJLLORVqq9qZGrUUh5YeqqsjXm05k/fZAkfa8bunoR
         USEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwjfQFNjybCwXyKlJJfea7OwtJQZMOzZX8AfBr361mw=;
        b=XIvapjBIvo5fFjrumsMUzBSkmTOi1MN4iUNSlwvCMAApDdOPqLnWntJzphx57uz+xw
         36KEEwvzI2DGFGDvLPK/71hx8sv8GXoPOnqEWbu3xH7jjGIUMxA9jCtTZo4dq6BlPTJf
         6/9fFCSIqAhWFlN0Ru5EAqP/BA7yL8NUZ7JQOKiQ9QajjLZY1k0Ferkee+Ozp7pYQKUK
         1mMedIEpnjllHaRy20vWXaTZntDbXDV0Osogscct+7G6eu3tRuHn6w5Wvl/1ecKd6qpQ
         Fz1uw/f5mHkg1ZkVsOo7+S7LtLaodcVM37O//2UzkNrproLmlIRui50n0R8GpCAuw4qS
         bysg==
X-Gm-Message-State: APjAAAXjK+k+xcHq44AavDnxaEh1lmzelve0e6B1+Ri5K85VOMWBsncF
        /Gn6cetAQ2gYKu/onRTOFds=
X-Google-Smtp-Source: APXvYqxdF3iR+Kizw0t3sH9GBAl1oefDsmya+rAkgEIXnJM+9Ps6Edua745rv3yGZYF2RNqrMJH1DA==
X-Received: by 2002:adf:c409:: with SMTP id v9mr4872114wrf.41.1573080103522;
        Wed, 06 Nov 2019 14:41:43 -0800 (PST)
Received: from localhost.localdomain ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id h140sm23469wme.22.2019.11.06.14.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 14:41:43 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v3 1/3] io_uring: allocate io_kiocb upfront
Date:   Thu,  7 Nov 2019 01:41:06 +0300
Message-Id: <b787787e16af14f03df2ee1ac0d57b81b367cb4c.1573079844.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1573079844.git.asml.silence@gmail.com>
References: <cover.1573079844.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Let io_submit_sqes() to allocate io_kiocb before fetching an sqe.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6524898831e0..ceb616dbe710 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2551,30 +2551,23 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 
 #define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK)
 
-static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
-			  struct io_submit_state *state, struct io_kiocb **link)
+static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			  struct sqe_submit *s, struct io_submit_state *state,
+			  struct io_kiocb **link)
 {
 	struct io_uring_sqe *sqe_copy;
-	struct io_kiocb *req;
 	int ret;
 
 	/* enforce forwards compatibility on users */
 	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
 		ret = -EINVAL;
-		goto err;
-	}
-
-	req = io_get_req(ctx, state);
-	if (unlikely(!req)) {
-		ret = -EAGAIN;
-		goto err;
+		goto err_req;
 	}
 
 	ret = io_req_set_file(ctx, s, state, req);
 	if (unlikely(ret)) {
 err_req:
 		io_free_req(req, NULL);
-err:
 		io_cqring_add_event(ctx, s->sqe->user_data, ret);
 		return;
 	}
@@ -2710,9 +2703,15 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 
 	for (i = 0; i < nr; i++) {
 		struct sqe_submit s;
+		struct io_kiocb *req;
 
-		if (!io_get_sqring(ctx, &s))
+		req = io_get_req(ctx, statep);
+		if (unlikely(!req))
 			break;
+		if (!io_get_sqring(ctx, &s)) {
+			__io_free_req(req);
+			break;
+		}
 
 		if (io_sqe_needs_user(s.sqe) && !*mm) {
 			mm_fault = mm_fault || !mmget_not_zero(ctx->sqo_mm);
@@ -2740,7 +2739,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		s.in_async = async;
 		s.needs_fixed_file = async;
 		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, async);
-		io_submit_sqe(ctx, &s, statep, &link);
+		io_submit_sqe(ctx, req, &s, statep, &link);
 		submitted++;
 
 		/*
@@ -4009,6 +4008,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		cur_mm = ctx->sqo_mm;
 		submitted = io_submit_sqes(ctx, to_submit, f.file, fd,
 					   &cur_mm, false);
+		if (!submitted)
+			submitted = -EAGAIN;
 		mutex_unlock(&ctx->uring_lock);
 	}
 	if (flags & IORING_ENTER_GETEVENTS) {
-- 
2.23.0

