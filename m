Return-Path: <SRS0=qbp9=ZY=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CC8C432C0
	for <io-uring@archiver.kernel.org>; Mon,  2 Dec 2019 22:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B04A206F0
	for <io-uring@archiver.kernel.org>; Mon,  2 Dec 2019 22:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iSiTNxbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfLBWbK (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:31:10 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37104 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfLBWbK (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 2 Dec 2019 17:31:10 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so1328682ioc.4
        for <io-uring@vger.kernel.org>; Mon, 02 Dec 2019 14:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcTvDvDoYCqJFHERHfhKp14EaQ3RHgv4cpkFbFkR6+Q=;
        b=iSiTNxbZHVgXnnzDeCAKgEBCL1I4C6G9CpajL9mxoFZlMRBFyHTkp1egtFSqnKR4u4
         A1oZzapBnjsoL1MKW6Ay2BdbahlpqeKZgJ3aeEgqUupdjYaw1Rg3Q05vdxXMML2KlNOi
         ZQuSDGJvGFcU81t3KpzmV/oC0RX/nWz01fuUVv/kqDfWrdXMZm+4P4Yem3jgSmc4w6Q+
         wLc1v5i8MXUm/9ehqCdYNHqmqWp5hmT00VKU1Y+7woKd4qcYASA18f5xaMdu+8tdCyty
         SxoYJFzamYPBVt52Y6I+q+SyYux8VIDr2UBEcbqtq8e98mUwjUe5AuHK8/vOQMb8e23E
         I4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcTvDvDoYCqJFHERHfhKp14EaQ3RHgv4cpkFbFkR6+Q=;
        b=MVm73WYeM8LDTu4jkOzozV/n3d1xhBtw7bVUCGLyVJOBG0zycTJOiOUUBlEZ6tzoIf
         WqLoWIf6kb4dRJxRkapv2jCjMsMupShiO8egSQNhDmWCVIZEOGSCLbckwlDd7RVU3wF9
         NN8z72XWfSfSBx+tBCBEAEawpRLXPau1DdEw7FgbIK85Dfm0Z/8ht7xHQfflVcZMFaqH
         H7/251Cd4SAPM6fH1tnXjTfxt6SwwYrO79GLaJIvJHqK0yko2FGK0FZwJciB83VO9/Mh
         D6mj9NIpczH4WnlOraHgA0njVleRDB14Z5SJ5rbIldWyqr8Efk61dAzHJLizuiN4H5Gh
         dw0A==
X-Gm-Message-State: APjAAAWTP2NEhKGGNE4/6t4YDV3ZbisD9iq9hzHVLp23xLu1+SiBzqQr
        VYFFkXQbjCQ6eEjtVtBi14X9QuaNPVfLYA==
X-Google-Smtp-Source: APXvYqz6YXCVBYcmOD/2K4A5ChPscc4WpfRRo8eq8zEAAvjJ2T+GPSrsnZ3cgQbEFZqLEirqsXpEfw==
X-Received: by 2002:a5d:81c7:: with SMTP id t7mr1174929iol.196.1575325868383;
        Mon, 02 Dec 2019 14:31:08 -0800 (PST)
Received: from localhost.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k6sm191184iom.52.2019.12.02.14.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 14:31:07 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     carter.li@eoitek.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] io_uring: ensure async punted read/write requests copy iovec
Date:   Mon,  2 Dec 2019 15:31:01 -0700
Message-Id: <20191202223101.10836-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202223101.10836-1-axboe@kernel.dk>
References: <20191202223101.10836-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Currently we don't copy the iovecs when we punt to async context. This
can be problematic for applications that store the iovec on the stack,
as they often assume that it's safe to let the iovec go out of scope
as soon as IO submission has been called. This isn't always safe, as we
will re-copy the iovec once we're in async context.

Make this 100% safe by copying the iovec just once. With this change,
applications may safely store the iovec on the stack for all cases.

Reported-by: 李通洲 <carter.li@eoitek.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 241 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 179 insertions(+), 62 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0328f565c0c9..ccc98042b28d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -308,8 +308,18 @@ struct io_timeout {
 	struct io_timeout_data		*data;
 };
 
+struct io_async_rw {
+	struct iovec			fast_iov[UIO_FASTIOV];
+	struct iovec			*iov;
+	ssize_t				nr_segs;
+	ssize_t				size;
+};
+
 struct io_async_ctx {
 	struct io_uring_sqe		sqe;
+	union {
+		struct io_async_rw	rw;
+	};
 };
 
 /*
@@ -358,6 +368,7 @@ struct io_kiocb {
 #define REQ_F_TIMEOUT_NOSEQ	8192	/* no timeout sequence */
 #define REQ_F_INFLIGHT		16384	/* on inflight list */
 #define REQ_F_COMP_LOCKED	32768	/* completion under lock */
+#define REQ_F_PREPPED		65536	/* has done prep */
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -1415,15 +1426,6 @@ static int io_prep_rw(struct io_kiocb *req, bool force_nonblock)
 	if (S_ISREG(file_inode(req->file)->i_mode))
 		req->flags |= REQ_F_ISREG;
 
-	/*
-	 * If the file doesn't support async, mark it as REQ_F_MUST_PUNT so
-	 * we know to async punt it even if it was opened O_NONBLOCK
-	 */
-	if (force_nonblock && !io_file_supports_async(req->file)) {
-		req->flags |= REQ_F_MUST_PUNT;
-		return -EAGAIN;
-	}
-
 	kiocb->ki_pos = READ_ONCE(sqe->off);
 	kiocb->ki_flags = iocb_flags(kiocb->ki_filp);
 	kiocb->ki_hint = ki_hint_validate(file_write_hint(kiocb->ki_filp));
@@ -1592,6 +1594,16 @@ static ssize_t io_import_iovec(int rw, struct io_kiocb *req,
 		return io_import_fixed(req->ctx, rw, sqe, iter);
 	}
 
+	if (req->io) {
+		struct io_async_rw *iorw = &req->io->rw;
+
+		*iovec = iorw->iov;
+		iov_iter_init(iter, rw, *iovec, iorw->nr_segs, iorw->size);
+		if (iorw->iov == iorw->fast_iov)
+			*iovec = NULL;
+		return iorw->size;
+	}
+
 	if (!req->has_user)
 		return -EFAULT;
 
@@ -1662,6 +1674,53 @@ static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
 	return ret;
 }
 
+static void io_req_map_io(struct io_kiocb *req, ssize_t io_size,
+			  struct iovec *iovec, struct iovec *fast_iov,
+			  struct iov_iter *iter)
+{
+	req->io->rw.nr_segs = iter->nr_segs;
+	req->io->rw.size = io_size;
+	req->io->rw.iov = iovec;
+	if (!req->io->rw.iov) {
+		req->io->rw.iov = req->io->rw.fast_iov;
+		memcpy(req->io->rw.iov, fast_iov,
+			sizeof(struct iovec) * iter->nr_segs);
+	}
+
+	memcpy(&req->io->sqe, req->sqe, sizeof(req->io->sqe));
+	req->sqe = &req->io->sqe;
+
+	req->flags |= REQ_F_PREPPED;
+}
+
+static int io_setup_async_io(struct io_kiocb *req, ssize_t io_size,
+			     struct iovec *iovec, struct iovec *fast_iov,
+			     struct iov_iter *iter)
+{
+	req->io = kmalloc(sizeof(*req->io), GFP_KERNEL);
+	if (req->io) {
+		io_req_map_io(req, io_size, iovec, fast_iov, iter);
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
+static int io_read_prep(struct io_kiocb *req, struct iovec **iovec,
+			struct iov_iter *iter, bool force_nonblock)
+{
+	ssize_t ret;
+
+	ret = io_prep_rw(req, force_nonblock);
+	if (ret)
+		return ret;
+
+	if (unlikely(!(req->file->f_mode & FMODE_READ)))
+		return -EBADF;
+
+	return io_import_iovec(READ, req, iovec, iter);
+}
+
 static int io_read(struct io_kiocb *req, struct io_kiocb **nxt,
 		   bool force_nonblock)
 {
@@ -1670,23 +1729,31 @@ static int io_read(struct io_kiocb *req, struct io_kiocb **nxt,
 	struct iov_iter iter;
 	struct file *file;
 	size_t iov_count;
-	ssize_t read_size, ret;
-
-	ret = io_prep_rw(req, force_nonblock);
-	if (ret)
-		return ret;
-	file = kiocb->ki_filp;
-
-	if (unlikely(!(file->f_mode & FMODE_READ)))
-		return -EBADF;
+	ssize_t io_size, ret;
 
-	ret = io_import_iovec(READ, req, &iovec, &iter);
-	if (ret < 0)
-		return ret;
+	if (!(req->flags & REQ_F_PREPPED)) {
+		ret = io_read_prep(req, &iovec, &iter, force_nonblock);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = io_import_iovec(READ, req, &iovec, &iter);
+		if (ret < 0)
+			return ret;
+	}
 
-	read_size = ret;
+	file = req->file;
+	io_size = ret;
 	if (req->flags & REQ_F_LINK)
-		req->result = read_size;
+		req->result = io_size;
+
+	/*
+	 * If the file doesn't support async, mark it as REQ_F_MUST_PUNT so
+	 * we know to async punt it even if it was opened O_NONBLOCK
+	 */
+	if (force_nonblock && !io_file_supports_async(file)) {
+		req->flags |= REQ_F_MUST_PUNT;
+		goto copy_iov;
+	}
 
 	iov_count = iov_iter_count(&iter);
 	ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_count);
@@ -1708,18 +1775,40 @@ static int io_read(struct io_kiocb *req, struct io_kiocb **nxt,
 		 */
 		if (force_nonblock && !(req->flags & REQ_F_NOWAIT) &&
 		    (req->flags & REQ_F_ISREG) &&
-		    ret2 > 0 && ret2 < read_size)
+		    ret2 > 0 && ret2 < io_size)
 			ret2 = -EAGAIN;
 		/* Catch -EAGAIN return for forced non-blocking submission */
-		if (!force_nonblock || ret2 != -EAGAIN)
+		if (!force_nonblock || ret2 != -EAGAIN) {
 			kiocb_done(kiocb, ret2, nxt, req->in_async);
-		else
-			ret = -EAGAIN;
+		} else {
+copy_iov:
+			ret = io_setup_async_io(req, io_size, iovec,
+						inline_vecs, &iter);
+			if (ret)
+				goto out_free;
+			return -EAGAIN;
+		}
 	}
+out_free:
 	kfree(iovec);
 	return ret;
 }
 
+static int io_write_prep(struct io_kiocb *req, struct iovec **iovec,
+			 struct iov_iter *iter, bool force_nonblock)
+{
+	ssize_t ret;
+
+	ret = io_prep_rw(req, force_nonblock);
+	if (ret)
+		return ret;
+
+	if (unlikely(!(req->file->f_mode & FMODE_WRITE)))
+		return -EBADF;
+
+	return io_import_iovec(WRITE, req, iovec, iter);
+}
+
 static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
 		    bool force_nonblock)
 {
@@ -1728,29 +1817,36 @@ static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
 	struct iov_iter iter;
 	struct file *file;
 	size_t iov_count;
-	ssize_t ret;
+	ssize_t ret, io_size;
 
-	ret = io_prep_rw(req, force_nonblock);
-	if (ret)
-		return ret;
+	if (!(req->flags & REQ_F_PREPPED)) {
+		ret = io_write_prep(req, &iovec, &iter, force_nonblock);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = io_import_iovec(WRITE, req, &iovec, &iter);
+		if (ret < 0)
+			return ret;
+	}
 
 	file = kiocb->ki_filp;
-	if (unlikely(!(file->f_mode & FMODE_WRITE)))
-		return -EBADF;
-
-	ret = io_import_iovec(WRITE, req, &iovec, &iter);
-	if (ret < 0)
-		return ret;
-
+	io_size = ret;
 	if (req->flags & REQ_F_LINK)
-		req->result = ret;
+		req->result = io_size;
 
-	iov_count = iov_iter_count(&iter);
+	/*
+	 * If the file doesn't support async, mark it as REQ_F_MUST_PUNT so
+	 * we know to async punt it even if it was opened O_NONBLOCK
+	 */
+	if (force_nonblock && !io_file_supports_async(req->file)) {
+		req->flags |= REQ_F_MUST_PUNT;
+		goto copy_iov;
+	}
 
-	ret = -EAGAIN;
 	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT))
-		goto out_free;
+		goto copy_iov;
 
+	iov_count = iov_iter_count(&iter);
 	ret = rw_verify_area(WRITE, file, &kiocb->ki_pos, iov_count);
 	if (!ret) {
 		ssize_t ret2;
@@ -1774,10 +1870,16 @@ static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
 			ret2 = call_write_iter(file, kiocb, &iter);
 		else
 			ret2 = loop_rw_iter(WRITE, file, kiocb, &iter);
-		if (!force_nonblock || ret2 != -EAGAIN)
+		if (!force_nonblock || ret2 != -EAGAIN) {
 			kiocb_done(kiocb, ret2, nxt, req->in_async);
-		else
-			ret = -EAGAIN;
+		} else {
+copy_iov:
+			ret = io_setup_async_io(req, io_size, iovec,
+						inline_vecs, &iter);
+			if (ret)
+				goto out_free;
+			return -EAGAIN;
+		}
 	}
 out_free:
 	kfree(iovec);
@@ -2603,10 +2705,36 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	return 0;
 }
 
+static int io_req_defer_prep(struct io_kiocb *req, struct io_async_ctx *io)
+{
+	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
+	struct iov_iter iter;
+	ssize_t ret;
+
+	switch (READ_ONCE(req->sqe->opcode)) {
+	case IORING_OP_READV:
+		ret = io_read_prep(req, &iovec, &iter, true);
+		break;
+	case IORING_OP_WRITEV:
+		ret = io_write_prep(req, &iovec, &iter, true);
+		break;
+	default:
+		return 0;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	req->io = io;
+	io_req_map_io(req, ret, iovec, inline_vecs, &iter);
+	return 0;
+}
+
 static int io_req_defer(struct io_kiocb *req)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_async_ctx *io;
+	int ret;
 
 	/* Still need defer if there is pending req in defer list. */
 	if (!req_need_defer(req) && list_empty(&ctx->defer_list))
@@ -2623,9 +2751,9 @@ static int io_req_defer(struct io_kiocb *req)
 		return 0;
 	}
 
-	memcpy(&io->sqe, req->sqe, sizeof(io->sqe));
-	req->sqe = &io->sqe;
-	req->io = io;
+	ret = io_req_defer_prep(req, io);
+	if (ret < 0)
+		return ret;
 
 	trace_io_uring_defer(ctx, req, req->user_data);
 	list_add_tail(&req->list, &ctx->defer_list);
@@ -2958,17 +3086,6 @@ static void __io_queue_sqe(struct io_kiocb *req)
 	 */
 	if (ret == -EAGAIN && (!(req->flags & REQ_F_NOWAIT) ||
 	    (req->flags & REQ_F_MUST_PUNT))) {
-		struct io_async_ctx *io;
-
-		io = kmalloc(sizeof(*io), GFP_KERNEL);
-		if (!io)
-			goto err;
-
-		memcpy(&io->sqe, req->sqe, sizeof(io->sqe));
-
-		req->sqe = &io->sqe;
-		req->io = io;
-
 		if (req->work.flags & IO_WQ_WORK_NEEDS_FILES) {
 			ret = io_grab_files(req);
 			if (ret)
@@ -3090,9 +3207,9 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 			goto err_req;
 		}
 
-		memcpy(&io->sqe, req->sqe, sizeof(io->sqe));
-		req->sqe = &io->sqe;
-		req->io = io;
+		ret = io_req_defer_prep(req, io);
+		if (ret)
+			goto err_req;
 		trace_io_uring_link(ctx, req, prev);
 		list_add_tail(&req->list, &prev->link_list);
 	} else if (req->sqe->flags & IOSQE_IO_LINK) {
-- 
2.24.0

