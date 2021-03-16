Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C79BC433E0
	for <io-uring@archiver.kernel.org>; Tue, 16 Mar 2021 06:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7346D650D2
	for <io-uring@archiver.kernel.org>; Tue, 16 Mar 2021 06:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhCPGOc (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 16 Mar 2021 02:14:32 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:51929 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232624AbhCPGOF (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 16 Mar 2021 02:14:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0US5VWTL_1615875233;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0US5VWTL_1615875233)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Mar 2021 14:14:01 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH] io_uring: remove duplicate IO_WQ_BIT_EXIT check
Date:   Tue, 16 Mar 2021 14:13:53 +0800
Message-Id: <1615875233-229318-1-git-send-email-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

remove duplicate IO_WQ_BIT_EXIT check since we do it in while()

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io-wq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 0ae9ecadf295..1c0575b29734 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -503,8 +503,7 @@ static int io_wqe_worker(void *data)
 		if (fatal_signal_pending(current))
 			break;
 		/* timed out, exit unless we're the fixed worker */
-		if (test_bit(IO_WQ_BIT_EXIT, &wq->state) ||
-		    !(worker->flags & IO_WORKER_F_FIXED))
+		if (!(worker->flags & IO_WORKER_F_FIXED))
 			break;
 	}
 
-- 
1.8.3.1

