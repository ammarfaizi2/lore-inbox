Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B162C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B7D20643
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSuFjCxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKUUVm (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:21:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34205 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKUUVm (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 15:21:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so6070348wrr.1
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 12:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EQznzcYIgdzgLVfD6AlwKeGZzxgr0SuHZlvsdj1efBw=;
        b=vSuFjCxoCmYRbBNW7W/7auUNr3MUBQikV2jqDPUMfds4+OtC2qVfxRMA7Hvjf/vW13
         N6PA2HZsdr5J7L9sIzB+cn9kZmBP/nuwmcA0v7PPxRRn6p3gW+wr/QRwMl3G8T+Zmt9w
         zXZ8C+1eL9tnBe8zC9RfUYGZtz1whT5AmPiwU06dIxH4xtsSEu6A2sc8cWIWIcGfytJj
         lcuAnMneJz52cR+Qkvz9sEuEIH++ymlB9cFOK4Tz+UJ9gyUYDx34ll+ILbN8fpqyiYOU
         AGqvPGrcO1h8DnoeAZDKtnVn7wWEO+FXeYJ8cTswBmh6isy+ZrB2ovyBRT+HU/gp3tyN
         5LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQznzcYIgdzgLVfD6AlwKeGZzxgr0SuHZlvsdj1efBw=;
        b=dU7Lduh+zJJ+fFPgLfAFZg7W/o/URDup7C+BScrPNLzwCplHY73qz472gVo9U1zMfq
         4Zxi1aK1+70FAH1ybbfbiT3w8gQP/2GQl8/J2kpbdZQZGZ/qI6vawiGTOh7OIRJNfcVS
         7Bb0FTp7SuCRlcJomnEwpr//+73kDa1yJY+PD4UEz/reVp0PScNz61Se4jrOO/Zm2MH4
         XOqHk2I1snrwxcBJZGohqFeg4mNUD+8C/R+WGLbxbobLjMyw4HM/q4JIL/CiFAs7sBEx
         nT2GegCAaZUzTJZmpH1W9gK3fQsp+KHYKxG42A1uP0UTpOh8bZ6akaPobwkJCsQ/z5z8
         Frag==
X-Gm-Message-State: APjAAAVb0GPKasPllAJ5dtK1na7z4nxCXx/8fkU8jGIjC0dp0TQn4QQX
        K00RA9nw5LNdI7G/JYrWY7E=
X-Google-Smtp-Source: APXvYqw6CiZMbfHH/OEMYsMZsjfqvTF/oCHNZVSh8aDARiQ+ImUciNKfD0D4/cxS56n9fVlC/EBlYA==
X-Received: by 2002:a5d:6508:: with SMTP id x8mr13948291wru.0.1574367700654;
        Thu, 21 Nov 2019 12:21:40 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id w4sm4646112wrs.1.2019.11.21.12.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:21:40 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 4/4] io_uring: only !null ptr to io_issue_sqe()
Date:   Thu, 21 Nov 2019 23:21:03 +0300
Message-Id: <d33b2d46990d7912e8848bc7bf389ffea5d56042.1574366549.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574366549.git.asml.silence@gmail.com>
References: <cover.1574366549.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Pass only non-null @nxt to io_issue_sqe() and handle it at the caller's
side. And propagate it.

- kiocb_done() is only called from io_read() and io_write(), which are
only called from io_issue_sqe(), so it's @nxt != NULL

- io_put_req_find_next() is called either with explicitly non-null local
nxt, or from one of the functions in io_issue_sqe() switch (or their
callees).

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1ab045e5d663..3e8efe8f064d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -985,21 +985,13 @@ static void io_free_req(struct io_kiocb *req)
  * Drop reference to request, return next in chain (if there is one) if this
  * was the last reference to this request.
  */
+__attribute__((nonnull))
 static void io_put_req_find_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 {
-	struct io_kiocb *nxt = NULL;
-
-	io_req_find_next(req, &nxt);
+	io_req_find_next(req, nxtptr);
 
 	if (refcount_dec_and_test(&req->refs))
 		__io_free_req(req);
-
-	if (nxt) {
-		if (nxtptr)
-			*nxtptr = nxt;
-		else
-			io_queue_async_work(nxt);
-	}
 }
 
 static void io_put_req(struct io_kiocb *req)
@@ -1482,7 +1474,7 @@ static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
 static void kiocb_done(struct kiocb *kiocb, ssize_t ret, struct io_kiocb **nxt,
 		       bool in_async)
 {
-	if (in_async && ret >= 0 && nxt && kiocb->ki_complete == io_complete_rw)
+	if (in_async && ret >= 0 && kiocb->ki_complete == io_complete_rw)
 		*nxt = __io_complete_rw(kiocb, ret);
 	else
 		io_rw_done(kiocb, ret);
@@ -2570,6 +2562,7 @@ static int io_req_defer(struct io_kiocb *req)
 	return -EIOCBQUEUED;
 }
 
+__attribute__((nonnull))
 static int io_issue_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
 			bool force_nonblock)
 {
@@ -2884,10 +2877,13 @@ static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req)
 
 static void __io_queue_sqe(struct io_kiocb *req)
 {
-	struct io_kiocb *nxt = io_prep_linked_timeout(req);
+	struct io_kiocb *linked_timeout = io_prep_linked_timeout(req);
+	struct io_kiocb *nxt = NULL;
 	int ret;
 
-	ret = io_issue_sqe(req, NULL, true);
+	ret = io_issue_sqe(req, &nxt, true);
+	if (nxt)
+		io_queue_async_work(nxt);
 
 	/*
 	 * We async punt it if the file wasn't marked NOWAIT, or if the file
@@ -2923,11 +2919,11 @@ static void __io_queue_sqe(struct io_kiocb *req)
 	/* drop submission reference */
 	io_put_req(req);
 
-	if (nxt) {
+	if (linked_timeout) {
 		if (!ret)
-			io_queue_linked_timeout(nxt);
+			io_queue_linked_timeout(linked_timeout);
 		else
-			io_put_req(nxt);
+			io_put_req(linked_timeout);
 	}
 
 	/* and drop final reference, if we failed */
-- 
2.24.0

