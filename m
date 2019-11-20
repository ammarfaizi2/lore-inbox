Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1939C432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 14:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751952230E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 14:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xn1H2Alo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbfKTOXa (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:23:30 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44932 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbfKTOXa (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 09:23:30 -0500
Received: by mail-il1-f194.google.com with SMTP id i6so2245601ilr.11
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 06:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lmtBK1Unr6vHf8NiVWoaHpN/0NOUiwzwNiVhnjsFyyA=;
        b=xn1H2AlozbIG1JgTfMV2qiy8KxBQ8Luvtm4rS0i8HJstIK/Cm++2focuhfDd28nD/D
         j23YuakDaZBbFMqXIJ0Vs9e00AKodiseaYAGp1yhtBzYWRabDMfjGiHpMt1aT+3gbxzd
         KelSgL2cI7PtxXJS6CWm/k2b5d3UYDTZuLaDoz6fJNRAU5luKQTqNW5ExoNOsDzeQDoR
         JdLuEjf6CuUnnC7OuF9xLf26xOnx08cey8EhKqvBt677mSb29ZDr5dTJEFW9y6xxtyBP
         rn0vkwKOVLJX3BJk7pOfu9wIRDwSTts4N6Iiww3sUMu7r3JcbAK8uyoHSUohdHi8juhw
         jCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lmtBK1Unr6vHf8NiVWoaHpN/0NOUiwzwNiVhnjsFyyA=;
        b=j0xeZx4NroFNOyiMHxozuX/gxwuBdUB9MhVVIUg8sbMhkX9jE4GOrUuyPpwp5kHjrp
         1rkJ3fao3HRjvfvYUXDorUuR8wy5tY80YrE73ympS3bDpp9rRg6vFcQJml38N9TdZxxr
         HCQV7tUslsmi3ekvxLEZr9gaROWMRtLaTw0Bt2JQJBXsNTR8XUkF2fXrkkMrCZgpmU4+
         1EC64TFFH/jVQyO+Z5gryMBRQuzQRl/OhfO3+5pRWcTvcnOnI9VEkvXVcwXqGsynGWb1
         JHzpzHLnsRCLm1vhYkEStWMoKEVelOoRRP3bWKpfw1oz/fWAkxeTmVctcEYPzjx+9jO9
         rpRA==
X-Gm-Message-State: APjAAAWR6LERK0oA+/7kUzzbougTa3bkUI66rADnqU8TE9lBPIRNeoEr
        N/vCrrR7wV6T2wm7iyQQef2kv1NBRw6A8w==
X-Google-Smtp-Source: APXvYqz1Gh22n8lBgsQt/UVeiRbQqzamxc1/KBGg+UAailC9xt0NbZVs3SxDLhnWQcNo/5f4IM61Gw==
X-Received: by 2002:a92:d645:: with SMTP id x5mr3609759ilp.219.1574259808781;
        Wed, 20 Nov 2019 06:23:28 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f24sm3799901ioc.87.2019.11.20.06.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 06:23:27 -0800 (PST)
Subject: Re: io_uring: io_fail_links() should only consider first linked
 timeout
To:     Bob Liu <bob.liu@oracle.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
References: <efca87b0-3b8a-9614-c4c7-a341a2882b58@kernel.dk>
 <b8b1c8cf-5120-c4b2-e74b-4d0545b7a1f8@gmail.com>
 <9f43d496-5864-19ab-2084-75a097c96a61@oracle.com>
 <6b39513b-0dec-f56f-992e-7c950cda803f@gmail.com>
 <11ab7750-6009-1228-af70-bc6b4604b245@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d2479a49-0d2d-9e6c-5172-c1a2be9582f4@kernel.dk>
Date:   Wed, 20 Nov 2019 07:23:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <11ab7750-6009-1228-af70-bc6b4604b245@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 7:03 AM, Bob Liu wrote:
> On 11/20/19 7:07 PM, Pavel Begunkov wrote:
>> On 11/20/2019 1:22 PM, Bob Liu wrote:
>>> On 11/20/19 4:44 PM, Pavel Begunkov wrote:
>>>> On 11/20/2019 1:33 AM, Jens Axboe wrote:
>>>>> We currently clear the linked timeout field if we cancel such a timeout,
>>>>> but we should only attempt to cancel if it's the first one we see.
>>>>> Others should simply be freed like other requests, as they haven't
>>>>> been started yet.
>>>>>
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>
>>>>> ---
>>>>>
>>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>>> index a79ef43367b1..d1085e4e8ae9 100644
>>>>> --- a/fs/io_uring.c
>>>>> +++ b/fs/io_uring.c
>>>>> @@ -937,12 +937,12 @@ static void io_fail_links(struct io_kiocb *req)
>>>>>   		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
>>>>>   		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
>>>>>   			io_link_cancel_timeout(link);
>>>>> -			req->flags &= ~REQ_F_LINK_TIMEOUT;
>>>>>   		} else {
>>>>>   			io_cqring_fill_event(link, -ECANCELED);
>>>>>   			__io_double_put_req(link);
>>>>>   		}
>>>>>   		kfree(sqe_to_free);
>>>>> +		req->flags &= ~REQ_F_LINK_TIMEOUT;
>>>>
>>>> That's not necessary, but maybe would safer to keep. If
>>>> REQ_F_LINK_TIMEOUT is set, than there was a link timeout request,
>>>> and for it and only for it io_link_cancel_timeout() will be called.
>>>>
>>>> However, this is only true if linked timeout isn't fired. Otherwise,
>>>> there is another bug, which isn't fixed by either of the patches. We
>>>> need to clear REQ_F_LINK_TIMEOUT in io_link_timeout_fn() as well.
>>>>
>>>> Let: REQ -> L_TIMEOUT1 -> L_TIMEOUT2
>>>> 1. L_TIMEOUT1 fired before REQ is completed
>>>>
>>>> 2. io_link_timeout_fn() removes L_TIMEOUT1 from the list:
>>>> REQ|REQ_F_LINK_TIMEOUT -> L_TIMEOUT2
>>>>
>>>> 3. free_req(REQ) then call io_link_cancel_timeout(L_TIMEOUT2)
>>>> leaking it (as described in my patch).
>>>>
>>>> P.S. haven't tried to test nor reproduce it yet.
>>>>
>>>
>>> Off topic... I'm reading the code regarding IORING_OP_LINK_TIMEOUT.
>>> But confused by what's going to happen if userspace submit a request with IORING_OP_LINK_TIMEOUT but not IOSQE_IO_LINK.
>>>
>> It fails in __io_submit_sqe() with -EINVAL. (see default branch in the
>> switch). As for me, it's better to do it late, as it will generically
>> handle dependant links (e.g. fail them properly).
>>
> 
> I see, thanks.
> As for me, it may better return -EINVAL in advance so as to skip a lot
> unnecessary code for those reqs.

It's an error case, hence unnecessary code isn't an issue. It's much
more important to just let it unwind naturally for that, imho.

-- 
Jens Axboe

