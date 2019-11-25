Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A5C432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 16:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B472068E
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 16:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cvXjA6mM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfKYQs1 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:48:27 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33503 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfKYQs0 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 11:48:26 -0500
Received: by mail-io1-f67.google.com with SMTP id j13so17050927ioe.0
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 08:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhpTeuOA1GpRMng8r9BTuksctnFgh1g7Dr54Kb56Ya8=;
        b=cvXjA6mMM7Y6XtYDyhm+OxpuwQEeKpNb9L4AMArjDpqAUFNakMdrYboMjxa7BNoUPN
         iIiSfeNboHtm8Ub+3QNi4vZAW1AV/359syVGSreVeouBC9d0L5B10PrERQEFbcHtJ4mp
         Pe75+dMShSnx6AKlxt+9Luki8UI4d/9e+IkBVdzaCWpIFfV1zpvSqIIrk/1S/jjRA2EP
         pENzL/3OBAKdoRhN+GPKix1xEKvfDrr1PCgpY96nFeE40YZkVVQ0t6AdUenQB3pqDddq
         F+IcL1QRYg2u1o1NHMdAIn8koj4Y7P8KHdHA2Oe6/3PI1Znm+UNdO30o+Xuu+bLT7j+T
         FGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhpTeuOA1GpRMng8r9BTuksctnFgh1g7Dr54Kb56Ya8=;
        b=tbc4Maqsnwu0BrQW8BL4+PjtOvi0J2aILs7pP+V8dhJfvo74Vvf81XBBWCi08M+pWH
         9OFOY65qDhffOHpCNjFV/91xqXJRYEjS+iv3U8kyBexMpPUIdMRz/nWkDq4KjqLpvRic
         lL1W+DBSXEgMtvmcv9f3Hvl9EG5/kSAh8hO2ccri/YhjwowvIbmPQihRm6/i1BNzkKae
         CRCThwLvg0weJ94sqB8edI0R4cS0HDX+UQuy0opWME8fP+Ejc+nZ1RlcIbg+pzmXxFgm
         lbzE1rC7i4bAAhOFtWih0Pz4sGAo1ZUENsZ31qMrKe3fyiYg5aUX2LowgSOf2EtDB7Lo
         +stg==
X-Gm-Message-State: APjAAAWABFPPv/KkqEaNlJg4fJ5zfr48YAB8ue6bmtTpb8K0ZFu3Hgba
        E+JbFWRENATib/GV2ffcpLl+ITjB4RhEKg==
X-Google-Smtp-Source: APXvYqwQqUxpu7N8B0buWGCB33BuQEfnRa7ywsKlhLxeaXUUfWIwLhyQ1a/NAgzDc3Uulvg0S4IQLA==
X-Received: by 2002:a6b:cf0f:: with SMTP id o15mr11023793ioa.229.1574700504208;
        Mon, 25 Nov 2019 08:48:24 -0800 (PST)
Received: from localhost.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k4sm1944788iof.61.2019.11.25.08.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 08:48:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: async workers should inherit the user creds
Date:   Mon, 25 Nov 2019 09:48:17 -0700
Message-Id: <20191125164818.16414-3-axboe@kernel.dk>
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
 fs/io_uring.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 84efb8956734..9bead1717949 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -255,6 +255,8 @@ struct io_ring_ctx {
 
 	struct user_struct	*user;
 
+	struct cred		*creds;
+
 	struct completion	ctx_done;
 
 	struct {
@@ -1294,8 +1296,11 @@ static void io_poll_complete_work(struct work_struct *work)
 	struct io_poll_iocb *poll = &req->poll;
 	struct poll_table_struct pt = { ._key = poll->events };
 	struct io_ring_ctx *ctx = req->ctx;
+	const struct cred *old_cred;
 	__poll_t mask = 0;
 
+	old_cred = override_creds(ctx->creds);
+
 	if (!READ_ONCE(poll->canceled))
 		mask = vfs_poll(poll->file, &pt) & poll->events;
 
@@ -1310,7 +1315,7 @@ static void io_poll_complete_work(struct work_struct *work)
 	if (!mask && !READ_ONCE(poll->canceled)) {
 		add_wait_queue(poll->head, &poll->wait);
 		spin_unlock_irq(&ctx->completion_lock);
-		return;
+		goto out;
 	}
 	list_del_init(&req->list);
 	io_poll_complete(ctx, req, mask);
@@ -1318,6 +1323,8 @@ static void io_poll_complete_work(struct work_struct *work)
 
 	io_cqring_ev_posted(ctx);
 	io_put_req(req);
+out:
+	revert_creds(old_cred);
 }
 
 static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
@@ -1528,10 +1535,12 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	struct io_ring_ctx *ctx = req->ctx;
 	struct mm_struct *cur_mm = NULL;
 	struct async_list *async_list;
+	const struct cred *old_cred;
 	LIST_HEAD(req_list);
 	mm_segment_t old_fs;
 	int ret;
 
+	old_cred = override_creds(ctx->creds);
 	async_list = io_async_list_from_sqe(ctx, req->submit.sqe);
 restart:
 	do {
@@ -1633,6 +1642,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		unuse_mm(cur_mm);
 		mmput(cur_mm);
 	}
+	revert_creds(old_cred);
 }
 
 /*
@@ -1881,6 +1891,7 @@ static int io_sq_thread(void *data)
 	struct sqe_submit sqes[IO_IOPOLL_BATCH];
 	struct io_ring_ctx *ctx = data;
 	struct mm_struct *cur_mm = NULL;
+	const struct cred *old_cred;
 	mm_segment_t old_fs;
 	DEFINE_WAIT(wait);
 	unsigned inflight;
@@ -1888,6 +1899,7 @@ static int io_sq_thread(void *data)
 
 	old_fs = get_fs();
 	set_fs(USER_DS);
+	old_cred = override_creds(ctx->creds);
 
 	timeout = inflight = 0;
 	while (!kthread_should_stop() && !ctx->sqo_stop) {
@@ -2001,6 +2013,7 @@ static int io_sq_thread(void *data)
 		unuse_mm(cur_mm);
 		mmput(cur_mm);
 	}
+	revert_creds(old_cred);
 
 	if (kthread_should_park())
 		kthread_parkme();
@@ -2645,6 +2658,8 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 		io_unaccount_mem(ctx->user,
 				ring_pages(ctx->sq_entries, ctx->cq_entries));
 	free_uid(ctx->user);
+	if (ctx->creds)
+		put_cred(ctx->creds);
 	kfree(ctx);
 }
 
@@ -2924,6 +2939,12 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
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

