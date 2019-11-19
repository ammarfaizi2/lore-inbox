Return-Path: <SRS0=5OhC=ZL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4632C432C0
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21632240E
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK2W6+eQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfKSUdU (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:33:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46001 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSUdU (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 15:33:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so25482790wrs.12
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 12:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lwxKA3No/+VOp6R8ZfhT1Z3nDnpM56QMdFwvIbC4GqY=;
        b=PK2W6+eQstW+JvTmYb6K+AX1XiX9OxFQ1qPEZzyXAZgbDHxZ0L1Wfo0GdK6T5tkJhN
         h59yAo2Gn45bFUDyEeXl0YY/kK+uXW9oi9Y7m+UhrywU1b9p/sWOVbPdlQxdEooza5Tw
         3Yie+0xlRrBkZxDSDzi9nu7ZWHsdQTKW0xKmldz977CtwWLKzQqjOYbZTDN4168ZcT96
         2BtSnNmD2cSFhY2yB9BOE+7q94aAk8K5tKVzOn/mBg4tEgi/vJVHDoETJIWtx/4qe0xv
         cCwJm1gPwVuMSeCfeZxAHwzmsrISjy92kr5LsrtK5tjQoiINMk9d2iXzykdh9vB/MZ+W
         DugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwxKA3No/+VOp6R8ZfhT1Z3nDnpM56QMdFwvIbC4GqY=;
        b=k71Maty9tf3x8xjbSlRl6+gPiujvBDqaDCbmwqMFXrIVImn2voTrYn/b18KqN+Qpw5
         LZb0ALsP/XpSbAZB2mLmmLwlKIp49H+j2h6024jj4m3aDFmFlq5YimMclAFw2mAMh5HF
         8aS9mab84Z6CCxkxk9zQABA769tZbQTjgoVrwR07kcL4TTsejPt9JoU6B7j7LtyeEL0H
         fsbqt2L+717bjSgCZ4dYm6IasuGKZIqAavetVMI8K6Z1d1Ohe3PHhEKmYfY1xxFfeJqQ
         EVgp3XoYApl9tlHDYPLBgPSjn6eVFtUVRNlOKRqozYC+QZ77VrZrekGb0HOsuG6LH2jY
         Vkhg==
X-Gm-Message-State: APjAAAVuKzMb4vU8m6WUw6fdmEpzTcLgti7MrRD+c/PIOt7yVbMqe3zg
        vxybZMGRdKiHyPvQe4+3s4g=
X-Google-Smtp-Source: APXvYqyJvHPlwF8xhpMyCEQLovth4saA1OB2DdB1oJYr9j5fcuQHWza3QV1tE0NhC9NO8rs0diy7aA==
X-Received: by 2002:adf:e58f:: with SMTP id l15mr16407169wrm.1.1574195598293;
        Tue, 19 Nov 2019 12:33:18 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id g184sm4605981wma.8.2019.11.19.12.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 12:33:17 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH 3/4] io_uring: remove redundant check
Date:   Tue, 19 Nov 2019 23:32:49 +0300
Message-Id: <4e094dff9ecd493f793e2dc28fa0168b7867ce5a.1574195129.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574195129.git.asml.silence@gmail.com>
References: <cover.1574195129.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Pass any IORING_OP_LINK_TIMEOUT request further, where it will
eventually fail in io_issue_sqe().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 637818cc3e5b..aa6c9fb8f640 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3059,10 +3059,6 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 
 		INIT_LIST_HEAD(&req->link_list);
 		*link = req;
-	} else if (READ_ONCE(s->sqe->opcode) == IORING_OP_LINK_TIMEOUT) {
-		/* Only valid as a linked SQE */
-		ret = -EINVAL;
-		goto err_req;
 	} else {
 		io_queue_sqe(req);
 	}
-- 
2.24.0

