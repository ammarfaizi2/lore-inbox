Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1EAC432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 11:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B37520740
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 11:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILmxqe0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfKYLXC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:23:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36850 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfKYLXC (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 06:23:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15so15387891lja.3
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 03:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JRGj/1NeM6lIm5zK1y8p9V68ab04/7SiKUzxkb3LUSk=;
        b=ILmxqe0OL1109x3HcNHUb4+V3i4Gqju/kiAR1SU3aG0Zt4c/eQvWHa/WmESYXIlMvB
         dwuEsG0FIk/ezQToys/3670l7KJcdE+OB4ZRRlE/tpbP/fnw+K9opIx5MeNvcPG8GxOm
         HKNincgJf2LuwTyzW9qAc8jsg4JbiJZToLLpsXyTAewVYvfSDm1Laf2YV4Rrnk4eC7PT
         gpvX8qxdUJ6skO3T7he3BffEkRvwoPDFFXvqpjMYWyUqpE+0/xC6NdR90KDokCBeb/Lp
         CCyNV070dqp4GxNHUhNCTPRjYgrwA7zA7coAji6BXugPtiYitPqhzgdyTFUzlCgstFnU
         /6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JRGj/1NeM6lIm5zK1y8p9V68ab04/7SiKUzxkb3LUSk=;
        b=A66gyr5J7lNIFZmhu3FQa2MyrBM2may7mr5Zp+OftT3h4I59CkNKlWKSrg5lJSfkau
         joQFu9gTUK2aBFGoVvLcEcSIJtN7rsPRdpJGE/51OO37oLLoIbaD+nowszkw8ThVjGdD
         oC5EVPzay+fBOIO9Geqgt/icysMv5ghhXNotw72tmr5K8YjCOF+6an1QwAPgopLzLrgp
         SSPGJwdpBGTfeBAGG7YTRJamh5RfZ7kh9sXPEcEqXOSEOPkUftcIXkylxzuZqDXW3jbA
         vSwZru/LR8erucHjGiC/PMvuhjgdqLiGDh6GlJ4yHJ3QQrTIgdmp7XnbP4Hmicvh5Rjd
         EOlQ==
X-Gm-Message-State: APjAAAW6TUL4Pbr8hqphikMu5etAUdSC0eQXe4cOGxRqr02VFhbQhbLY
        c3cjKRdFNfJdoBqZ30Q9SMxH3jJhj0U=
X-Google-Smtp-Source: APXvYqyw1qC9deu8thFMOMaW/I8TMXX9PzMpXdgCoEG+2Lqj+rN1YgnuBTLdGHnW5pzOjNT7Ip8Maw==
X-Received: by 2002:a2e:8805:: with SMTP id x5mr19720954ljh.44.1574680978737;
        Mon, 25 Nov 2019 03:22:58 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id a5sm3721641ljm.56.2019.11.25.03.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 03:22:58 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: introduce add/post_event_and_complete
 function
To:     Bob Liu <bob.liu@oracle.com>, axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
References: <20191125090412.24045-1-bob.liu@oracle.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <9d6eba49-2212-88fa-5f22-0b8e832d0f3e@gmail.com>
Date:   Mon, 25 Nov 2019 14:22:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191125090412.24045-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/25/2019 12:04 PM, Bob Liu wrote:
> * Only complie-tested right now. *
> There are many duplicated code doing add/post event, set REQ_F_FAIL_LINK and
> then put req. Put them into common funcs io_cqring_event_posted_and_complete()
> and io_cqring_add_event_and_complete().

There are some comments below. This one looks much better, but I think,
it's still not self-expressing enough. And it looks like
io_cqring_add_event_and_complete() is doing 2 orthogonal things, mostly
because we anyway need to do 2+ puts() for a single request.

How about to try extract something like io_fail_event(req, err_code)
first, which fails it unconditionally? As you noticed, in the most cases
setting REQ_F_FAIL_LINK is followed by io_cqring_add_event().

It may also be interesting to set REQ_F_FAIL_LINK for all request types,
not only for linked (i.e. REQ_F_FAIL). This may (or may not...) prove to
be clearer.

> 
> Signed-off-by: Bob Liu <bob.liu@oracle.com>
> ---
> Changes since v1:
> - Using FAIL_LINK_* enums.
> 
> ---
>  fs/io_uring.c | 131 +++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 65 insertions(+), 66 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 9f9c2d4..d91864e 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -363,6 +363,12 @@ struct io_kiocb {
>  	struct io_wq_work	work;
>  };
>  
> +enum set_f_fail_link {
> +	FAIL_LINK_NONE,
> +	FAIL_LINK_ON_NEGATIVE,
> +	FAIL_LINK_ON_NOTEQUAL_RES,
> +	FAIL_LINK_ALWAYS,
> +};
>  #define IO_PLUG_THRESHOLD		2
>  #define IO_IOPOLL_BATCH			8
>  
> @@ -1253,34 +1259,66 @@ static void kiocb_end_write(struct io_kiocb *req)
>  	file_end_write(req->file);
>  }
>  
> -static void io_complete_rw_common(struct kiocb *kiocb, long res)
> +void set_f_fail_link(struct io_kiocb *req, long ret, unsigned int fail_link)
> +{

if (!(req->flags & REQ_F_LINK))
	return;

Less bulky and is good for fast-path. And this single check
_should_ be inlined. Could you check assembly for that?

> +	if (fail_link == FAIL_LINK_ALWAYS) {
> +		if (req->flags & REQ_F_LINK)
> +			req->flags |= REQ_F_FAIL_LINK;
> +	} else if (fail_link == FAIL_LINK_ON_NEGATIVE) {
> +		if (ret < 0 && (req->flags & REQ_F_LINK))
> +			req->flags |= REQ_F_FAIL_LINK;
> +	} else if (fail_link == FAIL_LINK_ON_NOTEQUAL_RES) {
> +		if ((ret != req->result) && (req->flags & REQ_F_LINK))
> +			req->flags |= REQ_F_FAIL_LINK;
> +	}
> +}
> +
> +static void io_cqring_add_event_and_complete(struct io_kiocb *req, long ret,
> +		unsigned int fail_link, struct io_kiocb **nxt)

io_cqring_add_event_and_put() maybe?
That's what it really do.

> +{
> +	set_f_fail_link(req, ret, fail_link);
> +	io_cqring_add_event(req, ret);
> +
> +	if (nxt)
> +		io_put_req_find_next(req, nxt);

Just removed this pattern with possible nxt==NULL.
It always tends getting nested multiplying such checks.

> +	else
> +		io_put_req(req);
> +}
> +
> +static void io_cqring_ev_posted_and_complete(struct io_kiocb *req, long ret,
> +		unsigned int fail_link, struct io_kiocb **nxt)
> +{
> +	io_cqring_ev_posted(req->ctx);
> +	set_f_fail_link(req, ret, fail_link);
> +
> +	if (nxt)
> +		io_put_req_find_next(req, nxt);
> +	else
> +		io_put_req(req);
> +}
> +
> +static void io_complete_rw_common(struct kiocb *kiocb, long res,
> +		struct io_kiocb **nxt)
>  {
>  	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
>  
>  	if (kiocb->ki_flags & IOCB_WRITE)
>  		kiocb_end_write(req);
>  
> -	if ((req->flags & REQ_F_LINK) && res != req->result)
> -		req->flags |= REQ_F_FAIL_LINK;
> -	io_cqring_add_event(req, res);
> +	io_cqring_add_event_and_complete(req, res,
> +			FAIL_LINK_ON_NOTEQUAL_RES, nxt);
>  }
>  
>  static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
>  {
> -	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
> -
> -	io_complete_rw_common(kiocb, res);
> -	io_put_req(req);
> +	io_complete_rw_common(kiocb, res, NULL);
>  }
>  
>  static struct io_kiocb *__io_complete_rw(struct kiocb *kiocb, long res)
>  {
> -	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
>  	struct io_kiocb *nxt = NULL;
>  
> -	io_complete_rw_common(kiocb, res);
> -	io_put_req_find_next(req, &nxt);
> -
> +	io_complete_rw_common(kiocb, res, &nxt);
>  	return nxt;
>  }
>  
> @@ -1831,10 +1869,7 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>  				end > 0 ? end : LLONG_MAX,
>  				fsync_flags & IORING_FSYNC_DATASYNC);
>  
> -	if (ret < 0 && (req->flags & REQ_F_LINK))
> -		req->flags |= REQ_F_FAIL_LINK;
> -	io_cqring_add_event(req, ret);
> -	io_put_req_find_next(req, nxt);
> +	io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, nxt);
>  	return 0;
>  }
>  
> @@ -1878,10 +1913,7 @@ static int io_sync_file_range(struct io_kiocb *req,
>  
>  	ret = sync_file_range(req->rw.ki_filp, sqe_off, sqe_len, flags);
>  
> -	if (ret < 0 && (req->flags & REQ_F_LINK))
> -		req->flags |= REQ_F_FAIL_LINK;
> -	io_cqring_add_event(req, ret);
> -	io_put_req_find_next(req, nxt);
> +	io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, nxt);
>  	return 0;
>  }
>  
> @@ -1916,10 +1948,7 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>  			return ret;
>  	}
>  
> -	io_cqring_add_event(req, ret);
> -	if (ret < 0 && (req->flags & REQ_F_LINK))
> -		req->flags |= REQ_F_FAIL_LINK;
> -	io_put_req_find_next(req, nxt);
> +	io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, nxt);
>  	return 0;
>  }
>  #endif
> @@ -1972,10 +2001,7 @@ static int io_accept(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>  	}
>  	if (ret == -ERESTARTSYS)
>  		ret = -EINTR;
> -	if (ret < 0 && (req->flags & REQ_F_LINK))
> -		req->flags |= REQ_F_FAIL_LINK;
> -	io_cqring_add_event(req, ret);
> -	io_put_req_find_next(req, nxt);
> +	io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, nxt);
>  	return 0;
>  #else
>  	return -EOPNOTSUPP;
> @@ -2005,10 +2031,8 @@ static int io_connect(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>  		return -EAGAIN;
>  	if (ret == -ERESTARTSYS)
>  		ret = -EINTR;
> -	if (ret < 0 && (req->flags & REQ_F_LINK))
> -		req->flags |= REQ_F_FAIL_LINK;
> -	io_cqring_add_event(req, ret);
> -	io_put_req_find_next(req, nxt);
> +
> +	io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, nxt);
>  	return 0;
>  #else
>  	return -EOPNOTSUPP;
> @@ -2091,10 +2115,7 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  	ret = io_poll_cancel(ctx, READ_ONCE(sqe->addr));
>  	spin_unlock_irq(&ctx->completion_lock);
>  
> -	io_cqring_add_event(req, ret);
> -	if (ret < 0 && (req->flags & REQ_F_LINK))
> -		req->flags |= REQ_F_FAIL_LINK;
> -	io_put_req(req);
> +	io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, NULL);
>  	return 0;
>  }
>  
> @@ -2148,11 +2169,7 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
>  	io_poll_complete(req, mask, ret);
>  	spin_unlock_irq(&ctx->completion_lock);
>  
> -	io_cqring_ev_posted(ctx);
> -
> -	if (ret < 0 && req->flags & REQ_F_LINK)
> -		req->flags |= REQ_F_FAIL_LINK;
> -	io_put_req_find_next(req, &nxt);
> +	io_cqring_ev_posted_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, &nxt);
>  	if (nxt)
>  		*workptr = &nxt->work;
>  }
> @@ -2338,10 +2355,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
>  	io_commit_cqring(ctx);
>  	spin_unlock_irqrestore(&ctx->completion_lock, flags);
>  
> -	io_cqring_ev_posted(ctx);
> -	if (req->flags & REQ_F_LINK)
> -		req->flags |= REQ_F_FAIL_LINK;
> -	io_put_req(req);
> +	io_cqring_ev_posted_and_complete(req, 0, FAIL_LINK_ALWAYS, NULL);
>  	return HRTIMER_NORESTART;
>  }
>  
> @@ -2396,10 +2410,7 @@ static int io_timeout_remove(struct io_kiocb *req,
>  	io_cqring_fill_event(req, ret);
>  	io_commit_cqring(ctx);
>  	spin_unlock_irq(&ctx->completion_lock);
> -	io_cqring_ev_posted(ctx);
> -	if (ret < 0 && req->flags & REQ_F_LINK)
> -		req->flags |= REQ_F_FAIL_LINK;
> -	io_put_req(req);
> +	io_cqring_ev_posted_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, NULL);
>  	return 0;
>  }
>  
> @@ -2560,11 +2571,7 @@ static void io_async_find_and_cancel(struct io_ring_ctx *ctx,
>  	io_cqring_fill_event(req, ret);
>  	io_commit_cqring(ctx);
>  	spin_unlock_irqrestore(&ctx->completion_lock, flags);
> -	io_cqring_ev_posted(ctx);
> -
> -	if (ret < 0 && (req->flags & REQ_F_LINK))
> -		req->flags |= REQ_F_FAIL_LINK;
> -	io_put_req_find_next(req, nxt);
> +	io_cqring_ev_posted_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, nxt);
>  }
>  
>  static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
> @@ -2738,12 +2745,8 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
>  	/* drop submission reference */
>  	io_put_req(req);
>  
> -	if (ret) {
> -		if (req->flags & REQ_F_LINK)
> -			req->flags |= REQ_F_FAIL_LINK;
> -		io_cqring_add_event(req, ret);
> -		io_put_req(req);
> -	}
> +	if (ret)
> +		io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ALWAYS, NULL);
>  
>  	/* if a dependent link is ready, pass it back */
>  	if (!ret && nxt) {
> @@ -2981,12 +2984,8 @@ static void __io_queue_sqe(struct io_kiocb *req)
>  	}
>  
>  	/* and drop final reference, if we failed */
> -	if (ret) {
> -		io_cqring_add_event(req, ret);
> -		if (req->flags & REQ_F_LINK)
> -			req->flags |= REQ_F_FAIL_LINK;
> -		io_put_req(req);
> -	}
> +	if (ret)
> +		io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ALWAYS, NULL);
>  }
>  
>  static void io_queue_sqe(struct io_kiocb *req)
> 

-- 
Pavel Begunkov
