Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC399C432C3
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908162080F
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="z6EmTITX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKTUMN (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:12:13 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33232 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfKTUMN (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 15:12:13 -0500
Received: by mail-il1-f193.google.com with SMTP id m5so905605ilq.0
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 12:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xw+nr8IoUPO7BUZAplZBKLjjSduKoITOhRe8sSruUyA=;
        b=z6EmTITXV4lT6NF0ahLLgiUKi6TUlKYJyJLqg/Fl+FZr7XOLg7oQTFtzN599RBpaqy
         t9hZ5ic/qrjdeO4ZiBEpDYZEXjOUkX+uEoWmcUnSAu3xd5wgapTEXc6GYiI0Ql5DIUcI
         3YJrCkEe8rjI9ZzdwNcMpc/KK/xHPmy/LA++VbFKqrSIEvHGlGixKGDd4x0vWuCg4waY
         9h66qdKLfNiA0mR3elQTSBrtsm0N+UlTcQhcC/RDHg6BiDwoa4JtW2nFeiDfboJmDk2O
         xHY6/38+Hfy7CDlCSrOiBCciDLqX2BVO1bIaYjMJ69de3MyAGZ1NVgSv8gxCJq1IzjaC
         Nwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xw+nr8IoUPO7BUZAplZBKLjjSduKoITOhRe8sSruUyA=;
        b=Q2AZxJq981KJLaNxQVai/ZO5ND1o7EbWMlFYFc8s8oxYlYrpfvt9BGXoE0uVnqXSDk
         hmoiFcpo6bgh0cDa3w0uEzQDOUjw6kmIf9RpPPupRv/PT2BHpgpue/TfJvEki9LC9ZZc
         8HV5QQHL3r8wFqjoTAisqWLshoKkyJVvZjrrNahK1+WjdafgKvFAUG0A9FUDFe2pY/Oa
         8dIJTO1FWR0Y5Kq7aqIG5VICvtkRWdP6a+04zrqyyz6KzizDBuV81/tul0w/2Tl3l+9y
         WNHKgo9amjpHRYKVUTrzDuLV58WUCMcByAfRg+RkwoBhm2zsL+kBrU/Ety/It8i6Sw7u
         QB7w==
X-Gm-Message-State: APjAAAUZKMfOF2nOdxju0QN7AbsRJMI/QBSLWNsgDInX/sHarCBTHIuE
        vuXUTOAx+9OkbLNRgdJ4x7WhEfwj5AFvuQ==
X-Google-Smtp-Source: APXvYqx88DIQ6ainlSGNT862HYwefiNd1S1MFTNEar6mKhzLMh9YFTbmq3RW4Fedc0eNuY+0TLBqDg==
X-Received: by 2002:a92:3b0c:: with SMTP id i12mr5219661ila.190.1574280731875;
        Wed, 20 Nov 2019 12:12:11 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w75sm53350ill.78.2019.11.20.12.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 12:12:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] io_uring: allow finding next link independent of req reference count
Date:   Wed, 20 Nov 2019 13:12:05 -0700
Message-Id: <20191120201206.22799-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120201206.22799-1-axboe@kernel.dk>
References: <20191120201206.22799-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We currently try and start the next link when we put the request, and
only if we were going to free it. This means that the optimization to
continue executing requests from the same context often fails, as we're
not putting the final reference.

Add REQ_F_LINK_NEXT to keep track of this, and allow io_uring to find the
next request more efficiently.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 066b59ffb54e..132a890368bf 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -340,6 +340,7 @@ struct io_kiocb {
 #define REQ_F_NOWAIT		1	/* must not punt to workers */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
+#define REQ_F_LINK_NEXT		8	/* already grabbed next link */
 #define REQ_F_IO_DRAIN		16	/* drain existing IO first */
 #define REQ_F_IO_DRAINED	32	/* drain done */
 #define REQ_F_LINK		64	/* linked sqes */
@@ -874,6 +875,10 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	struct io_kiocb *nxt;
 	bool wake_ev = false;
 
+	/* Already got next link */
+	if (req->flags & REQ_F_LINK_NEXT)
+		return;
+
 	/*
 	 * The list should never be empty when we are called here. But could
 	 * potentially happen if the chain is messed up, check to be on the
@@ -910,6 +915,7 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 		break;
 	}
 
+	req->flags |= REQ_F_LINK_NEXT;
 	if (wake_ev)
 		io_cqring_ev_posted(ctx);
 }
@@ -946,12 +952,10 @@ static void io_fail_links(struct io_kiocb *req)
 	io_cqring_ev_posted(ctx);
 }
 
-static void io_free_req_find_next(struct io_kiocb *req, struct io_kiocb **nxt)
+static void io_req_find_next(struct io_kiocb *req, struct io_kiocb **nxt)
 {
-	if (likely(!(req->flags & REQ_F_LINK))) {
-		__io_free_req(req);
+	if (likely(!(req->flags & REQ_F_LINK)))
 		return;
-	}
 
 	/*
 	 * If LINK is set, we have dependent requests in this chain. If we
@@ -977,7 +981,11 @@ static void io_free_req_find_next(struct io_kiocb *req, struct io_kiocb **nxt)
 	} else {
 		io_req_link_next(req, nxt);
 	}
+}
 
+static void io_free_req_find_next(struct io_kiocb *req, struct io_kiocb **nxt)
+{
+	io_req_find_next(req, nxt);
 	__io_free_req(req);
 }
 
@@ -994,8 +1002,10 @@ static void io_put_req_find_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 {
 	struct io_kiocb *nxt = NULL;
 
+	io_req_find_next(req, &nxt);
+
 	if (refcount_dec_and_test(&req->refs))
-		io_free_req_find_next(req, &nxt);
+		__io_free_req(req);
 
 	if (nxt) {
 		if (nxtptr)
-- 
2.24.0

