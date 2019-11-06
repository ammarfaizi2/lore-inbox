Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BDCC5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3322173E
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlIsE9GA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKFWFT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:05:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38160 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKFWFT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 17:05:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so5512704wmk.3;
        Wed, 06 Nov 2019 14:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=p1r/b7AjfwEhrGrY3zSynTTOyFEJ8wM7kRl+FezclwM=;
        b=UlIsE9GABqebt1jTYV4w/mMYfLRNFiwzM2jwHPg53JGxGnFgeaX5vz1KCgvChazLUo
         AgQLQp/EgNjkyp9ouNieeOZ/CgvYBUb801kv0VfZz2VnHpAj1vmuvgn9Q+OdCstnl6H6
         j9qiiIB1oZRvqSMoy4dIZyYZ+dTZOmdA6qMeeh20Ug0NzjOa7IluR+iciEo2aI7udwh7
         MVQAKPKbsVGPzB766Sexwo5M+it4PM99eG1kE+xMe0nSu52Np62itpVI5M6UQ7GJRST+
         GG25FuIo7xvqFMeJKAfAv/ll/manLU0yXHM5bGhBt/vFi2G0AFW/g9sENpaDHrRYJRXE
         K/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=p1r/b7AjfwEhrGrY3zSynTTOyFEJ8wM7kRl+FezclwM=;
        b=pC0+2Hu5jkYcNz4K5k4LfJhY8sH5hRyJCXyQowuja8l3zv3CWonvslMte1lacpU1YD
         CKdzBhA/8k92uOPq44L2stCfsfIxSP5XoxBYBkOHRBlu5/3Ae5yhzQrrAdn1Mbd9wDnM
         ZqFHBHJIHdprVy1nQ5LYD5fH59wqP6dezmMh9QjwjRRxJzXFjhPo36GzQ3wsn7qY2Pqk
         Qcx8x3YgYdAfgMh6FEzsdyo3YweEV+Uu5mu9H0+e41SqvQF075JWl3YaqoTi23ZIDZr9
         ATFeerUsbaGUPqGTmPDOqJ6e+4s9EK9g77OZNPeTTiK7TIUQVC8DzPi9DUzHBPX7sj1W
         W2bw==
X-Gm-Message-State: APjAAAVaqdjO4S1I6+WsTUqM2DHROaP2s/tD/I3F1l8w7rH5tDMOWY7N
        G7YsbzmLMQom+AZf7p9bPU3+IGzHFmk=
X-Google-Smtp-Source: APXvYqyKx4Cr8/cPVeM2ocbZ0IXrBfMBdtVdag5XO9pMnbFymE0VpWUxFud0zl3AKqSJfAL3WWE/9g==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr4860287wmc.130.1573077915621;
        Wed, 06 Nov 2019 14:05:15 -0800 (PST)
Received: from [192.168.43.132] ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id q5sm118142wmc.27.2019.11.06.14.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 14:05:15 -0800 (PST)
Subject: Re: [PATCH v2 1/3] io_uring: allocate io_kiocb upfront
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1573077364.git.asml.silence@gmail.com>
 <ed30899d479bf40c6d386cac5d9401892836c3b5.1573077364.git.asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <3ba4d378-db8c-27ac-e7a1-ac13f361bd91@gmail.com>
Date:   Thu, 7 Nov 2019 01:05:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ed30899d479bf40c6d386cac5d9401892836c3b5.1573077364.git.asml.silence@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sUrP5cOkW2HQWcm0jxCQKGwPNg2ua0gU7"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sUrP5cOkW2HQWcm0jxCQKGwPNg2ua0gU7
Content-Type: multipart/mixed; boundary="XXeTZNjBoPkxpeGZ1kQnwcKXRq0d8Ghm8";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Message-ID: <3ba4d378-db8c-27ac-e7a1-ac13f361bd91@gmail.com>
Subject: Re: [PATCH v2 1/3] io_uring: allocate io_kiocb upfront
References: <cover.1573077364.git.asml.silence@gmail.com>
 <ed30899d479bf40c6d386cac5d9401892836c3b5.1573077364.git.asml.silence@gmail.com>
In-Reply-To: <ed30899d479bf40c6d386cac5d9401892836c3b5.1573077364.git.asml.silence@gmail.com>

--XXeTZNjBoPkxpeGZ1kQnwcKXRq0d8Ghm8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

This one changes behaviour a bit. If we haven't been able to allocate
req before, it would post an completion event with -EAGAIN. Now it will
break imidiately without consuming sqe. So the user will see, that 0
sqes was submitted/consumed.

Is that ok or we need to do something about it?=20

On 07/11/2019 01:00, Pavel Begunkov wrote:
> Let io_submit_sqes() to allocate io_kiocb before fetching an sqe.
>=20
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/io_uring.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 6524898831e0..0289bb3cc697 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2551,30 +2551,23 @@ static int io_queue_link_head(struct io_ring_ct=
x *ctx, struct io_kiocb *req,
> =20
>  #define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK=
)
> =20
> -static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *=
s,
> -			  struct io_submit_state *state, struct io_kiocb **link)
> +static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *re=
q,
> +			  struct sqe_submit *s, struct io_submit_state *state,
> +			  struct io_kiocb **link)
>  {
>  	struct io_uring_sqe *sqe_copy;
> -	struct io_kiocb *req;
>  	int ret;
> =20
>  	/* enforce forwards compatibility on users */
>  	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
>  		ret =3D -EINVAL;
> -		goto err;
> -	}
> -
> -	req =3D io_get_req(ctx, state);
> -	if (unlikely(!req)) {
> -		ret =3D -EAGAIN;
> -		goto err;
> +		goto err_req;
>  	}
> =20
>  	ret =3D io_req_set_file(ctx, s, state, req);
>  	if (unlikely(ret)) {
>  err_req:
>  		io_free_req(req, NULL);
> -err:
>  		io_cqring_add_event(ctx, s->sqe->user_data, ret);
>  		return;
>  	}
> @@ -2710,9 +2703,15 @@ static int io_submit_sqes(struct io_ring_ctx *ct=
x, unsigned int nr,
> =20
>  	for (i =3D 0; i < nr; i++) {
>  		struct sqe_submit s;
> +		struct io_kiocb *req;
> =20
> -		if (!io_get_sqring(ctx, &s))
> +		req =3D io_get_req(ctx, statep);
> +		if (unlikely(!req))
>  			break;
> +		if (!io_get_sqring(ctx, &s)) {
> +			__io_free_req(req);
> +			break;
> +		}
> =20
>  		if (io_sqe_needs_user(s.sqe) && !*mm) {
>  			mm_fault =3D mm_fault || !mmget_not_zero(ctx->sqo_mm);
> @@ -2740,7 +2739,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx=
, unsigned int nr,
>  		s.in_async =3D async;
>  		s.needs_fixed_file =3D async;
>  		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, async);
> -		io_submit_sqe(ctx, &s, statep, &link);
> +		io_submit_sqe(ctx, req, &s, statep, &link);
>  		submitted++;
> =20
>  		/*
>=20

--=20
Pavel Begunkov


--XXeTZNjBoPkxpeGZ1kQnwcKXRq0d8Ghm8--

--sUrP5cOkW2HQWcm0jxCQKGwPNg2ua0gU7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3DQ44ACgkQWt5b1Glr
+6WMlQ/+PMogv5RyePk3ok4faFLnTFlkoPJ3N8cpxIyQpim6zN7DsGli/BnN+ZGx
DrZSNJEfw6rEPRW+0At2PWdqhqRkBmUMF4DpymPqB38UQS7jEd83+GxpfR8P4XYU
cL9Q+ETfJTW2+UTpwT924uKV7qNlpgxYfGm9nFPa5HWUg1qfxISamlkRPeh9U6N+
RfyUps6BxL0npEReZ1H2IKLz9b9lo7XaJcMfT52+pa2exLVVWlp93GevjICKy3ow
wFVALiKIQjvjBCay5DiY9x4+UoNyZGykxpDT27KqdN7sVYTwUbxRGCi4s/TvGDP+
m61oI84Hqnw364ExYHaiEYlVELmvQjryj/H2iGTML7VVX3/LhDuiCSQ3/D+iYuXa
ltcn+RMEhncg4734zYJiY+DdWHzjIjthXzB2wTCw+7rkDrhErcryHcsgb36YI3U0
MUIw3if/eaQPSSXK3PUS95XyAWJgZ4rjcNkqlnIUs8IbAr5K8QJZbT+5+EaGFs3B
NPc+IMnJd8dnwCFg9ATq07eX+PjbhSWhCqHx54f+cmRn54ywoYdb9P37p2wY0zy0
9uPyNzi5mAEOd/yj+WnWBylbUaYsiA5N+ErSBT9a8ww6B06V48+whmoC07zU9u2e
uyCCOi6j4TwDjObmVPQiy7XUJaZXlXm60XJyqcs3e1aRTvV7KxI=
=q8js
-----END PGP SIGNATURE-----

--sUrP5cOkW2HQWcm0jxCQKGwPNg2ua0gU7--
