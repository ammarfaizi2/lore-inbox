Return-Path: <SRS0=5OhC=ZL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87C3C432C3
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7567522444
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 20:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Criq5VAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfKSUv7 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:51:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45265 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSUv7 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 15:51:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id z10so25537257wrs.12
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 12:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=4FbrBtvtgorbVcdRaQJtZu5aVbTUEDpgs51UhUPpew4=;
        b=Criq5VAZIVtH0+CylDs7RUwWTSzIhyrOr2XGOFptWYDpviQVDplBZ3U3mH+mV46PMv
         fRUYTasOGoRsowNVG5ZmKUL1gz5PXIMC88IsAHs/O9FRMmTVqm+fk5ds+QBiyZJJYvHV
         Zof56u2adsHf+Gux+LZ/vJzGvOqU2+Bs72WFATuOBu9CM25P5lLYvUvEgMUdCGMtraGB
         GZLT2WzbrXY8HjRKuaFgF6Ek1f61o9c5mMycCHAY/9NyJGuF28OZcucnjF4o2NNBsAs7
         D11snc1ctAEzioYDLix6R6nkqlbjfJcvx+H+wImYcMB9cfBvF2oZldSEPaXrAkiNNOMW
         5rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=4FbrBtvtgorbVcdRaQJtZu5aVbTUEDpgs51UhUPpew4=;
        b=TWKpPr+/oGxL9ZS6LCWfxhtgsSi+2l/rx83Fp4nRJBg7ufUL2buZS8NvCRs27JCDe6
         mY0It2XT8DyzccH908QBJKJ/SzuFRmd61232mB24GF/gD+YdFjXKUiPCDc72o/wpi8Hw
         a00+RyzHy20Wxf7qRZGc9OONayJQxBljppvJnOzu7OM9t0PuuBcqWyy189udfvuEMb8s
         RgzzDyfwA1CggywCFypdbW0m2/NFdZfFR1+l3NP28hC9dHweKSCG0AufdG3EAfZtMSPq
         SsAc2yd5Riz+TWiNPkmpszBZ9Vmox3vQsV4kUFAeSD3K6it7oF4gvLl7xo/jgOt23MCd
         iCaQ==
X-Gm-Message-State: APjAAAWmu7tdaCKHBBHRzWQs5a/WMlRRqXMl/MY0JJAXVSIHlHOwxjBR
        BXoc5s/nBMxcunGopI+RhkLft73U
X-Google-Smtp-Source: APXvYqyPIVhbKXvkyaHe3qdJWx1lCUFI5PCCBX6hrrU8X6FfYlQ8RgYK9/bQ8qK/KccTveElg/ZaNw==
X-Received: by 2002:a5d:4c4e:: with SMTP id n14mr27519653wrt.260.1574196715956;
        Tue, 19 Nov 2019 12:51:55 -0800 (PST)
Received: from [192.168.43.115] ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id y6sm28244581wrr.19.2019.11.19.12.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 12:51:55 -0800 (PST)
Subject: Re: [PATCH 7/8] io_uring: fix sequencing issues with linked timeouts
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <20191116015314.24276-1-axboe@kernel.dk>
 <20191116015314.24276-8-axboe@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <ccf48def-1a4a-9cb1-aa9a-467294487856@gmail.com>
Date:   Tue, 19 Nov 2019 23:51:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191116015314.24276-8-axboe@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j5BCWOu37USg5bmp0hS8QSlMwUTWgEjjN"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j5BCWOu37USg5bmp0hS8QSlMwUTWgEjjN
Content-Type: multipart/mixed; boundary="ygcMyst8zW4r6TVbws0FtkBA37Eox8xCp";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <ccf48def-1a4a-9cb1-aa9a-467294487856@gmail.com>
Subject: Re: [PATCH 7/8] io_uring: fix sequencing issues with linked timeouts
References: <20191116015314.24276-1-axboe@kernel.dk>
 <20191116015314.24276-8-axboe@kernel.dk>
In-Reply-To: <20191116015314.24276-8-axboe@kernel.dk>

--ygcMyst8zW4r6TVbws0FtkBA37Eox8xCp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16/11/2019 04:53, Jens Axboe wrote:
> We have an issue with timeout links that are deeper in the submit chain=
,
> because we only handle it upfront, not from later submissions. Move the=

> prep + issue of the timeout link to the async work prep handler, and do=

> it normally for non-async queue. If we validate and prepare the timeout=

> links upfront when we first see them, there's nothing stopping us from
> supporting any sort of nesting.
>=20
> Fixes: 2665abfd757f ("io_uring: add support for linked SQE timeouts")
> Reported-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---

> @@ -923,6 +942,7 @@ static void io_fail_links(struct io_kiocb *req)
>  			io_cqring_fill_event(link, -ECANCELED);
>  			__io_double_put_req(link);
>  		}
> +		kfree(sqe_to_free);
>  	}
> =20
>  	io_commit_cqring(ctx);
> @@ -2668,8 +2688,12 @@ static void io_wq_submit_work(struct io_wq_work =
**workptr)
> =20
>  	/* if a dependent link is ready, pass it back */
>  	if (!ret && nxt) {
> -		io_prep_async_work(nxt);
> +		struct io_kiocb *link;
> +
> +		io_prep_async_work(nxt, &link);
>  		*workptr =3D &nxt->work;
Are we safe here without synchronisation?
Probably io_link_timeout_fn() may miss the new value
(doing io-wq cancel).


> +		if (link)
> +			io_queue_linked_timeout(link);
>  	}
>  }
> =20

--=20
Pavel Begunkov


--ygcMyst8zW4r6TVbws0FtkBA37Eox8xCp--

--j5BCWOu37USg5bmp0hS8QSlMwUTWgEjjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3UVdsACgkQWt5b1Glr
+6UMYRAAplVrHGTJ4MqDqvC3Iz9mEZEe4LuwUI4gCOuFGFk5mRDUlG4NglPjlp36
NzU1F88jmbOWJZiBBWVW4Cu4M73/pCPj5n8gmQACnNJtJ4eJrcGuva0RFCFma39I
RuCt3CanIHk6F8niiwshP+dpArrYocTS71bX9MTZ7zbmQOLYNycyK1OyQ3odoZxu
7noEh/8/67E37xxOWLWWQpBuT8qGo3l3tsZG6xmYmcQ5xnRlf8Xc/ZeKZWSuuvme
75nhDQXyBJ0JdiHp5WIfbM7xHyiDrZBaVlm/kcKnjAEcjWIkgdJwHxI+W0HxYZ38
QrKbX9aTsMs6NIVGs8a4NC5yZ+QYCPIOPWHgHWh1jLi4xyvEUoNV+1LoNkT9Dlvz
6Q6YaFCo1hmgcWF8xtozPbdSWBu06Xboy+pbzNnaiK1B7gjvhsj3/LlN5VCQmkHY
dPmOUWuHY2+0n8Rqqwed0QXsWFnmp/i021mG4HcvTIjK0ke78FkjQ1B543y7RWUr
dJd0UlAyMMai7XC864zoY4kCsuBmmWclx5g1dMjqmjyPTfrQNrICbfKxGn80epf/
jbF1gTR9fpQA0xLP5Taw8FY+LRjU245qStdqLLG7FTElgyTMqQoSoqFFmtbaounh
OG5tHChpuE9fWtWrT2vqSjfj30LLvc1vYhyeu0Z8paOW8U48jNM=
=V2dm
-----END PGP SIGNATURE-----

--j5BCWOu37USg5bmp0hS8QSlMwUTWgEjjN--
