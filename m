Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB435C433E9
	for <io-uring@archiver.kernel.org>; Thu,  4 Feb 2021 09:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B886B64F48
	for <io-uring@archiver.kernel.org>; Thu,  4 Feb 2021 09:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhBDJcg (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 4 Feb 2021 04:32:36 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37611 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233628AbhBDJcf (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 4 Feb 2021 04:32:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UNqzQFj_1612431081;
Received: from B-25KNML85-0107.local(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UNqzQFj_1612431081)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Feb 2021 17:31:22 +0800
To:     io-uring <io-uring@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
From:   Hao Xu <haoxu@linux.alibaba.com>
Subject: Queston about io_uring_flush
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <63d16aae-1ca7-8939-1c8a-89c600be8462@linux.alibaba.com>
Date:   Thu, 4 Feb 2021 17:31:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi all,
Sorry for disturb all of you. Here comes my question.
When we close a uring file, we go into io_uring_flush(),
there is codes at the end:

if (!(ctx->flags & IORING_SETUP_SQPOLL) || ctx->sqo_task == current)
    io_uring_del_task_file(file);

My understanding, this is to delete the ctx(associated with the uring
file) from current->io_uring->xa.
I'm thinking of this scenario: the task to close uring file is not the
one which created the uring file.
Then it doesn't make sense to delete the uring file from 
current->io_uring->xa. It should be "delete uring file from
ctx->sqo_task->io_uring->xa" instead.


