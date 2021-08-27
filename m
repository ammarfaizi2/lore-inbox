Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3F0C432BE
	for <io-uring@archiver.kernel.org>; Fri, 27 Aug 2021 09:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E58D60E73
	for <io-uring@archiver.kernel.org>; Fri, 27 Aug 2021 09:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244998AbhH0Jrt (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 27 Aug 2021 05:47:49 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33619 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245118AbhH0JrQ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 27 Aug 2021 05:47:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UmFsqUh_1630057569;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UmFsqUh_1630057569)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 Aug 2021 17:46:26 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH for-5.15 v3 0/2] fix failed linkchain code logic
Date:   Fri, 27 Aug 2021 17:46:07 +0800
Message-Id: <20210827094609.36052-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

the first patch is code clean.
the second is the main one, which refactors linkchain failure path to
fix a problem, detail in the commit message.

v1-->v2
 - update patch with Pavel's suggestion.
v2-->v3
 - move req->result initiation to better place
 - add helpers for failing link node

Hao Xu (2):
  io_uring: remove redundant req_set_fail()
  io_uring: fix failed linkchain code logic

 fs/io_uring.c | 62 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 15 deletions(-)

-- 
2.24.4

