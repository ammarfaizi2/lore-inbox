Return-Path: <SRS0=5OhC=ZL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222C4C432C0
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0962240E
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKIXG8nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfKSUdS (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:33:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41729 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSUdS (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 15:33:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id b18so24068413wrj.8
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 12:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Awh/8B+l8qNqi46Eoe7rb12NgJmClF09Vzhqfq+DgCI=;
        b=kKIXG8ntqlndWNQNdNvLtwp958FkbU5EmMlkd3NiSGs3cCDb863wfVgd+IZDtqrpyq
         GePxoOyD1e88Ee1T/hmy6ABIR6PbDhCtPkKTo4vFmZBClX1ZSk/DRVhs6GJXR/yXx7Be
         pkDlzaZJTtS5XU56KA7Mik/8keEqqJ+qZxTGViTwxgdAxFie/kdOxbMEkFxm5WPbkFF3
         fUMY6g7ORGwCZj+v3wA/L/ASCYEDcujJJjD2YA8odbE97A6R5uyXq/atO+Jok/OKhGW/
         QCg1+IJzPvdr6T73YW+9+5+JjRXGAk4uBYLfbaVso2Ik1TGjk/9pDSIhofJccSNOzzL5
         tAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Awh/8B+l8qNqi46Eoe7rb12NgJmClF09Vzhqfq+DgCI=;
        b=riG2OfmVixmON9Amzh1jC2yAf0ZSMIUNXl4codHfEI0F+nsJpxYZ+/gnybZ1Cb3fGK
         uuu0K5ztVnvAM61Zuh6hoE5PYC7qE4gBbIDLprgHMyYGWDjs+crjnyXNq5XsWKZA3oNt
         VIn2ckUjFqWaSnsjBbr4c5isTezy01U6REShKgcsDfcfeNzh/nwNtOvdqdVx3DcHzyD4
         X9rYOO7UkPDplYn3w49SvetQ/gugLN70kN9Z5UYJqyRP137A03aqtfp7d8hXxaLuAPKL
         HtwXyRk/vltSV5gt0RE7sRRmAu/yJTJowuHB1Fi1fhmeNFOljG4XLe4jOPzKbiG+hkDk
         IUDA==
X-Gm-Message-State: APjAAAVm/n08rHYGrJnrfHcnhIu0FkERvLjf3ztLwZPI+FOdxiUicFUw
        o76Lyjelg9zDX4h/mtNW3rIBp/WG
X-Google-Smtp-Source: APXvYqz51iJKTxyh83jtTfxDG6dqmndGRTstxb0zPB0UJm2wcc3dvvZJLQbkoR91wmL1bSz+3cLAxw==
X-Received: by 2002:adf:9e92:: with SMTP id a18mr38840221wrf.34.1574195595509;
        Tue, 19 Nov 2019 12:33:15 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id g184sm4605981wma.8.2019.11.19.12.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 12:33:14 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 1/4] io_uring: Always REQ_F_FREE_SQE for allocated sqe
Date:   Tue, 19 Nov 2019 23:32:47 +0300
Message-Id: <d879b9ce9ea9d47129d8f0a093bc96ce5dc3f54d.1574195129.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574195129.git.asml.silence@gmail.com>
References: <cover.1574195129.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Always mark requests with allocated sqe and deallocate it in
__io_free_req(). It's easier to follow and doesn't add edge cases.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 49 ++++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 09a96516f690..ca3c5e979918 100644
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
 	}
 
 	io_commit_cqring(ctx);
@@ -1083,7 +1079,8 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			 * completions for those, only batch free for fixed
 			 * file and non-linked commands.
 			 */
-			if (((req->flags & (REQ_F_FIXED_FILE|REQ_F_LINK)) ==
+			if (((req->flags &
+				(REQ_F_FIXED_FILE|REQ_F_LINK|REQ_F_FREE_SQE)) ==
 			    REQ_F_FIXED_FILE) && !io_is_fallback_req(req)) {
 				reqs[to_free++] = req;
 				if (to_free == ARRAY_SIZE(reqs))
@@ -2566,6 +2563,7 @@ static int io_req_defer(struct io_kiocb *req)
 	}
 
 	memcpy(sqe_copy, sqe, sizeof(*sqe_copy));
+	req->flags |= REQ_F_FREE_SQE;
 	req->submit.sqe = sqe_copy;
 
 	trace_io_uring_defer(ctx, req, false);
@@ -2660,7 +2658,6 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 	struct io_wq_work *work = *workptr;
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
 	struct sqe_submit *s = &req->submit;
-	const struct io_uring_sqe *sqe = s->sqe;
 	struct io_kiocb *nxt = NULL;
 	int ret = 0;
 
@@ -2696,9 +2693,6 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 		io_put_req(req);
 	}
 
-	/* async context always use a copy of the sqe */
-	kfree(sqe);
-
 	/* if a dependent link is ready, pass it back */
 	if (!ret && nxt) {
 		struct io_kiocb *link;
@@ -2896,23 +2890,24 @@ static void __io_queue_sqe(struct io_kiocb *req)
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
@@ -3003,7 +2998,6 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 			  struct io_kiocb **link)
 {
-	struct io_uring_sqe *sqe_copy;
 	struct sqe_submit *s = &req->submit;
 	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
@@ -3033,6 +3027,7 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 	 */
 	if (*link) {
 		struct io_kiocb *prev = *link;
+		struct io_uring_sqe *sqe_copy;
 
 		if (READ_ONCE(s->sqe->opcode) == IORING_OP_LINK_TIMEOUT) {
 			ret = io_timeout_setup(req);
-- 
2.24.0

