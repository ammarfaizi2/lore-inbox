Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0E6C432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 16:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F122068E
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 16:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="de0lDEWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfKYQs2 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:48:28 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37591 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfKYQs2 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 11:48:28 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so6359817ioc.4
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 08:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i/Nn4KPoO6d2avLi8YeilyrpapR+do+CuEzcXz+87NY=;
        b=de0lDEWKCsN6TAgftsYgd4nIZTx3Bn5blgXtj6PEswAnaf3OKa71eKcrUtIxo5QE5l
         miMLZI38bpViw8GRFXfYTy9iFekWVu9VlLGw1ibx/LVMz7t1A/fak6cstmmSdZpFmRZE
         d5d2EEBcgbiBUi5j4Eh5FfpmIR+2p1/PU/8oOEi8Flgs0G0oLIoqYYIOqPnfNpquQj60
         gCFF7NT5Voz8qi69lrDBqki+TojIE0DcNKrvsnkO3AFtCQ9SSfaWT4FM1QGkwSXwbtsQ
         yjkp+M4FUclINEbI1+l0gOk2hrbb92RQHh4uh3NBlMegXeBOIQjnCi4ZC9i+KIfxdu/0
         y6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i/Nn4KPoO6d2avLi8YeilyrpapR+do+CuEzcXz+87NY=;
        b=twL95DiJr5UVtV36yJONcbDWJHiuvW2aK1Ye72BN81LQAtrFJ/f4rPAphTqkQ7NNDg
         YrpVzyOhNlkku8hdC7e6ZqcQD0P0Ime9UlBGUtmU+9qZ6rjzXgHmZK6WBqN0I6D3RQHV
         ccnyI19SHxn7BuE7yw4h+06iJ65+PODqz8cOuFHhCVUXrEqP1BkfbrsAZaPfJNl11z7N
         4Gv4TANkcnthmrvOwQczXdqZeI3dUfvUN5iOwYTZA4Zs6vIphtzSX3XULeL4j472kE31
         T/ceRXydYYrBIrBMbA19QmGyLnguj/DSq66BJXnqyA2WEgvYTfWCdsyuzAlUS/EuCYVZ
         pBZA==
X-Gm-Message-State: APjAAAXriOHAdxe3QPcuqoV/iB6CKsygxOUjcdy1A7bAxOfqAUlIm62i
        IhD/Vb2eC+wOFgHsj77wYGq0QxIaAA+qiw==
X-Google-Smtp-Source: APXvYqzE8stPkIZCxLvDBIpd+UeV9TtZLAlh2LlKdEWT+pLrOuOYO8e+hYySqikDrRn5vrSyWkmGKQ==
X-Received: by 2002:a6b:b294:: with SMTP id b142mr26331486iof.243.1574700505511;
        Mon, 25 Nov 2019 08:48:25 -0800 (PST)
Received: from localhost.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k4sm1944788iof.61.2019.11.25.08.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 08:48:24 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] io_uring: async workers should inherit the user creds
Date:   Mon, 25 Nov 2019 09:48:18 -0700
Message-Id: <20191125164818.16414-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125164818.16414-1-axboe@kernel.dk>
References: <20191125164818.16414-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

If we don't inherit the original task creds, then we can confuse users
like fuse that pass creds in the request header. See link below on
identical aio issue.

Link: https://lore.kernel.org/linux-fsdevel/26f0d78e-99ca-2f1b-78b9-433088053a61@scylladb.com/T/#u
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c    | 10 ++++++++++
 fs/io-wq.h    |  1 +
 fs/io_uring.c | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 49ca58c714da..85c0090b2717 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -57,6 +57,7 @@ struct io_worker {
 
 	struct rcu_head rcu;
 	struct mm_struct *mm;
+	const struct cred *creds;
 	struct files_struct *restore_files;
 };
 
@@ -111,6 +112,7 @@ struct io_wq {
 
 	struct task_struct *manager;
 	struct user_struct *user;
+	struct cred *creds;
 	struct mm_struct *mm;
 	refcount_t refs;
 	struct completion done;
@@ -136,6 +138,11 @@ static bool __io_worker_unuse(struct io_wqe *wqe, struct io_worker *worker)
 {
 	bool dropped_lock = false;
 
+	if (worker->creds) {
+		revert_creds(worker->creds);
+		worker->creds = NULL;
+	}
+
 	if (current->files != worker->restore_files) {
 		__acquire(&wqe->lock);
 		spin_unlock_irq(&wqe->lock);
@@ -442,6 +449,8 @@ static void io_worker_handle_work(struct io_worker *worker)
 			set_fs(USER_DS);
 			worker->mm = wq->mm;
 		}
+		if (!worker->creds)
+			worker->creds = override_creds(wq->creds);
 		if (test_bit(IO_WQ_BIT_CANCEL, &wq->state))
 			work->flags |= IO_WQ_WORK_CANCEL;
 		if (worker->mm)
@@ -995,6 +1004,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 
 	/* caller must already hold a reference to this */
 	wq->user = data->user;
+	wq->creds = data->creds;
 
 	i = 0;
 	for_each_online_node(node) {
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 6db81f0f44e2..e09c6a54648c 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -51,6 +51,7 @@ typedef void (put_work_fn)(struct io_wq_work *);
 struct io_wq_data {
 	struct mm_struct *mm;
 	struct user_struct *user;
+	struct cred *creds;
 
 	get_work_fn *get_work;
 	put_work_fn *put_work;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index a9a1fb9954cc..26bfba729a1e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -237,6 +237,8 @@ struct io_ring_ctx {
 
 	struct user_struct	*user;
 
+	struct cred		*creds;
+
 	/* 0 is for ctx quiesce/reinit/free, 1 is for sqo_thread started */
 	struct completion	*completions;
 
@@ -3251,6 +3253,7 @@ static int io_sq_thread(void *data)
 {
 	struct io_ring_ctx *ctx = data;
 	struct mm_struct *cur_mm = NULL;
+	const struct cred *old_cred;
 	mm_segment_t old_fs;
 	DEFINE_WAIT(wait);
 	unsigned inflight;
@@ -3261,6 +3264,7 @@ static int io_sq_thread(void *data)
 
 	old_fs = get_fs();
 	set_fs(USER_DS);
+	old_cred = override_creds(ctx->creds);
 
 	ret = timeout = inflight = 0;
 	while (!kthread_should_park()) {
@@ -3367,6 +3371,7 @@ static int io_sq_thread(void *data)
 		unuse_mm(cur_mm);
 		mmput(cur_mm);
 	}
+	revert_creds(old_cred);
 
 	kthread_parkme();
 
@@ -3993,6 +3998,7 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 
 	data.mm = ctx->sqo_mm;
 	data.user = ctx->user;
+	data.creds = ctx->creds;
 	data.get_work = io_get_work;
 	data.put_work = io_put_work;
 
@@ -4347,6 +4353,8 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 		io_unaccount_mem(ctx->user,
 				ring_pages(ctx->sq_entries, ctx->cq_entries));
 	free_uid(ctx->user);
+	if (ctx->creds)
+		put_cred(ctx->creds);
 	kfree(ctx->completions);
 	kmem_cache_free(req_cachep, ctx->fallback_req);
 	kfree(ctx);
@@ -4700,6 +4708,12 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	ctx->account_mem = account_mem;
 	ctx->user = user;
 
+	ctx->creds = prepare_creds();
+	if (!ctx->creds) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
 	ret = io_allocate_scq_urings(ctx, p);
 	if (ret)
 		goto err;
-- 
2.24.0

