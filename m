Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF03C433F5
	for <io-uring@archiver.kernel.org>; Wed, 15 Sep 2021 13:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A515461359
	for <io-uring@archiver.kernel.org>; Wed, 15 Sep 2021 13:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhIONCX (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:02:23 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:47192 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233325AbhIONCS (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 15 Sep 2021 09:02:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UoUEPo._1631710858;
Received: from B-25KNML85-0107.local(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UoUEPo._1631710858)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Sep 2021 21:00:58 +0800
Subject: Re: [PATCH for-next] io_uring: remove ctx referencing from
 complete_post
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <60a0e96434c16ab4fe587651448290d61ec9a113.1631703756.git.asml.silence@gmail.com>
From:   Hao Xu <haoxu@linux.alibaba.com>
Message-ID: <27450ede-6a8a-1262-82a1-3e8749faba79@linux.alibaba.com>
Date:   Wed, 15 Sep 2021 21:00:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <60a0e96434c16ab4fe587651448290d61ec9a113.1631703756.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

在 2021/9/15 下午7:04, Pavel Begunkov 写道:
> Now completions are done from task context, that means that it's either
> the task itself, task_work or io-wq worker. In all those cases the ctx
system-wq as well, not sure if that matters.
> will be staying alive by mutexing, explicit referencing or req
> references by iowq. Remove extra ctx pinning from
> io_req_complete_post().
