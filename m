Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54FFC43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 11:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5503121882
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 11:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzFNQ/nQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKILBn (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 06:01:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55837 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfKILBn (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 06:01:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so8618100wmb.5
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 03:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=2jzuJ+N+vnlmVH9dWip2ER7fIznN9FE21rLF0xaHf0Q=;
        b=tzFNQ/nQ7Urk3gXVzzoixVT9lVM9KFYKPwOsoNjGt6bO94OXlj3yQhO6/eIyS9pW0t
         xYQkRGtD6WGAK9FFmT+qE+ohrVt+kk6EEaCr26/LZ4AnaILDkK/bgK8X9DcM4xCh0Gjz
         O/Pf/ZzbvuSVFwwStXQM/2ErFNhEjbFfAHDVj/rXLx7B2LZdMlvFrEwPuUI9P+YBsOON
         B6AR5BTa68yKGYpH9IbDjj0ZYQEjP3gTcX2/tbwxUijpg/YdI9G3QLorQhfFy/RKhSIK
         2f7+m/S6DlI4OUCaXjvczOU1AQ57Mp3S+f8qEqGQ3hUuqTLpRK9o7QtC5lg36rtkyLzm
         Y+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=2jzuJ+N+vnlmVH9dWip2ER7fIznN9FE21rLF0xaHf0Q=;
        b=pBg8zH7GZ66OqnB7VqXGzrC7iiAULB5NnDjgWbE2hx3oXXdglFzlrKfPgrHXLY9+cM
         8lsJIeh6NvNTF3gQUypX12mv9uMmVeiaS6qJYEJDI5phu6kDRv77jT4Up+Sd9vn3UO/B
         z0cpk+gMaXE1U7TWyKqa380Pn5bz97fk8NGDTJPM9jHYOhRm9srmuoq1evMCx1jUb8PX
         kioKBRko8gt4wqc8J2sgZzhdiu6NLs0zcNxdiRjizWKA50IbC601K3wtU7D0Sa+D8ZY9
         GtawwCZer0aJN0rVnghmxA1Gu7tgxR0iFxaUodphy2CsQyzCMiEKiDKo4C6FVChhZkpx
         av+w==
X-Gm-Message-State: APjAAAVJb2kKxp1r/WyqDu9CylEMRej9I7J6s7wOsKhw/sGWDIbLuYKN
        S1yFTk/T3MYk5bczAP5Np72hb4O7
X-Google-Smtp-Source: APXvYqymijMoVvGGYElDgU+dCphMbgbAOR/CROuFtRAL+SJuXjslePHED8A0HLl9+y2Yjpxz+zZslA==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr11859889wmi.17.1573297300213;
        Sat, 09 Nov 2019 03:01:40 -0800 (PST)
Received: from [192.168.43.163] ([109.126.130.90])
        by smtp.gmail.com with ESMTPSA id z6sm10413410wro.18.2019.11.09.03.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2019 03:01:39 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <d7604123-1499-70b1-9990-74b3b1cfab69@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH RFC v2] io_uring: limit inflight IO
Message-ID: <6945baa5-7539-1d67-fcb5-5642e81994a8@gmail.com>
Date:   Sat, 9 Nov 2019 14:01:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <d7604123-1499-70b1-9990-74b3b1cfab69@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="w5DUW3Pmp5UzgiKDlBHp6SalI1fwMVRFR"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w5DUW3Pmp5UzgiKDlBHp6SalI1fwMVRFR
Content-Type: multipart/mixed; boundary="LHwWRQ0ZtTOplnfncTWROmMAUx9f7okjA";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <6945baa5-7539-1d67-fcb5-5642e81994a8@gmail.com>
Subject: Re: [PATCH RFC v2] io_uring: limit inflight IO
References: <d7604123-1499-70b1-9990-74b3b1cfab69@kernel.dk>
In-Reply-To: <d7604123-1499-70b1-9990-74b3b1cfab69@kernel.dk>

--LHwWRQ0ZtTOplnfncTWROmMAUx9f7okjA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/11/2019 00:10, Jens Axboe wrote:
> Here's a modified version for discussion. Instead of sizing this on the=

> specific ring, just size it based on the max allowable CQ ring size. I
> think this should be safer, and won't risk breaking existing use cases
> out there.
>=20
> The reasoning here is that we already limit the ring sizes globally,
> they are under ulimit memlock protection. With this on top, we have som=
e
> sort of safe guard for the system as a whole as well, whereas before we=

> had none. Even a small ring size can keep queuing IO.
>=20
> Let me know what you guys think...
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 29ea1106132d..0d8c3b1612af 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -737,6 +737,25 @@ static struct io_kiocb *io_get_fallback_req(struct=
 io_ring_ctx *ctx)
>  	return NULL;
>  }
> =20
> +static bool io_req_over_limit(struct io_ring_ctx *ctx)
> +{
> +	unsigned inflight;
> +
> +	/*
> +	 * This doesn't need to be super precise, so only check every once
> +	 * in a while.
> +	 */
> +	if (ctx->cached_sq_head & ctx->sq_mask)
> +		return false;
> +
> +	/*
> +	 * Use 2x the max CQ ring size
> +	 */
> +	inflight =3D ctx->cached_sq_head -
> +		  (ctx->cached_cq_tail + atomic_read(&ctx->cached_cq_overflow));
> +	return inflight >=3D 2 * IORING_MAX_CQ_ENTRIES;
> +}

ctx->cached_cq_tail protected by ctx->completion_lock and can be
changed asynchronously. That's a not synchronised access, so=20
formally (probably) breaks the memory model.

False values shouldn't be a problem here, but anyway.


> +
>  static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>  				   struct io_submit_state *state)
>  {
> @@ -744,9 +763,11 @@ static struct io_kiocb *io_get_req(struct io_ring_=
ctx *ctx,
>  	struct io_kiocb *req;
> =20
>  	if (!percpu_ref_tryget(&ctx->refs))
> -		return NULL;
> +		return ERR_PTR(-ENXIO);
> =20
>  	if (!state) {
> +		if (unlikely(io_req_over_limit(ctx)))
> +			goto out_limit;
>  		req =3D kmem_cache_alloc(req_cachep, gfp);
>  		if (unlikely(!req))
>  			goto fallback;
> @@ -754,6 +775,8 @@ static struct io_kiocb *io_get_req(struct io_ring_c=
tx *ctx,
>  		size_t sz;
>  		int ret;
> =20
> +		if (unlikely(io_req_over_limit(ctx)))
> +			goto out_limit;
>  		sz =3D min_t(size_t, state->ios_left, ARRAY_SIZE(state->reqs));
>  		ret =3D kmem_cache_alloc_bulk(req_cachep, gfp, sz, state->reqs);
> =20
> @@ -789,8 +812,9 @@ static struct io_kiocb *io_get_req(struct io_ring_c=
tx *ctx,
>  	req =3D io_get_fallback_req(ctx);
>  	if (req)
>  		goto got_it;
> +out_limit:
>  	percpu_ref_put(&ctx->refs);
> -	return NULL;
> +	return ERR_PTR(-EBUSY);
>  }
> =20
>  static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int=
 *nr)
> @@ -3016,9 +3040,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx=
, unsigned int nr,
>  		unsigned int sqe_flags;
> =20
>  		req =3D io_get_req(ctx, statep);
> -		if (unlikely(!req)) {
> +		if (unlikely(IS_ERR(req))) {
>  			if (!submitted)
> -				submitted =3D -EAGAIN;
> +				submitted =3D PTR_ERR(req);
>  			break;
>  		}
>  		if (!io_get_sqring(ctx, &req->submit)) {
> @@ -3039,8 +3063,10 @@ static int io_submit_sqes(struct io_ring_ctx *ct=
x, unsigned int nr,
>  		if (link && (sqe_flags & IOSQE_IO_DRAIN)) {
>  			if (!shadow_req) {
>  				shadow_req =3D io_get_req(ctx, NULL);
> -				if (unlikely(!shadow_req))
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


--LHwWRQ0ZtTOplnfncTWROmMAUx9f7okjA--

--w5DUW3Pmp5UzgiKDlBHp6SalI1fwMVRFR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3GnIMACgkQWt5b1Glr
+6VUNBAApE8nu733+L96mHZSV8G++ctHpBIb1WucLECLOb4Agad45E3A87m1oIJC
NcP2kv/0gQo0EXUfwAVbQkB3lHn/yFjkUspIbAeXKvQOOy89g83O2Khel5DjD+F6
+8EC0NM68pxkvCoXlSF2UWMauLShzZKmubJEIeXQB29eeFUfjNp52ofMo0058MPW
1LKdpTcmaq9BopmmXxb8WHFZUVJBuiQlR3SHyk/5No4oL2ZMSaYd9FEJ9uYawzje
h5KIo/X8zvtCyKVpgWaal8/ReooS0bPqDB0wZ4n0yfjPreACUtp2I8bHtGxr9gdq
C8mbVVw5PDDScjWliTpiN8lBp2+t8EVjcY9dVG0UVO5dOGSCELWzmdJQh8kiWiA8
Qm96BoMtEm0U4Flw3aBCfIl1QYD0IK6qqKlXL1n0xShNHm42urT0quMo5WjHCGZf
D+NHTzlS2bIPZ1i0aGvJVRGNUmBdEvI2+xbHbs6y64N4Sb0rl34op0XgXwAGG/78
cuqCaI4Y98SOLuCZM1UIxlqoEx7Iwhf7xjQ3xzfLlh73jLc/+UXLSfpPYY7DqSRc
8vPrVL5v2nTLOORX2sAIBr9C5yGI4qwPGbQzd/N8g7Ekrz2zdZfVXXMMdyz01oGO
oPU+hedkcU0fFRVIOBRb6oKoEhHipus59SvvpqHAH7vElanLbao=
=l6xC
-----END PGP SIGNATURE-----

--w5DUW3Pmp5UzgiKDlBHp6SalI1fwMVRFR--
