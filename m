Return-Path: <SRS0=l6sb=2A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2780C43603
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C5F2053B
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QT5GNSVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLJP5x (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:57:53 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37791 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLJP5x (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Dec 2019 10:57:53 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so19315703ioc.4
        for <io-uring@vger.kernel.org>; Tue, 10 Dec 2019 07:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTZLv5ZA315Z4UgW1ZxBcW3K56nAU0F7erW42h4DOB4=;
        b=QT5GNSVbl8sFBvzzKfJzJPZJ4FMwsEbwKdgU8I817a9xmUPtPzorCCI8sHeO540051
         Ta6yuGu5r1o2gdt8fQpyRIm8TFggrNQiac6ZXyhT6GA2wGnWD60La7Sx+T7yM5QBeVNV
         zZnzd5HXvOM17ishRfNBysIx3zAcP3f29b2BBb3AqImmzzSXffz9lHCEl6J6jKPrvKFT
         SaGhoaubizSL0J4pbRAh9xMA2+z1lc7R6RF1sXHNZUCWYSYoy8IQHyo7f4AG/vcABqZL
         KykuBxs40kwUi+MK+lk5hU8AuqLYscniyqAEJXY50BB5N1fcqsZzlU8jhuCgG6FTLnwp
         NvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTZLv5ZA315Z4UgW1ZxBcW3K56nAU0F7erW42h4DOB4=;
        b=QKMvmFyPraEfSufLwsO9OdYePcyaOIIIQr1ceIvYj/ttENNm6TWNQlJbGIEDjEiBEI
         7s1Qcn3ZJS7FSWJ5tvGTL4vfsNBeBegTTuDexr9aQzvvyLvlD2gDzC0BRczWLEfkW6Jk
         nUbLN2PtQ+/QFkdx5Rw/pf12Zm8mKkhHKPxamURnPb7+lgCoQHDtLLpRIEsEQRHhO4SK
         dStncohurVYUwvU1t6ARahBUqfATiuzMFz6U2NeMTLe5VHqN8yLsCaE+e56LMi/Gf427
         D/wTvTtb4ecunazzqYDxFm+nvmwWjXafWSgZ8fV0cgVs04/3/we8A9Ck6Wgs+xAPGRpF
         Zkxg==
X-Gm-Message-State: APjAAAVtPp4Y/U0P+Zbu39aJrpGEmzdVLZeJZuZDCurhBUIJfZ3rqUj5
        lR6ABFHGeQaLpRVxTw0wHqLbGREhZpK5mA==
X-Google-Smtp-Source: APXvYqznwDqsj/sKMmndckk4ta1QJqlD3IaS0coqigKQeg9jn56Xjab73mDCeE6zWpFq2gWszCg+Bg==
X-Received: by 2002:a5d:80d9:: with SMTP id h25mr11578149ior.97.1575993471664;
        Tue, 10 Dec 2019 07:57:51 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w6sm770953ioa.16.2019.12.10.07.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:57:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/11] io_uring: sqthread should grab ctx->uring_lock for submissions
Date:   Tue, 10 Dec 2019 08:57:35 -0700
Message-Id: <20191210155742.5844-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210155742.5844-1-axboe@kernel.dk>
References: <20191210155742.5844-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We use the mutex to guard against registered file updates, for instance.
Ensure we're safe in accessing that state against concurrent updates.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4cda61fe67da..1e1e80d48145 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3002,12 +3002,7 @@ static int io_issue_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
 		if (req->result == -EAGAIN)
 			return -EAGAIN;
 
-		/* workqueue context doesn't hold uring_lock, grab it now */
-		if (req->in_async)
-			mutex_lock(&ctx->uring_lock);
 		io_iopoll_req_issued(req);
-		if (req->in_async)
-			mutex_unlock(&ctx->uring_lock);
 	}
 
 	return 0;
@@ -3661,7 +3656,9 @@ static int io_sq_thread(void *data)
 		}
 
 		to_submit = min(to_submit, ctx->sq_entries);
+		mutex_lock(&ctx->uring_lock);
 		ret = io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm, true);
+		mutex_unlock(&ctx->uring_lock);
 		if (ret > 0)
 			inflight += ret;
 	}
-- 
2.24.0

