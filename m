Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0704C43141
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED29206E3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c9YQiY1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfKMVcM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:32:12 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45055 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfKMVcM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:32:12 -0500
Received: by mail-il1-f195.google.com with SMTP id i6so3200137ilr.11
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXleKxJHnAMFj+IImco3GMPRbLovDZwkpuyp6sbad9M=;
        b=c9YQiY1o2ekHYcRcdyqvE789/Kq0YXtSKsAcugFmUp8AK0Pl0fEEWHPuXMLcM/Di9z
         XrNx2ox47MVzfhCAk3yVd8fBc3GiEDybtTi9U9alJUY/jN6Y+Mopb4heoh/WfJtoCzM9
         VbYJ+4X8hO+pzsJJVMDshMPDoazQB5UozowZpnp1YusozSqOLix/rhUZl6Dspe9lY7KB
         Fd5c0g/MaT7ylDxQDca2zO34bCwctI8laPbcAYhTelt3zIt9bgaPIYbUaoXq9kP90OfB
         bY0w9utuAbwc5TXvz9GzR17ST6NxQqEL2DIF6e7Y7/7fU8+i7gqRV4xS+ZQvqrzSD/pg
         1bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXleKxJHnAMFj+IImco3GMPRbLovDZwkpuyp6sbad9M=;
        b=q9NAyyFra/lOv2RVYO5norCQHWAG6TWjAKwPKXZk4yv0GC5uVkUkGpPaLJzrtfYeTx
         FoLj+ggbH0lirI+DPDHLhku3yRmOl4cnYjtg8zfsmePXKJTTys0daSJTLLi4vS65EqV5
         e4i6uOPKOAoxk1fEZqEo2ufS3CXrHYrvnSsWR9a66RDW2UF8CSsGgNHpO4ugwocym12I
         QrOLeYkvvrmKTzwGAN7FYccMb/oRNuUq7GiHj52SfjnF5tmsGs3mrNBtdQ8/9hJbzVv/
         wrU6B9lsZv3FLkXUeIGqRvU13JCFYXJwLj5W2W8QUlmIdRMNsXHdAVod9u+0z6U9terC
         osIQ==
X-Gm-Message-State: APjAAAVfUe2Dcg9vag/D+Qpd7f3ulTd9t/ZOgzBp2NS0vtFShL05vQDJ
        +QRAhd5lRbF98XMi+zTeoH4HTmEm8nc=
X-Google-Smtp-Source: APXvYqyHFkzZw95vrk2arvUuOtr9sx8sMeSKGr1be8aokmxGCF/QbTVSPqzVjBmZ10Qw0eQWvynQlQ==
X-Received: by 2002:a92:d7c2:: with SMTP id g2mr6902073ilq.81.1573680730683;
        Wed, 13 Nov 2019 13:32:10 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 6sm304872iov.45.2019.11.13.13.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:32:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     paulmck@kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] io_wq: add get/put_work handlers to io_wq_create()
Date:   Wed, 13 Nov 2019 14:32:04 -0700
Message-Id: <20191113213206.2415-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113213206.2415-1-axboe@kernel.dk>
References: <20191113213206.2415-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

For cancellation, we need to ensure that the work item stays valid for
as long as ->cur_work is valid. Right now we can't safely dereference
the work item even under the wqe->lock, because while the ->cur_work
pointer will remain valid, the work could be completing and be freed
in parallel.

Only invoke ->get/put_work() on items we know that the caller queued
themselves. Add IO_WQ_WORK_INTERNAL for io-wq to use, which is needed
when we're queueing a flush item, for instance.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c    | 25 +++++++++++++++++++++++--
 fs/io-wq.h    |  7 ++++++-
 fs/io_uring.c | 17 ++++++++++++++++-
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 33b14b85752b..26d81540c1fc 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -106,6 +106,9 @@ struct io_wq {
 	unsigned long state;
 	unsigned nr_wqes;
 
+	get_work_fn *get_work;
+	put_work_fn *put_work;
+
 	struct task_struct *manager;
 	struct user_struct *user;
 	struct mm_struct *mm;
@@ -392,7 +395,7 @@ static struct io_wq_work *io_get_next_work(struct io_wqe *wqe, unsigned *hash)
 static void io_worker_handle_work(struct io_worker *worker)
 	__releases(wqe->lock)
 {
-	struct io_wq_work *work, *old_work;
+	struct io_wq_work *work, *old_work = NULL, *put_work = NULL;
 	struct io_wqe *wqe = worker->wqe;
 	struct io_wq *wq = wqe->wq;
 
@@ -424,6 +427,8 @@ static void io_worker_handle_work(struct io_worker *worker)
 			wqe->flags |= IO_WQE_FLAG_STALLED;
 
 		spin_unlock_irq(&wqe->lock);
+		if (put_work && wq->put_work)
+			wq->put_work(old_work);
 		if (!work)
 			break;
 next:
@@ -444,6 +449,11 @@ static void io_worker_handle_work(struct io_worker *worker)
 		if (worker->mm)
 			work->flags |= IO_WQ_WORK_HAS_MM;
 
+		if (wq->get_work && !(work->flags & IO_WQ_WORK_INTERNAL)) {
+			put_work = work;
+			wq->get_work(work);
+		}
+
 		old_work = work;
 		work->func(&work);
 
@@ -455,6 +465,12 @@ static void io_worker_handle_work(struct io_worker *worker)
 		}
 		if (work && work != old_work) {
 			spin_unlock_irq(&wqe->lock);
+
+			if (put_work && wq->put_work) {
+				wq->put_work(put_work);
+				put_work = NULL;
+			}
+
 			/* dependent work not hashed */
 			hash = -1U;
 			goto next;
@@ -950,13 +966,15 @@ void io_wq_flush(struct io_wq *wq)
 
 		init_completion(&data.done);
 		INIT_IO_WORK(&data.work, io_wq_flush_func);
+		data.work.flags |= IO_WQ_WORK_INTERNAL;
 		io_wqe_enqueue(wqe, &data.work);
 		wait_for_completion(&data.done);
 	}
 }
 
 struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
-			   struct user_struct *user)
+			   struct user_struct *user, get_work_fn *get_work,
+			   put_work_fn *put_work)
 {
 	int ret = -ENOMEM, i, node;
 	struct io_wq *wq;
@@ -972,6 +990,9 @@ struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	wq->get_work = get_work;
+	wq->put_work = put_work;
+
 	/* caller must already hold a reference to this */
 	wq->user = user;
 
diff --git a/fs/io-wq.h b/fs/io-wq.h
index cc50754d028c..4b29f922f80c 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -10,6 +10,7 @@ enum {
 	IO_WQ_WORK_NEEDS_USER	= 8,
 	IO_WQ_WORK_NEEDS_FILES	= 16,
 	IO_WQ_WORK_UNBOUND	= 32,
+	IO_WQ_WORK_INTERNAL	= 64,
 
 	IO_WQ_HASH_SHIFT	= 24,	/* upper 8 bits are used for hash key */
 };
@@ -34,8 +35,12 @@ struct io_wq_work {
 		(work)->files = NULL;			\
 	} while (0)					\
 
+typedef void (get_work_fn)(struct io_wq_work *);
+typedef void (put_work_fn)(struct io_wq_work *);
+
 struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
-				struct user_struct *user);
+				struct user_struct *user,
+				get_work_fn *get_work, put_work_fn *put_work);
 void io_wq_destroy(struct io_wq *wq);
 
 void io_wq_enqueue(struct io_wq *wq, struct io_wq_work *work);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 99822bf89924..e1a3b8b667e0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3822,6 +3822,20 @@ static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
 	return done ? done : err;
 }
 
+static void io_put_work(struct io_wq_work *work)
+{
+	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
+
+	io_put_req(req);
+}
+
+static void io_get_work(struct io_wq_work *work)
+{
+	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
+
+	refcount_inc(&req->refs);
+}
+
 static int io_sq_offload_start(struct io_ring_ctx *ctx,
 			       struct io_uring_params *p)
 {
@@ -3871,7 +3885,8 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 
 	/* Do QD, or 4 * CPUS, whatever is smallest */
 	concurrency = min(ctx->sq_entries, 4 * num_online_cpus());
-	ctx->io_wq = io_wq_create(concurrency, ctx->sqo_mm, ctx->user);
+	ctx->io_wq = io_wq_create(concurrency, ctx->sqo_mm, ctx->user,
+					io_get_work, io_put_work);
 	if (IS_ERR(ctx->io_wq)) {
 		ret = PTR_ERR(ctx->io_wq);
 		ctx->io_wq = NULL;
-- 
2.24.0

