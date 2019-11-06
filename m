Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FB5C5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 19:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B235D2075C
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 19:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRMf5yBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfKFTMV (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:12:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40121 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfKFTMV (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 14:12:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id i10so6674021wrs.7;
        Wed, 06 Nov 2019 11:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=cjrE0jgP309rjp36iwwbVTcgzX6EZqWkvy/dHkUe4l0=;
        b=WRMf5yBTjGeBxdI7imJ/bum8+co4o+bdZGrfMEOp97DV7kPRGgHslV+3zedEpyNi18
         2mDv/MTNOKz6zHLppswfx3adJBCjXJlXWANeCup8JLMxXJkWbvHRXyNpDltF1ch8hlj1
         gX4Bz635kS//LW9xvT1QjCgruvT4mngaO70wWQebX3EOcdruNARk1nA9UG+tdosDm/ei
         mDnUmqaIf2g0GLYgNG6PgE4KtydJSdDAMiHvTyE6rQiVscx0P8fINYivDsn6XMOH0ClD
         1N3O7Hvkk3PRsZUOsjPWdcxhtiZXnRjJCeB7HfuvoJJmYmAFTU4CkL95qM0rPHvWzmIo
         pHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=cjrE0jgP309rjp36iwwbVTcgzX6EZqWkvy/dHkUe4l0=;
        b=k22EEOfyoeIbU7ubTwfmLVz7srVQcPjq6ixuAaVV6Mld6t6RvGe5kP2xodpfWLFPKk
         jUX0BqEFriwm9VujEfl/R1hVnjA7k4tBku2fTO+TY+O56am6hRZjm6vJb7e6QM6GQYGO
         E4PX1hfwURgvckezme4yIAjpG9I0AWmKGJBYakErcwlqNcux25y1V7206M7KYW6zcHd4
         AXY5BDHQKYCpBYGTwiNrD+GZnqEIA8GtGk/9mk962TUwVwxfqHzAN5LkzxXVx0AlJgWH
         l9fOU7eYZ4vqh2B0OGJwb4VLP3O0wuUeWZmyvowWS/IAOhj6HuoBIEtWlB8DnwLi5yeq
         4JuQ==
X-Gm-Message-State: APjAAAXbegPByrLj/2H212b9ZXOyQoZYdnYGBsDAFIwGNGbjZctWTFZ7
        lpknAt1Ny7AKQHWB06t3uLd4vjF0
X-Google-Smtp-Source: APXvYqwoRkybyNKueOTufjCLkDRcrGErfRL5SDzVGbDvWmDTv2OC8Z4xW4Vqck/ahYREAFUnqFkyAg==
X-Received: by 2002:adf:9381:: with SMTP id 1mr4166292wrp.10.1573067536273;
        Wed, 06 Nov 2019 11:12:16 -0800 (PST)
Received: from [192.168.43.132] ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id o18sm28093485wrm.11.2019.11.06.11.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 11:12:15 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [RFC] io_uring CQ ring backpressure
Message-ID: <412439b3-5626-f016-71e7-6100e7a6feef@gmail.com>
Date:   Wed, 6 Nov 2019 22:12:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EShPOEFbhHY0CK2BcxPn0hnMsGK9M4jk0"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EShPOEFbhHY0CK2BcxPn0hnMsGK9M4jk0
Content-Type: multipart/mixed; boundary="s1YQz4YqNHTiElWf4j021odKFWt9IGFIb";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <412439b3-5626-f016-71e7-6100e7a6feef@gmail.com>
Subject: Re: [RFC] io_uring CQ ring backpressure
References: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
In-Reply-To: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>

--s1YQz4YqNHTiElWf4j021odKFWt9IGFIb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06/11/2019 19:21, Jens Axboe wrote:
> Currently we drop completion events, if the CQ ring is full. That's fin=
e
> for requests with bounded completion times, but it may make it harder t=
o
> use io_uring with networked IO where request completion times are
> generally unbounded. Or with POLL, for example, which is also unbounded=
=2E
>=20
> This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bi=
t
> for CQ ring overflows. First of all, it doesn't overflow the ring, it
> simply stores backlog of completions that we weren't able to put into
> the CQ ring. To prevent the backlog from growing indefinitely, if the
> backlog is non-empty, we apply back pressure on IO submissions. Any
> attempt to submit new IO with a non-empty backlog will get an -EBUSY
> return from the kernel.
>=20
> I think that makes for a pretty sane API in terms of how the applicatio=
n
> can handle it. With CQ_NODROP enabled, we'll never drop a completion
> event (well unless we're totally out of memory...), but we'll also not
> allow submissions with a completion backlog.
>=20
> ---
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index b647cdf0312c..12e9fe2479f4 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -207,6 +207,7 @@ struct io_ring_ctx {
> =20
>  		struct list_head	defer_list;
>  		struct list_head	timeout_list;
> +		struct list_head	cq_overflow_list;
> =20
>  		wait_queue_head_t	inflight_wait;
>  	} ____cacheline_aligned_in_smp;
> @@ -414,6 +415,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct=
 io_uring_params *p)
> =20
>  	ctx->flags =3D p->flags;
>  	init_waitqueue_head(&ctx->cq_wait);
> +	INIT_LIST_HEAD(&ctx->cq_overflow_list);
>  	init_completion(&ctx->ctx_done);
>  	init_completion(&ctx->sqo_thread_started);
>  	mutex_init(&ctx->uring_lock);
> @@ -588,6 +590,77 @@ static struct io_uring_cqe *io_get_cqring(struct i=
o_ring_ctx *ctx)
>  	return &rings->cqes[tail & ctx->cq_mask];
>  }
> =20
> +static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
> +{
> +	if (waitqueue_active(&ctx->wait))
> +		wake_up(&ctx->wait);
> +	if (waitqueue_active(&ctx->sqo_wait))
> +		wake_up(&ctx->sqo_wait);
> +	if (ctx->cq_ev_fd)
> +		eventfd_signal(ctx->cq_ev_fd, 1);
> +}
> +
> +struct cqe_drop {
> +	struct list_head list;
> +	u64 user_data;
> +	s32 res;
> +};

How about to use io_kiocb instead of new structure?
It already has valid req->user_data and occasionaly used
req->result. But this would probably take more work to do.

> +
> +static void io_cqring_overflow_flush(struct io_ring_ctx *ctx)
> +{
> +	struct io_rings *rings =3D ctx->rings;
> +	struct io_uring_cqe *cqe;
> +	struct cqe_drop *drop;
> +	unsigned long flags;
> +
> +	if (list_empty_careful(&ctx->cq_overflow_list))
> +		return;
> +	if (ctx->cached_cq_tail - READ_ONCE(rings->cq.head) =3D=3D
> +	    rings->cq_ring_entries)
> +		return;
> +
> +	spin_lock_irqsave(&ctx->completion_lock, flags);
> +
> +	while (!list_empty(&ctx->cq_overflow_list)) {
> +		drop =3D list_first_entry(&ctx->cq_overflow_list, struct cqe_drop,
> +						list);
> +		cqe =3D io_get_cqring(ctx);
> +		if (!cqe)
> +			break;
> +		list_del(&drop->list);
> +		WRITE_ONCE(cqe->user_data, drop->user_data);
> +		WRITE_ONCE(cqe->res, drop->res);
> +		WRITE_ONCE(cqe->flags, 0);
> +		kfree(drop);
> +	}
> +
> +	io_commit_cqring(ctx);
> +	spin_unlock_irqrestore(&ctx->completion_lock, flags);
> +	io_cqring_ev_posted(ctx);
> +}
> +
> +static void io_cqring_overflow(struct io_ring_ctx *ctx, u64 ki_user_da=
ta,
> +			       long res)
> +	__must_hold(&ctx->completion_lock)
> +{
> +	struct cqe_drop *drop;
> +
> +	if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
> +log_overflow:
> +		WRITE_ONCE(ctx->rings->cq_overflow,
> +				atomic_inc_return(&ctx->cached_cq_overflow));
> +		return;
> +	}
> +
> +	drop =3D kmalloc(sizeof(*drop), GFP_ATOMIC);
> +	if (!drop)
> +		goto log_overflow;
> +
> +	drop->user_data =3D ki_user_data;
> +	drop->res =3D res;
> +	list_add_tail(&drop->list, &ctx->cq_overflow_list);
> +}
> +
>  static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_=
data,
>  				 long res)
>  {
> @@ -601,26 +674,15 @@ static void io_cqring_fill_event(struct io_ring_c=
tx *ctx, u64 ki_user_data,
>  	 * the ring.
>  	 */
>  	cqe =3D io_get_cqring(ctx);
> -	if (cqe) {
> +	if (likely(cqe)) {
>  		WRITE_ONCE(cqe->user_data, ki_user_data);
>  		WRITE_ONCE(cqe->res, res);
>  		WRITE_ONCE(cqe->flags, 0);
>  	} else {
> -		WRITE_ONCE(ctx->rings->cq_overflow,
> -				atomic_inc_return(&ctx->cached_cq_overflow));
> +		io_cqring_overflow(ctx, ki_user_data, res);
>  	}
>  }
> =20
> -static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
> -{
> -	if (waitqueue_active(&ctx->wait))
> -		wake_up(&ctx->wait);
> -	if (waitqueue_active(&ctx->sqo_wait))
> -		wake_up(&ctx->sqo_wait);
> -	if (ctx->cq_ev_fd)
> -		eventfd_signal(ctx->cq_ev_fd, 1);
> -}
> -
>  static void io_cqring_add_event(struct io_ring_ctx *ctx, u64 user_data=
,
>  				long res)
>  {
> @@ -859,8 +921,13 @@ static void io_put_req(struct io_kiocb *req, struc=
t io_kiocb **nxtptr)
>  	}
>  }
> =20
> -static unsigned io_cqring_events(struct io_rings *rings)
> +static unsigned io_cqring_events(struct io_ring_ctx *ctx)
>  {
> +	struct io_rings *rings =3D ctx->rings;
> +
> +	if (ctx->flags & IORING_SETUP_CQ_NODROP)
> +		io_cqring_overflow_flush(ctx);
> +
>  	/* See comment at the top of this file */
>  	smp_rmb();
>  	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
> @@ -1016,7 +1083,7 @@ static int __io_iopoll_check(struct io_ring_ctx *=
ctx, unsigned *nr_events,
>  		 * If we do, we can potentially be spinning for commands that
>  		 * already triggered a CQE (eg in error).
>  		 */
> -		if (io_cqring_events(ctx->rings))
> +		if (io_cqring_events(ctx))
>  			break;
> =20
>  		/*
> @@ -2873,6 +2940,10 @@ static int io_submit_sqes(struct io_ring_ctx *ct=
x, unsigned int nr,
>  	int i, submitted =3D 0;
>  	bool mm_fault =3D false;
> =20
> +	if ((ctx->flags & IORING_SETUP_CQ_NODROP) &&
> +	    !list_empty(&ctx->cq_overflow_list))
> +		return -EBUSY;
> +
>  	if (nr > IO_PLUG_THRESHOLD) {
>  		io_submit_state_start(&state, ctx, nr);
>  		statep =3D &state;
> @@ -2952,6 +3023,7 @@ static int io_sq_thread(void *data)
>  	timeout =3D inflight =3D 0;
>  	while (!kthread_should_park()) {
>  		unsigned int to_submit;
> +		int ret;
> =20
>  		if (inflight) {
>  			unsigned nr_events =3D 0;
> @@ -3036,8 +3108,10 @@ static int io_sq_thread(void *data)
>  		}
> =20
>  		to_submit =3D min(to_submit, ctx->sq_entries);
> -		inflight +=3D io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm,
> -					   true);
> +		ret =3D io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm, true);
> +		if (ret < 0)
> +			continue;
> +		inflight +=3D ret;
> =20

After rebase could be simplified to=20
if (ret >=3D 0)
	inflight +=3D ret;


>  		/* Commit SQ ring head once we've consumed all SQEs */
>  		io_commit_sqring(ctx);
> @@ -3070,7 +3144,7 @@ static inline bool io_should_wake(struct io_wait_=
queue *iowq)
>  	 * started waiting. For timeouts, we always want to return to userspa=
ce,
>  	 * regardless of event count.
>  	 */
> -	return io_cqring_events(ctx->rings) >=3D iowq->to_wait ||
> +	return io_cqring_events(ctx) >=3D iowq->to_wait ||
>  			atomic_read(&ctx->cq_timeouts) !=3D iowq->nr_timeouts;
>  }
> =20
> @@ -3105,7 +3179,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx=
, int min_events,
>  	struct io_rings *rings =3D ctx->rings;
>  	int ret =3D 0;
> =20
> -	if (io_cqring_events(rings) >=3D min_events)
> +	if (io_cqring_events(ctx) >=3D min_events)
>  		return 0;
> =20
>  	if (sig) {
> @@ -4406,7 +4480,8 @@ static long io_uring_setup(u32 entries, struct io=
_uring_params __user *params)
>  	}
> =20
>  	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_SQPOLL |
> -			IORING_SETUP_SQ_AFF | IORING_SETUP_CQSIZE))
> +			IORING_SETUP_SQ_AFF | IORING_SETUP_CQSIZE |
> +			IORING_SETUP_CQ_NODROP))
>  		return -EINVAL;
> =20
>  	ret =3D io_uring_create(entries, &p);
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_urin=
g.h
> index f1a118b01d18..3d8517eb376e 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -56,6 +56,7 @@ struct io_uring_sqe {
>  #define IORING_SETUP_SQPOLL	(1U << 1)	/* SQ poll thread */
>  #define IORING_SETUP_SQ_AFF	(1U << 2)	/* sq_thread_cpu is valid */
>  #define IORING_SETUP_CQSIZE	(1U << 3)	/* app defines CQ size */
> +#define IORING_SETUP_CQ_NODROP	(1U << 4)	/* no CQ drops */
> =20
>  #define IORING_OP_NOP		0
>  #define IORING_OP_READV		1
>=20

--=20
Pavel Begunkov


--s1YQz4YqNHTiElWf4j021odKFWt9IGFIb--

--EShPOEFbhHY0CK2BcxPn0hnMsGK9M4jk0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3DGwAACgkQWt5b1Glr
+6Vo5w//YvfNGyO/mGyiNDDEn7vajzIs+p674Z7usFIqD8GFf+TYahfs2KnUyW/8
+/rqLrOPpNW076Z/OavhoPaHx2NoYS3k/ctvn1774QtOOo5WjMo19EhQ0LKDVW95
edZHMOgH5zk2NAPjfL1P2sm7OVevCHczYdZoMFVdXxdhM/Cwr7QCQfQzAWLJzsAu
88Y7JIXuhl+mRrn0kM1NA+ev+GzVS63AMOPvEqbOegHF8DOeCpRPPP0uEDcbJ0pJ
ygbI8jUrvPIEnfcndpck2G9BpugbQ6t4Sd2c3epYMJZoZ69S4CM/fLR2dO7ruS+2
IG3ZvZEHOqi71pCn46r3sLhmI1qQ9EsclWtn/yN+NEYtH03Bbx4D6k+9SJs7a6nW
xsUAjX5b/8vlDKJRo/D6jdRrifIzi0+TSOGLDGwaNn9+vaizvCfhzs4o05zlRRB6
qfB9G/pBDIzy96YZcqQ5Zi2LVWyUwdWahnWRB2y2B7YMizTpcAvnt7+7GBzEs7CP
tauQ009Hetqw4uaMy8GWlKwThkR6GasfJpVB2uJqCefoMp+54mjAugGX3gJma4Eq
S/fDBA9+tvO5gGHoWaDABBYeF91/KQM4JvdSCYxscuvAoWvCxh//jZU51leBaPnA
GPrtSuaIo2yDX6lHEVwAouoEpKrzt3SQJLJTo1BR/dx/uCDi3mQ=
=/s9B
-----END PGP SIGNATURE-----

--EShPOEFbhHY0CK2BcxPn0hnMsGK9M4jk0--
