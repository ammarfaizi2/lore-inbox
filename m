Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2532AFC6194
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA565217F4
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn+kamU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfKFWkq (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:40:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37856 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKFWkq (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 17:40:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so566873wrv.4;
        Wed, 06 Nov 2019 14:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=yUhRqhDRMrpNiCo+K2zhyLI6zu9uY8xGcm6iTm6sTFY=;
        b=Zn+kamU1jOUMBFhHay+wtZCxX/EZoMCdElfaufagFfzZqq3TUxJURE5MyZXB4NiyRx
         vBNwbyK3mxYwEBLzQksKXF8NIIo1Iqch01gshZhm1tAWF1CSsoLZJAsJNkgmn6Un261d
         NE6QpH8IVhy0q49RYPiCgXa2u3yuETsiWC114onbTzCf8hL10XnqPHIsx49zQITuQzJ3
         Nn075kSbo/fNxVgCdgE1TayPQjBOFLbB8plpP1K2cXrLT42fYhek64WElLFkLQ5eQbu8
         ez+hpIDbNRe6/PQESWM7NbP8W3kTWeHe4F4tqZE/p3RhODPQ3k3dR+VhxUGPE9BiFCU/
         9lLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=yUhRqhDRMrpNiCo+K2zhyLI6zu9uY8xGcm6iTm6sTFY=;
        b=WDx6kFKwDh9sW4//F0tpSPgPM68+9fBKNOxXLJcEn9i9jYiW8Z8/wK9q1Q7mvkydoY
         5EAQbQbVRTXwJSYA4yoxEPTvfZ1FxDFAtdkG4hBm/6IgT0phftts2/lxH0KGATN5GQWv
         ZjOQZuGfLzJHPrgOFTu3ThWCS3h3Uh/Jzd3UttPaWtFafFe6jdUyJp4XzQtOXDghdpcG
         ejQaIN71e6UssXSu7/G+m4sZfjxv27yUFzc78CP4F0dzDZzFNqnl8AnyACneRQJAnZY1
         ya4CUpd1k7AGLpWD9QzrpUOL8L6lGOCnE1wtRK2/n2bHluT6NAqV+li86KtfInrLPKfI
         OOxA==
X-Gm-Message-State: APjAAAW6Zn6dDQjzRLBww6nT/BUXig2/kE2G9l7dvOIaWyTpFrMwxwKW
        UZKZNehGN917v6+hqxPAyJfHbl/bQcQ=
X-Google-Smtp-Source: APXvYqwLteMzvKWOsIM9goB1+53wED3y5XbDL+2v9FTqUe5vqUwNvEd3LAUUzz6SohLi8keHHsvSgA==
X-Received: by 2002:adf:ed4e:: with SMTP id u14mr5034283wro.132.1573080044287;
        Wed, 06 Nov 2019 14:40:44 -0800 (PST)
Received: from [192.168.43.132] ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id d11sm188915wrf.80.2019.11.06.14.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 14:40:43 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1573077364.git.asml.silence@gmail.com>
 <ed30899d479bf40c6d386cac5d9401892836c3b5.1573077364.git.asml.silence@gmail.com>
 <3ba4d378-db8c-27ac-e7a1-ac13f361bd91@gmail.com>
 <49a76924-c788-1305-6aad-36018315e30e@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2 1/3] io_uring: allocate io_kiocb upfront
Message-ID: <8c66d8d6-7112-6c2b-f6fb-0daf54924965@gmail.com>
Date:   Thu, 7 Nov 2019 01:40:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <49a76924-c788-1305-6aad-36018315e30e@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TugVnWfplImftIshyEi3J8mdkwb1mJK6G"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TugVnWfplImftIshyEi3J8mdkwb1mJK6G
Content-Type: multipart/mixed; boundary="WF1XNY5qQYKmqc3dJcEdd2KarUICgHnEP";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Message-ID: <8c66d8d6-7112-6c2b-f6fb-0daf54924965@gmail.com>
Subject: Re: [PATCH v2 1/3] io_uring: allocate io_kiocb upfront
References: <cover.1573077364.git.asml.silence@gmail.com>
 <ed30899d479bf40c6d386cac5d9401892836c3b5.1573077364.git.asml.silence@gmail.com>
 <3ba4d378-db8c-27ac-e7a1-ac13f361bd91@gmail.com>
 <49a76924-c788-1305-6aad-36018315e30e@kernel.dk>
In-Reply-To: <49a76924-c788-1305-6aad-36018315e30e@kernel.dk>

--WF1XNY5qQYKmqc3dJcEdd2KarUICgHnEP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/11/2019 01:18, Jens Axboe wrote:
> On 11/6/19 3:05 PM, Pavel Begunkov wrote:
>> This one changes behaviour a bit. If we haven't been able to allocate
>> req before, it would post an completion event with -EAGAIN. Now it wil=
l
>> break imidiately without consuming sqe. So the user will see, that 0
>> sqes was submitted/consumed.
>>
>> Is that ok or we need to do something about it?
>=20
> At the very least we need to return -EAGAIN to the application. So
> something ala:
>=20
> return submitted ? submitted : ret;
>=20
> where ret is 0 or -EAGAIN if we failed to get a request.
>=20
This one is even better, as the old one didn't care about links

--=20
Pavel Begunkov


--WF1XNY5qQYKmqc3dJcEdd2KarUICgHnEP--

--TugVnWfplImftIshyEi3J8mdkwb1mJK6G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3DS+EACgkQWt5b1Glr
+6UjfBAAtwAl9z7cxFu7UqLJcnvdf3o2b+QJw+3b1pUeL0/rAVUDhM58Nj0Cqm/S
xvCAaAG/caJaegR5NIQVR11fxZ88kU2lwBviXp4A2CulWD8ugkR8apiDSRHKiG4c
PzAeReTlbZOxIH1Eiec7+Gwk66fs+sG3SHtwCI5k/ydUG/XQ/KtZhCAbbtsza+JF
yfzOR2dHwMMfRWgvuZ/HLq6yiBX19RfWafnO5JE+0g1zE2HLJA90g5d9+cmh5cHl
Ke0T4xgGoOWpSAAFWgl+6//qQPBqGpQWgYCjhJ0VdCk+d+MWl7n4wtp0jQUmFaEN
b6z285q7S776dYoHwWsDRzXD9c0oqzcUQd0qkEe84vmxb8PP2Ub70o7QPa2Qs0+w
AJKBkoFDhb487nLTsKPQxYrmkZO2FDtAJ9tZzmH9mx4YEpnkfnrH1utuka/Tls4/
lwDluaJfVFpX+jUMi2sDcGX9cL8SQNj3BUzG3vZaCp4EDSmtLB6o96tN2M+tBYZk
8lKeDmKEBGwWOIEOk72e+dfLscyGfeVp3DRihOqUpEWxIN4ebrkOpw4LgFNp6hYD
s21mpq+4aVDMIB6C7YzZz8jm3ealb3BtAeitNxqc5e8ZRA7I/kdSkA+WQU1fkI33
Aaq8hWUhBEBPE5Vu17ULxiqfTqrGl+++BkSoXdNnZHnLNQWD9rk=
=ymie
-----END PGP SIGNATURE-----

--TugVnWfplImftIshyEi3J8mdkwb1mJK6G--
