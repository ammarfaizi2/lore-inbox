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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A25C17440
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 09:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D2A21882
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 09:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NERzkO75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfKIJ7g (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 04:59:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45940 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfKIJ7g (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 04:59:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so4325843wrs.12
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 01:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:references:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=cpF15TNRfPhnXL76uKlU/8aFHngpA10iIFi1tJRaiSU=;
        b=NERzkO75RraWE44cboeIloBydfKmbYqpQumFZTXRNZxWjYvEVze2HUfaADoQwGIXFE
         TaGgx3CZ8c1lxBlF4iLqPQOE4C5FhCPviTxd3G3qaQ6smDCGIzxUtbbV/Q+H2iGSvSre
         DDyiN9bFP7wzvuZKxQlGFQDrhfpSWHlJmFKx8z+VMN8ZsePuMsHyaCAbBiV/ZiOrm9X5
         cjqHcaGW11oXHZLQB+5WRBEMQEWiY7orQnPK0rGM0p0IuRbpF/TCUc1fihsQAurHqvr6
         LJjWmu3w6RZJBaUyVw+w4SldkCKOz9m6ey0cl32YIukhcYQl5MjFLRo99yDfja7B1I7V
         Murg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=cpF15TNRfPhnXL76uKlU/8aFHngpA10iIFi1tJRaiSU=;
        b=qgp7E1a5rvdJ98Uj1gdam7SX+bdCFX05VTL5TFztANft8vs5Xrw/fHwCuFprnirO3n
         /s3wOiXoGOd+47JPDX2O9Vel5wmtYgilufFJIPzrIwkWM+Il3+ayQ1cjOR5DmDrzz0ou
         Gy/7+e6X5goyL65gvRmkXoZV2d8KgRPevABmB5yk1yREHBw4GjCqkYqAv6kCtXKlOZ4m
         Il3f6YRpzlNUwjLOT9WVchyJ/lA2iZ3Xp12HMeqfxwsnKuiOZg/bXkWiG4pA3Nuzenyg
         q6Ne2IIsSpie5zqLhDdDfrXU1OvZZGR51yYkqKsYF6LmaxDvOVWca5ohXANJL0pjEbPT
         R7hQ==
X-Gm-Message-State: APjAAAXbkaLNe98eCqxPmtIENq8XuzEbOtCZ3zIUi3TLXO5hgCXGJKfB
        rIQ+xbTk/ZZaAWDdpyDfFarCFIXG
X-Google-Smtp-Source: APXvYqyEKnmkaxFJ36ZpfThsXzGlcn5IMkH791cUzs6+NK9kZLLezXN0TnCUX0d5CoBZp8EEDBQMNQ==
X-Received: by 2002:a5d:51c8:: with SMTP id n8mr3077811wrv.302.1573293573085;
        Sat, 09 Nov 2019 01:59:33 -0800 (PST)
Received: from [192.168.43.163] ([109.126.130.90])
        by smtp.gmail.com with ESMTPSA id i13sm8273228wrp.12.2019.11.09.01.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2019 01:59:32 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <16c996fa-61e9-74b9-bc61-b31ecc085c87@kernel.dk>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] io_uring: account overflows even with
 IORING_SETUP_CQ_NODROP
Message-ID: <bad714dd-5c79-df38-1aef-7b8bf1cb1a94@gmail.com>
Date:   Sat, 9 Nov 2019 12:59:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <16c996fa-61e9-74b9-bc61-b31ecc085c87@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JQRAeXRTHFyc3LK37dRy4Xv7iMhBYnsTs"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JQRAeXRTHFyc3LK37dRy4Xv7iMhBYnsTs
Content-Type: multipart/mixed; boundary="CeIWsDeY1BymYtldFvplUD6B8yDBl9IjS";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <bad714dd-5c79-df38-1aef-7b8bf1cb1a94@gmail.com>
Subject: Re: [PATCH] io_uring: account overflows even with
 IORING_SETUP_CQ_NODROP
References: <16c996fa-61e9-74b9-bc61-b31ecc085c87@kernel.dk>
In-Reply-To: <16c996fa-61e9-74b9-bc61-b31ecc085c87@kernel.dk>

--CeIWsDeY1BymYtldFvplUD6B8yDBl9IjS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/11/2019 18:51, Jens Axboe wrote:
> It's useful for the application to know if the kernel had to dip into
> using the backlog to prevent overflows. Let's keep on accounting any
> overflow in cq_ring->overflow, even if we handled it correctly. As it's=

> impossible to get dropped events with IORING_SETUP_CQ_NODROP, overflow
> with CQ_NODROP enabled simply provides a hint to the application that i=
t
> may reconsider using a bigger ring.
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>=20
> ---
>=20
> Since this hasn't been released yet, we can tweak the behavior a bit. I=

> think it makes sense to still account the overflows, even if we handled=

> it correctly. If the application doesn't care, it simply doesn't need t=
o
> look at cq_ring->overflow if it is using CQ_NODROP. But it may care, as=

> it is less efficient than a suitably sized ring.
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 94ec44caac00..aa3b6149dfe9 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -666,10 +666,10 @@ static void io_cqring_overflow(struct io_ring_ctx=
 *ctx, struct io_kiocb *req,
>  			       long res)
>  	__must_hold(&ctx->completion_lock)
>  {
> -	if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
> -		WRITE_ONCE(ctx->rings->cq_overflow,
> -				atomic_inc_return(&ctx->cached_cq_overflow));
> -	} else {
> +	WRITE_ONCE(ctx->rings->cq_overflow,
> +			atomic_inc_return(&ctx->cached_cq_overflow));
> +
> +	if (ctx->flags & IORING_SETUP_CQ_NODROP) {

We used cq_overflow to fix __io_sequence_defer().
This breaks the assumption:
cached_cq_tail + cached_cq_overflow =3D=3D=20
	total number of handled completions

First, we account overflow, and then add it to cq_ring
(i.e. cached_cq_tail++) in io_cqring_overflow_flush()


>  		refcount_inc(&req->refs);
>  		req->result =3D res;
>  		list_add_tail(&req->list, &ctx->cq_overflow_list);
>=20

--=20
Pavel Begunkov




--CeIWsDeY1BymYtldFvplUD6B8yDBl9IjS--

--JQRAeXRTHFyc3LK37dRy4Xv7iMhBYnsTs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3GjfgACgkQWt5b1Glr
+6WJfw//QKII8Ge4ZgnbHjuQejbW2vS1LR6fFlMa97abrhB3N2jgMJ5RbbcyQTSu
WpEALhPLIROPCSHr/j9f9s0T4LCUxy1UCNRAYfBoOq63rCkn8mt0e5CAnNwwvbE3
3F0A7q9o76OD5EWlqutxGj/82Zj3Efvk+z1dudBosjYnuklFHS4DPzzT1xexHGv1
Td+yTusPbJ9otzWoR9S9KlFoDxp4VtKct4N6ZMhNzOgp++xMwwEvGUc4n4apt/sC
dTWRh+tbsY2Bn/4uNGhdmtCtNzqBx2Im4a6DNlOpBIeOBWQ8eK5vg7JTWvfEI13g
+8K8YwUoifnlhFaS2G45RBATGY9bfs1JA8ui1DuPbE4UCjs0ka2lG6lXPHPGisq3
XLcQvmQEUoHCBDnU2o8Qznerge6EXfoRqourQqCaPMxllQyx97jNth/nStROfmNc
/b6hAP/P4Cp7L0m5Fjiwcw37UIz6aLsAeoCKFF8ak3GMGfR0hsE+rj5EHyoIyr1q
z/UQKd6wtBB6wnuv6kfXMknOF2Q3w3TSTwsapnbl2WaM9p+N9yzcpJEfviY2f3bg
xKaDDcXPOnxkvYFsdynUoJ0FZ3S3kWuOKwxm1lwfrlFzVLG3+5cWoxqNh4KYGz8j
a3C6HJ82u10FNe9/ct76ZrQXaXN1ECrPOuu+mmSdx5xH9dZf8Ok=
=EoW+
-----END PGP SIGNATURE-----

--JQRAeXRTHFyc3LK37dRy4Xv7iMhBYnsTs--
