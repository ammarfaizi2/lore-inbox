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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F88C4338F
	for <io-uring@archiver.kernel.org>; Mon,  9 Aug 2021 19:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3B460FDA
	for <io-uring@archiver.kernel.org>; Mon,  9 Aug 2021 19:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhHITTO (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 9 Aug 2021 15:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbhHITTN (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 9 Aug 2021 15:19:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87B2C0613D3
        for <io-uring@vger.kernel.org>; Mon,  9 Aug 2021 12:18:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n11so11310317wmd.2
        for <io-uring@vger.kernel.org>; Mon, 09 Aug 2021 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MRleOxZuG2g1jOjmPsnV0zVqdp15hh1SUYQpQKjLsFM=;
        b=trALDX+jQd5STZbsoIUYykyPxEUJ2HjRZyCOCdX0MMRoIN2kMWyBVyyfc7gkAiakRC
         NONFtblikq2Ckz8RlXdchRYWwE2wAna+WklpdtXeHQ0vPPP9NPZoGkIjGnMFknJIYeEO
         TGtGHq625D7gN2/arGybqoA4Ze3vLXRJGNRh7g3+GumWn/7Gxk3m8SQAv0SOl3Wdruku
         /TnOQNgWur4vPJFqbitLMSITqXXVXWSB3oe1iFrn0yEhKfc/Zgeqm6CHGwOkAcSeDgse
         iqx91m/kePk9w+9gZ7mnQsqBmnQlwmR8qhoWCQUpnXtXBwW7hze2lSqcxoWcCV5zOlRZ
         7nhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MRleOxZuG2g1jOjmPsnV0zVqdp15hh1SUYQpQKjLsFM=;
        b=D9qiY9ZU/t86Zx2v025m6IQcclodyPwn/s5KdK6fjFkbW47JJ3puWV1c+hgRjxkCIp
         wXIkO2uCJlY8avuGyZggj4rkGT9o/XOJ+tma8Mq47ulTKkHncs8a3cSChGPhvTXFOfEd
         UECNr/coEII5zNPmRKsn2AqZKFW5K+Nvn/OlBxVRRI/SNQ4nBjWCYnGL3Qnj3RGlFVQc
         DO3p0SO2LybIiBbRoi7k5W/gk++//iQT8Ye7i7St7DckLOxu7HPOCek9vNQa90Owp31w
         xmw8RBLhjGVoHSQKXh/e7zYzPfp7r/GJkcucYehRkvmVXaCmeZm7dKj9rUFoHLMaAal7
         tB+g==
X-Gm-Message-State: AOAM533LPEGcS32TEYHVi/koy0pwGAuxsltMkK4Dj3SItNFRo85KcFO9
        OlGgHkF6DQc5xN3fCWaoopY=
X-Google-Smtp-Source: ABdhPJx8bJgwYU3/HgZytgfekPFFoWkgFsgqHauRz2QrxqrjfQmiaHl0uaSzg6kmXdkoMjBFvTF3eA==
X-Received: by 2002:a7b:ca4e:: with SMTP id m14mr627155wml.17.1628536730505;
        Mon, 09 Aug 2021 12:18:50 -0700 (PDT)
Received: from localhost.localdomain ([85.255.236.119])
        by smtp.gmail.com with ESMTPSA id h11sm13283074wrq.64.2021.08.09.12.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 12:18:50 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 2/7] io_uring: cache __io_free_req()'d requests
Date:   Mon,  9 Aug 2021 20:18:08 +0100
Message-Id: <9f4950fbe7771c8d41799366d0a3a08ac3040236.1628536684.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628536684.git.asml.silence@gmail.com>
References: <cover.1628536684.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Don't kfree requests in __io_free_req() but put them back into the
internal request cache. That makes allocations more sustainable and will
be used for refcounting optimisations.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 889e11892227..9aa692625f42 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1826,11 +1826,16 @@ static void io_dismantle_req(struct io_kiocb *req)
 static void __io_free_req(struct io_kiocb *req)
 {
 	struct io_ring_ctx *ctx = req->ctx;
+	unsigned long flags;
 
 	io_dismantle_req(req);
 	io_put_task(req->task, 1);
 
-	kmem_cache_free(req_cachep, req);
+	spin_lock_irqsave(&ctx->completion_lock, flags);
+	list_add(&req->compl.list, &ctx->locked_free_list);
+	ctx->locked_free_nr++;
+	spin_unlock_irqrestore(&ctx->completion_lock, flags);
+
 	percpu_ref_put(&ctx->refs);
 }
 
-- 
2.32.0

