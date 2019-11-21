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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E706EC432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFEC20643
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIqkv+jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKUUVj (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:21:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38577 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKUUVj (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 15:21:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so5213011wmk.3
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 12:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yEsMyHpJpbwoO40GEaLtjeT34ViM6cUuCKsgKLbaIs4=;
        b=tIqkv+joungjulairbulhO7JUTIwL2ITbDAzsAaLRuC2SRqmfzXeAh11hJXk7Mm31p
         bxTHoSvcyYtvDKpvzNhIA7Ho+IqsfaAgWsQd+6Tf7G8/jw7MtXsKjM+H54WYBkjmdmgC
         kSwws6yOW7bGWNxP+S+77qFHs2ECDAh6XH9DfgTj/0b/xBwWlmtk7XZrfPMNWsWhx2zY
         +xE/bb5hkny6lvr/9CN1eip2TWvTJFK3lYgbNOI9tM0UOW2Pa7+ETFHEOv4/SeiRUNlf
         hkz6jA6Hva5MnS+xaHhtPQ2oQaKL7c9q8Kst4g0iV0WVoR4kygvalsRw3zj/9SgJD49x
         OdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yEsMyHpJpbwoO40GEaLtjeT34ViM6cUuCKsgKLbaIs4=;
        b=AHT0i95+C0CuYVKkj8I4wMYKyt6BbCiSJQjqBKDEaxfVZDVQzl6rJoTnSHbiKyl6sJ
         POprW/IsY8OGBaBflvQh+97/+Gt/DrJtIp2OWHdBEYmuIyXmoQV65tEK4Ynyz5Avb+MA
         nwr9hT83fZQqu57wauSOmEI4FP8/9kUms+zXhnmzTf/ldfPBswZYHPmAFrZY0LDqbutQ
         G+kIU7jTlgKIxaQELKHtBcopt4LmjbXXqFr18+vrvJu16S9X4HsSh4cbrsoZIQ1Q2ZdG
         y1cljdGtMAobcWlH+Vt8J9HypPjsVVrKfgeMZQIv1LdTssQgm5wlqg5N3HCq/ghE89KM
         5ohQ==
X-Gm-Message-State: APjAAAVSBG5SCnRKskJx5I96aNfXi1RfVrG+XsG0ApYgv76objfqjlfX
        2DyyLAStuX8YNQz6pxTRZWw=
X-Google-Smtp-Source: APXvYqzW8GixN3H7TpG5DtQFHY4AzC+mZZjWiDjK2NQ3RazQJ+xruDB5G03PHSkID9PdBgUY1LJ3CA==
X-Received: by 2002:a7b:c8d0:: with SMTP id f16mr7945901wml.168.1574367697280;
        Thu, 21 Nov 2019 12:21:37 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id w4sm4646112wrs.1.2019.11.21.12.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:21:36 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 2/4] io_uring: pass only !null to io_req_find_next()
Date:   Thu, 21 Nov 2019 23:21:01 +0300
Message-Id: <a483916f68d74ff4a27c7b3719fbe6a83612a4f0.1574366549.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574366549.git.asml.silence@gmail.com>
References: <cover.1574366549.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Make io_req_find_next() and io_req_link_next() to accept only non-null
nxt, and handle it in callers.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 07b48ce3ccab..63ef603d5fa0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -903,7 +903,7 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 		 * in this context instead of having to queue up new async work.
 		 */
 		if (nxt) {
-			if (nxtptr && io_wq_current_is_worker())
+			if (io_wq_current_is_worker())
 				*nxtptr = nxt;
 			else
 				io_queue_async_work(nxt);
@@ -981,8 +981,13 @@ static void io_req_find_next(struct io_kiocb *req, struct io_kiocb **nxt)
 
 static void io_free_req(struct io_kiocb *req)
 {
-	io_req_find_next(req, NULL);
+	struct io_kiocb *nxt = NULL;
+
+	io_req_find_next(req, &nxt);
 	__io_free_req(req);
+
+	if (nxt)
+		io_queue_async_work(nxt);
 }
 
 /*
-- 
2.24.0

