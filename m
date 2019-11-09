Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E9CC43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C85320869
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IoiiuH7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfKIOQS (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 09:16:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43891 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfKIOQS (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 09:16:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so6027869pgh.10
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 06:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HAVi3q9UOvdNO0YwVgc5BPmmupKCGIur27Oj0Kch6uw=;
        b=IoiiuH7LnLnd9gRdacI4iPWKu6CoeEzy+5jdQxHq20EUKmc10XVWQxJCyAfOwUuiiR
         nKIyjBFE5QyMPLIN3ke8KmvsommKveA8vOnrwg1o26dEoCwthEGZ8bOXfwDYRXrw/VIl
         EBAHd5LFRAnDNQlmwXlKDB3S5jVI+HctRqDp4yDUCv80mrBYTkgi+zcyONE/4Jox/t4x
         NAmiDdYZtNP1xOH/ljylPGh21scWLYesPQAfX0Es22QY+hx0RQTXwCg6kA6cnmcdXmfo
         ZBCz5hTCX7EsiPLD81X5SJUhnuTuinU7qX4J3nQ/LJ7vn9wXnmFPJBBpzABmmKy2KV5z
         syDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HAVi3q9UOvdNO0YwVgc5BPmmupKCGIur27Oj0Kch6uw=;
        b=jfIvxyaLRVeza6v6Q7TqOuR7FYhqD5u7/qgGbGjqAQHYNU3UJ+xABpLkoM5TQxG+8p
         fZZQiv5CMNWM7pr3348CiA7wSNqciobHolUUd2TcqLcwo6s7/vGE5VAEeConYRKg9v+6
         XCKIdyqHghuAvU1d80FBSNUCMFsKVmWsLdY6KqdN7s+gM6JT08rP8vUafi2KTEW+SFyd
         ZlodJQizhTNzg7Wb3xuvxh3EwJHkCZk/VrRtouOiHLQbXSuKHIoeyQpfsluLMrDqmsYm
         0aGU3UfjzxWA8u0873W6UwSQ186NoJAX9FHVqSUbArOEQ4EaNXnI/CYVxROSv8fyFhSE
         M2FQ==
X-Gm-Message-State: APjAAAX8Tzs0pPJpEKkQZBl3/Z2Kp211GGA9Cq/Ge0rvgm1giwyP6AfO
        BecMWTBu7gnhZqr2mDXT3kXKWzjiB5c=
X-Google-Smtp-Source: APXvYqyuuxr9JFvCKIHCRiVbB36EyFn0zhR9wQlmPbeQ4ebeX31HZQeKRg3PrircN+VX2FmUfCSJmA==
X-Received: by 2002:a63:1f09:: with SMTP id f9mr17788125pgf.89.1573308977362;
        Sat, 09 Nov 2019 06:16:17 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id e24sm9477243pjt.18.2019.11.09.06.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 06:16:16 -0800 (PST)
Subject: Re: [PATCH RFC v2] io_uring: limit inflight IO
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <d7604123-1499-70b1-9990-74b3b1cfab69@kernel.dk>
 <6945baa5-7539-1d67-fcb5-5642e81994a8@gmail.com>
 <614016e6-9e94-0b26-1652-8ce140952d28@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ed59eb7-d3fc-2d12-6d6e-5af420577abd@kernel.dk>
Date:   Sat, 9 Nov 2019 07:16:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <614016e6-9e94-0b26-1652-8ce140952d28@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/9/19 5:28 AM, Pavel Begunkov wrote:
> On 11/9/2019 2:01 PM, Pavel Begunkov wrote:
>> On 09/11/2019 00:10, Jens Axboe wrote:
>>> Here's a modified version for discussion. Instead of sizing this on the
>>> specific ring, just size it based on the max allowable CQ ring size. I
>>> think this should be safer, and won't risk breaking existing use cases
>>> out there.
>>>
>>> The reasoning here is that we already limit the ring sizes globally,
>>> they are under ulimit memlock protection. With this on top, we have some
>>> sort of safe guard for the system as a whole as well, whereas before we
>>> had none. Even a small ring size can keep queuing IO.
>>>
>>> Let me know what you guys think...
>>>
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index 29ea1106132d..0d8c3b1612af 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -737,6 +737,25 @@ static struct io_kiocb *io_get_fallback_req(struct io_ring_ctx *ctx)
>>>   	return NULL;
>>>   }
>>>   
>>> +static bool io_req_over_limit(struct io_ring_ctx *ctx)
>>> +{
>>> +	unsigned inflight;
>>> +
>>> +	/*
>>> +	 * This doesn't need to be super precise, so only check every once
>>> +	 * in a while.
>>> +	 */
>>> +	if (ctx->cached_sq_head & ctx->sq_mask)
>>> +		return false;
>>> +
>>> +	/*
>>> +	 * Use 2x the max CQ ring size
>>> +	 */
>>> +	inflight = ctx->cached_sq_head -
>>> +		  (ctx->cached_cq_tail + atomic_read(&ctx->cached_cq_overflow));
>>> +	return inflight >= 2 * IORING_MAX_CQ_ENTRIES;
>>> +}
>>
>> ctx->cached_cq_tail protected by ctx->completion_lock and can be
>> changed asynchronously. That's a not synchronised access, so
>> formally (probably) breaks the memory model.
>>
>> False values shouldn't be a problem here, but anyway.
>>
> 
> Took a glance, it seems access to cached_cq_tail is already messed up in
> other places. Do I miss something?

It doesn't really matter for cases that don't need a stable value,
like this one right here. It's an integer, so it's not like we'll
ever see a fractured value, at most it'll be a bit stale.

-- 
Jens Axboe

