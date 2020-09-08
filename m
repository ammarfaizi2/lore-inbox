Return-Path: <SRS0=dEr3=CR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A278FC2D0E0
	for <io-uring@archiver.kernel.org>; Tue,  8 Sep 2020 02:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6703121941
	for <io-uring@archiver.kernel.org>; Tue,  8 Sep 2020 02:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgIHCyN (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 7 Sep 2020 22:54:13 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:43237 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728241AbgIHCyM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 7 Sep 2020 22:54:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0U8HGWcQ_1599533649;
Received: from 30.225.32.193(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0U8HGWcQ_1599533649)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Sep 2020 10:54:09 +0800
Subject: Re: [PATCH 8/8] io_uring: enable IORING_SETUP_ATTACH_WQ to attach to
 SQPOLL thread too
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <20200903022053.912968-1-axboe@kernel.dk>
 <20200903022053.912968-9-axboe@kernel.dk>
 <c6562c28-7631-d593-d3e5-cde158337337@linux.alibaba.com>
 <13bd91f7-9eef-cc38-d892-d28e5d068421@kernel.dk>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <0496b3cc-a32a-230c-81dc-26be7369ab26@linux.alibaba.com>
Date:   Tue, 8 Sep 2020 10:53:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <13bd91f7-9eef-cc38-d892-d28e5d068421@kernel.dk>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

hi,

> On 9/7/20 2:56 AM, Xiaoguang Wang wrote:
>> 3. When it's appropriate to set ctx's IORING_SQ_NEED_WAKEUP flag? In
>> your current implementation, if a ctx is marked as SQT_IDLE, this ctx
>> will be set IORING_SQ_NEED_WAKEUP flag, but if other ctxes have work
>> to do, then io_sq_thread is still running and does not need to be
>> waken up, then a later wakeup form userspace is unnecessary. I think
>> it maybe appropriate to set IORING_SQ_NEED_WAKEUP when all ctxes have
>> no work to do, you can have a look at my attached codes:)
> 
> That's a good point, any chance I can get you to submit a patch to fix
> that up?
> 
>> 4. Is io_attach_sq_data really safe? sqd_list is a global list, but
>> its search key is a fd local to process, different processes may have
>> same fd, then this codes looks odd, seems that your design is to make
>> io_sq_thread shared inside process.
> 
> It's really meant for thread sharing, or you could pass the fd and use
> it across a process too. See the incremental I just sent in a reply to
> Pavel.
> 
> That said, I do think the per-cpu approach has merrit, and I also think
> it should be possible to layer it on top of the existing code in
> for-5.10/io_uring. So I'd strongly encourage you to try and do that, so
> you can get rid of using that private patch and just have it upstream
> instead.
Really thanks for your encouragement, I'll do my best to try to have it in upstream.

Regards,
Xiaoguang Wang

> 
