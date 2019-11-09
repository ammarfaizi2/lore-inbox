Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1E5C43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 19:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6252D21882
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 19:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgTGdqS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfKITZV (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 14:25:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36907 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfKITZV (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 14:25:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so1193213wmj.2
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 11:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=T7FlVyZ5S8RdlkH9cNNelNWaq19X1Rq3em1QgAS28VQ=;
        b=AgTGdqS6knSsriI9YKu4N2np05prXKKUKyCgD4Bfohvm+UUq+M5EqzImMBDbE6DooH
         8FQV0Hy9Ubl7n/dC9CJ7U5qIFY8OxNqziUGb3/MCCn5+NIa1YLZk/43kx9tMb6kzZKWC
         kqtI6XGJ43VGDE3Dp33jzbRSnjXxfxpt0BsCw7611Bd4McHas3rzS/B+NvfFLueDovaK
         hxlHV1nvCC13Vtfjjp1IEYVJsbgXH4h9aP3ZKd3DvSAogB88Ps7Nqiwj87Vpt484Kghv
         VMjfu29SLfK8onAzmiTBh5tsLHiTH68WFNEgWNeTHXVEr5HqV4pqFU87VBxHrAhJoNur
         ZBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=T7FlVyZ5S8RdlkH9cNNelNWaq19X1Rq3em1QgAS28VQ=;
        b=swT78Dd6Ux7WXtWHe4wmnATvnbzHKcURzB/IZzaamKG++TnuX5Q48/hrNSi9LBJjXr
         EeoBaQVKPRZ2VZok2DBQJ5siqFSTFFB33wBps9MUaGTsG8XMA58SuhEQyxMu0Phrrkiv
         Ux7fZRAinFscdDS6PF96htRJ0AjjsfszlJVXV3FlAHeuEwoH4dvMIhu/WJRGxhWWuKpK
         mO7f9aH4AbkE4W8mIUXTTurJuQIVGtVfpOqVhK/NC2v4AJsfYSULeCHFEHaH/ZBrbszr
         B60yfAyV6FbUGuI6BRxGmNLbZwcXr1D+fvJd4EHkpiWwMOCBmTLd74SJROWC6Lw87RDL
         A6Mg==
X-Gm-Message-State: APjAAAWSy9aMyR13W4zUdZ9CkUI4eVz3IQanzPUfEG1macvwvPyAoz7F
        8pQrDWDF2CeUJGs3GUBTNQjoFKC7
X-Google-Smtp-Source: APXvYqwkJC5sDFux+KEz1xAplHmLQiZPl0K3BaFGk7hxvHJF3dLI8jSrHK/sr7yxG43MsK7QQw3/yw==
X-Received: by 2002:a7b:c768:: with SMTP id x8mr14347149wmk.26.1573327518391;
        Sat, 09 Nov 2019 11:25:18 -0800 (PST)
Received: from [192.168.43.77] ([109.126.135.169])
        by smtp.gmail.com with ESMTPSA id n23sm9457543wmc.18.2019.11.09.11.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2019 11:25:17 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
 <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
 <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
 <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>
 <bdfdad32-91b7-7721-ccdf-0dd399e7e051@kernel.dk>
 <69985522-3e8e-102b-c8e9-ea9046cd22c6@gmail.com>
 <d8002007-7641-3e9d-0560-123358300e66@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
Message-ID: <45560c7f-08a3-afc9-c078-a5cc944d6455@gmail.com>
Date:   Sat, 9 Nov 2019 22:24:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <d8002007-7641-3e9d-0560-123358300e66@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ug3r0ZohTrTfYrDKiDlAXInT0eH7wZr9i"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ug3r0ZohTrTfYrDKiDlAXInT0eH7wZr9i
Content-Type: multipart/mixed; boundary="PSE8Jai5f3mL55DAquEeL0f2PQO4cnDZ8";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <45560c7f-08a3-afc9-c078-a5cc944d6455@gmail.com>
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
 <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
 <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
 <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>
 <bdfdad32-91b7-7721-ccdf-0dd399e7e051@kernel.dk>
 <69985522-3e8e-102b-c8e9-ea9046cd22c6@gmail.com>
 <d8002007-7641-3e9d-0560-123358300e66@kernel.dk>
In-Reply-To: <d8002007-7641-3e9d-0560-123358300e66@kernel.dk>

--PSE8Jai5f3mL55DAquEeL0f2PQO4cnDZ8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/11/2019 17:23, Jens Axboe wrote:
> On 11/9/19 4:16 AM, Pavel Begunkov wrote:
>>> I've been struggling a bit with how to make this reliable, and I'm no=
t
>>> so sure there's a way to do that. Let's say an application sets up a
>>> ring with 8 sq entries, which would then default to 16 cq entries. Wi=
th
>>> this patch, we'd allow 16 ios inflight. But what if the application d=
oes
>>>
>>> for (i =3D 0; i < 32; i++) {
>>> 	sqe =3D get_sqe();
>>> 	prep_sqe();
>>> 	submit_sqe();
>>> }
>>>
>>> And then directly proceeds to:
>>>
>>> do {
>>> 	get_completions();
>>> } while (has_completions);
>>>
>>> As long as fewer than 16 requests complete before we start reaping,
>>> we don't lose any events. Hence there's a risk of breaking existing
>>> setups with this, even though I don't think that's a high risk.
>>>
>>
>> I think, this should be considered as an erroneous usage of the API.
>> It's better to fail ASAP than to be surprised in a production
>> system, because of non-deterministic nature of such code. Even worse
>> with trying to debug such stuff.
>>
>> As for me, cases like below are too far-fetched
>>
>> for (i =3D 0; i < n; i++)
>> 	submit_read_sqe()
>> for (i =3D 0; i < n; i++) {
>> 	device_allow_next_read()
>> 	get_single_cqe()
>> }
>=20
> I can't really disagree with that, it's a use case that's bound to fail=

> every now and then...
>=20
> But if we agree that's the case, then we should be able to just limit
> based on the cq ring size in question.
>=20
> Do we make it different fro CQ_NODROP and !CQ_NODROP or not? Because th=
e
> above case would work with CQ_NODROP, reliably. At least CQ_NODROP is
> new so we get to set the rules for that one, they just have to make
> sense.
>=20
=2E..would work reliably... and also would let user know about
stalling (-EBUSY). I thinks it's a good idea to always do
CQ_NODROP, as in the backlogged patch update.

--=20
Pavel Begunkov


--PSE8Jai5f3mL55DAquEeL0f2PQO4cnDZ8--

--ug3r0ZohTrTfYrDKiDlAXInT0eH7wZr9i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3HEowACgkQWt5b1Glr
+6VkwA//e7Gfr85JpaFUE7yPHHjAua1HnjxO7FMoip7HOF+kZBwJjUtR3VVhN0iC
GCU0nkU6CUUW7wyACufVqC0/wJJAkpxOCrddnJORW4oqXZ3MZJCO9UWezLe87oQS
deKHRPnrweu+clvsNEbwu/03Xl1TvEK6x+1yjA0AwJZTMX5ildcZZZac8cmXzMrv
MKMxdQijNqsBxQInMcUSQgawtWCKmVDOtxx80spq74Fl3QGcAWjnNCy8SA68CIVe
YHQM2Ykx++O0iv+yPMN/m2VW3jr0lIj4AL6wBIG9BzYSmuzyMaf+2B/KKC4wfSoQ
oOAak5V/PatsT0drtku91qahFrnlvmALBbSU+fA+gXDSo+YFH+EmbevGIEM+BXPs
EwRvYmETHRxcF/j97ds15XBB+R3JFyABPVDT0p0g0ze+8EmntjX00xf4Qrqr8koU
bKLrXAN0obKxGGdsrl8o5lz7LOtP3WOtpxyPAKHrGvcs5vk3og661sf00KbHLOu+
qUmrwBzB83Ml8w5jdfb/XqOTyeZu/BMJwRKhCYEjhyOPaTXZ+YDZkDIjEzA36YT/
hA4GcL6atqZkvr5QyhjNRbLu5BBkCYhCN46lAZVxOjAp/hx6a0sJdqreUsfAjcP3
heZDFli8o2YhIz9C2FBydbN+alXdTuE2Dp30OAENsbIO0a7Fr1k=
=f7kk
-----END PGP SIGNATURE-----

--ug3r0ZohTrTfYrDKiDlAXInT0eH7wZr9i--
