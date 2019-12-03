Return-Path: <SRS0=jlnN=ZZ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F06C432C0
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 02:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B6E20705
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 02:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vi1yThZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLCCzG (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:55:06 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34861 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfLCCzD (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 2 Dec 2019 21:55:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so925024pgk.2
        for <io-uring@vger.kernel.org>; Mon, 02 Dec 2019 18:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gh+PUDCD29+w/3cnxh/LnlZn8zTO317FOBA/WJRRbvk=;
        b=vi1yThZ9drEm6wDaoLfTqVmoKjn1mUOFxM/wJWfkOD+0z4u/StKNYhvsY/0iVNrHas
         5PCdq9k6aMn7zbV5hM7M6HOoVkMSSa6q06K9Yh4Vu0A5GOssMSYYvyr9++U7EJNiwuAI
         BLcqbHgGxMdetCDvtXru8TRfrCc6q5XFYt0xtWiYG8I+W51+RyPwhKPnQwoqgqc/DMzQ
         k9KtmxvDH3lvTZyAPEmb7MimYX/xV5hCTpnZbjTgt8/eIXhjkgJkDSVqNN6EkWwbIGwE
         f65/ZaXWUSdWOHLlaVhDt24SyNPxvQHKqqriGY7AvpIbQLeSbOw+K37YIIhhol1Tx9vv
         YDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gh+PUDCD29+w/3cnxh/LnlZn8zTO317FOBA/WJRRbvk=;
        b=b1DEDXaAvu2aLTiQRrQDiprEDXln/j0RWcTeBg1UT5N42mRlImjg5aN4xHcA7Xla4H
         3c8i6x6ni0wBj4nSSpwJKf8X4arPw3no+1n1wl9icAm6CGw3/Yg+4uEgAfzOGcLcG9cu
         ZlB86lIjowJLmiP/HBTrFE+H44jGfJPbu0BZQ1PVIvFGMbuWIcphP72uLOvgaSVRqdUc
         IdLV4FE/LnVuE8oMiSrXUidQZm6nMtSGUesHgA60bi6HNg8Z/jm40VMvHujtNWt/zCCw
         ZJeEp4v8X/y6WwPPE10tyhY14RB5MhZLnwGs+tp6SHO1OOvpQK7OzROejiPEEKtjycSE
         YplQ==
X-Gm-Message-State: APjAAAUqxpQYgn8czcxUvtWPt64CB0TaaDknI7RImdR619AShfB/MiFL
        +VqhWL/Bmz8UDJOByRzuhbUlN+DJ0pQUNQ==
X-Google-Smtp-Source: APXvYqwlJiu2HZSscb52j8KWpoYL46r/nlhw5DkPr5VQ5IpGC8sDfup3EyH/ORlNH0he/o7H3se3Rw==
X-Received: by 2002:a63:5162:: with SMTP id r34mr2939054pgl.227.1575341701696;
        Mon, 02 Dec 2019 18:55:01 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z7sm959364pfk.41.2019.12.02.18.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 18:55:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     netdev@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/5] io_uring: ensure async punted connect requests copy data
Date:   Mon,  2 Dec 2019 19:54:43 -0700
Message-Id: <20191203025444.29344-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203025444.29344-1-axboe@kernel.dk>
References: <20191203025444.29344-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Just like commit bd26dacbd5ce for read/write requests, this one ensures
that the sockaddr data has been copied for IORING_OP_CONNECT if we need
to punt the request to async context.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c          | 47 ++++++++++++++++++++++++++++++++++++++----
 include/linux/socket.h |  5 ++---
 net/socket.c           | 16 +++++++-------
 3 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 11d181ed2076..d5cd338ac8bf 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -308,6 +308,10 @@ struct io_timeout {
 	struct io_timeout_data		*data;
 };
 
+struct io_async_connect {
+	struct sockaddr_storage		address;
+};
+
 struct io_async_msghdr {
 	struct iovec			fast_iov[UIO_FASTIOV];
 	struct iovec			*iov;
@@ -327,6 +331,7 @@ struct io_async_ctx {
 	union {
 		struct io_async_rw	rw;
 		struct io_async_msghdr	msg;
+		struct io_async_connect	connect;
 	};
 };
 
@@ -2187,11 +2192,22 @@ static int io_accept(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 #endif
 }
 
+static int io_connect_prep(struct io_kiocb *req, struct io_async_ctx *io)
+{
+	const struct io_uring_sqe *sqe = req->sqe;
+	struct sockaddr __user *addr;
+	int addr_len;
+
+	addr = (struct sockaddr __user *) (unsigned long) READ_ONCE(sqe->addr);
+	addr_len = READ_ONCE(sqe->addr2);
+	return move_addr_to_kernel(addr, addr_len, &io->connect.address);
+}
+
 static int io_connect(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		      struct io_kiocb **nxt, bool force_nonblock)
 {
 #if defined(CONFIG_NET)
-	struct sockaddr __user *addr;
+	struct io_async_ctx __io, *io;
 	unsigned file_flags;
 	int addr_len, ret;
 
@@ -2200,15 +2216,35 @@ static int io_connect(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (sqe->ioprio || sqe->len || sqe->buf_index || sqe->rw_flags)
 		return -EINVAL;
 
-	addr = (struct sockaddr __user *) (unsigned long) READ_ONCE(sqe->addr);
 	addr_len = READ_ONCE(sqe->addr2);
 	file_flags = force_nonblock ? O_NONBLOCK : 0;
 
-	ret = __sys_connect_file(req->file, addr, addr_len, file_flags);
-	if (ret == -EAGAIN && force_nonblock)
+	if (req->io) {
+		io = req->io;
+	} else {
+		ret = io_connect_prep(req, &__io);
+		if (ret)
+			goto out;
+		io = &__io;
+	}
+
+	ret = __sys_connect_file(req->file, &io->connect.address, addr_len,
+					file_flags);
+	if (ret == -EAGAIN && force_nonblock) {
+		io = kmalloc(sizeof(*io), GFP_KERNEL);
+		if (!io) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		memcpy(&io->connect, &__io.connect, sizeof(io->connect));
+		req->io = io;
+		memcpy(&io->sqe, req->sqe, sizeof(*req->sqe));
+		req->sqe = &io->sqe;
 		return -EAGAIN;
+	}
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;
+out:
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req, ret);
@@ -2822,6 +2858,9 @@ static int io_req_defer_prep(struct io_kiocb *req, struct io_async_ctx *io)
 	case IORING_OP_RECVMSG:
 		ret = io_recvmsg_prep(req, io);
 		break;
+	case IORING_OP_CONNECT:
+		ret = io_connect_prep(req, io);
+		break;
 	default:
 		req->io = io;
 		return 0;
diff --git a/include/linux/socket.h b/include/linux/socket.h
index 903507fb901f..2d2313403101 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -406,9 +406,8 @@ extern int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 			 int __user *upeer_addrlen, int flags);
 extern int __sys_socket(int family, int type, int protocol);
 extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
-extern int __sys_connect_file(struct file *file,
-			struct sockaddr __user *uservaddr, int addrlen,
-			int file_flags);
+extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
+			      int addrlen, int file_flags);
 extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
 			 int addrlen);
 extern int __sys_listen(int fd, int backlog);
diff --git a/net/socket.c b/net/socket.c
index 0fb0820edeec..b343db1489bd 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1826,26 +1826,22 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
  *	include the -EINPROGRESS status for such sockets.
  */
 
-int __sys_connect_file(struct file *file, struct sockaddr __user *uservaddr,
+int __sys_connect_file(struct file *file, struct sockaddr_storage *address,
 		       int addrlen, int file_flags)
 {
 	struct socket *sock;
-	struct sockaddr_storage address;
 	int err;
 
 	sock = sock_from_file(file, &err);
 	if (!sock)
 		goto out;
-	err = move_addr_to_kernel(uservaddr, addrlen, &address);
-	if (err < 0)
-		goto out;
 
 	err =
-	    security_socket_connect(sock, (struct sockaddr *)&address, addrlen);
+	    security_socket_connect(sock, (struct sockaddr *)address, addrlen);
 	if (err)
 		goto out;
 
-	err = sock->ops->connect(sock, (struct sockaddr *)&address, addrlen,
+	err = sock->ops->connect(sock, (struct sockaddr *)address, addrlen,
 				 sock->file->f_flags | file_flags);
 out:
 	return err;
@@ -1858,7 +1854,11 @@ int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
 
 	f = fdget(fd);
 	if (f.file) {
-		ret = __sys_connect_file(f.file, uservaddr, addrlen, 0);
+		struct sockaddr_storage address;
+
+		ret = move_addr_to_kernel(uservaddr, addrlen, &address);
+		if (!ret)
+			ret = __sys_connect_file(f.file, &address, addrlen, 0);
 		if (f.flags)
 			fput(f.file);
 	}
-- 
2.24.0

