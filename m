Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E83C5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 18:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A510217D7
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 18:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjMRme2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfKFSSW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:18:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34841 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfKFSSW (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 13:18:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id p2so1913565wro.2;
        Wed, 06 Nov 2019 10:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=qkfJQAt8u+zjQYupHcHKVUZxI5nQvEriTiRCojl/kyM=;
        b=hjMRme2ExJaxuKLzhLN1TzvOCpMGK5M2QtvHLuy8wHdELY51b5+KALekzS9jpgKgNw
         QdXf+/AjKKQS26AJmIjLsgn/YaFDjAej8SL0Ck5ngTKw5Y2mMjsriEALUM5lYV5BSFfe
         KjNypShRb/mNEUOwzxqM9H+d9d2lFLkTNdaV6Ozo6YKFTTtnnO1u5TP1STludTVNdQDq
         a8CNhHkT7uVJVbh7WoYl6RVtE6EByt+i8b7vGOddZw0NKDxKzS3M0e81B6I1kzwPrM7s
         uZ8d1Jem0QOoXKBijECShTGTVry9cePqzi+pyB6k/HUx5xHhLekC/9SqXxYg8hI72xvr
         3UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=qkfJQAt8u+zjQYupHcHKVUZxI5nQvEriTiRCojl/kyM=;
        b=DDiGc/WS4PLCXQ8oSoCoy3j0RtkMhXAC3Gi4Nol9CShexYJWadSjfnMCrAAGfX1Bv2
         OW71ZXmjH7Q5FyTp5/3T00TMywHYwGhQoV6/Znccv8Q9/dSaG3aXolJMFZWo3dXLJxtb
         eX4NIFImOWmNSW/YNH6cMfdoCilYP796kO7G2jL+OKUAiKM9A8wOR53hWY/GLu+RUTc2
         TpD9g4zEU8tkihDIAA9WJfTWkN/PWagbWAHxiD0ufH+mDjOYSGhYWZZHsV29gayWt2Jl
         xXOtElMgRTVhmfMJzYekajsCuuOyT9nipajxDnzsKZZiRWx2rPlbHbTWhTMoaiWYel0f
         2TvA==
X-Gm-Message-State: APjAAAU0lRmF9NnG6yN5G9XnDzDMAcID4a5hx4pf3BGYS67B0xUq3jgk
        /zId1ZuWnfXdcxLdsphDTrRzIC0OKXg=
X-Google-Smtp-Source: APXvYqztutKx3PtfIGc62owzcxZ5heymGYIUjoB/OyOoN81dzsxbYD5G3SGGQeJ9IUkV9DHbJoLWJg==
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr3959150wrw.222.1573064299070;
        Wed, 06 Nov 2019 10:18:19 -0800 (PST)
Received: from [192.168.43.132] ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id x7sm47744332wrg.63.2019.11.06.10.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 10:18:18 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Bob Liu <bob.liu@oracle.com>
References: <ca020164c33381c602d3188d95e0d650a5c625ac.1573058949.git.asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 1/1] io_uring: Remove extra io_commit_sqring()
Message-ID: <8bef0309-6dce-7ed3-7309-b38738265f5c@gmail.com>
Date:   Wed, 6 Nov 2019 21:17:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ca020164c33381c602d3188d95e0d650a5c625ac.1573058949.git.asml.silence@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zsViKMeCG846KwsfTraREW6rEFEs6Yrer"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zsViKMeCG846KwsfTraREW6rEFEs6Yrer
Content-Type: multipart/mixed; boundary="a1SBaAABv8fH1nVYr4ytXLKb6TRhc2Z2Z";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: Bob Liu <bob.liu@oracle.com>
Message-ID: <8bef0309-6dce-7ed3-7309-b38738265f5c@gmail.com>
Subject: Re: [PATCH 1/1] io_uring: Remove extra io_commit_sqring()
References: <ca020164c33381c602d3188d95e0d650a5c625ac.1573058949.git.asml.silence@gmail.com>
In-Reply-To: <ca020164c33381c602d3188d95e0d650a5c625ac.1573058949.git.asml.silence@gmail.com>

--a1SBaAABv8fH1nVYr4ytXLKb6TRhc2Z2Z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

This was noticed by Bob, though I haven't had time to fix and resend
the cleanup patches before they were applied.=20

On 06/11/2019 21:12, Pavel Begunkov wrote:
> io_submit_sqes() calls io_commit_sqring() at the end, so there is no
> need for sq_thread to repeat it.
>=20
> Fixes: 09c0eb1f1b93b9cf ("io_uring: Merge io_submit_sqes and
> io_ring_submit").
>=20
> Reported-by: Bob Liu <bob.liu@oracle.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/io_uring.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index ba77475c1cec..6524898831e0 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2868,9 +2868,6 @@ static int io_sq_thread(void *data)
>  		to_submit =3D min(to_submit, ctx->sq_entries);
>  		inflight +=3D io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm,
>  					   true);
> -
> -		/* Commit SQ ring head once we've consumed all SQEs */
> -		io_commit_sqring(ctx);
>  	}
> =20
>  	set_fs(old_fs);
>=20

--=20
Pavel Begunkov


--a1SBaAABv8fH1nVYr4ytXLKb6TRhc2Z2Z--

--zsViKMeCG846KwsfTraREW6rEFEs6Yrer
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3DDmEACgkQWt5b1Glr
+6UCyBAAqyk88Xap1OrxJRkfzXVmQILgYuAdplxxv/eAJEMU9mfyrLSCZ93WARIE
zzK++tUE1cz1u7d5c4Q5CDTI1jIrpsnofQ+uiUFh0DaSmORmhnfDdqP95OINZjOA
MivwlqamBSsYLZx3PfHsIXU+VfratT+3Rd8tpfyzuvc4ysgq4sDJDglGLZOmVB4g
cIAazg+eZF9129EgF26BfbEIGaScvSCnR7gLkx4epQMF7lmqdfOvwprCGqy4K6xx
mchVJfOkLeMT3f6gFUvFCyTiYKDLHPTCWi842o32lNpvVWof2UJRQtS9/l3Z63CU
DWRElncWFs6FIdqOajSSJPk9jq4hvAZxLBGjFBoQ6qweIz1Pyzh4ig1txpFkXwvl
5fmmd9iUY6xIDy22QA+YAjotrZX1td++f0QqY+TRSn+PasAjugMEw4F2UXQ1qzXz
l9l9M8xUQAsDeNCGU6UT3rBeN/rtz+B6BecHYdaw8FGwYh5ksBpgqyyMAP48ptCt
XOdHvYSyfTtTOHjYdEa7UXQw1D2uRu/i1OgqKNgytXmZJ1pyfSah98F6IKAiq5JB
4AfO4iU4x45ofWrVtE0K5Lc2WenuYOkZ9lRzXsEL1Bahrv3NCUNwvO9JUlmabQRq
WwK//q/MGHV5qXy3C/9XBuCF3XADUzEtopvSrEst43dXxPJ6mhY=
=10jU
-----END PGP SIGNATURE-----

--zsViKMeCG846KwsfTraREW6rEFEs6Yrer--
