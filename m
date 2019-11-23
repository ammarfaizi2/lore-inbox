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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E78DC432C0
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 22:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02E020706
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 22:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaDwblGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKWWuP (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 23 Nov 2019 17:50:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46639 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfKWWuP (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 23 Nov 2019 17:50:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so9509476wrl.13
        for <io-uring@vger.kernel.org>; Sat, 23 Nov 2019 14:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iknTRs31ucmsZXMy90dhSEhUrFKlfIP0yK11o72jMmQ=;
        b=uaDwblGpBUB9pPtWVr4i1OtqZ8L0jROSVa7XFgkga8M9fQQuu5v4V7tjQ6un7OciPS
         LIeCRMKZ8bwByEsJujJNuKX7YVoZb1JEomrhYli/XKtgCrYrdJ3abbtsLXLqXjt7aRGj
         Tme2EHX0HzftuWNEsSZ75U/+OAdpvWHhz7teSnZUoeFYYRr8OQOee61swcdXYFF18unT
         xLMW3bXMN2sOMqI4WdIYs3xhqqii0yFMlHQtKOlQI2n6HtQdVPvgldUzdAOiI+zot2vt
         paB/FGFA/LVODmVGYaBPihvrlnJOHyr6OQi2gtkSWIuXNDGnhz07bERQqx3Pwz/Q/UrH
         MZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iknTRs31ucmsZXMy90dhSEhUrFKlfIP0yK11o72jMmQ=;
        b=dakEXWKzn2n3u98AFnyCPZCD2KWqxpdqr5YOmPMaqM0otxO+QepXmRPjbYPYCTXOgo
         txk9L5xjbXH3UdzXECVEu8qSK3t3zaIlQ6Ip4rs0Nh4zxrcgQeQKsCHfgtc68eoNhs4b
         IV4oeixkf4SxhKm8ns0qTKq3BSb05WEXSGDTib/5vlRtPjUl2WhMCMgDfUyfvHaOljos
         lHlWf6i+hOl6WO4mMqFeDaP7NdrA2oB0F6BRdwE+tuIWTEKFu6e47ZrP2nbm4KVRanXg
         FLhPrxQtg4BKG/8BU1M3t6U95lUwuwBKeydjXPFrxQhdVkfrp5oceIr+3MwzJM2qmIpC
         n9GQ==
X-Gm-Message-State: APjAAAUXovelgztlf+bBwGdQ05fxpn9ihUHMMwv9TaDqRZf4tg039fI9
        t6FKl4ai2wwuCmPqGHazuZ7vXFWo
X-Google-Smtp-Source: APXvYqziaOZ3qVTR+2qzHVqJHgEIBG4MNltXQkCa3JYpK3sTN6MEhR1j1MxTeFGuSyfw7fM3A7jHHg==
X-Received: by 2002:adf:f689:: with SMTP id v9mr6131630wrp.28.1574549412654;
        Sat, 23 Nov 2019 14:50:12 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id l10sm4110745wrg.90.2019.11.23.14.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 14:50:12 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 1/2] io_uring: fix dead-hung for non-iter fixed rw
Date:   Sun, 24 Nov 2019 01:49:43 +0300
Message-Id: <1633e8791ecd0661ba59302cc79c3847d56cc714.1574549055.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574549055.git.asml.silence@gmail.com>
References: <cover.1574549055.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Read/write requests to devices without implemented read/write_iter
using fixed buffers causes general protection fault, which totally
hanged up a machine.

io_import_fixed() initialises iov_iter as a bvec, but loop_rw_iter()
tries to access its unitialised iov, so dereferencing random address.

Fix it by passing a userspace ptr instead in this case.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 60 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8119cbae4fb6..566e987c6dab 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -172,6 +172,11 @@ struct io_mapped_ubuf {
 	unsigned int	nr_bvecs;
 };
 
+struct io_ubuf_iter {
+	struct iov_iter	it;
+	u64		ubuf;
+};
+
 struct fixed_file_table {
 	struct file		**files;
 };
@@ -1486,7 +1491,7 @@ static void kiocb_done(struct kiocb *kiocb, ssize_t ret, struct io_kiocb **nxt,
 
 static ssize_t io_import_fixed(struct io_ring_ctx *ctx, int rw,
 				const struct io_uring_sqe *sqe,
-				struct iov_iter *iter)
+				struct io_ubuf_iter *iter)
 {
 	size_t len = READ_ONCE(sqe->len);
 	struct io_mapped_ubuf *imu;
@@ -1513,12 +1518,14 @@ static ssize_t io_import_fixed(struct io_ring_ctx *ctx, int rw,
 	if (buf_addr < imu->ubuf || buf_addr + len > imu->ubuf + imu->len)
 		return -EFAULT;
 
+	iter->ubuf = buf_addr;
+
 	/*
 	 * May not be a start of buffer, set size appropriately
 	 * and advance us to the beginning.
 	 */
 	offset = buf_addr - imu->ubuf;
-	iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs, offset + len);
+	iov_iter_bvec(&iter->it, rw, imu->bvec, imu->nr_bvecs, offset + len);
 
 	if (offset) {
 		/*
@@ -1540,7 +1547,7 @@ static ssize_t io_import_fixed(struct io_ring_ctx *ctx, int rw,
 		const struct bio_vec *bvec = imu->bvec;
 
 		if (offset <= bvec->bv_len) {
-			iov_iter_advance(iter, offset);
+			iov_iter_advance(&iter->it, offset);
 		} else {
 			unsigned long seg_skip;
 
@@ -1548,25 +1555,27 @@ static ssize_t io_import_fixed(struct io_ring_ctx *ctx, int rw,
 			offset -= bvec->bv_len;
 			seg_skip = 1 + (offset >> PAGE_SHIFT);
 
-			iter->bvec = bvec + seg_skip;
-			iter->nr_segs -= seg_skip;
-			iter->count -= bvec->bv_len + offset;
-			iter->iov_offset = offset & ~PAGE_MASK;
+			iter->it.bvec = bvec + seg_skip;
+			iter->it.nr_segs -= seg_skip;
+			iter->it.count -= bvec->bv_len + offset;
+			iter->it.iov_offset = offset & ~PAGE_MASK;
 		}
 	}
 
-	return iter->count;
+	return iter->it.count;
 }
 
 static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
 			       const struct sqe_submit *s, struct iovec **iovec,
-			       struct iov_iter *iter)
+			       struct io_ubuf_iter *iter)
 {
 	const struct io_uring_sqe *sqe = s->sqe;
 	void __user *buf = u64_to_user_ptr(READ_ONCE(sqe->addr));
 	size_t sqe_len = READ_ONCE(sqe->len);
 	u8 opcode;
 
+	iter->ubuf = 0;
+
 	/*
 	 * We're reading ->opcode for the second time, but the first read
 	 * doesn't care whether it's _FIXED or not, so it doesn't matter
@@ -1587,10 +1596,10 @@ static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
 #ifdef CONFIG_COMPAT
 	if (ctx->compat)
 		return compat_import_iovec(rw, buf, sqe_len, UIO_FASTIOV,
-						iovec, iter);
+						iovec, &iter->it);
 #endif
 
-	return import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec, iter);
+	return import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec, &iter->it);
 }
 
 /*
@@ -1598,7 +1607,7 @@ static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
  * by looping over ->read() or ->write() manually.
  */
 static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
-			   struct iov_iter *iter)
+			   struct io_ubuf_iter *iter)
 {
 	ssize_t ret = 0;
 
@@ -1612,10 +1621,17 @@ static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
 	if (kiocb->ki_flags & IOCB_NOWAIT)
 		return -EAGAIN;
 
-	while (iov_iter_count(iter)) {
-		struct iovec iovec = iov_iter_iovec(iter);
+	while (iov_iter_count(&iter->it)) {
+		struct iovec iovec;
 		ssize_t nr;
 
+		if (iter_is_iovec(&iter->it)) {
+			iovec = iov_iter_iovec(&iter->it);
+		} else {
+			iovec.iov_base = (void __user *)iter->ubuf;
+			iovec.iov_len = iov_iter_count(&iter->it);
+		}
+
 		if (rw == READ) {
 			nr = file->f_op->read(file, iovec.iov_base,
 					      iovec.iov_len, &kiocb->ki_pos);
@@ -1630,9 +1646,11 @@ static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
 			break;
 		}
 		ret += nr;
+		iter->ubuf += nr;
+
 		if (nr != iovec.iov_len)
 			break;
-		iov_iter_advance(iter, nr);
+		iov_iter_advance(&iter->it, nr);
 	}
 
 	return ret;
@@ -1643,7 +1661,7 @@ static int io_read(struct io_kiocb *req, struct io_kiocb **nxt,
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
-	struct iov_iter iter;
+	struct io_ubuf_iter iter;
 	struct file *file;
 	size_t iov_count;
 	ssize_t read_size, ret;
@@ -1664,13 +1682,13 @@ static int io_read(struct io_kiocb *req, struct io_kiocb **nxt,
 	if (req->flags & REQ_F_LINK)
 		req->result = read_size;
 
-	iov_count = iov_iter_count(&iter);
+	iov_count = iov_iter_count(&iter.it);
 	ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_count);
 	if (!ret) {
 		ssize_t ret2;
 
 		if (file->f_op->read_iter)
-			ret2 = call_read_iter(file, kiocb, &iter);
+			ret2 = call_read_iter(file, kiocb, &iter.it);
 		else
 			ret2 = loop_rw_iter(READ, file, kiocb, &iter);
 
@@ -1701,7 +1719,7 @@ static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
-	struct iov_iter iter;
+	struct io_ubuf_iter iter;
 	struct file *file;
 	size_t iov_count;
 	ssize_t ret;
@@ -1721,7 +1739,7 @@ static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
 	if (req->flags & REQ_F_LINK)
 		req->result = ret;
 
-	iov_count = iov_iter_count(&iter);
+	iov_count = iov_iter_count(&iter.it);
 
 	ret = -EAGAIN;
 	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT))
@@ -1747,7 +1765,7 @@ static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
 		kiocb->ki_flags |= IOCB_WRITE;
 
 		if (file->f_op->write_iter)
-			ret2 = call_write_iter(file, kiocb, &iter);
+			ret2 = call_write_iter(file, kiocb, &iter.it);
 		else
 			ret2 = loop_rw_iter(WRITE, file, kiocb, &iter);
 		if (!force_nonblock || ret2 != -EAGAIN)
-- 
2.24.0

