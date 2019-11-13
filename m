Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACEBC432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62819206D8
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXDWA4CJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKMVLg (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:11:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37266 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVLf (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:11:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so4043216wrv.4
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x23X+ZUwsKuQunrl2CzEz8KxSp8eWzztVlvybvczl14=;
        b=HXDWA4CJdxXCj4KlFiCbIZgxZaPm5yHIs8NIKaQFpQ8tnC8yjbcmU4yLLr7FG0wADV
         8knkxvRkRe4ZlS6mE383gxMGi1QmHzIBi9+gtKa4ITIvRUWBLJ4AmkGJEO37DGu2XK61
         h7wUhagIdL4IzWuSA6Mf3rswL10KqQOk4s2OwRJ4xBhiQNleONS0OrY/gqZoYziFwgLi
         W9K31qSLY+YPLOVOLrm2rHawvkC8HMyyeQCtJ82rhymszRHZcxY27N8wj/wUh9vSRMf8
         JU427m45Gg0jGo7mrmHttNG9iehlZXUpCL14N343+SC1YN1mdOul5UAIpjrcCodfBwmS
         CYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x23X+ZUwsKuQunrl2CzEz8KxSp8eWzztVlvybvczl14=;
        b=sL4wim+PfCpPI1TrKxI/G7lBTL8yP2gVDwtgaOrT2nLxf8MD6aCsWTZJlYmmlAxm6X
         8dGg7lAr1CQH6laNZR1j0RLhzOO9XPNnN4p14/fcpRP5foKQG0CmYY78x3rNBIqPr0eB
         gUMFMhPw4CTCs3h8f9hvlmn8iUfuu/qc404YFC3xZcj8LJSPZ+sCTrjScP8oCvhO4fuz
         RVeWUgUme428ERAQDJ4Q2FkSnYn+NvgNkkrGahaZT9qOyEk4wQxNnjsLENxk84ks20/+
         poVaiqc++5PslapLZUHjfURkiVQwDa70FxYF8U9d8GopxYfpRmCXLVoJB6nzD1auc1tK
         loZw==
X-Gm-Message-State: APjAAAUs7xmTOxmAjQUTjkX1bfqnWMsaDk0DtOn3kG8HPguo1CUFfLhw
        qP0qzDgofMeE3UGBCMR0p93Vc0jA
X-Google-Smtp-Source: APXvYqyBoXFGG/RAMkvG7gBCKRe+Y+c1C8psOGtxgN2LV3mIPW56SvYHkbvXc0CHkRQIVUgRFMc+vQ==
X-Received: by 2002:adf:82c6:: with SMTP id 64mr4580759wrc.151.1573679493762;
        Wed, 13 Nov 2019 13:11:33 -0800 (PST)
Received: from localhost.localdomain ([109.126.149.223])
        by smtp.gmail.com with ESMTPSA id c9sm3243746wmb.42.2019.11.13.13.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:11:33 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH] io_uring: Fix getting file for timeout
Date:   Thu, 14 Nov 2019 00:11:01 +0300
Message-Id: <f07037aafc5e272343fbf5f9eeb554d51a4353df.1573679112.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

For timeout requests and bunch of others io_uring tries to grab a file
with specified fd, which is usually stdin/fd=0.
Update io_op_needs_file()

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6aea62f3bfff..0730c54b2153 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2599,6 +2599,10 @@ static bool io_op_needs_file(const struct io_uring_sqe *sqe)
 	switch (op) {
 	case IORING_OP_NOP:
 	case IORING_OP_POLL_REMOVE:
+	case IORING_OP_TIMEOUT:
+	case IORING_OP_TIMEOUT_REMOVE:
+	case IORING_OP_ASYNC_CANCEL:
+	case IORING_OP_LINK_TIMEOUT:
 		return false;
 	default:
 		return true;
-- 
2.24.0

