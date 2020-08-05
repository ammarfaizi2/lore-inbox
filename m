Return-Path: <SRS0=V/+L=BP=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08DEC433E0
	for <io-uring@archiver.kernel.org>; Wed,  5 Aug 2020 02:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C6B2073E
	for <io-uring@archiver.kernel.org>; Wed,  5 Aug 2020 02:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgHECAZ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:00:25 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:53309 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbgHECAZ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 4 Aug 2020 22:00:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U4mffbV_1596592812;
Received: from ali-186590e05fa3.local(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0U4mffbV_1596592812)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Aug 2020 10:00:13 +0800
Subject: Re: [PATCH liburing v2 1/2] io_uring_enter: add timeout support
To:     Jens Axboe <axboe@kernel.dk>, Stefan Metzmacher <metze@samba.org>
Cc:     io-uring@vger.kernel.org
References: <1596532913-70757-1-git-send-email-jiufei.xue@linux.alibaba.com>
 <1596532913-70757-2-git-send-email-jiufei.xue@linux.alibaba.com>
 <a1c1413b-ede9-acf5-7bfb-7b617897f1d7@samba.org>
 <1072d796-5347-eb4b-b0ad-1e1838c1a100@linux.alibaba.com>
 <f8b90784-669c-7fbc-ad9d-4cc49ac314b8@kernel.dk>
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
Message-ID: <d06e7805-c6d1-7744-d688-b75d38bacf9d@linux.alibaba.com>
Date:   Wed, 5 Aug 2020 10:00:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f8b90784-669c-7fbc-ad9d-4cc49ac314b8@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org



On 2020/8/5 上午9:43, Jens Axboe wrote:
> On 8/4/20 7:08 PM, Jiufei Xue wrote:
>>
>>
>> On 2020/8/4 下午6:25, Stefan Metzmacher wrote:
>>> Am 04.08.20 um 11:21 schrieb Jiufei Xue:
>>>> Kernel can handle timeout when feature IORING_FEAT_GETEVENTS_TIMEOUT
>>>> supported. Applications should use io_uring_set_cqwait_timeout()
>>>> explicitly to asked for the new feature.
>>>>
>>>> In addition in this commit we add two new members to io_uring and a pad
>>>> for future flexibility. So for the next release, applications have to
>>>> re-compile against the lib.
>>>
>>> I don't think this is an option, existing applications need to work.
>>>
>>> Or they must fail at startup when the runtime dependencies are resolved.
>>> Which means the soname of the library has to change.
>>>
>>
>> Yes, I think the version should bump to 2.0.X with next release.
>>
>> Jens, 
>> should I bump the version with this patch set? Or you will bump it
>> before next release.
> 
> It should get bumped with the change, otherwise things will fail before
> the next release in case people run the git version.
> 
> And while you're at it, add some more pad. Don't want to go through
> the same process again the next time we need a bit of space. Just add
> 4 unsigneds as pad at least, that's enough for a pointer and 2
> 32-bit entries.
>

ok. I will send version 3 later with these modification.

Thank,
Jiufei
