Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BF2C5DF60
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C7B21A49
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuS5DBEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfKEXpO (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:45:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44239 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfKEXpO (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 18:45:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id f2so14660800wrs.11;
        Tue, 05 Nov 2019 15:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=gRPouBGtjSiZ16Jnj0l3vdZ5zLnhr+ynhqiLZJYnQg4=;
        b=XuS5DBEM5O8J9shhX1CwVfwiCctmTWmG8fNtemsXp65g99fuSq/uaRJjBgc9OvIQP8
         WUuE6bdGcAEUUc8eYAcbQaVoXlCGdPp93DFpcvx3whqjp+Uk/Tk79W2XmA2c0otemrG3
         554TBbTJ1gcFbqmWOtszNKrXJ03M1dOLgUNafdSanrprh8Q64pGBNxOUzQFhwvR4RZ+J
         S29N8HGOrrIttvMr0ZSJKpGeOkZqbhijubtXi2QovdXFmP++Nhs4X1ot6ChbevOM65/L
         w6gF1hPmQ7q6z4GjczrFKNhcluUIc5y1wGaZfcCOghAWxz+gnTmQkjcFXOTevOeu6VcK
         QjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=gRPouBGtjSiZ16Jnj0l3vdZ5zLnhr+ynhqiLZJYnQg4=;
        b=Fu8t8TeLMUtznRVmeRV/NGGMqR6OTSTMR+tBRiQ/9OJtOayMvVgmt/fwzz7z7c53ga
         XIeGAScxa6R5Gve6JzaoTe/CU8lWt0L95/fckr12n9tj3FvHo3lY8QNFK035iOodeYxo
         l3G6moiP3Do8TXujy0XmDu3y+hj53fV7fbhlIyceMB8grdwD/rstYsOqdt2PT2szHdEF
         ShlsN/ejpi7zehDdF8pM8blw2mJZdwGI8Tk/xiBIr1aG3j1GbtrII2eDYE6CbWRYkym9
         h/bduOJynQ46Q3cuZsA6saCMKkGZ3aEOenRksX4FuLj7diXPdqVr9zTGxPHlwTeOl2Xs
         PLmA==
X-Gm-Message-State: APjAAAXED5zImNuvoWsb2vcdWrE9g2CvpVc/kWSOEiIiaz5/yxAFU+sY
        7AzUfvoDn9he5WIEfbG2Sl452wUv
X-Google-Smtp-Source: APXvYqz++0gOdn7u7ydSpGM/upqcOs0eK7J98yGn8n4ggENvD7pJwS+0p1gXYIkFWj0njCpPDz/Sfg==
X-Received: by 2002:a5d:5742:: with SMTP id q2mr3090916wrw.311.1572997511123;
        Tue, 05 Nov 2019 15:45:11 -0800 (PST)
Received: from [192.168.43.132] ([109.126.129.81])
        by smtp.gmail.com with ESMTPSA id b3sm820071wmj.44.2019.11.05.15.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:45:10 -0800 (PST)
Subject: Re: [RFC 0/3] Inline sqe_submit
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1572993994.git.asml.silence@gmail.com>
 <a0393f05-dff2-6c34-4ba1-f6dba67955d2@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <1cc9dc92-3468-a780-e8ca-cb0f559a053f@gmail.com>
Date:   Wed, 6 Nov 2019 02:45:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a0393f05-dff2-6c34-4ba1-f6dba67955d2@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="A79lQxqbtwn6MjiLO7gCCC18miYcIfp8r"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A79lQxqbtwn6MjiLO7gCCC18miYcIfp8r
Content-Type: multipart/mixed; boundary="7UzG1V5qRNanlEUk2ZOweNz6lapf8GLn1";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Message-ID: <1cc9dc92-3468-a780-e8ca-cb0f559a053f@gmail.com>
Subject: Re: [RFC 0/3] Inline sqe_submit
References: <cover.1572993994.git.asml.silence@gmail.com>
 <a0393f05-dff2-6c34-4ba1-f6dba67955d2@kernel.dk>
In-Reply-To: <a0393f05-dff2-6c34-4ba1-f6dba67955d2@kernel.dk>

--7UzG1V5qRNanlEUk2ZOweNz6lapf8GLn1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06/11/2019 02:37, Jens Axboe wrote:
> On 11/5/19 4:04 PM, Pavel Begunkov wrote:
>> The proposal is to not pass struct sqe_submit as a separate entity,
>> but always use req->submit instead, so there will be less stuff to
>> care about. The reasoning begind is code simplification.
>>
>> Also, I've got steady +1% throughput improvement for nop tests.
>> Though, it's highly system-dependent, and I wouldn't count on it.
>>
>> P.S. I'll double check the patches, if the idea is accepted.
>=20
> I like the idea (a lot), makes the whole thing easier to follow as well=
=2E

Great, than I'll prepare the patches properly and resend it

> Just one comment on patch 3, that needs fixing.
>=20

--=20
Pavel Begunkov


--7UzG1V5qRNanlEUk2ZOweNz6lapf8GLn1--

--A79lQxqbtwn6MjiLO7gCCC18miYcIfp8r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3CCYAACgkQWt5b1Glr
+6UwJQ//fUhzRbauImwakRDbpin0Ex6cnk0XOjXw6+HFsfTLOfmIBRUyCPJ861LO
fQRbj/HCwVBcs1sliZatAm0cm51lSOHzRcfZ8VpacIDT9aRzvUgFBSzw9EqHecRi
h90MeUj0/eJ9H6doX1AMJIzeFR6P3parf01/AYTmYZZpvHjH/VCOcvhRm5IllhMY
VFuniW2uFvnmZidNXfUpb3ZXtNVVPBs7kvMBVWSKlFWcX7JBYpNwGflHfB7bwwfw
yM7k78zp6YT97LcBKuf+hX5VlAdngVOF811iv7ETO+4yGlUaIK6d7OWnvY4c4cvv
xS2WifVoA70kI0euCrjeenY9BauaXQv/3Ub+3IOfzy1ddRnvf4jD14fSISkFmGi6
fWdH2QEg6wa7gK+uxsFSSrrK37MkKq9jVMhLvVMPVjt+iSC/ZgIHVI0Qry3Djwl5
YjDlOB1YUfaJX6mBGjOzmkCZmsvvoNH/yto4vtBZ1hUNHWyozxblYzZyCpSYy0Bz
Bf3Mp3ZYLhNs+Mnzag85Smn9RNfOxoAQ5hR2nmSJQrVp/qvQxuF7jyF3H01rOpLF
epiSU03fSWmwfLva2nqlHR6FqDfDdMBriFfa/hUWM5i8OEMS6t+nsMlBOWRKKd5q
ZvAUrU6Ujck6EJGHwmFGddKOFtDXrSicZMKbJtVW+oeZva+9CNI=
=FCON
-----END PGP SIGNATURE-----

--A79lQxqbtwn6MjiLO7gCCC18miYcIfp8r--
