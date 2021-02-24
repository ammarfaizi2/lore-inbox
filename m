Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67CBC433DB
	for <io-uring@archiver.kernel.org>; Wed, 24 Feb 2021 03:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9E564DFF
	for <io-uring@archiver.kernel.org>; Wed, 24 Feb 2021 03:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhBXDHf (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 23 Feb 2021 22:07:35 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37304 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229961AbhBXDHe (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 23 Feb 2021 22:07:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UPPcA2a_1614136011;
Received: from B-25KNML85-0107.local(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UPPcA2a_1614136011)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Feb 2021 11:06:51 +0800
Subject: Re: [PATCH v2 1/1] io_uring: allocate memory for overflowed CQEs
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <a5e833abf8f7a55a38337e5c099f7d0f0aa8746d.1614083504.git.asml.silence@gmail.com>
From:   Hao Xu <haoxu@linux.alibaba.com>
Message-ID: <f57545fb-a109-0881-ff14-f371d1a9d811@linux.alibaba.com>
Date:   Wed, 24 Feb 2021 11:06:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a5e833abf8f7a55a38337e5c099f7d0f0aa8746d.1614083504.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

ÔÚ 2021/2/23 ÏÂÎç8:40, Pavel Begunkov Ð´µÀ:
> Instead of using a request itself for overflowed CQE stashing, allocate
> a separate entry. The disadvantage is that the allocation may fail and
> it will be accounted as lost (see rings->cq_overflow), so we lose
> reliability in case of memory pressure. However, it opens a way for for
> multiple CQEs per an SQE and even generating SQE-less CQEs >
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
Hi Pavel,
Allow me to ask a stupid question, why do we need to support multiple 
CQEs per SQE or even SQE-less CQEs in the future?

Thanks,
Hao
