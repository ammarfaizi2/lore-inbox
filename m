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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00798C5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21972173E
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDzMRHEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfKFWBG (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:01:06 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:36279 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKFWBG (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 17:01:06 -0500
Received: by mail-wr1-f48.google.com with SMTP id r10so442253wrx.3;
        Wed, 06 Nov 2019 14:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lizohWRvM+sM050FRzytwDt0m05/lds/P23AL0/QNl4=;
        b=sDzMRHENusHp1frmTfL78UXSqixVC1EprDG9YRMhjzL3Q7IOzhmVCm1Tw2IPI4GDDg
         7Z7r2ElU4iULWJz4i6C8tmSU3lDyG+D/CC4/cZuOyAC+iCw9cV4tlXO3Ay0us05wmViN
         cy7REFCGoJeU0xfz7uSqIith0tRhdyWnFXRVaWQPzlLvtfP42AD/lORwpxhw6e5jl7dh
         CnIunothBsO+ce/OthWXWM8/o1El6GZTaiZ53l5T0mOZuU7b311pResf8PV39f2bUTsK
         oYYljRfWS3syPZikUc4sdUA3i8IrZUsWvb2DnaWdafZlzWtVAMTAriHEeuOvTFsJqQ0X
         Hu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lizohWRvM+sM050FRzytwDt0m05/lds/P23AL0/QNl4=;
        b=An1icfhGc6nFHfUL96sMzkMDqEN0f0fmzge8+y3DggZLBAnreh0pdN3Qrg2ra/SAqF
         izdaAigpAmqH0OmSI4wM3Tz0cRaKnDlgqBlESyLjVPNlw44oUqDutc4uW69pwBAGYgKv
         O5YEHIScDuuYbZswwfiBjVH8CbNQIMkpDu+QxU3Dwy41fWl7bOBKOTQyTxa7l+DO+VxX
         2M+y0V7IfUgmd3IJhctBS7MVjUBtKl0zpCkazfzLu1xZ8jLxEraidCW6MXpW5e6PVy/B
         05XtwQhAJFgF+VHALZlWA3+KOnog4b/YuCCtucI2BWe/LbHoxKv92Ptvj9LgP9jRtGIy
         xZkQ==
X-Gm-Message-State: APjAAAX5nMO7uKvbUJ00flJF/3FFJhO73CQscwz+WiA2Cw8RcnsJxzLq
        uNhc44hIXNj61xMoHyoP1HU=
X-Google-Smtp-Source: APXvYqyolHwbeZzkZcCPvT/NOl5PiLk/omdJ+lTCmyp6aNgjmFW/+CG9hFCZM5M95e206UWl2E8AZA==
X-Received: by 2002:adf:f685:: with SMTP id v5mr5004156wrp.246.1573077663148;
        Wed, 06 Nov 2019 14:01:03 -0800 (PST)
Received: from localhost.localdomain ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id c24sm62159wrb.27.2019.11.06.14.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 14:01:02 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v2 3/3] io_uring: use inlined struct sqe_submit
Date:   Thu,  7 Nov 2019 01:00:32 +0300
Message-Id: <1b1e5571b9fc0ad13fa4480a91671c348ee6be10.1573077364.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1573077364.git.asml.silence@gmail.com>
References: <cover.1573077364.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

req->submit is always up-to-date, use it directly

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 87 +++++++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 44 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f863304e451a..886b9cd96181 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1155,10 +1155,9 @@ static bool io_file_supports_async(struct file *file)
 	return false;
 }
 
-static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
-		      bool force_nonblock)
+static int io_prep_rw(struct io_kiocb *req, bool force_nonblock)
 {
-	const struct io_uring_sqe *sqe = s->sqe;
+	const struct io_uring_sqe *sqe = req->submit.sqe;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct kiocb *kiocb = &req->rw;
 	unsigned ioprio;
@@ -1406,8 +1405,8 @@ static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
 	return ret;
 }
 
-static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
-		   struct io_kiocb **nxt, bool force_nonblock)
+static int io_read(struct io_kiocb *req, struct io_kiocb **nxt,
+		   bool force_nonblock)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -1416,7 +1415,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	size_t iov_count;
 	ssize_t read_size, ret;
 
-	ret = io_prep_rw(req, s, force_nonblock);
+	ret = io_prep_rw(req, force_nonblock);
 	if (ret)
 		return ret;
 	file = kiocb->ki_filp;
@@ -1424,7 +1423,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	if (unlikely(!(file->f_mode & FMODE_READ)))
 		return -EBADF;
 
-	ret = io_import_iovec(req->ctx, READ, s, &iovec, &iter);
+	ret = io_import_iovec(req->ctx, READ, &req->submit, &iovec, &iter);
 	if (ret < 0)
 		return ret;
 
@@ -1456,7 +1455,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 			ret2 = -EAGAIN;
 		/* Catch -EAGAIN return for forced non-blocking submission */
 		if (!force_nonblock || ret2 != -EAGAIN)
-			kiocb_done(kiocb, ret2, nxt, s->in_async);
+			kiocb_done(kiocb, ret2, nxt, req->submit.in_async);
 		else
 			ret = -EAGAIN;
 	}
@@ -1464,8 +1463,8 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	return ret;
 }
 
-static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
-		    struct io_kiocb **nxt, bool force_nonblock)
+static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
+		    bool force_nonblock)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -1474,7 +1473,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	size_t iov_count;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, s, force_nonblock);
+	ret = io_prep_rw(req, force_nonblock);
 	if (ret)
 		return ret;
 
@@ -1482,7 +1481,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	if (unlikely(!(file->f_mode & FMODE_WRITE)))
 		return -EBADF;
 
-	ret = io_import_iovec(req->ctx, WRITE, s, &iovec, &iter);
+	ret = io_import_iovec(req->ctx, WRITE, &req->submit, &iovec, &iter);
 	if (ret < 0)
 		return ret;
 
@@ -1519,7 +1518,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 		else
 			ret2 = loop_rw_iter(WRITE, file, kiocb, &iter);
 		if (!force_nonblock || ret2 != -EAGAIN)
-			kiocb_done(kiocb, ret2, nxt, s->in_async);
+			kiocb_done(kiocb, ret2, nxt, req->submit.in_async);
 		else
 			ret = -EAGAIN;
 	}
@@ -2188,9 +2187,9 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	return 0;
 }
 
-static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			const struct io_uring_sqe *sqe)
+static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req)
 {
+	const struct io_uring_sqe *sqe = req->submit.sqe;
 	struct io_uring_sqe *sqe_copy;
 
 	if (!io_sequence_defer(ctx, req) && list_empty(&ctx->defer_list))
@@ -2217,10 +2216,10 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
 }
 
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			   const struct sqe_submit *s, struct io_kiocb **nxt,
-			   bool force_nonblock)
+			   struct io_kiocb **nxt, bool force_nonblock)
 {
 	int ret, opcode;
+	struct sqe_submit *s = &req->submit;
 
 	req->user_data = READ_ONCE(s->sqe->user_data);
 
@@ -2232,18 +2231,18 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_READV:
 		if (unlikely(s->sqe->buf_index))
 			return -EINVAL;
-		ret = io_read(req, s, nxt, force_nonblock);
+		ret = io_read(req, nxt, force_nonblock);
 		break;
 	case IORING_OP_WRITEV:
 		if (unlikely(s->sqe->buf_index))
 			return -EINVAL;
-		ret = io_write(req, s, nxt, force_nonblock);
+		ret = io_write(req, nxt, force_nonblock);
 		break;
 	case IORING_OP_READ_FIXED:
-		ret = io_read(req, s, nxt, force_nonblock);
+		ret = io_read(req, nxt, force_nonblock);
 		break;
 	case IORING_OP_WRITE_FIXED:
-		ret = io_write(req, s, nxt, force_nonblock);
+		ret = io_write(req, nxt, force_nonblock);
 		break;
 	case IORING_OP_FSYNC:
 		ret = io_fsync(req, s->sqe, nxt, force_nonblock);
@@ -2318,7 +2317,7 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 		s->has_user = (work->flags & IO_WQ_WORK_HAS_MM) != 0;
 		s->in_async = true;
 		do {
-			ret = __io_submit_sqe(ctx, req, s, &nxt, false);
+			ret = __io_submit_sqe(ctx, req, &nxt, false);
 			/*
 			 * We can get EAGAIN for polled IO even though we're
 			 * forcing a sync submission from here, since we can't
@@ -2372,9 +2371,10 @@ static inline struct file *io_file_from_index(struct io_ring_ctx *ctx,
 	return table->files[index & IORING_FILE_TABLE_MASK];
 }
 
-static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
+static int io_req_set_file(struct io_ring_ctx *ctx,
 			   struct io_submit_state *state, struct io_kiocb *req)
 {
+	struct sqe_submit *s = &req->submit;
 	unsigned flags;
 	int fd;
 
@@ -2438,12 +2438,11 @@ static int io_grab_files(struct io_ring_ctx *ctx, struct io_kiocb *req)
 	return ret;
 }
 
-static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			struct sqe_submit *s)
+static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 {
 	int ret;
 
-	ret = __io_submit_sqe(ctx, req, s, NULL, true);
+	ret = __io_submit_sqe(ctx, req, NULL, true);
 
 	/*
 	 * We async punt it if the file wasn't marked NOWAIT, or if the file
@@ -2451,6 +2450,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	 */
 	if (ret == -EAGAIN && (!(req->flags & REQ_F_NOWAIT) ||
 	    (req->flags & REQ_F_MUST_PUNT))) {
+		struct sqe_submit *s = &req->submit;
 		struct io_uring_sqe *sqe_copy;
 
 		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
@@ -2488,31 +2488,30 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	return ret;
 }
 
-static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			struct sqe_submit *s)
+static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 {
 	int ret;
 
-	ret = io_req_defer(ctx, req, s->sqe);
+	ret = io_req_defer(ctx, req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
+			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
 			io_free_req(req, NULL);
-			io_cqring_add_event(ctx, s->sqe->user_data, ret);
 		}
 		return 0;
 	}
 
-	return __io_queue_sqe(ctx, req, s);
+	return __io_queue_sqe(ctx, req);
 }
 
 static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			      struct sqe_submit *s, struct io_kiocb *shadow)
+			      struct io_kiocb *shadow)
 {
 	int ret;
 	int need_submit = false;
 
 	if (!shadow)
-		return io_queue_sqe(ctx, req, s);
+		return io_queue_sqe(ctx, req);
 
 	/*
 	 * Mark the first IO in link list as DRAIN, let all the following
@@ -2520,12 +2519,12 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	 * list.
 	 */
 	req->flags |= REQ_F_IO_DRAIN;
-	ret = io_req_defer(ctx, req, s->sqe);
+	ret = io_req_defer(ctx, req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
+			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
 			io_free_req(req, NULL);
 			__io_free_req(shadow);
-			io_cqring_add_event(ctx, s->sqe->user_data, ret);
 			return 0;
 		}
 	} else {
@@ -2543,7 +2542,7 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	spin_unlock_irq(&ctx->completion_lock);
 
 	if (need_submit)
-		return __io_queue_sqe(ctx, req, s);
+		return __io_queue_sqe(ctx, req);
 
 	return 0;
 }
@@ -2551,10 +2550,10 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 #define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK)
 
 static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			  struct sqe_submit *s, struct io_submit_state *state,
-			  struct io_kiocb **link)
+			  struct io_submit_state *state, struct io_kiocb **link)
 {
 	struct io_uring_sqe *sqe_copy;
+	struct sqe_submit *s = &req->submit;
 	int ret;
 
 	/* enforce forwards compatibility on users */
@@ -2563,11 +2562,11 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		goto err_req;
 	}
 
-	ret = io_req_set_file(ctx, s, state, req);
+	ret = io_req_set_file(ctx, state, req);
 	if (unlikely(ret)) {
 err_req:
-		io_free_req(req, NULL);
 		io_cqring_add_event(ctx, s->sqe->user_data, ret);
+		io_free_req(req, NULL);
 		return;
 	}
 
@@ -2598,7 +2597,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		INIT_LIST_HEAD(&req->link_list);
 		*link = req;
 	} else {
-		io_queue_sqe(ctx, req, s);
+		io_queue_sqe(ctx, req);
 	}
 }
 
@@ -2739,7 +2738,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		req->submit.needs_fixed_file = async;
 		trace_io_uring_submit_sqe(ctx, req->submit.sqe->user_data,
 					  true, async);
-		io_submit_sqe(ctx, req, &req->submit, statep, &link);
+		io_submit_sqe(ctx, req, statep, &link);
 		submitted++;
 
 		/*
@@ -2747,14 +2746,14 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		 * that's the end of the chain. Submit the previous link.
 		 */
 		if (!(sqe_flags & IOSQE_IO_LINK) && link) {
-			io_queue_link_head(ctx, link, &link->submit, shadow_req);
+			io_queue_link_head(ctx, link, shadow_req);
 			link = NULL;
 			shadow_req = NULL;
 		}
 	}
 
 	if (link)
-		io_queue_link_head(ctx, link, &link->submit, shadow_req);
+		io_queue_link_head(ctx, link, shadow_req);
 	if (statep)
 		io_submit_state_end(&state);
 
-- 
2.23.0

