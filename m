Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D90C5DF60
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 21:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296C521929
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 21:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaeKDjaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfKEVWi (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:22:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35135 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfKEVWh (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 16:22:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id l10so23206420wrb.2;
        Tue, 05 Nov 2019 13:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5EDy+50o4mSxYJD87pw0KYNW/6Dq6N/yrH1gcPWLVMA=;
        b=ZaeKDjaaDerDEt6OEbAspHw3lNrC3tyjUg3hh5Kifb/Pnb/3PcCsdOY/+YdEY/wn94
         C/ZKUx/gDcWA96Y+KC6dMdbsvH383yMZY2LpXiuQsy+iigXlxmJHX+rAHkBT8q0zHZBh
         a2VlYzEwKiKl/ws9lxUOqL/cmpTISyiSxOu8F6dhFzoBDGxVrLvtpR5lI2U+iz+PO1Kd
         1n/YiMiGlKxKFNUMt3J+E+eaZFJwWTRjCKICEo0gu8IhuVAcpH2vGKvpnB1T3smTfOTL
         T82sqUP2CK/mC/oNwCr0BaM+snCeuVSOm87wp0Bu4ovZb7B0tAhhRCeDqLvE7Z3WBWRU
         xZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5EDy+50o4mSxYJD87pw0KYNW/6Dq6N/yrH1gcPWLVMA=;
        b=KBVmCvqAs46NzoeaUpajd7Q1YcDLZIJGXPhss7CoBY2OEpQUXh/TSmBg1yxFkKL0dx
         1MrPindSvTXd3giXGTclpq+gBLgEy9QF1/xcr0MvU6c2XcV/F6go2WUdYIXwkAnzkO4k
         z3x61NoIV46hHqVIl9XhSyA6G63mcyngWAd5M5rgPK8u+tUwpkKKVFJAGqzTJT2RPo7R
         XMNTndgV6C1rZmI4z4bZHhw2wtQkivjwinszrbraTltklHC1RWeAzUk3yJ1yvfi9mANw
         mT9K6cUzxmNOOQ413PIEAn10t8oBA5YaCOCgl+AU+3ds5Xpf0cMZpqZxHYx0uT4aGYLA
         ND/g==
X-Gm-Message-State: APjAAAXNZkBAJJA+Wwpvl2pyJL5bUEcBCqNIZDaEK8DhIXJmlT+BDVjy
        PO9qkdV5qci0L9gLpEcx2KdLdHX6
X-Google-Smtp-Source: APXvYqz5eTNwnggWlXyjTnxCZf2X3oQwQv4KMip51cAuEZ3WGHhwM3IfXGdkwc0p3xczjcU5fA7s+g==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr29201913wrt.249.1572988955219;
        Tue, 05 Nov 2019 13:22:35 -0800 (PST)
Received: from localhost.localdomain ([109.126.129.81])
        by smtp.gmail.com with ESMTPSA id 16sm1061197wmf.0.2019.11.05.13.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:22:34 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] io_uring: Merge io_submit_sqes and io_ring_submit
Date:   Wed,  6 Nov 2019 00:22:14 +0300
Message-Id: <09fcce1a50f4d1a399b903e3669ba98ede408d9c.1572988512.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572988512.git.asml.silence@gmail.com>
References: <cover.1572988512.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

io_submit_sqes() and io_ring_submit() are doing the same stuff with
a little difference. Deduplicate them.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 88 +++++++++++----------------------------------------
 1 file changed, 18 insertions(+), 70 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7813bc7d5b61..ebe2a4edd644 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2681,7 +2681,8 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 }
 
 static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
-			  struct mm_struct **mm)
+			  struct file *ring_file, int ring_fd,
+			  struct mm_struct **mm, bool async)
 {
 	struct io_submit_state state, *statep = NULL;
 	struct io_kiocb *link = NULL;
@@ -2732,10 +2733,12 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		}
 
 out:
+		s.ring_file = ring_file;
+		s.ring_fd = ring_fd;
 		s.has_user = *mm != NULL;
-		s.in_async = true;
-		s.needs_fixed_file = true;
-		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, true);
+		s.in_async = async;
+		s.needs_fixed_file = async;
+		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, async);
 		io_submit_sqe(ctx, &s, statep, &link);
 		submitted++;
 	}
@@ -2745,6 +2748,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	if (statep)
 		io_submit_state_end(&state);
 
+	 /* Commit SQ ring head once we've consumed and submitted all SQEs */
+	io_commit_sqring(ctx);
+
 	return submitted;
 }
 
@@ -2849,7 +2855,8 @@ static int io_sq_thread(void *data)
 		}
 
 		to_submit = min(to_submit, ctx->sq_entries);
-		inflight += io_submit_sqes(ctx, to_submit, &cur_mm);
+		inflight += io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm,
+					   true);
 
 		/* Commit SQ ring head once we've consumed all SQEs */
 		io_commit_sqring(ctx);
@@ -2866,69 +2873,6 @@ static int io_sq_thread(void *data)
 	return 0;
 }
 
-static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
-			  struct file *ring_file, int ring_fd)
-{
-	struct io_submit_state state, *statep = NULL;
-	struct io_kiocb *link = NULL;
-	struct io_kiocb *shadow_req = NULL;
-	bool prev_was_link = false;
-	int i, submit = 0;
-
-	if (to_submit > IO_PLUG_THRESHOLD) {
-		io_submit_state_start(&state, ctx, to_submit);
-		statep = &state;
-	}
-
-	for (i = 0; i < to_submit; i++) {
-		struct sqe_submit s;
-
-		if (!io_get_sqring(ctx, &s))
-			break;
-
-		/*
-		 * If previous wasn't linked and we have a linked command,
-		 * that's the end of the chain. Submit the previous link.
-		 */
-		if (!prev_was_link && link) {
-			io_queue_link_head(ctx, link, &link->submit, shadow_req);
-			link = NULL;
-			shadow_req = NULL;
-		}
-		prev_was_link = (s.sqe->flags & IOSQE_IO_LINK) != 0;
-
-		if (link && (s.sqe->flags & IOSQE_IO_DRAIN)) {
-			if (!shadow_req) {
-				shadow_req = io_get_req(ctx, NULL);
-				if (unlikely(!shadow_req))
-					goto out;
-				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
-				refcount_dec(&shadow_req->refs);
-			}
-			shadow_req->sequence = s.sequence;
-		}
-
-out:
-		s.ring_file = ring_file;
-		s.has_user = true;
-		s.in_async = false;
-		s.needs_fixed_file = false;
-		s.ring_fd = ring_fd;
-		submit++;
-		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, false);
-		io_submit_sqe(ctx, &s, statep, &link);
-	}
-
-	if (link)
-		io_queue_link_head(ctx, link, &link->submit, shadow_req);
-	if (statep)
-		io_submit_state_end(statep);
-
-	io_commit_sqring(ctx);
-
-	return submit;
-}
-
 struct io_wait_queue {
 	struct wait_queue_entry wq;
 	struct io_ring_ctx *ctx;
@@ -4049,10 +3993,14 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 			wake_up(&ctx->sqo_wait);
 		submitted = to_submit;
 	} else if (to_submit) {
-		to_submit = min(to_submit, ctx->sq_entries);
+		struct mm_struct *cur_mm;
 
+		to_submit = min(to_submit, ctx->sq_entries);
 		mutex_lock(&ctx->uring_lock);
-		submitted = io_ring_submit(ctx, to_submit, f.file, fd);
+		/* already have mm, so io_submit_sqes() won't try to grab it */
+		cur_mm = ctx->sqo_mm;
+		submitted = io_submit_sqes(ctx, to_submit, f.file, fd,
+					   &cur_mm, false);
 		mutex_unlock(&ctx->uring_lock);
 	}
 	if (flags & IORING_ENTER_GETEVENTS) {
-- 
2.23.0

