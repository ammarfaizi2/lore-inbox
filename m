Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE052C43141
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 15:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68FA2073A
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 15:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XMtUITRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKOPNr (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:13:47 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:46704 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfKOPNr (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 10:13:47 -0500
Received: by mail-io1-f51.google.com with SMTP id i11so10734463iol.13
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 07:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nl3wTCoLMUeCBIWD8WqaehgSPLUmMgTb4iNO52iRxzk=;
        b=XMtUITRAFXEkzTEh5ZCkNbP+Wu1s4jBNFZYlgHgQOzgifst9FxS8ZDVQUjxBPT1Vk1
         oZ+ia9cZeux+cguxR6xyuK9YQdvvRgHIA+hZOSUjdeSwdx77W76uBpFQIkVPfpBWK6Xu
         BM7jqH4hnDpcilcbImw1GkxKu+kXSOyR+08sLEAKmryP6jUBz4PhMCIhBk8zpd2dtSug
         757z+VVvl9Ya5v2WxjDN2ZQMWDe5sLCkR6bIN/k/FJMVPHkuC9VbDWuLpVgl0pP/mxmy
         B73sN3dtXL2JjbCBfpksMZOMUA2EMTqftC5KguO136c9sXWreIUwcm3XgnoF6cVlFfRV
         vVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nl3wTCoLMUeCBIWD8WqaehgSPLUmMgTb4iNO52iRxzk=;
        b=LKCI65Pepbx4tX+wCOddGTQGYlJREXSLXQ/dAQo/LMEcYWI6CQpS506HtM6PIqmTvh
         83C2B+jTBFY867xBh0Gw4/dM7ph8FveGFLKmHJV2B8Z8RIdw25rWIVuetNbnoWPYwOEZ
         Ilf5pK7zSWyJx9HAZLYsBWTidvbl2AtE6JTDa4HMMHjGRjj54MN+dKNP9E4QvlHIUvjO
         vCjjGRVFUnzl/mbWolv/EWR4nsMjwph02YBsu4D7XcpQ+CC8zse/uvXL/pxpvViAZD4g
         +zCvBBzZ16W1htAp0w3AVBq5/s52CzY96nAsTdpO0ncn78VzdUPxHP6UPNJrjzRapu6W
         h2dw==
X-Gm-Message-State: APjAAAXvgZSMP+WRrqBmcSTOU+WZOlJSgHyn2Ga9K+DemCC2mijvZ+A/
        TRoYwiNt6fDnpm3Tturwvjw3ng==
X-Google-Smtp-Source: APXvYqzuvZHK6ig+6fL99J73Po0VpXkbzccVHtOXx7NvIDQ0oRAhGlnRIaW9yOtk6fyiCqz4ePiGKw==
X-Received: by 2002:a05:6638:229:: with SMTP id f9mr1184316jaq.64.1573830824952;
        Fri, 15 Nov 2019 07:13:44 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e67sm1634672ill.42.2019.11.15.07.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 07:13:43 -0800 (PST)
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
 <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>
Date:   Fri, 15 Nov 2019 08:13:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/15/19 7:21 AM, Pavel Begunkov wrote:
> On 15/11/2019 12:40, Pavel Begunkov wrote:
>>>> Finally got to this patch. I think, find it adding too many edge cases
>>>> and it isn't integrated consistently into what we have now. I would love
>>>> to hear your vision, but I'd try to implement them in such a way, that it
>>>> doesn't need to modify the framework, at least for some particular case.
>>>> In other words, as opcodes could have been added from the outside with a
>>>> function table.
>>>
>>> I agree, it could do with a bit of cleanup. Incrementals would be
>>> appreciated!
>>>
>>>> Also, it's not so consistent with the userspace API as well.
>>>>
>>>> 1. If we specified drain for the timeout, should its start be delayed
>>>> until then? I would prefer so.
>>>>
>>>> E.g. send_msg + drained linked_timeout, which would set a timeout from the
>>>> start of the send.
>>>
>>> What cases would that apply to, what would the timeout even do in this
>>> case? The point of the linked timeout is to abort the previous command.
>>> Maybe I'm not following what you mean here.
>>>
>> Hmm, got it a bit wrong with defer. io_queue_link_head() can defer it
>> without setting timeout. However, it seems that io_wq_submit_work()
>> won't set a timer, as it uses __io_submit_sqe(), but not
>> __io_queue_sqe(), which handles all this with linked timeouts.
>>
>> Indeed, maybe it be, that you wanted to place it in __io_submit_sqe?
>>
>>>> 2. Why it could be only the second one in a link? May we want to cancel
>>>> from a certain point?
>>>> e.g. "op1 -> op2 -> timeout -> op3" cancels op2 and op3
>>>
>>> Logically it need not be the second, it just has to follow another
>>> request. Is there a bug there?
>>>
>> __io_queue_sqe looks only for the second one in a link. Other linked
>> timeouts will be ignored, if I get the code right.
>>
>> Also linking may (or __may not__) be an issue. As you remember, the head
>> is linked through link_list, and all following with list.
>> i.e. req_head.link_list <-> req.list <-> req.list <-> req.list
>>
>> free_req() (last time I saw it), expects that timeout's previous request
>> is linked with link_list. If a timeout can fire in the middle of a link
>> (during execution), this could be not the case. But it depends on when
>> we set an timeout.
>>
>> BTW, personally I'd link them all through link_list. E.g. may get rid of
>> splicing in free_req(). I'll try to make it later.
>>
>>>> 3. It's a bit strange, that the timeout affects a request from the left,
>>>> and after as an consequence cancels everything on the right (i.e. chain).
>>>> Could we place it in the head? So it would affect all requests on the right
>>>> from it.
>>>
>>> But that's how links work, though. If you keep linking, then everything
>>> that depends on X will fail, if X itself isn't succesful.
>>>
>> Right. That's about what userspace API would be saner. To place timeout
>> on the left of a request, or on the right, with the same resulting effect.
>>
>> Let put this question away until the others are clear.
>>
>>>> 4. I'd prefer to handle it as a new generic command and setting a timer
>>>> in __io_submit_sqe().
>>>>
>>>> I believe we can do it more gracefully, and at the same moment giving
>>>> more freedom to the user. What do you think?
>>>
>>> I just think we need to make sure the ground rules are sane. I'm going
>>> to write a few test cases to make sure we do the right thing.
>>>
>>
> Ok, let me try to state some rules to discuss:

> 1. REQ -> LINK_TIMEOUT
> is a valid use case

Yes

> 2. timeout is set at the moment of starting execution of operation.
> e.g. REQ1, REQ2|DRAIN -> LINK_TIMEOUT
>
> Timer is set at the moment, when everything is drained and we
> sending REQ. i.e. after completion of REQ1

Right, the timeout is prepped before REQ2 is started, armed when it is
started (if not already done). The prep + arm split is important to
ensure that a short timeout doesn't even find REQ2.

> 3. REQ1 -> LINK_TIMEOUT1 -> REQ2 -> LINK_TIMEOUT2
> 
> is valid, and LINK_TIMEOUT2 will be set, at the moment of
> start of REQ2's execution. It also mean, that if
> LINK_TIMEOUT1 fires, it will cancel REQ1, and REQ2
> with LINK_TIMEOUT2 (with proper return values)

That's not valid with the patches I sent. It could be, but we'd need to
fix that bit.

> 4. REQ1, LINK_TIMEOUT
> is invalid, fail it

Correct

> 5. LINK_TIMEOUT1 -> LINK_TIMEOUT2
> Fail first, link-fail (aka cancelled) for the second one

Correct

> 6. REQ1 -> LINK_TIMEOUT1 -> LINK_TIMEOUT2
> execute REQ1+LINK_TIMEOUT1, and then fail LINK_TIMEOUT2 as
> invalid. Also, LINK_TIMEOUT2 could be just cancelled
> (e.g. if fail_links for REQ1)

Given case 5, why would this one be legal?

-- 
Jens Axboe

