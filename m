Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE5EC5DF60
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C09206BA
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5jvNo0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfKEXFg (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:05:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53824 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbfKEXFg (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 18:05:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id x4so1239585wmi.3;
        Tue, 05 Nov 2019 15:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Pi5p+/PyA3+76eBqLmjodT/hFSgkairOEN4cJPTZ1wY=;
        b=Q5jvNo0kHtQUvMTgpMpydZhoMf04/2kvnjtrjJhXv7fEWglA473vA+PWtWBryvN9Gk
         WrlkPIir7OuEzXgm394+sCN6vAOElfNbqonBmNAq6S3F8BvTdBh3DI3xfnjdFmEuQ+Fc
         0BEFyWw1mgZg+RGr/uMnc2OeK1a5wBxL+yMs/f5fH3Cm+6TehJun0WCxv7Ez66oZiCSX
         fdn18YEAWLODyc6WtdtdeXysGRe9s3hFjQUO/AV/OfWSSGHip8yc3/x66gyuW22K9VgT
         txlAqDhz+qpVx6M2tWb/ANde1b8elrBT5LZT9ipSuQLuOvRry7O3Ft5ZNeDRXSrqUckT
         9sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pi5p+/PyA3+76eBqLmjodT/hFSgkairOEN4cJPTZ1wY=;
        b=kos+clIpeqwev0yJ2qAP886QVWUAKssIf2Rs0K50hnpQ8w0wOyRMbRKXyPiZVpJQ9O
         h4dt2dWvh3tGr7DyuDuLgyKqofSs8jrge5szi2vb1ccAkxWepCLQilW79BmA6sogosja
         NGbGM2VPzZlZm0J00ys/NaFvL+pMRXbSGCu8B7MLS5xNr73blnjPfplsobHRfrkh1Hv2
         mMx5QN3NDeN8BwKBQNHWZ+iF3lYRflqt0tCE3wiy+tCVCTJbWirvP//mYLVJVudxSwEY
         fiCh4/BnFB7XoXOTsciq0HJYLGxXV2+HO6y1Svd+sQ8l3k1LBy5dJp4ZcXaCiYsuWbaX
         QQ9g==
X-Gm-Message-State: APjAAAVHF6U+vzTxF6yFe0tbFgPrKvhcC+rB83/xOWnhdmp8SnuEs1cU
        I9lTTKviBGgN3wtsl4lTp80=
X-Google-Smtp-Source: APXvYqx1qz8sWqw4yh1A6AJ6Egx/ZVkPArs6hlEDigKPOVbztsUE2Z3LhUII6QxvlDYgdtSOZzF2pw==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr1148866wmf.162.1572995131162;
        Tue, 05 Nov 2019 15:05:31 -0800 (PST)
Received: from localhost.localdomain ([109.126.129.81])
        by smtp.gmail.com with ESMTPSA id x8sm15579658wrm.7.2019.11.05.15.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 15:05:30 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 3/3] io_uring: use inlined struct sqe_submit
Date:   Wed,  6 Nov 2019 02:04:45 +0300
Message-Id: <e9f1f564ec60748c4ad266ec6bace9b2df392b58.1572993994.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572993994.git.asml.silence@gmail.com>
References: <cover.1572993994.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

req->submit is always up-to-date, use it directly

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 85 +++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 43 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index ecb5a4336389..e40a6ed54adf 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1157,10 +1157,9 @@ static bool io_file_supports_async(struct file *file)
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
@@ -1408,8 +1407,8 @@ static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
 	return ret;
 }
 
-static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
-		   struct io_kiocb **nxt, bool force_nonblock)
+static int io_read(struct io_kiocb *req, struct io_kiocb **nxt,
+		   bool force_nonblock)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -1418,7 +1417,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	size_t iov_count;
 	ssize_t read_size, ret;
 
-	ret = io_prep_rw(req, s, force_nonblock);
+	ret = io_prep_rw(req, force_nonblock);
 	if (ret)
 		return ret;
 	file = kiocb->ki_filp;
@@ -1426,7 +1425,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	if (unlikely(!(file->f_mode & FMODE_READ)))
 		return -EBADF;
 
-	ret = io_import_iovec(req->ctx, READ, s, &iovec, &iter);
+	ret = io_import_iovec(req->ctx, READ, &req->submit, &iovec, &iter);
 	if (ret < 0)
 		return ret;
 
@@ -1458,7 +1457,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 			ret2 = -EAGAIN;
 		/* Catch -EAGAIN return for forced non-blocking submission */
 		if (!force_nonblock || ret2 != -EAGAIN)
-			kiocb_done(kiocb, ret2, nxt, s->in_async);
+			kiocb_done(kiocb, ret2, nxt, req->submit.in_async);
 		else
 			ret = -EAGAIN;
 	}
@@ -1466,8 +1465,8 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	return ret;
 }
 
-static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
-		    struct io_kiocb **nxt, bool force_nonblock)
+static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
+		    bool force_nonblock)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -1476,7 +1475,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	size_t iov_count;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, s, force_nonblock);
+	ret = io_prep_rw(req, force_nonblock);
 	if (ret)
 		return ret;
 
@@ -1484,7 +1483,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	if (unlikely(!(file->f_mode & FMODE_WRITE)))
 		return -EBADF;
 
-	ret = io_import_iovec(req->ctx, WRITE, s, &iovec, &iter);
+	ret = io_import_iovec(req->ctx, WRITE, &req->submit, &iovec, &iter);
 	if (ret < 0)
 		return ret;
 
@@ -1521,7 +1520,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 		else
 			ret2 = loop_rw_iter(WRITE, file, kiocb, &iter);
 		if (!force_nonblock || ret2 != -EAGAIN)
-			kiocb_done(kiocb, ret2, nxt, s->in_async);
+			kiocb_done(kiocb, ret2, nxt, req->submit.in_async);
 		else
 			ret = -EAGAIN;
 	}
@@ -2177,9 +2176,9 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	return 0;
 }
 
-static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			const struct io_uring_sqe *sqe)
+static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req)
 {
+	const struct io_uring_sqe *sqe = req->submit.sqe;
 	struct io_uring_sqe *sqe_copy;
 
 	if (!io_sequence_defer(ctx, req) && list_empty(&ctx->defer_list))
@@ -2206,10 +2205,10 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
 }
 
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			   const struct sqe_submit *s, struct io_kiocb **nxt,
-			   bool force_nonblock)
+			   struct io_kiocb **nxt, bool force_nonblock)
 {
 	int ret, opcode;
+	struct sqe_submit *s = &req->submit;
 
 	req->user_data = READ_ONCE(s->sqe->user_data);
 
@@ -2221,18 +2220,18 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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
@@ -2307,7 +2306,7 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 		s->has_user = (work->flags & IO_WQ_WORK_HAS_MM) != 0;
 		s->in_async = true;
 		do {
-			ret = __io_submit_sqe(ctx, req, s, &nxt, false);
+			ret = __io_submit_sqe(ctx, req, &nxt, false);
 			/*
 			 * We can get EAGAIN for polled IO even though we're
 			 * forcing a sync submission from here, since we can't
@@ -2359,9 +2358,10 @@ static inline struct file *io_file_from_index(struct io_ring_ctx *ctx,
 	return table->files[index & IORING_FILE_TABLE_MASK];
 }
 
-static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
+static int io_req_set_file(struct io_ring_ctx *ctx,
 			   struct io_submit_state *state, struct io_kiocb *req)
 {
+	struct sqe_submit *s = &req->submit;
 	unsigned flags;
 	int fd;
 
@@ -2425,12 +2425,11 @@ static int io_grab_files(struct io_ring_ctx *ctx, struct io_kiocb *req)
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
@@ -2438,6 +2437,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	 */
 	if (ret == -EAGAIN && (!(req->flags & REQ_F_NOWAIT) ||
 	    (req->flags & REQ_F_MUST_PUNT))) {
+		struct sqe_submit *s = &req->submit;
 		struct io_uring_sqe *sqe_copy;
 
 		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
@@ -2475,31 +2475,30 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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
 			io_free_req(req, NULL);
-			io_cqring_add_event(ctx, s->sqe->user_data, ret);
+			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
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
@@ -2507,12 +2506,12 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	 * list.
 	 */
 	req->flags |= REQ_F_IO_DRAIN;
-	ret = io_req_defer(ctx, req, s->sqe);
+	ret = io_req_defer(ctx, req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
 			io_free_req(req, NULL);
 			__io_free_req(shadow);
-			io_cqring_add_event(ctx, s->sqe->user_data, ret);
+			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
 			return 0;
 		}
 	} else {
@@ -2530,7 +2529,7 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	spin_unlock_irq(&ctx->completion_lock);
 
 	if (need_submit)
-		return __io_queue_sqe(ctx, req, s);
+		return __io_queue_sqe(ctx, req);
 
 	return 0;
 }
@@ -2538,10 +2537,10 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
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
@@ -2550,7 +2549,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		goto err_req;
 	}
 
-	ret = io_req_set_file(ctx, s, state, req);
+	ret = io_req_set_file(ctx, state, req);
 	if (unlikely(ret)) {
 err_req:
 		io_free_req(req, NULL);
@@ -2585,7 +2584,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		INIT_LIST_HEAD(&req->link_list);
 		*link = req;
 	} else {
-		io_queue_sqe(ctx, req, s);
+		io_queue_sqe(ctx, req);
 	}
 }
 
@@ -2723,7 +2722,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		req->submit.needs_fixed_file = async;
 		trace_io_uring_submit_sqe(ctx, req->submit.sqe->user_data,
 					  true, async);
-		io_submit_sqe(ctx, req, &req->submit, statep, &link);
+		io_submit_sqe(ctx, req, statep, &link);
 		submitted++;
 
 		/*
@@ -2731,14 +2730,14 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		 * that's the end of the chain. Submit the previous link.
 		 */
 		if (!(req->submit.sqe->flags & IOSQE_IO_LINK) && link) {
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

