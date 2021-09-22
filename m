Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC21C433EF
	for <io-uring@archiver.kernel.org>; Wed, 22 Sep 2021 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5135261178
	for <io-uring@archiver.kernel.org>; Wed, 22 Sep 2021 10:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhIVKRA (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:17:00 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:56395 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234531AbhIVKQ7 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 22 Sep 2021 06:16:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UpDq-Kb_1632305722;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UpDq-Kb_1632305722)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Sep 2021 18:15:28 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH] io_uring: return boolean value for io_alloc_async_data
Date:   Wed, 22 Sep 2021 18:15:22 +0800
Message-Id: <20210922101522.9179-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

boolean value is good enough for io_alloc_async_data.

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 91e4c89abf78..05c449ea3fd3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3309,7 +3309,7 @@ static void io_req_map_rw(struct io_kiocb *req, const struct iovec *iovec,
 	}
 }
 
-static inline int io_alloc_async_data(struct io_kiocb *req)
+static inline bool io_alloc_async_data(struct io_kiocb *req)
 {
 	WARN_ON_ONCE(!io_op_defs[req->opcode].async_size);
 	req->async_data = kmalloc(io_op_defs[req->opcode].async_size, GFP_KERNEL);
-- 
2.24.4

