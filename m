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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECA9C43215
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 20:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EE420659
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 20:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heSslJV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfKYUPN (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:15:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34856 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfKYUPM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 15:15:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id n5so748727wmc.0
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 12:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KgFNowuZMqGUBEF8deu+eqSvBHeEjv17nELCi+Lnm68=;
        b=heSslJV4EHzt88LEbPzE8t1oF6XS97soHynHG6e8HvVcvVgCNA6N974fJt1WKbUhOM
         3tZo7MSs1qvezFPEA8bYgIPWFzvyBHUs9uT4VqcEmxIn80RW/iVt+btDd5k9jQXYdfrz
         5ppC1PHOHVJj1WoRzDPa4FQmCA9wPiqQYoUCYYUMPtlAEG8PpvW91qjZmeg3WtRkfhNY
         OYEKpcujR3H1HnmFj/99DwUq9lUFh6I96SvtU/4o2hSGxk5XM48KFD98hPRnQNCqxRvI
         zzi+80oBhH+6vvw8QRv1LW7qK5dQolgGNRsroZpQ9Z0qINp4XDo2g0n8gkCAKlRCxGgF
         KbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KgFNowuZMqGUBEF8deu+eqSvBHeEjv17nELCi+Lnm68=;
        b=IhyR42+xlGJwHr6XrRHcQ8fLOGx9LwLT/NGOE9Lf6qoq7wH8TbVlp9zdt+Lpye88tf
         0lnFUGWEax9CZbA/8f5WcQL9qCuNoo5AXUAHG++9a83/3QevKkgIyMvl6uvKKXk+A/Xj
         PhsVFsPXluI+f7rSHWpiMLoAFsI6uafOvuqxVDoKe8nVRgfEvWEOyA+ouFvpLT/jLYqz
         A+T1kKbewhq+kSP7r2FmOzmtTY3L+PHH+e9P4Fq+gREZrkTgm2h/qzmYBUwey/e9DVG8
         UgWCYCj7xBVzntmqgiV5DaTK1tvDg5AkUQ7VdW/JrpQ40459av81D5SxsaHbjOdz1wFN
         tKSw==
X-Gm-Message-State: APjAAAWLzWtgTGZG5hJlOnDCEvnYrkhTUw9yVvBe55vfcngjZZFmGGRV
        CcgaN9qrF78wH97q1wWMlBlSerlG
X-Google-Smtp-Source: APXvYqyA58EnnQLrK8Zrgp3hMTkIKHtYPvcwi6JuIprbh2xuAkaCPwZXNwmZRKegz5Ty2JTfFcJiPw==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr559915wmg.117.1574712910101;
        Mon, 25 Nov 2019 12:15:10 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id x7sm11584407wrq.41.2019.11.25.12.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 12:15:09 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 3/3] io_uring: cleanup io_import_fixed()
Date:   Mon, 25 Nov 2019 23:14:40 +0300
Message-Id: <3bea434add1c68d10fdc7b716c6e43099fabb5ab.1574712375.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574712375.git.asml.silence@gmail.com>
References: <cover.1574712375.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Clean io_import_fixed() call site and make it return proper type.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c75431079a74..7079e774bb8b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1488,9 +1488,9 @@ static void kiocb_done(struct kiocb *kiocb, ssize_t ret, struct io_kiocb **nxt,
 		io_rw_done(kiocb, ret);
 }
 
-static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
-			   const struct io_uring_sqe *sqe,
-			   struct iov_iter *iter)
+static ssize_t io_import_fixed(struct io_ring_ctx *ctx, int rw,
+			       const struct io_uring_sqe *sqe,
+			       struct iov_iter *iter)
 {
 	size_t len = READ_ONCE(sqe->len);
 	struct io_mapped_ubuf *imu;
@@ -1579,11 +1579,9 @@ static ssize_t io_import_iovec(int rw, struct io_kiocb *req,
 	 * flag.
 	 */
 	opcode = READ_ONCE(sqe->opcode);
-	if (opcode == IORING_OP_READ_FIXED ||
-	    opcode == IORING_OP_WRITE_FIXED) {
-		ssize_t ret = io_import_fixed(req->ctx, rw, sqe, iter);
+	if (opcode == IORING_OP_READ_FIXED || opcode == IORING_OP_WRITE_FIXED) {
 		*iovec = NULL;
-		return ret;
+		return io_import_fixed(req->ctx, rw, sqe, iter);
 	}
 
 	if (!req->has_user)
-- 
2.24.0

