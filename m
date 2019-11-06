Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64630C5DF62
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 09:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E4A2075C
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 09:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg2a+bBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfKFJbi (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:31:38 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36056 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfKFJbh (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 04:31:37 -0500
Received: by mail-lf1-f65.google.com with SMTP id m6so1342366lfl.3;
        Wed, 06 Nov 2019 01:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zQ7HLJOmb7PEV7Bvvm45eQnx60eQFp2jSB+Y921nCUk=;
        b=eg2a+bBvdRXPs3ywIvinqtswuKGtIjM3Kpupd49H5FyQfG3SEuWCvLceKny75NZ3zE
         T3p+FozOLa57+VfXVuRngSe7loSgYAceIz9wTfK2N+ZpdwSd0uzHWG6Mn+zk8YnyJKfo
         UEfShFAF+mFZgCvPUoN02dE9okO4wvE/MrfqjP4bRg7mACZkFwBdmXGhOgkN9WczBrEu
         MUYViRSzjU70GkW0Dxs5xCpqogVlE2A0lXHKNSjk/7fUy631+zouv9Phvr1n049CbwHw
         3q2S6Yy7Up1HZizZFP4Jfjfw41oY7mi6nuan/MDSEsOFNsGfYppzEG37CVnpylHNWyWe
         TMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zQ7HLJOmb7PEV7Bvvm45eQnx60eQFp2jSB+Y921nCUk=;
        b=Bjhn7aHzxjW78dmhnbImO416TP/gNv0iBHjnhHmxM6I7Mp8kGRd14m+H/vdPNJZzML
         GBaYz8I9Dar9uOLK2zmp8XGbWoEcxPRsp2bfH7Udh5nOi7JnDKaGyzg8elfPJqb0N8p5
         f46Lx4ZDZUwnlz/8fS3YONAqpjlyl+CbvqypS9ZcqDOZCQACS0evfj4cc/PZRRjklRvZ
         UyxlnT9+/Jo/TFI90vb8NtXoiYNade/Q0DuNvkQPgQo72rbOGAy+B+A5xHYnbTjkniOF
         dWYvpNfVuX8olGsZPPLaylIf9EP6vcLkpv5cV/fFqo12CeCHi9WX9iC9l3LB/5rJ1dr9
         lsLg==
X-Gm-Message-State: APjAAAUjOrEKltVwYfI+Zce9hQ7zmfJk0ZCrPS8g83qopF4z7iOx24Vw
        ixed677FhuLnlpB2/h5WQFoZMoqThto=
X-Google-Smtp-Source: APXvYqzB/Bb4P5TC2qQgP/75MMq896H2nD6KTG/h3yqawbV/cFlVsyQ5UVbo2com+mpYyQs+W7WWIA==
X-Received: by 2002:a19:48cf:: with SMTP id v198mr8457177lfa.59.1573032694930;
        Wed, 06 Nov 2019 01:31:34 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id g5sm9288178ljn.101.2019.11.06.01.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:31:34 -0800 (PST)
Subject: Re: [PATCH v2 2/2] io_uring: io_queue_link*() right after submit
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Bob Liu <bob.liu@oracle.com>, Jens Axboe <axboe@kernel.dk>,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1572988512.git.asml.silence@gmail.com>
 <85a316b577e1b5204d27a96a7ce452ed6be3c2ae.1572988512.git.asml.silence@gmail.com>
 <8700c9a3-01aa-2af6-c275-1f17734c2cc5@oracle.com>
 <81c2db6f-e262-328a-5917-71b30d9390a5@gmail.com>
Message-ID: <2600cd84-a953-734c-1972-2c6ae0125ce5@gmail.com>
Date:   Wed, 6 Nov 2019 12:31:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <81c2db6f-e262-328a-5917-71b30d9390a5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/6/2019 12:06 PM, Pavel Begunkov wrote:
> On 11/6/2019 11:36 AM, Bob Liu wrote:
>> On 11/6/19 5:22 AM, Pavel Begunkov wrote:
>>> After a call to io_submit_sqe(), it's already known whether it needs
>>> to queue a link or not. Do it there, as it's simplier and doesn't keep
>>> an extra variable across the loop.
>>>
>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>> ---
>>>  fs/io_uring.c | 22 ++++++++++------------
>>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index ebe2a4edd644..82c2da99cb5c 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -2687,7 +2687,6 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>>>  	struct io_submit_state state, *statep = NULL;
>>>  	struct io_kiocb *link = NULL;
>>>  	struct io_kiocb *shadow_req = NULL;
>>> -	bool prev_was_link = false;
>>>  	int i, submitted = 0;
>>>  	bool mm_fault = false;
>>>  
>>> @@ -2710,17 +2709,6 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>>>  			}
>>>  		}
>>>  
>>> -		/*
>>> -		 * If previous wasn't linked and we have a linked command,
>>> -		 * that's the end of the chain. Submit the previous link.
>>> -		 */
>>> -		if (!prev_was_link && link) {
>>> -			io_queue_link_head(ctx, link, &link->submit, shadow_req);
>>> -			link = NULL;
>>> -			shadow_req = NULL;
>>> -		}
>>> -		prev_was_link = (s.sqe->flags & IOSQE_IO_LINK) != 0;
>>> -
>>>  		if (link && (s.sqe->flags & IOSQE_IO_DRAIN)) {
>>>  			if (!shadow_req) {
>>>  				shadow_req = io_get_req(ctx, NULL);
>>> @@ -2741,6 +2729,16 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>>>  		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, async);
>>>  		io_submit_sqe(ctx, &s, statep, &link);
>>>  		submitted++;
>>> +
>>> +		/*
>>> +		 * If previous wasn't linked and we have a linked command,
>>> +		 * that's the end of the chain. Submit the previous link.
>>> +		 */
>>> +		if (!(s.sqe->flags & IOSQE_IO_LINK) && link) 
>> The behavior changed to 'current seq' instead of previous after dropping prev_was_link?
>>
> The old behaviour was to remember @prev_was_link for current sqe, and
> use at the beginning of the next iteration, where it becomes
> "previous/last sqe". See, prev_was_link was set after io_queue_link_head.
> 
> If @i is iteration idx, then timeline was:
> i:   sqe[i-1].is_link -> io_queue_link_head() # if (prev_was_link)
> i:   sqe[i].is_link = prev_was_link = (sqe[i].flags & LINK)
> i+1: sqe[i].is_link -> io_queue_link_head() # if (prev_was_link)
> i+1: sqe[i+1].is_link = ...
> 
> 
> After the change, it's done at the same loop iteration by swapping order
> of checking @prev_was_link and io_queue_link_head().
> 
> i:   sqe[i].is_link = ...
> i:   sqe[i].is_link -> io_queue_link_head()
> i+1: sqe[i+1].is_link = ...
> i+1: sqe[i+1].is_link -> io_queue_link_head()
> 
> Shouldn't change the behavior, if I'm not missing something.
> 
And the same goes for ordering with io_submit_sqe(), which assembles a link.

i:   prev_was_link = ... # for sqe[i]
i:   io_submit_sqe() # for sqe[i]
i+1: prev_was_link -> io_queue_link_head # for sqe[i]

after:
i:   io_submit_sqe() # for sqe[i]
i:   is_link = ... # for sqe[i]
i:   is_link -> io_queue_link_head # for sqe[i]

> 
>>> +			io_queue_link_head(ctx, link, &link->submit, shadow_req);
>>> +			link = NULL;
>>> +			shadow_req = NULL;
>>> +		}
>>>  	}
>>>  
>>>  	if (link)
>>>
>>
