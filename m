Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66979C5DF60
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 09:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E44206DF
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 09:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcafy7kS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfKHJ5J (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:57:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34708 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbfKHJ5J (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 04:57:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id e6so6351934wrw.1
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 01:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=lxGbZazfDQtCjBRdyau4l0OjuFmBet6UXhciwCXRDkQ=;
        b=Zcafy7kSRgT/fqrXD11QldqMTWZ0ifdYU87nkWtLHp6tk5rfKQj9BbzQel/yb2CPzw
         tOdl2zJh88UD1IvZjlQjcbeO8HY8ETOhiLF+Ns5vWuLC4WpCuI4JNufqaiAtbqYee7Rc
         2YMseLxiqMzjshxt8kip6Hp8IM0dMcmu2+u2P2uSGPelXP7+d9JPl8ACUkTglS+riIii
         lSqhdK20wNv470f66wRXyLEs2KmMo4ic5noPCn4BNLpLhg6x/S6mhHwnVtYFLgFMXUcU
         qEdG8IKxzzdmKeWWSFghsh1RhHcLmL0IGPeulnQI6yz8cz4q1hUxI2S1gMBsNoniT1YS
         ijzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=lxGbZazfDQtCjBRdyau4l0OjuFmBet6UXhciwCXRDkQ=;
        b=tGPhFqEGc4fTZzuF/SI0NPf7Quq6QlNI6sVakroFSP3woKYy6U7qCIyEzp2PQBpnMM
         B5eSlTxKvjb8M4fqlJ3hUdHOLhszfm0lyj5yEYOYFaC9TLbyuBVWoG2AEv68IwZCHXRp
         I+orRrZhmPnvT5BY8JRAHnQg4aW64c+PcfK590JLpETZdX7dG4nUjHqqN4kiTlfGVYTK
         JGFc9auIFkfWeUjyVssjP+DaynOR6ZvM0p2pG5lG5Fb5++NW7SYRVa11QTDrfgWPn9Bo
         FGrSkcAVBYhPTdXNMCW/hNYwnGJesWYxbljtDFuDpcel5xy+UUmpnqPJ2uGaH2+Hvg4M
         bpmQ==
X-Gm-Message-State: APjAAAXOEjdlmQchFpPq6QnyyngZiO4JS/xyl61J+YhvJno9Hq1WuBYt
        AS3YMKAYORvoeo/o/CI1sjRfz7ns
X-Google-Smtp-Source: APXvYqzkTAk5bEfpkzJMPTkrkPBFKSDrsFoDaIKj30+k1b2or49PuSPfAs42xK2i84ZLKw17Plsuig==
X-Received: by 2002:adf:aa03:: with SMTP id p3mr4228219wrd.240.1573207025486;
        Fri, 08 Nov 2019 01:57:05 -0800 (PST)
Received: from [192.168.43.59] ([109.126.142.81])
        by smtp.gmail.com with ESMTPSA id t24sm8513194wra.55.2019.11.08.01.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 01:57:04 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
 <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
Message-ID: <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
Date:   Fri, 8 Nov 2019 12:56:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZT9379RTICjRd9Jh99IuXixfdtf6cPRwf"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZT9379RTICjRd9Jh99IuXixfdtf6cPRwf
Content-Type: multipart/mixed; boundary="DEVYF07Wn4RPISQQTm30UcFy18utfnjuJ";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
 <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
In-Reply-To: <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>

--DEVYF07Wn4RPISQQTm30UcFy18utfnjuJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/11/2019 03:19, Jens Axboe wrote:
> On 11/7/19 4:21 PM, Jens Axboe wrote:
>> I'd like some feedback on this one. Even tith the overflow backpressur=
e
>> patch, we still have a potentially large gap where applications can
>> submit IO before we get any dropped events in the CQ ring. This is
>> especially true if the execution time of those requests are long
>> (unbounded).
>>
>> This adds IORING_SETUP_INFLIGHT, which if set, will return -EBUSY if w=
e
>> have more IO pending than we can feasibly support. This is normally th=
e
>> CQ ring size, but of IORING_SETUP_CQ_NODROP is enabled, then it's twic=
e
>> the CQ ring size.
>>
>> This helps manage the pending queue size instead of letting it grow
>> indefinitely.
>>
>> Note that we could potentially just make this the default behavior -
>> applications need to handle -EAGAIN returns already, in case we run ou=
t
>> of memory, and if we change this to return -EAGAIN as well, then it
>> doesn't introduce any new failure cases. I'm tempted to do that...
>>
>> Anyway, comments solicited!
What's wrong with giving away overflow handling to the userspace? It
knows its inflight count, and it shouldn't be a problem to allocate
large enough rings. The same goes for the backpressure patch. Do you
have a particular requirement/user for this?

Awhile something could be done {efficiently,securely,etc} in the
userspace, I would prefer to keep the kernel part simpler.


>=20
> After a little deliberation, I think we should go with the one that
> doesn't require users to opt-in. As mentioned, let's change it to
> -EAGAIN to not introduce a new errno for this. They essentially mean
> the same thing anyway.
>=20
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index f8344f95817e..4c488bf6e889 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -203,6 +203,7 @@ struct io_ring_ctx {
>  		unsigned		sq_mask;
>  		unsigned		sq_thread_idle;
>  		unsigned		cached_sq_dropped;
> +		atomic_t		cached_cq_overflow;
>  		struct io_uring_sqe	*sq_sqes;
> =20
>  		struct list_head	defer_list;
> @@ -221,13 +222,12 @@ struct io_ring_ctx {
> =20
>  	struct {
>  		unsigned		cached_cq_tail;
> -		atomic_t		cached_cq_overflow;
>  		unsigned		cq_entries;
>  		unsigned		cq_mask;
> +		atomic_t		cq_timeouts;
>  		struct wait_queue_head	cq_wait;
>  		struct fasync_struct	*cq_fasync;
>  		struct eventfd_ctx	*cq_ev_fd;
> -		atomic_t		cq_timeouts;
>  	} ____cacheline_aligned_in_smp;
> =20
>  	struct io_rings	*rings;
> @@ -705,16 +705,39 @@ static void io_cqring_add_event(struct io_kiocb *=
req, long res)
>  	io_cqring_ev_posted(ctx);
>  }
> =20
> +static bool io_req_over_limit(struct io_ring_ctx *ctx)
> +{
> +	unsigned limit, inflight;
> +
> +	/*
> +	 * This doesn't need to be super precise, so only check every once
> +	 * in a while.
> +	 */
> +	if (ctx->cached_sq_head & ctx->sq_mask)
> +		return false;
> +
> +	if (ctx->flags & IORING_SETUP_CQ_NODROP)
> +		limit =3D 2 * ctx->cq_entries;
> +	else
> +		limit =3D ctx->cq_entries;
> +
> +	inflight =3D ctx->cached_sq_head -
> +		  (ctx->cached_cq_tail + atomic_read(&ctx->cached_cq_overflow));
> +	return inflight >=3D limit;
> +}
> +
>  static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
> -				   struct io_submit_state *state)
> +				   struct io_submit_state *state, bool force)
>  {
>  	gfp_t gfp =3D GFP_KERNEL | __GFP_NOWARN;
>  	struct io_kiocb *req;
> =20
>  	if (!percpu_ref_tryget(&ctx->refs))
> -		return NULL;
> +		return ERR_PTR(-ENXIO);
> =20
>  	if (!state) {
> +		if (unlikely(!force && io_req_over_limit(ctx)))
> +			goto out;
>  		req =3D kmem_cache_alloc(req_cachep, gfp);
>  		if (unlikely(!req))
>  			goto out;
> @@ -722,6 +745,8 @@ static struct io_kiocb *io_get_req(struct io_ring_c=
tx *ctx,
>  		size_t sz;
>  		int ret;
> =20
> +		if (unlikely(!force && io_req_over_limit(ctx)))
> +			goto out;
>  		sz =3D min_t(size_t, state->ios_left, ARRAY_SIZE(state->reqs));
>  		ret =3D kmem_cache_alloc_bulk(req_cachep, gfp, sz, state->reqs);
> =20
> @@ -754,7 +779,7 @@ static struct io_kiocb *io_get_req(struct io_ring_c=
tx *ctx,
>  	return req;
>  out:
>  	percpu_ref_put(&ctx->refs);
> -	return NULL;
> +	return ERR_PTR(-EAGAIN);
>  }
> =20
>  static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int=
 *nr)
> @@ -2963,10 +2988,11 @@ static int io_submit_sqes(struct io_ring_ctx *c=
tx, unsigned int nr,
>  		struct io_kiocb *req;
>  		unsigned int sqe_flags;
> =20
> -		req =3D io_get_req(ctx, statep);
> -		if (unlikely(!req)) {
> +		req =3D io_get_req(ctx, statep, false);
> +		if (unlikely(IS_ERR(req))) {
>  			if (!submitted)
> -				submitted =3D -EAGAIN;
> +				submitted =3D PTR_ERR(req);
> +			req =3D NULL;
>  			break;
>  		}
>  		if (!io_get_sqring(ctx, &req->submit)) {
> @@ -2986,9 +3012,11 @@ static int io_submit_sqes(struct io_ring_ctx *ct=
x, unsigned int nr,
> =20
>  		if (link && (sqe_flags & IOSQE_IO_DRAIN)) {
>  			if (!shadow_req) {
> -				shadow_req =3D io_get_req(ctx, NULL);
> -				if (unlikely(!shadow_req))
> +				shadow_req =3D io_get_req(ctx, NULL, true);
> +				if (unlikely(IS_ERR(shadow_req))) {
> +					shadow_req =3D NULL;
>  					goto out;
> +				}
>  				shadow_req->flags |=3D (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
>  				refcount_dec(&shadow_req->refs);
>  			}
>=20

--=20
Pavel Begunkov


--DEVYF07Wn4RPISQQTm30UcFy18utfnjuJ--

--ZT9379RTICjRd9Jh99IuXixfdtf6cPRwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3FO+EACgkQWt5b1Glr
+6X1QQ/+JdT6tKRYSSifA3qKpTDrN7vZSoXqURMiyWJ6M4Pzu6+dQ4KqqHVsyI5z
wxxkhZRfhFEYhY0uyANMLGCQZmYHHL6p+BztMYNZCfnEXt+trB159gTfRdSURJO5
L9/Cz53bwgnntLZhLGl+//ppY1U6+xwDGHra7cg22iGe9MMOVk8gfW3BiU92dSvJ
40ukLey2Ry708FWGI1Xqu9CRExo2xdJ5ZZSw3bgixOM1E/S8Ugno+mS47MLxwCnE
JtJq39ynVdyPIdFc8pA76MgytolOvrEM8+ft4B/kMlMHHtOK2b+CSzZwLLFhATfw
TyI5gfEOkO7GvE0e04QDFI1Dv//fAuk1GG79fpOxdM0TVdOK03Kl9akYMtOEAFfR
VKqMm4ptqU44NJMgoLJEVbPmN63gUQtbmJ9rHsHjRku4NX3YINtdA8PHgllhQsnP
P9svbWFqz7Wb2XAZURhSfKeWyUFIOwFNvw2v7LwcPFtXLzBJmT6FoVYoUQ5f8reW
N7ekcRYljswhQIzhamkUFVxdljEbWWs7xEQ47um0uMrbNL3ye1x7EwGrCuLdUR31
zmnlDPJ9jM2Fn6Yh7JSgA1ZZGjLmCuITFOuwGdz5/89RzKSCmbz3nkgWICQwHfVp
ejKb0ZAisraLwNsK4bVMJpYIPXX2lTdFggrQUEymyxaXCnUEHsU=
=XzTB
-----END PGP SIGNATURE-----

--ZT9379RTICjRd9Jh99IuXixfdtf6cPRwf--
