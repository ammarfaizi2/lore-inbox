Return-Path: <SRS0=l6sb=2A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE03AC2D0BF
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D5D2053B
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="poe5/mbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLJP5y (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:57:54 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35867 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLJP5y (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Dec 2019 10:57:54 -0500
Received: by mail-io1-f66.google.com with SMTP id a22so4349174ios.3
        for <io-uring@vger.kernel.org>; Tue, 10 Dec 2019 07:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zW5InZeja/qiB9BHiMF+/0XxC1x6YORCaS0op/LqnNY=;
        b=poe5/mbKDqdI0Zu0bOEWmye9Ny4ENuDoMI3O+GIglUBDopHIlmLWOqe++HqD5c8mvr
         IKxIqDkIFqo9xk8caYuSmlSkvhCu55TqqGyCYezb7xGRlBnAAbv8F7JJMwOKRSQuZo2F
         1/MCSiPEv4bMp2emQOkkktgsyzT+KomGd5/4x/3wov/KufD94Zalxni9iGdO73kRI/P3
         2kj4jQMGG6O+w8pDn+fvJikEi9N/DoB7l2OkncuNOw6Dbbgp75H2HVh4CGxcm7yduvEo
         /52r/88mRbOZWsIdO5+H7v2SwpfJQgxmq5+ESB45bzNkJUxQnPt0z205RZfAQytlfK94
         g93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zW5InZeja/qiB9BHiMF+/0XxC1x6YORCaS0op/LqnNY=;
        b=GfcqhvRgxaR3jDoRnckQ1ocNELXsPbdbFaIQ92nImLpKexfZMXMNRLvK/+lL/4J8kG
         fqEimsxKQkm2Bj5xmENEztnH2JI63lubvBEnWO5c/rPRPvBB4zQm9tEktztm24aMUXy0
         GMW3OaHJCnWEieVOs8RdgUyBRroTJp/nJk+Dfs73gWEjpcJsN7+STqDuNU3xkB8K0LOp
         DnZPc8peg90tuzRo6aK7fgH8VCzeFw4GDnh1rMbT5MOeHGfZ+izNGet9FHGd8JabaF4g
         xeqISIEUV3Mxikk8xgLsQNryiszDshnBwcObKkF5hX4NRX26ONkK/xsE9nepjB7gVngB
         kn5w==
X-Gm-Message-State: APjAAAUvl67q0HcKAadTw0FA5Zdt4nG7f2w3lFsOUSNVSJcOtcW9v5ix
        H/uWuftY0yOhcvTtoTnBkUhXv6S47bplog==
X-Google-Smtp-Source: APXvYqzeZ0uJxoBoi6j1iz3/voMecF3baKG4DEWMQnEG9FgyO/WNmuJPNFQBBUOTn3JpNZ7mLGI/ZQ==
X-Received: by 2002:a05:6638:a4a:: with SMTP id 10mr26625373jap.44.1575993473086;
        Tue, 10 Dec 2019 07:57:53 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w6sm770953ioa.16.2019.12.10.07.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:57:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] io_uring: deferred send/recvmsg should assign iov
Date:   Tue, 10 Dec 2019 08:57:36 -0700
Message-Id: <20191210155742.5844-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210155742.5844-1-axboe@kernel.dk>
References: <20191210155742.5844-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Don't just assign it from the main call path, that can miss the case
when we're called from issue deferral.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1e1e80d48145..a0ed20e097d9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2026,6 +2026,7 @@ static int io_sendmsg_prep(struct io_kiocb *req, struct io_async_ctx *io)
 
 	flags = READ_ONCE(sqe->msg_flags);
 	msg = (struct user_msghdr __user *)(unsigned long) READ_ONCE(sqe->addr);
+	io->msg.iov = io->msg.fast_iov;
 	return sendmsg_copy_msghdr(&io->msg.msg, msg, flags, &io->msg.iov);
 #else
 	return 0;
@@ -2061,7 +2062,6 @@ static int io_sendmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		} else {
 			kmsg = &io.msg.msg;
 			kmsg->msg_name = &addr;
-			io.msg.iov = io.msg.fast_iov;
 			ret = io_sendmsg_prep(req, &io);
 			if (ret)
 				goto out;
@@ -2104,6 +2104,7 @@ static int io_recvmsg_prep(struct io_kiocb *req, struct io_async_ctx *io)
 
 	flags = READ_ONCE(sqe->msg_flags);
 	msg = (struct user_msghdr __user *)(unsigned long) READ_ONCE(sqe->addr);
+	io->msg.iov = io->msg.fast_iov;
 	return recvmsg_copy_msghdr(&io->msg.msg, msg, flags, &io->msg.uaddr,
 					&io->msg.iov);
 #else
@@ -2143,7 +2144,6 @@ static int io_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		} else {
 			kmsg = &io.msg.msg;
 			kmsg->msg_name = &addr;
-			io.msg.iov = io.msg.fast_iov;
 			ret = io_recvmsg_prep(req, &io);
 			if (ret)
 				goto out;
-- 
2.24.0

