Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2D1C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652EA20643
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovHYf/GV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUUbE (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:31:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40933 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUUbE (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 15:31:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id 4so2732585wro.7
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 12:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=mfvbmkyB/qFO7d0t10IOhDHcE3lNtfGmaJqQE1PKgec=;
        b=ovHYf/GVJaZ9StKdxbpZFsBJqIXXs8f+Zc8JGSsczWx8kPtaEJ8EWVvFlG1bP/8PPR
         vmznjqxcVS6U4zIkUPoR+13gLud3elBm9DYiZugXCSXLoC3ky4TNUDzX5bnBnI96Cjlg
         GcwBbXRpoWBQ++TkhFxZIXitRGHVd9zpw83Do9sTwIaEXfSNeAGwDab79bPjdGmUHzY2
         Ag9p2FJPfiHaNUjI1hCfWqYMJWcAgUE3POW0spMsxj0eX4G5wxt8izRb2QeJGGQQq0HU
         PsDhBYLtKLpjKDn0CeE255HYKk1Pa23Pnd+BVQe0uUtXnX0f6Tec54e1yFT9MmNNH5MU
         IIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=mfvbmkyB/qFO7d0t10IOhDHcE3lNtfGmaJqQE1PKgec=;
        b=M9BeAHR+8WlQYdZ2LnncYBNumTKGuF13UE1jAw37bwk0FB9Rc4yhCqiaf7fj45JSoM
         CI62w4t4kBaCZILhdi3mNfiKJnjlh94M0uGZnDQP4BmCKEdfhE7IkEdSkXRtj/GxhDvt
         nykjOL5EdK4LL5lee+0x4TkMdNmdyNzjKXdN3V9je9PzG+9a3j0JwamrttUkhm0Zi5D+
         gkUCDuEiNyA2+WikH1KyqP8LQ0k+YtI5JdHM5W6ghkq4uGTt9/B5ecB/Yr8KUtLbJ1EF
         YfTBXvNGNXaIpBGko4ZkskFaUWYPtm003dyfciU+IQ92CMcCLaw7wROweSv5DmcyV2OF
         IaYA==
X-Gm-Message-State: APjAAAWk20HYlx3w9+Ig/7KWlVvjvq12wgYFuAt8Tg3E7zYZrJq5Jn+f
        rN+vYs9j7ZBBkB/R2g/uAv6pKa09
X-Google-Smtp-Source: APXvYqz32BKmZY7SXwlpMvt1rjaki0EZh5hEq0Yw4oU8a97wlptk+H6M65VodTB0zkFYS1MO8lXK6w==
X-Received: by 2002:adf:db41:: with SMTP id f1mr13035774wrj.351.1574368260574;
        Thu, 21 Nov 2019 12:31:00 -0800 (PST)
Received: from [192.168.43.101] ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id h15sm5092733wrb.44.2019.11.21.12.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 12:30:59 -0800 (PST)
Subject: Re: [PATCH] io_uring: rename __io_submit_sqe()
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <228a5ae5d63c61dd4f7349594012bfc7691028a7.1574360634.git.asml.silence@gmail.com>
 <715c1f8f-ac3a-21b2-df1b-9fef23036dbd@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <8b5be6c6-5160-24e5-ee41-a50690be93b6@gmail.com>
Date:   Thu, 21 Nov 2019 23:30:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <715c1f8f-ac3a-21b2-df1b-9fef23036dbd@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KP3LkuYhCDqFmbpEv5L6SGFzXFW6gyNdG"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KP3LkuYhCDqFmbpEv5L6SGFzXFW6gyNdG
Content-Type: multipart/mixed; boundary="3NgGWEf9li3dUixV4HJ9QQ73ykpffxpu0";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <8b5be6c6-5160-24e5-ee41-a50690be93b6@gmail.com>
Subject: Re: [PATCH] io_uring: rename __io_submit_sqe()
References: <228a5ae5d63c61dd4f7349594012bfc7691028a7.1574360634.git.asml.silence@gmail.com>
 <715c1f8f-ac3a-21b2-df1b-9fef23036dbd@kernel.dk>
In-Reply-To: <715c1f8f-ac3a-21b2-df1b-9fef23036dbd@kernel.dk>

--3NgGWEf9li3dUixV4HJ9QQ73ykpffxpu0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21/11/2019 23:08, Jens Axboe wrote:
> On 11/21/19 11:24 AM, Pavel Begunkov wrote:
>> __io_submit_sqe() is issuing requests, so call it as
>> such. Moreover, it ends by calling io_iopoll_req_issued().
>>
>> Rename it and make terminology clearer.
>=20
> I'm fine with this (and the other patch), but will push them
> to the back of the pile for once the merge window stuff is over.
>=20
Not a problem. Then, I'll send remaining patches later.

--=20
Pavel Begunkov


--3NgGWEf9li3dUixV4HJ9QQ73ykpffxpu0--

--KP3LkuYhCDqFmbpEv5L6SGFzXFW6gyNdG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3W8/YACgkQWt5b1Glr
+6W/chAAt+OdVWvIUz9WozVO6KqVo6wgJ96ZFy1SeD5jowsSlI13KzLWmD34ckU1
HckfR0hFOYHef1wPhX8GB4VM2WU+BvUGpJ0Uk4MjpE5PkYLSKp3ByEshW08Tt+wR
emMcMzT/zjZ+OqsrOADNcvosf9/ztI85G+vLiqnnDZTba3N8NQdpbWzCSL1iyofW
R6K0lA3WZjmt6nbYcO65BVRNXNzmjKQy4/3Lj767VKXlt+xkBCZG0xkrSaSfMpO4
E61rJh/IfBPkG4wYtsmdpE5+EwA5VCar5anl4D15NClYJnhsdVXrzJfiijKHqCRt
bdIYeKlv3MBiyOAj1QwKOSeck7ecZ79alN05e0MIUoOlsFdnwAt23y9oT+0orZN5
/T/tL7/g4YkIHEu8UgYZ6zU3Pf9f12CiivX7xxsPxo4E1S1tsgBHvQ0gqXt2L65A
Wf2kwEp10SbiovjeLHTlwHfk3HfGL5b5pH4kjeFvDl3ZIiDGHJDfb0wh1QW+nIfc
oHd0L7ypGYsTNedD9PYsG3wrLqDkSKTuUUKEY6fKNkuKpuUSS28XCXbJT24UcOeW
axMEcw33rDSSTIeIaETRFNzjmsJczuCykH5HL4XIXjTea/TMeZ+UrZ1Z9IzgFb95
oc9wFYUptBDlOc3xXKGfl4rJPUhXb72PYR7Ppb/a1TeJNqp7vLE=
=+Vzj
-----END PGP SIGNATURE-----

--KP3LkuYhCDqFmbpEv5L6SGFzXFW6gyNdG--
