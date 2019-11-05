Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB0BC5DF62
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC552084D
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgyoaa7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfKEXFb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:05:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37765 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfKEXFb (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 18:05:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id q130so1227225wme.2;
        Tue, 05 Nov 2019 15:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K4HSlR1svrgFdOVbEL5IMlVxcn9RvX0EQvAJKCf+mao=;
        b=vgyoaa7JayR4PIKIgFbd98uvjj33uMDx4kfaJyb5sV8rbxf+FuLfPQtDhTkQ+axE3X
         z4vdjTopwuRFh57a1Q0kqMRtEd+FuhD1aLVDwpcbUwn2AnbgeOOdysP7PFbB4tCPGa53
         WVDBBQqL0yHqF15q2DDNigAhBeAnPKty72GqHrA1A4mvyA9fwjJtMQrbBzs53Z5mbJ58
         Ohb9+qY2mI81i56J6bHdN6mgrj9tCAZVf6xC02PDj6IZjx/Br0DrgVtVfkjC3jN3M+Ja
         4AYLc0Eupw8N0PSJ0WD0LzpDpLpTBO1oR11wkvIBrSjWDzc+zdLswnY3Rab/N9WQcG0t
         LEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K4HSlR1svrgFdOVbEL5IMlVxcn9RvX0EQvAJKCf+mao=;
        b=iLDPVi1HY1I3bZEyzdKdPe6/vuAITIC/XwN78c93seqnVNBA9qllqtTBC4KdFFsOUE
         FQcSyaHZpq/mUY9S9/xcxCa3lRpWswvKZu0Uj3IOpfMO6RHOHlVJF1RZz1lfiGJdskGe
         2fCRyKukqpj0SQD4dHLjweus4ix9wpBzgK0vLgUf/Ncc5xlr/X8xz859VuaU1aIwcnnE
         /Cw2r5+Rr30qV0f1iabmwLuHpsQdu5rakucqiD+Q/Z6Busp7vAyCDVlYFg/5k2k3FkUN
         gx204st5XvfiXXGSJBQJvBdsWXv1tjov8OjEPQ6OAwJd9zjsgcU0GP8cOv/6uBaFplvs
         +COA==
X-Gm-Message-State: APjAAAV6jG8y1QSLuSKivPL6bc21rG9/oqeyDLgT4pntbyfqLQk9L+lO
        2TG+sjcrGd1OG08A+tnRcyQ=
X-Google-Smtp-Source: APXvYqxw1JGo7f/Pa83tGSFcGvadlSS5VcQFLclbIwgkQ0Mx2FJcjZMNq+UsCxpn9t6rt01fMy9FEw==
X-Received: by 2002:a05:600c:3cf:: with SMTP id z15mr1208530wmd.76.1572995128729;
        Tue, 05 Nov 2019 15:05:28 -0800 (PST)
Received: from localhost.localdomain ([109.126.129.81])
        by smtp.gmail.com with ESMTPSA id x8sm15579658wrm.7.2019.11.05.15.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 15:05:28 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 1/3] io_uring: allocate io_kiocb upfront
Date:   Wed,  6 Nov 2019 02:04:43 +0300
Message-Id: <d2bac0d2571d3cb15b415f81068dd0f0649b08f2.1572993994.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572993994.git.asml.silence@gmail.com>
References: <cover.1572993994.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Preparation patch.
Make io_submit_sqes() to allocate io_kiocb, and then pass it further.
Another difference is that it's allocated before we get an sqe.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 82c2da99cb5c..920ad731db01 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2538,30 +2538,23 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 
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
@@ -2697,9 +2690,15 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 
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
@@ -2727,7 +2726,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		s.in_async = async;
 		s.needs_fixed_file = async;
 		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, async);
-		io_submit_sqe(ctx, &s, statep, &link);
+		io_submit_sqe(ctx, req, &s, statep, &link);
 		submitted++;
 
 		/*
-- 
2.23.0

