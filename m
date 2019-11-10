Return-Path: <SRS0=ex/T=ZC=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523E4C43331
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 01:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0777A20B7C
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 01:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oBxbbi9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfKJBZE (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 20:25:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39276 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfKJBZE (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 20:25:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so7719402pfo.6
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 17:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0svVlQ6EOY6n3Q/SIBjYToHbEnVxtBnmlZjQLquTsjM=;
        b=oBxbbi9ODqf2q74HPtjx8XdPi5HhThaMmlj0hWl29e1qTvpQABE1HHHVPy3ZyRDqGo
         qIf//neyblN+ACul+UepzQy4mr95OOiaWiXmudYCeA/QjPGW6r/dQHdw1A38rLHIMmpe
         BNgiPKXu7EjgI+v+zw2CcVRd3ecFhp//sOedOWs+Y20GtXpKgZgwnKel6+NbAV5kEpNU
         1ApXuqRQ8q4POG64fWlgLptoWbr1mRugg7J+hM/WXU0Tqzdqv92U6IgwrqZQI1+JitQ4
         4zE2a1PfJIj4DX4gAn9RiHFt82eZCONoQs7KWwLKUkOqZkiSuEO+VtVP+yzYmws/NgTw
         XjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0svVlQ6EOY6n3Q/SIBjYToHbEnVxtBnmlZjQLquTsjM=;
        b=WwnRz4H36DWkbUKtQKEIpuq/xOaXRp6PIyAsj05v1XOvrSAB1oiXJMfIzCHsXaVIzy
         UBym/YesI7no07C1oOnruB1Ye/qGEZEzqea45iQDwJx6lAKMfdqbb0s7uJoPPdT3MDln
         +9wWCBF8sJZboRA87Tya8bm5vLu/txNyRmpUIlaY0tBrwyLrblIIG8iRcyxKk2O4AdF0
         vUlAUxpXjlLwOl9RJJ9it0SbqMMCo+p8+Oq70vcUCUmbrr4Ipp03Z8t6Lj8i94eXDugf
         df11pEo4abhXllaPDcGGMb0Wadvj7Zi3cM7fpAIxIDiqF1c3/lwQYldfDhXnXY+7BdrJ
         nl2w==
X-Gm-Message-State: APjAAAV1MysO4zH1S4Pob/+1A6BKjji6I34SWzCuT/nSRiHbZ9g6ugAZ
        YjBrOm9QzaLWRThWilHsEAVhng==
X-Google-Smtp-Source: APXvYqztX4zsf8expQfwdxAwPUl6LhmqEUdguQLviCpSa0FFmm+JnfDo0flCkoRN0sEV12jLGfCqyQ==
X-Received: by 2002:a63:f246:: with SMTP id d6mr20827642pgk.368.1573349101484;
        Sat, 09 Nov 2019 17:25:01 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id v19sm9396052pjr.14.2019.11.09.17.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 17:25:00 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: make ASYNC_CANCEL work with poll and timeout
Cc:     Hrvoje Zeba <zeba.hrvoje@gmail.com>
Message-ID: <f1548beb-9cfe-53ed-e480-e1923e7811b8@kernel.dk>
Date:   Sat, 9 Nov 2019 18:24:58 -0700
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

It's a little confusing that we have multiple types of command
cancellation opcodes now that we have a generic one. Make the generic
one work with POLL_ADD and TIMEOUT commands as well, that makes for an
easier to use API for the application. The fact that they currently
don't is a bit confusing.

Reported-by: Hrvoje Zeba <zeba.hrvoje@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a2548a6dd195..6db27bc9b2e3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1957,6 +1957,20 @@ static void io_poll_remove_all(struct io_ring_ctx *ctx)
 	spin_unlock_irq(&ctx->completion_lock);
 }
 
+static int io_poll_cancel(struct io_ring_ctx *ctx, __u64 sqe_addr)
+{
+	struct io_kiocb *req;
+
+	list_for_each_entry(req, &ctx->cancel_list, list) {
+		if (req->user_data != sqe_addr)
+			continue;
+		io_poll_remove_one(req);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
 /*
  * Find a running poll command that matches one specified in sqe->addr,
  * and remove it if found.
@@ -1964,8 +1978,7 @@ static void io_poll_remove_all(struct io_ring_ctx *ctx)
 static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	struct io_kiocb *poll_req, *next;
-	int ret = -ENOENT;
+	int ret;
 
 	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
@@ -1974,13 +1987,7 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EINVAL;
 
 	spin_lock_irq(&ctx->completion_lock);
-	list_for_each_entry_safe(poll_req, next, &ctx->cancel_list, list) {
-		if (READ_ONCE(sqe->addr) == poll_req->user_data) {
-			io_poll_remove_one(poll_req);
-			ret = 0;
-			break;
-		}
-	}
+	ret = io_poll_cancel(ctx, READ_ONCE(sqe->addr));
 	spin_unlock_irq(&ctx->completion_lock);
 
 	io_cqring_add_event(req, ret);
@@ -2200,6 +2207,31 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+static int io_timeout_cancel(struct io_ring_ctx *ctx, __u64 user_data)
+{
+	struct io_kiocb *req;
+	int ret = -ENOENT;
+
+	list_for_each_entry(req, &ctx->timeout_list, list) {
+		if (user_data == req->user_data) {
+			list_del_init(&req->list);
+			ret = 0;
+			break;
+		}
+	}
+
+	if (ret == -ENOENT)
+		return ret;
+
+	ret = hrtimer_try_to_cancel(&req->timeout.timer);
+	if (ret == -1)
+		return -EALREADY;
+
+	io_cqring_fill_event(req, -ECANCELED);
+	io_put_req(req);
+	return 0;
+}
+
 /*
  * Remove or update an existing timeout command
  */
@@ -2207,10 +2239,8 @@ static int io_timeout_remove(struct io_kiocb *req,
 			     const struct io_uring_sqe *sqe)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	struct io_kiocb *treq;
-	int ret = -ENOENT;
-	__u64 user_data;
 	unsigned flags;
+	int ret;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
@@ -2220,42 +2250,15 @@ static int io_timeout_remove(struct io_kiocb *req,
 	if (flags)
 		return -EINVAL;
 
-	user_data = READ_ONCE(sqe->addr);
 	spin_lock_irq(&ctx->completion_lock);
-	list_for_each_entry(treq, &ctx->timeout_list, list) {
-		if (user_data == treq->user_data) {
-			list_del_init(&treq->list);
-			ret = 0;
-			break;
-		}
-	}
-
-	/* didn't find timeout */
-	if (ret) {
-fill_ev:
-		io_cqring_fill_event(req, ret);
-		io_commit_cqring(ctx);
-		spin_unlock_irq(&ctx->completion_lock);
-		io_cqring_ev_posted(ctx);
-		if (req->flags & REQ_F_LINK)
-			req->flags |= REQ_F_FAIL_LINK;
-		io_put_req(req);
-		return 0;
-	}
+	ret = io_timeout_cancel(ctx, READ_ONCE(sqe->addr));
 
-	ret = hrtimer_try_to_cancel(&treq->timeout.timer);
-	if (ret == -1) {
-		ret = -EBUSY;
-		goto fill_ev;
-	}
-
-	io_cqring_fill_event(req, 0);
-	io_cqring_fill_event(treq, -ECANCELED);
+	io_cqring_fill_event(req, ret);
 	io_commit_cqring(ctx);
 	spin_unlock_irq(&ctx->completion_lock);
 	io_cqring_ev_posted(ctx);
-
-	io_put_req(treq);
+	if (ret < 0 && req->flags & REQ_F_LINK)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_put_req(req);
 	return 0;
 }
@@ -2387,10 +2390,24 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	sqe_addr = (void *) (unsigned long) READ_ONCE(sqe->addr);
 	ret = io_async_cancel_one(ctx, sqe_addr);
+	if (ret != -ENOENT) {
+		spin_lock_irq(&ctx->completion_lock);
+		goto done;
+	}
+
+	spin_lock_irq(&ctx->completion_lock);
+	ret = io_timeout_cancel(ctx, (unsigned long) sqe_addr);
+	if (ret != -ENOENT)
+		goto done;
+	ret = io_poll_cancel(ctx, (unsigned long) sqe_addr);
+done:
+	io_cqring_fill_event(req, ret);
+	io_commit_cqring(ctx);
+	spin_unlock_irq(&ctx->completion_lock);
+	io_cqring_ev_posted(ctx);
 
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req, ret);
 	io_put_req_find_next(req, nxt);
 	return 0;
 }

-- 
Jens Axboe

