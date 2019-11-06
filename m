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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEAEFC6196
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C852173E
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sw3bmPTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732764AbfKFWlt (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:41:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51356 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfKFWlt (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 17:41:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so8949wme.1;
        Wed, 06 Nov 2019 14:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BJUO+4STjtuSZ2Fe5R2yrdF6JVhW+iolCJYQxrmi8lI=;
        b=Sw3bmPTyzvkdxBKFaa7EA/nkLVh1Yvz1iEXLjyUvic5Ti1UnxlgwooSo6WrerJbKof
         MZkG5kWzVEymCntm/IaxYtUmoAcN0yqvN9NP0I5IV8d+oLkvJ5TLFYsPOqe9WMoxFewy
         Z7p/H0zBypjjImCtlWhCw/JoRsusDrKmTjf3ssTPuKVbhNifl+QrDNuoxkCnQpzAqSUt
         LebtzSPIKZA2l6dT3jIhARdvASBBx7CyevsPwih9A/pH6ABdSgvAkka6HzDlc4oxfAMp
         lQ8RG0YpXt8UAxxFbco8Oj5j8u02D/DZne1rQj31cv/SVemOGijYicr7lfB4kdWoq10i
         lBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJUO+4STjtuSZ2Fe5R2yrdF6JVhW+iolCJYQxrmi8lI=;
        b=WZa77AkWPo39K+bO5uZKY3IsLtgTWwbffBekCmLpbIUifGOUblAvXqyicisk+YSiYO
         XsPeOkykix7bru5/9uR4CIN7eVS83cF5Txs83BRCi2/ijFLd4mC+gdg2sj2XM4TF7nL6
         QtdSSP3/LoW7UyPecN3VNeviLn9wmt2Zn8z0+EwZOrVHELiBRw2c/WYMAvD3JqtLrNjd
         IAs+WaOMgCCWXzYrBcNdbpajIdfeKZrRhUN7kJl4b7/n1Hl+GBGy9kkbTWsGk2TqOnRV
         WZRO/3i2900ozOrFytOwQb+cQ2fEtfVQGy1XpaZ+2R4Du0Ajji8YnPr//3iiy5tia3Yh
         xaBw==
X-Gm-Message-State: APjAAAXBR8uN1MfLxVjNqBzITZ7jDMIzJT/0/Pe05SKVzIRpxEgjPhO1
        VsSBwZsgxy8DiQY8MeMaO88=
X-Google-Smtp-Source: APXvYqzFsieCvrvFZZEwaFjGGmGwVwhjnHPjh+dCWWGRlCjM5IvNlloJ4doNk+d+GNDAWZUqy/4MPw==
X-Received: by 2002:a1c:f602:: with SMTP id w2mr4503298wmc.83.1573080105781;
        Wed, 06 Nov 2019 14:41:45 -0800 (PST)
Received: from localhost.localdomain ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id h140sm23469wme.22.2019.11.06.14.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 14:41:45 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v3 3/3] io_uring: use inlined struct sqe_submit
Date:   Thu,  7 Nov 2019 01:41:08 +0300
Message-Id: <ecee5ea82fa6675129d6565144216ab1a5e7f572.1573079844.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1573079844.git.asml.silence@gmail.com>
References: <cover.1573079844.git.asml.silence@gmail.com>
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
index c0d2601dc17b..2c56c3b9c828 100644
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

