Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E31C4338F
	for <io-uring@archiver.kernel.org>; Mon, 23 Aug 2021 18:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BC8613B1
	for <io-uring@archiver.kernel.org>; Mon, 23 Aug 2021 18:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhHWShj (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:37:39 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54513 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229962AbhHWShi (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 23 Aug 2021 14:37:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UlQutiJ_1629743808;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UlQutiJ_1629743808)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Aug 2021 02:36:54 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [RFC 0/2] io_task_work optimization
Date:   Tue, 24 Aug 2021 02:36:46 +0800
Message-Id: <20210823183648.163361-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

running task_work may not be a big bottleneck now, but it's never worse
to make it move forward a little bit.
I'm trying to construct tests to prove it is better in some cases where
it should be theoretically.
Currently only prove it is not worse by running fio tests(sometimes a
little bit better). So just put it here for comments and suggestion.

Hao Xu (2):
  io_uring: run task_work when sqthread is waken up
  io_uring: add irq completion work to the head of task_list

 fs/io-wq.h    |  9 +++++++++
 fs/io_uring.c | 23 ++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.24.4

