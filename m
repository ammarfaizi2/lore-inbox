Return-Path: <SRS0=S5qu=ZQ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC27C432C0
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 08:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133B920706
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 08:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOaitSap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfKXI6s (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 24 Nov 2019 03:58:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34122 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKXI6s (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 24 Nov 2019 03:58:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so13753778wrr.1
        for <io-uring@vger.kernel.org>; Sun, 24 Nov 2019 00:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Uj4dV0DFaKiwHziXBljrsiiOW9uyFa8zCB2rOtCqzIs=;
        b=OOaitSapngOplgz+SMyeVoh4iuA0bd/yg3LHmMHa9FrS9WPWRIic6Y/+D7PswiqJqD
         Xio0GVU2KP1GIQEJzvja5jmfplZC2YJQPhh01IDFcDH+S/NjXtWIyixupD2Mhe8U1/+x
         Gyn34Bh7z968XpCwZtqqlSyy9HAf06XkMxNUNRBX8J2x6z7fpNPI2mt4KFTHJE/xjExL
         4pD1hBniNsSLIPENmsUZM6sjogtJd2ahNZ7Mvc+LQTdedfnrmgWE3Jm9UQbApo5UtmQB
         8yA6zPS4RB/ccYG2VCZ+N/4nHZovOesruSGCYkK+YlRyQxUVItYHLfmx0AooFFcugRR1
         YMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uj4dV0DFaKiwHziXBljrsiiOW9uyFa8zCB2rOtCqzIs=;
        b=TBnqI6QJHZ8K/3ew0km/4Y4j39q1H41J3WjUYLSvLivLx6geMiK40D5AeQW7tlbVRg
         r/Y9BH1h33pCujnHc6HAZEIhYOOsaFRilXNhDvCLOM80CMXk7Hu7g0lPe1mj0sY90im8
         2x73o+17gclllLu+D9/2l4VAlJWxsXi8gk6CEAjWoRriG80qydaUle4E2TlsUbvzDpuO
         CfiX2CNbNsSkMpnzuYIKydlmo9o6Dvh+7kfY9TayeWbSt3VqccuxG+W0tA8KSmuRjS17
         NyFrUqxNJURo7W4lPef9mMH3eqxLB3tOnLuyORC9BE/OZhAiKjHEF+e5I2GCLrDUbVnp
         x3sw==
X-Gm-Message-State: APjAAAW4V/Co6XSmMdyDBMuIMyve2li81uu0AwHvKCfRFwafK1puZR8l
        lYXy1RXtwsBi73iQiuEpTBog+AcT
X-Google-Smtp-Source: APXvYqyIhBvuH6TF3vSgWF7Jy+Y4QPVpO4j8KES0NOoE3XtGlUYpyyMiNk0Mcg68RB54Y7ILTQ26UA==
X-Received: by 2002:a5d:6a4c:: with SMTP id t12mr16618753wrw.141.1574585926353;
        Sun, 24 Nov 2019 00:58:46 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id d12sm3167786wrc.3.2019.11.24.00.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 00:58:45 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH v2] io_uring: fix dead-hung for non-iter fixed rw
Date:   Sun, 24 Nov 2019 11:58:24 +0300
Message-Id: <620023b272fef0fd76d0f91ff1876fa64864caa6.1574585281.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574585281.git.asml.silence@gmail.com>
References: <cover.1574585281.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Read/write requests to devices without implemented read/write_iter
using fixed buffers causes general protection fault, which totally
hangs a machine.

io_import_fixed() initialises iov_iter with bvec, but loop_rw_iter()
accesses it as iovec, so dereferencing random address.

kmap() page by page in this case

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
v2: use kmap

P.S. this one passes all tests well

 fs/io_uring.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8119cbae4fb6..1a9f34645586 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1613,9 +1613,19 @@ static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
 		return -EAGAIN;
 
 	while (iov_iter_count(iter)) {
-		struct iovec iovec = iov_iter_iovec(iter);
+		struct iovec iovec;
 		ssize_t nr;
 
+		if (!iov_iter_is_bvec(iter)) {
+			iovec = iov_iter_iovec(iter);
+		} else {
+			/* fixed buffers import bvec */
+			iovec.iov_base = kmap(iter->bvec->bv_page)
+						+ iter->iov_offset;
+			iovec.iov_len = min(iter->count,
+					iter->bvec->bv_len - iter->iov_offset);
+		}
+
 		if (rw == READ) {
 			nr = file->f_op->read(file, iovec.iov_base,
 					      iovec.iov_len, &kiocb->ki_pos);
@@ -1624,6 +1634,9 @@ static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
 					       iovec.iov_len, &kiocb->ki_pos);
 		}
 
+		if (iov_iter_is_bvec(iter))
+			kunmap(iter->bvec->bv_page);
+
 		if (nr < 0) {
 			if (!ret)
 				ret = nr;
-- 
2.24.0

