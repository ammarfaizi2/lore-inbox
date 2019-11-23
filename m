Return-Path: <SRS0=JfP8=ZP=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A428C432C0
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 22:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002A120706
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 22:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcpcAqCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKWWuR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 23 Nov 2019 17:50:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38639 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfKWWuR (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 23 Nov 2019 17:50:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so12927858wro.5
        for <io-uring@vger.kernel.org>; Sat, 23 Nov 2019 14:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qB5U9QK8IFWliKpOTyjb5xqvh6hw4LKNN50FWFFmUW8=;
        b=lcpcAqCcIee157okYQ+NRIikf5rdFlo5FAFFLjDjRGRFhtbRECTdJjFiZ+kkGH7Ok5
         NiG5bJjaZ5TB98h1TDQ/Q7TRZ9jMm7LcG7Q5B4s9rzyixy6vpGwwNil6VnjoeTcDckCU
         8GxzX6LHfs/PgJU/XeT1R+sjtKPORw9JyUnXG2v5vJvf7CCfby4ppxHNjcL4FhpjdXg/
         uUWtcGPZ4pSQ8kM5V2mH8KUdYoYAsK+IBHL1eGrib+XwhxJLkC7gqtUZoZ0APdQfd68K
         828jKfDOh0HtgJ7xcqIfZQeAbAD4SNLc7X0cShhT/FBR64UrvFzgFblTPmPO9LKB3dcd
         al8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qB5U9QK8IFWliKpOTyjb5xqvh6hw4LKNN50FWFFmUW8=;
        b=nU8EuGgUk5KXalBQnWwkebQ4qSlbdwn0zVKnNZbM6HwEj705WbG4F18TBaaqdy8zW4
         s1HlCe2549GJvq1/ikhtohPwYtqZlqw62dSxmSttL7DERHEbtEI/57ZSFH9o7zzu+AYe
         JDZz+Z+B5EQD/qk1U7FAQ2N15Cd+odz9RegSxrvBIaxUNQqpr5BjtxfdxMaTiUELURQ0
         jhW+qnmDwVgGZMW9+L8e7WU9XXn9undoiUePIKay03eib0mvKbWNKwBwuKcyVNtZE6BY
         oVviUmUvE/k4fm1VZ0HAZdi3OBK4F/lQEO1DHWifkryF9s/D6ji6dBRPgH5Ev5jB1xss
         meMg==
X-Gm-Message-State: APjAAAV9v+X1aRBCVWW+9xGVNHjXOqFM0wzEZ0aqeCLkHR/fZ85+7U0Y
        a2rKKmrACNzivwN0EoqP4YVWb0LO
X-Google-Smtp-Source: APXvYqz+3NrXC1+daKbklh2QB4EdF07lkbhCzM32nq0trzmROv47yaUc0Y79qXy2xoAg3wTj4aqa4g==
X-Received: by 2002:adf:f987:: with SMTP id f7mr24101760wrr.284.1574549413816;
        Sat, 23 Nov 2019 14:50:13 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id l10sm4110745wrg.90.2019.11.23.14.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 14:50:13 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 2/2] io_uring: fix linked fixed !iter rw
Date:   Sun, 24 Nov 2019 01:49:44 +0300
Message-Id: <b3c25be83a015fd511bb84857af1eb8babf0a864.1574549055.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574549055.git.asml.silence@gmail.com>
References: <cover.1574549055.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

As loop_rw_iter() may need mm even for fixed requests, update
io_req_needs_user(), so the offloading thread and io-wq can handle it as
well.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 566e987c6dab..d84b69872967 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -525,12 +525,13 @@ static void __io_commit_cqring(struct io_ring_ctx *ctx)
 	}
 }
 
-static inline bool io_sqe_needs_user(const struct io_uring_sqe *sqe)
+static inline bool io_req_needs_user(struct io_kiocb *req)
 {
-	u8 opcode = READ_ONCE(sqe->opcode);
+	struct file *f = req->file;
+	u8 opcode = READ_ONCE(req->submit.sqe->opcode);
 
-	return !(opcode == IORING_OP_READ_FIXED ||
-		 opcode == IORING_OP_WRITE_FIXED);
+	return !((opcode == IORING_OP_READ_FIXED && f->f_op->read_iter) ||
+		(opcode == IORING_OP_WRITE_FIXED && f->f_op->write_iter));
 }
 
 static inline bool io_prep_async_work(struct io_kiocb *req,
@@ -559,7 +560,7 @@ static inline bool io_prep_async_work(struct io_kiocb *req,
 				req->work.flags |= IO_WQ_WORK_UNBOUND;
 			break;
 		}
-		if (io_sqe_needs_user(req->submit.sqe))
+		if (io_req_needs_user(req))
 			req->work.flags |= IO_WQ_WORK_NEEDS_USER;
 	}
 
@@ -1625,11 +1626,11 @@ static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
 		struct iovec iovec;
 		ssize_t nr;
 
-		if (iter_is_iovec(&iter->it)) {
-			iovec = iov_iter_iovec(&iter->it);
-		} else {
+		if (iov_iter_is_bvec(&iter->it)) {
 			iovec.iov_base = (void __user *)iter->ubuf;
 			iovec.iov_len = iov_iter_count(&iter->it);
+		} else {
+			iovec = iov_iter_iovec(&iter->it);
 		}
 
 		if (rw == READ) {
@@ -3041,14 +3042,6 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 		goto err_req;
 	}
 
-	ret = io_req_set_file(state, req);
-	if (unlikely(ret)) {
-err_req:
-		io_cqring_add_event(req, ret);
-		io_double_put_req(req);
-		return;
-	}
-
 	/*
 	 * If we already have a head request, queue this one for async
 	 * submittal once the head completes. If we don't have a head but
@@ -3092,6 +3085,11 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 	} else {
 		io_queue_sqe(req);
 	}
+
+	return;
+err_req:
+	io_cqring_add_event(req, ret);
+	io_double_put_req(req);
 }
 
 /*
@@ -3197,6 +3195,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	for (i = 0; i < nr; i++) {
 		struct io_kiocb *req;
 		unsigned int sqe_flags;
+		int ret;
 
 		req = io_get_req(ctx, statep);
 		if (unlikely(!req)) {
@@ -3209,7 +3208,14 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 			break;
 		}
 
-		if (io_sqe_needs_user(req->submit.sqe) && !*mm) {
+		ret = io_req_set_file(statep, req);
+		if (unlikely(ret)) {
+			io_cqring_add_event(req, ret);
+			__io_free_req(req);
+			break;
+		}
+
+		if (io_req_needs_user(req) && !*mm) {
 			mm_fault = mm_fault || !mmget_not_zero(ctx->sqo_mm);
 			if (!mm_fault) {
 				use_mm(ctx->sqo_mm);
@@ -3217,6 +3223,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 			}
 		}
 
+
 		sqe_flags = req->submit.sqe->flags;
 
 		req->submit.ring_file = ring_file;
-- 
2.24.0

