Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D95C432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 21:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A314220733
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 21:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC3A1AqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfKOVia (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:38:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39804 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKOVia (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 16:38:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so11930483wmi.4;
        Fri, 15 Nov 2019 13:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=uwEpTmbxHUwkJPEuUhSjRoTkXwQgTPyZZALSLtTxUsM=;
        b=nC3A1AqZ7Hh23lMMfrdtB6lC1OSuNuhWMZBrr2x7lrpIdw27X46kuCpXR6b7+l3seh
         vHjvVBlm4lfD5DAIMHCob4AAntfNTGPsYuCaKVxbBXy6u4dXWZq8BlXi4ApO1fprC82n
         HcJGYX2eJEQYrdHbk7YsBkwzbH3qOV0aZSLKCQSMo518D69W5ksshXO0g5U+9v77ESGm
         DrwrjJcrZI4FLmLb23Xh18s6nWKmqOjXoRRTq7BzdH6rX8fgdL/InPSvAKlkxIqHRBcq
         oGbrwQsnEGmWFZLsSoShcXXDn+G77bUM78FAQT7mzdSn43PgHioLP/jPFPfigFhEDkkn
         lLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=uwEpTmbxHUwkJPEuUhSjRoTkXwQgTPyZZALSLtTxUsM=;
        b=AzhDeghSqaCTB5i93DtEJMr83gi71RgDQUzPXLCwkJp/VCweeRZ+1K7Cp4HOzjICnn
         b6Ul3I/0dJ8I7HeGLhCykOsfyL/JympZh5PXJMbYS85AtL8MQkNDrvWO5S15rAfM6EIJ
         9DNVfSpXyWFm4eiVFxwBZqemYuqWrN68wzRCjrsa6lYiS3pXM15+Z9M1QNNGKJfREAZL
         gBIgqTd0M39smUF16nEvNeh0e+o9SMuZ/Iq997n5LYypsPMgq0A41nNJF8IzuOjpqqGI
         fQgJwUMMkzE+6z6Hrg3EpDMpYcRheAWDDwuVmv7AIrDtWi931om2a2QSAiyuhn3GlUqN
         ppww==
X-Gm-Message-State: APjAAAVCWouuDmEY56lxVV97LUZJatQf7mcSWgmcexTJ+4UQXBCe8+Ps
        oyAOPpf1Y5WIgrzb3q7nnhY=
X-Google-Smtp-Source: APXvYqwnVAVpPx6Mjm6tbhiJ+JrfOdfU5g86Ty3/lAZcVkOgVR4FQ+3Z11iN6teEUVJm9oDU7Q8muw==
X-Received: by 2002:a1c:7701:: with SMTP id t1mr18669374wmi.113.1573853905472;
        Fri, 15 Nov 2019 13:38:25 -0800 (PST)
Received: from [192.168.43.69] ([109.126.151.234])
        by smtp.gmail.com with ESMTPSA id q15sm11736219wmq.0.2019.11.15.13.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 13:38:24 -0800 (PST)
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
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
Message-ID: <bde153ca-ff2a-8899-172e-0aa6359bff8c@gmail.com>
Date:   Sat, 16 Nov 2019 00:38:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <cdba1334-b037-d223-29a6-051bd49fef70@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GUY2DrrXwMpuxsF7U4vcuwMpjVWZQ8o5H"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GUY2DrrXwMpuxsF7U4vcuwMpjVWZQ8o5H
Content-Type: multipart/mixed; boundary="hb0ti9ImGX0h6nbWDuOBdWpHnvqgZFm5o";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
Message-ID: <bde153ca-ff2a-8899-172e-0aa6359bff8c@gmail.com>
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
In-Reply-To: <cdba1334-b037-d223-29a6-051bd49fef70@kernel.dk>

--hb0ti9ImGX0h6nbWDuOBdWpHnvqgZFm5o
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16/11/2019 00:16, Jens Axboe wrote:
> On 11/15/19 12:34 PM, Jens Axboe wrote:
>> How about something like this? Should work (and be valid) to have any
>> sequence of timeout links, as long as there's something in front of it=
=2E
>> Commit message has more details.
>=20
> Updated below (missed the sqe free), easiest to check out the repo
> here:
>=20
> https://git.kernel.dk/cgit/linux-block/log/?h=3Dfor-5.5/io_uring-post
>=20
> as that will show the couple of prep patches, too. Let me know what
> you think.
>=20

Sure,

BTW, found "io_uring: make io_double_put_req() use normal completion
path" in the tree. And it do exactly the same, what my patch was doing,
the one which "blowed" the link test :)

I'd add there "req->flags | REQ_F_FAIL_LINK" in-between failed
io_req_defer() and calling io_double_put_req(). (in 2 places)
Otherwise, even though a request failed, it will enqueue the rest
of its link with io_queue_async_work().

--=20
Pavel Begunkov


--hb0ti9ImGX0h6nbWDuOBdWpHnvqgZFm5o--

--GUY2DrrXwMpuxsF7U4vcuwMpjVWZQ8o5H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3PGr8ACgkQWt5b1Glr
+6WtuRAAkZRafyFkUMMp9j/nQDoKq72ewDn+O74mGb5JbaYQjtlWXJS1i/QSBx3C
BeIgxqyzVM/szj7QE9vF+dmvjRP1QS9osZUFgN5fR04tkQQMBdjOUlYVInV1fATL
96V8a1UdkHF3TO1QVg9/DBrWR1+/6ZfMY018aFUXCMaVLDUaKn1PHQY7btYlbDCp
Ol7x5bEDv3QRYstdLPeU51UYZ/5WF/x8tuKkR5HCVfpTUhalusWFGcEKn8BL8pfg
QuqNEQFUNd37K6oDc16kzXA9O/P6z1B/PHra8Dkycw6RkBV2tHDSq3ciT8UzEJq3
crf1tCVVg2IqJzY2D3LNxY5Ib52YIlAlltoYaDBle6hBMtlxZEUwN3ABLyUebOV8
wacunxATG8PI27Zv/VVc6D3XRJ+NbEQ4BvAdxU8sUS26Xq3fRg1/4xs5E6ZQ9FAr
UKli01j5rSMgfWpwl6Pa6OplaC5adVZMHW9MQ5Jb1qfteZj5Fxtb3RHUgZ/AjTCc
L9JIGfM0Sap8zBRERC9MjKn1x/RTGGbw5qAgTmlDpZgpy6W/naPPxTLj48ZhDIdV
/WfthrzRXx4MpaBltxFCmORHcTo0YoGgCcRbzfzTysY9DzMbK3DXrmi8JovZA1eC
etV6tvthgGye148I2XSfis0OX7Jud0/oTP7fpo2eCkZ4RVHP6l4=
=XKTD
-----END PGP SIGNATURE-----

--GUY2DrrXwMpuxsF7U4vcuwMpjVWZQ8o5H--
