Return-Path: <SRS0=4IE2=DZ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08014C43457
	for <io-uring@archiver.kernel.org>; Sun, 18 Oct 2020 09:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01EB2137B
	for <io-uring@archiver.kernel.org>; Sun, 18 Oct 2020 09:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh71fCgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgJRJUs (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 18 Oct 2020 05:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgJRJUs (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 18 Oct 2020 05:20:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966C4C0613CE
        for <io-uring@vger.kernel.org>; Sun, 18 Oct 2020 02:20:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 13so7441147wmf.0
        for <io-uring@vger.kernel.org>; Sun, 18 Oct 2020 02:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UNJ3OGz4vF0DqwDRGrdTdH+VRYxcdSnqAG5IXs/NI+g=;
        b=Lh71fCgAftrf80M3Xu6bw2KhH0TSdS2thrGzbKgdOVANo1/oK/hGxFkCO9ItwLN+1G
         NhAdnAP5391Rv3LNsMuvS7s2JmHRamAK+6owi4pgmyqeTQRPry2XCnE3qpOlvZOlzC1B
         4N0+nnAgMt4zLiABk9Eg74+6S4fTRdPtIPQC76QIsXPT32jsKtxOESRVdLuEpXPQtEHL
         CvdOPnaWX7VoZA4lScBy+KeFc4QuHDWy936iAQL5Wil1ougeXsS74wd3ZQGQf+EcdCgB
         +r4V3tNkbUYwsaH3QYXkDIgkh/6rGL1gH3NeIZeRKAuBrT1pL9Ov2eUjVa0WemZqOQdw
         SnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UNJ3OGz4vF0DqwDRGrdTdH+VRYxcdSnqAG5IXs/NI+g=;
        b=HPXAuwJLiryYt/5CnbpRl9JED+k5jF16fVmrlYnkPFEv2SdkRibVN8vUxm4CkshiM4
         1pyKodzFWZqJwdJ/GMZ9jtCkRCo4UONDs9tWqE065eiwi9M4/IjGfIB/g9KU9gXEMOul
         6BsWPEKKkukJt1dTVKnpMJ4nDv1zstHXt85qQR7XYOkBLWA5uYa4uZLLUHPfuLqPkJ6Q
         9yUh2Z0IKF/RFqajcFOxUdv0KLhgsSnPE50Jt/ZLdGZbokDWeW7Z5sDFrArxCH83HX36
         ZI1yLgm2K7N8Cr8E2dL+uVYcBW7sPpCiEcsMSXYeF8czwQ7rqCXFQOfIhsy0EvIL8L6z
         pcOA==
X-Gm-Message-State: AOAM533yYaeLW9cC/qVwfepeoysWwo3whzxSgfFgWk+BbUU8pjK6xnT2
        X02IgOPI+4AJT+LJjXipXF8pIH1UKKN63g==
X-Google-Smtp-Source: ABdhPJzatcOJH21VKwkkXNfn1mmuDORDVbfnUvFU68xpxQXIJIWsTWyV2a3h6RCB18FU+6DF0bnfug==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr12125383wma.48.1603012846386;
        Sun, 18 Oct 2020 02:20:46 -0700 (PDT)
Received: from localhost.localdomain (host109-152-100-164.range109-152.btcentralplus.com. [109.152.100.164])
        by smtp.gmail.com with ESMTPSA id w11sm12782984wrs.26.2020.10.18.02.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 02:20:45 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 3/7] io_uring: inline io_fail_links()
Date:   Sun, 18 Oct 2020 10:17:39 +0100
Message-Id: <3dc7ff2a6d38e41b30e2be90c32bdc9c27a981d2.1603011899.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1603011899.git.asml.silence@gmail.com>
References: <cover.1603011899.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Inline io_fail_links() and kill extra io_cqring_ev_posted().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 048db9d3002c..43c92a3088d8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1913,10 +1913,12 @@ static struct io_kiocb *io_req_link_next(struct io_kiocb *req)
 /*
  * Called if REQ_F_LINK_HEAD is set, and we fail the head request
  */
-static void __io_fail_links(struct io_kiocb *req)
+static void io_fail_links(struct io_kiocb *req)
 {
 	struct io_ring_ctx *ctx = req->ctx;
+	unsigned long flags;
 
+	spin_lock_irqsave(&ctx->completion_lock, flags);
 	while (!list_empty(&req->link_list)) {
 		struct io_kiocb *link = list_first_entry(&req->link_list,
 						struct io_kiocb, link_list);
@@ -1938,15 +1940,6 @@ static void __io_fail_links(struct io_kiocb *req)
 	}
 
 	io_commit_cqring(ctx);
-}
-
-static void io_fail_links(struct io_kiocb *req)
-{
-	struct io_ring_ctx *ctx = req->ctx;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ctx->completion_lock, flags);
-	__io_fail_links(req);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 	io_cqring_ev_posted(ctx);
-- 
2.24.0

