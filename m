Return-Path: <SRS0=l6sb=2A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCDEC43603
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123B32053B
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EkGctzVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfLJP5z (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:57:55 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39128 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLJP5z (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Dec 2019 10:57:55 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so19308518ioh.6
        for <io-uring@vger.kernel.org>; Tue, 10 Dec 2019 07:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Fgy522fqQQwn2fTX7g3jy3eERarM7jqk3src0QU9rw=;
        b=EkGctzVNVitAdBQ/obujoeQs77hSaEh3z6PSPDj4K+ipIvK7EUvUvw0UAnk5prLryE
         /wmM9RSJdf37VuhTf5uhqyaTNcE/wg6hcSe3/XDBtcA3JqGeuEl+LCzEWEHOukca2Uqt
         TXY1qSOkHkhD/V1cWhXCikVrLjMBtv7XxplQHrXvXuJJ8TLYOQQ8iy/sdqbguL42IuE4
         uklmq8NboRBTF7lyVStjzcKVUhpDqTMAfK9+nPzXmXLaIC+05YHfhLh1DeaHFFdarTcX
         aipTzcrGbX6Cpmuvt48ptBQiyec2jtmvrcwcWSXC9jmfIgPScNOYLEs3XAWEThUJv85C
         IViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Fgy522fqQQwn2fTX7g3jy3eERarM7jqk3src0QU9rw=;
        b=ARcOHbHZIQxK55/+50vHaF8FJSzfrYqVli/Mdmj3JDFNgS4QKdWn7+UvYnbhPc8lgp
         cT628xclagfxR6ZbnEX32ee2F2SAI1cNLGGqAn18Wn51+2OH8wTQ+aKU+7yW47oh05vT
         7ZFlCOVHNoMzG5jlkBerMAHjgWDq6xZhqz4IwwmUoqrUOm9myGH4ZE9seOgDRc1kVHTn
         F+Bh7XvOIa2Lv+BpfTdVCYEw2TWebWim65FYbDFO4jZGrjbOfaZlZOOLsrr9AP0UCt+f
         eZuxbE7QE3uQ3uOs9HoHcJbIL4f86CVTneqWUKWKD5yEgx7keLzezFXwQf0AYix/DHXP
         cnoQ==
X-Gm-Message-State: APjAAAWKTdJ1GSdalnzTmya138a8IyDagZRz+3SMif/F8vPop8qwB+lM
        4xCoOBLXjBlRkpsP4MzJhVx60Vjqn1u0+Q==
X-Google-Smtp-Source: APXvYqzsYYuJ7HS+nTzDh+sx9XjLee0WjNZOH5Jr53LUb546ImLO/yitqas0WQgLfgCTPg/Phxdq2A==
X-Received: by 2002:a02:13ca:: with SMTP id 193mr961796jaz.54.1575993474519;
        Tue, 10 Dec 2019 07:57:54 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w6sm770953ioa.16.2019.12.10.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:57:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/11] io_uring: don't dynamically allocate poll data
Date:   Tue, 10 Dec 2019 08:57:37 -0700
Message-Id: <20191210155742.5844-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210155742.5844-1-axboe@kernel.dk>
References: <20191210155742.5844-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This essentially reverts commit e944475e6984. For high poll ops
workloads, like TAO, the dynamic allocation of the wait_queue
entry for IORING_OP_POLL_ADD adds considerable extra overhead.
Go back to embedding the wait_queue_entry, but keep the usage of
wait->private for the pointer stashing.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a0ed20e097d9..9a596b819334 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -293,7 +293,7 @@ struct io_poll_iocb {
 	__poll_t			events;
 	bool				done;
 	bool				canceled;
-	struct wait_queue_entry		*wait;
+	struct wait_queue_entry		wait;
 };
 
 struct io_timeout_data {
@@ -2286,8 +2286,8 @@ static void io_poll_remove_one(struct io_kiocb *req)
 
 	spin_lock(&poll->head->lock);
 	WRITE_ONCE(poll->canceled, true);
-	if (!list_empty(&poll->wait->entry)) {
-		list_del_init(&poll->wait->entry);
+	if (!list_empty(&poll->wait.entry)) {
+		list_del_init(&poll->wait.entry);
 		io_queue_async_work(req);
 	}
 	spin_unlock(&poll->head->lock);
@@ -2358,7 +2358,6 @@ static void io_poll_complete(struct io_kiocb *req, __poll_t mask, int error)
 	struct io_ring_ctx *ctx = req->ctx;
 
 	req->poll.done = true;
-	kfree(req->poll.wait);
 	if (error)
 		io_cqring_fill_event(req, error);
 	else
@@ -2396,7 +2395,7 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 	 */
 	spin_lock_irq(&ctx->completion_lock);
 	if (!mask && ret != -ECANCELED) {
-		add_wait_queue(poll->head, poll->wait);
+		add_wait_queue(poll->head, &poll->wait);
 		spin_unlock_irq(&ctx->completion_lock);
 		return;
 	}
@@ -2426,7 +2425,7 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	if (mask && !(mask & poll->events))
 		return 0;
 
-	list_del_init(&poll->wait->entry);
+	list_del_init(&poll->wait.entry);
 
 	/*
 	 * Run completion inline if we can. We're using trylock here because
@@ -2467,7 +2466,7 @@ static void io_poll_queue_proc(struct file *file, struct wait_queue_head *head,
 
 	pt->error = 0;
 	pt->req->poll.head = head;
-	add_wait_queue(head, pt->req->poll.wait);
+	add_wait_queue(head, &pt->req->poll.wait);
 }
 
 static void io_poll_req_insert(struct io_kiocb *req)
@@ -2496,10 +2495,6 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (!poll->file)
 		return -EBADF;
 
-	poll->wait = kmalloc(sizeof(*poll->wait), GFP_KERNEL);
-	if (!poll->wait)
-		return -ENOMEM;
-
 	req->io = NULL;
 	INIT_IO_WORK(&req->work, io_poll_complete_work);
 	events = READ_ONCE(sqe->poll_events);
@@ -2516,9 +2511,9 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	ipt.error = -EINVAL; /* same as no support for IOCB_CMD_POLL */
 
 	/* initialized the list so that we can do list_empty checks */
-	INIT_LIST_HEAD(&poll->wait->entry);
-	init_waitqueue_func_entry(poll->wait, io_poll_wake);
-	poll->wait->private = poll;
+	INIT_LIST_HEAD(&poll->wait.entry);
+	init_waitqueue_func_entry(&poll->wait, io_poll_wake);
+	poll->wait.private = poll;
 
 	INIT_LIST_HEAD(&req->list);
 
@@ -2527,14 +2522,14 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	spin_lock_irq(&ctx->completion_lock);
 	if (likely(poll->head)) {
 		spin_lock(&poll->head->lock);
-		if (unlikely(list_empty(&poll->wait->entry))) {
+		if (unlikely(list_empty(&poll->wait.entry))) {
 			if (ipt.error)
 				cancel = true;
 			ipt.error = 0;
 			mask = 0;
 		}
 		if (mask || ipt.error)
-			list_del_init(&poll->wait->entry);
+			list_del_init(&poll->wait.entry);
 		else if (cancel)
 			WRITE_ONCE(poll->canceled, true);
 		else if (!poll->done) /* actually waiting for an event */
-- 
2.24.0

