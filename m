Return-Path: <SRS0=q7Pc=74=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ED2C433DF
	for <io-uring@archiver.kernel.org>; Mon, 15 Jun 2020 18:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF4E207DA
	for <io-uring@archiver.kernel.org>; Mon, 15 Jun 2020 18:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgFOSGp (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:06:45 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43834 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728585AbgFOSGp (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 15 Jun 2020 14:06:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U.iJe-C_1592244403;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0U.iJe-C_1592244403)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Jun 2020 02:06:43 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     io-uring@vger.kernel.org
Cc:     axboe@kernel.dk, joseph.qi@linux.alibaba.com,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [PATCH v2 0/2] add proper memory barrier for IOPOLL mode
Date:   Tue, 16 Jun 2020 02:06:36 +0800
Message-Id: <20200615180638.19905-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The first patch makes io_uring do not fail links for io request that
returns EAGAIN error, second patch adds proper memory barrier to
synchronize io_kiocb's result and iopoll_completed.

V2:
  fix uninitialized req reference in the second patch.

Xiaoguang Wang (2):
  io_uring: don't fail links for EAGAIN error in IOPOLL mode
  io_uring: add memory barrier to synchronize io_kiocb's result and
    iopoll_completed

 fs/io_uring.c | 55 +++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

-- 
2.17.2

