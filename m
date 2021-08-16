Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36637C4320A
	for <io-uring@archiver.kernel.org>; Mon, 16 Aug 2021 06:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 222E761A2C
	for <io-uring@archiver.kernel.org>; Mon, 16 Aug 2021 06:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhHPGFY (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 16 Aug 2021 02:05:24 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:43336 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233561AbhHPGFX (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 16 Aug 2021 02:05:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uj5gy5d_1629093890;
Received: from B-25KNML85-0107.local(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0Uj5gy5d_1629093890)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Aug 2021 14:04:51 +0800
Subject: Re: [PATCH] io_uring: consider cgroup setting when binding sqpoll cpu
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20210815151049.182340-1-haoxu@linux.alibaba.com>
 <9d0a001a-bdab-9399-d8c3-19191785d3c7@kernel.dk>
From:   Hao Xu <haoxu@linux.alibaba.com>
Message-ID: <0c3195be-7109-861f-ff05-a4f804380e1c@linux.alibaba.com>
Date:   Mon, 16 Aug 2021 14:04:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9d0a001a-bdab-9399-d8c3-19191785d3c7@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

在 2021/8/15 下午11:19, Jens Axboe 写道:
> On 8/15/21 9:10 AM, Hao Xu wrote:
>> Since sqthread is userspace like thread now, it should respect cgroup
>> setting, thus we should consider current allowed cpuset when doing
>> cpu binding for sqthread.
> 
> This seems a bit convoluted for what it needs to do. Surely we can just
> test sqd->sq_cpu directly in the task_cs()?
I didn't know task_cs() before, it seems to be a static function, which
is called by cpuset_cpus_allowed(), and this one is exposed.
> 

