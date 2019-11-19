Return-Path: <SRS0=5OhC=ZL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F29C432C0
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 22:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E222244A
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 22:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qTHmyvFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKSWNM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:13:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33400 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfKSWNM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 17:13:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id c184so13070710pfb.0
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 14:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KueytCkMW84i3XWKtdaF+nJ4GqDTf6vIx0b5wIzi7zM=;
        b=qTHmyvFfb3V+DjtJiCNqLAJDt2EdAq8178GGeCXgDFI/yU0DMRZEMHiolnENfqhWYX
         Q8G/Q0pk5LWdFxO9+0ZoFUJK3UzrMQpg+131tU2QlC7ws8YsecUoKNW0m5NA2Lc6qDI9
         rxZfzauciLns7RkmYsvc3ksWF6KoNunMsgct59Vs2rbT5Km6kuJkQhO5LAL+Bbvvf0bM
         pme0Avw0ltrZZcUI9u7XJkSpGCGmfgjPvmC7TDPigocGOatftMcOTiJfVQXDC0ENi/aw
         lIVXFAA62PX2ex53EnzVHFNCC5YsqbIyHvQVl5xIoe2XaIe1Qaqr7ZG4otetn1LYHmA3
         XOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KueytCkMW84i3XWKtdaF+nJ4GqDTf6vIx0b5wIzi7zM=;
        b=ltni/bJiWIlSJuINiZ3c8VIWYUToMPd8XzpUrArD+E3vERan/MFazqF47a6GNDmarl
         kfWyzGRca3h+8UFWWlz4lZpQv8YdwUzb6dJ+beNOGELHnfHN/++922YbbfKuj7ZUJ5Ca
         1/DCcQkPk5XRW5IegO9/W1m3t9mcbl+8HDAc5sXUJGCsa6m+3BMa7vvwpEKZPCgqL8/P
         ZzMkb8heyBj+elw4ZFaLF2sL8BftBVYP0tPDl9Qz5hfnkYo6F7jdBpDzBpPFERWT+2JM
         OnSyIpFuOL2PElnGrrpAAOIkyMtoDR5gMsFY7H948vSh9yLCOq9x2Cx1o5cxCYvz8qvk
         3XuA==
X-Gm-Message-State: APjAAAUovDRMZ8nBdu72qrGhTxfdLOVy4hm3HVFblcgYSA0iYAFIhklz
        1EERWQj2GIipvo/R+u3thYJPXfKU+3g=
X-Google-Smtp-Source: APXvYqy+2KuChD2GTZB1ojr55XOmvi/Y6fLstaSEpuGlHXCwUPKdPkd/iU6fKHKbOmBLBo9MgUiVrg==
X-Received: by 2002:a65:678a:: with SMTP id e10mr8136660pgr.258.1574201590702;
        Tue, 19 Nov 2019 14:13:10 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id h66sm28308371pfg.23.2019.11.19.14.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 14:13:09 -0800 (PST)
Subject: Re: [PATCH 7/8] io_uring: fix sequencing issues with linked timeouts
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <20191116015314.24276-1-axboe@kernel.dk>
 <20191116015314.24276-8-axboe@kernel.dk>
 <ccf48def-1a4a-9cb1-aa9a-467294487856@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b98a91cd-54c1-49ef-d75d-8007dcc470c1@kernel.dk>
Date:   Tue, 19 Nov 2019 15:13:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ccf48def-1a4a-9cb1-aa9a-467294487856@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/19/19 1:51 PM, Pavel Begunkov wrote:
> On 16/11/2019 04:53, Jens Axboe wrote:
>> We have an issue with timeout links that are deeper in the submit chain,
>> because we only handle it upfront, not from later submissions. Move the
>> prep + issue of the timeout link to the async work prep handler, and do
>> it normally for non-async queue. If we validate and prepare the timeout
>> links upfront when we first see them, there's nothing stopping us from
>> supporting any sort of nesting.
>>
>> Fixes: 2665abfd757f ("io_uring: add support for linked SQE timeouts")
>> Reported-by: Pavel Begunkov <asml.silence@gmail.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
> 
>> @@ -923,6 +942,7 @@ static void io_fail_links(struct io_kiocb *req)
>>   			io_cqring_fill_event(link, -ECANCELED);
>>   			__io_double_put_req(link);
>>   		}
>> +		kfree(sqe_to_free);
>>   	}
>>   
>>   	io_commit_cqring(ctx);
>> @@ -2668,8 +2688,12 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
>>   
>>   	/* if a dependent link is ready, pass it back */
>>   	if (!ret && nxt) {
>> -		io_prep_async_work(nxt);
>> +		struct io_kiocb *link;
>> +
>> +		io_prep_async_work(nxt, &link);
>>   		*workptr = &nxt->work;
> Are we safe here without synchronisation?
> Probably io_link_timeout_fn() may miss the new value
> (doing io-wq cancel).

Miss what new value? Don't follow that part.

This should be safe, by the time the request is findable, we have
made the necessary setup in io_prep_async_work().

-- 
Jens Axboe

