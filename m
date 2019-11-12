Return-Path: <SRS0=vuSH=ZE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E39C43331
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 20:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC112067B
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 20:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKevba77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfKLUMH (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:12:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52172 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLUMG (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 15:12:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id q70so4667154wme.1
        for <io-uring@vger.kernel.org>; Tue, 12 Nov 2019 12:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=mVR/+rXXVQogbnITQQzkx7tY/+98QoiA8fbooKDT+fY=;
        b=CKevba77JE5EGo9ap/5mtaxZd5WgfmN9/r3FvvPXTPL3miiQ5SadLlccy/VZN9Mz3j
         WZ1hGqNJ5DN3CyPw3elcH+025DAIpkzG+TSv7bR9FD5dwILB+jLOprdbS9i+pOhOezVd
         R342VB9a3wz0s0f5b23p64/OMxK8JTQlvBjJUnXzjGoP3nbC/4o66tE9jrvyhrYIQJur
         eplckxbwqZ6YjA+ZQtCsd5SMjiTKKH/Y8O1ePa4DWbccBfUDSP9J+jEWhnnCjEi11gKB
         LrGp9wdyz/D93lPrGLqeT4ws77ls0lBd5kqQlJ0e9/iU8vAufFkFAEOVrCqQ0iLytmEG
         MYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=mVR/+rXXVQogbnITQQzkx7tY/+98QoiA8fbooKDT+fY=;
        b=q4Gp1MkdrcuWGfOiHNwqqt/w/b+sXIJW/nStkO2EfrtbwVrm1e8PmPKZ5ebHgP0Nxw
         EHHR5EC2GC+dZqz9XPXl+PFzUjb+I0Tj1KCB6BN9PKKBT3qAZ2baGgY6Eogke/JRhaz3
         PHRMgDX8MIttrnu7GuoFs8SirxzUOIVC5BipXWTT0OG7WN+1EzYKZdDO1iFgc/+7rYRL
         kk6bfVRAWS9yXZE8AiCMDg7pIuNQd4/Ny6c3yvfE/NDsSCQh15X4lop7caKajbF7GQZJ
         T1FJSgnJDQ9TyVHtUS5Ye7S3mgcbyIcHqON3+Gi/8UZoOntGyfladhIxiqdMoOQd626f
         1zCA==
X-Gm-Message-State: APjAAAXCT4gRvWJpdWwZiDX18zwHQudavBTwK5zJSrBjwCQx+h1mnWJ+
        goyc8bb3Kd1iHJAbbag968xpArOH
X-Google-Smtp-Source: APXvYqyV8pOYpI64CpapcB1/7MLeFlh3iNaVVgMAStJQPIRmGsO1w60m8I4q7xVUGgroouSPkHPDyA==
X-Received: by 2002:a1c:3dc6:: with SMTP id k189mr5452755wma.145.1573589523880;
        Tue, 12 Nov 2019 12:12:03 -0800 (PST)
Received: from [192.168.43.158] ([109.126.145.151])
        by smtp.gmail.com with ESMTPSA id u26sm4195395wmj.9.2019.11.12.12.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 12:12:03 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <44a6c4ded7492f9a4d06d09fd9ff94e609b1ecad.1573546632.git.asml.silence@gmail.com>
 <787eebde-a668-ff97-fd6b-86aa6fd04c79@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] io_uring: Fix leaking double_put()
Message-ID: <61b57500-1718-c33a-8b8b-4fde62688363@gmail.com>
Date:   Tue, 12 Nov 2019 23:11:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <787eebde-a668-ff97-fd6b-86aa6fd04c79@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="au8Ql3UufzJPgx5ltG3IUOAPRnA7WH3Qk"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--au8Ql3UufzJPgx5ltG3IUOAPRnA7WH3Qk
Content-Type: multipart/mixed; boundary="6QdqOZDBnroHht4GcbEvALdjb1u4baSk9";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <61b57500-1718-c33a-8b8b-4fde62688363@gmail.com>
Subject: Re: [PATCH] io_uring: Fix leaking double_put()
References: <44a6c4ded7492f9a4d06d09fd9ff94e609b1ecad.1573546632.git.asml.silence@gmail.com>
 <787eebde-a668-ff97-fd6b-86aa6fd04c79@kernel.dk>
In-Reply-To: <787eebde-a668-ff97-fd6b-86aa6fd04c79@kernel.dk>

--6QdqOZDBnroHht4GcbEvALdjb1u4baSk9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/11/2019 18:02, Jens Axboe wrote:
> On 11/12/19 12:17 AM, Pavel Begunkov wrote:
>> io_double_put_req() may be called for a request with a link (see
>> io_req_defer(req)), and so can leak it in case of an error, as
>> __io_free_req() doesn't handle links.
>>
>> Fixes: 78e19bbef38362ceb ("io_uring: pass in io_kiocb to fill/add CQ
>> handlers")
>=20
> This blows up the 'link' test from the liburing regression suite:

> -			io_double_put_req(link);
> +			if (refcount_sub_and_test(2, &req->refs))
> +				__io_free_req(req);

My bad, it frees @req instead of @link. Sorry for the trouble.

It wouldn't apply properly anyway, as there is new commit using
io_double_put_req(). I'll resend it later.


--=20
Pavel Begunkov


--6QdqOZDBnroHht4GcbEvALdjb1u4baSk9--

--au8Ql3UufzJPgx5ltG3IUOAPRnA7WH3Qk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3LEgUACgkQWt5b1Glr
+6VGBQ//TUb23CNPIJedJO0WSEk7Kfz3qWR+OO9exs/3b21Samn3v4CzMQZ2AOR0
vbsItAwzCHANt9Ohg7xdMf0jNzBVPaqsStZq8u6o0TebMO8xWu8mRVD1dxHSfnF1
nkqddB21F/Cpp6GANtETx2/ygoODNR4pmcNwi8cAh9Hu/23p8BHRpvK071nd1aYT
PHn6+EGNs/eowng7+M3dUE2QotJXiXwevXLgKDfZZEtnOYbQ1gCOesjTILcv0dJE
syL6nkBD2eX3ioZzP/CboYIOFLXHEPgmCgzt/tNxzB6T8VXCpT6sfJiiRnDRFCCN
V76yjUmZpm7R9k8RoLjziYOR/j5PvlMowhJiR2sU4b6/lzKTBuSYWRaDyqRAqt6E
InUBNaWf87s2o3XY4P90+cQVzWbwASozccaeghKAoRHOwyTyXTFx6wi6bCUW+Odd
wOgYxek/4pp0R5n0U0Bqr5Hp3X7lCtZZvh6JJzG2xs70lMFIHoOaObJWD85I3YZW
XUAN8uaoDoZsokf5Hc77iZTIrQ51YkOHHAN55Ck+sfM1ftB1+2DDSR7PHuB4+KJa
zNsB1czqCLph8v+cfGp0zJzQp0Yuo3mzU8yEWTRfDe0YQr0B2PBE4mOA8IWTlOPz
djHGLHsh+SaCS/dm8RWSQcyXmW7fZtYKughJvCmyh5pCZIxeoQQ=
=Ue+4
-----END PGP SIGNATURE-----

--au8Ql3UufzJPgx5ltG3IUOAPRnA7WH3Qk--
