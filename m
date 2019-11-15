Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40F7C432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 17:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B9B206D6
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 17:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYxHnovF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfKORMQ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:12:16 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:52377 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfKORMQ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 12:12:16 -0500
Received: by mail-wm1-f49.google.com with SMTP id l1so10386201wme.2;
        Fri, 15 Nov 2019 09:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=wUCRAnh9SXFop5nqWtHc5auIvv1qJaj7Mu1awOQyvl8=;
        b=XYxHnovF8Ou62Cv+aPkEMyUn8wPuz+kkyCAErTWWnEjhRtj+X0bvYplVABR2CeWPfn
         t0SGQnrPVlM5BcjHvHx7QjNSCChl43gdDelFWyrXj/I+acpZPlj8JqDg0AY8WTlgNqPu
         0LT7RsFOi1jqMn0ZYbrAAsrndNY5fTi4zdhbjxR1yylqd8YbuBqPiUFoSzbqGaQa0vm/
         fIjQhHob3BX6jCqRhA/sNnXmkTSvwA31yDSJq9lmAy1AxyoZrkLO4CnKv+LkiSg0NptV
         oG4BLMk4QrYKvS7Lnn3UZ7HfJypZaVlv0KTbS3YB34zwbfu5FNoB4YCNVaygGJMJlr3j
         JN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=wUCRAnh9SXFop5nqWtHc5auIvv1qJaj7Mu1awOQyvl8=;
        b=qaqioh2dJKUkWoc6+NLowiuWBoGUBoG6RnMWh1llYrBYkAJiod2WoV3z4FyCx1YSAy
         AsgvHCGowkNe5L0nGuN8QMehC0kp/xaPlYNeEHnL5h0Hz89WwC/3+uibbaNWZuSaD8fR
         +wanZHOlruG7oY8wPKw6eoNsWceHaDvFEk8NGWhGLKLsrumXs7Gh2UE8z5UzqMPh0VFa
         TBHKIrvm3mXt1UiL+AyjmF+O34KBmDw8+y3v07X1WdB2KmXVRA5fUXvhxHPvP3SDfk//
         DWsNXfALITCSpr6Xgo7IjdtiwENiu793kFyT/VvPFgZeGH1EBenGxfGk9YMBstmhuqbz
         fx0w==
X-Gm-Message-State: APjAAAWrw250YGJgKsLOqqCcMRkqqe2Mf4GJa7lUJ+N965Llg0HqU+T0
        iLu5wJnGMAwhJU+O8SmvgblwIA3K
X-Google-Smtp-Source: APXvYqwfQKqFb0WnPE/Al6mcHSTlTBoHDuWvjc7QwnkvFNhHY1OB8WBIyosX/wysb+xkSaPOwOUBeA==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr7494206wmk.37.1573837932873;
        Fri, 15 Nov 2019 09:12:12 -0800 (PST)
Received: from [192.168.43.69] ([109.126.151.234])
        by smtp.gmail.com with ESMTPSA id v9sm11696497wrs.95.2019.11.15.09.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 09:12:11 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
 <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
 <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
Message-ID: <aabbed5f-db68-4a48-1596-28ac4110ce95@gmail.com>
Date:   Fri, 15 Nov 2019 20:11:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TN2sznfti6AuMbALsTe3Llvpg0b2S6csi"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TN2sznfti6AuMbALsTe3Llvpg0b2S6csi
Content-Type: multipart/mixed; boundary="eTtXEYmp1UhJKZVIm5uEqT55EL7v4H40B";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
Message-ID: <aabbed5f-db68-4a48-1596-28ac4110ce95@gmail.com>
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
 <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
 <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>
In-Reply-To: <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>

--eTtXEYmp1UhJKZVIm5uEqT55EL7v4H40B
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

>>>> I just think we need to make sure the ground rules are sane. I'm goi=
ng
>>>> to write a few test cases to make sure we do the right thing.
>>>>
>>>
>> Ok, let me try to state some rules to discuss:
>=20
>> 1. REQ -> LINK_TIMEOUT
>> is a valid use case
>=20
> Yes
>=20
>> 2. timeout is set at the moment of starting execution of operation.
>> e.g. REQ1, REQ2|DRAIN -> LINK_TIMEOUT
>>
>> Timer is set at the moment, when everything is drained and we
>> sending REQ. i.e. after completion of REQ1
>=20
> Right, the timeout is prepped before REQ2 is started, armed when it is
> started (if not already done). The prep + arm split is important to
> ensure that a short timeout doesn't even find REQ2.
I've got (and seen the patch) for prep + arm split. Could a
submission block/take a long time? If so, it's probably not what
user would want.

e.g. WRITE -> LINK_TIMEOUT (1s)
- submit write (blocking, takes 2s)
- and only after this 2s have a chance to arm the timeout.

>=20
>> 3. REQ1 -> LINK_TIMEOUT1 -> REQ2 -> LINK_TIMEOUT2
>>
>> is valid, and LINK_TIMEOUT2 will be set, at the moment of
>> start of REQ2's execution. It also mean, that if
>> LINK_TIMEOUT1 fires, it will cancel REQ1, and REQ2
>> with LINK_TIMEOUT2 (with proper return values)
>=20
> That's not valid with the patches I sent. It could be, but we'd need to=

> fix that bit.
>=20
It should almost work, if we move linked timeout init/arm code=20
into __io_submit_sqe(). There is also a problem, which it'll solve:

If a request is deferred, it will skip timeout initialisation,
because io_req_defer() happens before __io_queue_sqe().
io_wq_submit_work() won't initialise/arm the timeout as well,
as it use __io_submit_sqe() directly. So
- rule 2. doesn't work
- free_req() calls io_link_cancel_timeout() for an non-inititialised
timeout


The case I keep in mind is:
read file -> SEND (+LINK_TIMEOUT)=20
	-> RECV (+LINK_TIMEOUT) -> write file ...

We don't care how long file read/write would take,
but would want to limit execution time for network operations.


>> 4. REQ1, LINK_TIMEOUT
>> is invalid, fail it
>=20
> Correct
>=20
>> 5. LINK_TIMEOUT1 -> LINK_TIMEOUT2
>> Fail first, link-fail (aka cancelled) for the second one
>=20
> Correct
>=20
>> 6. REQ1 -> LINK_TIMEOUT1 -> LINK_TIMEOUT2
>> execute REQ1+LINK_TIMEOUT1, and then fail LINK_TIMEOUT2 as
>> invalid. Also, LINK_TIMEOUT2 could be just cancelled
>> (e.g. if fail_links for REQ1)
>=20
> Given case 5, why would this one be legal?
>=20
This one is different if we conceptually consider
REQ + following LINK_TIMEOUT as a single operation with timeout.
If so, it can be said that (REQ1 -> LINK_TIMEOUT1) is valid
pair, but LINK_TIMEOUT2 is a following single link timeout,
that's more like in 4.


7. If we decide to not implement 3., what's about the case below?
REQ1 -> REQ2 -> LINK_TIMEOUT

--=20
Pavel Begunkov


--eTtXEYmp1UhJKZVIm5uEqT55EL7v4H40B--

--TN2sznfti6AuMbALsTe3Llvpg0b2S6csi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3O3FYACgkQWt5b1Glr
+6VRKw/7BS5ovVDpbmzq+U0rYdbVSidnigsrCCyep+BecswWSHfHFXv2fPlJgC2a
SjqNB+kQ8qOcEAGeUegwMKMQAi1ftpkhIcTz7xbz5EdV7gIpXts4MPIesQ0ZkVOA
o/fKn7r4/csldyNoCflpaENtcQaKBDfX6JiparnsxndfxJ6Um2HE+nHTpLoUWhGN
eEQ+oQBef/uP4BYMT+GBvCln1o8QtdltAa3g3yHnILzGp/3/o1WaIS4v7dMA+ivh
fy5N5DUUwTnQgo1CWjlpMUkDBSpnRbb/e8043+1AbEtytXiHWe8XybjEbX5fHS2q
MoNuIaPuvQZL4fMsqp4/++4815A8cDY0xbACJSVVzYXJh3Qon/9G7s5N3s8bDVgG
+cYuDoEQD4fqU20hGA1tgcZ3iFsroA7tUah068jRSxZ5NKPQltEoZUzOkF7U+yu0
vmRCJ38z+szvNwsodTo7y6qOIL/ATv67856kTTVLupUnoAWTiBOHU4jiTuF0GUvz
qg/lsoKvgECIPqG5W9xJrVBXH9aCbeCqzj0ED3wtQuvBf03Tl7024zrhjVIjVR2z
KHEEQK8YJ+4cszZY3p9raLS/HxUpjXvapzTnV6EBuumMn284HHBvy9GeNz5DjkE2
EpaLM9UVbyk1PI2CsMRXeA1R/64uR+X3ZY1W1O/7bq4Xa9GcS74=
=j61P
-----END PGP SIGNATURE-----

--TN2sznfti6AuMbALsTe3Llvpg0b2S6csi--
