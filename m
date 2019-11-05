Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19C9C5DF60
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563C32087E
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIOZpJw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfKEXng (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:43:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53175 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbfKEXng (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 18:43:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id c17so1325727wmk.2;
        Tue, 05 Nov 2019 15:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=j4dNR7LASW9I4N5arv4r0p/xc9NcmekwQTe0qVj09a0=;
        b=XIOZpJw48+rzztba7KwgNUlYhesS6WuUiK4RFKxIKwwmDm+kpU/MKsYusuyLVGvp5n
         8PKUVOpSc6NRsz+EwdJvi5VJkTKEeLm8LL2m5cIa1Ag7AppamiP7zXGIfU9Kd64jIs0w
         EcnTvee1T+c+K3mjlrqdO4HjH2t/Ii9NmYgltTcxJ+FnPMjZd6Deyio3yXnyGacAZ4px
         RaXXUJsysroLV1jNxLyBXRdCcOu3UgLWPZp6mZigj3kpsrgfXyxHFtOQhij8wwr7PbXq
         z/ySgLqWJaQqaCCQ66LjvVJJky2+2yHE3i9OdJpMD9sC8ddljdaz1enn5yI0mRpuK1XQ
         dSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=j4dNR7LASW9I4N5arv4r0p/xc9NcmekwQTe0qVj09a0=;
        b=jTvVtoJADRDVyLyl1QJVKNs/ag44jYPdjo7dhE2BHDsxtPxLkXYwVuglKXKkxr26f+
         zL1PGg61tNqIl2U/vU0VDUR1d+OGwrnUED3HAvFqCVa1qUtJssq1X4zOJMFCE2EwREFU
         YsVlixV4Zxi38yZAZ93nqO12NMsmWLoxcDcKukNadyzva/R4FCI7lsbIyspHp0v5p88F
         3IZ1ttwMP18113GPLESBMaE/BaGpaRB8JGjq9c4gZ0alpunxZx63Vc6eJU9pasPZfzRs
         602zk9S5R4+EPbrMKalEvTGnMjTmOo4AuwXsGEZxI8V/PaLDnpNwCK3sZc8rtElP9qFh
         bY5g==
X-Gm-Message-State: APjAAAWVLKwrF6OTQUYG1rZu9GKe5OZUCxr4UUVG+LdqAiRUwXTl4wrF
        gwb7mfw6JkHv3rrodyOOxsTFKg+z
X-Google-Smtp-Source: APXvYqwF/bL2IqNbm7hMs7WLCHidnJZ670X3JfhiJpnDU+KdMd/aPjIPrnRorhODSX1EPqNBkK2NeA==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr1270106wmj.125.1572997412594;
        Tue, 05 Nov 2019 15:43:32 -0800 (PST)
Received: from [192.168.43.132] ([109.126.129.81])
        by smtp.gmail.com with ESMTPSA id z6sm23447096wro.18.2019.11.05.15.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:43:32 -0800 (PST)
Subject: Re: [PATCH 3/3] io_uring: use inlined struct sqe_submit
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1572993994.git.asml.silence@gmail.com>
 <e9f1f564ec60748c4ad266ec6bace9b2df392b58.1572993994.git.asml.silence@gmail.com>
 <589994ea-6528-eac0-e0c6-b496ee5bebd2@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <da1ab11d-d1c1-6e3f-4083-6cf06d03ceee@gmail.com>
Date:   Wed, 6 Nov 2019 02:43:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <589994ea-6528-eac0-e0c6-b496ee5bebd2@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WlVl7eLDMKVyvfWUhS6y6TFezwOYpedLu"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WlVl7eLDMKVyvfWUhS6y6TFezwOYpedLu
Content-Type: multipart/mixed; boundary="WkrlIt2ORJKwerlhxjDy7oduk0TfsEiyh";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Message-ID: <da1ab11d-d1c1-6e3f-4083-6cf06d03ceee@gmail.com>
Subject: Re: [PATCH 3/3] io_uring: use inlined struct sqe_submit
References: <cover.1572993994.git.asml.silence@gmail.com>
 <e9f1f564ec60748c4ad266ec6bace9b2df392b58.1572993994.git.asml.silence@gmail.com>
 <589994ea-6528-eac0-e0c6-b496ee5bebd2@kernel.dk>
In-Reply-To: <589994ea-6528-eac0-e0c6-b496ee5bebd2@kernel.dk>

--WkrlIt2ORJKwerlhxjDy7oduk0TfsEiyh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06/11/2019 02:37, Jens Axboe wrote:
> On 11/5/19 4:04 PM, Pavel Begunkov wrote:
>> @@ -2475,31 +2475,30 @@ static int __io_queue_sqe(struct io_ring_ctx *=
ctx, struct io_kiocb *req,
>>   	return ret;
>>   }
>>  =20
>> -static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req=
,
>> -			struct sqe_submit *s)
>> +static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req=
)
>>   {
>>   	int ret;
>>  =20
>> -	ret =3D io_req_defer(ctx, req, s->sqe);
>> +	ret =3D io_req_defer(ctx, req);
>>   	if (ret) {
>>   		if (ret !=3D -EIOCBQUEUED) {
>>   			io_free_req(req, NULL);
>> -			io_cqring_add_event(ctx, s->sqe->user_data, ret);
>> +			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
>=20
> Cases like these are now (or can be) use-after-free. Same with this one=
:
>=20
Hmm, lost this in rebasing. Good catch!

>> @@ -2507,12 +2506,12 @@ static int io_queue_link_head(struct io_ring_c=
tx *ctx, struct io_kiocb *req,
>>   	 * list.
>>   	 */
>>   	req->flags |=3D REQ_F_IO_DRAIN;
>> -	ret =3D io_req_defer(ctx, req, s->sqe);
>> +	ret =3D io_req_defer(ctx, req);
>>   	if (ret) {
>>   		if (ret !=3D -EIOCBQUEUED) {
>>   			io_free_req(req, NULL);
>>   			__io_free_req(shadow);
>> -			io_cqring_add_event(ctx, s->sqe->user_data, ret);
>> +			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
>>   			return 0;
>=20
> Free the req, then deref it...
>=20

--=20
Pavel Begunkov


--WkrlIt2ORJKwerlhxjDy7oduk0TfsEiyh--

--WlVl7eLDMKVyvfWUhS6y6TFezwOYpedLu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3CCRwACgkQWt5b1Glr
+6WTMw//T7HN+y3UDhFDuxrRjcmxqdU7b4SpzIT4LeC358tlbFXoHD+yVvOaiK5z
73gVuas+9gFSgMzoFywtKgawBjuwsFgul8DwWru4/9deBfMKs1TG2+Ep8RGOp6Tm
Zyqc1gcnwikD+sND1qPDabVu4YGWI3CO0msnRWhCcQjTnCJZOYAtSKn+O6K52m8A
PJ0zEOR4+1rXLW2c1O3aElMNSfeWyxPSET3I/bn78djq8rdfgCn20Ocw2RcCkaJJ
y61JrctA92sv/zv/Ur9QCVVMbNn9f+r0JT5CVbSwbGcJ2oqmYEMejVnKqY4tjkFX
4vdDUFpELx8UuhiHoVL91zlxGntoEIrF1fUiVEgb2qWvY9PdLR9N3wBWIJUnYeFA
kEP+s2VxyCsK6p5HGHymjui/WAdecJHODlEH8+RXbwplvI/MtBMqIwXshfa/AzLU
/ZP3NutwcBs6wTDlC5LphzoEk38jSmOx5tufKyw982R1TyCdrga5xn1X3FWjB5oy
1cZxPHPW9OmZuyyC76SPn98KDjeuOJnCHv6x/XN07uo8bvcgXAlUBGxirWocy9Kx
W822dWYao02Y7YRPYSR28T99t5fTZ/6nw05FYSzitPTJ5uOusl1ivj4W/wL/e6PZ
E/oDpXtDfHoPzYE+HjxdK8NS08nnJTE7urn/M1z2IYDGX/Tu4rs=
=RCku
-----END PGP SIGNATURE-----

--WlVl7eLDMKVyvfWUhS6y6TFezwOYpedLu--
