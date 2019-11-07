Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAA2C5DF61
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 18:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE114218AE
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 18:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zN9sdaHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfKGS32 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:29:28 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45990 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKGS32 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 13:29:28 -0500
Received: by mail-il1-f196.google.com with SMTP id o18so2695074ils.12
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fnApKBH47QIWo6OKAZ33mYWPD6FrkPgDTdpsV9Rrqxc=;
        b=zN9sdaHspwa+N+RzPkh3Qw2MEKS/SdmKz3S+H1OSRfU43Wfk3Yt6XmRngykipFzQIK
         t973EG2Vk+SSwlMD4C+eT1YUfPd3ZUXAoqkqP88ZY0zAYdgBdyL7tmb1R0MoUj/W3gW9
         1oTmKaaOUadsDACawQb9zaa4zUL1Rx9tfcoy9ADyNy2047aZ70XeMNOK1gaOp/7Sw7lh
         qLOQUv/xlDzQZbrwILzZTaRTX8PdqDVtafzpmpf+qrjWgWSrgrbc2dhnLc8Jm5x4n5p+
         4Qran5g243kO9fOTaux2HCnLb/ZGCAeukcYY1gKfH7iaiHJ7AY3lAYBzsb65+nC8XI4S
         e7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fnApKBH47QIWo6OKAZ33mYWPD6FrkPgDTdpsV9Rrqxc=;
        b=oCmB0bWYJ+OKFoSfUQ85Zoh6bWElrxZr04AEqTL/hafNM0yCk2fAutICzxHUy1haac
         bD0u/WefREwYweDvLeKqJbM6957bawb8krEzaL6IopW+fFTdX1ZTDRboecwx0n8FQRcs
         gF0fYIUvdogwejSA9JwBzKLrY9WS41OgTaRF4MmRV8C2vKkUTsmP7cmIH0UH3wLaMZJR
         pzuDVKHuFB/TnYbjnWvC+SXj3AWk6nnVe0LO18g4pufX9cMYqmPtXO6ZQdDv/NsfNdN2
         n2eUgDPJcfATAibReUY2pYfV5jGRo0qaqxkE+EubSkOUzcPmxKbpFC0LdSuHNmQ2Znoq
         tj1w==
X-Gm-Message-State: APjAAAU7AssfJrbSaGJyEztwJLBLgmYDIT26MuS2g13/fb77GB0Y4dMi
        GIzz3IGtN1VGanFRJH7MxpFHQ15yW7U=
X-Google-Smtp-Source: APXvYqyTJWavrcheLQUOqw5Zva98FWpIYPs6nkQN8jF1ELugw9yngqopAuYwjVtoGke/ZTwbUIlnzg==
X-Received: by 2002:a92:405a:: with SMTP id n87mr6518614ila.16.1573151367057;
        Thu, 07 Nov 2019 10:29:27 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p6sm243727iog.55.2019.11.07.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:29:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] io-wq: io_wqe_run_queue() doesn't need to use list_empty_careful()
Date:   Thu,  7 Nov 2019 11:29:18 -0700
Message-Id: <20191107182920.21196-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107182920.21196-1-axboe@kernel.dk>
References: <20191107182920.21196-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We hold the wqe lock at this point (which is also annotated), so there's
no need to use the careful variant of list_empty().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index ba40a7ee31c3..9b375009a553 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -338,8 +338,7 @@ static void io_worker_handle_work(struct io_worker *worker)
 static inline bool io_wqe_run_queue(struct io_wqe *wqe)
 	__must_hold(wqe->lock)
 {
-	if (!list_empty_careful(&wqe->work_list) &&
-	    !(wqe->flags & IO_WQE_FLAG_STALLED))
+	if (!list_empty(&wqe->work_list) && !(wqe->flags & IO_WQE_FLAG_STALLED))
 		return true;
 	return false;
 }
-- 
2.24.0

