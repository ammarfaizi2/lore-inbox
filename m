Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D33AC5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 21:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BCF214D8
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 21:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcXIvlap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKFVzR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 16:55:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44430 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFVzQ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 16:55:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id f2so343126wrs.11;
        Wed, 06 Nov 2019 13:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=FWLCTfahXQoqpwieNtBzjF6IrKP4g5ztf8Rwz5scOgw=;
        b=HcXIvlapBIdPsqhww12KJ5TzJIWJ/ihMI7ij0Q4No2BOnOw3XUDbRmnOYoaisRYcKi
         5hcJkdaEDvGQto809SkZsvj/sEDX8XAGB8SCaiSeuni4KTOyGZ4/tY1fMpEqNt4dstdH
         OOuJuvMSHkK53JN0jpSw3mXgzgXSmvpFurfidAyLYW0I2Djr0+ebGt2vxEMWmuGLmLOk
         sTPto66FPJ8L11VVfCaorPvXIf0t4PEIa7J6Fs62Juwu/YTnE6Hm+QA3xsSUOLJkxCic
         OHtZ2zV+bKMx6y0PDk2ZhA/bW0ysS7iLrGSYfLlw5oOjbrKw7gaJQmeDVa15x6YeTl8G
         3wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=FWLCTfahXQoqpwieNtBzjF6IrKP4g5ztf8Rwz5scOgw=;
        b=uPBeX5iPWKYxtVzWdjtD5fC8Shw8oqwoOswdB2a8qRsgJWGHj9zleMiTlE0GeiejdX
         UVPK4nr5tCOOQX1RN/jt3zfLdOCGgd/CYu5pKvZajDCKnjNn06NAgg555UDiKOGtMvwa
         YEBgHPKBnTo3cFYqoE2Zwz5Y38YAFWzF7o8GgvPKAeURYfqnuJIXzcBq4J4dSOs3kAP9
         NKtA/IvXVkeQ2wygTLz7Xjwa4o+osUZyNTT5Vtog6ucXCwgUPo6HszBz5DzOn6zR7HDc
         2C2MCTgecr5EWJz0uABy7Dsz2/HhpZK0W3AT9inl7aJGwkGIxbxy5SZWI3FXqcn7YRjs
         Bnng==
X-Gm-Message-State: APjAAAUXDW8RLPw/LWdM8JZ21ZLZYH+sKfR0PPBD/ORHeQqFxRUlGKGJ
        vQG975l9l63mkKDv36hEKJAFF3VdOBY=
X-Google-Smtp-Source: APXvYqyTpSq1qNJRli/Fx+6BQHx9tZN+xK5mVlQs7sg+s5YprnFkZs0AmouSNKFFDVeJdr4bRqu6Ww==
X-Received: by 2002:a5d:414a:: with SMTP id c10mr5035394wrq.100.1573077312364;
        Wed, 06 Nov 2019 13:55:12 -0800 (PST)
Received: from [192.168.43.132] ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id j22sm26728wrd.41.2019.11.06.13.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 13:55:11 -0800 (PST)
Subject: Re: [RFC] io_uring CQ ring backpressure
To:     Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>
Cc:     io-uring@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
 <CAG48ez1_91Lk73sdpp1SiufOQShdP2zX6g9gMLW46gAvMioKOA@mail.gmail.com>
 <c01e91d3-0f20-00e9-e2c6-e4148f667fb6@kernel.dk>
 <7878d52d-d4bb-28e5-e8dc-87b2f0721b56@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <5b9e1953-0e32-150d-f607-39025bd1f034@gmail.com>
Date:   Thu, 7 Nov 2019 00:54:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <7878d52d-d4bb-28e5-e8dc-87b2f0721b56@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lpa314vZISROBSn3yy6NP9lVDTg7glisw"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lpa314vZISROBSn3yy6NP9lVDTg7glisw
Content-Type: multipart/mixed; boundary="wkDpzRKLDP3JSEPTuDWBHhOQCCKRcPztu";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>
Cc: io-uring@vger.kernel.org,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <5b9e1953-0e32-150d-f607-39025bd1f034@gmail.com>
Subject: Re: [RFC] io_uring CQ ring backpressure
References: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
 <CAG48ez1_91Lk73sdpp1SiufOQShdP2zX6g9gMLW46gAvMioKOA@mail.gmail.com>
 <c01e91d3-0f20-00e9-e2c6-e4148f667fb6@kernel.dk>
 <7878d52d-d4bb-28e5-e8dc-87b2f0721b56@kernel.dk>
In-Reply-To: <7878d52d-d4bb-28e5-e8dc-87b2f0721b56@kernel.dk>

--wkDpzRKLDP3JSEPTuDWBHhOQCCKRcPztu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/11/2019 00:31, Jens Axboe wrote:
> On 11/6/19 1:08 PM, Jens Axboe wrote:
>> On 11/6/19 12:51 PM, Jann Horn wrote:
>>> On Wed, Nov 6, 2019 at 5:23 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> Currently we drop completion events, if the CQ ring is full. That's =
fine
>>>> for requests with bounded completion times, but it may make it harde=
r to
>>>> use io_uring with networked IO where request completion times are
>>>> generally unbounded. Or with POLL, for example, which is also unboun=
ded.
>>>>
>>>> This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a=
 bit
>>>> for CQ ring overflows. First of all, it doesn't overflow the ring, i=
t
>>>> simply stores backlog of completions that we weren't able to put int=
o
>>>> the CQ ring. To prevent the backlog from growing indefinitely, if th=
e
>>>> backlog is non-empty, we apply back pressure on IO submissions. Any
>>>> attempt to submit new IO with a non-empty backlog will get an -EBUSY=

>>>> return from the kernel.
>>>>
>>>> I think that makes for a pretty sane API in terms of how the applica=
tion
>>>> can handle it. With CQ_NODROP enabled, we'll never drop a completion=

>>>> event (well unless we're totally out of memory...), but we'll also n=
ot
>>>> allow submissions with a completion backlog.
>>> [...]
>>>> +static void io_cqring_overflow(struct io_ring_ctx *ctx, u64 ki_user=
_data,
>>>> +                              long res)
>>>> +       __must_hold(&ctx->completion_lock)
>>>> +{
>>>> +       struct cqe_drop *drop;
>>>> +
>>>> +       if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
>>>> +log_overflow:
>>>> +               WRITE_ONCE(ctx->rings->cq_overflow,
>>>> +                               atomic_inc_return(&ctx->cached_cq_ov=
erflow));
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       drop =3D kmalloc(sizeof(*drop), GFP_ATOMIC);
>>>> +       if (!drop)
>>>> +               goto log_overflow;
>>>> +
>>>> +       drop->user_data =3D ki_user_data;
>>>> +       drop->res =3D res;
>>>> +       list_add_tail(&drop->list, &ctx->cq_overflow_list);
>>>> +}
>>>
>>> This could potentially consume moderately large amounts of atomic
>>> memory quickly and without any guarantee that the memory will be free=
d
>>> anytime soon, right? That seems moderately bad. Is there no way to
>>> e.g. pre-reserve memory for completion events, or something like that=
?
>>
>> As soon as there's even one entry in that backlog, the ring won't acce=
pt
>> anymore new IO. So I don't think it's a huge concern. If we pre-reserv=
e,
>> we haven't really made much progress in making sure we don't drop even=
ts,
>> and we'll be tying up that memory all the time.
>>
>> The alternative, as Pavel also mentioned, is to re-use the io_kiocb
>> for this. But that'll tie up more memory, and it's a bit tricky with
>> the life times. Just because the request has completed doesn't mean
>> that someone isn't still holding a reference to it, and who knows
>> what they will do.
>=20
> OK, I took a stab at it, here's a brain dump of the "complications"
>=20
> 1) Some places now use __io_free_req() to drop both references, if we
>    know we haven't issued a request yet. Needs double drop, not a big
>    deal.
> 2) Some ordering changes between io_put_req() and the fill/add event
>    logic. Again not a huge deal, easy to spot.
> 3) We have one failure case that does not have a request, exactly becau=
se
>    we failed to allocate one. Don't look at that part in the below patc=
h,
>    I think what we should do here is just reserve a request for that ca=
se.
>    It won't help with the submission, but it'll get it logged correctly=

>    for the overflow backlog. Any new submission can't proceed with that=

>    request in the overflow backlog anyway, so we need just the one.
>    Not super pretty, but at least we can keep this out of the fast path=
,
>    as the only one that will free this request is the overflow flush
>    path.
>=20

2 (maybe partially) and 3 will hopefully be solved by the patchset
removing passing sqe_submit. I'll resend it in a minute.

> I'll do a prep patch that makes the fill/add event path deal in request=
s,
> then we can build the backpressure on top.
>=20

--=20
Pavel Begunkov


--wkDpzRKLDP3JSEPTuDWBHhOQCCKRcPztu--

--lpa314vZISROBSn3yy6NP9lVDTg7glisw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3DQTQACgkQWt5b1Glr
+6Xu+xAAkoJNV8RtKXKpscmrHymBn4M/0R5DOawvKyF4e65Rg3xGJBsDXPPpqeXx
U288wgEUPzNCsIvXD+MpMrxrW/HP++gsvF8Mes3gVYdkaxzd+ACE7MC9JugZbeAH
b2N923bHhQMShCaomCDRKILpuCltep4jrjnTHfva6DsScLM5sJ6MMXEwTN2L5Fr8
j0ecoUXJsDVq+AO+xsu3c/513Hm/P16vwqMG1df/nm2AHMRVHhOaxflMBjNC6TeP
a2Tvch9gARHDirTrQ+BrMGLUVmUwQnHjN3YMUrBdRWZs+KQ4OnpGbx8jmyBXOY/X
y/GeDg+hNf0hZwltUxHdUbdQnvXsntnhr4VnPgZgzIOBpVlC+JbRSF+eFKQtjOvU
h7qJW6YiMbjPAoJVF43CWFXTKPtbqNxnkKNunVAWxzZNrolhiBXWKiz6/rflQj6J
xTgC6En5PeasWCIBx35FU6fgRD1WkwuLuzTXLNgMFFougQ3ygGlOWqYnvJPYIP67
YXv0QZ0XUMMWncBCyhFlx9cLgzLlSS/YNyMDAsIwtfdfCeSmKlbOrTkSiolTO6Ik
SgoIEDz5KbJw6sWdxvB1wePb0chjDBGIgUr45pDjRA53yGEcndgqlCwFobjBH/xJ
LsG8qOEnopHXrS261btQXFmf8mGk2h7cIB7idnSb8RPry4f8CCI=
=PZFt
-----END PGP SIGNATURE-----

--lpa314vZISROBSn3yy6NP9lVDTg7glisw--
