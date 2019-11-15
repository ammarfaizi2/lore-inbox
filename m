Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF59BC432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 04:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A692072A
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 04:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="B1vFrXAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKOE4P (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 14 Nov 2019 23:56:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45824 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKOE4P (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 14 Nov 2019 23:56:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id k1so3903211pgg.12
        for <io-uring@vger.kernel.org>; Thu, 14 Nov 2019 20:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1L07Io7m8zwFbRqB5VHI7zaBHO+mLF/JO/H1LKf8F90=;
        b=B1vFrXAAd0dzQO7r6Ka1mcp74O6CsaKyOVWg7TAe/z6Q0fJBrCGzphweGHx5gNsIYJ
         u1fqpj2EslL2ZA+crtXUR0n9Z1h22h0QCbd73J+u22pH9DQ4za1NwYkF1bvHFNx+t1mV
         gfP68Cl6rOaZv7eQAaR4s1m33DOKHuZQMPQKISMkjhBks8a6S8BSU7pEohvJ9Y8MWb2y
         F1zeviNiiNd4O7K/qGJOEs/X+1zs793hOLU/gaZpjmQncvv0K8BHDg5520bOjn5fDCPT
         BhG+iWOTW+RYTErhn3zzjyniTOA0ALNQdVqwNJWARC40q7HTWkvF//yaVabNUwJBUfd8
         g1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1L07Io7m8zwFbRqB5VHI7zaBHO+mLF/JO/H1LKf8F90=;
        b=TjboU1c0jyF0Z9nYReTM7DJQAF+TsL09uMOwS85klvoX6nlpI/qRn4ske4fQIeA0VN
         rG5FMTNMzfTNSY+swcAnjQhlFCDmQj2ZZOTKNYiblpq1vcd+E7ovqcaExBqT0MMaiu+i
         gRrW42Wsg9MM4XTUwWA6PICEPxeWoxpVyW8JYPqaseBDwTX5riTCUUdvOnU+cGpfsGl3
         OnvtcLyBKMXNtstgSpvoLsNJXbyjBu6+3Es8rf/xSCg2V/+oNTrhUfRjW3dMzOSS+ajm
         5JQcOZhL/NHmUnWIf2XQwxy3YQCum7yKwR8ThEkSkJTy87fiqvbl76HFRGikEFGQ0TtV
         Nh6w==
X-Gm-Message-State: APjAAAXk2hk4nTeG5mc/BuroAzrWbH8lh1SfsiRDCN/JPRFHScakS18O
        YQ6ePpQ2U++24gJNUZr5vGFUMBh+3Ao=
X-Google-Smtp-Source: APXvYqyDwGCvEXRvsCeXH5OUQps5l7gib31y5xIi6ZpJW3qZPEE3U6CiIZP6CIjzPHdSNvumym0Wsg==
X-Received: by 2002:a62:ee0c:: with SMTP id e12mr15656337pfi.38.1573793772237;
        Thu, 14 Nov 2019 20:56:12 -0800 (PST)
Received: from x1.localdomain ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id w7sm9192366pfb.101.2019.11.14.20.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 20:56:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] io_uring: fix sequencing issues with linked timeouts
Date:   Thu, 14 Nov 2019 21:56:03 -0700
Message-Id: <20191115045603.15158-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115045603.15158-1-axboe@kernel.dk>
References: <20191115045603.15158-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We can't easily support multiple linked timeouts in a chain, and it's
not a given that it even makes sense to do so. For now, make it
explicitly illegal, we'll error the head request with -ENOLINK and
the rest of the chain will get cancelled as they do with other errors.

Ensure that we handle the sequencing of linked timeouts correctly as
well. The loop in io_req_link_next() isn't necessary, and it will never
do anything, because we can't have both REQ_F_LINK_TIMEOUT set and have
dependent links.

Reported-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b9965f2f69ca..c148a56b5894 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -345,6 +345,7 @@ struct io_kiocb {
 #define REQ_F_MUST_PUNT		4096	/* must be punted even for NONBLOCK */
 #define REQ_F_INFLIGHT		8192	/* on inflight list */
 #define REQ_F_COMP_LOCKED	16384	/* completion under lock */
+#define REQ_F_FREE_SQE		32768
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -858,30 +859,26 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	 * safe side.
 	 */
 	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
-	while (nxt) {
+	if (nxt) {
 		list_del_init(&nxt->list);
 		if (!list_empty(&req->link_list)) {
 			INIT_LIST_HEAD(&nxt->link_list);
 			list_splice(&req->link_list, &nxt->link_list);
 			nxt->flags |= REQ_F_LINK;
+		} else if (req->flags & REQ_F_LINK_TIMEOUT) {
+			wake_ev = io_link_cancel_timeout(nxt);
+			nxt = NULL;
 		}
 
 		/*
 		 * If we're in async work, we can continue processing the chain
 		 * in this context instead of having to queue up new async work.
 		 */
-		if (req->flags & REQ_F_LINK_TIMEOUT) {
-			wake_ev = io_link_cancel_timeout(nxt);
-
-			/* we dropped this link, get next */
-			nxt = list_first_entry_or_null(&req->link_list,
-							struct io_kiocb, list);
-		} else if (nxtptr && io_wq_current_is_worker()) {
-			*nxtptr = nxt;
-			break;
-		} else {
-			io_queue_async_work(nxt);
-			break;
+		if (nxt) {
+			if (nxtptr && io_wq_current_is_worker())
+				*nxtptr = nxt;
+			else
+				io_queue_async_work(nxt);
 		}
 	}
 
@@ -906,6 +903,9 @@ static void io_fail_links(struct io_kiocb *req)
 
 		trace_io_uring_fail_link(req, link);
 
+		if (req->flags & REQ_F_FREE_SQE)
+			kfree(link->submit.sqe);
+
 		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
 		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
 			io_link_cancel_timeout(link);
@@ -2465,7 +2465,7 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	    sqe->cancel_flags)
 		return -EINVAL;
 
-	io_async_find_and_cancel(ctx, req, READ_ONCE(sqe->addr), NULL);
+	io_async_find_and_cancel(ctx, req, READ_ONCE(sqe->addr), nxt);
 	return 0;
 }
 
@@ -2741,10 +2741,12 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	 */
 	if (!list_empty(&req->list)) {
 		prev = list_entry(req->list.prev, struct io_kiocb, link_list);
-		if (refcount_inc_not_zero(&prev->refs))
+		if (refcount_inc_not_zero(&prev->refs)) {
+			prev->flags &= ~REQ_F_LINK_TIMEOUT;
 			list_del_init(&req->list);
-		else
+		} else {
 			prev = NULL;
+		}
 	}
 
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
@@ -2914,6 +2916,10 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 	int need_submit = false;
 	struct io_ring_ctx *ctx = req->ctx;
 
+	if (unlikely(req->flags & REQ_F_FAIL_LINK)) {
+		ret = -ENOLINK;
+		goto err;
+	}
 	if (!shadow) {
 		io_queue_sqe(req);
 		return;
@@ -2928,9 +2934,13 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 	ret = io_req_defer(req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
+err:
 			io_cqring_add_event(req, ret);
-			io_double_put_req(req);
-			__io_free_req(shadow);
+			/* need to ensure we fail links */
+			io_put_req(req);
+			io_put_req(req);
+			if (shadow)
+				__io_free_req(shadow);
 			return;
 		}
 	} else {
@@ -2987,6 +2997,11 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 	if (*link) {
 		struct io_kiocb *prev = *link;
 
+		/* For now, linked timeouts must be first linked request */
+		if (READ_ONCE(s->sqe->opcode) == IORING_OP_LINK_TIMEOUT &&
+		    !list_empty(&prev->link_list))
+			prev->flags |= REQ_F_FAIL_LINK | REQ_F_FREE_SQE;
+
 		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
 		if (!sqe_copy) {
 			ret = -EAGAIN;
-- 
2.24.0

