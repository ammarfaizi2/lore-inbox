Return-Path: <SRS0=S5qu=ZQ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C8CC432C0
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 17:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399F22071A
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 17:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdvWRCZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKXRwe (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 24 Nov 2019 12:52:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36670 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfKXRwe (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 24 Nov 2019 12:52:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id n188so11221056wme.1
        for <io-uring@vger.kernel.org>; Sun, 24 Nov 2019 09:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=hbpM7C8eVGXs+9sfG5PMG3Kv3KNvOkwZ2cixkXoBFzs=;
        b=GdvWRCZVMVStnz7rVOdacXSSD2w8SP0nyrwLq69QO2O3nrFA8owRpRYgULjCVOeuWy
         C2YpvNMgol79DzXxFbCi641LG+N8P87AMEC0X89aV/SMO1qvngpN8HbnlzdV8LIHuvbZ
         dNxk7GCEqCDkh4Skxtml7ny2IxDVobj6YwYSXNdHLkA2MASfQviOJkoMKaSwfMW/lejz
         Qj4fvBXDL9shratYB2Snq509rF2QOXjygE8X7YKo8biu01hmd7FX0itjCpnNJtURiABM
         MRo+5KDzdJccHq8ImELzIY6KKVYZsl3LPXLMLAkoh90EYtJdaawLsXECJH3sdmZKpEz+
         wioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=hbpM7C8eVGXs+9sfG5PMG3Kv3KNvOkwZ2cixkXoBFzs=;
        b=QFFxKgmd7mDQO3nLSGWIG7tvzqnVFn2YqdwNv0ErG0qLEDHAUb6FmQPWiZJCSl/9iH
         VAVwUe54Rm3VtOLVDAsh2vLZfBdp4rMfWXTbeRIBOYFzkBrT6EiAXNwQhtAh3Ey82qhW
         IJap1M9ijYlm2j0a5feuutWUVgwtJ7ZtMLgykC96dlrJlquCK8gL0MdczFtmaSZTreHs
         IUOEKyc2vByFLe+kKWsy/u9Kqt7Sqx9SWUth2duIRC+SVMZ80yIiuz66yDMmao1pw+bQ
         ayMprMPImPlXxVLBQNwzEbarrZhWMCZj07+NQ8f2zJFBAAU86+Ue1WbOsBeCoNmth0vR
         pHuA==
X-Gm-Message-State: APjAAAXPzgowrCyOLvmYILXg3WaSXiW8lhX/Xz2UE+jh2Thf6Ccqc4FT
        BExqDOE+BbU9mY+AsDqPfAVzhKo9
X-Google-Smtp-Source: APXvYqzIS28zzo0/10tYGKvPeD96ocTaMm/vZDRbxwVacOkMx7RVUdOwNfnPR8UnvQxtkf2znHx3CQ==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr25697803wma.140.1574617951384;
        Sun, 24 Nov 2019 09:52:31 -0800 (PST)
Received: from [192.168.43.199] ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id s17sm5711872wmh.41.2019.11.24.09.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2019 09:52:30 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <cover.1574585281.git.asml.silence@gmail.com>
 <620023b272fef0fd76d0f91ff1876fa64864caa6.1574585281.git.asml.silence@gmail.com>
 <6a2fcf67-1267-a02a-98ce-435bbb2ca9bb@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2] io_uring: fix dead-hung for non-iter fixed rw
Message-ID: <c44dd55c-79b9-78c0-06ad-45f7d47fdd5f@gmail.com>
Date:   Sun, 24 Nov 2019 20:52:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <6a2fcf67-1267-a02a-98ce-435bbb2ca9bb@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gbm9a60AHPgzJc3wB6cmlHGZOVL603Qaf"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gbm9a60AHPgzJc3wB6cmlHGZOVL603Qaf
Content-Type: multipart/mixed; boundary="gpM5RufoIE47vKZ73kib1pAEiwpOsDDMl";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <c44dd55c-79b9-78c0-06ad-45f7d47fdd5f@gmail.com>
Subject: Re: [PATCH v2] io_uring: fix dead-hung for non-iter fixed rw
References: <cover.1574585281.git.asml.silence@gmail.com>
 <620023b272fef0fd76d0f91ff1876fa64864caa6.1574585281.git.asml.silence@gmail.com>
 <6a2fcf67-1267-a02a-98ce-435bbb2ca9bb@kernel.dk>
In-Reply-To: <6a2fcf67-1267-a02a-98ce-435bbb2ca9bb@kernel.dk>

--gpM5RufoIE47vKZ73kib1pAEiwpOsDDMl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24/11/2019 20:10, Jens Axboe wrote:
> On 11/24/19 1:58 AM, Pavel Begunkov wrote:
>> Read/write requests to devices without implemented read/write_iter
>> using fixed buffers causes general protection fault, which totally
>> hangs a machine.
>>
>> io_import_fixed() initialises iov_iter with bvec, but loop_rw_iter()
>> accesses it as iovec, so dereferencing random address.
>>
>> kmap() page by page in this case
>=20
> This looks good to me, much cleaner/simpler. I've added a few pipe fixe=
d
> buffer tests to liburing as well. Didn't crash for me, but obvious
> garbage coming out. I've flagged this for stable as well.
>=20
The problem I have is that __user pointer is meant to be checked
for not being a kernel address. I suspect, it could fail in some
device, which double checks the pointer after vfs (e.g. using access_ok()=
).
Am I wrong? Not a fault at least...

#define access_ok(...) __range_not_ok(addr, user_addr_max());

BTW, is there anybody testing it for non x86-64 arch?

--=20
Pavel Begunkov


--gpM5RufoIE47vKZ73kib1pAEiwpOsDDMl--

--gbm9a60AHPgzJc3wB6cmlHGZOVL603Qaf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3aw0sACgkQWt5b1Glr
+6Uqig//U/VRr7SUs8cCRke42cbGdZ5iZUeWX8mkdSucQq3x8mw70kw4axXtIgMb
JaQc+Jj7HEa8aP/LVriTUkPuAl4I7uJPsRZk4BgL38jpAfYjFaPvlOZZP2hZGXMM
igW9K9ixPqDiu9qwZ/wU/cNR5ZeTj1kL3iOSQpCMjSJb0bJ3kzy4ew/ABSKSLHQ/
OPobq1ymjw6R7zO9lwjyWjDQ54KC1q3UVuoWvM+dN3nR1d4MK/hhFYeabkSA9acW
+jNgT1PIdmf7L5qZhmNm/KEKpddtWaq8/8liG1kR0aTxKU/a9L/E0Ld3j4gpE+Ge
Dt9VqcaGEQJN277a8ZVjgcOjjwkcJSvCToR+ivlDcwZpn/2yWPQfdcWi8MgIhxep
0LU6GkNDWiS+7yl3A92AY4jLtrpPdBSiFPtEhzwGXJ9EbFw1iPPdKEJdCv6Np34l
IpqYURjbEDmR1h9qGyZk1nmP2TlCOlGnZvEvqytYQQwqInims9htQk1KE1A53zJL
Hju0EqSkVKzckN0x+YizrUNpv9j78mz/sf0/V0aXtIGTyVgmyOftYNR2kbP5R8GR
bkDWeUzkujeLZVOWiFn5Nalp/E0xvKF7+J7MgkJJYb81bhG5ZcGKz5bW5SsCrpMh
6VagwShJd+15J3VuWnWr/nXdPH2dGCMNCI9RccwfW4Kf3cHWnfM=
=wPe/
-----END PGP SIGNATURE-----

--gbm9a60AHPgzJc3wB6cmlHGZOVL603Qaf--
