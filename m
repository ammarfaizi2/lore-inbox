Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85209C433B4
	for <io-uring@archiver.kernel.org>; Wed, 28 Apr 2021 13:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2A461411
	for <io-uring@archiver.kernel.org>; Wed, 28 Apr 2021 13:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbhD1NdW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:33:22 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:35129 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230007AbhD1NdW (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 28 Apr 2021 09:33:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UX4Z1lB_1619616749;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UX4Z1lB_1619616749)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Apr 2021 21:32:35 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH RFC 5.13 0/2] adaptive sqpoll and its wakeup optimization
Date:   Wed, 28 Apr 2021 21:32:26 +0800
Message-Id: <1619616748-17149-1-git-send-email-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

patch 1/2 provides a new option to set up sq_thread_idle in nanosecond
granularity.
patch 2/2 is to cut down IO latency when sqthread is waking up.

This is a RFC, especially 2/2. There may be more works to do, like add
a REGISTER OP to allow applications to adjust sq_thread_idle, since it
may experience both high IO pressure and low IO pressure. And in low IO
pressure, patch 1/2 saves cpu resource while keeping a reasonable
latency. liburing tweak is ready as well, but currently I'd like to just
post this for comments.

Hao Xu (2):
  io_uring: add support for ns granularity of io_sq_thread_idle
  io_uring: submit sqes in the original context when waking up sqthread

 fs/io_uring.c                 | 88 ++++++++++++++++++++++++++++++++-----------
 include/uapi/linux/io_uring.h |  4 +-
 2 files changed, 70 insertions(+), 22 deletions(-)

-- 
1.8.3.1

