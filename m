Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03E8C432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 22:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF8A20733
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 22:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASnn+Ead"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKOWX0 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:23:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43080 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfKOWX0 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 17:23:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id n1so12539274wra.10;
        Fri, 15 Nov 2019 14:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=vs2Rc+yd0wmPb/liQUnPFP+vlT8j3Zf7JtSAaXGQSt8=;
        b=ASnn+EadFT5WhD044h1M2/P6ULp5XD1Mbcn8X0zS7/fbenkq3v+JvZKBtgnvtq7oL5
         xJqkW6mXB7L51h2V1BlZkqfs9IdHWrgB+/2kHr8aWhOgMHQoPZ+L0V2X5/iNSCDjX+87
         XOnokwo8VKK5YYJkOd9gLw94NWLQ2Ic+7YB7MdeceuuTWovik0GA81MaMHfbh9DmY3Lj
         lVq4hvUOU77f6/djJf1s8GRotCtKwOG9k72jrZP0Lds3VBIK3aLqTXX9HUirFgleN4qQ
         l7+OFWfXhK+hUDu2TW2pKXNjudoko7TSHDBsptzup91sbV2j4pCGIaGlm5WqsT7Kkkup
         9VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=vs2Rc+yd0wmPb/liQUnPFP+vlT8j3Zf7JtSAaXGQSt8=;
        b=eonZX3IhDdTAB1OW7Dq10OeZk3nDb9IQnoPolRixPhlKY9Ttv4toaMX7pj+vlkIJTG
         sz5I5AOFdImFe4YLsOT8NCxMwh61QArZMSjTy5D/F0/zPSeMgbYWtzTwXn7oTfgCpLi6
         IcI/W5TRqllFCZ8y4aQ/faDVXKJysao5M2BtnLnM9HFEVS1xyodvpOedUg/fIDzzSKh2
         1SWvqBmNlvWtSHTK2mTjxQKedObIjuM0zI4KhjlP3JNP9KsUueVXErquBYCPjBRgrUZJ
         Z0e9WOjFAQTEMZ1w1j09c2rPEBS2q+MsZE5Mm6N2F4VuxnnZNKlxDHfMxGbV+wtQFyrZ
         fRCQ==
X-Gm-Message-State: APjAAAXWeo/8GMCpdtoo45nP5aOF25jY5pNjhoq46TASHoJodqxXR9tB
        neyXllR2oWQe1H8w+AhFQZqIA2cb
X-Google-Smtp-Source: APXvYqz6uomPac0sIqQLsCat75AKNNmQAgmYZJQeZ7dinElT6zMQPBge0vH2WArPdQEH9Z04haVFKA==
X-Received: by 2002:a5d:490e:: with SMTP id x14mr17058078wrq.75.1573856602926;
        Fri, 15 Nov 2019 14:23:22 -0800 (PST)
Received: from [192.168.43.69] ([109.126.151.234])
        by smtp.gmail.com with ESMTPSA id w19sm11144509wmk.36.2019.11.15.14.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 14:23:22 -0800 (PST)
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
From:   Pavel Begunkov <asml.silence@gmail.com>
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
 <62cb2281-f107-7bfa-bbab-2134d473066c@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <31482102-510e-3421-1a32-c864475e3b87@gmail.com>
Date:   Sat, 16 Nov 2019 01:23:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <62cb2281-f107-7bfa-bbab-2134d473066c@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nq9rWCIMDwLw3oLcLglMvYkgnmIxgyhhq"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nq9rWCIMDwLw3oLcLglMvYkgnmIxgyhhq
Content-Type: multipart/mixed; boundary="51y2xkvCwtMK5MMIO7j88tjfRp2ndftPN";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
Message-ID: <31482102-510e-3421-1a32-c864475e3b87@gmail.com>
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
 <62cb2281-f107-7bfa-bbab-2134d473066c@gmail.com>
In-Reply-To: <62cb2281-f107-7bfa-bbab-2134d473066c@gmail.com>

--51y2xkvCwtMK5MMIO7j88tjfRp2ndftPN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16/11/2019 01:19, Pavel Begunkov wrote:
> On 16/11/2019 01:15, Jens Axboe wrote:
>> On 11/15/19 2:38 PM, Pavel Begunkov wrote:
>>> On 16/11/2019 00:16, Jens Axboe wrote:
>>>> On 11/15/19 12:34 PM, Jens Axboe wrote:
>>>>> How about something like this? Should work (and be valid) to have a=
ny
>>>>> sequence of timeout links, as long as there's something in front of=
 it.
>>>>> Commit message has more details.
>>>>
>>>> Updated below (missed the sqe free), easiest to check out the repo
>>>> here:
>>>>
>>>> https://git.kernel.dk/cgit/linux-block/log/?h=3Dfor-5.5/io_uring-pos=
t
>>>>
>>>> as that will show the couple of prep patches, too. Let me know what
>>>> you think.
>>>>
>>>
>>> Sure,
>>>
>>> BTW, found "io_uring: make io_double_put_req() use normal completion
>>> path" in the tree. And it do exactly the same, what my patch was doin=
g,
>>> the one which "blowed" the link test :)
>>
>> Hah yes, you are right, you never did resend it though. I'll get
>> rid of the one I have, and replace with your original (but with
>> the arguments fixed).
>>
> Just keep yours, it's better :)

Moreover, mine have one extra REQ_F_FAIL_LINK, which really
should not be there.

>=20
>>> I'd add there "req->flags | REQ_F_FAIL_LINK" in-between failed
>>> io_req_defer() and calling io_double_put_req(). (in 2 places)
>>> Otherwise, even though a request failed, it will enqueue the rest
>>> of its link with io_queue_async_work().
>>
>> Good point, updating now.
>>
>=20

--=20
Pavel Begunkov


--51y2xkvCwtMK5MMIO7j88tjfRp2ndftPN--

--nq9rWCIMDwLw3oLcLglMvYkgnmIxgyhhq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3PJU0ACgkQWt5b1Glr
+6X1bBAAo1PgH5MM+qS8A71ZEm5f2dZZqiPEjyqg3y1+3xKckjezr9AWH5KGmCdn
Wx2yIrfcNJAhxS+8p3XyTh4kKfEPPzI6mNxOFmf3DgcIIjCYWCRA3xFqabGmVySg
wlCKcPldFGbBSNA+CGumN/+Sx0Bp3yJbcUfam9O0+iss1juy5doEGM6F05tqnXpx
sV0/xhMQ6ExHNBQP+HpbiWsFWwyublXLhZU0qFC4lZFVeSQrNzSoQVOldSZrQKY9
ZD5csJ5MQpqNQF7l8Mm1RdEDSDby6KSAvFAtVOncqKgDELrsenhrPHbJ2CH6qMoU
d4YmM5c86hIHqzCNUL+J6R4yqXmHeXTYMPA6KVHlX7nxsUVyC8U93/mwFcMFZc8E
DvzfN/5TZ3gg8krZzZyZMP1IIFgmmexSL1h/aWNsOgVX3ROuHF9aN3F6mMDYgcqI
e0wU/eIA5G+mYQwhc/V69llDQdy61Q7wQDg/qyEWiupjvTXMcMSLGCuWYM5huqt9
LgBX61SO8DH18sMAFrzT+vjsS8L5NMxoY596f7lShqhf/akLynhF5AqKdQ1beCa1
ngb+9mLfIWdqYQK69hO7aZV09pUld+8kplb50y8x/5XB3Zx4pIxkSYkKqDiJ0DUd
3KSQKtpFYV5QgT5kMXu58cd0iIG9+3pAIp3dGaVaqBnXTqH7SSQ=
=hY3J
-----END PGP SIGNATURE-----

--nq9rWCIMDwLw3oLcLglMvYkgnmIxgyhhq--
