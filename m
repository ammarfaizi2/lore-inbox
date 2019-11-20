Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE755C432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64C02075E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v4VjyCf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfKTUKG (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:10:06 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35416 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfKTUKG (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 15:10:06 -0500
Received: by mail-il1-f193.google.com with SMTP id z12so884330ilp.2
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 12:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2yGtzHTyYTjMZqkCyggLrPp2wT/FQ57LcjSs7Dy1D8M=;
        b=v4VjyCf7TQkHGX55aMvCBRVzgsnTFxH5/Ymbqa/iB+cJVtZeKPIkJRNiSXMIzQg0/S
         w/38GhFvS/GsYD9nAzZUwiO+kY8eRd6r3WJ9NmAxDYEKIVpQh0xBP33VuSHiAcXFW0w8
         Rmi69wRYtFcVM3e7KkqANes48Y1XDHEQHrsVUY+ZyO1G50rASw9EKdFQBC6h2wm2eQFh
         Xnc3o66KDqbqRG1UDujx8Vg1i6vGBJw0+0gDIjDpMv6LAj4WgC6PSmSS2/KJOHtALceq
         v5a4/N3weInnnCT3GBcpoi+4+GnVr/HYvme6HZOV0NixtxZCbgD7Ygzn3j3a3PwRXa7K
         Zv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2yGtzHTyYTjMZqkCyggLrPp2wT/FQ57LcjSs7Dy1D8M=;
        b=cLxW1Sv4Vt81euufyT4+uX07MBKMTFluuwQyHfvfYqCCZLzuts98dmUcHJKGnMNqAw
         vcH7E5i6fpL7wZwiQ2N6ZR8wVJbLpi207iDEJC7U4rPkpxt81gFZ1MnWcXy3k+V9VfTh
         dXwWsJ1KKh5nYMtl6t8URRB6ZHA3UcqzASRCn0Hjc1gjz+TtwILDZNqoA0ESBscuAI6C
         ffPArJxM5Jg9YWW2sUyekxE1agnsLAtt7a1XV+uGgthdOnEphfV+5OVsWrRR6pjdQOOm
         fLS/QcCJ99GgMmbWGP238hhrZVpxx+Jp4yCmt+QvNJJW5veD3KvqLxMLNMLdcbeKb+vd
         OZqg==
X-Gm-Message-State: APjAAAXx2PtoQD9mlHpBCK/jQFRCyJdzR6KnyRQ0z1dIxoRgWxuUaKSj
        ac1XY87JTIlZauM2S8su6zGpf+Imq5c2Vw==
X-Google-Smtp-Source: APXvYqzF82qZBuoXA1EUG4pW0zL3sCPkCC4jPq1lYHfIw9cAlcnxsXJkIz5ogkWZVdz90tKsra5ZNg==
X-Received: by 2002:a92:ce0d:: with SMTP id b13mr5673376ilo.26.1574280604439;
        Wed, 20 Nov 2019 12:10:04 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e25sm48012iol.36.2019.11.20.12.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 12:10:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/7] io_uring: Always REQ_F_FREE_SQE for allocated sqe
Date:   Wed, 20 Nov 2019 13:09:37 -0700
Message-Id: <20191120200936.22588-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120200936.22588-1-axboe@kernel.dk>
References: <20191120200936.22588-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Always mark requests with allocated sqe and deallocate it in
__io_free_req(). It's easier to follow and doesn't add edge cases.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 49 ++++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d1085e4e8ae9..df7f5ce5bb06 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -829,6 +829,8 @@ static void __io_free_req(struct io_kiocb *req)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 
+	if (req->flags & REQ_F_FREE_SQE)
+		kfree(req->submit.sqe);
 	if (req->file && !(req->flags & REQ_F_FIXED_FILE))
 		fput(req->file);
 	if (req->flags & REQ_F_INFLIGHT) {
@@ -924,16 +926,11 @@ static void io_fail_links(struct io_kiocb *req)
 	spin_lock_irqsave(&ctx->completion_lock, flags);
 
 	while (!list_empty(&req->link_list)) {
-		const struct io_uring_sqe *sqe_to_free = NULL;
-
 		link = list_first_entry(&req->link_list, struct io_kiocb, list);
 		list_del_init(&link->list);
 
 		trace_io_uring_fail_link(req, link);
 
-		if (link->flags & REQ_F_FREE_SQE)
-			sqe_to_free = link->submit.sqe;
-
 		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
 		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
 			io_link_cancel_timeout(link);
@@ -941,7 +938,6 @@ static void io_fail_links(struct io_kiocb *req)
 			io_cqring_fill_event(link, -ECANCELED);
 			__io_double_put_req(link);
 		}
-		kfree(sqe_to_free);
 		req->flags &= ~REQ_F_LINK_TIMEOUT;
 	}
 
@@ -1084,7 +1080,8 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			 * completions for those, only batch free for fixed
 			 * file and non-linked commands.
 			 */
-			if (((req->flags & (REQ_F_FIXED_FILE|REQ_F_LINK)) ==
+			if (((req->flags &
+				(REQ_F_FIXED_FILE|REQ_F_LINK|REQ_F_FREE_SQE)) ==
 			    REQ_F_FIXED_FILE) && !io_is_fallback_req(req)) {
 				reqs[to_free++] = req;
 				if (to_free == ARRAY_SIZE(reqs))
@@ -2567,6 +2564,7 @@ static int io_req_defer(struct io_kiocb *req)
 	}
 
 	memcpy(sqe_copy, sqe, sizeof(*sqe_copy));
+	req->flags |= REQ_F_FREE_SQE;
 	req->submit.sqe = sqe_copy;
 
 	trace_io_uring_defer(ctx, req, false);
@@ -2661,7 +2659,6 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 	struct io_wq_work *work = *workptr;
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
 	struct sqe_submit *s = &req->submit;
-	const struct io_uring_sqe *sqe = s->sqe;
 	struct io_kiocb *nxt = NULL;
 	int ret = 0;
 
@@ -2697,9 +2694,6 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 		io_put_req(req);
 	}
 
-	/* async context always use a copy of the sqe */
-	kfree(sqe);
-
 	/* if a dependent link is ready, pass it back */
 	if (!ret && nxt) {
 		struct io_kiocb *link;
@@ -2897,23 +2891,24 @@ static void __io_queue_sqe(struct io_kiocb *req)
 		struct io_uring_sqe *sqe_copy;
 
 		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
-		if (sqe_copy) {
-			s->sqe = sqe_copy;
-			if (req->work.flags & IO_WQ_WORK_NEEDS_FILES) {
-				ret = io_grab_files(req);
-				if (ret) {
-					kfree(sqe_copy);
-					goto err;
-				}
-			}
+		if (!sqe_copy)
+			goto err;
 
-			/*
-			 * Queued up for async execution, worker will release
-			 * submit reference when the iocb is actually submitted.
-			 */
-			io_queue_async_work(req);
-			return;
+		s->sqe = sqe_copy;
+		req->flags |= REQ_F_FREE_SQE;
+
+		if (req->work.flags & IO_WQ_WORK_NEEDS_FILES) {
+			ret = io_grab_files(req);
+			if (ret)
+				goto err;
 		}
+
+		/*
+		 * Queued up for async execution, worker will release
+		 * submit reference when the iocb is actually submitted.
+		 */
+		io_queue_async_work(req);
+		return;
 	}
 
 err:
@@ -3008,7 +3003,6 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 			  struct io_kiocb **link)
 {
-	struct io_uring_sqe *sqe_copy;
 	struct sqe_submit *s = &req->submit;
 	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
@@ -3038,6 +3032,7 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 	 */
 	if (*link) {
 		struct io_kiocb *prev = *link;
+		struct io_uring_sqe *sqe_copy;
 
 		if (READ_ONCE(s->sqe->opcode) == IORING_OP_LINK_TIMEOUT) {
 			ret = io_timeout_setup(req);
-- 
2.24.0

