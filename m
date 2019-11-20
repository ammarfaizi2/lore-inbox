Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3619C432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 23:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12BE20878
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 23:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UHCVE8gU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfKTXHo (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 18:07:44 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40282 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKTXHo (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 18:07:44 -0500
Received: by mail-io1-f67.google.com with SMTP id p6so1163388iod.7
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 15:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cBVhyrjLvfNS834Z7ZlpbuwxvSo8bxpPDoaaMYu2GYQ=;
        b=UHCVE8gUmU3SlFvTvqMuBT05jY0SvJzoEQDBy33ukj/e9N88GF14r9OKmTxjFtl53a
         I4/Yhmd8bA22D72iCx1P55Bwt4MbifoSL0SMavMUUV808A58w3ujfxJ2oaikslbKal1w
         qxy601s04BH8T8Ywm2w4a2qbz9/qgz2TxArIlJvivs0ioxOhbGKp9WD6mZQ2bEpMcbnG
         ABPwI0+pvr6FBBrtbArn7qzBHez7xId51Y2nM70Mo4j/MkgBiY6T4TK3rJpRBA6Z7HJj
         r76juhJyX/oXaBIOiWaVniSjNn612sBczo4wIXmdkELwZXn8aAh2JgE9At/H/IMWDZXa
         GD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cBVhyrjLvfNS834Z7ZlpbuwxvSo8bxpPDoaaMYu2GYQ=;
        b=ItTmcrmx755bDo0F5KyJzI2dKxbPGAc3JB4BPISBYfAuj3LuYubNufyslIOoLU0mgM
         eWbnMSiLgHGUvo4EJZ/Ss2BJyv8bpgf6l0VrbQhvjOVUvxGY0gkNsJEy7w84hbNvNEUU
         NU6r142bcCLVhfg4FgqynorcQCBSTBTfjMyOlszPD1ZNgngaPujKOvz3j7eXYPOlWXZo
         iN1RL8vy4b8JyDYbkw7K7wpEne0sVeq6CzkEx912aAHHm5y10Xi4/DajbwVIAOVomN2f
         PK36ews+E8wC9syMWJH/g9AYRW5aALz5YN9pk+GVQxgGPmPp/3bKXiplnxmPEjAauEGj
         6++w==
X-Gm-Message-State: APjAAAVnfGwhbigpKlppFvpqwNGpAfDm3WT9ZTRKFShg7ktMLzoC2i2U
        TXlPlooS8/6oRwrng2dE6MQL4M9xGypYIQ==
X-Google-Smtp-Source: APXvYqzPEllp2MekqI63IsIjnZWwjQNDoIawWr3d6qBEz28zJrCQlKgk1DI2X3V/LI+jqE631tqeew==
X-Received: by 2002:a6b:c809:: with SMTP id y9mr4935605iof.232.1574291263423;
        Wed, 20 Nov 2019 15:07:43 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s90sm214799ill.40.2019.11.20.15.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 15:07:42 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     Jackie Liu <liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: fix race with shadow drain deferrals
Message-ID: <27c153ee-cfc8-3251-a874-df85a033429a@kernel.dk>
Date:   Wed, 20 Nov 2019 16:07:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

When we go and queue requests with drain, we check if we need to defer
based on sequence. This is done safely under the lock, but then we drop
the lock before actually inserting the shadow. If the original request
is found on the deferred list by another completion in the mean time,
it could have been started AND completed by the time we insert the
shadow, which will stall the queue.

After re-grabbing the completion lock, check if the original request is
still in the deferred list. If it isn't, then we know that someone else
already found and issued it. If that happened, then our job is done, we
can simply free the shadow.

Cc: Jackie Liu <liuyun01@kylinos.cn>
Fixes: 4fe2c963154c ("io_uring: add support for link with drain")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6175e2e195c0..6fb25ae53817 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2973,6 +2973,7 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 	int ret;
 	int need_submit = false;
 	struct io_ring_ctx *ctx = req->ctx;
+	struct io_kiocb *tmp;
 
 	if (unlikely(req->flags & REQ_F_FAIL_LINK)) {
 		ret = -ECANCELED;
@@ -3011,8 +3012,30 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 
 	/* Insert shadow req to defer_list, blocking next IOs */
 	spin_lock_irq(&ctx->completion_lock);
-	trace_io_uring_defer(ctx, shadow, true);
-	list_add_tail(&shadow->list, &ctx->defer_list);
+	if (ret) {
+		/*
+		 * We dropped the lock since deciding we needed to defer this
+		 * request. We must re-check under the lock, if it's now gone
+		 * from the list, that means that another completion came in
+		 * and submitted it since we decided we needed to defer. If
+		 * that's the case, simply drop the shadow, there's nothing
+		 * more we need to do here.
+		 */
+		list_for_each_entry(tmp, &ctx->defer_list, list) {
+			if (tmp == req)
+				break;
+		}
+		if (tmp != req) {
+			__io_free_req(shadow);
+			shadow = NULL;
+		}
+	}
+	if (shadow) {
+		trace_io_uring_defer(ctx, shadow, true);
+		list_add_tail(&shadow->list, &ctx->defer_list);
+	} else {
+		need_submit = false;
+	}
 	spin_unlock_irq(&ctx->completion_lock);
 
 	if (need_submit)

-- 
Jens Axboe

