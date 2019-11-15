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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC796C432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 09:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF53E20740
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 09:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce2qb43G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfKOJtM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:49:12 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45880 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfKOJtM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 04:49:12 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so9961396ljg.12
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 01:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e7kAPS7eez8rQqIGwcd+UKMalthSaV/noYS5Lhl1HUs=;
        b=ce2qb43GF99DMj0n3PTDiWjnuKslFJ/kftIj4zpLncXZs92ASECziEH2nPmntN8LSi
         bRdFQIxkhVwiEIRMYyHz/dNjVMddgTyJpppRxaPOPp4NGpbt4+np5o4CwlI4Oyl7lLhx
         LfRM9Mavxfccmv76IzJ4Po81cnmLFedWAUbvkCi1+ilD7MZ/fbWdvC311E/xHnmIWOtL
         TqOhut/aTVE6ZHlfz4lCjX+/qy1iezTmna0IdtvPeFNw7jb7Di7AAQakVo588sdv9u5k
         /ugSohRS3GcEjT6Hsl2ekc4w5iRUd52xzbxkQRan2nBITRIahMHIqgH7e2LfV8b8JFgw
         7LZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e7kAPS7eez8rQqIGwcd+UKMalthSaV/noYS5Lhl1HUs=;
        b=ikrAdOG0R2I9qsURtNjAOQPyTInBjxKr0K7ivF5OVK2JsgF6BUPFtVqIcJmcARhcwc
         WNM5Dac9aJj0UXlf7CH/0NFOUz95v6WrjDiQqGCaIYhSfORoERDD5J7REHcc+Qo2LDXK
         AjLzRA4aW5qzRDV24+2F831ODm+3G06/hLFdLwq4vmq3OfxGXMwOvf/mST7CednTNPzC
         VtXkg5pCT/rHgrT8CwhPpdsiVQGTQbwJN5sZHbp/8veatc2Hm00u1gkbbaC4F+V8Vood
         PU7TYqkS5NSMts91vC4V1D6gj4jBNH78UkmQF44TJtWAMFQoO+choP2QHNUlkikjcALl
         Si8Q==
X-Gm-Message-State: APjAAAVzr3yR+pcxo3Yi1zc+AGzlQUmpuuYX7YGJnqQxPGXhD9ADSW1V
        AIokg/rH1ir0DofC10NKeUlCZDvi
X-Google-Smtp-Source: APXvYqwtekdoRkbQEIDAjCyEUzNxq2Qta/PstDevczjzuI0O9DiS6yDFAKIs0PP0uotizW9D9mz7pA==
X-Received: by 2002:a2e:8608:: with SMTP id a8mr10583043lji.172.1573811349814;
        Fri, 15 Nov 2019 01:49:09 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id m6sm3732655ljj.49.2019.11.15.01.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:49:09 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix duplicated increase of cached_cq_overflow
To:     Bob Liu <bob.liu@oracle.com>, axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
References: <20191115093733.18396-1-bob.liu@oracle.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <9ba5abd2-94c2-585a-b55c-d97dc5f429a6@gmail.com>
Date:   Fri, 15 Nov 2019 12:49:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191115093733.18396-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/15/2019 12:37 PM, Bob Liu wrote:
> cached_cq_overflow already be increased in function
> io_cqring_overflow_flush().
> 
> Signed-off-by: Bob Liu <bob.liu@oracle.com>
> ---
>  fs/io_uring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 55f8b1d..eb23451 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -701,7 +701,7 @@ static void io_cqring_fill_event(struct io_kiocb *req, long res)
>  		WRITE_ONCE(cqe->flags, 0);
>  	} else if (ctx->cq_overflow_flushed) {
>  		WRITE_ONCE(ctx->rings->cq_overflow,
> -				atomic_inc_return(&ctx->cached_cq_overflow));
> +				atomic_read(&ctx->cached_cq_overflow));

Not really. It won't get into io_cqring_overflow_flush() if this branch
is executed. See, it's enqueued for overflow in "else" right below.

i.e. list_add_tail(&req->list, &ctx->cq_overflow_list);

>  	} else {
>  		refcount_inc(&req->refs);
>  		req->result = res;
> 

-- 
Pavel Begunkov
