Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E47C48BC2
	for <io-uring@archiver.kernel.org>; Sun, 27 Jun 2021 21:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646D261A1D
	for <io-uring@archiver.kernel.org>; Sun, 27 Jun 2021 21:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhF0Vuh (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 27 Jun 2021 17:50:37 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:34667 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231676AbhF0Vug (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 27 Jun 2021 17:50:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UdpbPyp_1624830485;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UdpbPyp_1624830485)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Jun 2021 05:48:10 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH] io_uring: code clean for kiocb_done()
Date:   Mon, 28 Jun 2021 05:48:05 +0800
Message-Id: <1624830485-47217-1-git-send-email-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

A simple code clean for kiocb_done()

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2eb290f68aa3..5280a7bcb68a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2801,7 +2801,7 @@ static void kiocb_done(struct kiocb *kiocb, ssize_t ret,
 
 	if (req->flags & REQ_F_CUR_POS)
 		req->file->f_pos = kiocb->ki_pos;
-	if (ret >= 0 && kiocb->ki_complete == io_complete_rw)
+	if (ret >= 0 && check_reissue)
 		__io_complete_rw(req, ret, 0, issue_flags);
 	else
 		io_rw_done(kiocb, ret);
-- 
1.8.3.1

