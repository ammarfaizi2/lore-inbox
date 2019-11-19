Return-Path: <SRS0=5OhC=ZL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF48C432C0
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 21:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EC5223D8
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 21:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEiFMJFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKSVLa (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:11:30 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:32851 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSVLa (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 16:11:30 -0500
Received: by mail-wr1-f45.google.com with SMTP id w9so25634172wrr.0;
        Tue, 19 Nov 2019 13:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=kXuBAAZwSFST0qd19QtDRG+IPDL0ENNYnjBWKHvJp5g=;
        b=cEiFMJFKEXk7zLqRXR97LTKSHvL3Pizx1Lf8lZYw3ze5bMZCbf8mdUywGEWsD4z6IL
         4q2QAaaryPPAVes+O+Aoyrp1RwJj4XRxya/rxhdgy7eDdH8fyguiDfl/C/8M9CwxebmU
         ZxLP7PDCpGoN3mG2AFlaL0jMuskf9GFkwzhv15atjwfpru+rc7epQ/npIJ5cXp7f61La
         UCgIqtP2kk7R6fJVeFOirPnZi0SavEF+ZHWk+pw2Z44kWYAF5CBwtnEggeii1PpLji5A
         IhmlOUgD1zKxJuYZ4Fa9wR+9A3uRMBtJ6MHJKiBFfjnPE8EFtoR/vQgTFX0+vjjF9t8I
         xHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=kXuBAAZwSFST0qd19QtDRG+IPDL0ENNYnjBWKHvJp5g=;
        b=NksPz3Lqa6ZrS3tJZJJsOjgPOzgpWpogbLk/7FFrG+vGiAEjn3jyE2HHD1VV7xDRsk
         yxTNZMpCeYQigVs4qY3F/xMDokSE786jaxe6kKSzTxZA3ovUxG4vYyPlml4nvWwxpfiG
         3uwMmD9enFMTzSCJqiap5/n0F3cZOByz1dp/nf77xgnpBnQu3z/Q5ZApKPn5aoKbSl1J
         aVW1Urex6v0ifnM9I03rAaSql4qeFt7e86rgOFxGVSf/VLFmyRPhNFAsjtInGI8cJQDi
         pMChO321t1LzZ2sGZaUsCvUFHwfV1JFsJ+CqnUzvTW1EOm8x0T938+nIvnK6LyAl7rBa
         lmVQ==
X-Gm-Message-State: APjAAAUrc79mF8b2TIRqX7R5VIpkls4qHNlL/wHFvlRKcb7OYKLjw2nm
        t+h5/jAyzyKGl6/SFZpKijM=
X-Google-Smtp-Source: APXvYqygnhjXCke235b6xrYBlXgkkS9tfYRwrqS2Vvdp95RZzq+pQvPGB2570AOcd6lUC2y2tDypbQ==
X-Received: by 2002:adf:f048:: with SMTP id t8mr25026076wro.237.1574197885147;
        Tue, 19 Nov 2019 13:11:25 -0800 (PST)
Received: from [192.168.43.115] ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id b1sm26857542wrs.74.2019.11.19.13.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 13:11:24 -0800 (PST)
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
 <06929659-a545-87c8-fbf4-edfc01c69520@gmail.com>
 <71860cea-313d-b6ef-895d-9635c73d7530@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
Message-ID: <025ba8ae-2ff9-a620-de9b-2b851f0ca708@gmail.com>
Date:   Wed, 20 Nov 2019 00:11:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <71860cea-313d-b6ef-895d-9635c73d7530@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jUBFEm2wFDAMZeuUlCGuxrYc5R4mmlpAR"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jUBFEm2wFDAMZeuUlCGuxrYc5R4mmlpAR
Content-Type: multipart/mixed; boundary="vAeD9ZpwBUXAE4G9WfS2zsr9VF2L9104n";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
Message-ID: <025ba8ae-2ff9-a620-de9b-2b851f0ca708@gmail.com>
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
 <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
 <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>
 <aabbed5f-db68-4a48-1596-28ac4110ce95@gmail.com>
 <2b35c1a0-69bf-1e50-8bda-2fff73bac8de@kernel.dk>
 <06929659-a545-87c8-fbf4-edfc01c69520@gmail.com>
 <71860cea-313d-b6ef-895d-9635c73d7530@kernel.dk>
In-Reply-To: <71860cea-313d-b6ef-895d-9635c73d7530@kernel.dk>

--vAeD9ZpwBUXAE4G9WfS2zsr9VF2L9104n
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16/11/2019 00:26, Jens Axboe wrote:
> On 11/15/19 2:22 PM, Pavel Begunkov wrote:
>> On 15/11/2019 22:34, Jens Axboe wrote:
>>> How about something like this? Should work (and be valid) to have any=

>>> sequence of timeout links, as long as there's something in front of i=
t.
>>> Commit message has more details.
>>
>> If you don't mind, I'll give a try rewriting this. A bit tight
>> on time, so hopefully by this Sunday.
>>
>> In any case, there are enough of edge cases, I need to spend some
>> time to review and check it.
>=20
> Of course, appreciate more eyes on this for sure. We'll see what happen=
s
> with 5.4 release, I suspect it won't happen until 11/24. In any case,
> this is not really staged yet, just sitting in for-5.5/io_uring-post
> as part of a series that'll likely go in after the initial merge.
>=20
Tangled up in cancellation and io-wq, so no reworking here until I
understand it well enough. I've sent a separate series for what spotted

I've wanted to return back a version with queuing linked timeout
before issuing request, but make the timeout callback mark the
master request as cancelled. e.g.=20

io_link_timeout_fn(req) {
	req->work.flags |=3D IO_WQ_WORK_CANCEL;
	try_to_cancel();
}
issue_req(req) {
	next =3D get_next(req);
	queue_linked_timeout(next);
	__issue_req(req);
}



There is another point to discuss until de-staged it. Did you consider
reverse syntax? e.g. LINKED_TIMEOUT -> REQ instead.

I think it's a bit more consistent, as any request affects only those
on right of it (from the user perspective).

Also, I'm tempted to implement the scheme above, and after remove all
linked timeout handling from submission path and move it into
io_issue_sqe() (last __io_submit_sqe) as yet another case in the switch.


>> REQ1 -> LINKED_TIMEOUT -> REQ2 -> REQ3
>> Is this a valid case? Just to check that I got this "can't have both" =
right.
>> If no, why so? I think there are a lot of use cases for this.
>=20
> Yes, it's valid. With the recently posted stuff, the only invalid case
> is having a linked timeout as the first entry since that's nonsensical.=

> It has to be linked from a previous request. We no longer need to
> restrict where the linked timeout appears otherwise.
>=20

--=20
Pavel Begunkov


--vAeD9ZpwBUXAE4G9WfS2zsr9VF2L9104n--

--jUBFEm2wFDAMZeuUlCGuxrYc5R4mmlpAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3UWmoACgkQWt5b1Glr
+6WJoQ/8CVnu/vQeBr+UI2xYKgUoZTvRXiCN8wWhuERrHt2LjZvFky9+pTqhiF19
RV2MjwlykyT/G4ofXT3hWY8BBD69KGNNLTQQGveF1p4gzJtQ3av22x3st0V3FFq+
zdLj4RhrxfvyLwegiuS2FTfXtjszFq9f/FZPoCScURgi0NywnM5PSurr5U3qktNh
JvQhkHhEQvWODMiqUw/k/NxpAnG9W4e7JeioTQpLvnxe7OgOsLV5Vfh/hH+AGyGV
9Rq12OETnfjIz93hs1XoTvMGqCcsVYsDjXtxtYMv36KIVAjS8L+xjlzSpTTo2BC0
WG9AaWPTE4zy7IoQ56hdfcqXdO3PdQxa4RMUAuUUXJPPA6iHkXuXfQCFh+DH+Zu4
bbrKlGUbgVJX/6RXxEAW+g3v0t3py7zzXJkBFXphpZ4oIX3JNzfU0Zhb3fI5LwML
sO/PBhymY5VDORA3TYdRsMsj/AOTlUFAo1FRXg7HjKOrsqYJL2lyKxYqFxvoPrgi
qANVEe7wS+Z5G6s2NwR5TZ5+/ebtW+o++GXb+fn8/TTAyWayqgahvvOaqegdpxzK
9cJXTii3vq/ntxoYcHInbH6K+yVnnPDAM/80D3Gb8qxU7QTBbK/UwDiSF7gyU4S6
iHCWm6VEQXiyGMSFSsew31SjeDBWRQ/NyuROt6meUOvkJYP0ll0=
=321g
-----END PGP SIGNATURE-----

--jUBFEm2wFDAMZeuUlCGuxrYc5R4mmlpAR--
