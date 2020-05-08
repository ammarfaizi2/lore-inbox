Return-Path: <SRS0=dMkf=6W=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E765AC47254
	for <io-uring@archiver.kernel.org>; Fri,  8 May 2020 13:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32F6206B9
	for <io-uring@archiver.kernel.org>; Fri,  8 May 2020 13:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEHNT7 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 May 2020 09:19:59 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:35083 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727845AbgEHNT6 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 May 2020 09:19:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TxwybQY_1588943979;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TxwybQY_1588943979)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 May 2020 21:19:51 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     io-uring@vger.kernel.org
Cc:     axboe@kernel.dk, joseph.qi@linux.alibaba.com
Subject: [PATCH] io_uring: remove obsolete 'state' parameter
Date:   Fri,  8 May 2020 21:19:30 +0800
Message-Id: <20200508131930.38743-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The "struct io_submit_state *state" parameter is not used, remove it.

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 979d9f9..5a29097 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5631,7 +5631,7 @@ static inline void io_queue_link_head(struct io_kiocb *req)
 }
 
 static int io_submit_sqe(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-			  struct io_submit_state *state, struct io_kiocb **link)
+			 struct io_kiocb **link)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
@@ -5895,7 +5895,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 
 		trace_io_uring_submit_sqe(ctx, req->opcode, req->user_data,
 						true, async);
-		err = io_submit_sqe(req, sqe, statep, &link);
+		err = io_submit_sqe(req, sqe, &link);
 		if (err)
 			goto fail_req;
 	}
-- 
1.8.3.1

