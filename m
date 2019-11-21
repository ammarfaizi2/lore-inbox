Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CE2C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 18:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FFD2067D
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 18:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBLDnk3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfKUSZF (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:25:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40709 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUSZF (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 13:25:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id 4so2333345wro.7
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 10:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KugMKVn8G/1wJJpNDlHZ7DiO8b6x9TOEgDPYZdUeDmw=;
        b=hBLDnk3KX4vjilRpbO/mbj3MKvIoLRwbOwxV40s3iSYXSZlSa/toWCnzvIfpdctIyU
         oZOlNQWuoKLaF43JeeGlHQ1qpbXPof/hK77glUosli2eydca6K5VxI6u0lfPi3VfNN5C
         SM3Z3rLW+xdZc6XKkTXy1zkXOOu9go5XCdRn84dD1wDyxtx69oxPhXa8GN6/OoYALqXG
         w6Qz6XFnpRSOUlAEexd5XLKjqW7zOBCX9bmqr5X2vnKG5+JT8kkx/37JNZZg1/M9RWv/
         L+zbXinFzJkZ6x+9CZ0hGIjxubC7xAkg78SESBFVI9zdRUq6YsBYia4O/yYIkJl9xf7S
         s7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KugMKVn8G/1wJJpNDlHZ7DiO8b6x9TOEgDPYZdUeDmw=;
        b=QtuNlitwsN/ie70zfvNvCFe+4u+Bn8uGiIOFhCAyr7syTrBkY+1vawEQpTwx96lB4W
         kuq22YoPAqW1OisDkR5F7OwsldD0IEwx7lCfg7TNrQsvc4oiqsL4qUeJasmS3YvTuAGC
         W96oCw1icnzcul5J9CZKzK3OcS3/3HLUMHs9DRMUxrgKxNtwXEoEf4iGmntQq0nv3H7m
         nJIMAri4EtLH6zSBqZeRXaiB5yns9D9ZXBa3Ur71ya1C3E9AdZW+diKtg6kItEvuzgB4
         aoZlCSnv/yOaS0jGwD64jpzsuml+2fe15dazTRo4mYGPlfYzhxYf6iQMTq3UxvcKx/yB
         TVcg==
X-Gm-Message-State: APjAAAXSnAeiP5beTV5f/Vz6qlmP+QKX0PrqIiWW4Mlvq7F76I6eao55
        n9R6TY96Z90RApqUtaLCxQm6dFop
X-Google-Smtp-Source: APXvYqzOa3B1r6IaxBtyBOGXJr/5jvWoQ/4JyTv5RstijiUeB0DsJekAJCrRqhC2JoyaGfUtxVmudQ==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr12335065wrr.88.1574360702231;
        Thu, 21 Nov 2019 10:25:02 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id y6sm4379294wrw.6.2019.11.21.10.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:25:01 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH] io_uring: rename __io_submit_sqe()
Date:   Thu, 21 Nov 2019 21:24:36 +0300
Message-Id: <228a5ae5d63c61dd4f7349594012bfc7691028a7.1574360634.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

__io_submit_sqe() is issuing requests, so call it as
such. Moreover, it ends by calling io_iopoll_req_issued().

Rename it and make terminology clearer.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index dd220f415c39..fa1cf7263959 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2579,8 +2579,8 @@ static int io_req_defer(struct io_kiocb *req)
 	return -EIOCBQUEUED;
 }
 
-static int __io_submit_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
-			   bool force_nonblock)
+static int io_issue_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
+			bool force_nonblock)
 {
 	int ret, opcode;
 	struct sqe_submit *s = &req->submit;
@@ -2685,7 +2685,7 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 		s->has_user = (work->flags & IO_WQ_WORK_HAS_MM) != 0;
 		s->in_async = true;
 		do {
-			ret = __io_submit_sqe(req, &nxt, false);
+			ret = io_issue_sqe(req, &nxt, false);
 			/*
 			 * We can get EAGAIN for polled IO even though we're
 			 * forcing a sync submission from here, since we can't
@@ -2896,7 +2896,7 @@ static void __io_queue_sqe(struct io_kiocb *req)
 	struct io_kiocb *nxt = io_prep_linked_timeout(req);
 	int ret;
 
-	ret = __io_submit_sqe(req, NULL, true);
+	ret = io_issue_sqe(req, NULL, true);
 
 	/*
 	 * We async punt it if the file wasn't marked NOWAIT, or if the file
-- 
2.24.0

