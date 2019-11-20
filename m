Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7448C432C3
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 11:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97A022365
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 11:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLXax0an"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfKTLHE (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:07:04 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39267 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfKTLHE (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 06:07:04 -0500
Received: by mail-lf1-f66.google.com with SMTP id f18so7486757lfj.6
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 03:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KxjDo+5ZEo/J65zN4v9UXkrdF/8wc1UumArs6sbIUVQ=;
        b=FLXax0anBy4VIQhbUYump4+vngzP2pBqySXTzCrXchJ3ptjzQwx5vwWutWn+1XkA7n
         27Pl/7bMJH8lCxnDA6aasRi9fqtHgMmIdecSFNAeQ3QxhxagkcRny26E6xh6Wbd9+oLB
         NmenhXxd3HDycih2lY3yShmD2BL3cUa1lTtm46fSzXI+/AZLAtRtd6+ezv/PZ02rCPmy
         YH2Y9eoZowZgrbndov0DHQoEjyq3fwVenb2fshYo7t32lCS8/+9fdDUbhTCyImVcmj0M
         NA+HOglVA1KiUlG6gn0O3pTVqxAdFpcgdKFpuJAgUI3jlNjClQqOy6Ejc6zQcrj8FMZl
         3D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KxjDo+5ZEo/J65zN4v9UXkrdF/8wc1UumArs6sbIUVQ=;
        b=FDIZxE7f/yoIkNuJoD8YhrSf+kQJN8QLOIiudc5jB+k/X7EMIVvUdPlBPFV0TrzGkO
         sd0TfScnZegFd8RfMqKZssCd1Af98tnfkGWsbh5mrAknh4EVm7eo2BsRC5C+IQoC78di
         kuhF26JuYm4tpSxcXVHyuvHGuca1h0XCO7qxeoXUsQ2aQzcHOOXJS2adrs6QfHmoSTwb
         KbHAaFBR8Z5dYiZKcja256bFKLZEljVejDk7Kcc1MR/YvmulcU+0ShjfvVvVYS2xbtpu
         Gz37+4cU7/DWknX9Z12z59kThkQx2hGmHEBpKroEsrP9iMfTzQGRm9PhSe/0N9NGzicf
         89hQ==
X-Gm-Message-State: APjAAAUSd3Vf8uoMltJ/9v3pHGC+LozWB8TlPAuhRPuF0XbLzzA9ad9X
        2A2WAmhff0HEkxYz1FiYqAxCvgXv
X-Google-Smtp-Source: APXvYqxpE1esvqjHw5jhuUbZJseNTa/BQocAGFolarEwmeUBrvrmocAqLKUdhQcXF3iHG1EnREuVog==
X-Received: by 2002:ac2:4553:: with SMTP id j19mr2368386lfm.142.1574248022173;
        Wed, 20 Nov 2019 03:07:02 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id v203sm12741613lfa.25.2019.11.20.03.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 03:07:01 -0800 (PST)
Subject: Re: io_uring: io_fail_links() should only consider first linked
 timeout
To:     Bob Liu <bob.liu@oracle.com>, Jens Axboe <axboe@kernel.dk>,
        io-uring@vger.kernel.org
References: <efca87b0-3b8a-9614-c4c7-a341a2882b58@kernel.dk>
 <b8b1c8cf-5120-c4b2-e74b-4d0545b7a1f8@gmail.com>
 <9f43d496-5864-19ab-2084-75a097c96a61@oracle.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <6b39513b-0dec-f56f-992e-7c950cda803f@gmail.com>
Date:   Wed, 20 Nov 2019 14:07:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <9f43d496-5864-19ab-2084-75a097c96a61@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/2019 1:22 PM, Bob Liu wrote:
> On 11/20/19 4:44 PM, Pavel Begunkov wrote:
>> On 11/20/2019 1:33 AM, Jens Axboe wrote:
>>> We currently clear the linked timeout field if we cancel such a timeout,
>>> but we should only attempt to cancel if it's the first one we see.
>>> Others should simply be freed like other requests, as they haven't
>>> been started yet.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> ---
>>>
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index a79ef43367b1..d1085e4e8ae9 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -937,12 +937,12 @@ static void io_fail_links(struct io_kiocb *req)
>>>  		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
>>>  		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
>>>  			io_link_cancel_timeout(link);
>>> -			req->flags &= ~REQ_F_LINK_TIMEOUT;
>>>  		} else {
>>>  			io_cqring_fill_event(link, -ECANCELED);
>>>  			__io_double_put_req(link);
>>>  		}
>>>  		kfree(sqe_to_free);
>>> +		req->flags &= ~REQ_F_LINK_TIMEOUT;
>>
>> That's not necessary, but maybe would safer to keep. If
>> REQ_F_LINK_TIMEOUT is set, than there was a link timeout request,
>> and for it and only for it io_link_cancel_timeout() will be called.
>>
>> However, this is only true if linked timeout isn't fired. Otherwise,
>> there is another bug, which isn't fixed by either of the patches. We
>> need to clear REQ_F_LINK_TIMEOUT in io_link_timeout_fn() as well.
>>
>> Let: REQ -> L_TIMEOUT1 -> L_TIMEOUT2
>> 1. L_TIMEOUT1 fired before REQ is completed
>>
>> 2. io_link_timeout_fn() removes L_TIMEOUT1 from the list:
>> REQ|REQ_F_LINK_TIMEOUT -> L_TIMEOUT2
>>
>> 3. free_req(REQ) then call io_link_cancel_timeout(L_TIMEOUT2)
>> leaking it (as described in my patch).
>>
>> P.S. haven't tried to test nor reproduce it yet.
>>
> 
> Off topic... I'm reading the code regarding IORING_OP_LINK_TIMEOUT.
> But confused by what's going to happen if userspace submit a request with IORING_OP_LINK_TIMEOUT but not IOSQE_IO_LINK.
> 
It fails in __io_submit_sqe() with -EINVAL. (see default branch in the
switch). As for me, it's better to do it late, as it will generically
handle dependant links (e.g. fail them properly).

-- 
Pavel Begunkov
