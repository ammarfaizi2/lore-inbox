Return-Path: <SRS0=l6sb=2A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B020BC00454
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C2C2053B
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 15:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DdFG1LCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLJP6D (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:58:03 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44049 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfLJP6C (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Dec 2019 10:58:02 -0500
Received: by mail-io1-f67.google.com with SMTP id z23so19251854iog.11
        for <io-uring@vger.kernel.org>; Tue, 10 Dec 2019 07:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44A4VNsJJg1uYXRwb2kU/bBFqxJ8x+egS1B8TpSKGfc=;
        b=DdFG1LCm94x1/G+IMHZtTbKa6V1X7DDm7oq41o/i+pSA6Mv5rgqbYpG1sPMKQ9QVyA
         FQqYd6FFA/i5EOZY7DXvnB4a0WYYxGKNiAYJHCtaLNJ68ZuIhW2/m8qReC+p3CPMZW1H
         1LPWD2GrHas93kcqEuZK38vI2GqM/w73TJcDmMB6XplUO/VxmAW2MBH7GE+4JtM0pdMc
         jhtP7fbIx5/QV7Kkl+CV2oai8j61yCkCfYbwdEsMIl5Zbr3IpCpKMa/+g+w0PKvHikFa
         /qXANy0+KGTnJliDX/EktIVSxFnnyFu/wmuNdY4TuIDJbR+xVqK9tiKF2tItyK1GXUMW
         Wa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44A4VNsJJg1uYXRwb2kU/bBFqxJ8x+egS1B8TpSKGfc=;
        b=Dt1xKns8+QdAVCXASsqKSnHbwSSMQBZ0oUfBSxJawOekwXHT3StSjRb7Rp1wwU7LYs
         QLcvwFTCsPkhF4n1oqHrfQTZLrSyXdaJPgbgARyEhuuA19FQkMCC56adUEhgqvEn0mln
         CuSbJZAnV32x1MtmxFKa15ml2WpR5JcjiO9HX66e+MbzqdD9be60P1jzWhqGBVX1shbn
         waLWmDif/4DVWjdJd3Qdiu4+OFqRbIe1EiEdY0wcudcTr6Bd71qUxVwa4hINMUKUdFIT
         YnqV5TuxSlHn0LCnsxp7U90n1LfXwuPPv8E2H5cvrGQ200/9QX8YhxUqb56ODezsXWkJ
         VQ9w==
X-Gm-Message-State: APjAAAVwqj6ErfUdEicCg4Jz0RxjR9XcT+zyVKemfO1eMBatBAXIlYwN
        P9Gp41MUEFfSvK0mal84smb8WlB6I5UACw==
X-Google-Smtp-Source: APXvYqweJuzz0TWsL1e11A2tjKhMcyy/gnhh/qxAG2K7JKci+z3Y8FV3VgTJx5Yo0MVDA+GLyxBdwA==
X-Received: by 2002:a6b:f608:: with SMTP id n8mr24103957ioh.159.1575993481196;
        Tue, 10 Dec 2019 07:58:01 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w6sm770953ioa.16.2019.12.10.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:58:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/11] io_uring: add sockets to list of files that support non-blocking issue
Date:   Tue, 10 Dec 2019 08:57:42 -0700
Message-Id: <20191210155742.5844-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210155742.5844-1-axboe@kernel.dk>
References: <20191210155742.5844-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

In chasing a performance issue between using IORING_OP_RECVMSG and
IORING_OP_READV on sockets, tracing showed that we always punt the
socket reads to async offload. This is due to io_file_supports_async()
not checking for S_ISSOCK on the inode. Since sockets supports the
O_NONBLOCK (or MSG_DONTWAIT) flag just fine, add sockets to the list
of file types that we can do a non-blocking issue to.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8258a2f299e3..80e02957ae9e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1431,7 +1431,7 @@ static bool io_file_supports_async(struct file *file)
 {
 	umode_t mode = file_inode(file)->i_mode;
 
-	if (S_ISBLK(mode) || S_ISCHR(mode))
+	if (S_ISBLK(mode) || S_ISCHR(mode) || S_ISSOCK(mode))
 		return true;
 	if (S_ISREG(mode) && file->f_op != &io_uring_fops)
 		return true;
@@ -1867,7 +1867,9 @@ static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
 		goto copy_iov;
 	}
 
-	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT))
+	/* file path doesn't support NOWAIT for non-direct_IO */
+	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT) &&
+	    (req->flags & REQ_F_ISREG))
 		goto copy_iov;
 
 	iov_count = iov_iter_count(&iter);
-- 
2.24.0

