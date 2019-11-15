Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340EEC432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 22:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0214720732
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 22:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP6ZrS9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfKOWUT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:20:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40051 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKOWUT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 17:20:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id f3so11999564wmc.5;
        Fri, 15 Nov 2019 14:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=ywIUinYz248/g85EBqVsotoJFG2H+fCK1M7rhxXShdo=;
        b=LP6ZrS9J+FxmvNiZS0cZTlkTFNv8eNcpbdeMQsxX9HbBoYDv6kmcim9Ky41+a/0Omm
         5L2mswAbhXKhtRjwSNF9PpH3G/zN6voYcmdsYIYMdTtcMw1OU6wx1WMHcQOfhwwBxfcs
         nHhlJfWQI+t7KtO0YYilLvyJ2l1TVk+OIA2MFireJ8satOauoXAcd3RMJg4bSRtUaJxv
         pSge54Vqg1h1EjViMfnnzWa9R0qnJXLuM76EdjnHa04XDwqwQlcB/davnve5DhSIcv9C
         ypwkwk0HYyZlhhY5yZUQUAH2LTIHwzHY4veo4Gawv5L79QsSeXEAYteP0X0nnOjcYAvz
         y7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=ywIUinYz248/g85EBqVsotoJFG2H+fCK1M7rhxXShdo=;
        b=Z7qvhOeoQv7r27iPHEVcipcvDEn4327HvHbj0UAe3l+ei+sDZV9JlqhPRQlh0K7lYD
         xovQagc3sefyA8NKmLC5pnqerImqoTRsGsYRebtfMrPyXUH6/NB6gj01zZGhxXC0NT/C
         rHAKQp97GRHf3+hxLpZIRgzJDEdX35WgjfzuC85JFS3Lh0mG22ez7YvPHatpDO+m1lBe
         gaxzz9ZuRfZ8iD+X9DMV/gRXvNecQsJOdRwlyZMekHIMTZ4SPNNvcYO9QIVAJXTtyTOu
         SjJdAaXzXB6gR23aNrd8jGwDn77se7JWfnXUvspqU2tst8CVwlHraDmiOumfupl5zBoT
         HCWw==
X-Gm-Message-State: APjAAAXbbyljJI3IEqJsWZrlySJdLNe9pv5w/oZ16p9uCLW8KxbzbN1C
        To4Ow+qsmHlLZsfMpEQ2N4M=
X-Google-Smtp-Source: APXvYqyvbd/khgNFPmUShZQs7TWwSFwchduSLrX5nBq7pvJwDkKyz9hE4twZnnyYJn/5D0c06p/V0A==
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr16134984wml.158.1573856415189;
        Fri, 15 Nov 2019 14:20:15 -0800 (PST)
Received: from [192.168.43.69] ([109.126.151.234])
        by smtp.gmail.com with ESMTPSA id 65sm15813282wrs.9.2019.11.15.14.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 14:20:14 -0800 (PST)
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
 <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
 <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>
 <aabbed5f-db68-4a48-1596-28ac4110ce95@gmail.com>
 <2b35c1a0-69bf-1e50-8bda-2fff73bac8de@kernel.dk>
 <cdba1334-b037-d223-29a6-051bd49fef70@kernel.dk>
 <bde153ca-ff2a-8899-172e-0aa6359bff8c@gmail.com>
 <a35ad645-0340-62e4-fba7-7c1a080a9a65@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <62cb2281-f107-7bfa-bbab-2134d473066c@gmail.com>
Date:   Sat, 16 Nov 2019 01:19:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <a35ad645-0340-62e4-fba7-7c1a080a9a65@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7dq1Vp2hkscMu3d2sWjBtlZgYNoCe8A1f"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7dq1Vp2hkscMu3d2sWjBtlZgYNoCe8A1f
Content-Type: multipart/mixed; boundary="zQQCKx2YYeVVLqUqbkocmsACddv22WTAW";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
Message-ID: <62cb2281-f107-7bfa-bbab-2134d473066c@gmail.com>
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
 <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
 <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>
 <aabbed5f-db68-4a48-1596-28ac4110ce95@gmail.com>
 <2b35c1a0-69bf-1e50-8bda-2fff73bac8de@kernel.dk>
 <cdba1334-b037-d223-29a6-051bd49fef70@kernel.dk>
 <bde153ca-ff2a-8899-172e-0aa6359bff8c@gmail.com>
 <a35ad645-0340-62e4-fba7-7c1a080a9a65@kernel.dk>
In-Reply-To: <a35ad645-0340-62e4-fba7-7c1a080a9a65@kernel.dk>

--zQQCKx2YYeVVLqUqbkocmsACddv22WTAW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16/11/2019 01:15, Jens Axboe wrote:
> On 11/15/19 2:38 PM, Pavel Begunkov wrote:
>> On 16/11/2019 00:16, Jens Axboe wrote:
>>> On 11/15/19 12:34 PM, Jens Axboe wrote:
>>>> How about something like this? Should work (and be valid) to have an=
y
>>>> sequence of timeout links, as long as there's something in front of =
it.
>>>> Commit message has more details.
>>>
>>> Updated below (missed the sqe free), easiest to check out the repo
>>> here:
>>>
>>> https://git.kernel.dk/cgit/linux-block/log/?h=3Dfor-5.5/io_uring-post=

>>>
>>> as that will show the couple of prep patches, too. Let me know what
>>> you think.
>>>
>>
>> Sure,
>>
>> BTW, found "io_uring: make io_double_put_req() use normal completion
>> path" in the tree. And it do exactly the same, what my patch was doing=
,
>> the one which "blowed" the link test :)
>=20
> Hah yes, you are right, you never did resend it though. I'll get
> rid of the one I have, and replace with your original (but with
> the arguments fixed).
>=20
Just keep yours, it's better :)

>> I'd add there "req->flags | REQ_F_FAIL_LINK" in-between failed
>> io_req_defer() and calling io_double_put_req(). (in 2 places)
>> Otherwise, even though a request failed, it will enqueue the rest
>> of its link with io_queue_async_work().
>=20
> Good point, updating now.
>=20

--=20
Pavel Begunkov


--zQQCKx2YYeVVLqUqbkocmsACddv22WTAW--

--7dq1Vp2hkscMu3d2sWjBtlZgYNoCe8A1f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3PJIgACgkQWt5b1Glr
+6U3vg/+Ngr7JzjKwguNOOxJdH1+oGyu05f8OBTAs5kEuPUAkQ6Vc4o3yUo94eOz
cCjSOte/IyNxhSDatlf+z7m8fnScemjTy8mLG4Hc4ECpc8giuWk91CmzVqXs+cOh
iwK8v/RZ83r0Jf57XYicv/KlEyLAwOotY3viahyoawL+ynLrqTsVu8lEIvqnwRGA
rVFHYabqZ+uM117PnKVv6KFkfBKy9UyY2E4cIimRqH8UnMTFCxZ2mfUYNHUWBbvq
cwTqAZj0WkRFoAhKR0KrvJ1ehAiUxUFCpZTy5x+pKsWmVGcWOFf2McD2FPY6pA2R
pFRyD1aqP5SiVZGLVDrD1hcyxUhjs23koCBVLVSJkhSNw98NxCfLTu4ILALXFO7U
nerO880q1tJBtsAjMG9V6EbgGIgcAmgLx9PgWCSjTd1fqKAMTKz1dpEj8t7i1HOh
pQjQ7Jwh3L3VA+qjAatMyCP88PpEwHydYXkE1lEYJj/Vexz3B3GVRF+VmxQxeCpv
1Z5XWoNvB+G0eSIUvde6c7ewmkgOkAinJa8a69V/VluwHQr5OGuHps7Lc+bhXbzj
t6Ze+NejrcJ8sU3VG74qFJuk5iyzU12WgkdriWKz+pUO9aMk+gxUD6pHD8OCOoZu
WwIlXCfdqTkUR5ASXzuxjGX6E8Ie/SmghL/pfHtZmtYXpXtPRxs=
=ytZL
-----END PGP SIGNATURE-----

--7dq1Vp2hkscMu3d2sWjBtlZgYNoCe8A1f--
