Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD07C432C3
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 20:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E142075C
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 20:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksb15F9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfKYUPL (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:15:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40783 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfKYUPL (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 15:15:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id y5so709017wmi.5
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 12:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WC782iU+XJCyKwCDe7v5eOWwR3QrryU0nf4ir+TjfKo=;
        b=ksb15F9z0K/gkehoxF2EKFWxG1VznfTxeD2pIqQ0X8mdY9scD/BH790/6D0sBq4odT
         Vu4H53M3QUjeT4xbeP6I5ja+0v7+2xgrb66pIYkC0nhPdW/GgrbP0pmERZIyl0DcgyZu
         qi+bzhayIUT3qYQPAVMy3shG7Ck4bWQJXC81zJVQNgYUy4IdLvJKKTL4zc2egX8Azaf8
         y5Mk1WapjuljiZ8YOoPuPvNdLuDTYl2qZPM41CYWQGcU1cDhpY/3TX/Jrmm/6sztWj/c
         IPQWNLSS7qqulUpHD57prz3SkOOVhLNNlneZSkGZzfgwKPvsVjASFvk+j+YaXp8fqT+D
         rngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WC782iU+XJCyKwCDe7v5eOWwR3QrryU0nf4ir+TjfKo=;
        b=RY2AacfnuxYGSi/YXi2OiwDBRIFcnZNs6nqIfnfvRqM5joa7L3KldfChct6En0qMXk
         1RnxDsyntw0RtvdXYcvgoNgVVrMB6tolRT9bzJIZhU3/zVTQunilOduNB9iGv8qwQyvL
         DYydDwdGp2U8khEq4PzIyYHIvx/Pui6ftpW2iqgQf6agNlkwxzR7DQU7AGMtYOUT56mX
         CMXTgrzVQVv7+6uUnKWsxrN62iY2xMVmOzsuu/2ncXkrD72bVRD2cZtVvyOu9C9+hG9h
         cv+DC1E+bz3eT4P0Box7ssinyYl3239luDsjO9N8dNbTtnFmPI1VIGxA0Sj6KUaKJyKP
         x7hg==
X-Gm-Message-State: APjAAAVZom3Z+Yc/WmIIgCgId9m4lzmn5gk++HPd6At/tB0GYsRuYmyF
        VX3+e/dPubaptl4Kemy9p58=
X-Google-Smtp-Source: APXvYqzvBOtGmrn/45rpu41KeVtG1Jh8ndzZ8aL+8877Iu4A2nTgaBw5HIn4yBpzAuyAsK35zvFAgw==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr561140wmj.11.1574712909015;
        Mon, 25 Nov 2019 12:15:09 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id x7sm11584407wrq.41.2019.11.25.12.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 12:15:08 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 2/3] io_uring: inline struct sqe_submit
Date:   Mon, 25 Nov 2019 23:14:39 +0300
Message-Id: <f2a159218bd15c6711e624f0af36d986273f7cef.1574712375.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574712375.git.asml.silence@gmail.com>
References: <cover.1574712375.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

There is no point left in keeping struct sqe_submit. Inline it
into struct io_kiocb, so any req->submit.field is now just req->field

- moves initialisation of ring_file into io_get_req()
- removes duplicated req->sequence.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 169 +++++++++++++++++++++++---------------------------
 1 file changed, 78 insertions(+), 91 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0ce894fd4940..c75431079a74 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -279,16 +279,6 @@ struct io_ring_ctx {
 	} ____cacheline_aligned_in_smp;
 };
 
-struct sqe_submit {
-	const struct io_uring_sqe	*sqe;
-	struct file			*ring_file;
-	int				ring_fd;
-	u32				sequence;
-	bool				has_user;
-	bool				in_async;
-	bool				needs_fixed_file;
-};
-
 /*
  * First field must be the file pointer in all the
  * iocb unions! See also 'struct kiocb' in <linux/fs.h>
@@ -329,7 +319,12 @@ struct io_kiocb {
 		struct io_timeout	timeout;
 	};
 
-	struct sqe_submit	submit;
+	const struct io_uring_sqe	*sqe;
+	struct file			*ring_file;
+	int				ring_fd;
+	bool				has_user;
+	bool				in_async;
+	bool				needs_fixed_file;
 
 	struct io_ring_ctx	*ctx;
 	union {
@@ -539,8 +534,8 @@ static inline bool io_prep_async_work(struct io_kiocb *req,
 {
 	bool do_hashed = false;
 
-	if (req->submit.sqe) {
-		switch (req->submit.sqe->opcode) {
+	if (req->sqe) {
+		switch (req->sqe->opcode) {
 		case IORING_OP_WRITEV:
 		case IORING_OP_WRITE_FIXED:
 			do_hashed = true;
@@ -561,7 +556,7 @@ static inline bool io_prep_async_work(struct io_kiocb *req,
 				req->work.flags |= IO_WQ_WORK_UNBOUND;
 			break;
 		}
-		if (io_sqe_needs_user(req->submit.sqe))
+		if (io_sqe_needs_user(req->sqe))
 			req->work.flags |= IO_WQ_WORK_NEEDS_USER;
 	}
 
@@ -808,6 +803,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	}
 
 got_it:
+	req->ring_file = NULL;
 	req->file = NULL;
 	req->ctx = ctx;
 	req->flags = 0;
@@ -838,7 +834,7 @@ static void __io_free_req(struct io_kiocb *req)
 	struct io_ring_ctx *ctx = req->ctx;
 
 	if (req->flags & REQ_F_FREE_SQE)
-		kfree(req->submit.sqe);
+		kfree(req->sqe);
 	if (req->file && !(req->flags & REQ_F_FIXED_FILE))
 		fput(req->file);
 	if (req->flags & REQ_F_INFLIGHT) {
@@ -936,7 +932,7 @@ static void io_fail_links(struct io_kiocb *req)
 		trace_io_uring_fail_link(req, link);
 
 		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
-		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
+		    link->sqe->opcode == IORING_OP_LINK_TIMEOUT) {
 			io_link_cancel_timeout(link);
 		} else {
 			io_cqring_fill_event(link, -ECANCELED);
@@ -1399,7 +1395,7 @@ static bool io_file_supports_async(struct file *file)
 
 static int io_prep_rw(struct io_kiocb *req, bool force_nonblock)
 {
-	const struct io_uring_sqe *sqe = req->submit.sqe;
+	const struct io_uring_sqe *sqe = req->sqe;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct kiocb *kiocb = &req->rw;
 	unsigned ioprio;
@@ -1566,11 +1562,10 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 	return len;
 }
 
-static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
-			       const struct sqe_submit *s, struct iovec **iovec,
-			       struct iov_iter *iter)
+static ssize_t io_import_iovec(int rw, struct io_kiocb *req,
+			       struct iovec **iovec, struct iov_iter *iter)
 {
-	const struct io_uring_sqe *sqe = s->sqe;
+	const struct io_uring_sqe *sqe = req->sqe;
 	void __user *buf = u64_to_user_ptr(READ_ONCE(sqe->addr));
 	size_t sqe_len = READ_ONCE(sqe->len);
 	u8 opcode;
@@ -1586,16 +1581,16 @@ static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
 	opcode = READ_ONCE(sqe->opcode);
 	if (opcode == IORING_OP_READ_FIXED ||
 	    opcode == IORING_OP_WRITE_FIXED) {
-		ssize_t ret = io_import_fixed(ctx, rw, sqe, iter);
+		ssize_t ret = io_import_fixed(req->ctx, rw, sqe, iter);
 		*iovec = NULL;
 		return ret;
 	}
 
-	if (!s->has_user)
+	if (!req->has_user)
 		return -EFAULT;
 
 #ifdef CONFIG_COMPAT
-	if (ctx->compat)
+	if (req->ctx->compat)
 		return compat_import_iovec(rw, buf, sqe_len, UIO_FASTIOV,
 						iovec, iter);
 #endif
@@ -1679,7 +1674,7 @@ static int io_read(struct io_kiocb *req, struct io_kiocb **nxt,
 	if (unlikely(!(file->f_mode & FMODE_READ)))
 		return -EBADF;
 
-	ret = io_import_iovec(req->ctx, READ, &req->submit, &iovec, &iter);
+	ret = io_import_iovec(READ, req, &iovec, &iter);
 	if (ret < 0)
 		return ret;
 
@@ -1711,7 +1706,7 @@ static int io_read(struct io_kiocb *req, struct io_kiocb **nxt,
 			ret2 = -EAGAIN;
 		/* Catch -EAGAIN return for forced non-blocking submission */
 		if (!force_nonblock || ret2 != -EAGAIN)
-			kiocb_done(kiocb, ret2, nxt, req->submit.in_async);
+			kiocb_done(kiocb, ret2, nxt, req->in_async);
 		else
 			ret = -EAGAIN;
 	}
@@ -1737,7 +1732,7 @@ static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
 	if (unlikely(!(file->f_mode & FMODE_WRITE)))
 		return -EBADF;
 
-	ret = io_import_iovec(req->ctx, WRITE, &req->submit, &iovec, &iter);
+	ret = io_import_iovec(WRITE, req, &iovec, &iter);
 	if (ret < 0)
 		return ret;
 
@@ -1774,7 +1769,7 @@ static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
 		else
 			ret2 = loop_rw_iter(WRITE, file, kiocb, &iter);
 		if (!force_nonblock || ret2 != -EAGAIN)
-			kiocb_done(kiocb, ret2, nxt, req->submit.in_async);
+			kiocb_done(kiocb, ret2, nxt, req->in_async);
 		else
 			ret = -EAGAIN;
 	}
@@ -2258,7 +2253,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (!poll->file)
 		return -EBADF;
 
-	req->submit.sqe = NULL;
+	req->sqe = NULL;
 	INIT_IO_WORK(&req->work, io_poll_complete_work);
 	events = READ_ONCE(sqe->poll_events);
 	poll->events = demangle_poll(events) | EPOLLERR | EPOLLHUP;
@@ -2412,7 +2407,7 @@ static int io_timeout_remove(struct io_kiocb *req,
 
 static int io_timeout_setup(struct io_kiocb *req)
 {
-	const struct io_uring_sqe *sqe = req->submit.sqe;
+	const struct io_uring_sqe *sqe = req->sqe;
 	struct io_timeout_data *data;
 	unsigned flags;
 
@@ -2600,7 +2595,6 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 static int io_req_defer(struct io_kiocb *req)
 {
-	const struct io_uring_sqe *sqe = req->submit.sqe;
 	struct io_uring_sqe *sqe_copy;
 	struct io_ring_ctx *ctx = req->ctx;
 
@@ -2619,9 +2613,9 @@ static int io_req_defer(struct io_kiocb *req)
 		return 0;
 	}
 
-	memcpy(sqe_copy, sqe, sizeof(*sqe_copy));
+	memcpy(sqe_copy, req->sqe, sizeof(*sqe_copy));
 	req->flags |= REQ_F_FREE_SQE;
-	req->submit.sqe = sqe_copy;
+	req->sqe = sqe_copy;
 
 	trace_io_uring_defer(ctx, req, req->user_data);
 	list_add_tail(&req->list, &ctx->defer_list);
@@ -2634,21 +2628,20 @@ static int io_issue_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
 			bool force_nonblock)
 {
 	int ret, opcode;
-	struct sqe_submit *s = &req->submit;
 	struct io_ring_ctx *ctx = req->ctx;
 
-	opcode = READ_ONCE(s->sqe->opcode);
+	opcode = READ_ONCE(req->sqe->opcode);
 	switch (opcode) {
 	case IORING_OP_NOP:
 		ret = io_nop(req);
 		break;
 	case IORING_OP_READV:
-		if (unlikely(s->sqe->buf_index))
+		if (unlikely(req->sqe->buf_index))
 			return -EINVAL;
 		ret = io_read(req, nxt, force_nonblock);
 		break;
 	case IORING_OP_WRITEV:
-		if (unlikely(s->sqe->buf_index))
+		if (unlikely(req->sqe->buf_index))
 			return -EINVAL;
 		ret = io_write(req, nxt, force_nonblock);
 		break;
@@ -2659,37 +2652,37 @@ static int io_issue_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
 		ret = io_write(req, nxt, force_nonblock);
 		break;
 	case IORING_OP_FSYNC:
-		ret = io_fsync(req, s->sqe, nxt, force_nonblock);
+		ret = io_fsync(req, req->sqe, nxt, force_nonblock);
 		break;
 	case IORING_OP_POLL_ADD:
-		ret = io_poll_add(req, s->sqe, nxt);
+		ret = io_poll_add(req, req->sqe, nxt);
 		break;
 	case IORING_OP_POLL_REMOVE:
-		ret = io_poll_remove(req, s->sqe);
+		ret = io_poll_remove(req, req->sqe);
 		break;
 	case IORING_OP_SYNC_FILE_RANGE:
-		ret = io_sync_file_range(req, s->sqe, nxt, force_nonblock);
+		ret = io_sync_file_range(req, req->sqe, nxt, force_nonblock);
 		break;
 	case IORING_OP_SENDMSG:
-		ret = io_sendmsg(req, s->sqe, nxt, force_nonblock);
+		ret = io_sendmsg(req, req->sqe, nxt, force_nonblock);
 		break;
 	case IORING_OP_RECVMSG:
-		ret = io_recvmsg(req, s->sqe, nxt, force_nonblock);
+		ret = io_recvmsg(req, req->sqe, nxt, force_nonblock);
 		break;
 	case IORING_OP_TIMEOUT:
-		ret = io_timeout(req, s->sqe);
+		ret = io_timeout(req, req->sqe);
 		break;
 	case IORING_OP_TIMEOUT_REMOVE:
-		ret = io_timeout_remove(req, s->sqe);
+		ret = io_timeout_remove(req, req->sqe);
 		break;
 	case IORING_OP_ACCEPT:
-		ret = io_accept(req, s->sqe, nxt, force_nonblock);
+		ret = io_accept(req, req->sqe, nxt, force_nonblock);
 		break;
 	case IORING_OP_CONNECT:
-		ret = io_connect(req, s->sqe, nxt, force_nonblock);
+		ret = io_connect(req, req->sqe, nxt, force_nonblock);
 		break;
 	case IORING_OP_ASYNC_CANCEL:
-		ret = io_async_cancel(req, s->sqe, nxt);
+		ret = io_async_cancel(req, req->sqe, nxt);
 		break;
 	default:
 		ret = -EINVAL;
@@ -2704,10 +2697,10 @@ static int io_issue_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
 			return -EAGAIN;
 
 		/* workqueue context doesn't hold uring_lock, grab it now */
-		if (s->in_async)
+		if (req->in_async)
 			mutex_lock(&ctx->uring_lock);
 		io_iopoll_req_issued(req);
-		if (s->in_async)
+		if (req->in_async)
 			mutex_unlock(&ctx->uring_lock);
 	}
 
@@ -2725,7 +2718,6 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 {
 	struct io_wq_work *work = *workptr;
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
-	struct sqe_submit *s = &req->submit;
 	struct io_kiocb *nxt = NULL;
 	int ret = 0;
 
@@ -2736,8 +2728,8 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 		ret = -ECANCELED;
 
 	if (!ret) {
-		s->has_user = (work->flags & IO_WQ_WORK_HAS_MM) != 0;
-		s->in_async = true;
+		req->has_user = (work->flags & IO_WQ_WORK_HAS_MM) != 0;
+		req->in_async = true;
 		do {
 			ret = io_issue_sqe(req, &nxt, false);
 			/*
@@ -2803,24 +2795,17 @@ static inline struct file *io_file_from_index(struct io_ring_ctx *ctx,
 
 static int io_req_set_file(struct io_submit_state *state, struct io_kiocb *req)
 {
-	struct sqe_submit *s = &req->submit;
 	struct io_ring_ctx *ctx = req->ctx;
 	unsigned flags;
 	int fd;
 
-	flags = READ_ONCE(s->sqe->flags);
-	fd = READ_ONCE(s->sqe->fd);
+	flags = READ_ONCE(req->sqe->flags);
+	fd = READ_ONCE(req->sqe->fd);
 
 	if (flags & IOSQE_IO_DRAIN)
 		req->flags |= REQ_F_IO_DRAIN;
-	/*
-	 * All io need record the previous position, if LINK vs DARIN,
-	 * it can be used to mark the position of the first IO in the
-	 * link list.
-	 */
-	req->sequence = s->sequence;
 
-	if (!io_op_needs_file(s->sqe))
+	if (!io_op_needs_file(req->sqe))
 		return 0;
 
 	if (flags & IOSQE_FIXED_FILE) {
@@ -2833,7 +2818,7 @@ static int io_req_set_file(struct io_submit_state *state, struct io_kiocb *req)
 			return -EBADF;
 		req->flags |= REQ_F_FIXED_FILE;
 	} else {
-		if (s->needs_fixed_file)
+		if (req->needs_fixed_file)
 			return -EBADF;
 		trace_io_uring_file_get(ctx, fd);
 		req->file = io_file_get(state, fd);
@@ -2857,7 +2842,7 @@ static int io_grab_files(struct io_kiocb *req)
 	 * the fd has changed since we started down this path, and disallow
 	 * this operation if it has.
 	 */
-	if (fcheck(req->submit.ring_fd) == req->submit.ring_file) {
+	if (fcheck(req->ring_fd) == req->ring_file) {
 		list_add(&req->inflight_entry, &ctx->inflight_list);
 		req->flags |= REQ_F_INFLIGHT;
 		req->work.files = current->files;
@@ -2938,7 +2923,7 @@ static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req)
 		return NULL;
 
 	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
-	if (!nxt || nxt->submit.sqe->opcode != IORING_OP_LINK_TIMEOUT)
+	if (!nxt || nxt->sqe->opcode != IORING_OP_LINK_TIMEOUT)
 		return NULL;
 
 	req->flags |= REQ_F_LINK_TIMEOUT;
@@ -2961,14 +2946,13 @@ static void __io_queue_sqe(struct io_kiocb *req)
 	 */
 	if (ret == -EAGAIN && (!(req->flags & REQ_F_NOWAIT) ||
 	    (req->flags & REQ_F_MUST_PUNT))) {
-		struct sqe_submit *s = &req->submit;
 		struct io_uring_sqe *sqe_copy;
 
-		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
+		sqe_copy = kmemdup(req->sqe, sizeof(*sqe_copy), GFP_KERNEL);
 		if (!sqe_copy)
 			goto err;
 
-		s->sqe = sqe_copy;
+		req->sqe = sqe_copy;
 		req->flags |= REQ_F_FREE_SQE;
 
 		if (req->work.flags & IO_WQ_WORK_NEEDS_FILES) {
@@ -3042,14 +3026,13 @@ static inline void io_queue_link_head(struct io_kiocb *req)
 static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 			  struct io_kiocb **link)
 {
-	struct sqe_submit *s = &req->submit;
 	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
 
-	req->user_data = s->sqe->user_data;
+	req->user_data = req->sqe->user_data;
 
 	/* enforce forwards compatibility on users */
-	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
+	if (unlikely(req->sqe->flags & ~SQE_VALID_FLAGS)) {
 		ret = -EINVAL;
 		goto err_req;
 	}
@@ -3073,13 +3056,13 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 		struct io_kiocb *prev = *link;
 		struct io_uring_sqe *sqe_copy;
 
-		if (s->sqe->flags & IOSQE_IO_DRAIN)
+		if (req->sqe->flags & IOSQE_IO_DRAIN)
 			(*link)->flags |= REQ_F_DRAIN_LINK | REQ_F_IO_DRAIN;
 
-		if (READ_ONCE(s->sqe->opcode) == IORING_OP_LINK_TIMEOUT) {
+		if (READ_ONCE(req->sqe->opcode) == IORING_OP_LINK_TIMEOUT) {
 			ret = io_timeout_setup(req);
 			/* common setup allows offset being set, we don't */
-			if (!ret && s->sqe->off)
+			if (!ret && req->sqe->off)
 				ret = -EINVAL;
 			if (ret) {
 				prev->flags |= REQ_F_FAIL_LINK;
@@ -3087,17 +3070,17 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 			}
 		}
 
-		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
+		sqe_copy = kmemdup(req->sqe, sizeof(*sqe_copy), GFP_KERNEL);
 		if (!sqe_copy) {
 			ret = -EAGAIN;
 			goto err_req;
 		}
 
-		s->sqe = sqe_copy;
+		req->sqe = sqe_copy;
 		req->flags |= REQ_F_FREE_SQE;
 		trace_io_uring_link(ctx, req, prev);
 		list_add_tail(&req->list, &prev->link_list);
-	} else if (s->sqe->flags & IOSQE_IO_LINK) {
+	} else if (req->sqe->flags & IOSQE_IO_LINK) {
 		req->flags |= REQ_F_LINK;
 
 		INIT_LIST_HEAD(&req->link_list);
@@ -3153,7 +3136,7 @@ static void io_commit_sqring(struct io_ring_ctx *ctx)
  * used, it's important that those reads are done through READ_ONCE() to
  * prevent a re-load down the line.
  */
-static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
+static bool io_get_sqring(struct io_ring_ctx *ctx, struct io_kiocb *req)
 {
 	struct io_rings *rings = ctx->rings;
 	u32 *sq_array = ctx->sq_array;
@@ -3174,9 +3157,13 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 
 	head = READ_ONCE(sq_array[head & ctx->sq_mask]);
 	if (likely(head < ctx->sq_entries)) {
-		s->ring_file = NULL;
-		s->sqe = &ctx->sq_sqes[head];
-		s->sequence = ctx->cached_sq_head;
+		/*
+		 * All io need record the previous position, if LINK vs DARIN,
+		 * it can be used to mark the position of the first IO in the
+		 * link list.
+		 */
+		req->sequence = ctx->cached_sq_head;
+		req->sqe = &ctx->sq_sqes[head];
 		ctx->cached_sq_head++;
 		return true;
 	}
@@ -3217,12 +3204,12 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 				submitted = -EAGAIN;
 			break;
 		}
-		if (!io_get_sqring(ctx, &req->submit)) {
+		if (!io_get_sqring(ctx, req)) {
 			__io_free_req(req);
 			break;
 		}
 
-		if (io_sqe_needs_user(req->submit.sqe) && !*mm) {
+		if (io_sqe_needs_user(req->sqe) && !*mm) {
 			mm_fault = mm_fault || !mmget_not_zero(ctx->sqo_mm);
 			if (!mm_fault) {
 				use_mm(ctx->sqo_mm);
@@ -3230,14 +3217,14 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 			}
 		}
 
-		sqe_flags = req->submit.sqe->flags;
+		sqe_flags = req->sqe->flags;
 
-		req->submit.ring_file = ring_file;
-		req->submit.ring_fd = ring_fd;
-		req->submit.has_user = *mm != NULL;
-		req->submit.in_async = async;
-		req->submit.needs_fixed_file = async;
-		trace_io_uring_submit_sqe(ctx, req->submit.sqe->user_data,
+		req->ring_file = ring_file;
+		req->ring_fd = ring_fd;
+		req->has_user = *mm != NULL;
+		req->in_async = async;
+		req->needs_fixed_file = async;
+		trace_io_uring_submit_sqe(ctx, req->sqe->user_data,
 					  true, async);
 		io_submit_sqe(req, statep, &link);
 		submitted++;
-- 
2.24.0

