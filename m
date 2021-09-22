Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0437C433EF
	for <io-uring@archiver.kernel.org>; Wed, 22 Sep 2021 12:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B8760560
	for <io-uring@archiver.kernel.org>; Wed, 22 Sep 2021 12:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhIVMfx (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 22 Sep 2021 08:35:53 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:35103 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230171AbhIVMfw (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 22 Sep 2021 08:35:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UpEjUHJ_1632314061;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0UpEjUHJ_1632314061)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Sep 2021 20:34:21 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     io-uring@vger.kernel.org
Cc:     axboe@kernel.dk, asml.silence@gmail.com,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [RFC 0/3] improvements for poll requests
Date:   Wed, 22 Sep 2021 20:34:14 +0800
Message-Id: <20210922123417.2844-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This patchset tries to improve echo_server model based on io_uring's
IORING_POLL_ADD_MULTI feature.

Xiaoguang Wang (3):
  io_uring: reduce frequent add_wait_queue() overhead for multi-shot
    poll request
  io_uring: don't get completion_lock in io_poll_rewait()
  io_uring: try to batch poll request completion

 fs/io_uring.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 92 insertions(+), 24 deletions(-)

-- 
2.14.4.44.g2045bb6

