Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE989C432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 12:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B658E20728
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 12:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvjA6vZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfKOMlJ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:41:09 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33128 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKOMlJ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 07:41:09 -0500
Received: by mail-lf1-f65.google.com with SMTP id d6so7939640lfc.0
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 04:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lpm1lb6luFvxC3CsJmbg08zN4tb5oNH8xvG1aho6KA4=;
        b=VvjA6vZgLKjMKxmwGylRwma4o7jQG0J3ixOpHBYMXI4NA9ct8dI8FNYaHDmirFZaDL
         5LEYcSj1ZEEPyOn/6CussBYeCd8nAUntNiV7PlDg6hgwz5cMMqHQWgf/y4ImwrjjRKgY
         z3YhGoFU8m0hxmYAEZZw/U7faAJRPle5XjEWqzmn8YeK5UevUr8DGUeRfV4mxeoDti7M
         +oZtzORYKRUqbDD+i0wKCLgHsBYG/YU+RwJRYsJO0gdTkM1ca0CUz51b46/u700dfR9U
         gJuqw+PD5Smz6b1qH2oBVCLKtozfeZgTPPsZsCNzskdJC+ebOTBRD0NIo3zk5+Fp9xt5
         yRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lpm1lb6luFvxC3CsJmbg08zN4tb5oNH8xvG1aho6KA4=;
        b=eTOiDA5dcJoi7nH/coa6eHn77U/0Te2luIyxdnsJXdrKIdIh5/BjIb64uxpo6CzC0P
         G2YuHCSwBSgINN7uIfFntUvIHTS8DfpjtI94lPLwpk5b/3gbL3smfWXTqaz9E4fl4XVB
         sD/v+pZfDdD/uTNfAVScfaTuGsmP4ggT3c/aL9YUp9WShN+OWjDkA49n106TIWSxqNUH
         D4ECqTk52BYrkEl4pW1VJw3a+CebH71qq3z6CCNVwPA0fk8/YsHwQNWNMdhPzZOk1bg5
         0IZRN52H/w1T7reUI+GreKDFPbOFhLJ0jgWewj/dJQ0Dx0DBv3NH1msJE1JyuhoFW5xy
         tEhw==
X-Gm-Message-State: APjAAAWdq+yLDeX5lZfIQz7Bo2zVvEvLmOTU/HnkhHd76q++fylPBsFh
        /a/fVeo+2HDJU10C+T75MHLNZlmi
X-Google-Smtp-Source: APXvYqyk5OPjdGRgD0Kvt9LgkB5KHAJ7zNdiBveyA6C7HD9PgWoUNv4hqVgraKRDGlqA1QDadHb7Dg==
X-Received: by 2002:ac2:5a11:: with SMTP id q17mr11355803lfn.41.1573821665670;
        Fri, 15 Nov 2019 04:41:05 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id v2sm4317873lfb.50.2019.11.15.04.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 04:41:05 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix duplicated increase of cached_cq_overflow
To:     Bob Liu <bob.liu@oracle.com>, axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
References: <20191115093733.18396-1-bob.liu@oracle.com>
 <9ba5abd2-94c2-585a-b55c-d97dc5f429a6@gmail.com>
 <7ed5d143-c9ba-7d0a-03fe-57af65e88a54@oracle.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <c88f9b89-4749-fd3b-0ac8-e6824077ec26@gmail.com>
Date:   Fri, 15 Nov 2019 15:41:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <7ed5d143-c9ba-7d0a-03fe-57af65e88a54@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/15/2019 3:17 PM, Bob Liu wrote:
> On 11/15/19 5:49 PM, Pavel Begunkov wrote:
>> On 11/15/2019 12:37 PM, Bob Liu wrote:
>>> cached_cq_overflow already be increased in function
>>> io_cqring_overflow_flush().
>>>
>>> Signed-off-by: Bob Liu <bob.liu@oracle.com>
>>> ---
>>>  fs/io_uring.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index 55f8b1d..eb23451 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -701,7 +701,7 @@ static void io_cqring_fill_event(struct io_kiocb *req, long res)
>>>  		WRITE_ONCE(cqe->flags, 0);
>>>  	} else if (ctx->cq_overflow_flushed) {
>>>  		WRITE_ONCE(ctx->rings->cq_overflow,
>>> -				atomic_inc_return(&ctx->cached_cq_overflow));
>>> +				atomic_read(&ctx->cached_cq_overflow));
>>
>> Not really. It won't get into io_cqring_overflow_flush() if this branch
>> is executed. 
> 
> io_cqring_overflow_flush(force=true) must have been called when this branch is executed,
> since io_cqring_overflow_flush() is the only place can set 'ctx->cq_overflow_flushed' to true.
> 
Yes, it should have been called, but it sets this flag for the future
users of io_cqring_fill_event(), so any _new_ requests in
io_cqring_fill_event() will overflow instead of being added to
@overflow_list.

Either a request completes/overflows in io_cqring_fill_event(),
or it would be added to @overflow_list to be processed by
io_cqring_overflow_flush().


> And 'ctx->cached_cq_overflow' may already be increased in io_cqring_overflow_flush() if force is true and cqe==NULL.
> 
> static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
> {
> 	...
>         if (force)
>                 ctx->cq_overflow_flushed = true;
>                 
>         while (!list_empty(&ctx->cq_overflow_list)) {
>                 cqe = io_get_cqring(ctx);
>                 if (!cqe && !force)
>                         break;
>                         
>                 req = list_first_entry(&ctx->cq_overflow_list, struct io_kiocb,
>                                                 list);
>                 list_move(&req->list, &list);   
>                 if (cqe) {
> 			...
>                 } else {
>                         WRITE_ONCE(ctx->rings->cq_overflow,
>                                 atomic_inc_return(&ctx->cached_cq_overflow));
> 			  ^^^^^^^^^^^
> 			  ctx->cached_cq_overflow is increased if 'force=true' and 'ceq==NULL'.
> 
> 
> Did I miss anything?
> 
>> See, it's enqueued for overflow in "else" right below.
>>
>> i.e. list_add_tail(&req->list, &ctx->cq_overflow_list);
>>
>>>  	} else {
>>>  		refcount_inc(&req->refs);
>>>  		req->result = res;
>>>
> 
