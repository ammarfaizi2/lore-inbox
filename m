Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F6AC5DF60
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 09:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DD12166E
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 09:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUD4gegc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfKGJY2 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:24:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34187 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfKGJY1 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 04:24:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id e6so2193756wrw.1
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 01:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=aaHEPuI81fXJvJl1mVmWU4dD1zz28f295pK4Ud9kSPo=;
        b=mUD4gegcHCo7v66yVlioDdgcGMX9y1pvr+W7pY+F4EK5EMUEWKYyrhZJurubRWMwkl
         7eGeKzvOjuwY/IE0E+59lkqZKA3yX2nvLbHW+Iv2GCdJbmEzkFx2MWBfJ2WZt9BmhmxO
         5Be6xOYy7LwWsNKEqAjafjhxCKAjIz/Y2W/6pBFDkgECulMucD6a64KzWlKyLTSePvx/
         ECIt6fGSLD2wBp9iq1EGbjNSvH++ZMTALwPSVix1I/bI50kd6Pms15MXthB3871OTBog
         nlKchBE+f4PLbnbps9SH1e+otVemvpBxE/uYFXHrqx2gM19bjl5nxwr0FHWD7jof/nid
         wssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=aaHEPuI81fXJvJl1mVmWU4dD1zz28f295pK4Ud9kSPo=;
        b=CMAB6OauQeGFiwSNDHIn0h+QaubVbHwgz5kKN15yBJO+Rv6vtNDwWC7KkMnQIRZIem
         1nTqasOTR6Z8I4pGFX4gpfVOYzxLtvypitm/uOB93mw36ewDKiy7hz3LxsCiTDz+b3Iy
         RKUG17FRT26bGTo/QN/OKYlaJjw+H0JzYf9s6AQ3xOCyHIyLYt1CHmyq11tvxJ8YSveq
         hZY7Y1uvsQabwxQMdNTd4Z2StCcpsfh4Q13ow/BMv6q/jqHcqk1B+LPfoTXbDu+/k2tW
         lHcDQaupqdBNRL358QVpsOO+G//2tBOFTut6dRusNfYx88PzMlK6jodkXjyPgmgYqzRH
         xYxg==
X-Gm-Message-State: APjAAAX1msYt4juO52WkxxvuHuj/ww6PiH5ilmMJMbW6q+YcJt8DxU3c
        sxSh+M9T5vXXyvXYp1aAb2FQaEEd
X-Google-Smtp-Source: APXvYqyne7+4oYT5X7wkys2osl77Hxo5RiVngbPVLVhQKNXIJnnj0PQeQ9NPQ0v8V0hQ1eg+QGrcQA==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr1824712wro.305.1573118664236;
        Thu, 07 Nov 2019 01:24:24 -0800 (PST)
Received: from [192.168.43.132] ([109.126.148.209])
        by smtp.gmail.com with ESMTPSA id b3sm1703972wmh.17.2019.11.07.01.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 01:24:23 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <4e41bfad-d7ec-6381-741c-0261f321617a@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: fixup for "io_uring: allocate io_kiocb upfront"
Message-ID: <2ed217ce-6a17-7364-6752-73b16ff6fc2f@gmail.com>
Date:   Thu, 7 Nov 2019 12:24:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4e41bfad-d7ec-6381-741c-0261f321617a@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eGeNJNYnWQgwuQLIXm81Rce6uVWnUw4zJ"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eGeNJNYnWQgwuQLIXm81Rce6uVWnUw4zJ
Content-Type: multipart/mixed; boundary="AzFlLVkyFY0Btcr0LcEgHApAfHDq4lYiH";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <2ed217ce-6a17-7364-6752-73b16ff6fc2f@gmail.com>
Subject: Re: fixup for "io_uring: allocate io_kiocb upfront"
References: <4e41bfad-d7ec-6381-741c-0261f321617a@kernel.dk>
In-Reply-To: <4e41bfad-d7ec-6381-741c-0261f321617a@kernel.dk>

--AzFlLVkyFY0Btcr0LcEgHApAfHDq4lYiH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/11/2019 06:20, Jens Axboe wrote:
> Pavel,
>=20
> I didn't read this one closely enough for the latest change, we
> can't just return -EAGAIN if we don't submit anything, we have to
> explicitly do it for just the failure case of not getting a request.
> I'm going to fold in this incremental:
>=20
My bad, it should be a common case to have @to_submit >=3D nr_sqes_in_rin=
g
(i.e. I don't care, just submit all). Thanks for fixing it.
Also, if it submitted @n (>0), and can't allocate for @n+1, I'd rather
prefer to get submitted count.

BTW, I found this "one return value for both submit() and wait_cqes()"
a bit confusing. In addition, there is reporting through cqe, and
sometimes they could be interchanged like in this case. It's getting
even more trickier with links.
Maybe, you have some write-up on what to expect from this perspective?
Don't remember it to be in the pdf.


> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 951fd09612ec..af8a673c618f 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2978,8 +2978,11 @@ static int io_submit_sqes(struct io_ring_ctx *ct=
x, unsigned int nr,
>  		unsigned int sqe_flags;
> =20
>  		req =3D io_get_req(ctx, statep);
> -		if (unlikely(!req))
> +		if (unlikely(!req)) {
> +			if (!submitted)
> +				submitted =3D -EAGAIN;
>  			break;
> +		}
>  		if (!io_get_sqring(ctx, &req->submit)) {
>  			__io_free_req(req);
>  			break;
> @@ -4316,8 +4319,6 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd,=
 u32, to_submit,
>  		cur_mm =3D ctx->sqo_mm;
>  		submitted =3D io_submit_sqes(ctx, to_submit, f.file, fd,
>  					   &cur_mm, false);
> -		if (!submitted)
> -			submitted =3D -EAGAIN;
>  		mutex_unlock(&ctx->uring_lock);
>  	}
>  	if (flags & IORING_ENTER_GETEVENTS) {
>=20

--=20
Pavel Begunkov


--AzFlLVkyFY0Btcr0LcEgHApAfHDq4lYiH--

--eGeNJNYnWQgwuQLIXm81Rce6uVWnUw4zJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3D4rUACgkQWt5b1Glr
+6UM+A/8CoYq0INEkNzLO8aPXH2yRzE3gBlTbMoNUllI/vZlF7HQFPouAuq9SxEV
qI6/KuUPTH82XQXw1ZNwSDLOefnyLoixF6DQPCyogrgfGvfNDM1BECkT+wXlJm/R
a7QFmvBo6ZjybpC2FYZI76a3e3+JgZ74d3mDDz7xyqzzimOvIyUnZW1ycwyET6fv
Orw/5ojmy7wymRXuxZ+PH+M7u6t3+qcwXkWuweaMAV0SZHxcupLURUMJWntM98Su
ZkcHrJemROr8R0+EFGgCg0sIAmujzrA1pGzN6v+Y2cfBaCF93jH31xosbN1HFwpC
ix7Mt1cClAFJr3rPL2pD3jGy5jV+xsFQyd3xKF76C6xFYjJU1aWFU6fpsNJ9eGyg
cJa5BHg+7UvFdE1Y+4pzceBrVEffyxjOfyjM92dbdEGoN6E8PPvA20jvRLV6w0rW
eC1HkMVDUHExWQo6F2ypAk6mEQa8j+/l7nIARah2ZxodDOcCPa2luTlBiVzfdwV+
a4KT9UHNcnRsE3eeqZH8vR5sSaOW4bYS97qOr0ksE0RJeAoSMRGRZGTJQEdDVt+E
c422UoMaKlHWGna1g3KbEu78CsRK0J0lBRwd8szTAOtejU6ryCC7x+hcVI0GaIWs
VTgv4LhSKZj2EALSFWdPSM6QgEZN3eHTJXfTxliFw1TS3vDM8DY=
=TUhU
-----END PGP SIGNATURE-----

--eGeNJNYnWQgwuQLIXm81Rce6uVWnUw4zJ--
