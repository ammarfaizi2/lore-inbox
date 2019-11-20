Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9615C432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 14:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790472230E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 14:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eQmQaSdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfKTOW4 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:22:56 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41596 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfKTOW4 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 09:22:56 -0500
Received: by mail-il1-f195.google.com with SMTP id q15so23584288ils.8
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 06:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SS1Dbnqyjb89ITlD63zrqrJxjYsMLUg2IUNct0mox8s=;
        b=eQmQaSdRBtAfaLekQ/dFPfshG4s5K8jikBvb1nCXWRKfCmbnFouF8ezRXNO/+WVZ2h
         IgHW+v0mtskOU5EBzsBc9CEco9SIdT2aAVsVVLJ6NwLL2D9jHqhH3BEI8tCtF8mabWdt
         rffb0jpqhDsW8wziM1drKDhOoS3Ewv4ZOjU9+opIUuG66pdpE1X7BLOqGqTG3Pvadz/A
         o0wMZVmWTY9vhEkGRrYzdwBdNF+2CcOmALRwvHz0jM09yhG/lP28xr15sC289necWLyd
         kGlx3gP38gzuTs5vZxKkyBxnk3+xgXH9H47cXkCVeLesvmvT8kTzSECM5Ms8kiIEaUOJ
         Rk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SS1Dbnqyjb89ITlD63zrqrJxjYsMLUg2IUNct0mox8s=;
        b=MakqbNm0qXsOVAd4pNFlpcjrZhVW/nNpfc5lJhOhHZqJejkelQm+bZKHvSpbisHx9y
         tUDDX+rSHfyX5clr2vGRgXjMS0PGNZ5mmZ0eoZMHgTea9bsKK77miZY/dyeyCPG3eo8M
         GbQNcj2n4FcvTB+VA5+PDgz+ty6PUCwtzJYIT+auxvIynpN3iuI3SCmuyDErwXEVBEGq
         sjK7/Wzhbe5BeOsiEJskBsYKLijKMR3LuW7ZcvYrCt06oYXeorqb/+j2x7s+6XIYEXkJ
         DT/07fwCTIvgJTsX13Orvk5s/oK48QvrO50ybsKIsD7Rtsh7RCo8kik8XHJuhBszRL8l
         lqCw==
X-Gm-Message-State: APjAAAUDMUneYnsTGARj2CIt7QnUYJIT3a+HFHo7cZuNcpYQNf5BQRVY
        ut+sGaMqFd1kTEuLIt63KcobszMYkSymKw==
X-Google-Smtp-Source: APXvYqz1b6URShFUK0WhM5uW9XUdNOz0GNeYV5yjPVNG+k/4TvKlIY0RcQS0VDFvzVINtyG1fBvXhA==
X-Received: by 2002:a92:d7c2:: with SMTP id g2mr3927410ilq.81.1574259774234;
        Wed, 20 Nov 2019 06:22:54 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a11sm6580099ilb.72.2019.11.20.06.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 06:22:53 -0800 (PST)
Subject: Re: io_uring: io_fail_links() should only consider first linked
 timeout
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <efca87b0-3b8a-9614-c4c7-a341a2882b58@kernel.dk>
 <b8b1c8cf-5120-c4b2-e74b-4d0545b7a1f8@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f61f129e-8709-1b40-86eb-42cb672fe74f@kernel.dk>
Date:   Wed, 20 Nov 2019 07:22:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b8b1c8cf-5120-c4b2-e74b-4d0545b7a1f8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 1:44 AM, Pavel Begunkov wrote:
> On 11/20/2019 1:33 AM, Jens Axboe wrote:
>> We currently clear the linked timeout field if we cancel such a timeout,
>> but we should only attempt to cancel if it's the first one we see.
>> Others should simply be freed like other requests, as they haven't
>> been started yet.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index a79ef43367b1..d1085e4e8ae9 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -937,12 +937,12 @@ static void io_fail_links(struct io_kiocb *req)
>>   		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
>>   		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
>>   			io_link_cancel_timeout(link);
>> -			req->flags &= ~REQ_F_LINK_TIMEOUT;
>>   		} else {
>>   			io_cqring_fill_event(link, -ECANCELED);
>>   			__io_double_put_req(link);
>>   		}
>>   		kfree(sqe_to_free);
>> +		req->flags &= ~REQ_F_LINK_TIMEOUT;
> 
> That's not necessary, but maybe would safer to keep. If
> REQ_F_LINK_TIMEOUT is set, than there was a link timeout request,
> and for it and only for it io_link_cancel_timeout() will be called.
> 
> However, this is only true if linked timeout isn't fired. Otherwise,
> there is another bug, which isn't fixed by either of the patches. We
> need to clear REQ_F_LINK_TIMEOUT in io_link_timeout_fn() as well.
> 
> Let: REQ -> L_TIMEOUT1 -> L_TIMEOUT2
> 1. L_TIMEOUT1 fired before REQ is completed
> 
> 2. io_link_timeout_fn() removes L_TIMEOUT1 from the list:
> REQ|REQ_F_LINK_TIMEOUT -> L_TIMEOUT2
> 
> 3. free_req(REQ) then call io_link_cancel_timeout(L_TIMEOUT2)
> leaking it (as described in my patch).
> 
> P.S. haven't tried to test nor reproduce it yet.

That's exactly the case I was worried about. In any case, it seems
prudent to handle it defensively.

-- 
Jens Axboe

