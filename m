Return-Path: <SRS0=ex/T=ZC=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1BFC43331
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 13:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C0C20818
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 13:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZVHwx6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfKJNhT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 10 Nov 2019 08:37:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34005 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfKJNhT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 10 Nov 2019 08:37:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id j18so1223434wmk.1
        for <io-uring@vger.kernel.org>; Sun, 10 Nov 2019 05:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=onOmLLZuKg3odcBHpnac/ZN75J/kVPxcS/iR/p/lsvA=;
        b=uZVHwx6IoapELwW+CfTkpFaWF6gr29TKaaoW01yqX/pJh5JQVzIA5X/th9GMawYLQ5
         FIfx70G6PqXYOwYaOXEHyB+iGkej7qsKSyMFm6AY1GvsGg7rdrRRiWcqwlIBgFmJfdBm
         Muxo2qtM1uKOarFrnQTZMyommwQq9xIaJMPNi3EonlZpp7EfsMeoRQw1AwzJ/DD1d+yY
         S2tjiHBhbrLdw3JgqfzTlxQGfVTcphRBt6y+NZ24uiv6SzStc7qt81oULad7cFCnM6yH
         HmzBfrvU950M5FgrifYTM6zgysgeGONU83cDic+hWe7WKi+2+vsLfp6hLodFfTRrc2Ra
         mJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=onOmLLZuKg3odcBHpnac/ZN75J/kVPxcS/iR/p/lsvA=;
        b=nc8EqkBLvrXDlqMsONFvh8XHCKsEZ5S+T5F8n+1awYs/cVXnlG2kbfpPek8BBCUg1N
         peWD/KxnPFYgALQULk/JKPJlvSFUFGKv2YGSXX22UwgysmjmxPvnOMRXxVZbUcDfXk+g
         5zoQhKGy+ZUV2A3Q7CNCIrbmd2BpN6gkoSj55ORwOUnHP6OTPD9pJ0RTPACIc1J30Tyf
         qM7O7Zeh/3InibTlErJVg9JzEc+Md72Jie/gwqBs6GAjBovyTd5wjxRqd0NdQI0vn3Oz
         IdTi8En897zsNygJvr9zB7tIyNikZteBRSfCOreO9sYcfrePXZvKn/fPKRwDrIyI1vut
         PHYw==
X-Gm-Message-State: APjAAAX45AqP3dgayxKsfD39Zs1wJXwGSJXQfy5jmm00WUq4OTlwjwJZ
        JK+e0yI2LjocbCWJoSAzVhPwohJi
X-Google-Smtp-Source: APXvYqzFGZXrE+SWIsfGrFtvcXGtau9OaWGkzX7kcXn3eqiy5OHRiQA0ajTgd6FD4Y4FgfSccxXE5Q==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr16747173wma.140.1573393035570;
        Sun, 10 Nov 2019 05:37:15 -0800 (PST)
Received: from [192.168.43.201] ([109.126.135.169])
        by smtp.gmail.com with ESMTPSA id w81sm18403802wmg.5.2019.11.10.05.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 05:37:14 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <8c57d694-6f73-4ac7-f390-ffbb3d780fea@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v4] io_uring: limit inflight IO
Message-ID: <f31d824c-a531-9d13-dcdc-f606de761693@gmail.com>
Date:   Sun, 10 Nov 2019 16:36:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <8c57d694-6f73-4ac7-f390-ffbb3d780fea@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kTmQx37tt2gm9W13KpPAHnP6yt7xGIykB"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kTmQx37tt2gm9W13KpPAHnP6yt7xGIykB
Content-Type: multipart/mixed; boundary="wcVroYOI6b7AdJ6TSD3AOrjjeqsOktS5J";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <f31d824c-a531-9d13-dcdc-f606de761693@gmail.com>
Subject: Re: [PATCH v4] io_uring: limit inflight IO
References: <8c57d694-6f73-4ac7-f390-ffbb3d780fea@kernel.dk>
In-Reply-To: <8c57d694-6f73-4ac7-f390-ffbb3d780fea@kernel.dk>

--wcVroYOI6b7AdJ6TSD3AOrjjeqsOktS5J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/11/2019 00:01, Jens Axboe wrote:
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
> Changes since v3:
> - Fixup masking for when to check (Pavel)
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 472bbc11688c..a2548a6dd195 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -745,7 +745,7 @@ static struct io_kiocb *io_get_req(struct io_ring_c=
tx *ctx,
>  	struct io_kiocb *req;
> =20
>  	if (!percpu_ref_tryget(&ctx->refs))
> -		return NULL;
> +		return ERR_PTR(-ENXIO);
> =20
>  	if (!state) {
>  		req =3D kmem_cache_alloc(req_cachep, gfp);
> @@ -791,7 +791,7 @@ static struct io_kiocb *io_get_req(struct io_ring_c=
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
> @@ -2997,6 +2997,31 @@ static bool io_get_sqring(struct io_ring_ctx *ct=
x, struct sqe_submit *s)
>  	return false;
>  }
> =20
> +static bool io_sq_over_limit(struct io_ring_ctx *ctx, unsigned to_subm=
it)
> +{
> +	unsigned inflight;
> +
> +	if (!list_empty(&ctx->cq_overflow_list)) {
> +		io_cqring_overflow_flush(ctx, false);
> +		return true;
> +	}
> +
> +	/*
> +	 * This doesn't need to be super precise, so only check every once
> +	 * in a while.
> +	 */
> +	if ((ctx->cached_sq_head & ~ctx->sq_mask) !=3D
> +	    ((ctx->cached_sq_head + to_submit) & ~ctx->sq_mask))
> +		return false;

Still not quite agree, with "!=3D" it will check almost every time.
We want to continue with the checks only when we overrun sq_entries
(i.e. changed higher bits).


There is a simplified trace: let
1) mask =3D=3D 3, ~mask =3D=3D 4
2) head =3D=3D 0,
3) submitting by one

1: (0 & 4) !=3D (1 & 4): false // do checks
2: (1 & 4) !=3D (2 & 4): false // do checks
3: (2 & 4) !=3D (3 & 4): false // do checks
4: (3 & 4) !=3D (4 & 4): true // skip, return true


The rest looks good,
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>


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
> @@ -3007,10 +3032,8 @@ static int io_submit_sqes(struct io_ring_ctx *ct=
x, unsigned int nr,
>  	int i, submitted =3D 0;
>  	bool mm_fault =3D false;
> =20
> -	if (!list_empty(&ctx->cq_overflow_list)) {
> -		io_cqring_overflow_flush(ctx, false);
> +	if (unlikely(io_sq_over_limit(ctx, nr)))
>  		return -EBUSY;
> -	}
> =20
>  	if (nr > IO_PLUG_THRESHOLD) {
>  		io_submit_state_start(&state, ctx, nr);
> @@ -3022,9 +3045,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx=
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
> @@ -3045,8 +3068,10 @@ static int io_submit_sqes(struct io_ring_ctx *ct=
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


--wcVroYOI6b7AdJ6TSD3AOrjjeqsOktS5J--

--kTmQx37tt2gm9W13KpPAHnP6yt7xGIykB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3IEn0ACgkQWt5b1Glr
+6XjtQ//XG5yiIsdmU12vrIicDqORJ9cKOzGLbrF8dmgjGYqIIDPmtGAcoLm0J3d
N+L/kv3KTQSWutxCCe/NYa7gtOLn39AI4mK0uBYXs69bBSixGR6bUR6tHuhM1cME
FS/uKEEfHmQlh2/yI/neYJZENUax1tQjK1bTV9VWTfZW3385xex+INNviHc6xY05
l56q9f0lG906GMpnY/E4M0ocVL/jx8beIvISNtc5MWjeKGo5pphWqJHSOCUd6NaN
AOlqOVKb0rE7uMex5M61TzETxK2cVuyNXPSppvBtADIQs3v50HrI/TcZFYeUiQhK
1yAQslnTCkfR4OOlZ/P6j672avOQq0PfIKEltKWJ+vhHsGkRukO93BaAWcauIqru
Kc6gQ+eOkE6k5xDZ1+pPjBYBA3ikQTOPrU0YPk1RAhw7L4IgYA9VyNvENooyLDKP
9hukptlxQoEp+hHqo8ngbyHExJPlnhj3gAK8W8PwnkcQZHLj07Xrc7So4jciNtVU
C3nN2OvvNY6/qghROy4gg/n71AuCSbbzmx1dzjA71+fWA8yCWrUIC1yTVh/ipqQu
+R4KdOB7s2sk66KVg8H+J6LAE8XjTvlBJUpJlCdg2ISLnvfIDwvplR+1xgXJFcx8
lrg7OS3tpMt4NwLMScgdEHetwkW9lAFn/u9VWMcMCmLPhc26ym8=
=OZiG
-----END PGP SIGNATURE-----

--kTmQx37tt2gm9W13KpPAHnP6yt7xGIykB--
