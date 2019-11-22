Return-Path: <SRS0=nrYQ=ZO=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327A4C432C3
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 04:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEB32068D
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 04:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZJpRdKPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfKVEEW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 23:04:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38669 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKVEEW (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 23:04:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id t3so2259822pgl.5
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 20:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QuqZsbWQWPO6ogIcK8s9iOZYm0gFCuSjaTina0uKJQQ=;
        b=ZJpRdKPRFtX/GozpxkVU9Le8nnRELFLl0HmluUlfjCtWfK6RjAUERuNJkVoR8FN/wH
         ndg0stgVFqtLPoHfR4iSsF7qdNFqFj7SsN9hdaquDI8g8GFyYfeJy/6OPA2wjyMlghHc
         /TPiUhRbq5xhKZ1TQ77jlSUVShdWzkoE5Kbfts0yfybUO7IfMI/RfR0jOgJOLFdoGqAO
         qrupeALE248d8U2c2WJnCyqX9aKheJ0CNbel2Ua1z0/wpzllK1tbZjCnfsajqKlVe9OF
         G7SO/X4vGkmo9TAjIUnGeyQEgeW4Jrw52sj+qHzQ1yLy0mR3FB9tSVaKpQx2uCUuxY0Z
         AMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QuqZsbWQWPO6ogIcK8s9iOZYm0gFCuSjaTina0uKJQQ=;
        b=k788NkowvOwCAWNBcDGTAZglhSbaQpGNCWeJEA7tqIQsODYLYz8K7N/qZVSxHYApiX
         DPIwx5OebrXvGFYHxGIU7EV5mUIhq8/02Px+IX0oYnxxCcQxGPsCErPxgXozj5Ybpy3B
         frLiF96AClil/dTc8n4ZbywjbINNBeThDE4KoX8GTlplqWH8r2qdA5/ZD4JgzT4XN9Tw
         YHAEkFx6BYgNl0CaPSkBKOTPrZqNKCPaPq1nbDmJ5aE/D2o2VNh7bE1BIXBQOeHog3W3
         i4R3BsgwT9eBQ9ZPVFS31oMC9AUFvCg3w2cSfMR5uOXlGSF3W93RxI6CraK8l0Ycv/dB
         lYXg==
X-Gm-Message-State: APjAAAVlbHkFvdrFMkp5AtJ3/5fCLLwk3aCVfOp/dRFOt96EHNM0U86G
        RTfT5B21lcdRzvfG4YdVgQfFS6Q47wg=
X-Google-Smtp-Source: APXvYqwT/tgPV32XZV6GbKazQsd7h2/FLAvgbnxJwsAp/GSTHoyw5eWO7PQUeLW3kPX5XB3b/vRk7A==
X-Received: by 2002:a65:4387:: with SMTP id m7mr6228736pgp.449.1574395459881;
        Thu, 21 Nov 2019 20:04:19 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::12a6? ([2620:10d:c090:180::38ae])
        by smtp.gmail.com with ESMTPSA id h62sm3058948pge.89.2019.11.21.20.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 20:04:19 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     Dan Melnic <dmm@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: only return -EBUSY for submit on non-flushed
 backlog
Message-ID: <9aca99cc-bd0f-4137-cec3-b8bbea17c5d2@kernel.dk>
Date:   Thu, 21 Nov 2019 21:04:16 -0700
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

We return -EBUSY on submit when we have a CQ ring overflow backlog, but
that can be a bit problematic if the application is using pure userspace
poll of the CQ ring. For that case, if the ring briefly overflowed and
we have pending entries in the backlog, the submit flushes the backlog
successfully but still returns -EBUSY. If we're able to fully flush the
CQ ring backlog, let the submission proceed.

Reported-by: Dan Melnic <dmm@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 013e5ed6b754..0c66cd6ed0b0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -649,7 +649,8 @@ static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
 		eventfd_signal(ctx->cq_ev_fd, 1);
 }
 
-static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
+/* Returns true if there are no backlogged entries after the flush */
+static bool io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
 {
 	struct io_rings *rings = ctx->rings;
 	struct io_uring_cqe *cqe;
@@ -659,10 +660,10 @@ static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
 
 	if (!force) {
 		if (list_empty_careful(&ctx->cq_overflow_list))
-			return;
+			return true;
 		if ((ctx->cached_cq_tail - READ_ONCE(rings->cq.head) ==
 		    rings->cq_ring_entries))
-			return;
+			return false;
 	}
 
 	spin_lock_irqsave(&ctx->completion_lock, flags);
@@ -671,6 +672,7 @@ static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
 	if (force)
 		ctx->cq_overflow_flushed = true;
 
+	cqe = NULL;
 	while (!list_empty(&ctx->cq_overflow_list)) {
 		cqe = io_get_cqring(ctx);
 		if (!cqe && !force)
@@ -698,6 +700,8 @@ static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
 		list_del(&req->list);
 		io_put_req(req);
 	}
+
+	return cqe != NULL;
 }
 
 static void io_cqring_fill_event(struct io_kiocb *req, long res)
@@ -3127,10 +3131,10 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	int i, submitted = 0;
 	bool mm_fault = false;
 
-	if (!list_empty(&ctx->cq_overflow_list)) {
-		io_cqring_overflow_flush(ctx, false);
+	/* if we have a backlog and couldn't flush it all, return BUSY */
+	if (!list_empty(&ctx->cq_overflow_list) &&
+	    !io_cqring_overflow_flush(ctx, false))
 		return -EBUSY;
-	}
 
 	if (nr > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, nr);

-- 
Jens Axboe

