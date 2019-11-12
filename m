Return-Path: <SRS0=vuSH=ZE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC17C43331
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 06:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F689214E0
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 06:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tSW/u+ZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfKLGiD (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:38:03 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:41010 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfKLGiC (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 01:38:02 -0500
Received: by mail-pg1-f178.google.com with SMTP id h4so11162678pgv.8
        for <io-uring@vger.kernel.org>; Mon, 11 Nov 2019 22:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1bi1gz4+V9ryVWyTCW0YbJ+ho8iwIDKsT4JuBZW+qwc=;
        b=tSW/u+ZWl8sXyV/kLSaCdwJTeHFoxapuXppZ3YpOn0g2QPBn1HgebBCtM12x7XLdIr
         SdaeepcATg5Mkmk7f2QdIKVYvZh1z7Y78jymmgZ7zTq+ecBfdQIKRcmxwUnfv40qKp2T
         sLOgKZfb5KeLaUnYMPVA2KUFk4JXSt/6KWc4DxXXwdPOBox4EPFCHg5R2EYDRSTJE27Z
         ZR/2f1u3NLSBxVkmxpE8k/0C8Ew6gUDQPgtlTaF0WMVUJ3VgBfKrPgA++EXYmC/vqizg
         BEBEo5lUU1I8Uc0lCdNnsaHoyM79yBP8QsflOe+rTW6h5LxtH7XfAhrfzOHI1d8xlAD8
         Gkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1bi1gz4+V9ryVWyTCW0YbJ+ho8iwIDKsT4JuBZW+qwc=;
        b=QlMEUBocFjroAeF3X+mhQsVBc2KGwG1J+GieUer0sjC9VtG4Bles+7z4IkjKd00glw
         Ur6sYDrgeu+JB1PM7rINrQyraIdrAoYAQPt3FqvH7Jyy9QkLzu14egomrUrFnFtMGfBR
         69j5wRgwv37J3MLiegCWKQKyZ/dYk1nUiOdc4FMvIuq0cVjFVrp/T7x8SuKD1nwpbBnx
         bdMOv0kU+KdhFuqTV2TFb01MwHB7buMY5mdjtBqaOXFlXjrcA26+BO46V83asyONSe46
         Owy5V0fDp+acJE5svdCzskXP3/3/kvbFRxJ4UaePk0AF/4wACCPOoQcjALXGLeoU5dEI
         DxAw==
X-Gm-Message-State: APjAAAULE8onZeGgN4cUwjDQLRuEHrYsNN1X5Xx5asve8Z4PjusxLRaH
        SaZbydMVGpDX9N7u2CPl6q8ERgzVSyI=
X-Google-Smtp-Source: APXvYqww012nIK8yDRssgbFrqGc9ea2WZLirzMPr5zIvn3fkzNcjJKXot9UdSBKfmrVRDDb+n9gaUA==
X-Received: by 2002:a65:48c7:: with SMTP id o7mr11759570pgs.276.1573540680026;
        Mon, 11 Nov 2019 22:38:00 -0800 (PST)
Received: from [192.168.201.136] ([50.234.116.4])
        by smtp.gmail.com with ESMTPSA id b5sm18394653pfp.149.2019.11.11.22.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 22:37:59 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     carter.li@eoitek.com
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: make timeout sequence == 0 mean no sequence
Message-ID: <440e683b-8ddc-ebf8-7c52-10294b79a233@kernel.dk>
Date:   Mon, 11 Nov 2019 22:37:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Currently we make sequence == 0 be the same as sequence == 1, but that's
not super useful if the intent is really to have a timeout that's just
a pure timeout.

If the user passes in sqe->off == 0, then don't apply any sequence logic
to the request, let it purely be driven by the timeout specified.

Reported-by: 李通洲 <carter.li@eoitek.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Carter brings up a valid point that we should be able to support pure
timeouts, that don't factor in the sequence at all. Since timeouts were
introduced in this merge window, now's the time to make the correction.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f9a38998f2fc..87beca4377f7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -326,6 +326,7 @@ struct io_kiocb {
 #define REQ_F_TIMEOUT		1024	/* timeout request */
 #define REQ_F_ISREG		2048	/* regular file */
 #define REQ_F_MUST_PUNT		4096	/* must be punted even for NONBLOCK */
+#define REQ_F_TIMEOUT_NOSEQ	8192	/* no timeout sequence */
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -453,9 +454,13 @@ static struct io_kiocb *io_get_timeout_req(struct io_ring_ctx *ctx)
 	struct io_kiocb *req;
 
 	req = list_first_entry_or_null(&ctx->timeout_list, struct io_kiocb, list);
-	if (req && !__io_sequence_defer(ctx, req)) {
-		list_del_init(&req->list);
-		return req;
+	if (req) {
+		if (req->flags & REQ_F_TIMEOUT_NOSEQ)
+			return NULL;
+		if (!__io_sequence_defer(ctx, req)) {
+			list_del_init(&req->list);
+			return req;
+		}
 	}
 
 	return NULL;
@@ -1941,18 +1946,24 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (get_timespec64(&ts, u64_to_user_ptr(sqe->addr)))
 		return -EFAULT;
 
+	req->flags |= REQ_F_TIMEOUT;
+
 	/*
 	 * sqe->off holds how many events that need to occur for this
-	 * timeout event to be satisfied.
+	 * timeout event to be satisfied. If it isn't set, then this is
+	 * a pure timeout request, sequence isn't used.
 	 */
 	count = READ_ONCE(sqe->off);
-	if (!count)
-		count = 1;
+	if (!count) {
+		req->flags |= REQ_F_TIMEOUT_NOSEQ;
+		spin_lock_irq(&ctx->completion_lock);
+		entry = ctx->timeout_list.prev;
+		goto add;
+	}
 
 	req->sequence = ctx->cached_sq_head + count - 1;
 	/* reuse it to store the count */
 	req->submit.sequence = count;
-	req->flags |= REQ_F_TIMEOUT;
 
 	/*
 	 * Insertion sort, ensuring the first entry in the list is always
@@ -1964,6 +1975,9 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		unsigned nxt_sq_head;
 		long long tmp, tmp_nxt;
 
+		if (nxt->flags & REQ_F_TIMEOUT_NOSEQ)
+			continue;
+
 		/*
 		 * Since cached_sq_head + count - 1 can overflow, use type long
 		 * long to store it.
@@ -1990,6 +2004,7 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		nxt->sequence++;
 	}
 	req->sequence -= span;
+add:
 	list_add(&req->list, entry);
 	spin_unlock_irq(&ctx->completion_lock);
 
-- 
Jens Axboe

