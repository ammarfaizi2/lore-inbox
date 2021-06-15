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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A5CC48BDF
	for <io-uring@archiver.kernel.org>; Tue, 15 Jun 2021 15:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437F06157F
	for <io-uring@archiver.kernel.org>; Tue, 15 Jun 2021 15:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFOPJy (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 15 Jun 2021 11:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhFOPJx (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 15 Jun 2021 11:09:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7A2C061574
        for <io-uring@vger.kernel.org>; Tue, 15 Jun 2021 08:07:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v9so2446580wrx.6
        for <io-uring@vger.kernel.org>; Tue, 15 Jun 2021 08:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fPAUfDhxjB0DAgN5H6VHbDI2swLdx4FyhGp0U0Zy45s=;
        b=aA8vtCvzJ33NMhgfIV1dXUiQ2m3+HJdi9RKXtT0zK03AFBY/z8dBqAkQNMpHuGv9uu
         rPG468WJ4egpVXsFKXmRiGGbxPJUq8rM4/p6TfkPFDCQ4yvnsxPZj3f3fIgeHgDq3l2E
         sXci1v3NOmrkEO63DSvBGQCMivuaP3cRQhUzXxCYZNc9mP8ZaVPb/MtlwpB+oclcjQmK
         PgovAz5Gw6BeUUmg1L/m5FJ9mYgE8t+a3zrQWclnWx2OK+S/szHu6g+Va7tFh5yHN4mv
         gSxbhaDlU54AAXvvbJTSsv5N2eebEaO4OUzx9cM+2GYrLpwcdo7lKFTJ3XeGwjRuoBwA
         Bp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fPAUfDhxjB0DAgN5H6VHbDI2swLdx4FyhGp0U0Zy45s=;
        b=IEPctE2pq/eFpbK4wMKDqn+F2V3wAn1Jok6giwOKMfK808eXKXS3zpN27VvLh7e3il
         o88FlgPTtwA1xdkVmnHwtFFi2tYACEPlk61668qDblvN2p2Y1V7oaoEyfBcPBzFHwSIP
         l/+3kEOM3iOLpGW1kPUWv8dbXtUYd36v57XBCWNxFK36QAy1Uh+IabpAQqEV6omMe05E
         STOnaHIRQbkVx+dZa6c1Wx4NzyhYycHX5uWDrSkIz01Cv1FdIGLchemTcienftkDdpKn
         feHaG6l81pYMtk7n1W10snIut4GUe9eQRXoj6xX/3TEgep641yxRtnTpjhfiNSCAvKKQ
         P2Yg==
X-Gm-Message-State: AOAM532YONrA220zISeGITFDX5Zu0g1EQpeg7GX2T70TPbT1YDpe0UsH
        vCZGXhVXYCRZiMdniIBzgmE=
X-Google-Smtp-Source: ABdhPJxpni9Eaq+n9/1pT9CsPP1K/VBE9iXGCxPGx4w8eWWWiFFt1DxNJ3XVaZyJlA852R9s+ADtbA==
X-Received: by 2002:a5d:6c6d:: with SMTP id r13mr25531580wrz.350.1623769666959;
        Tue, 15 Jun 2021 08:07:46 -0700 (PDT)
Received: from localhost.localdomain ([148.252.132.209])
        by smtp.gmail.com with ESMTPSA id m23sm2936563wml.27.2021.06.15.08.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:07:46 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH liburing 1/1] queue: clean up SQ flushing
Date:   Tue, 15 Jun 2021 16:07:28 +0100
Message-Id: <7c725dda9dba669235737ee5fd0b37909b6d25a5.1623769611.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Clean up and deduplicate parts of __io_uring_flush_sq(), also helping to
generate a better binary if a compiler is not smart enough.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 src/queue.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/src/queue.c b/src/queue.c
index ce5d237..2f0f19b 100644
--- a/src/queue.c
+++ b/src/queue.c
@@ -198,23 +198,20 @@ int __io_uring_flush_sq(struct io_uring *ring)
 {
 	struct io_uring_sq *sq = &ring->sq;
 	const unsigned mask = *sq->kring_mask;
-	unsigned ktail, to_submit;
+	unsigned ktail = *sq->ktail;
+	unsigned to_submit = sq->sqe_tail - sq->sqe_head;
 
-	if (sq->sqe_head == sq->sqe_tail) {
-		ktail = *sq->ktail;
+	if (!to_submit)
 		goto out;
-	}
 
 	/*
 	 * Fill in sqes that we have queued up, adding them to the kernel ring
 	 */
-	ktail = *sq->ktail;
-	to_submit = sq->sqe_tail - sq->sqe_head;
-	while (to_submit--) {
+	do {
 		sq->array[ktail & mask] = sq->sqe_head & mask;
 		ktail++;
 		sq->sqe_head++;
-	}
+	} while (--to_submit);
 
 	/*
 	 * Ensure that the kernel sees the SQE updates before it sees the tail
-- 
2.31.1

