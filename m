Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A3EC432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 16:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF4220715
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 16:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P3PLCRvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbfKTQ2Z (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:28:25 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37069 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbfKTQ2Z (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 11:28:25 -0500
Received: by mail-io1-f66.google.com with SMTP id 1so28310104iou.4
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 08:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9CdKL+7bmWYLkA6nTpQYIf300RqKGDgWTQHsjyx754k=;
        b=P3PLCRvj+9jNZr6oSoqhgmx3Td8cesIp97ty028AgWp36xAYJ3cszo/dBp/DgEvoif
         T7nkMw3WOUnRYhm3cJ1PyQvLb6ARJ+0Nbw+JTdZxh9voeyn3XaaTxSjh6nQlD0ReYZ6D
         vcLDSWIBCW3dPrbWEVfQJEzEXrviCSqpMuTDWfj+VSPPZujyc5NyyGCldJtAg93faMGS
         Q23K1VJXbbHcLPPxHiIFJdFod40CbPhLwHRJkOJlzd6NvdclBogVN70NOO+b2qXZiaX2
         NyJo3gqiDGB3IZsIazO81J7QHoD0h7ASkyLVFxBDw3tE0rmeEUqN8EY3itQbf6OEe/Hq
         q2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9CdKL+7bmWYLkA6nTpQYIf300RqKGDgWTQHsjyx754k=;
        b=UayK8tuSrsc2wtSDZ9oe/mxz20btwSqQQVe43LB1gXNmh4KdiXiXM7BoGylA+3G66N
         fLOiJlCCKV46Qmd6fA2U1ek+yMyWPIsYURBW2qcrszMCxsOeHQE58tQdj97JKq9OnNmJ
         yo1QBeJ45PxLCDBpntah0E65srs8o1l0sUTYtOIoqLpheUiKezTdsBF223sNRmsiT5nC
         Jfs83G2Qc9ekrSg0ihN01tPm6lmQzbKsIq+Kho8FqCc59Vo9OYs9mnDkzjNZzQjzpjGs
         FLHhAAJ0+6UjvOxrbTarQAYkdmUc3huMa87MEQ9VxJFOEsaywBLAM7ANB3ZKltjzFNOb
         sapQ==
X-Gm-Message-State: APjAAAVMfQzhJJWtIh9nyM6sf1v6C0Wx+BFxwreTB6id7LqCjUQsCgrk
        XfzxVVrybJaGyXGXf5eA3qQsgYWq6jlEig==
X-Google-Smtp-Source: APXvYqw/0IVHtFpv+GRLyHmN3vgW6RgBVgHf9WDystI//fnkrOhtCb2uS2V5wBfRx2pGRZBb8y7doA==
X-Received: by 2002:a6b:6002:: with SMTP id r2mr2761888iog.148.1574267303377;
        Wed, 20 Nov 2019 08:28:23 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b3sm5141748ioh.72.2019.11.20.08.28.22
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 08:28:22 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: io_allocate_scq_urings() should return a sane state
Message-ID: <714885ab-3e2b-5de0-274a-3a71e737d65a@kernel.dk>
Date:   Wed, 20 Nov 2019 09:28:21 -0700
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

We currently rely on the ring destroy on cleaning things up in case of
failure, but io_allocate_scq_urings() can leave things half initialized
if only parts of it fails.

Be nice and return with either everything setup in success, or return an
error with things nicely cleaned up.

Reported-by: syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 100931b40301..066b59ffb54e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4568,12 +4568,18 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	ctx->cq_entries = rings->cq_ring_entries;
 
 	size = array_size(sizeof(struct io_uring_sqe), p->sq_entries);
-	if (size == SIZE_MAX)
+	if (size == SIZE_MAX) {
+		io_mem_free(ctx->rings);
+		ctx->rings = NULL;
 		return -EOVERFLOW;
+	}
 
 	ctx->sq_sqes = io_mem_alloc(size);
-	if (!ctx->sq_sqes)
+	if (!ctx->sq_sqes) {
+		io_mem_free(ctx->rings);
+		ctx->rings = NULL;
 		return -ENOMEM;
+	}
 
 	return 0;
 }

-- 
Jens Axboe

