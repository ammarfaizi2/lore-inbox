Return-Path: <SRS0=oqI+=ZD=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9747FC43331
	for <io-uring@archiver.kernel.org>; Mon, 11 Nov 2019 06:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C41320818
	for <io-uring@archiver.kernel.org>; Mon, 11 Nov 2019 06:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MB6mwn3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfKKGjv (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 11 Nov 2019 01:39:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40677 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKGju (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 11 Nov 2019 01:39:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so8816878pgt.7
        for <io-uring@vger.kernel.org>; Sun, 10 Nov 2019 22:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=mAY2fRh438L3O0yL9MohpsT1p6DON3CzjxbJUlgi4aw=;
        b=MB6mwn3y6EjMEM7PA+X5e1+ScSemylxFdAcYk0pmGMdpijhdebkmNoriHP5V152Z0d
         kpqazDLcqdtnQPSE1gaU7Ed3rBIROzQS7gcWVswEZrHaWkrTSVnCfg5Pm8kvcb4uZ+vq
         2tejITjqwehEcutAbuc7ehHig7jTUTmF6vapVh5N/pElLuLkzMNm05lnhs7t6jQvze4k
         vnyPkycV+nmqqGDS2SKJ03Iz2FaOo0u7oOU7i9Wv2OnAsE3LS3gXymnMtUL05qetIGDb
         YP6DdfepO2IxrP7r5asNmRzrpKV9XwQgMx6pLZ7S6W0sw2TawOeKW3H4GaFPp0hThQuN
         MzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mAY2fRh438L3O0yL9MohpsT1p6DON3CzjxbJUlgi4aw=;
        b=Fiz9X/a7E0OsalvmFpIOx9DPgIERe3Bp/Hv1j2duPTFn9G0OU7QV3sDiPJAZTwGHna
         rwku8i1/XHRfRTuTFR+j3Exc8CcLP9gYmHBYnrm27jdkAsT3jpfQnQNmWtCuPY4qd8T+
         GAC2l7mcUmQ4jDUm4KM/d5lvNplsJjWb6sCadD6xcGIGxTsoVbOpkVsVwwaJ4iLYz7Cl
         U6A+o0B4nEClAXlWM7EZDgUt5tfoi1uIZIn6+uCRSV/RgXG5+BK1pyd7aLZkziALNNC+
         ApGGVE0yqUeVHMLQSTzO5fM0e0mvmBvVVqlbo2SVcpK/sb4GOfr9sW3uDG18po46Ytjy
         3DZw==
X-Gm-Message-State: APjAAAXrKE14KjHCIjs5FkgxPS8gUE8tzjwrfe49OEnezebS1/KvCzJD
        l/vzoYqYbzl4/FNC61wbpXnMYw==
X-Google-Smtp-Source: APXvYqyNYnVhXNKLaXefmTzH//wF6EPY21CQIUtQ38ZeuPdJk58qpCBoNdXmiBP0xGvlPJGiJ35Jow==
X-Received: by 2002:a17:90b:30ca:: with SMTP id hi10mr32394798pjb.143.1573454389698;
        Sun, 10 Nov 2019 22:39:49 -0800 (PST)
Received: from [192.168.201.136] ([50.234.116.4])
        by smtp.gmail.com with ESMTPSA id 70sm15745962pfw.160.2019.11.10.22.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 22:39:48 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     Hrvoje Zeba <zeba.hrvoje@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: fix -ENOENT issue with linked timer with short
 timeout
Message-ID: <8527992c-7485-aa8a-5050-a7d4b07f9e8b@kernel.dk>
Date:   Sun, 10 Nov 2019 22:39:47 -0800
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

If you prep a read (for example) that needs to get punted to async
context with a timer, if the timeout is sufficiently short, the timer
request will get completed with -ENOENT as it could not find the read.

The issue is that we prep and start the timer before we start the read.
Hence the timer can trigger before the read is even started, and the end
result is then that the timer completes with -ENOENT, while the read
starts instead of being cancelled by the timer.

Fix this by splitting the linked timer into two parts:

1) Prep and validate the linked timer
2) Start timer

The read is then started between steps 1 and 2, so we know that the
timer will always have a consistent view of the read request state.

Reported-by: Hrvoje Zeba <zeba.hrvoje@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 83c8c6b98026..55e0cb03615e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2688,13 +2688,17 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	 */
 	if (!list_empty(&req->list)) {
 		prev = list_entry(req->list.prev, struct io_kiocb, link_list);
-		list_del_init(&req->list);
+		if (refcount_inc_not_zero(&prev->refs))
+			list_del_init(&req->list);
+		else
+			prev = NULL;
 	}
 
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 	if (prev) {
 		io_async_find_and_cancel(ctx, req, prev->user_data, NULL);
+		io_put_req(prev);
 	} else {
 		io_cqring_add_event(req, -ETIME);
 		io_put_req(req);
@@ -2702,78 +2706,70 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-static int io_queue_linked_timeout(struct io_kiocb *req, struct io_kiocb *nxt)
+static void io_queue_linked_timeout(struct io_kiocb *req, struct timespec64 *ts,
+				    enum hrtimer_mode *mode)
 {
-	const struct io_uring_sqe *sqe = nxt->submit.sqe;
-	enum hrtimer_mode mode;
-	struct timespec64 ts;
-	int ret = -EINVAL;
+	req->timeout.timer.function = io_link_timeout_fn;
+	hrtimer_start(&req->timeout.timer, timespec64_to_ktime(*ts), *mode);
+}
 
+static int io_validate_link_timeout(const struct io_uring_sqe *sqe,
+				    struct timespec64 *ts)
+{
 	if (sqe->ioprio || sqe->buf_index || sqe->len != 1 || sqe->off)
-		goto err;
+		return -EINVAL;
 	if (sqe->timeout_flags & ~IORING_TIMEOUT_ABS)
-		goto err;
-	if (get_timespec64(&ts, u64_to_user_ptr(sqe->addr))) {
-		ret = -EFAULT;
-		goto err;
-	}
-
-	req->flags |= REQ_F_LINK_TIMEOUT;
-
-	if (sqe->timeout_flags & IORING_TIMEOUT_ABS)
-		mode = HRTIMER_MODE_ABS;
-	else
-		mode = HRTIMER_MODE_REL;
-	hrtimer_init(&nxt->timeout.timer, CLOCK_MONOTONIC, mode);
-	nxt->timeout.timer.function = io_link_timeout_fn;
-	hrtimer_start(&nxt->timeout.timer, timespec64_to_ktime(ts), mode);
-	ret = 0;
-err:
-	/* drop submission reference */
-	io_put_req(nxt);
-
-	if (ret) {
-		struct io_ring_ctx *ctx = req->ctx;
-
-		/*
-		 * Break the link and fail linked timeout, parent will get
-		 * failed by the regular submission path.
-		 */
-		list_del(&nxt->list);
-		io_cqring_fill_event(nxt, ret);
-		trace_io_uring_fail_link(req, nxt);
-		io_commit_cqring(ctx);
-		io_put_req(nxt);
-		ret = -ECANCELED;
-	}
+		return -EINVAL;
+	if (get_timespec64(ts, u64_to_user_ptr(sqe->addr)))
+		return -EFAULT;
 
-	return ret;
+	return 0;
 }
 
-static inline struct io_kiocb *io_get_linked_timeout(struct io_kiocb *req)
+static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req,
+					       struct timespec64 *ts,
+					       enum hrtimer_mode *mode)
 {
 	struct io_kiocb *nxt;
+	int ret;
 
 	if (!(req->flags & REQ_F_LINK))
 		return NULL;
 
 	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
-	if (nxt && nxt->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT)
-		return nxt;
+	if (!nxt || nxt->submit.sqe->opcode != IORING_OP_LINK_TIMEOUT)
+		return NULL;
 
-	return NULL;
+	ret = io_validate_link_timeout(nxt->submit.sqe, ts);
+	if (ret) {
+		list_del_init(&nxt->list);
+		io_cqring_add_event(nxt, ret);
+		io_double_put_req(nxt);
+		return ERR_PTR(-ECANCELED);
+	}
+
+	if (nxt->submit.sqe->timeout_flags & IORING_TIMEOUT_ABS)
+		*mode = HRTIMER_MODE_ABS;
+	else
+		*mode = HRTIMER_MODE_REL;
+
+	req->flags |= REQ_F_LINK_TIMEOUT;
+	hrtimer_init(&nxt->timeout.timer, CLOCK_MONOTONIC, *mode);
+	io_put_req(nxt);
+	return nxt;
 }
 
 static int __io_queue_sqe(struct io_kiocb *req)
 {
+	enum hrtimer_mode mode;
 	struct io_kiocb *nxt;
+	struct timespec64 ts;
 	int ret;
 
-	nxt = io_get_linked_timeout(req);
-	if (unlikely(nxt)) {
-		ret = io_queue_linked_timeout(req, nxt);
-		if (ret)
-			goto err;
+	nxt = io_prep_linked_timeout(req, &ts, &mode);
+	if (IS_ERR(nxt)) {
+		ret = PTR_ERR(nxt);
+		goto err;
 	}
 
 	ret = __io_submit_sqe(req, NULL, true);
@@ -2803,12 +2799,16 @@ static int __io_queue_sqe(struct io_kiocb *req)
 			 * submit reference when the iocb is actually submitted.
 			 */
 			io_queue_async_work(req);
+
+			if (nxt)
+				io_queue_linked_timeout(nxt, &ts, &mode);
+
 			return 0;
 		}
 	}
 
-	/* drop submission reference */
 err:
+	/* drop submission reference */
 	io_put_req(req);
 
 	/* and drop final reference, if we failed */

-- 
Jens Axboe

