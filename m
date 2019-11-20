Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF04DC43215
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4822075E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OMkir3o5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfKTUJx (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:09:53 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:37676 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKTUJx (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 15:09:53 -0500
Received: by mail-il1-f194.google.com with SMTP id s5so873324iln.4
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 12:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xw+nr8IoUPO7BUZAplZBKLjjSduKoITOhRe8sSruUyA=;
        b=OMkir3o5JIXhBU7r5EWmPndGej58XkehmDKgBEfCl4I8qIGG58pcujlFChod7QUsbw
         p+8h+JEsZyJUTa/gHQD7Kf+58UQgSjKN8mFz/WqDRJoDoZiUi0hf0ri13K4EyEDIDxsy
         iBlZzIhPNWkGJWdwmuZmYc2Oa478+7AKuQFh6wm+rW8zi+3o6cTd+1DIAtBkgQqwN6I8
         YresPI78uLTNK5w2yS05/8uC/9+wjvv+aA8pYvDS+WrEaxGQ8J/lkOHbzjRq3FfoYxvX
         UQSF5C1pYZE/fG2rsc5bIzeRIJsBwe/54pliMyDWqvH8pQM17BuZzVeCsdiIRfCDl3fU
         IJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xw+nr8IoUPO7BUZAplZBKLjjSduKoITOhRe8sSruUyA=;
        b=OxLFuF9E8AntbF1kDSHykSobp/eHOtVOM59Uo7krt0oIw/4VALATyeYegwivKGWaa8
         EGXKA0/Ump/d7pd9c6wFtXbd7WlixVGXJNPy5oDSEht6Fmjh5xj5dhQ58XotOZlXex0O
         CUO78sc+RyWKfoy41BNagQJi4iDX8Df71h4UFX7gBbEbTqwyaDx+VS9ZIU4gI45ss5CD
         W932G971k0WM5dLsCrmiSGBY+cJGxW3hp1sfhcfKx6j7KrPlmqdbMZ3TNhQwNFOdlKQZ
         kVHGyOjJe7vPHt879GoOa3Qax3P4cBpLtBjeEfI0lMAQ6OPNizu3BZ4mFHQCDjwCdjs1
         FGRQ==
X-Gm-Message-State: APjAAAXTkgrsh99Eu+qTahj6Z10ZfjMXOCw/RDHtBFqnQe/RS77UIeEi
        TWKlsB0fT3yRFZKoVHWSEEcW0eWnwXKtMw==
X-Google-Smtp-Source: APXvYqw3LVWAKEFUYHRUm/n28mZZAdk55Flg2wkeDo6nQ1FLd3xoimRmVDcLoHENKxOLPhSsdCd0mg==
X-Received: by 2002:a92:690c:: with SMTP id e12mr5364309ilc.153.1574280591923;
        Wed, 20 Nov 2019 12:09:51 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e25sm48012iol.36.2019.11.20.12.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 12:09:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] io_uring: allow finding next link independent of req reference count
Date:   Wed, 20 Nov 2019 13:09:30 -0700
Message-Id: <20191120200936.22588-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120200936.22588-1-axboe@kernel.dk>
References: <20191120200936.22588-1-axboe@kernel.dk>
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

