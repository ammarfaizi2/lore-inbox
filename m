Return-Path: <SRS0=yioi=ZS=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B54C432C0
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 22:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218C92064B
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 22:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bBPHrljf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfKZWBA (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:01:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35674 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKZWA7 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 26 Nov 2019 17:00:59 -0500
Received: by mail-pj1-f65.google.com with SMTP id s8so8928137pji.2
        for <io-uring@vger.kernel.org>; Tue, 26 Nov 2019 14:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=30FUXkSKLOyIOg6Rgyv4mFrBUR5wxDIvA3DuNWr1Puk=;
        b=bBPHrljfwgU6nPL3Hlp8bweHyoWapMpEpK3FUZXe7zKORVu3yNss3O4KxBSvsDn64V
         T43fRKp/7PFYjoA4dntjvFbHvPs0R3UqIDfiLla9Gi27Vsgozouyptj3eZfJ3RurdE9s
         05xDiniZ9fUKN7tGNjZzYX6kX6mUXtaawlpV3/L0ZnO5P/A3JHnf67zlUhR8bGg5mAGQ
         rGfeEaJfSqEahrrboNatcsfodCHc4APYGpGTPLjDu9BoUMPsKGPK3v6hF5fGasfZSoBF
         zSD0ZYsVbosZx5wJ99bzoQ9exWr1kduX2f5oVlBj/xI1jjHInVCJkiMm5AetEFqbsNc1
         0c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=30FUXkSKLOyIOg6Rgyv4mFrBUR5wxDIvA3DuNWr1Puk=;
        b=GpBKuAKQLf5GuMeDYIwtCzIkt9TmSyxjCaYOqprV7K9kcSwf7BcfEdRvcCiqYlKSOd
         NEzosweqZBYsFZgRaUDJDEEdRqMKyvHslm5hr1PQ46vKXuUWXVQVrVx+Q9ifPcN7QhT5
         lBPCQakP4ly9urs3uINZgJlhjm3PwPwp7ijCBPFTpp6kwXa8OTys2Dxi2HmjQSa1G+9K
         6bb/0GiymrsAcrVTz0kW+5OTjkn6RiRUhsBBaJPPFRX7z1zuGZJSpYuMaA0WCQHCSPbK
         vATdYwdQ5oEY97UA3Nm1cZvtLyqU9nqQV4oe5k5I9Ehm1yvppVsBHnJMilqy46tnE14o
         VwTQ==
X-Gm-Message-State: APjAAAW/vw9eUhTcLn/9IewkUuG29kRBVweMuB0Vpd0ccq3f/mRNDYXm
        L32UgMI1Bsq0L9fbjSetGZHMX+gNCfl7OA==
X-Google-Smtp-Source: APXvYqyuVVD/KGWs4X8a+Y+MX/6B0Of3cjr/a3TrdcPZwq27QokibYNSsHhFz8A34bAm8C4NXIOaiw==
X-Received: by 2002:a17:902:7c03:: with SMTP id x3mr540148pll.157.1574805656599;
        Tue, 26 Nov 2019 14:00:56 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id b24sm13300597pgk.93.2019.11.26.14.00.55
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 14:00:55 -0800 (PST)
To:     io-uring <io-uring@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: make poll->wait dynamically allocated
Message-ID: <c2b228fc-6975-181d-745b-c9bd32f4da9d@kernel.dk>
Date:   Tue, 26 Nov 2019 15:00:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

In the quest to bring io_kiocb down to 3 cachelines, this one does
the trick. Make the wait_queue_entry for the poll command come out
of kmalloc instead of embedding it in struct io_poll_iocb, as the
latter is the largest member of io_kiocb. Once we trim this down a
bit, we're back at a healthy 192 bytes for struct io_kiocb.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e44b0e01f1b5..2c2e8c25da01 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -291,7 +291,7 @@ struct io_poll_iocb {
 	__poll_t			events;
 	bool				done;
 	bool				canceled;
-	struct wait_queue_entry		wait;
+	struct wait_queue_entry		*wait;
 };
 
 struct io_timeout_data {
@@ -2030,8 +2030,8 @@ static void io_poll_remove_one(struct io_kiocb *req)
 
 	spin_lock(&poll->head->lock);
 	WRITE_ONCE(poll->canceled, true);
-	if (!list_empty(&poll->wait.entry)) {
-		list_del_init(&poll->wait.entry);
+	if (!list_empty(&poll->wait->entry)) {
+		list_del_init(&poll->wait->entry);
 		io_queue_async_work(req);
 	}
 	spin_unlock(&poll->head->lock);
@@ -2104,6 +2104,7 @@ static void io_poll_complete(struct io_kiocb *req, __poll_t mask, int error)
 	struct io_ring_ctx *ctx = req->ctx;
 
 	req->poll.done = true;
+	kfree(req->poll.wait);
 	if (error)
 		io_cqring_fill_event(req, error);
 	else
@@ -2141,7 +2142,7 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 	 */
 	spin_lock_irq(&ctx->completion_lock);
 	if (!mask && ret != -ECANCELED) {
-		add_wait_queue(poll->head, &poll->wait);
+		add_wait_queue(poll->head, poll->wait);
 		spin_unlock_irq(&ctx->completion_lock);
 		return;
 	}
@@ -2161,8 +2162,7 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 			void *key)
 {
-	struct io_poll_iocb *poll = container_of(wait, struct io_poll_iocb,
-							wait);
+	struct io_poll_iocb *poll = wait->private;
 	struct io_kiocb *req = container_of(poll, struct io_kiocb, poll);
 	struct io_ring_ctx *ctx = req->ctx;
 	__poll_t mask = key_to_poll(key);
@@ -2172,7 +2172,7 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	if (mask && !(mask & poll->events))
 		return 0;
 
-	list_del_init(&poll->wait.entry);
+	list_del_init(&poll->wait->entry);
 
 	/*
 	 * Run completion inline if we can. We're using trylock here because
@@ -2213,7 +2213,7 @@ static void io_poll_queue_proc(struct file *file, struct wait_queue_head *head,
 
 	pt->error = 0;
 	pt->req->poll.head = head;
-	add_wait_queue(head, &pt->req->poll.wait);
+	add_wait_queue(head, pt->req->poll.wait);
 }
 
 static void io_poll_req_insert(struct io_kiocb *req)
@@ -2252,6 +2252,10 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (!poll->file)
 		return -EBADF;
 
+	poll->wait = kmalloc(sizeof(*poll->wait), GFP_KERNEL);
+	if (!poll->wait)
+		return -ENOMEM;
+
 	req->sqe = NULL;
 	INIT_IO_WORK(&req->work, io_poll_complete_work);
 	events = READ_ONCE(sqe->poll_events);
@@ -2268,8 +2272,9 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	ipt.error = -EINVAL; /* same as no support for IOCB_CMD_POLL */
 
 	/* initialized the list so that we can do list_empty checks */
-	INIT_LIST_HEAD(&poll->wait.entry);
-	init_waitqueue_func_entry(&poll->wait, io_poll_wake);
+	INIT_LIST_HEAD(&poll->wait->entry);
+	init_waitqueue_func_entry(poll->wait, io_poll_wake);
+	poll->wait->private = poll;
 
 	INIT_LIST_HEAD(&req->list);
 
@@ -2278,14 +2283,14 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	spin_lock_irq(&ctx->completion_lock);
 	if (likely(poll->head)) {
 		spin_lock(&poll->head->lock);
-		if (unlikely(list_empty(&poll->wait.entry))) {
+		if (unlikely(list_empty(&poll->wait->entry))) {
 			if (ipt.error)
 				cancel = true;
 			ipt.error = 0;
 			mask = 0;
 		}
 		if (mask || ipt.error)
-			list_del_init(&poll->wait.entry);
+			list_del_init(&poll->wait->entry);
 		else if (cancel)
 			WRITE_ONCE(poll->canceled, true);
 		else if (!poll->done) /* actually waiting for an event */

-- 
Jens Axboe

