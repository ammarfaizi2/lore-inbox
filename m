Return-Path: <SRS0=l6sb=2A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D5FC3F68F
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B6B2053B
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="e3aSf/KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfLJP6B (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:58:01 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35533 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfLJP6B (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Dec 2019 10:58:01 -0500
Received: by mail-io1-f65.google.com with SMTP id v18so19365715iol.2
        for <io-uring@vger.kernel.org>; Tue, 10 Dec 2019 07:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nvur1Bj3nl4CLr5ek2z8ES9n5dJyB/sJxmpMaueCmiY=;
        b=e3aSf/KXcc+AR+5F42eoJ4K1Y2VE+DmXZfc8211Yl+ii6+BkV2EHRLFgezbj+bslIo
         K5gCrJamxlce19s/mXb6qeDZVnKPk4dpEHLV6o7tx+dyofzWfxf2b7kQRwpLVqIvnxdF
         gGNGyCuFsOeTXpHF27AraAsjOmWZ9OwdBft9IDLqNoviNAsd8exGQxadRomEYCWm1Abp
         j1Q++Ul5RaS+opJNko4bRKWkqrXFS5U2nHt4m2FPtqYIFanI7Lu6Yx/1cBVRWOs+/vd7
         TF57Wmz2SPy73NxVNQhJDXpAEDNbzPbNroa1oJHmmjay1m+37RrX9PaMGIV8QfgGdR2o
         XaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nvur1Bj3nl4CLr5ek2z8ES9n5dJyB/sJxmpMaueCmiY=;
        b=EpgFVJGctUeytrCgHR9jll1uUBEdVI5uu4a9yHWLyMxmkxOvi3hgbQgLwOkJAB6Y/Z
         djw7NQn/g9UvdCTiSKGm+4ou9z/KDau4VeaJ31BXo3bnpoj/p4WiqBSxoPEBzCXd6eux
         8yr3jiCG3mMFCT7mfyWJUor4hkbDwC/8aHTE+9Ex7mHVaZZAIgkJsuE7Msm842ovjp1A
         YEnsUxGxXy7+oMCLxjDvZ8hKalNsS4xYUlcGmf3Ken8m6vu8/zAU+HvSWAy1+Hiw6F40
         pOBwqaz+aLf9VjizW43cE24zPWibKKpaM+HcEqePEbbEkvvL8+2nLWRY6hYuB8j9tO/G
         UocA==
X-Gm-Message-State: APjAAAWRFLCzneIwYZGf1cDqncQfuD9/xZ+EYL1wL7AOdNbeIfrZ37CA
        flUtS34sgP2kek7CR9BmMae2v3QiecR6MA==
X-Google-Smtp-Source: APXvYqxKQvNZgQMaZ1zbKTgPZjIlZzKeGlZBWxsFUmJz/xTnPkB1O/4ZUq6YhzBH9YTtTw7n9ygIoQ==
X-Received: by 2002:a02:cd3b:: with SMTP id h27mr15035171jaq.18.1575993479974;
        Tue, 10 Dec 2019 07:57:59 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w6sm770953ioa.16.2019.12.10.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:57:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, David Miller <davem@davemloft.net>,
        netdev@vger.kernel.org
Subject: [PATCH 10/11] net: make socket read/write_iter() honor IOCB_NOWAIT
Date:   Tue, 10 Dec 2019 08:57:41 -0700
Message-Id: <20191210155742.5844-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210155742.5844-1-axboe@kernel.dk>
References: <20191210155742.5844-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The socket read/write helpers only look at the file O_NONBLOCK. not
the iocb IOCB_NOWAIT flag. This breaks users like preadv2/pwritev2
and io_uring that rely on not having the file itself marked nonblocking,
but rather the iocb itself.

Cc: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index b343db1489bd..b116e58d6438 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -957,7 +957,7 @@ static ssize_t sock_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			     .msg_iocb = iocb};
 	ssize_t res;
 
-	if (file->f_flags & O_NONBLOCK)
+	if (file->f_flags & O_NONBLOCK || (iocb->ki_flags & IOCB_NOWAIT))
 		msg.msg_flags = MSG_DONTWAIT;
 
 	if (iocb->ki_pos != 0)
@@ -982,7 +982,7 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_pos != 0)
 		return -ESPIPE;
 
-	if (file->f_flags & O_NONBLOCK)
+	if (file->f_flags & O_NONBLOCK || (iocb->ki_flags & IOCB_NOWAIT))
 		msg.msg_flags = MSG_DONTWAIT;
 
 	if (sock->type == SOCK_SEQPACKET)
-- 
2.24.0

