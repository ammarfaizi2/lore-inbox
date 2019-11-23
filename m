Return-Path: <SRS0=JfP8=ZP=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38BDC432C3
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 21:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C08F20672
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 21:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yU1tw9us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKWV1U (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 23 Nov 2019 16:27:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41828 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKWV1U (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 23 Nov 2019 16:27:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id p26so5346904pfq.8
        for <io-uring@vger.kernel.org>; Sat, 23 Nov 2019 13:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UR0UVLJ/IUMWn5l60pc0zwFWn8/sSH1s224oij3hpAM=;
        b=yU1tw9usSS8pHAUxiyMghvfPl9agwLDQlGDGDrZUcnwFlxNbugiJLyFne8oc8OA++R
         toBQmjX4ZkL8k/TNT6DfFyGIW71oAVMEHy7zIC/KuPxxWP7p49dFpxSFRqLgV2MFLbCH
         ugZo05HKbJQJdTRNk0ebtbj4dbnVetxGYu9M+c3mIXgcZchd+i6oQc0b0OA8JUVRa4Tm
         /hhSVcn4z7YzH/NwbI3M1Ai7CoF7IRFVfQJESSZEao+D9TYNKdeTeFs8Pb0vuCiHo8pz
         AxPBK7i/4G08ndlcc67b3qESSGRDXqsJSvXQzoC5oh4hcGPP1FmDGcfwx8NjJDqloyCp
         61sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UR0UVLJ/IUMWn5l60pc0zwFWn8/sSH1s224oij3hpAM=;
        b=j7U9nDOiYjz+/1cfjCmgLhH+82v8y3Q9jsgDS/neB/7oS9kYZO/l3O8V8NL5XYoSiY
         Y0oDMw6A0yVuo2p6FjBxyLR27odhw0vv2a3WrgpjM5FW44bC0VWi+1oLfOqooKHDycCW
         Q9LIWCe4bMepHZOHEVViP0HKmSInJoIo6ihHFMAy3uhfzmyomCKc5fElo4wd8ZjmuczF
         ODwBrPF6bbHag8f/5DEPose5aIuwBelEljfPvKUCqBmdQKxebFDE2ElJmmu44zJ7fr49
         7eo0ZA164prUX9y1J+oxd82J41JLYAf8jfcDix1596oiKVXPERwSWEcF0OvTtYHj1f0f
         nLHw==
X-Gm-Message-State: APjAAAVwdnS/a2Fzb3GrNV3LZn1cYi1+Zo6Qs/djK/roDnC6xUEt+UXK
        4SkcUvPo6C+RpkOs1Pow//K5YuPUTN7guQ==
X-Google-Smtp-Source: APXvYqxQHtPuijF5lw+QxGLslaUuwSbemBzgSxJB9ARi0Tx6pdmy2IK2/xaCyymVvoZ+wzDNdBxnNw==
X-Received: by 2002:a65:520d:: with SMTP id o13mr9352862pgp.433.1574544439102;
        Sat, 23 Nov 2019 13:27:19 -0800 (PST)
Received: from x1.thefacebook.com ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id gx16sm2981169pjb.10.2019.11.23.13.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 13:27:18 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] io_uring: add support for IORING_OP_CONNECT
Date:   Sat, 23 Nov 2019 14:27:09 -0700
Message-Id: <20191123212709.4598-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191123212709.4598-1-axboe@kernel.dk>
References: <20191123212709.4598-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This allows an application to call connect() in an async fashion. Like
other opcodes, we first try a non-blocking accept, then punt to async
context if we have to.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 37 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/io_uring.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0c66cd6ed0b0..5ceec1a4faad 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1968,6 +1968,40 @@ static int io_accept(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 #endif
 }
 
+static int io_connect(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		      struct io_kiocb **nxt, bool force_nonblock)
+{
+#if defined(CONFIG_NET)
+	struct sockaddr __user *addr;
+	unsigned file_flags;
+	int addr_len, ret;
+
+	if (unlikely(req->ctx->flags & (IORING_SETUP_IOPOLL|IORING_SETUP_SQPOLL)))
+		return -EINVAL;
+	if (sqe->ioprio || sqe->off || sqe->len || sqe->buf_index || sqe->flags)
+		return -EINVAL;
+
+	addr = (struct sockaddr __user *) (unsigned long) READ_ONCE(sqe->addr);
+	addr_len = READ_ONCE(sqe->addr2);
+	file_flags = force_nonblock ? O_NONBLOCK : 0;
+
+	ret = __sys_connect_file(req->file, addr, addr_len, file_flags);
+	if ((ret == -EAGAIN || ret == -EINPROGRESS) && force_nonblock) {
+		req->work.flags |= IO_WQ_WORK_NEEDS_FILES;
+		return -EAGAIN;
+	}
+	if (ret == -ERESTARTSYS)
+		ret = -EINTR;
+	if (ret < 0 && (req->flags & REQ_F_LINK))
+		req->flags |= REQ_F_FAIL_LINK;
+	io_cqring_add_event(req, ret);
+	io_put_req_find_next(req, nxt);
+	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
 static inline void io_poll_remove_req(struct io_kiocb *req)
 {
 	if (!RB_EMPTY_NODE(&req->rb_node)) {
@@ -2622,6 +2656,9 @@ static int io_issue_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
 	case IORING_OP_ACCEPT:
 		ret = io_accept(req, s->sqe, nxt, force_nonblock);
 		break;
+	case IORING_OP_CONNECT:
+		ret = io_connect(req, s->sqe, nxt, force_nonblock);
+		break;
 	case IORING_OP_ASYNC_CANCEL:
 		ret = io_async_cancel(req, s->sqe, nxt);
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 2a1569211d87..4637ed1d9949 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -73,6 +73,7 @@ struct io_uring_sqe {
 #define IORING_OP_ACCEPT	13
 #define IORING_OP_ASYNC_CANCEL	14
 #define IORING_OP_LINK_TIMEOUT	15
+#define IORING_OP_CONNECT	16
 
 /*
  * sqe->fsync_flags
-- 
2.24.0

