Return-Path: <SRS0=qbCF=ZK=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEFAC432C0
	for <io-uring@archiver.kernel.org>; Mon, 18 Nov 2019 18:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4870D222A4
	for <io-uring@archiver.kernel.org>; Mon, 18 Nov 2019 18:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uWLALqkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfKRSO7 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:14:59 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:34884 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfKRSO6 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 18 Nov 2019 13:14:58 -0500
Received: by mail-io1-f49.google.com with SMTP id x21so19900075ior.2
        for <io-uring@vger.kernel.org>; Mon, 18 Nov 2019 10:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Md0b4GghoPtrhGWbaXz6PKBHYEUOaujqazcSjfSqI9A=;
        b=uWLALqkwzfuBeiRLGdEEKW1sIlSyt56tfuNO7F+ckea+1+iR09lMDD4E9o+5TiJuUp
         F1stn8CqC5du57vJ9fMpuG+zjb8ijVG0c0/bz02glX2TCnx/43VMJyavbS94FWwGCXBm
         VeXZ5vBkh2WkiJH56CsItl9VEA23pHbW+RWejFII66Q623/bfnYqDR7lbE8daB35/hmF
         dZpTn9aMKaThTofIGMsBTDz0jIcY0Y1rmq1I9PbrRQgaXBQh9kWzlSetYqEru/LCqceV
         kzOLDfifW91QpCdheEhEgQyXXdO/nLoaJPOFngboHC8shZvbgh+OZcC6cuxjUL3t8pcW
         /E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Md0b4GghoPtrhGWbaXz6PKBHYEUOaujqazcSjfSqI9A=;
        b=bZxSRxr7csRoNazYzY0Dd7zRaJip7IbSAwaQm98vFP2rnm9/2sJkzLMD/VHMvjvZMM
         Qm92cGlYmOOFKFntvDkwGPw5kfFwh/e1m28hZt3QlJdulXK9mMIVl5BsWVhu9yvxuPVR
         /NzqEw/yfb1GoDlyD6erlcIB244JRQGZo7Ny2VetA6bgD5qwlQYVY+2KFaYDBoqZpV5Z
         c5a97xduX9o6v8tx2HM/OAL69HBBxweMOzH4Wovowsl4LXgNPbdVuRUFb9Sqym+mJJaK
         sBJZtQzOivSDyuheiWA3DcsDW4ABi45OqRVX/m0wBhN6VWaiTCfUkfdaWzKaWl2yviUF
         Gb/Q==
X-Gm-Message-State: APjAAAUv2dBIZhqdVcOVcnPRqB5vRnTKrwZGCPa5BioYSgTrb9OO+3mz
        mRTo6Qgf+jTWbWBvJR62wN1EuhQTMWA=
X-Google-Smtp-Source: APXvYqw9/+rnn8MJk840S2qFgr3jMrBd8IUOMamChiv0BaBb2ckojfKPBcrbzlBtczYFxYk6o4Rgdg==
X-Received: by 2002:a02:140a:: with SMTP id 10mr14352074jag.72.1574100896371;
        Mon, 18 Nov 2019 10:14:56 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w9sm4696457ilo.68.2019.11.18.10.14.55
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 10:14:55 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: correct poll cancel and linked timeout expiration
 completion
Message-ID: <61440859-f57d-cd0d-f2b9-72a4e869da26@kernel.dk>
Date:   Mon, 18 Nov 2019 11:14:54 -0700
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

Currently a poll request fills a completion entry of 0, even if it got
cancelled. This is odd, and it makes it harder to support with chains.
Ensure that it returns -ECANCELED in the completions events if it got
cancelled, and furthermore ensure that the linked timeout that triggered
it completes with -ETIME if we did indeed trigger the completions
through a timeout.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

This does change the API slightly for poll, but I think that's a low
risk event at this point. Any other request that got cancelled will
return -ECANCELED, I think it's more important to be consistent here.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 942c04d5e63d..40c351a9ed26 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2066,12 +2066,15 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return 0;
 }
 
-static void io_poll_complete(struct io_kiocb *req, __poll_t mask)
+static void io_poll_complete(struct io_kiocb *req, __poll_t mask, int error)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 
 	req->poll.done = true;
-	io_cqring_fill_event(req, mangle_poll(mask));
+	if (error)
+		io_cqring_fill_event(req, error);
+	else
+		io_cqring_fill_event(req, mangle_poll(mask));
 	io_commit_cqring(ctx);
 }
 
@@ -2084,11 +2087,16 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_kiocb *nxt = NULL;
 	__poll_t mask = 0;
+	int ret = 0;
 
-	if (work->flags & IO_WQ_WORK_CANCEL)
+	if (work->flags & IO_WQ_WORK_CANCEL) {
 		WRITE_ONCE(poll->canceled, true);
+		ret = -ECANCELED;
+	} else if (READ_ONCE(poll->canceled)) {
+		ret = -ECANCELED;
+	}
 
-	if (!READ_ONCE(poll->canceled))
+	if (ret != -ECANCELED)
 		mask = vfs_poll(poll->file, &pt) & poll->events;
 
 	/*
@@ -2099,13 +2107,13 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 	 * avoid further branches in the fast path.
 	 */
 	spin_lock_irq(&ctx->completion_lock);
-	if (!mask && !READ_ONCE(poll->canceled)) {
+	if (!mask && ret != -ECANCELED) {
 		add_wait_queue(poll->head, &poll->wait);
 		spin_unlock_irq(&ctx->completion_lock);
 		return;
 	}
 	io_poll_remove_req(req);
-	io_poll_complete(req, mask);
+	io_poll_complete(req, mask, ret);
 	spin_unlock_irq(&ctx->completion_lock);
 
 	io_cqring_ev_posted(ctx);
@@ -2139,7 +2147,7 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	 */
 	if (mask && spin_trylock_irqsave(&ctx->completion_lock, flags)) {
 		io_poll_remove_req(req);
-		io_poll_complete(req, mask);
+		io_poll_complete(req, mask, 0);
 		req->flags |= REQ_F_COMP_LOCKED;
 		io_put_req(req);
 		spin_unlock_irqrestore(&ctx->completion_lock, flags);
@@ -2251,7 +2259,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	if (mask) { /* no async, we'd stolen it */
 		ipt.error = 0;
-		io_poll_complete(req, mask);
+		io_poll_complete(req, mask, 0);
 	}
 	spin_unlock_irq(&ctx->completion_lock);
 
@@ -2503,7 +2511,7 @@ static int io_async_cancel_one(struct io_ring_ctx *ctx, void *sqe_addr)
 
 static void io_async_find_and_cancel(struct io_ring_ctx *ctx,
 				     struct io_kiocb *req, __u64 sqe_addr,
-				     struct io_kiocb **nxt)
+				     struct io_kiocb **nxt, int success_ret)
 {
 	unsigned long flags;
 	int ret;
@@ -2520,6 +2528,8 @@ static void io_async_find_and_cancel(struct io_ring_ctx *ctx,
 		goto done;
 	ret = io_poll_cancel(ctx, sqe_addr);
 done:
+	if (!ret)
+		ret = success_ret;
 	io_cqring_fill_event(req, ret);
 	io_commit_cqring(ctx);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
@@ -2541,7 +2551,7 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	    sqe->cancel_flags)
 		return -EINVAL;
 
-	io_async_find_and_cancel(ctx, req, READ_ONCE(sqe->addr), nxt);
+	io_async_find_and_cancel(ctx, req, READ_ONCE(sqe->addr), nxt, 0);
 	return 0;
 }
 
@@ -2831,7 +2841,8 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 	if (prev) {
-		io_async_find_and_cancel(ctx, req, prev->user_data, NULL);
+		io_async_find_and_cancel(ctx, req, prev->user_data, NULL,
+						-ETIME);
 		io_put_req(prev);
 	} else {
 		io_cqring_add_event(req, -ETIME);

-- 
Jens Axboe

