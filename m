Return-Path: <SRS0=vuSH=ZE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0A8C43331
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 08:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8F72084F
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 08:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3+JmkuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKLISa (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:18:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52306 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfKLIS3 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 03:18:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id l1so2038730wme.2
        for <io-uring@vger.kernel.org>; Tue, 12 Nov 2019 00:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqIeOhqfdGvwsDMxpzzoDoP5vyCVNuou3X9fZkDKKOs=;
        b=L3+JmkuIqqF3aTTeGodPxZQHgeIZgZ/I4KJnSdnp+92U8PidsugzwdRruNANmVQkTf
         n4BEI3UpCC57JG0uvEO8CJyspndUvbsg4JB8gqwRIOMcuXV9A73vhj9hnyoemBVUT9l0
         kZnbU7qhf0/k6Pf+UVyGUXmW3PSJ1FWlFNUhrZTzMlfGf6G1Z1qVthzuOoyBqlQZzdfK
         VOTS/9ygP9kEFUtvIXRbfFvHVZhmsjW+pRJpEeusD6m9newBWc/Kos6QvO+Bi6Mw2M4m
         pTEosCPUdN6C8meCHT05s6bjb6W9DlCibkKfGP0QLH8gufysELhLXahYM73cLXQH5P0g
         4bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqIeOhqfdGvwsDMxpzzoDoP5vyCVNuou3X9fZkDKKOs=;
        b=pFcBM/sk8CXgR963/nkIPGKAXTP92Nsgdarv3eZ4uGjKNCna79NAMQpiroXn+3UWNS
         wqB4AXvz6tFmv60pPYCT8g8nmWZO3hetpboCbd7go1QlwIPbpbdhslqDOYPFOMT0Qsnd
         Qv4ddLMv09s9RwVX54OpyRN5+bHjizuy/XHtyMw/kzv/IsrsFM8SZSu6jGGl0249J1RN
         /s/ixcxSWc3NVuM2u0OiwAXQITvlAGMRf+enhaqM6DJr7wPFVzt2TkebRh43u8rHxAwK
         1Dn2f0ylIuaVYpGT8MpnfW+zR4IgpHoEbZ2w6bxzVfXiaSnQ912Tr735EB3yz/VKPA9Q
         0X6A==
X-Gm-Message-State: APjAAAUs7NXB15UYmXB5zTK4OU34KUVp8O302fazMZ/48fYfhqpzWWIV
        PHhe2vEiFOA1r2Zuk1sCikONya4W
X-Google-Smtp-Source: APXvYqyX0DmQYWQ9qVYXUJeqRuSYnIQgMuh+bI2Le4dGEtjkWjAmt9gLN2Ael6w5C77pJ5a2BvrIdA==
X-Received: by 2002:a1c:39c1:: with SMTP id g184mr2680403wma.75.1573546706549;
        Tue, 12 Nov 2019 00:18:26 -0800 (PST)
Received: from localhost.localdomain ([109.126.145.212])
        by smtp.gmail.com with ESMTPSA id t24sm43909652wra.55.2019.11.12.00.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 00:18:25 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH] io_uring: Fix leaking double_put()
Date:   Tue, 12 Nov 2019 11:17:33 +0300
Message-Id: <44a6c4ded7492f9a4d06d09fd9ff94e609b1ecad.1573546632.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

io_double_put_req() may be called for a request with a link (see
io_req_defer(req)), and so can leak it in case of an error, as
__io_free_req() doesn't handle links.

Fixes: 78e19bbef38362ceb ("io_uring: pass in io_kiocb to fill/add CQ
handlers")

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 18711d45b994..82f139ebdbbc 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -376,7 +376,6 @@ static void io_wq_submit_work(struct io_wq_work **workptr);
 static void io_cqring_fill_event(struct io_kiocb *req, long res);
 static void __io_free_req(struct io_kiocb *req);
 static void io_put_req(struct io_kiocb *req);
-static void io_double_put_req(struct io_kiocb *req);
 
 static struct kmem_cache *req_cachep;
 
@@ -930,7 +929,8 @@ static void io_fail_links(struct io_kiocb *req)
 			io_link_cancel_timeout(link);
 		} else {
 			io_cqring_fill_event(link, -ECANCELED);
-			io_double_put_req(link);
+			if (refcount_sub_and_test(2, &req->refs))
+				__io_free_req(req);
 		}
 	}
 
@@ -1007,7 +1007,7 @@ static void io_double_put_req(struct io_kiocb *req)
 {
 	/* drop both submit and complete references */
 	if (refcount_sub_and_test(2, &req->refs))
-		__io_free_req(req);
+		io_free_req(req);
 }
 
 static unsigned io_cqring_events(struct io_ring_ctx *ctx, bool noflush)
@@ -2830,6 +2830,8 @@ static int io_queue_sqe(struct io_kiocb *req)
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
 			io_cqring_add_event(req, ret);
+			if (req->flags & REQ_F_LINK)
+				req->flags |= REQ_F_FAIL_LINK;
 			io_double_put_req(req);
 		}
 		return 0;
@@ -2857,6 +2859,8 @@ static int io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
 			io_cqring_add_event(req, ret);
+			if (req->flags & REQ_F_LINK)
+				req->flags |= REQ_F_FAIL_LINK;
 			io_double_put_req(req);
 			__io_free_req(shadow);
 			return 0;
@@ -2903,6 +2907,8 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 	if (unlikely(ret)) {
 err_req:
 		io_cqring_add_event(req, ret);
+		if (req->flags & REQ_F_LINK)
+			req->flags |= REQ_F_FAIL_LINK;
 		io_double_put_req(req);
 		return;
 	}
-- 
2.24.0

