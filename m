Return-Path: <SRS0=rTNh=2H=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B645C43603
	for <io-uring@archiver.kernel.org>; Tue, 17 Dec 2019 22:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40145206E0
	for <io-uring@archiver.kernel.org>; Tue, 17 Dec 2019 22:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+Gbqi40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfLQW3U (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:29:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34788 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfLQW3U (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 17 Dec 2019 17:29:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so187239wrr.1;
        Tue, 17 Dec 2019 14:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aber1vb0rqClqP4Eusyc1u8qLbsEelt+bd1/MaFY8Y4=;
        b=H+Gbqi40ANhhfugSzZ5l3x/nWHcUUktrQxurPvVHmeN2uTGLGa9iAVqF0hWOp4S6kG
         sow2dJy2JCDgXMZpoe9v91T5dI47+ou4FS1qgHnQ1aJSZaT/tEFVn/E3IUJAHbB+nZg+
         0Hglb4ujtaQ4x+w7dHQenmhepCMjK6upvBoTKCsA3qmU0GiWQJJcpRIeHFTTrEvLvGvU
         HSbg/EThKCR7E+EuUMdSuH3AaH53qw5pWxmNRMtoHRkMastW/RG1FL19nJPDY8WD7rqd
         7ueJEA8DLpv9eGtTt+Tz8SHT9joDciBIqPFT/ZSDNEsrfCCj+YEGuYifWsyUyIgcNOul
         cyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aber1vb0rqClqP4Eusyc1u8qLbsEelt+bd1/MaFY8Y4=;
        b=irjMR9gcGoQVdbzlOBog9gqUVGYPk+BT/+94YHWuMUhewvZ33Z1Pwst1Fsnto+i0cx
         i2YGZauuC+gETeIixi9Cct77EF5H02FyndRFkf5mTKjAhKn5H9CpaBapEQKHbSQ/yRjA
         k/5hlZfKZ7VSOTOzUdnZ5zUq4mInIrVuolqtLwtuZs86w5bb8dRmRiHL2Etc7aPnaj+l
         m2lkg5c6jAtoyx6J4B1far0niWKufea7QtkaGnnkCDDy11WKS5dP6SzkigvQLH2X9J0r
         lxU3//amg2amNI4JRylkqGQs66bz/zB5FTUbXcWOE4/bkP0kl6pQBf37uW7U3wnhY/Oa
         nO3A==
X-Gm-Message-State: APjAAAUSXVC+93eT+WBfXy9XXv5s8UzHybjOjL4VV7nlYgAGWkjBN3pk
        +MfRki9QV4Pxp6GFK2QQNvjB0Dll
X-Google-Smtp-Source: APXvYqz2LG9onczwpw3P3jtIw28QHlYfkKKnLdpk3CAC9Av1vFilPuOL8ZEeUtmnq+JrNtuERDswxQ==
X-Received: by 2002:a05:6000:1052:: with SMTP id c18mr39471537wrx.268.1576621758002;
        Tue, 17 Dec 2019 14:29:18 -0800 (PST)
Received: from localhost.localdomain ([109.126.149.134])
        by smtp.gmail.com with ESMTPSA id q68sm306036wme.14.2019.12.17.14.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 14:29:17 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] io_uring: batch getting pcpu references
Date:   Wed, 18 Dec 2019 01:28:39 +0300
Message-Id: <b72c5ec7f6d9a9881948de6cb88d30cc5e0354e9.1576621553.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1576621553.git.asml.silence@gmail.com>
References: <cover.1576621553.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

percpu_ref_tryget() has its own overhead. Instead getting a reference
for each request, grab a bunch once per io_submit_sqes().

basic benchmark with submit and wait 128 non-linked nops showed ~5%
performance gain. (7044 KIOPS vs 7423)

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

For notice: it could be done without @extra_refs variable,
but looked too tangled because of gotos.


 fs/io_uring.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index cf4138f0e504..6c85dfc62224 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -845,9 +845,6 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
 	struct io_kiocb *req;
 
-	if (!percpu_ref_tryget(&ctx->refs))
-		return NULL;
-
 	if (!state) {
 		req = kmem_cache_alloc(req_cachep, gfp);
 		if (unlikely(!req))
@@ -3929,6 +3926,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	struct io_submit_state state, *statep = NULL;
 	struct io_kiocb *link = NULL;
 	int i, submitted = 0;
+	unsigned int extra_refs;
 	bool mm_fault = false;
 
 	/* if we have a backlog and couldn't flush it all, return BUSY */
@@ -3941,6 +3939,10 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		statep = &state;
 	}
 
+	if (!percpu_ref_tryget_many(&ctx->refs, nr))
+		return -EAGAIN;
+	extra_refs = nr;
+
 	for (i = 0; i < nr; i++) {
 		struct io_kiocb *req = io_get_req(ctx, statep);
 
@@ -3949,6 +3951,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 				submitted = -EAGAIN;
 			break;
 		}
+		--extra_refs;
 		if (!io_get_sqring(ctx, req)) {
 			__io_free_req(req);
 			break;
@@ -3976,6 +3979,8 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		io_queue_link_head(link);
 	if (statep)
 		io_submit_state_end(&state);
+	if (extra_refs)
+		percpu_ref_put_many(&ctx->refs, extra_refs);
 
 	 /* Commit SQ ring head once we've consumed and submitted all SQEs */
 	io_commit_sqring(ctx);
-- 
2.24.0

