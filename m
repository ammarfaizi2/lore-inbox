Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6B5C5DF61
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 09:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716022084D
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 09:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlQtNAwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfKGJyJ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:54:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40178 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGJyI (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 04:54:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id f3so1640639wmc.5;
        Thu, 07 Nov 2019 01:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=XC6jMIiHUOZN1HXNHwaa9KYwCx3ms+D57ovfa6r4pT8=;
        b=IlQtNAwEiyATg/l8dwSvz/Q6JPysJwUnkU+SEBvzsMzV5MyQoZK8R2i+oEjgdRrKvp
         vNEjDUWl4i7qgiH1gmBrBP9H2hUUaSTnYlsQgm9Bho7Gi7m8eJvV/tyoppmJD2fFaXNx
         EzzWn9JAQcL8KOycvYZYsmZOB0ijyEn08iWvJKznMhD3S6xBxwJsKqZXG590tFLF9TG4
         EI5/wiEL6nDfabLp1Wrrrx1fnjEv+sqQ0HX59W8xqHnioAOoERxwxRIzo2HPUB3gClXT
         vdoYnTEH5CSLRTn+uRldnoX+/x4kLrWUWwfvWLATBDrjScPc7WH+yEf6+MgPwK5v8H+L
         3K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=XC6jMIiHUOZN1HXNHwaa9KYwCx3ms+D57ovfa6r4pT8=;
        b=oXIubz1s5os9iFY5KAOJIOrm/z7rafmpDNwfL+Ols6t6nJAph/eqvpVX05UAOVfLA5
         IlOmxCIX55VZNXzOp10a5X/fHcFsHfndBUrfPd8ZnGPXwGJJJ6TtjXWx43vrgLr3yj/t
         Z2oTZqUBEvhjLexTCseVlq6j+v0QPAdmARgQBzMhNExDQ8VAMFB2LO93d2/CfyEOlfPn
         Af1C3CTUssmg6g5epD500FQm2KzyL7VA0sa6fRMWzL4zQc6lOUgy8yo/B0cHhQ3EwdSn
         XGPWLt8sKpgjwrpA4FhUcWCENF/WrNIt3ZNSjqyUyTnkGzSXNcpf8pE8zS+mYSzF0Onf
         P8ug==
X-Gm-Message-State: APjAAAXDy/HqMT21TCBHRikOEsKzpDYOnme9g/zQXssvVfvr+4mVvN05
        EqOM9LINd+gvjXrrCtJoJBXkbL9z
X-Google-Smtp-Source: APXvYqw0rp8o7B62GWTK0AzQ07vrFn82d3oOLg1sA40YakRBh4mWXwfTXdfaaciuVcZ4zi+4QTJKLg==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr2042926wml.41.1573120444144;
        Thu, 07 Nov 2019 01:54:04 -0800 (PST)
Received: from [192.168.43.132] ([109.126.148.209])
        by smtp.gmail.com with ESMTPSA id g133sm1437535wme.42.2019.11.07.01.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 01:54:03 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, jannh@google.com
References: <20191106235307.32196-1-axboe@kernel.dk>
 <20191106235307.32196-3-axboe@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 2/3] io_uring: pass in io_kiocb to fill/add CQ handlers
Message-ID: <df4352ab-2670-e69f-cc92-5e72f1cd6229@gmail.com>
Date:   Thu, 7 Nov 2019 12:53:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106235307.32196-3-axboe@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GeAi5oeSJwPjkomrzlDWWHE4lWZEFonzs"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GeAi5oeSJwPjkomrzlDWWHE4lWZEFonzs
Content-Type: multipart/mixed; boundary="xiHYN1cE44ribps7guhAfpnYHIVRrlw4s";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, jannh@google.com
Message-ID: <df4352ab-2670-e69f-cc92-5e72f1cd6229@gmail.com>
Subject: Re: [PATCH 2/3] io_uring: pass in io_kiocb to fill/add CQ handlers
References: <20191106235307.32196-1-axboe@kernel.dk>
 <20191106235307.32196-3-axboe@kernel.dk>
In-Reply-To: <20191106235307.32196-3-axboe@kernel.dk>

--xiHYN1cE44ribps7guhAfpnYHIVRrlw4s
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/11/2019 02:53, Jens Axboe wrote:
> This is in preparation for handling CQ ring overflow a bit smarter. We
> should not have any functional changes in this patch. Most of the chang=
es
> are fairly straight forward, the only ones that stick out a bit are the=

> ones that change:
>=20
> __io_free_req()
>=20
> to a double io_put_req(). If the request hasn't been submitted yet, we
> know it's safe to simply ignore references and free it. But let's clean=

> these up too, as later patches will depend on the caller doing the righ=
t
> thing if the completion logging grabs a reference to the request.
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/io_uring.c | 90 +++++++++++++++++++++++++--------------------------=

>  1 file changed, 45 insertions(+), 45 deletions(-)
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 36ca7bc38ebf..fb621a564dcf 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -369,8 +369,7 @@ struct io_submit_state {
>  };
> =20
>  static void io_wq_submit_work(struct io_wq_work **workptr);
> -static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_=
data,
> -				 long res);
> +static void io_cqring_fill_event(struct io_kiocb *req, long res);
>  static void __io_free_req(struct io_kiocb *req);
>  static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr)=
;
> =20
> @@ -535,8 +534,8 @@ static void io_kill_timeout(struct io_kiocb *req)
>  	if (ret !=3D -1) {
>  		atomic_inc(&req->ctx->cq_timeouts);
>  		list_del_init(&req->list);
> -		io_cqring_fill_event(req->ctx, req->user_data, 0);
> -		__io_free_req(req);
> +		io_cqring_fill_event(req, 0);
> +		io_put_req(req, NULL);
>  	}
>  }
> =20
> @@ -588,12 +587,12 @@ static struct io_uring_cqe *io_get_cqring(struct =
io_ring_ctx *ctx)
>  	return &rings->cqes[tail & ctx->cq_mask];
>  }
> =20
> -static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_=
data,
> -				 long res)
> +static void io_cqring_fill_event(struct io_kiocb *req, long res)
>  {
> +	struct io_ring_ctx *ctx =3D req->ctx;
>  	struct io_uring_cqe *cqe;
> =20
> -	trace_io_uring_complete(ctx, ki_user_data, res);
> +	trace_io_uring_complete(ctx, req->user_data, res);
> =20
>  	/*
>  	 * If we can't get a cq entry, userspace overflowed the
> @@ -602,7 +601,7 @@ static void io_cqring_fill_event(struct io_ring_ctx=
 *ctx, u64 ki_user_data,
>  	 */
>  	cqe =3D io_get_cqring(ctx);
>  	if (cqe) {
> -		WRITE_ONCE(cqe->user_data, ki_user_data);
> +		WRITE_ONCE(cqe->user_data, req->user_data);
>  		WRITE_ONCE(cqe->res, res);
>  		WRITE_ONCE(cqe->flags, 0);
>  	} else {
> @@ -621,13 +620,13 @@ static void io_cqring_ev_posted(struct io_ring_ct=
x *ctx)
>  		eventfd_signal(ctx->cq_ev_fd, 1);
>  }
> =20
> -static void io_cqring_add_event(struct io_ring_ctx *ctx, u64 user_data=
,
> -				long res)
> +static void io_cqring_add_event(struct io_kiocb *req, long res)
>  {
> +	struct io_ring_ctx *ctx =3D req->ctx;
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&ctx->completion_lock, flags);
> -	io_cqring_fill_event(ctx, user_data, res);
> +	io_cqring_fill_event(req, res);
>  	io_commit_cqring(ctx);
>  	spin_unlock_irqrestore(&ctx->completion_lock, flags);
> =20
> @@ -721,10 +720,10 @@ static void io_link_cancel_timeout(struct io_ring=
_ctx *ctx,
> =20
>  	ret =3D hrtimer_try_to_cancel(&req->timeout.timer);
>  	if (ret !=3D -1) {
> -		io_cqring_fill_event(ctx, req->user_data, -ECANCELED);
> +		io_cqring_fill_event(req, -ECANCELED);
>  		io_commit_cqring(ctx);
>  		req->flags &=3D ~REQ_F_LINK;
> -		__io_free_req(req);
> +		io_put_req(req, NULL);
>  	}
>  }
> =20
> @@ -804,8 +803,10 @@ static void io_fail_links(struct io_kiocb *req)
>  		    link->submit.sqe->opcode =3D=3D IORING_OP_LINK_TIMEOUT) {
>  			io_link_cancel_timeout(ctx, link);
>  		} else {
> -			io_cqring_fill_event(ctx, link->user_data, -ECANCELED);
> -			__io_free_req(link);
> +			io_cqring_fill_event(link, -ECANCELED);
> +			/* drop both submit and complete references */
> +			io_put_req(link, NULL);
> +			io_put_req(link, NULL);

io_put_req() -> ... -> io_free_req() -> io_fail_links() -> io_put_req()

It shouldn't recurse further, but probably it would be better to avoid
it at all.


>  		}
>  	}
> =20
> @@ -891,7 +892,7 @@ static void io_iopoll_complete(struct io_ring_ctx *=
ctx, unsigned int *nr_events,
>  		req =3D list_first_entry(done, struct io_kiocb, list);
>  		list_del(&req->list);
> =20
> -		io_cqring_fill_event(ctx, req->user_data, req->result);
> +		io_cqring_fill_event(req, req->result);
>  		(*nr_events)++;
> =20
>  		if (refcount_dec_and_test(&req->refs)) {
> @@ -1087,7 +1088,7 @@ static void io_complete_rw_common(struct kiocb *k=
iocb, long res)
> =20
>  	if ((req->flags & REQ_F_LINK) && res !=3D req->result)
>  		req->flags |=3D REQ_F_FAIL_LINK;
> -	io_cqring_add_event(req->ctx, req->user_data, res);
> +	io_cqring_add_event(req, res);
>  }
> =20
>  static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
> @@ -1588,15 +1589,14 @@ static int io_write(struct io_kiocb *req, struc=
t io_kiocb **nxt,
>  /*
>   * IORING_OP_NOP just posts a completion event, nothing else.
>   */
> -static int io_nop(struct io_kiocb *req, u64 user_data)
> +static int io_nop(struct io_kiocb *req)
>  {
>  	struct io_ring_ctx *ctx =3D req->ctx;
> -	long err =3D 0;
> =20
>  	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
>  		return -EINVAL;
> =20
> -	io_cqring_add_event(ctx, user_data, err);
> +	io_cqring_add_event(req, 0);
>  	io_put_req(req, NULL);
>  	return 0;
>  }
> @@ -1643,7 +1643,7 @@ static int io_fsync(struct io_kiocb *req, const s=
truct io_uring_sqe *sqe,
> =20
>  	if (ret < 0 && (req->flags & REQ_F_LINK))
>  		req->flags |=3D REQ_F_FAIL_LINK;
> -	io_cqring_add_event(req->ctx, sqe->user_data, ret);
> +	io_cqring_add_event(req, ret);
>  	io_put_req(req, nxt);
>  	return 0;
>  }
> @@ -1690,7 +1690,7 @@ static int io_sync_file_range(struct io_kiocb *re=
q,
> =20
>  	if (ret < 0 && (req->flags & REQ_F_LINK))
>  		req->flags |=3D REQ_F_FAIL_LINK;
> -	io_cqring_add_event(req->ctx, sqe->user_data, ret);
> +	io_cqring_add_event(req, ret);
>  	io_put_req(req, nxt);
>  	return 0;
>  }
> @@ -1726,7 +1726,7 @@ static int io_send_recvmsg(struct io_kiocb *req, =
const struct io_uring_sqe *sqe,
>  			return ret;
>  	}
> =20
> -	io_cqring_add_event(req->ctx, sqe->user_data, ret);
> +	io_cqring_add_event(req, ret);
>  	if (ret < 0 && (req->flags & REQ_F_LINK))
>  		req->flags |=3D REQ_F_FAIL_LINK;
>  	io_put_req(req, nxt);
> @@ -1782,7 +1782,7 @@ static int io_accept(struct io_kiocb *req, const =
struct io_uring_sqe *sqe,
>  	}
>  	if (ret < 0 && (req->flags & REQ_F_LINK))
>  		req->flags |=3D REQ_F_FAIL_LINK;
> -	io_cqring_add_event(req->ctx, sqe->user_data, ret);
> +	io_cqring_add_event(req, ret);
>  	io_put_req(req, nxt);
>  	return 0;
>  #else
> @@ -1843,7 +1843,7 @@ static int io_poll_remove(struct io_kiocb *req, c=
onst struct io_uring_sqe *sqe)
>  	}
>  	spin_unlock_irq(&ctx->completion_lock);
> =20
> -	io_cqring_add_event(req->ctx, sqe->user_data, ret);
> +	io_cqring_add_event(req, ret);
>  	if (ret < 0 && (req->flags & REQ_F_LINK))
>  		req->flags |=3D REQ_F_FAIL_LINK;
>  	io_put_req(req, NULL);
> @@ -1854,7 +1854,7 @@ static void io_poll_complete(struct io_ring_ctx *=
ctx, struct io_kiocb *req,
>  			     __poll_t mask)
>  {
>  	req->poll.done =3D true;
> -	io_cqring_fill_event(ctx, req->user_data, mangle_poll(mask));
> +	io_cqring_fill_event(req, mangle_poll(mask));
>  	io_commit_cqring(ctx);
>  }
> =20
> @@ -2048,7 +2048,7 @@ static enum hrtimer_restart io_timeout_fn(struct =
hrtimer *timer)
>  		list_del_init(&req->list);
>  	}
> =20
> -	io_cqring_fill_event(ctx, req->user_data, -ETIME);
> +	io_cqring_fill_event(req, -ETIME);
>  	io_commit_cqring(ctx);
>  	spin_unlock_irqrestore(&ctx->completion_lock, flags);
> =20
> @@ -2092,7 +2092,7 @@ static int io_timeout_remove(struct io_kiocb *req=
,
>  	/* didn't find timeout */
>  	if (ret) {
>  fill_ev:
> -		io_cqring_fill_event(ctx, req->user_data, ret);
> +		io_cqring_fill_event(req, ret);
>  		io_commit_cqring(ctx);
>  		spin_unlock_irq(&ctx->completion_lock);
>  		io_cqring_ev_posted(ctx);
> @@ -2108,8 +2108,8 @@ static int io_timeout_remove(struct io_kiocb *req=
,
>  		goto fill_ev;
>  	}
> =20
> -	io_cqring_fill_event(ctx, req->user_data, 0);
> -	io_cqring_fill_event(ctx, treq->user_data, -ECANCELED);
> +	io_cqring_fill_event(req, 0);
> +	io_cqring_fill_event(treq, -ECANCELED);
>  	io_commit_cqring(ctx);
>  	spin_unlock_irq(&ctx->completion_lock);
>  	io_cqring_ev_posted(ctx);
> @@ -2249,7 +2249,7 @@ static int io_async_cancel(struct io_kiocb *req, =
const struct io_uring_sqe *sqe,
> =20
>  	if (ret < 0 && (req->flags & REQ_F_LINK))
>  		req->flags |=3D REQ_F_FAIL_LINK;
> -	io_cqring_add_event(req->ctx, sqe->user_data, ret);
> +	io_cqring_add_event(req, ret);
>  	io_put_req(req, nxt);
>  	return 0;
>  }
> @@ -2288,12 +2288,10 @@ static int __io_submit_sqe(struct io_ring_ctx *=
ctx, struct io_kiocb *req,
>  	int ret, opcode;
>  	struct sqe_submit *s =3D &req->submit;
> =20
> -	req->user_data =3D READ_ONCE(s->sqe->user_data);
> -
>  	opcode =3D READ_ONCE(s->sqe->opcode);
>  	switch (opcode) {
>  	case IORING_OP_NOP:
> -		ret =3D io_nop(req, req->user_data);
> +		ret =3D io_nop(req);
>  		break;
>  	case IORING_OP_READV:
>  		if (unlikely(s->sqe->buf_index))
> @@ -2402,7 +2400,7 @@ static void io_wq_submit_work(struct io_wq_work *=
*workptr)
>  	if (ret) {
>  		if (req->flags & REQ_F_LINK)
>  			req->flags |=3D REQ_F_FAIL_LINK;
> -		io_cqring_add_event(ctx, sqe->user_data, ret);
> +		io_cqring_add_event(req, ret);
>  		io_put_req(req, NULL);
>  	}
> =20
> @@ -2530,7 +2528,7 @@ static enum hrtimer_restart io_link_timeout_fn(st=
ruct hrtimer *timer)
>  	if (prev)
>  		ret =3D io_async_cancel_one(ctx, (void *) prev->user_data);
> =20
> -	io_cqring_add_event(ctx, req->user_data, ret);
> +	io_cqring_add_event(req, ret);
>  	io_put_req(req, NULL);
>  	return HRTIMER_NORESTART;
>  }
> @@ -2573,7 +2571,7 @@ static int io_queue_linked_timeout(struct io_kioc=
b *req, struct io_kiocb *nxt)
>  		 * failed by the regular submission path.
>  		 */
>  		list_del(&nxt->list);
> -		io_cqring_fill_event(ctx, nxt->user_data, ret);
> +		io_cqring_fill_event(nxt, ret);
>  		trace_io_uring_fail_link(req, nxt);
>  		io_commit_cqring(ctx);
>  		io_put_req(nxt, NULL);
> @@ -2646,7 +2644,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx=
, struct io_kiocb *req)
> =20
>  	/* and drop final reference, if we failed */
>  	if (ret) {
> -		io_cqring_add_event(ctx, req->user_data, ret);
> +		io_cqring_add_event(req, ret);
>  		if (req->flags & REQ_F_LINK)
>  			req->flags |=3D REQ_F_FAIL_LINK;
>  		io_put_req(req, NULL);
> @@ -2662,7 +2660,7 @@ static int io_queue_sqe(struct io_ring_ctx *ctx, =
struct io_kiocb *req)
>  	ret =3D io_req_defer(ctx, req);
>  	if (ret) {
>  		if (ret !=3D -EIOCBQUEUED) {
> -			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
> +			io_cqring_add_event(req, ret);
>  			io_free_req(req, NULL);
>  		}
>  		return 0;
> @@ -2689,8 +2687,8 @@ static int io_queue_link_head(struct io_ring_ctx =
*ctx, struct io_kiocb *req,
>  	ret =3D io_req_defer(ctx, req);
>  	if (ret) {
>  		if (ret !=3D -EIOCBQUEUED) {
> -			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
> -			io_free_req(req, NULL);
> +			io_cqring_add_event(req, ret);
> +			io_put_req(req, NULL);
>  			__io_free_req(shadow);
>  			return 0;
>  		}
> @@ -2723,6 +2721,8 @@ static void io_submit_sqe(struct io_ring_ctx *ctx=
, struct io_kiocb *req,
>  	struct sqe_submit *s =3D &req->submit;
>  	int ret;
> =20
> +	req->user_data =3D s->sqe->user_data;
> +
>  	/* enforce forwards compatibility on users */
>  	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
>  		ret =3D -EINVAL;
> @@ -2732,13 +2732,13 @@ static void io_submit_sqe(struct io_ring_ctx *c=
tx, struct io_kiocb *req,
>  	ret =3D io_req_set_file(ctx, state, req);
>  	if (unlikely(ret)) {
>  err_req:
> -		io_cqring_add_event(ctx, s->sqe->user_data, ret);
> -		io_free_req(req, NULL);
> +		io_cqring_add_event(req, ret);
> +		/* drop both submit and complete references */
> +		io_put_req(req, NULL);
> +		io_put_req(req, NULL);
>  		return;
>  	}
> =20
> -	req->user_data =3D s->sqe->user_data;
> -
>  	/*
>  	 * If we already have a head request, queue this one for async
>  	 * submittal once the head completes. If we don't have a head but
>=20

--=20
Pavel Begunkov


--xiHYN1cE44ribps7guhAfpnYHIVRrlw4s--

--GeAi5oeSJwPjkomrzlDWWHE4lWZEFonzs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3D6asACgkQWt5b1Glr
+6X6Mg/+K1CdNZNBLgfTPg9YYAuFHzcpsfMZTs8ytv97CpXREgaw7Fb+h4tK1mfw
NPPTUwT5rpVVLx1B726ZJzQpNu6VeUxEnBTDKyverqAa65bpV1dauBNBQZ+jV7If
UiZbWOOGOOaDTUVHegi/bK6uR4qvI9GoeWCD2rJkbVumeWFvwuo24TvgowV9ZWpU
U78S0J6onV9dGDyG9ijBrT+EdFiwhTgnMtfpK4QYtqn9ptzkhKDjUw51UzzcjFLG
m/5IJWi4xuqM0OE2Z18BFUBVNiNzyKbMArWXe5WEZZ3jm3MvRVxCB9qgCzJblePQ
Q9ZU4vwU8lD2sTIDbjz09GuYmdy1Z5qCD2Jg/GDk88TfidV1kejXkdUsJTQoXgFZ
IxlXkOv7MTDKmmJXy468q3sbzvAxFcmli3mR8kSQZOywwFXXWgYDvjOekbY8lkfn
h9cLSntf14AWMNmLC9dLSCBAlOTtKXdogmf6/8Ony5ZnNo/Y1iohpvW89s7R2D0U
fpSfCAcde4h4HEPzykV9tzqNZzFO4d3ln5ZINNuXhLhWxPiq66j8dUWMVstce8jg
oucvjZEgtuTQJSCIxHsJr+XpKWbcvDcl8bFt5ycw+zMyrAwft1lGVlt+dolhMqLi
r39I3JaUPTRQ5A6BTZTSpwUsrAFaTB9VzncObOa3IQxUJLpE7YI=
=6VeF
-----END PGP SIGNATURE-----

--GeAi5oeSJwPjkomrzlDWWHE4lWZEFonzs--
