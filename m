Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B64C432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 14:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9627620715
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 14:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEr/89xJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfKOOVy (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:21:54 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:53496 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfKOOVy (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 09:21:54 -0500
Received: by mail-wm1-f53.google.com with SMTP id u18so9850505wmc.3;
        Fri, 15 Nov 2019 06:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=cr0iCsvxv11e2DB+YXuGKeWcornmvgCi9lMUHj+I+co=;
        b=dEr/89xJjLcVkiea6bvHlRZ4cRh3xrGs3fQLyNDejDN/gHbR38jPomukivt2I9g3bN
         zzB9L7JdWWtSeh23Lwcv9b3P0FePtOkSVw3eVd7x+YqbzogPYKmGU1J9HAG8Wmfok3ID
         QeN1bNan8wfOe8H/W66PTAQxAAMSmEJ+l+AJcRzYDEih/SuLcYfO/fZaCIhyd6+dEDkm
         dlWKHGZZA8JNLrletrRZ5JyoCFMtv9H42EPKYdofqOHEShwhEYqDGDMTJ7vgj1EIe2hb
         WWQOx4XWH8l2K5gMnKoc3qjeembfUCM4teqbj/n34Quk5HdYtQsX8nq6p52CBUrNltpK
         UMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=cr0iCsvxv11e2DB+YXuGKeWcornmvgCi9lMUHj+I+co=;
        b=K23uVtw5fTj0qKkUniOIsrhuEk8Gnz57noZDhDUuakJaugxfkl8wqWHvLVjX6HjIyW
         5WjwtkyT67WHB3qyHx7EOO0mceQhKycXKx4e4EUnw5PkTuuOvTt1l1QthvMB+NlwoF8y
         qC6ga8vnq4075Nv2S/1yneAuSHRKE/uHbWUwr415uvtbO+T4pPjuuj1ITHruuSwbmy04
         pCch826SkFKFeKNXrXT2THf9NBUaMxFxw6kIwrCChyKUgfhWQJhkX68OiuONipoyWoWf
         /g7phSD3fZBvt83oQ3Z2YXitMvmvNVyv2C/kjWlLaD7j69Y8FCuh7Lk1lok6i739lsEY
         0QWQ==
X-Gm-Message-State: APjAAAUTuXxQm60OFsewitG5I0tMXB40OWqoPuSZzxbw1lHemfFd5Ofg
        vNIpLdwXfl2+nekSNZaoeAc=
X-Google-Smtp-Source: APXvYqyV5oMumVV+dcn13gyLjCaZDHicVGO3fTlkPdRgEpzaBJnq2vkW4j5w4xqPN4a0m+J92iO2mg==
X-Received: by 2002:a1c:e40b:: with SMTP id b11mr14809678wmh.152.1573827709753;
        Fri, 15 Nov 2019 06:21:49 -0800 (PST)
Received: from [192.168.43.69] ([109.126.151.234])
        by smtp.gmail.com with ESMTPSA id i25sm6458698wmd.25.2019.11.15.06.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:21:49 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
Message-ID: <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
Date:   Fri, 15 Nov 2019 17:21:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SnITHW8xp3JPKlkdsZYPZj95dCiZS22TR"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SnITHW8xp3JPKlkdsZYPZj95dCiZS22TR
Content-Type: multipart/mixed; boundary="tX0HxAW0PPArWg4PSxL8XOKZKyyAa2qrs";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
Message-ID: <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
In-Reply-To: <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>

--tX0HxAW0PPArWg4PSxL8XOKZKyyAa2qrs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15/11/2019 12:40, Pavel Begunkov wrote:
>>> Finally got to this patch. I think, find it adding too many edge case=
s
>>> and it isn't integrated consistently into what we have now. I would l=
ove
>>> to hear your vision, but I'd try to implement them in such a way, tha=
t it
>>> doesn't need to modify the framework, at least for some particular ca=
se.
>>> In other words, as opcodes could have been added from the outside wit=
h a
>>> function table.
>>
>> I agree, it could do with a bit of cleanup. Incrementals would be
>> appreciated!
>>
>>> Also, it's not so consistent with the userspace API as well.
>>>
>>> 1. If we specified drain for the timeout, should its start be delayed=

>>> until then? I would prefer so.
>>>
>>> E.g. send_msg + drained linked_timeout, which would set a timeout fro=
m the
>>> start of the send.
>>
>> What cases would that apply to, what would the timeout even do in this=

>> case? The point of the linked timeout is to abort the previous command=
=2E
>> Maybe I'm not following what you mean here.
>>
> Hmm, got it a bit wrong with defer. io_queue_link_head() can defer it
> without setting timeout. However, it seems that io_wq_submit_work()
> won't set a timer, as it uses __io_submit_sqe(), but not
> __io_queue_sqe(), which handles all this with linked timeouts.
>=20
> Indeed, maybe it be, that you wanted to place it in __io_submit_sqe?
>=20
>>> 2. Why it could be only the second one in a link? May we want to canc=
el
>>> from a certain point?
>>> e.g. "op1 -> op2 -> timeout -> op3" cancels op2 and op3
>>
>> Logically it need not be the second, it just has to follow another
>> request. Is there a bug there?
>>
> __io_queue_sqe looks only for the second one in a link. Other linked
> timeouts will be ignored, if I get the code right.
>=20
> Also linking may (or __may not__) be an issue. As you remember, the hea=
d
> is linked through link_list, and all following with list.
> i.e. req_head.link_list <-> req.list <-> req.list <-> req.list
>=20
> free_req() (last time I saw it), expects that timeout's previous reques=
t
> is linked with link_list. If a timeout can fire in the middle of a link=

> (during execution), this could be not the case. But it depends on when
> we set an timeout.
>=20
> BTW, personally I'd link them all through link_list. E.g. may get rid o=
f
> splicing in free_req(). I'll try to make it later.
>=20
>>> 3. It's a bit strange, that the timeout affects a request from the le=
ft,
>>> and after as an consequence cancels everything on the right (i.e. cha=
in).
>>> Could we place it in the head? So it would affect all requests on the=
 right
>>> from it.
>>
>> But that's how links work, though. If you keep linking, then everythin=
g
>> that depends on X will fail, if X itself isn't succesful.
>>
> Right. That's about what userspace API would be saner. To place timeout=

> on the left of a request, or on the right, with the same resulting effe=
ct.
>=20
> Let put this question away until the others are clear.
>=20
>>> 4. I'd prefer to handle it as a new generic command and setting a tim=
er
>>> in __io_submit_sqe().
>>>
>>> I believe we can do it more gracefully, and at the same moment giving=

>>> more freedom to the user. What do you think?
>>
>> I just think we need to make sure the ground rules are sane. I'm going=

>> to write a few test cases to make sure we do the right thing.
>>
>=20
Ok, let me try to state some rules to discuss:

1. REQ -> LINK_TIMEOUT
is a valid use case

2. timeout is set at the moment of starting execution of operation.
e.g. REQ1, REQ2|DRAIN -> LINK_TIMEOUT

Timer is set at the moment, when everything is drained and we
sending REQ. i.e. after completion of REQ1

3. REQ1 -> LINK_TIMEOUT1 -> REQ2 -> LINK_TIMEOUT2

is valid, and LINK_TIMEOUT2 will be set, at the moment of
start of REQ2's execution. It also mean, that if
LINK_TIMEOUT1 fires, it will cancel REQ1, and REQ2
with LINK_TIMEOUT2 (with proper return values)

4. REQ1, LINK_TIMEOUT
is invalid, fail it

5. LINK_TIMEOUT1 -> LINK_TIMEOUT2
Fail first, link-fail (aka cancelled) for the second one

6. REQ1 -> LINK_TIMEOUT1 -> LINK_TIMEOUT2
execute REQ1+LINK_TIMEOUT1, and then fail LINK_TIMEOUT2 as
invalid. Also, LINK_TIMEOUT2 could be just cancelled
(e.g. if fail_links for REQ1)

--=20
Pavel Begunkov


--tX0HxAW0PPArWg4PSxL8XOKZKyyAa2qrs--

--SnITHW8xp3JPKlkdsZYPZj95dCiZS22TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3OtG8ACgkQWt5b1Glr
+6Uwvg/+JnXZcdVL/C19frJrR/M9nvyZkOGdq5QLaEVEmuvgOy9uCU3cZVd0Fvhv
iEmXvyQPuk9Vwu34do0njwudiVUEFOx7HkkN1ItT0xsi/BQCh/0EWNmLVSD+4DWF
WaCcBzoPcLHbW1QmLJqSl/k7a8ouL+Me2PczNOkJb7HhJHVQzuITEDABtsz2VVMi
oqfIW/5Qqt2PoSLdVkdu2Fhq1QOCq/gutlmBXBPWPDouvx4sfdUYQqFLqVyabpzK
hXcfTlGsY8emdvsQTU7+mIx+Ls/VAXbeylOniFefy1ZupbaK1fbAB0ilOkRuUf0Z
sRo6m03OMxg+Te8cNFIkSeCgEptW3rN5qWLNYYPJ52eRnGSUfZIrRJx534uxjl6w
XmB6d1ZId88Vxw4kveoJlLKnJoDCW5yQuqf46q4p1G6sRIAZ2Jcmgl96YkRExCJ/
NT6J5xVxPJT9+gkFUmSlGdewHAKYH9KYRn1UXXAtrUcn7Ud7065IoucgFIBj8jl3
7l2au+1LEer3C5IST390DEkh1O48iaq37fgBxb0dHNRiF2h/GqKzHzitX4lXOKNr
CuOKJ86YhX2Vj18CS+GwUffIWtHg8CQRzd8uDYd/z/jgfaz1fm7kfW5CdbsOwYLk
65m9THXsGSDdBvtmzQyxgk4fAj455voxCIs3UkJaKX5/OG8R/SI=
=svtN
-----END PGP SIGNATURE-----

--SnITHW8xp3JPKlkdsZYPZj95dCiZS22TR--
