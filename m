Return-Path: <SRS0=o5Q3=Z7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCBFC43603
	for <io-uring@archiver.kernel.org>; Mon,  9 Dec 2019 23:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4C92068E
	for <io-uring@archiver.kernel.org>; Mon,  9 Dec 2019 23:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TZc6TdEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfLIXTE (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:19:04 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:46085 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLIXTE (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 9 Dec 2019 18:19:04 -0500
Received: by mail-pj1-f65.google.com with SMTP id z21so6527448pjq.13
        for <io-uring@vger.kernel.org>; Mon, 09 Dec 2019 15:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=628yIkRZLleJn7MIymKYJ02rnEgHC0yYd9QiSE8lUlE=;
        b=TZc6TdEI6bLW/ShVh36TLIDk5ytRwH8qNnYtRI5yylBN8qljJDkxGFi3kg7t5fmXHk
         xrCdNmKJ7O4F7g7Gwb+XoXllmiNMEXI2J6ngfytMzkgKdaLavKwY12+YFGXuCoi6U1+R
         3f1pP4xJIY1sMo4SnwtrPR5sXSKNXU4H2d/lkSHutrxMgTln1eaCQbXFUEhZf6C+DBxi
         7AH5JhF2xc+J1X9R97zeRKd+oJQtkZZP0IWpb/T5TUzPh2FhdbyTWVDF8qmRyH8fOE20
         LLlK9k6udk+yOk1UCBMBNg0uaa9eMFI9idoRIPE84qyB1UtAQOglaA7O+7uuWvLtntxU
         84aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=628yIkRZLleJn7MIymKYJ02rnEgHC0yYd9QiSE8lUlE=;
        b=ukg9vWKvpaRhpGnpm5K0+Bm/9/8q0ZLu3PttGk7eNG4YSd3rFWe2cXtTs8wgaTNeSV
         EnI8T6RMqD+85cOIJwTtVbrnWT9nMcyAK4RtDCQrZZ75IL45zaaTUqG4d18rElR6n3xn
         qxJdRiMiJF0aCsGEvyQgC6/GMxU01U/Wj8U45JqVnjgEymD7sP/cdKxzOzRL8Hu2wAJi
         QthrfqoMP0n9xt1ox/xcHacB/zHa1qZNImPa2InFxvIJbUTsTMqrC/Lbc6hdUuIMFERL
         5+u5aTmJEpsHeOyKqhIGjMnk1e1NB+wWGFsCKdRk84OVFzIHHLEBG37InoOvQr14f6VC
         Tfsg==
X-Gm-Message-State: APjAAAWTTDWyoNkNR+UK9kaP9o/7o4jkmunStnR1x9u84+IPQxXNCgJ5
        JznFvryVW9raXo8ZMHYUoiyuT+qrx3E=
X-Google-Smtp-Source: APXvYqy0tEwt6rOjtRoeiBLFEB9x6COmLh/5hIhQNMGa+K3eXaZGehSWUXSj9YvfrjtyR0DDkNMpXA==
X-Received: by 2002:a17:902:27:: with SMTP id 36mr7106379pla.270.1575933543253;
        Mon, 09 Dec 2019 15:19:03 -0800 (PST)
Received: from x1.thefacebook.com ([2620:10d:c090:180::e5cf])
        by smtp.gmail.com with ESMTPSA id 16sm515662pfh.182.2019.12.09.15.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 15:19:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] io_uring: sqthread should grab ctx->uring_lock for submissions
Date:   Mon,  9 Dec 2019 16:18:54 -0700
Message-Id: <20191209231854.3767-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209231854.3767-1-axboe@kernel.dk>
References: <20191209231854.3767-1-axboe@kernel.dk>
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
index 662404854571..33e15e925609 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2997,12 +2997,7 @@ static int io_issue_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
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
@@ -3657,7 +3652,9 @@ static int io_sq_thread(void *data)
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

