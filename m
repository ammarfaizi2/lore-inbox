Return-Path: <SRS0=FaGP=ZG=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D254C432C3
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 21:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08299206E6
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 21:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiUjS+DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfKNVVP (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:21:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37105 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNVVP (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 14 Nov 2019 16:21:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so8436971wrv.4
        for <io-uring@vger.kernel.org>; Thu, 14 Nov 2019 13:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvKfZMSRVx8KvhTtqlVTrT/XJWwhjkCPpNU8fE4gpns=;
        b=WiUjS+DBewjpzPgj9YnZOBOD2TleIgVG8HSSrCcPJH+oDAB+HheTPwZj0t9dogaoss
         yOWSmBvgdSDJED4HER9vk5kfZihsjGrPOHS5XdedIoXXxkX+MQDqxsgUGRt3qfZD2DqS
         DVp0zr4DmBPjShpFcsiEy0zwlO0HJ02/uwmvH80UjFXk1ZCN+JF2u56Tc+bCYPqej2MF
         NNPchJB9n2A9+AwWlhSmIbuFGVVoouO5m7DdN56ki+iCgrLk9xftSvXtTI12L/z27QDb
         z7HtaYC5ly5a0ejOr70StNxZ3DWsoOOX6xm+6DFxahwFKIAgpN2f/ZnATCHBVtD2wbVR
         Qhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvKfZMSRVx8KvhTtqlVTrT/XJWwhjkCPpNU8fE4gpns=;
        b=BpztYlGcFwJttt44RLD5+sn6IwnKV8vG35lWe0/FZrW6pAWJwNzMJB+/uqbtHwLo4b
         YxQx0/W5PSEpgsSfLpcKWiQwiG4FITiyq4/6MX6Qtg93Hm6PXOaEbA2YgL8Kz5p+agf6
         PBWoB6HJ1b4imKVN5/3ARHDOEdHVTKPylNZpJlDMzs7a9ujMGzk2sp/+cpm69nTchZYx
         17hEzLiGTejWHlbbr9dsRyA/JFEGP9gV1HlJB9GNaBL3Gc6J+psBQO/nC88ZPZRvH1Yh
         VtmR2Le9dbPk19V9GAfWV3MPczSbU5r4530jWqH4Oo2SW+6efLD0ALU0EmBBNgwl3XE/
         2sZA==
X-Gm-Message-State: APjAAAX2OpUArMjgTV397Xpgb7DRZEHK06e1Uw/NbVksdkFa1GTPPzs+
        kC9yUobwKRhoRDwBV5IBMkWh1J8G
X-Google-Smtp-Source: APXvYqzO3KtYQl5601K4ziVoEeS9zWGCkDFx96vUKaHvzws47Uu3UoA5SBotNUnw6dwTsblk4KZmlw==
X-Received: by 2002:a5d:6104:: with SMTP id v4mr10401418wrt.36.1573766473356;
        Thu, 14 Nov 2019 13:21:13 -0800 (PST)
Received: from localhost.localdomain ([109.126.151.234])
        by smtp.gmail.com with ESMTPSA id l1sm8717499wrw.33.2019.11.14.13.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 13:21:12 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: [PATCH] io_uring: Fix LINK_TIMEOUT checks
Date:   Fri, 15 Nov 2019 00:20:48 +0300
Message-Id: <9a5eef46f7ed9f52f8de67d314651cd4a4234572.1573766402.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

If IORING_OP_LINK_TIMEOUT request is a head of a link or an individual
request, pass it further through the submission path, where it will
eventually fail in __io_submit_sqe(). So respecting links and drains.

The case, which is really need to be checked, is if a
IORING_OP_LINK_TIMEOUT request is 3rd or later in a link, that is
invalid from the user API perspective (judging by the code). Moreover,
put/free and friends will try to io_link_cancel_timeout() such request,
even though it wasn't initialised.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 55f8b1d378df..fd2ba35f53e3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2952,6 +2952,12 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 	if (*link) {
 		struct io_kiocb *prev = *link;
 
+		if (unlikely(READ_ONCE(s->sqe->opcode) == IORING_OP_LINK_TIMEOUT
+			&& !list_empty(&prev->link_list))) {
+			ret = -EINVAL;
+			goto err_req;
+		}
+
 		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
 		if (!sqe_copy) {
 			ret = -EAGAIN;
@@ -2966,10 +2972,6 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 
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

