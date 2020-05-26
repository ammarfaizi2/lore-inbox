Return-Path: <SRS0=0Or6=7I=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BB0C433E1
	for <io-uring@archiver.kernel.org>; Tue, 26 May 2020 17:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6565A20704
	for <io-uring@archiver.kernel.org>; Tue, 26 May 2020 17:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5ceQ3ER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389286AbgEZRft (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 26 May 2020 13:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389270AbgEZRfs (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 26 May 2020 13:35:48 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34566C03E96D;
        Tue, 26 May 2020 10:35:48 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id se13so24689749ejb.9;
        Tue, 26 May 2020 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1dNRVhEWH4GCqg+T6vhCKgSZ3Uxjhegqgc6JAK8cXG0=;
        b=h5ceQ3ERpEUrsHMLuRCi0TaKbPggwwlKIxiNUQ84CddADuYhUWrp/8R5aUfYgS7OQa
         DT0HfNAVbZz7guroDGiDZiYgODSJPjXDAaKGf+6KmuJVHfwHYdbQJyR5TdA4wcsplBBl
         AvAuYzUKez7GR8eusxkvXOQX/GnZpWG741B5jTc68RzsNN/OZStnmWNvt35hf2tKidvh
         Tc58lX2u7P+ic8roDwKXZbfAOnvoVoWeR2GL+coU4srBMVwPN4pijlfG91hp0LLKLcNH
         JeuOdusN+V9gGGvHNOI/4judxgy9QORqFNjtK4qPza9bClCzUBdlzOscXkEhIlnIMEtr
         9Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1dNRVhEWH4GCqg+T6vhCKgSZ3Uxjhegqgc6JAK8cXG0=;
        b=Tp0HegR424SD7PrhJcDbkpYTvs+CJLziZ4heoF+H8DFah9JhncsiiLQqWmVQQpme6s
         Gurv2N4IzCnXJTArM/2Co2pHTq+cK0p8IDHg5o18743rkS2erBa4w/yhEXrp0mMSi1w+
         uueQNo1bwFiSgmpLB0uNmvQ6XXnzyoakNIEYNBRsFq4BEwnPfZ9ZcCpXlpbcB3E/vm9a
         ajcKIYBe1MoihpZsqoit2x9vkSe4wQbJUm0yvNdp7iHTPytCl+6zZvBir5xa6/yHekRB
         XRUtV0sWtyBShnwO+AD7k7qYrUG72aNyMvd7KeBSL5l4t7YoR2uPyC/JEAij7ueXEuPD
         d+Iw==
X-Gm-Message-State: AOAM531U7iSfy6wBuMMmnKsJsKpHIBCgUyCLyMn/6YF40mZSAxqD6Hg6
        icQqOWwG6oJD9T/UiEONm2w=
X-Google-Smtp-Source: ABdhPJzpajZIrf89uoVrNG8j5X268+SwDB2Tndpkr/lHIC3uqsEi0hAWabPkyX/bmQHZTDU71f6miA==
X-Received: by 2002:a17:906:68d2:: with SMTP id y18mr2168088ejr.248.1590514546828;
        Tue, 26 May 2020 10:35:46 -0700 (PDT)
Received: from localhost.localdomain ([5.100.193.151])
        by smtp.gmail.com with ESMTPSA id bz8sm391326ejc.94.2020.05.26.10.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 10:35:46 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] io_uring: separate DRAIN flushing into a cold path
Date:   Tue, 26 May 2020 20:34:05 +0300
Message-Id: <2f9403ad657d7f8eaaa2687d68a2d05599812e7e.1590513806.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1590513806.git.asml.silence@gmail.com>
References: <cover.1590513806.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

io_commit_cqring() assembly doesn't look good with extra code handling
drained requests. IOSQE_IO_DRAIN is slow and discouraged to be used in
a hot path, so try to minimise its impact by putting it into a helper
and doing a fast check.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 067ebdeb1ba4..acf6ce9eee68 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -982,19 +982,6 @@ static inline bool req_need_defer(struct io_kiocb *req)
 	return false;
 }
 
-static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
-{
-	struct io_kiocb *req;
-
-	req = list_first_entry_or_null(&ctx->defer_list, struct io_kiocb, list);
-	if (req && !req_need_defer(req)) {
-		list_del_init(&req->list);
-		return req;
-	}
-
-	return NULL;
-}
-
 static struct io_kiocb *io_get_timeout_req(struct io_ring_ctx *ctx)
 {
 	struct io_kiocb *req;
@@ -1127,6 +1114,19 @@ static void io_kill_timeouts(struct io_ring_ctx *ctx)
 	spin_unlock_irq(&ctx->completion_lock);
 }
 
+static void __io_queue_deferred(struct io_ring_ctx *ctx)
+{
+	do {
+		struct io_kiocb *req = list_first_entry(&ctx->defer_list,
+							struct io_kiocb, list);
+
+		if (req_need_defer(req))
+			break;
+		list_del_init(&req->list);
+		io_queue_async_work(req);
+	} while (!list_empty(&ctx->defer_list));
+}
+
 static void io_commit_cqring(struct io_ring_ctx *ctx)
 {
 	struct io_kiocb *req;
@@ -1136,8 +1136,8 @@ static void io_commit_cqring(struct io_ring_ctx *ctx)
 
 	__io_commit_cqring(ctx);
 
-	while ((req = io_get_deferred_req(ctx)) != NULL)
-		io_queue_async_work(req);
+	if (unlikely(!list_empty(&ctx->defer_list)))
+		__io_queue_deferred(ctx);
 }
 
 static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
-- 
2.24.0

