Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E39C432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 22:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE023206EF
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 22:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKd1+4Bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfKMWGL (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:06:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37658 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMWGL (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 17:06:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so3735217wmj.2
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 14:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=X12/9yyUhHuSB0KWbmlg6+Re/VH2Vb7u64/hZI/m5Jw=;
        b=dKd1+4BwI41O8xBhIf+JVORLsf0+OK4pfpCyGxbEa0rL5cFKVymydKy/e2uASjbMYq
         no7dfvqkAlpmXIb95VgdLxq+C9zZlz9yKT0PhDh7gUDt2KoP/6i2vFDBNtF8efNXaG3b
         wNp4lx0bTldelPN3qXPY20XNidSQX+U555FzBc04UaMymeuIFEuB+k/Skj0q7B83qCOy
         tLVCOfKm2ZSr/OJ9B02YuAvLbZYw2bsRhjozQDFUxP1agK9+G29I97+FybCXrY0+wTvv
         zkcOa0XuuYrGmUDNf9THvGjW082FnxupoA+2G2UXffHeIrq21coJfFxfF9sCEPj9/Cfb
         esLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=X12/9yyUhHuSB0KWbmlg6+Re/VH2Vb7u64/hZI/m5Jw=;
        b=EYLk0zgNPOA0Kyb3G+M/0tF9DglHXGZRbEMpvGcBRQQOy6h4THjNHr5e/qoAFa8LgW
         NgQUdpqiWQeFSdCnMnhpaE+tV8P9Vw9RzMacooNUbpiHKIeYB3DWUQYL94R3C7K6hAYL
         gBQFUcSMBEEytjTThpAzyAKrSRlaDKU+kT3bCIL71LRfabwOED/OnrHn+yWLx/a794iz
         voxwj4Mjzm0SG0784eQVwljVECMyVH6Eq6DgEx2jhXbfsatyQCZebMt6YZcPtLBmnWmb
         WQrj77ngDbLtQXkZf11BYlD6Ks6ys14TQ4fbaXNdC83naLWqQ2+T8molvY0axO1sBBuc
         pwBA==
X-Gm-Message-State: APjAAAWMZ2W920VLiaWQpi5UpagA0vYaNPkyAtkuEatUaTVcBKOM3wVl
        bEUuadTT19cTQVy03ehKHefjXByv
X-Google-Smtp-Source: APXvYqyPRrNqIf0c5v8DaBcMARTI9K2qYfNZSq2ckSTZKezvpNGpA4GthHwAH/XJMeKUVTlDxpvaLQ==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr4352064wmc.136.1573682768854;
        Wed, 13 Nov 2019 14:06:08 -0800 (PST)
Received: from [192.168.43.29] ([109.126.149.223])
        by smtp.gmail.com with ESMTPSA id w17sm4827623wrt.45.2019.11.13.14.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 14:06:08 -0800 (PST)
Subject: Re: [PATCH] io_uring: Fix getting file for timeout
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org
References: <5b145d14-59e8-041e-9b8a-21ec1d71e082@gmail.com>
 <22C89598-0237-49ED-B020-9DD01D7EA31E@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <05f9e5fd-c60b-d483-381f-ad66cd3723e7@gmail.com>
Date:   Thu, 14 Nov 2019 01:05:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <22C89598-0237-49ED-B020-9DD01D7EA31E@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xoJDY89rG82BAi3YV3T7dTio8ohMDpZlq"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xoJDY89rG82BAi3YV3T7dTio8ohMDpZlq
Content-Type: multipart/mixed; boundary="0MUvlwjUoy6OuNCcmhsLS5fIHkEWYdHrP";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org
Message-ID: <05f9e5fd-c60b-d483-381f-ad66cd3723e7@gmail.com>
Subject: Re: [PATCH] io_uring: Fix getting file for timeout
References: <5b145d14-59e8-041e-9b8a-21ec1d71e082@gmail.com>
 <22C89598-0237-49ED-B020-9DD01D7EA31E@kernel.dk>
In-Reply-To: <22C89598-0237-49ED-B020-9DD01D7EA31E@kernel.dk>

--0MUvlwjUoy6OuNCcmhsLS5fIHkEWYdHrP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14/11/2019 00:54, Jens Axboe wrote:
> On Nov 13, 2019, at 2:48 PM, Pavel Begunkov <asml.silence@gmail.com> wr=
ote:
>>
>> =EF=BB=BFOn 14/11/2019 00:37, Jens Axboe wrote:
>>>> On 11/13/19 2:33 PM, Jens Axboe wrote:
>>>> On 11/13/19 2:11 PM, Pavel Begunkov wrote:
>>>>> For timeout requests and bunch of others io_uring tries to grab a f=
ile
>>>>> with specified fd, which is usually stdin/fd=3D0.
>>>>> Update io_op_needs_file()
>>>>
>>>> Good catch, thanks, applied.
>>>
>>> Care to send one asap for 5.4 as well? It'd just be TIMEOUT for that
>>> one, but we need it fixed there, too.
>>>
>> Sure, I'll split this into 2 incremental patches then
>=20
> Just one patch is fine, it=E2=80=99ll be a conflict anyway. So no point=
 in doing two patches for 5.5.=20
>=20
Ahh, didn't see the message.

I assumed you would drop the first one, and apply new 2 without a
conflict. Either way, just skip whatever you don't need


--=20
Pavel Begunkov


--0MUvlwjUoy6OuNCcmhsLS5fIHkEWYdHrP--

--xoJDY89rG82BAi3YV3T7dTio8ohMDpZlq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3Mfj4ACgkQWt5b1Glr
+6UKJw//VuHIBc2vBwfz7sen+SDtgdbDWFwu3WbeGupDTmNP3MyhAmOcdD5rfJOz
0ZeJp38FS/RROzEd7zSJ8xF5XXpLzYaBw5+vri9uvTAV4Dh7fzh6KiqGJAX8qD4e
F9rd2ShFfVyNUFSg0M6tBv+tgeAm428fhHJ5Qjwjo3rGWgknJNbRz8HI3NjDV9w2
Hkq4gU9pe3l2RmvBKGqvunq6i8yG7hzNinbQZgmfybeSzhgO7c9OgKKGAlM349Yr
o11YIdNc8Txero9IJcKnHAkIE33C0xxIjKmAv8xpk+xrjwWKfZS3HMQm91SnGn8G
H5hUCcD1f2KX/nwsyPLpYgZYNNE9r2yp+UnGXPX6/NGenHYdOvb0JrV2I8Y+22iG
dA8RAefQrkYD+BLsLZibSGKsw84WJBsQWW9rQMc8QpmnNvbee5WdmS46LIb2seO9
AJYDNyEQm2CCwXZK1qRUgz7Dy6jb12h/v6ECRM5wTy6aR0MajN4Mi4kpbMzbUFcL
HJElNDLDIw7q4SYxvFV7U4uQrRcYmJlXfKWZTgRcF/7gCT339vDRAji60oqeryCY
Pe7rRWWWTGgMkBV9cn1e68P66eH7FSYcWjixjXo4pTzNROIfm2JfRyv5t2wvG3Wy
+KhqnX8kCzsnhKaAElL4lUQsr2BpSReFM116olwcEjfA9pnAf/Q=
=Qxg3
-----END PGP SIGNATURE-----

--xoJDY89rG82BAi3YV3T7dTio8ohMDpZlq--
