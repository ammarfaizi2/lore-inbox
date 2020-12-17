Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648FAC1B0D8
	for <io-uring@archiver.kernel.org>; Thu, 17 Dec 2020 00:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9D123787
	for <io-uring@archiver.kernel.org>; Thu, 17 Dec 2020 00:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgLQA2t (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 16 Dec 2020 19:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgLQA2t (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 16 Dec 2020 19:28:49 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B5FC0617A7
        for <io-uring@vger.kernel.org>; Wed, 16 Dec 2020 16:28:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k10so3969202wmi.3
        for <io-uring@vger.kernel.org>; Wed, 16 Dec 2020 16:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/j2Jp0V6vqRQx5Q2YSAM0H9pZCniClses7nnCu63fWA=;
        b=E59jQPNjyiE9MUVMzzpHCn0VER50V1resma153he2eV+nHpJRCcnKteGpXF+wesPM3
         L3HpYWsjkx1P8j74OIY8YLjjt89CPL5NFm9+9kzckjXdi/2TIUidm/qY69hTbQJoUY5q
         TVwOKmeze9D9m0STNtJ2mQc76w4qlA7JziZTezBirUtbw2AW+L+9+tzcf+v4sI6ecR80
         DsZmJuVCUriwBugO8j2XcnDqDGRoYl1N672cMPn0jRQ/vDK8si3tVan8dBVebSqyYBv3
         8zDJxZYsWHFxEfEBLRxbGwvv6LWzlfaeflFL/yjz4BXyDqnsT+lNvj526v/X1UTV6BM5
         dpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/j2Jp0V6vqRQx5Q2YSAM0H9pZCniClses7nnCu63fWA=;
        b=cMnLBMdEomk9CTeDGQAd1jhaDkjnvoZK24tMk1WtqysnX7w9aAzeXB32Qg/AMp2P25
         T4IaK16gMy6Oe4A+nn6CR+N28iqVAEm3AkTfap9IzmX3t97/etvXhDG9VXLz5WrAIyQW
         NPHtqAi91slt0hvx9dUggJkF1J2j0K+mG7GPJayObJzGymoei042kkdCJ0Fxq/olKASM
         NB4gtddMbPLqyKCSClOvrUYG/KNGbaShjebDE65FwkIwMhZ/tR+pVgk+m/lLO9H/MMB9
         xrBiI4J5vqjQEnqlGAezDCHVuKzHenYFcup4GxHCA1d1ID//YeUSh1KykcHMVxb5ASBL
         28Ww==
X-Gm-Message-State: AOAM533gXmg1e5U87XguvM+u4ajFmP/oLVMFLX0RnlGHPPt+IawBFdmA
        cahLdiLgc4XdC4jiZG0QvbU=
X-Google-Smtp-Source: ABdhPJzrHpYKTdtSoDOA7mLTdrL2o6K2/rJLYwq/deIJakwAVNa7ljIVNsyBwr3q2/dCC/HlVh9epw==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr6073102wme.23.1608164887750;
        Wed, 16 Dec 2020 16:28:07 -0800 (PST)
Received: from localhost.localdomain ([185.69.144.225])
        by smtp.gmail.com with ESMTPSA id h29sm5711161wrc.68.2020.12.16.16.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 16:28:07 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 4/5] io_uring: inline io_cqring_mark_overflow()
Date:   Thu, 17 Dec 2020 00:24:38 +0000
Message-Id: <cb8d272b6ee6fb0491151a8593b130cbe3604db5.1608164394.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1608164394.git.asml.silence@gmail.com>
References: <cover.1608164394.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

There is only one user of it and the name is misleading, get rid of it
by inlining. By the way make overflow_flush's return value deduction
simpler.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8f3588f4cb38..ce580678b8ed 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1709,15 +1709,6 @@ static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
 		eventfd_signal(ctx->cq_ev_fd, 1);
 }
 
-static void io_cqring_mark_overflow(struct io_ring_ctx *ctx)
-{
-	if (list_empty(&ctx->cq_overflow_list)) {
-		clear_bit(0, &ctx->sq_check_overflow);
-		clear_bit(0, &ctx->cq_check_overflow);
-		ctx->rings->sq_flags &= ~IORING_SQ_CQ_OVERFLOW;
-	}
-}
-
 /* Returns true if there are no backlogged entries after the flush */
 static bool io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force,
 				     struct task_struct *tsk,
@@ -1727,13 +1718,13 @@ static bool io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force,
 	struct io_kiocb *req, *tmp;
 	struct io_uring_cqe *cqe;
 	unsigned long flags;
+	bool all_flushed;
 	LIST_HEAD(list);
 
 	if (!force && __io_cqring_events(ctx) == rings->cq_ring_entries)
 		return false;
 
 	spin_lock_irqsave(&ctx->completion_lock, flags);
-	cqe = NULL;
 	list_for_each_entry_safe(req, tmp, &ctx->cq_overflow_list, compl.list) {
 		if (!io_match_task(req, tsk, files))
 			continue;
@@ -1754,9 +1745,14 @@ static bool io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force,
 		}
 	}
 
-	io_commit_cqring(ctx);
-	io_cqring_mark_overflow(ctx);
+	all_flushed = list_empty(&ctx->cq_overflow_list);
+	if (all_flushed) {
+		clear_bit(0, &ctx->sq_check_overflow);
+		clear_bit(0, &ctx->cq_check_overflow);
+		ctx->rings->sq_flags &= ~IORING_SQ_CQ_OVERFLOW;
+	}
 
+	io_commit_cqring(ctx);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 	io_cqring_ev_posted(ctx);
 
@@ -1766,7 +1762,7 @@ static bool io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force,
 		io_put_req(req);
 	}
 
-	return cqe != NULL;
+	return all_flushed;
 }
 
 static void __io_cqring_fill_event(struct io_kiocb *req, long res, long cflags)
-- 
2.24.0

