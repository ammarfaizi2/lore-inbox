Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E96FA372C
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 09:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A14F2178F
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 09:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAn0cbvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfKHJ1D (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:27:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43891 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfKHJ1C (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 04:27:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so6147898wra.10;
        Fri, 08 Nov 2019 01:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=m03gajIgnnSxrHaZI5eCxVy5L0LCjFb/1pEgbHPjJ8I=;
        b=OAn0cbvEWE4q7jfq05halPFTPChvv6cGVBEmrmCWCJVuwMG12VsMenL+uXYi55a+O6
         ia0dzyeL7OLPWop5yPDuPRXoAUsy+SzpsmOdR15m0KY6opjHXFdBEtijby4WeeJANfmM
         nhKu8/93/TtTFBG4zjJqunwwZihFM+209qOkTkWLZ9BNbIAWVgv3FpcPlUesy8L3REgc
         ADLHh7kwmjUCvxsc7ROF2ogMOD4KXsIx85IPktYl1WFV4z6EhTg9b87pJaIfJb5VK8Zk
         FD0XO3AxxYF1bJvyi8DA7FZp13S/hSs0HLodOOvvYogZPfuvf5SKAr0K5j48LesAW4Y9
         B37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=m03gajIgnnSxrHaZI5eCxVy5L0LCjFb/1pEgbHPjJ8I=;
        b=izbccZhOw+SLLIsxtTRQpBztpU5OWPM2uFZRPw8n0QYb6/LeyPrnj8+qyQBh133Fs2
         IDaK8q0OCOb3GxomjyICvU9fHa1SpQ5Y1G1Ymu+WNG29UwPGe7v93d6tJC+2MdBpjAef
         www/3ew9N499hwNq+dejdS4Uj0uZiORQAgXnUouN8xOoe5xrCD2oe8fBmShKgOGdfUdV
         NY3Ro7Ud7aD7KZwZQ18rnYQieXiC+hVk+aHfN3FjnFNBWEIjFj6gJFOqMxyR0V1Vrbef
         FL9vVb2Nimy4UjGVgtX/OUVQm0LoWVmYXl1d6My06DGPsWkjA8x71B4fbYygniYn7onk
         HCUA==
X-Gm-Message-State: APjAAAXXOuCJIgjwFpu3lI2bkrnyi1vPs1Zz7NAKajhFrDZtnBG0cQt3
        KGfH6AQ6jvA3q1aPHnN340E=
X-Google-Smtp-Source: APXvYqz7fSeJUbVf6rm5B/H3CS97DvdqiY8YDYUJY9ESquRxuMChPkAlnSyK1GZSSKmkrPGU2eivcg==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr7483330wrv.247.1573205219355;
        Fri, 08 Nov 2019 01:26:59 -0800 (PST)
Received: from [192.168.43.59] ([109.126.142.81])
        by smtp.gmail.com with ESMTPSA id k125sm5997640wmf.2.2019.11.08.01.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 01:26:58 -0800 (PST)
Subject: Re: [PATCHSET v3 0/3] io_uring CQ ring backpressure
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, jannh@google.com
References: <20191107160043.31725-1-axboe@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <410c13fd-121f-2ac8-1ce2-4f8d567383cc@gmail.com>
Date:   Fri, 8 Nov 2019 12:26:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191107160043.31725-1-axboe@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OETAsnTeCY7PCu33ZuyAYP2JJdkHGLbJ4"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OETAsnTeCY7PCu33ZuyAYP2JJdkHGLbJ4
Content-Type: multipart/mixed; boundary="6DbDmnLNymPchV1COzXcUy4nyniry6gFi";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, jannh@google.com
Message-ID: <410c13fd-121f-2ac8-1ce2-4f8d567383cc@gmail.com>
Subject: Re: [PATCHSET v3 0/3] io_uring CQ ring backpressure
References: <20191107160043.31725-1-axboe@kernel.dk>
In-Reply-To: <20191107160043.31725-1-axboe@kernel.dk>

--6DbDmnLNymPchV1COzXcUy4nyniry6gFi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/11/2019 19:00, Jens Axboe wrote:
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
> event, but we'll also not allow submissions with a completion backlog.
>=20
Looks good to me
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>


> Changes since v2:
>=20
> - Add io_double_put_req() helper for the cases where we need to drop bo=
th
>   the submit and complete reference. We didn't need this before as we
>   could just free the request unconditionally, but we don't know if tha=
t's
>   the case anymore if add/fill grabs a reference to it.
> - Fix linked request dropping.
>=20
> Changes since v1:
>=20
> - Drop the cqe_drop structure and allocation, simply use the io_kiocb
>   for the overflow backlog
> - Rebase on top of Pavel's series which made this cleaner
> - Add prep patch for the fill/add CQ handler changes
>=20
>  fs/io_uring.c                 | 209 +++++++++++++++++++++++-----------=

>  include/uapi/linux/io_uring.h |   1 +
>  2 files changed, 143 insertions(+), 67 deletions(-)
>=20

--=20
Pavel Begunkov


--6DbDmnLNymPchV1COzXcUy4nyniry6gFi--

--OETAsnTeCY7PCu33ZuyAYP2JJdkHGLbJ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3FNNYACgkQWt5b1Glr
+6UzDA//YDq4aRFdRTeFjxJKXLP8zpADt8VkyuaUmUbaoahP3h6kYAGfmwD9uSZk
sKaZsCMGgmPP1v4WZWFfwTxdGwf1466VHfgv92rkM0hG95Yg+XjMzKUL6OPFZaIA
DT7s5v7kBNidDRCoVOm3NSytcV+OIA7GJuLosRp3LekMKfSngMqC0IClXDugRBi/
2QhU34z5uy03mxx0jbFrG/llSUKZWm7e4mv958VA4OIJ3mg4wIXkViXE2wnQAevJ
wHN6d9Yt8mf4TiCnqnVZ+W9hWFPjzpgaF/uPILh37wiNPciX0kNWaP8pj/C9OPQg
uT/TTndA40fFtkSPiVAaMXi0rDvqDPzsQSHObCweIDb+6zJzM8i/gTwvAJZy+HmR
2ANCm+3U7Ct2ICr8GtDRa7T97AospqjereV9wHpnEDzo+Z0nGaSPPBxX/uJpM94s
fINiufSHwXeArnktiwUVus5cFtKg8Zv0ZU396fqvaXHmatp9+gIRmcbdgbOxBbAx
hVB/rIicjP7pJm9pOfTT4hOEIiKaL2yt1cUdB3YUWhFrAkEREZH8hxykX0mzJgzF
p0m5M90klbuzlNEIjzkoAu/oP4MMq+QHxdu1gbNsNsM7Yq5Tq8jlzuhW680MTZv+
tYvpIBSni2lyyath3kkdGZQUrKXDVneZ9iwGmeS7PPIQ3oEvwKo=
=A4nC
-----END PGP SIGNATURE-----

--OETAsnTeCY7PCu33ZuyAYP2JJdkHGLbJ4--
