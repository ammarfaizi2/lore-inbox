Return-Path: <SRS0=JfP8=ZP=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6374C432C0
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 22:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FFA20706
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 22:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1rhsxVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKWWmd (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 23 Nov 2019 17:42:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53634 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWWmc (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 23 Nov 2019 17:42:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id u18so11319685wmc.3
        for <io-uring@vger.kernel.org>; Sat, 23 Nov 2019 14:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4eieCF1jL2rwxXeKJ/I6g1C6TfbyVjHSblcmpnP88U=;
        b=g1rhsxVW1dCC0W21bU1bvdEIaI969y8KLMUrs+um+Z2pBuUUUTwXY3CKzolfBmhg58
         WlYT+1Ja+0XTn1igvB2MpwbRY/ZOM6x/tRbwmL3QCl/bK9Jw4QZndsD0Dv8EsixnhEJG
         zZ4We+GuZHsXsqwqxC9oU4ysfp7ttJ2Lfc+0+omj89LrXpgAJArvBqC+YuqeH1CsrVdA
         a/+39Q53ewGRmlOZ72O177VJxgmePy1elMbxz0Xsj5ToDVnMUjui3n6GxS+rvKOpWTg3
         wbApQHq1n9dldDT1k56qk9/8u0j40fLbtgaHcWFqWGPb2wS4WXidf3FGoODm0rl9TU/P
         lXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4eieCF1jL2rwxXeKJ/I6g1C6TfbyVjHSblcmpnP88U=;
        b=iEOeGyfK0vgpIdtxF+xFpC0oSgit0T/87MMrw9YD81MgP3OxAk0j7SH2pPysUQNgdd
         iMiwAUrXlKPTskg7+mslsByWkT9ulOixIJg0JAwMBNs41ip6O768kL3h0r5KApotE6dw
         0R+FMjqJiLut+BVmg6eq/9Vr+8h3XfhdOt1JXnloZ5K8NYsinYwSzvBrFClB9uWy9acc
         6heMJys6rGwsYFs5Ks8HlIi5r6m4dFyMQ/UhOchbqFkKVsiECX6FmZpr8u+wuWxkj9Io
         67qHibEXY4GuKshGQT3GAW/pu5rQRxjnv3jKbJDMNCrYSmMOcvp23Qmhf+N9E705tGGh
         ZtCg==
X-Gm-Message-State: APjAAAX+/ONx9hqDNIImN5bYk0k2xMql7EkBvdiYDqkFzjNATov32bef
        GIfP4aJvXQSmqqZsk7MTRMI=
X-Google-Smtp-Source: APXvYqxJ3bXVAg8HjtXAd/IvH1RxIuB9e8hm5tcv5eANeqZXkTYpZAeGzi6IdEpidoHs1bj5QSBEZQ==
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr23832368wmg.31.1574548950471;
        Sat, 23 Nov 2019 14:42:30 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id 11sm3319694wmb.34.2019.11.23.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 14:42:29 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH] io_uring: Fix linked fixed-read/write
Date:   Sun, 24 Nov 2019 01:42:00 +0300
Message-Id: <38fe471ecc3212c334fa60ff88a73896f11ec355.1574548888.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Dependant links of a fixed-read/write are always cancelled. The reason
is that io_complete_rw_common() uses req->result to decide whether to
fail links, which is set as res=io_import_iovec(). However,
io_import_fixed() doesn't return size, but error code.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5ceec1a4faad..8119cbae4fb6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1484,9 +1484,9 @@ static void kiocb_done(struct kiocb *kiocb, ssize_t ret, struct io_kiocb **nxt,
 		io_rw_done(kiocb, ret);
 }
 
-static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
-			   const struct io_uring_sqe *sqe,
-			   struct iov_iter *iter)
+static ssize_t io_import_fixed(struct io_ring_ctx *ctx, int rw,
+				const struct io_uring_sqe *sqe,
+				struct iov_iter *iter)
 {
 	size_t len = READ_ONCE(sqe->len);
 	struct io_mapped_ubuf *imu;
@@ -1555,7 +1555,7 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 		}
 	}
 
-	return 0;
+	return iter->count;
 }
 
 static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
@@ -1576,11 +1576,9 @@ static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
 	 * flag.
 	 */
 	opcode = READ_ONCE(sqe->opcode);
-	if (opcode == IORING_OP_READ_FIXED ||
-	    opcode == IORING_OP_WRITE_FIXED) {
-		ssize_t ret = io_import_fixed(ctx, rw, sqe, iter);
+	if (opcode == IORING_OP_READ_FIXED || opcode == IORING_OP_WRITE_FIXED) {
 		*iovec = NULL;
-		return ret;
+		return io_import_fixed(ctx, rw, sqe, iter);
 	}
 
 	if (!s->has_user)
-- 
2.24.0

