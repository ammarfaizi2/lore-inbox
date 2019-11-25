Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93778C432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 20:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D81B20659
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 20:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upJUfIn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfKYUPK (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:15:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36680 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfKYUPK (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 15:15:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id n188so744028wme.1
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 12:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J0/KKRyDPphO6YN/WpPwUVwO86DmnPIZPHu0ZXryBec=;
        b=upJUfIn9F6b4H1DHXpYGF2kPmRsxJqUvE58jhRk/V4xstf7Aw9/1Ca9p+pERR5Dtb2
         TDMs+N7Oq92+AnwHNXpmQ9p7GofjrKodZ6hw7CdnXx+N413/YLWlgcRZ8QcVMeqsdu4y
         /b5j0Ii99q/D97MsDAr+tRJXHTDjlzM2puAe9GQyCdfE/mTDjGGFtSreg1SJcZ/NO5gC
         sIReAqAUqmzOVnPZgPGjoF/5i5nd7kgoCelFElcWIQfOenokWgQCbOFnaQ75raKV+xb7
         TM7M5T3sTiVZoh8XojY7u/hn2gYBhz/bHYpx8PEldZ/oaPZC/5anFhSzlSN/OnBrS1O3
         cfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0/KKRyDPphO6YN/WpPwUVwO86DmnPIZPHu0ZXryBec=;
        b=Nn3L2/sKYVk2EeWjc/km75rKDmHmfbFyCsMpm7gBtinkJbpAiPB3b+61uGEFLkfSxX
         wn1FtHKkfnizkRfKMWgNNtOqUQulwFrlIzkKocX/eO1wmbMmuGSKzLXHqggihFxv2jvb
         x7VD/RIn3IHRJXci4yrB777JCkKsWmq5bkZs+QrmyWjcZ6Nq49GiJaAYu/cD59eobTnO
         MhQDF8Lp8iznXVxa9oFZBY/Rqblya2owdxTMz5/SkGbRsBYuGAjr5Zqai9NsUziqSyZD
         YXA/JV57WMI3UifYATgKQ6TzInvzNnx3I4Zy8dhKdUcRbGnSsDeE+4qMWV+e9EYHyMLA
         NEmQ==
X-Gm-Message-State: APjAAAVEmMzEuMs1dLV72VxqCpbanyKgxECb37zkFEe90U5NVN7a3bs/
        2t676h2CzyTDsh9VlHfjKDQ=
X-Google-Smtp-Source: APXvYqwo0ZZ7dO97FXih5s7Bnx91zQgeg04YJB+emK+oktD+ZKq1gF9INPZoSPA8m3xynM31r4hi7Q==
X-Received: by 2002:a1c:7507:: with SMTP id o7mr523121wmc.163.1574712907791;
        Mon, 25 Nov 2019 12:15:07 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id x7sm11584407wrq.41.2019.11.25.12.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 12:15:07 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 1/3] io_uring: store timeout's sqe->off in proper place
Date:   Mon, 25 Nov 2019 23:14:38 +0300
Message-Id: <8c6025c9e118f68bd8d09e347f274c07807cae89.1574712375.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574712375.git.asml.silence@gmail.com>
References: <cover.1574712375.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Timeouts' sequence offset (i.e. sqe->off) is stored in
req->submit.sequence under a false name. Keep it in timeout.data
instead. The unused space for sequence will be reclaimed in the
following patches.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e5bff60f61d6..0ce894fd4940 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -307,6 +307,7 @@ struct io_timeout_data {
 	struct hrtimer			timer;
 	struct timespec64		ts;
 	enum hrtimer_mode		mode;
+	u32				seq_offset;
 };
 
 struct io_timeout {
@@ -2472,8 +2473,7 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	}
 
 	req->sequence = ctx->cached_sq_head + count - 1;
-	/* reuse it to store the count */
-	req->submit.sequence = count;
+	req->timeout.data->seq_offset = count;
 
 	/*
 	 * Insertion sort, ensuring the first entry in the list is always
@@ -2484,6 +2484,7 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		struct io_kiocb *nxt = list_entry(entry, struct io_kiocb, list);
 		unsigned nxt_sq_head;
 		long long tmp, tmp_nxt;
+		u32 nxt_offset = nxt->timeout.data->seq_offset;
 
 		if (nxt->flags & REQ_F_TIMEOUT_NOSEQ)
 			continue;
@@ -2493,8 +2494,8 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		 * long to store it.
 		 */
 		tmp = (long long)ctx->cached_sq_head + count - 1;
-		nxt_sq_head = nxt->sequence - nxt->submit.sequence + 1;
-		tmp_nxt = (long long)nxt_sq_head + nxt->submit.sequence - 1;
+		nxt_sq_head = nxt->sequence - nxt_offset + 1;
+		tmp_nxt = (long long)nxt_sq_head + nxt_offset - 1;
 
 		/*
 		 * cached_sq_head may overflow, and it will never overflow twice
-- 
2.24.0

