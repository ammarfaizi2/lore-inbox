Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F92C17440
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 11:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4D6215EA
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 11:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsFCmgeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKILQw (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 06:16:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51453 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfKILQw (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 06:16:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so8669363wme.1
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 03:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=UwMnhGhPlkCWtmBur6lzxw1lYf+ASFVViH2CkL5+wIc=;
        b=tsFCmgeBQLaMOILbhp/K30za9qSygfNc+QmI6WtZqW9CZ1MxYNrzP8FwPf/Y7UNRtq
         LiX3j3FdIA75A3l9lV2C697exKCUiOX1gOEs6VMIqhXzn06qw863v74etGSsnP2hQzoV
         h2W+0PhB2H/rKq+0pEI6NrEe39kFDlrw31EGv09eCcRjukC55YgvuKGs1+hY81Lc5xjC
         kVE4QsA+PieHzDfX7C2HqtRatK5K4aeWzoE47iD6kvQvaKbQZg9HgDwm/1WLEstaBi2+
         Fe7Fn3xRv0Ruxf3UOMzE+MImw2F9cLpIqUfkRhtw+Xbijxr8w85EXH8Gex0eBbo1etZ7
         MsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=UwMnhGhPlkCWtmBur6lzxw1lYf+ASFVViH2CkL5+wIc=;
        b=Z0C1ERudYGEXo1y/kMfLnFNZ+FBLFtWUg1BJ2D+yOGXLRqe492OoOUl1SGi2HfBXrq
         g2QorgBF8I7A7bhWQekMoZG1/gdsJXJI4xCupR2LnWtBUlUW4DiHxLvqowLNcioTun86
         7HlV3fAkrt9+w9i1ED5hzHvdXlnXyrwHrx1Z4PN+XNhVfXAWjNHLy+fM+x9m+9BcSI9+
         LZ4ZgLrglCqOQ/XY34Ek+JFWazIPEmtL+v800+nNSnMLQNpfAUHxp7p4z0aeD2Pjoocn
         eFE39sixI/jI5m2gnBcDtoeqIeswOLC1RjB5ABnFA+ZwapZwveFyFX0P10H+Vg32nI98
         SLgg==
X-Gm-Message-State: APjAAAUcaCxWLsFS6oNfCisNIJoI1CCb2Q9fjkykjyaKrJHeT8/ul9Zm
        k7cg/BOuzvDd5CFxe6QfmFa0VU4E
X-Google-Smtp-Source: APXvYqwGgLPk5akBE1UiON2pz1+FlykgdQqa0JZag7ZvZiFMhEncNWR8Fo+DmG6cQyZZ0nND43fiBw==
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr12305890wme.115.1573298207721;
        Sat, 09 Nov 2019 03:16:47 -0800 (PST)
Received: from [192.168.43.163] ([109.126.130.90])
        by smtp.gmail.com with ESMTPSA id l26sm1474241wme.6.2019.11.09.03.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2019 03:16:47 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
 <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
 <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
 <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>
 <bdfdad32-91b7-7721-ccdf-0dd399e7e051@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
Message-ID: <69985522-3e8e-102b-c8e9-ea9046cd22c6@gmail.com>
Date:   Sat, 9 Nov 2019 14:16:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <bdfdad32-91b7-7721-ccdf-0dd399e7e051@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eW7EDb5mt7jaRM6T1INnGG1Kbj1KPEhhe"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eW7EDb5mt7jaRM6T1INnGG1Kbj1KPEhhe
Content-Type: multipart/mixed; boundary="cxrDoc9UWTMq07gbLIrLfM3mlT73TPq0k";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <69985522-3e8e-102b-c8e9-ea9046cd22c6@gmail.com>
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
 <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
 <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
 <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>
 <bdfdad32-91b7-7721-ccdf-0dd399e7e051@kernel.dk>
In-Reply-To: <bdfdad32-91b7-7721-ccdf-0dd399e7e051@kernel.dk>

--cxrDoc9UWTMq07gbLIrLfM3mlT73TPq0k
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

> I've been struggling a bit with how to make this reliable, and I'm not
> so sure there's a way to do that. Let's say an application sets up a
> ring with 8 sq entries, which would then default to 16 cq entries. With=

> this patch, we'd allow 16 ios inflight. But what if the application doe=
s
>=20
> for (i =3D 0; i < 32; i++) {
> 	sqe =3D get_sqe();
> 	prep_sqe();
> 	submit_sqe();
> }
>=20
> And then directly proceeds to:
>=20
> do {
> 	get_completions();
> } while (has_completions);
>=20
> As long as fewer than 16 requests complete before we start reaping,
> we don't lose any events. Hence there's a risk of breaking existing
> setups with this, even though I don't think that's a high risk.
>=20

I think, this should be considered as an erroneous usage of the API.
It's better to fail ASAP than to be surprised in a production
system, because of non-deterministic nature of such code. Even worse
with trying to debug such stuff.=20

As for me, cases like below are too far-fetched

for (i =3D 0; i < n; i++)
	submit_read_sqe()
for (i =3D 0; i < n; i++) {
	device_allow_next_read()
	get_single_cqe()
}


> We probably want to add some sysctl limit for this instead. But then
> the question is, what should that entry (or entries) be?
>=20

--=20
Pavel Begunkov


--cxrDoc9UWTMq07gbLIrLfM3mlT73TPq0k--

--eW7EDb5mt7jaRM6T1INnGG1Kbj1KPEhhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3GoAwACgkQWt5b1Glr
+6VUng/+L/Jv05p8kJwMI5R4EpmCf6mizhRAc3n/AwQ2z8fNigMwp3/GYrSKlr4M
rd3PhytHs4VCDq552jW+/RcJAAspT0+vzgAafcvjQsQOYzpbdAyM4YXQq0uUNRLe
9I+vt9tekOvzUTot1eYyMLmBQg+OksoSSVJWc4krlzFajBI1w46+x7nfLwgLRvRy
gKF4y5MsfEz9q7Yi+Sw3rhzFLDhSwnlbSB4YAx8/rxhwBAQ/PouBnVclrHkVpXLq
fUqvPCKDZJpuaNXVDsMcLaLlcjPrCJVVHfPWnOtA7gFldWxXzoXxFwyFVeXMVqB1
AbtIk7+lPtc3hqCBz+Nx9hWkjF2llDOMpjDGArQqliBH9lWru9msXWKT/rjhhjsW
16SkrVl836DEwNGSaKIvY36ASeOLfVWN+JbfXzTw2yCF0E+Ng3KBYASsH1VFFhZz
VezWYkIoXB5zg/mpSzj5ZZ5yqoa/XUGDJct19asA6cnrvaH3qSuDWzOnXKEiHxeP
8my3oRKqyVnyiLGr3cWM8DJHnvnYdXJ30C4Vb8RhHDdPNqCb0T3nTK3v8dmTPUOJ
ujPCIjfR4a+S9BSVV6hozROvGngtll88bvTk2kT81IoXar3bw+iU+DQ1INNyONx/
grjefyMjGJ3Mdyj83B8GEQtIvx+KcSsMwYxOQq4nyeM2O6HhbMU=
=q1XF
-----END PGP SIGNATURE-----

--eW7EDb5mt7jaRM6T1INnGG1Kbj1KPEhhe--
