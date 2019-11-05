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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5B7C5DF60
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63053206BA
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXDxu4sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfKEXFd (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:05:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46932 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbfKEXFd (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 18:05:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so17715408wrs.13;
        Tue, 05 Nov 2019 15:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tjXRi0nTPEcOLYK+DCsYCdl0V0t7lT7GLBF5vMkKjy8=;
        b=GXDxu4sDa8vOTm9elfLLl5qq/l5aR5L+NVnikbDcUMw0Q1Fs3TWXzgpJztlLIYx0vZ
         Mssw+WdMm6K6d1386dKtoxK66A/5ekj7qN/JE7RykZtxdAHdMtzpAThLdEoxYm6Qw34Q
         15YxqxeXDFnkUvgKVItd0JznsiKd6m00JfBnRScsNwtpXKyD3WaCMVCTq5Ai8wTy+NcX
         j1QU83wxX1prKy8jofNjFuEdXchXRXL7GYyKDs8m2aTSmcu9ZFrSKJxqODrjJKhmTzRh
         Nm/ch69vDGfSrHt2mpy8PJtGi2zQXTdfhLP53QETfybn4nya4IgqxJwRhbohic43GmSj
         lCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tjXRi0nTPEcOLYK+DCsYCdl0V0t7lT7GLBF5vMkKjy8=;
        b=Lyc/vp77ZOHSJU+vORx+lo7mds17RZFH8+uzshwZ7ukOd3CJ6Us+QeLzE7whklxaGh
         7I5WXuVxWr/IM+jB4ELoOrznEsERMpr8ZyAdVWMZGvGMzbuwBObO8zNePL+Jga4iptUx
         GezS28ro9oU2nKc7EErtPMcLmB3QBUPWU3wl6dH+waOx3oR+S8tAJ0GbdX/RY7Tk98M+
         DQpS7ekblxIuR6/ZNBfNMGSBIK8bdOm2bILs4t70PJ+QqZApRi//efYqTrkrprp5r0s5
         24prEdy2ya5rRntSCLTWUh16TzgKzu10b4H2laj0R1nbTr4VnGYNyKr3Kj9qqbWL1AOi
         0epA==
X-Gm-Message-State: APjAAAVJ73ysYx7jc2To2/FcFYzTT24HODqsA5qOvt5aggkwF3p9ojKy
        wHtmNGYOxkXl1j3MV6Oe3tbapWdV
X-Google-Smtp-Source: APXvYqx/NAx0pRtC/UP/f8z9JQRGuxCZKef6/nYxdRI1Mq8My+S7eIkENUA3cgsIOGRlUkNZpcGI+g==
X-Received: by 2002:a5d:62cf:: with SMTP id o15mr12884246wrv.7.1572995129843;
        Tue, 05 Nov 2019 15:05:29 -0800 (PST)
Received: from localhost.localdomain ([109.126.129.81])
        by smtp.gmail.com with ESMTPSA id x8sm15579658wrm.7.2019.11.05.15.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 15:05:29 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 2/3] io_uring: Use submit info inlined into req
Date:   Wed,  6 Nov 2019 02:04:44 +0300
Message-Id: <32cc59cefc848ba2e258fc4581684f1c2e67d649.1572993994.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572993994.git.asml.silence@gmail.com>
References: <cover.1572993994.git.asml.silence@gmail.com>
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
 fs/io_uring.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 920ad731db01..ecb5a4336389 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2443,7 +2443,6 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
 		if (sqe_copy) {
 			s->sqe = sqe_copy;
-			memcpy(&req->submit, s, sizeof(*s));
 			if (req->work.flags & IO_WQ_WORK_NEEDS_FILES) {
 				ret = io_grab_files(ctx, req);
 				if (ret) {
@@ -2578,13 +2577,11 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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
@@ -2689,18 +2686,17 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	}
 
 	for (i = 0; i < nr; i++) {
-		struct sqe_submit s;
 		struct io_kiocb *req;
 
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
@@ -2708,7 +2704,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 			}
 		}
 
-		if (link && (s.sqe->flags & IOSQE_IO_DRAIN)) {
+		if (link && (req->submit.sqe->flags & IOSQE_IO_DRAIN)) {
 			if (!shadow_req) {
 				shadow_req = io_get_req(ctx, NULL);
 				if (unlikely(!shadow_req))
@@ -2716,24 +2712,25 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
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
+		if (!(req->submit.sqe->flags & IOSQE_IO_LINK) && link) {
 			io_queue_link_head(ctx, link, &link->submit, shadow_req);
 			link = NULL;
 			shadow_req = NULL;
-- 
2.23.0

