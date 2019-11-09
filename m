Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D77C43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 19:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7193421882
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 19:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycy8MjY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfKITRS (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 14:17:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33573 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfKITRR (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 14:17:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id w9so3733796wrr.0
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 11:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=Msp37BDhCrnmC8p/9b+BDoxma2uQba8L1E8A5FfVRWM=;
        b=Ycy8MjY0RjCwXxMYSVOQyCmSmwP02xf2OQsxUjL1LfzGUR1WNZf3g4lPbSTyEuMGwZ
         19MYAFgZxkOvTUTUl3RBGmqgMdF5fBg5caYHjKRd47lSF39Of5/7/5st1qmsftenu7Rw
         5Bdhf4Fn/uJB1PYc1hHQoPjBu6aqSQapExYwI2zU9O/iDjZrGSBgQg4GtjEFBYSP2Ta6
         EnEykRcO9DL0eohPr6qJWrHDtIwAETx32arSiJDAOvhBkRTOOVWBbfkJOgUt7i3dn8Ym
         zmvsivIVOxhSAnYH6ISnRRg5GYYW5IMYUamGq8gzKAbElHROFS4twrFQIPTy7XLLoobF
         PtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=Msp37BDhCrnmC8p/9b+BDoxma2uQba8L1E8A5FfVRWM=;
        b=hPkL7msVkwSIuCmph052QTP+XczSvvLy/EJd8YkAe26XO2ELmVbFrO0SzOXC6e1Zrg
         bzl3HGSSiHO36VVdW/mcddgCeAMU/ut/wRggfd2TraIQFDYz2/QX/lEnZHaQqB4V215c
         PCgKIbzkvr4nehsCMyiyv8sbGSU5gAoz5NJHhUDZMEJMPGvzKlbamezuL9ZmzchTsOZu
         an7Ye9VzAQC0odqcudML8l+Ll8gl7YUIiJzm1D7pSV8Roq/ruGb7xUqxb1sOrqE0/DBs
         dXv+vJ3wii2WqjuJI3BC8kVD+YqifFAGyZLgoOtdGz8dD4P0WlCPeRlnEjzLvgrOBliV
         GGzw==
X-Gm-Message-State: APjAAAUBXD+cYTJ83zlzWCZZSdFZKzZ1oDH5t+cSD0PBwewKytEsFcYo
        guGQ8CGVgUuVc73cSBeSmTZ8XDDe
X-Google-Smtp-Source: APXvYqzq5qR0YbbRF5+jFNM2La0NK3xh5JE/JZUpMuL6rAqC7Put2ZkW4IHwP7bzyBWbXyPgD9syCg==
X-Received: by 2002:adf:ab41:: with SMTP id r1mr15065117wrc.281.1573327033666;
        Sat, 09 Nov 2019 11:17:13 -0800 (PST)
Received: from [192.168.43.77] ([109.126.135.169])
        by smtp.gmail.com with ESMTPSA id z11sm8868276wrg.0.2019.11.09.11.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2019 11:17:12 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <ecf5959a-9853-5526-9764-ac273649a5f4@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v3] io_uring: limit inflight IO
Message-ID: <8d4610ab-48b0-8f55-27f0-ca760ff5be5f@gmail.com>
Date:   Sat, 9 Nov 2019 22:16:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <ecf5959a-9853-5526-9764-ac273649a5f4@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OrScgFeg6WSHVa0XElPmR6J8HhxrGAA1S"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OrScgFeg6WSHVa0XElPmR6J8HhxrGAA1S
Content-Type: multipart/mixed; boundary="OUK9XpncAAGyFc3GUHchY4ROUXqdskUN3";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <8d4610ab-48b0-8f55-27f0-ca760ff5be5f@gmail.com>
Subject: Re: [PATCH v3] io_uring: limit inflight IO
References: <ecf5959a-9853-5526-9764-ac273649a5f4@kernel.dk>
In-Reply-To: <ecf5959a-9853-5526-9764-ac273649a5f4@kernel.dk>

--OUK9XpncAAGyFc3GUHchY4ROUXqdskUN3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/11/2019 18:21, Jens Axboe wrote:
> With unbounded request times, we can potentially have a lot of IO
> inflight. As we provide no real backpressure unless
> IORING_SETUP_CQ_NODROP is set, and even there there's quite some delay
> between overflows and backpressure being applied, let's put some safety=

> in place to avoid going way overboard.
>=20
> This limits the maximum number of inflight IO for any given io_ring_ctx=

> to twice the CQ ring size. This is a losely managed limit, we only chec=
k
> for every SQ ring size number of events. That should be good enough to
> achieve our goal, which is to prevent massively deep queues. If these
> are async requests, they would just be waiting for an execution slot
> anyway.
>=20
> We return -EBUSY if we can't queue anymore IO. The caller should reap
> some completions and retry the operation after that. Note that this is
> a "should never hit this" kind of condition, as driving the depth into
> CQ overflow situations is unreliable.
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>=20
> ---
>=20
> Changes since v2:
>=20
> - Check upfront if we're going over the limit, use the same kind of
>   cost amortization logic except something that's appropriate for
>   once-per-batch.
>=20
> - Fold in with the backpressure -EBUSY logic
>=20
> - Use twice setup CQ ring size as the rough limit
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 81457913e9c9..9dd0f5b5e5b2 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -744,7 +744,7 @@ static struct io_kiocb *io_get_req(struct io_ring_c=
tx *ctx,
>  	struct io_kiocb *req;
> =20
>  	if (!percpu_ref_tryget(&ctx->refs))
> -		return NULL;
> +		return ERR_PTR(-ENXIO);
> =20
>  	if (!state) {
>  		req =3D kmem_cache_alloc(req_cachep, gfp);
> @@ -790,7 +790,7 @@ static struct io_kiocb *io_get_req(struct io_ring_c=
tx *ctx,
>  	if (req)
>  		goto got_it;
>  	percpu_ref_put(&ctx->refs);
> -	return NULL;
> +	return ERR_PTR(-EBUSY);
>  }
> =20
>  static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int=
 *nr)
> @@ -2992,6 +2992,30 @@ static bool io_get_sqring(struct io_ring_ctx *ct=
x, struct sqe_submit *s)
>  	return false;
>  }
> =20
> +static bool io_sq_over_limit(struct io_ring_ctx *ctx, unsigned to_subm=
it)
> +{
> +	unsigned inflight;
> +
> +	if ((ctx->flags & IORING_SETUP_CQ_NODROP) &&
> +	    !list_empty(&ctx->cq_overflow_list))
> +		return true;
> +
> +	/*
> +	 * This doesn't need to be super precise, so only check every once
> +	 * in a while.
> +	 */
> +	if ((ctx->cached_sq_head & ctx->sq_mask) !=3D
> +	    ((ctx->cached_sq_head + to_submit) & ctx->sq_mask))
> +		return false;

ctx->sq_mask =3D sq_entries - 1, e.g. 0x0000...ffff.
Thus the code above is modular arithmetic (% sq_entries) and
equivalent to:

if (to_submit !=3D sq_entries)
	return false;
=20
I suggest, the intention was:

if ((sq_head & ~mask) =3D=3D ((sq_head + to_submit) & ~mask))
	return false;


> +
> +	/*
> +	 * Limit us to 2x the CQ ring size
> +	 */
> +	inflight =3D ctx->cached_sq_head -
> +		  (ctx->cached_cq_tail + atomic_read(&ctx->cached_cq_overflow));
> +	return inflight > 2 * ctx->cq_entries;
> +}
> +
>  static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>  			  struct file *ring_file, int ring_fd,
>  			  struct mm_struct **mm, bool async)
> @@ -3002,8 +3026,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx=
, unsigned int nr,
>  	int i, submitted =3D 0;
>  	bool mm_fault =3D false;
> =20
> -	if ((ctx->flags & IORING_SETUP_CQ_NODROP) &&
> -	    !list_empty(&ctx->cq_overflow_list))
> +	if (unlikely(io_sq_over_limit(ctx, nr)))
>  		return -EBUSY;
> =20
>  	if (nr > IO_PLUG_THRESHOLD) {
> @@ -3016,9 +3039,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx=
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
> @@ -3039,8 +3062,10 @@ static int io_submit_sqes(struct io_ring_ctx *ct=
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


--OUK9XpncAAGyFc3GUHchY4ROUXqdskUN3--

--OrScgFeg6WSHVa0XElPmR6J8HhxrGAA1S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3HEKoACgkQWt5b1Glr
+6VAvQ/9GtwRyUdQbXdoJK7tvDBFmKwE/YVBgyvjJg/C7bH5et4ZmkWs3MLyLjvd
8VGD+J3+51GxyOWHJyUZDi07bvwumr3gLWrribQc8Ch30tCO98JWAO+GjU4awLtC
NlxkqtS9u4t3QkToIEc42e/543ElBHdkf++KifkSHtmWMhAEJ6MW+blxyLRAwsNS
AHiFzdXSequaqTRCpEfjCQyyXuSFJbwPF9h3Cz81KAdOkNUc0rnq1OZUtNAWBdVq
8GhImlLIBWlIja9E+f71BxAOwxM68oK/nxXBwe9AqZqNzt0J8/K4/Md7CIN5GQjO
DRgCmXQ2XPuqszzHmSudTLcwQR9jqeRJ+E+n5tKMmiyiAH6sGEsa6vSD7wdtSp5S
AqdqTwy0J1DQEGIPdUC7Q6CHQlxQCxO7TwkuIhn2cC5OoLCJktjSUFU4KmdxMwDh
SmgKnItprqp1+yZFn2+HinSn0bCal80DEdpUck1Ygv+ddhYQjQRYZlxc8sCLIWu/
xlBtHSx1uP/U5FrQTZ2Ut08+WkIgEVbUugxFqC0/o3YED5StqcKp8wLZiYCgPu2F
FcG1ENJ70b/OxQmfXKhm6TyASyVB9oCDwPCe077rl6KwaB1Rdx4TFEBhyFGFP6Ns
dvkrndTWaN9PTj2AAogFeXW6e0izyHKDu4Zx4f/TchP353Xjtfw=
=BISr
-----END PGP SIGNATURE-----

--OrScgFeg6WSHVa0XElPmR6J8HhxrGAA1S--
