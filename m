Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72359C432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 16:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457642068E
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 16:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VuiONNAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfKYQsY (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:48:24 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45450 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfKYQsX (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 11:48:23 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so6089930ioi.12
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 08:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aN8pV2uXKQAm1f3vHGhHHU35zaycqf8BeNZaIAU5NoQ=;
        b=VuiONNAINvJoBi83Ua3mfMnktcYa4XASZhdtVIye0Q5bBp8vPHzKWsB+k0RiE9/tDz
         3aVCC7bDY2huta3N+pxAybqiWCAL2O61OTi9rnxsOsEWoAAaFjw/CxxdyeCI13CAiDyL
         u+48kHS2p3PxmKah/vRlmZ+3GCD+FguOGmkdj7s7CgaPGQHSkNXQ8Lr7sEgHKIO8gBIp
         Jl4HFc5+hhxxzl4uXgL61u6bVd5BA5EWhr5yGg3YBP9Dk1QYFbzi9oDDBp4TpjXT7J5/
         VMVW7be1VOIHArm4/x2c9vb+UjMN6k3qJQXqmzYLmGRZjHD2u1qbU9oiUhBqT0hhkrOA
         lRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aN8pV2uXKQAm1f3vHGhHHU35zaycqf8BeNZaIAU5NoQ=;
        b=mZjfRB3cF/bW90g4HKNXtjsQgzrTHqqz7TuU8D57NzuNiSBH4KhfRp+VejGT+4+lyY
         1WvV3KCSPcyfFJY5jPeiyGP78Fs8bcR0LXZ2qewU+5/cOUQ6/KCR2AkaQAhJ3F3u2U4l
         I31gts/+cPqEdmjJit977qQSAJd0HVfi868MZ0m/w5cu1QzoOgSi8vsToJ+FUsLXxlmI
         vvtNGHBrZiBGqTJ2JU1DPdbCI6WMnax4NLrGnWf/w/OrfPVLQ+xiYL/HaKWfWKXnBF4Z
         dvR+W54M7dVevybK3pn6scCa6PqOaPWuVWnjZRiLlHpvQe1RCETKfNgJbse1zjx0+eZV
         OVeA==
X-Gm-Message-State: APjAAAU6tRWF+jp+yaSq5MNPwMOfPpJMi3YURkHxcGIo+oCNFFGjtfhA
        GSa6lHDok/qTQEhgubLkk2HnaoDKC6pZaw==
X-Google-Smtp-Source: APXvYqxepXRd6PUjs5AwRBVI+boC3Njac1qmaGgR+aukxAh0NcC1sVkqlXWweT11ir2WU6Ty5loHCA==
X-Received: by 2002:a6b:d81a:: with SMTP id y26mr27102612iob.23.1574700502698;
        Mon, 25 Nov 2019 08:48:22 -0800 (PST)
Received: from localhost.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k4sm1944788iof.61.2019.11.25.08.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 08:48:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] io-wq: have io_wq_create() take a 'data' argument
Date:   Mon, 25 Nov 2019 09:48:16 -0700
Message-Id: <20191125164818.16414-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125164818.16414-1-axboe@kernel.dk>
References: <20191125164818.16414-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We currently pass in 4 arguments outside of the bounded size. In
preparation for adding one more argument, let's bundle them up in
a struct to make it more readable.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c    | 14 ++++++--------
 fs/io-wq.h    | 12 +++++++++---
 fs/io_uring.c |  9 +++++++--
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 2666384aaf44..49ca58c714da 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -974,9 +974,7 @@ void io_wq_flush(struct io_wq *wq)
 	}
 }
 
-struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
-			   struct user_struct *user, get_work_fn *get_work,
-			   put_work_fn *put_work)
+struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 {
 	int ret = -ENOMEM, i, node;
 	struct io_wq *wq;
@@ -992,11 +990,11 @@ struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	wq->get_work = get_work;
-	wq->put_work = put_work;
+	wq->get_work = data->get_work;
+	wq->put_work = data->put_work;
 
 	/* caller must already hold a reference to this */
-	wq->user = user;
+	wq->user = data->user;
 
 	i = 0;
 	for_each_online_node(node) {
@@ -1009,7 +1007,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
 		wqe->node = node;
 		wqe->acct[IO_WQ_ACCT_BOUND].max_workers = bounded;
 		atomic_set(&wqe->acct[IO_WQ_ACCT_BOUND].nr_running, 0);
-		if (user) {
+		if (wq->user) {
 			wqe->acct[IO_WQ_ACCT_UNBOUND].max_workers =
 					task_rlimit(current, RLIMIT_NPROC);
 		}
@@ -1031,7 +1029,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
 		goto err;
 
 	/* caller must have already done mmgrab() on this mm */
-	wq->mm = mm;
+	wq->mm = data->mm;
 
 	wq->manager = kthread_create(io_wq_manager, wq, "io_wq_manager");
 	if (!IS_ERR(wq->manager)) {
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 892989f3e41e..6db81f0f44e2 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -48,9 +48,15 @@ struct io_wq_work {
 typedef void (get_work_fn)(struct io_wq_work *);
 typedef void (put_work_fn)(struct io_wq_work *);
 
-struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
-				struct user_struct *user,
-				get_work_fn *get_work, put_work_fn *put_work);
+struct io_wq_data {
+	struct mm_struct *mm;
+	struct user_struct *user;
+
+	get_work_fn *get_work;
+	put_work_fn *put_work;
+};
+
+struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data);
 void io_wq_destroy(struct io_wq *wq);
 
 void io_wq_enqueue(struct io_wq *wq, struct io_wq_work *work);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9f9c2d46c19c..a9a1fb9954cc 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3946,6 +3946,7 @@ static void io_get_work(struct io_wq_work *work)
 static int io_sq_offload_start(struct io_ring_ctx *ctx,
 			       struct io_uring_params *p)
 {
+	struct io_wq_data data;
 	unsigned concurrency;
 	int ret;
 
@@ -3990,10 +3991,14 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 		goto err;
 	}
 
+	data.mm = ctx->sqo_mm;
+	data.user = ctx->user;
+	data.get_work = io_get_work;
+	data.put_work = io_put_work;
+
 	/* Do QD, or 4 * CPUS, whatever is smallest */
 	concurrency = min(ctx->sq_entries, 4 * num_online_cpus());
-	ctx->io_wq = io_wq_create(concurrency, ctx->sqo_mm, ctx->user,
-					io_get_work, io_put_work);
+	ctx->io_wq = io_wq_create(concurrency, &data);
 	if (IS_ERR(ctx->io_wq)) {
 		ret = PTR_ERR(ctx->io_wq);
 		ctx->io_wq = NULL;
-- 
2.24.0

