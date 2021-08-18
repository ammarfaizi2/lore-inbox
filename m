Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DD0C4338F
	for <io-uring@archiver.kernel.org>; Wed, 18 Aug 2021 07:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453486054E
	for <io-uring@archiver.kernel.org>; Wed, 18 Aug 2021 07:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbhHRHn5 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 18 Aug 2021 03:43:57 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:43335 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238224AbhHRHn5 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 18 Aug 2021 03:43:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UjeejBw_1629272596;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UjeejBw_1629272596)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Aug 2021 15:43:21 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 1/3] io_uring: remove redundant req_set_fail()
Date:   Wed, 18 Aug 2021 15:43:14 +0800
Message-Id: <20210818074316.22347-2-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210818074316.22347-1-haoxu@linux.alibaba.com>
References: <20210818074316.22347-1-haoxu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

req_set_fail() in io_submit_sqe() is redundant, remove it.

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io_uring.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1be7af620395..c0b841506869 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6629,7 +6629,6 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 fail_req:
 		if (link->head) {
 			/* fail even hard links since we don't submit */
-			req_set_fail(link->head);
 			io_req_complete_failed(link->head, -ECANCELED);
 			link->head = NULL;
 		}
-- 
2.24.4

