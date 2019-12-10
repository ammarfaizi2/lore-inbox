Return-Path: <SRS0=l6sb=2A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A733C00454
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707F52053B
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tbT3vOl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfLJP55 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:57:57 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:32977 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLJP55 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Dec 2019 10:57:57 -0500
Received: by mail-io1-f66.google.com with SMTP id s25so4622862iob.0
        for <io-uring@vger.kernel.org>; Tue, 10 Dec 2019 07:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e448OLD1TWIsIcSMCdNIscgSIw1Vhn9nes8gScYchZA=;
        b=tbT3vOl3uUAZqjUJaS7/8q/A/Jgz7N85PqGKfAGwbevvltjulnsjl4Tg/DMCF7lhRE
         rlKOXqqztG+NS0wLGJhbo6U6lU4cukOx6wnTMEsRtAviXtx+rOKJzna/3lRbZZRI62Gx
         nckUl14SrK4IlhitC9SR2Ob0ADf4GWFaOxs6OP4H2BQlzkKjdUz2/aPbxFF+322QERPU
         2FEVv+gzcWFWesHmo8JRLF7Lmg77bk9cDV1jWLn4tztV7Xb+d4zr2h2y1NDPaOnVfYNk
         4nMegcMzE7keNePIQd20m+t67XevsfOlpc6E2B0rtJOy5iNWySw51iHZOuoyLAkqEa4j
         AptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e448OLD1TWIsIcSMCdNIscgSIw1Vhn9nes8gScYchZA=;
        b=nD+f6rNSxO5hQWSAqoh8NQhAD1S+SIDrrgYRsPI/xF41A6j3hWq37UUKNLlgcPpxcA
         TsUtAoRUlyW+RQ+a9+VwHBJGrcBamn+e1OJHFYXA6ZcecYwZ2mSdg5TzKcGqMvEf9zOW
         wuIP1FMGijqbSuuuu9RUU3YhCyZpXgFKEni2GeVwhfFX1jsBVvUnqNa+lMG7v+NLEHlA
         6EQGgx2Flk/fD/fTTogtDZnS/uGr5AD9ek4O8OfSN3V+y35Kij38MsgxSZbuQvKy7gWg
         r8bL5vI7tib80TjosXFds+icdbApzIc2+Iph8u0NERCEmOdpCXq2lBA81jOOFg+mCKXa
         nUig==
X-Gm-Message-State: APjAAAXElzrQX2dG/J8qKyLIHIhRT93hL5BbsB3CkEs7DT305vpWq097
        zRS1K6euZ51k+445MBAT6O5Do0SA4hdVhA==
X-Google-Smtp-Source: APXvYqzjLCCrJoU9WxKSMbU29FWKs4HUjXqoQFb/oO6xcqVOXcljX36a/0Jy+s+REN0IKrN+nEeQLQ==
X-Received: by 2002:a05:6602:24d8:: with SMTP id h24mr15376426ioe.27.1575993475889;
        Tue, 10 Dec 2019 07:57:55 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w6sm770953ioa.16.2019.12.10.07.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:57:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/11] io_uring: use atomic_t for refcounts
Date:   Tue, 10 Dec 2019 08:57:38 -0700
Message-Id: <20191210155742.5844-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210155742.5844-1-axboe@kernel.dk>
References: <20191210155742.5844-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Recently had a regression that turned out to be because
CONFIG_REFCOUNT_FULL was set. Our ref count usage is really simple,
so let's just use atomic_t and get rid of the dependency on the full
reference count checking being enabled or disabled.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9a596b819334..05419a152b32 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -360,7 +360,7 @@ struct io_kiocb {
 	};
 	struct list_head	link_list;
 	unsigned int		flags;
-	refcount_t		refs;
+	atomic_t		refs;
 #define REQ_F_NOWAIT		1	/* must not punt to workers */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
@@ -770,7 +770,7 @@ static void io_cqring_fill_event(struct io_kiocb *req, long res)
 		WRITE_ONCE(ctx->rings->cq_overflow,
 				atomic_inc_return(&ctx->cached_cq_overflow));
 	} else {
-		refcount_inc(&req->refs);
+		atomic_inc(&req->refs);
 		req->result = res;
 		list_add_tail(&req->list, &ctx->cq_overflow_list);
 	}
@@ -852,7 +852,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	req->ctx = ctx;
 	req->flags = 0;
 	/* one is dropped after submission, the other at completion */
-	refcount_set(&req->refs, 2);
+	atomic_set(&req->refs, 2);
 	req->result = 0;
 	INIT_IO_WORK(&req->work, io_wq_submit_work);
 	return req;
@@ -1035,13 +1035,13 @@ static void io_put_req_find_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 {
 	io_req_find_next(req, nxtptr);
 
-	if (refcount_dec_and_test(&req->refs))
+	if (atomic_dec_and_test(&req->refs))
 		__io_free_req(req);
 }
 
 static void io_put_req(struct io_kiocb *req)
 {
-	if (refcount_dec_and_test(&req->refs))
+	if (atomic_dec_and_test(&req->refs))
 		io_free_req(req);
 }
 
@@ -1052,14 +1052,14 @@ static void io_put_req(struct io_kiocb *req)
 static void __io_double_put_req(struct io_kiocb *req)
 {
 	/* drop both submit and complete references */
-	if (refcount_sub_and_test(2, &req->refs))
+	if (atomic_sub_and_test(2, &req->refs))
 		__io_free_req(req);
 }
 
 static void io_double_put_req(struct io_kiocb *req)
 {
 	/* drop both submit and complete references */
-	if (refcount_sub_and_test(2, &req->refs))
+	if (atomic_sub_and_test(2, &req->refs))
 		io_free_req(req);
 }
 
@@ -1108,7 +1108,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 		io_cqring_fill_event(req, req->result);
 		(*nr_events)++;
 
-		if (refcount_dec_and_test(&req->refs)) {
+		if (atomic_dec_and_test(&req->refs)) {
 			/* If we're not using fixed files, we have to pair the
 			 * completion part with the file put. Use regular
 			 * completions for those, only batch free for fixed
@@ -3169,7 +3169,7 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	if (!list_empty(&req->link_list)) {
 		prev = list_entry(req->link_list.prev, struct io_kiocb,
 				  link_list);
-		if (refcount_inc_not_zero(&prev->refs)) {
+		if (atomic_inc_not_zero(&prev->refs)) {
 			list_del_init(&req->link_list);
 			prev->flags &= ~REQ_F_LINK_TIMEOUT;
 		} else
@@ -4237,7 +4237,7 @@ static void io_get_work(struct io_wq_work *work)
 {
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
 
-	refcount_inc(&req->refs);
+	atomic_inc(&req->refs);
 }
 
 static int io_sq_offload_start(struct io_ring_ctx *ctx,
@@ -4722,7 +4722,7 @@ static void io_uring_cancel_files(struct io_ring_ctx *ctx,
 			if (req->work.files != files)
 				continue;
 			/* req is being completed, ignore */
-			if (!refcount_inc_not_zero(&req->refs))
+			if (!atomic_inc_not_zero(&req->refs))
 				continue;
 			cancel_req = req;
 			break;
-- 
2.24.0

