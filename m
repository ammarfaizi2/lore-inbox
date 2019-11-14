Return-Path: <SRS0=FaGP=ZG=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D398CC432C3
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 21:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35E220715
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 21:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLawHwyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfKNVZG (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:25:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45466 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNVZG (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 14 Nov 2019 16:25:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so8408476wrs.12;
        Thu, 14 Nov 2019 13:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=ImiXQbN24NBgByGoJiKiGNc4mFeky9Z/oHNNemIi9Nc=;
        b=SLawHwyXnaBiZ6eL94CuTnl8KZBlwz6NjX5VeuRkOYJsbTuALdvnECTZ7FPfD/HDFM
         OXytaKvGCZp60PUGFpAGqWRUSMRBT8767O4ZSFqjdd0Ccwwru7HtMB2J1Mgjdf0JBv04
         pPZRIVR82YEDvVLURMglcQYpdiyb8HGyZn3wxAL23aALMi0YDRAnEp/7LDG3YhC8mIAm
         gMrunhgWJT21+nxUWqY87MkwSu7M3W0TG1Gs2EE0mKSXGv1zU/guL8kLiWrb89LZ+6a9
         STtFfTaPQpaWV0astjjUERUScg0hgJV3nv/WLBDHKW6BvLgrXFWdPdVhkcp+FoHALofG
         ZAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=ImiXQbN24NBgByGoJiKiGNc4mFeky9Z/oHNNemIi9Nc=;
        b=qjqzyqcnkiwXA40Mt7l/CMwHq9XIKPMdYEAxftfGE8/RvkSfdr+BuI3qudBItVAjBs
         AvlJykADcyV81xUeZzaeV/hVXxDg6YBmOmQPU1EBwBMl84tC5lf9ZByp9QhTriVTzkWj
         xfNm1FLJjGH7KidIPLAQt/imCsr/lJuh93Hvm1ABlbyVhgg2/U635S5EuUtqBhas5Nwe
         Wgcqtn2cPfeuTtyLrHXYKKtZesUjN1yknWXhIJkeKbG9KCc+iyUIxs0wFvAjzy5UJdLv
         vtQKwfapnlx7WhuxipNvZnos2KlVCRGohiEjsGW/iCroHVfC/VZaLaQPTmlIZceNasrj
         P/wA==
X-Gm-Message-State: APjAAAXW/PX9MXQ/TowTM2HXUowDUQuV48IvhIp8LJiiVtZS5V87MvrP
        8nbZ4i/+AuJy+9SWjtfOLnWalDWA
X-Google-Smtp-Source: APXvYqzvJETm/lJstRL3iqOfdcpjBYqzr6t8FjuPKKIndfptyT7ywGjxzB5V/vaEjdAiXlU2tA/fqg==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr1975476wrr.361.1573766701167;
        Thu, 14 Nov 2019 13:25:01 -0800 (PST)
Received: from [192.168.43.69] ([109.126.151.234])
        by smtp.gmail.com with ESMTPSA id x205sm8790809wmb.5.2019.11.14.13.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 13:25:00 -0800 (PST)
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
References: <20191105211130.6130-1-axboe@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
Date:   Fri, 15 Nov 2019 00:24:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191105211130.6130-1-axboe@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TMi7c411IZUt39MEN9srlQJti8M9lXl8U"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TMi7c411IZUt39MEN9srlQJti8M9lXl8U
Content-Type: multipart/mixed; boundary="fHJxt2ncXxmdS4uRrA9WFBDHAORwsGcog";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
Message-ID: <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
References: <20191105211130.6130-1-axboe@kernel.dk>
In-Reply-To: <20191105211130.6130-1-axboe@kernel.dk>

--fHJxt2ncXxmdS4uRrA9WFBDHAORwsGcog
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06/11/2019 00:11, Jens Axboe wrote:
> Anyway, this is support for IORING_OP_LINK_TIMEOUT. Unlike the timeouts=

> we have now that work on purely the CQ ring, these timeouts are
> specifically tied to a specific command. They are meant to be used to
> auto-cancel a request, if it hasn't finished in X amount of time. The
> way to use then is to setup your command as you usually would, but then=

> mark is IOSQE_IO_LINK and add an IORING_OP_LINK_TIMEOUT right after it.=

> That's how linked commands work to begin with. The main difference here=

> is that links are normally only started once the dependent request
> completes, but for IORING_OP_LINK_TIMEOUT they are armed as soon as we
> start the dependent request.
>=20
> If the dependent request finishes before the linked timeout, the timeou=
t
> is canceled. If the timeout finishes before the dependent request, the
> dependent request is attempted canceled.
>=20
> IORING_OP_LINK_TIMEOUT is setup just like IORING_OP_TIMEOUT in terms
> of passing in the timespec associated with it.
>=20
> I added a bunch of test cases to liburing, currently residing in a
> link-timeout branch. View them here:
>=20

Finally got to this patch. I think, find it adding too many edge cases
and it isn't integrated consistently into what we have now. I would love
to hear your vision, but I'd try to implement them in such a way, that it=

doesn't need to modify the framework, at least for some particular case.
In other words, as opcodes could have been added from the outside with a
function table.

Also, it's not so consistent with the userspace API as well.

1. If we specified drain for the timeout, should its start be delayed
until then? I would prefer so.

E.g. send_msg + drained linked_timeout, which would set a timeout from th=
e
start of the send.

2. Why it could be only the second one in a link? May we want to cancel
from a certain point?
e.g. "op1 -> op2 -> timeout -> op3" cancels op2 and op3

3. It's a bit strange, that the timeout affects a request from the left,
and after as an consequence cancels everything on the right (i.e. chain).=

Could we place it in the head? So it would affect all requests on the rig=
ht
from it.

4. I'd prefer to handle it as a new generic command and setting a timer
in __io_submit_sqe().

I believe we can do it more gracefully, and at the same moment giving
more freedom to the user. What do you think?


> https://git.kernel.dk/cgit/liburing/commit/?h=3Dlink-timeout&id=3Dbc1bd=
5e97e2c758d6fd975bd35843b9b2c770c5a
>=20
> Patches are against for-5.5/io_uring, and can currently also be found i=
n
> my for-5.5/io_uring-test branch.
>=20
>  fs/io_uring.c                 | 203 +++++++++++++++++++++++++++++++---=

>  include/uapi/linux/io_uring.h |   1 +
>  2 files changed, 187 insertions(+), 17 deletions(-)
>=20

--=20
Pavel Begunkov


--fHJxt2ncXxmdS4uRrA9WFBDHAORwsGcog--

--TMi7c411IZUt39MEN9srlQJti8M9lXl8U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3Nxh8ACgkQWt5b1Glr
+6Vqzg//cnQfItPaNoq2yJ0yUkCXW8JXnfwuvqS41jsEM/f+OiNWHsQF3hytQlIB
jIlRGboRvFTeJ7jfqos8QFpP/MlPJ8CRqisXfFzjJsKa7aI1bAHAnZwo5SJGS1sp
q6jE2zwjTFqeUcMVhoxNx2jhfmbPyTyan5XsDILWQQ/AH+Viw1qimmYBDB4UvZnT
5OLmIkMZ5dH4q96H/uIXbraDdiFk16O2sEtypTrGhSIOWrKLmBYbDmKA+rcSMoU2
hyFXHvf690fJ2ldeH5RqkehYJVD3wX41ixEau2yeXxVFWrJACfvRU1D0LV8BChHJ
SLUX+N8xQlgZnMaGGOMdnwyb7rDvUZ3NlQd3NWPeqHg2gaG41X+Hz7CHwdPmVxk8
JEcJgt1MEPUJwJiywbKwXMq1GYEr9UsUMFqMuWEb4L1eLULNgaQQ7Hryl+yaMFrs
lLLbBfS0t4Zl4WE/IVy8GDmyJuWnNz234otvCIWyOdMDby578UHBd7stJqnqzmGz
ZsADOEgIMnquPvOzilyJTAiNzLMpxDfZbMkZz6hy6Zz2mc8NhsTXBWOwNi2Hi4YO
llGq1Hjm3Np5YT8/2Qfob9IEX1YIezziMmsb/+8Yb3z9lWpc15/Ya7bPO/7M4Avs
+tKkj+5rF/H1gtdJdIAoE1lMJzs/CiUf1ZW3iERoHjD3llLemdI=
=pDKs
-----END PGP SIGNATURE-----

--TMi7c411IZUt39MEN9srlQJti8M9lXl8U--
