Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAF7C5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304792173E
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdwS0vWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfKFWBF (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:01:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45984 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfKFWBE (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 17:01:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id h3so358243wrx.12;
        Wed, 06 Nov 2019 14:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cjBwOeb8uc0MDJbK7bfIy9wsXovx5I/DEExGIwddhw0=;
        b=NdwS0vWKjCCVqCrvrHJ0NErzmoIQ6gfSUWyhGCWwSZ59H5nyORRnrHw8lO2aymdFwZ
         rFH+adVXaJydrXYlP16hJSfNqioKykjwlrpa+iM4QoE1t+YwOajr8RP7ojjVp+nEgjYO
         NyX/eZNXAEf7KIJyslPtib4aNDkDEc1xhwZ6MPBlnhDaVX+V42lHNxt3Wbj/Ydau2nI3
         kTDL8ScMA8/ZT2AUuYFRHLONfuAXDJpZpBLwW0yR3EmRhryTvbfTTKOxhZ9xtgxpDBfc
         bdcS5aFXouHcdrsKkja2bK0IbPee+dt2foBmqBzCiS0HYzWqpjEyp6rlGw3iKXMcj6dB
         NUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjBwOeb8uc0MDJbK7bfIy9wsXovx5I/DEExGIwddhw0=;
        b=SetJIgICKuMFa+ViTi0OSMJlMqN8ibHu1TauPgLgIRrfCnBKOV1aCfw65NMS95+gNh
         c2AoDGN2i2s1XdazyKhYyI4Y8nK4ij5txfqLWc+UHDCAdJuyyls+o1/zq0RBuUHCajzy
         wmVErb9CCH8m6x6dF/1zze5/EiO35gm0KLUQcI4du3Vx+M540x5g2qzpzCl9Z5xJuY6K
         ySj/5H/qZfpio6aFNWmRflBLujHCiovecrgKgLP+5KK8/RvhEkZpK9CYf0WGaU2DwRy4
         5/tUbgGG912UNSVCL+UqsrQXhu4Y11thkxp91FkeB9NKKA+sSwbeWZZMG2PJJDG3dBdK
         AlQw==
X-Gm-Message-State: APjAAAU5u3uWP4HGOz2TalQdAIjzTyHGqi+4syyN4OWG0iDShCqnOfq2
        lKWWulWM8nf4+g2FkUH5hrw=
X-Google-Smtp-Source: APXvYqx2Zhw/zgEk4M+BDdHsG5T/mcQoTo26kYlctLBWpKDvfGvZlD1k0+2LwWTBP6ON+ZLjTCZGUw==
X-Received: by 2002:a5d:660b:: with SMTP id n11mr4943196wru.146.1573077661887;
        Wed, 06 Nov 2019 14:01:01 -0800 (PST)
Received: from localhost.localdomain ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id c24sm62159wrb.27.2019.11.06.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 14:01:01 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v2 2/3] io_uring: Use submit info inlined into req
Date:   Thu,  7 Nov 2019 01:00:31 +0300
Message-Id: <d0d4750b8433cb34e660c4007770d624c855bb94.1573077364.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1573077364.git.asml.silence@gmail.com>
References: <cover.1573077364.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Stack allocated struct sqe_submit is passed down to the submission path
along with a request (a.k.a. struct io_kiocb), and will be copied into
req->submit for async requests.

As space for it is already allocated, fill req->submit in the first
place instead of using on-stack one. As a result:

1. sqe->submit is the only place for sqe_submit and is always valid,
so we don't need to track which one to use.
2. don't need to copy in case of async
3. allows to simplify the code by not carrying it as an argument all
the way down
4. allows to reduce number of function arguments / potentially improve
spilling

The downside is that stack is most probably be cached, that's not true
for just allocated memory for a request. Another concern is cache
pollution. Though, a request would be touched and fetched along with
req->submit at some point anyway, so shouldn't be a problem.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0289bb3cc697..f863304e451a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2456,7 +2456,6 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
 		if (sqe_copy) {
 			s->sqe = sqe_copy;
-			memcpy(&req->submit, s, sizeof(*s));
 			if (req->work.flags & IO_WQ_WORK_NEEDS_FILES) {
 				ret = io_grab_files(ctx, req);
 				if (ret) {
@@ -2591,13 +2590,11 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		}
 
 		s->sqe = sqe_copy;
-		memcpy(&req->submit, s, sizeof(*s));
 		trace_io_uring_link(ctx, req, prev);
 		list_add_tail(&req->list, &prev->link_list);
 	} else if (s->sqe->flags & IOSQE_IO_LINK) {
 		req->flags |= REQ_F_LINK;
 
-		memcpy(&req->submit, s, sizeof(*s));
 		INIT_LIST_HEAD(&req->link_list);
 		*link = req;
 	} else {
@@ -2702,18 +2699,18 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	}
 
 	for (i = 0; i < nr; i++) {
-		struct sqe_submit s;
 		struct io_kiocb *req;
+		unsigned int sqe_flags;
 
 		req = io_get_req(ctx, statep);
 		if (unlikely(!req))
 			break;
-		if (!io_get_sqring(ctx, &s)) {
+		if (!io_get_sqring(ctx, &req->submit)) {
 			__io_free_req(req);
 			break;
 		}
 
-		if (io_sqe_needs_user(s.sqe) && !*mm) {
+		if (io_sqe_needs_user(req->submit.sqe) && !*mm) {
 			mm_fault = mm_fault || !mmget_not_zero(ctx->sqo_mm);
 			if (!mm_fault) {
 				use_mm(ctx->sqo_mm);
@@ -2721,7 +2718,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 			}
 		}
 
-		if (link && (s.sqe->flags & IOSQE_IO_DRAIN)) {
+		sqe_flags = req->submit.sqe->flags;
+
+		if (link && (sqe_flags & IOSQE_IO_DRAIN)) {
 			if (!shadow_req) {
 				shadow_req = io_get_req(ctx, NULL);
 				if (unlikely(!shadow_req))
@@ -2729,24 +2728,25 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
 				refcount_dec(&shadow_req->refs);
 			}
-			shadow_req->sequence = s.sequence;
+			shadow_req->sequence = req->submit.sequence;
 		}
 
 out:
-		s.ring_file = ring_file;
-		s.ring_fd = ring_fd;
-		s.has_user = *mm != NULL;
-		s.in_async = async;
-		s.needs_fixed_file = async;
-		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, async);
-		io_submit_sqe(ctx, req, &s, statep, &link);
+		req->submit.ring_file = ring_file;
+		req->submit.ring_fd = ring_fd;
+		req->submit.has_user = *mm != NULL;
+		req->submit.in_async = async;
+		req->submit.needs_fixed_file = async;
+		trace_io_uring_submit_sqe(ctx, req->submit.sqe->user_data,
+					  true, async);
+		io_submit_sqe(ctx, req, &req->submit, statep, &link);
 		submitted++;
 
 		/*
 		 * If previous wasn't linked and we have a linked command,
 		 * that's the end of the chain. Submit the previous link.
 		 */
-		if (!(s.sqe->flags & IOSQE_IO_LINK) && link) {
+		if (!(sqe_flags & IOSQE_IO_LINK) && link) {
 			io_queue_link_head(ctx, link, &link->submit, shadow_req);
 			link = NULL;
 			shadow_req = NULL;
-- 
2.23.0

