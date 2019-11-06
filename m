Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B26C5DF64
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318A32173E
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aso9zoIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKFWBC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:01:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39006 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKFWBC (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 17:01:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id a11so410852wra.6;
        Wed, 06 Nov 2019 14:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X7atTRdyYArbkosaqMJAJ0E0O53nn9iIyABUEmzL+VY=;
        b=Aso9zoIbXKx1vRanWg1lwIu9ppK6GgKjJjVdrkWs0zytKU50bsQp6bOR8qbuptVTQO
         KK6Jsnv0EKBFwCEkqW6AD9V8NxlqAHtNVd6TrvyVNU0yHXg0hMrv1qf/nqThUeFaxv30
         oE9HtaJxmZHBMMoEkrwbKp2d4LTC454UcIXJ72FVmFegh/x18NFk81qwBJi2jFM0Cmzi
         r1uHMXxVcclKfNmAKtRI67RNOosgIB0uDOeBRmyXY49qWorApAfEDwderFUZWd7jLl/C
         2z5RKOOV9fC25lCnQNUC1Mo8pqKB9999FxwWbJCIrreQ52iMx3c9+RgQdD8+QEkd4r/+
         fDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7atTRdyYArbkosaqMJAJ0E0O53nn9iIyABUEmzL+VY=;
        b=F+SLh0bxJV6ds8cxEU88HnXyxFEhZCih9AN5SXUEtjPnFe5qDqqMuFY4dbJETs43bv
         4Cb4AJ1t1KFRyxo0qLhda6KNjb82NAgF6hb+yD+v0d+JyQxFWmkVjRHih/b/95lUNkhp
         2xdyuo4Is0Fp4sC7/e3gp/vT1zi9Kr6daCfWqXZWVimZCTq6tx3AvL0BoeC0TONajY+e
         4sj0rar15nwDzZTDK5EpjyQS2sS3OQ7kRX2ZAWUMTsaSpFMGdZUzkZv9e5QcCi0IakgK
         vZhlz6IXQ3K1lluCvEDY6A/pWrVBMACdorytAHwsAITzAH4tIO+ujZE4R8l++Y/AnZCH
         6TWQ==
X-Gm-Message-State: APjAAAXYSZ1WpCSMoF3qnIlY6jt7zUIjKyhi11ZaMvC3oy1gxlca5yjm
        EA5XgbXN/gLzunLpIYqHjSXb63kXE8k=
X-Google-Smtp-Source: APXvYqy6etY01eyufqs7QQR91A6Se5YsdGKHBL8VHWq1k/Oann29fmQrIiNO3ELPs1XNFhLk6Jp5Kw==
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr5092169wrn.256.1573077660670;
        Wed, 06 Nov 2019 14:01:00 -0800 (PST)
Received: from localhost.localdomain ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id c24sm62159wrb.27.2019.11.06.14.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 14:01:00 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v2 1/3] io_uring: allocate io_kiocb upfront
Date:   Thu,  7 Nov 2019 01:00:30 +0300
Message-Id: <ed30899d479bf40c6d386cac5d9401892836c3b5.1573077364.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1573077364.git.asml.silence@gmail.com>
References: <cover.1573077364.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Let io_submit_sqes() to allocate io_kiocb before fetching an sqe.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6524898831e0..0289bb3cc697 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2551,30 +2551,23 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 
 #define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK)
 
-static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
-			  struct io_submit_state *state, struct io_kiocb **link)
+static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			  struct sqe_submit *s, struct io_submit_state *state,
+			  struct io_kiocb **link)
 {
 	struct io_uring_sqe *sqe_copy;
-	struct io_kiocb *req;
 	int ret;
 
 	/* enforce forwards compatibility on users */
 	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
 		ret = -EINVAL;
-		goto err;
-	}
-
-	req = io_get_req(ctx, state);
-	if (unlikely(!req)) {
-		ret = -EAGAIN;
-		goto err;
+		goto err_req;
 	}
 
 	ret = io_req_set_file(ctx, s, state, req);
 	if (unlikely(ret)) {
 err_req:
 		io_free_req(req, NULL);
-err:
 		io_cqring_add_event(ctx, s->sqe->user_data, ret);
 		return;
 	}
@@ -2710,9 +2703,15 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 
 	for (i = 0; i < nr; i++) {
 		struct sqe_submit s;
+		struct io_kiocb *req;
 
-		if (!io_get_sqring(ctx, &s))
+		req = io_get_req(ctx, statep);
+		if (unlikely(!req))
 			break;
+		if (!io_get_sqring(ctx, &s)) {
+			__io_free_req(req);
+			break;
+		}
 
 		if (io_sqe_needs_user(s.sqe) && !*mm) {
 			mm_fault = mm_fault || !mmget_not_zero(ctx->sqo_mm);
@@ -2740,7 +2739,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		s.in_async = async;
 		s.needs_fixed_file = async;
 		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, async);
-		io_submit_sqe(ctx, &s, statep, &link);
+		io_submit_sqe(ctx, req, &s, statep, &link);
 		submitted++;
 
 		/*
-- 
2.23.0

