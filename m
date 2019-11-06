Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7705EC5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393E72173E
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvRuIUJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfKFWKO (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:10:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36947 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKFWKO (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 17:10:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id t1so471639wrv.4;
        Wed, 06 Nov 2019 14:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=8qClmsBtFRsruHyukpzEgVK713WuMHxwPi7XiFLznyM=;
        b=nvRuIUJA7TkPAa9wxQzHKXWxVfLNTybPDX7vBGQa7u/T4CkNyAChlcPOdL6EErCUyi
         t4id5d2f44MNPE07F1+y2kw4qXyOiYXm7q7xH9s1fB16iIlq4qg+siBvYMNWMmQ1UCIA
         8e99QYZUTXz71rsgWVZzIuVHER6sCvo6kp4TaiNzhpZQnx515S+OCGhvxNSNS+bZ9Sfv
         K3gP9XERwZPQ3wAWvcEPF8nNXmYj0x01aiB+CdFP4Vp+w+NvttF4g5I3a46JSbuFwKa+
         O9NNweaKyJ/Xql7BxGe96NzsaCgOQBoZUsZecBH7eXTasiujxgpQDc9tMvvF+9dcOlzt
         Bb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=8qClmsBtFRsruHyukpzEgVK713WuMHxwPi7XiFLznyM=;
        b=Io0Z4XUgtw5dDHZmOzQkJRFmQIP8ScU8nxixoNsIrBM3ioY1Y8Y1wDRpe3f2riJdDh
         wM6TGFOj1xLj+BHbvwSkoEJvkRlikF3yvURVyrdSz9O+H/4aF7hjLucr03A4nbMQu5nc
         R1emqVoUqpPNIJlzOh+XmxCG18zD/QCrdQOBwYWekgKoGsYghPizDrO/vCId4FcNQrZ3
         OBO/e28g+6nd5/06kpPuTM84q6ghADfwduk3NJp6kTL4YVcCzkX7INtbdNKSYfdONBNy
         LnN4MuGeXMR92sa5CGTlv+9ddKAqR6zvk1BN571ZDldKD589e7d/SpXFhGPGdA4dlWJi
         GeNQ==
X-Gm-Message-State: APjAAAVeO/O4vT63O+qTtEW+dTiluJo98OylTd9lwf3/4YFh3iSl/+d4
        3UDt0Sfuds15EODjNZCfhB+TMtJy06w=
X-Google-Smtp-Source: APXvYqyBlLFPI3aPDzIHb9seMCqLXZYB9dxX8kvEQO41fvghvWhf9Ad5MiJvsAsOBssexl0vnS+/AA==
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr4763040wrx.349.1573078212056;
        Wed, 06 Nov 2019 14:10:12 -0800 (PST)
Received: from [192.168.43.132] ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id z8sm48368wrp.49.2019.11.06.14.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 14:10:11 -0800 (PST)
Subject: Re: [PATCH v2 0/3] Inline sqe_submit
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1573077364.git.asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFmKBOQBEAC76ZFxLAKpDw0bKQ8CEiYJRGn8MHTUhURL02/7n1t0HkKQx2K1fCXClbps
 bdwSHrhOWdW61pmfMbDYbTj6ZvGRvhoLWfGkzujB2wjNcbNTXIoOzJEGISHaPf6E2IQx1ik9
 6uqVkK1OMb7qRvKH0i7HYP4WJzYbEWVyLiAxUj611mC9tgd73oqZ2pLYzGTqF2j6a/obaqha
 +hXuWTvpDQXqcOZJXIW43atprH03G1tQs7VwR21Q1eq6Yvy2ESLdc38EqCszBfQRMmKy+cfp
 W3U9Mb1w0L680pXrONcnlDBCN7/sghGeMHjGKfNANjPc+0hzz3rApPxpoE7HC1uRiwC4et83
 CKnncH1l7zgeBT9Oa3qEiBlaa1ZCBqrA4dY+z5fWJYjMpwI1SNp37RtF8fKXbKQg+JuUjAa9
 Y6oXeyEvDHMyJYMcinl6xCqCBAXPHnHmawkMMgjr3BBRzODmMr+CPVvnYe7BFYfoajzqzq+h
 EyXSl3aBf0IDPTqSUrhbmjj5OEOYgRW5p+mdYtY1cXeK8copmd+fd/eTkghok5li58AojCba
 jRjp7zVOLOjDlpxxiKhuFmpV4yWNh5JJaTbwCRSd04sCcDNlJj+TehTr+o1QiORzc2t+N5iJ
 NbILft19Izdn8U39T5oWiynqa1qCLgbuFtnYx1HlUq/HvAm+kwARAQABtDFQYXZlbCBCZWd1
 bmtvdiAoc2lsZW5jZSkgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+iQJOBBMBCAA4FiEE+6Ju
 PTjTbx479o3OWt5b1Glr+6UFAlmKBOQCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQ
 Wt5b1Glr+6WxZA//QueaKHzgdnOikJ7NA/Vq8FmhRlwgtP0+E+w93kL+ZGLzS/cUCIjn2f4Q
 Mcutj2Neg0CcYPX3b2nJiKr5Vn0rjJ/suiaOa1h1KzyNTOmxnsqE5fmxOf6C6x+NKE18I5Jy
 xzLQoktbdDVA7JfB1itt6iWSNoOTVcvFyvfe5ggy6FSCcP+m1RlR58XxVLH+qlAvxxOeEr/e
 aQfUzrs7gqdSd9zQGEZo0jtuBiB7k98t9y0oC9Jz0PJdvaj1NZUgtXG9pEtww3LdeXP/TkFl
 HBSxVflzeoFaj4UAuy8+uve7ya/ECNCc8kk0VYaEjoVrzJcYdKP583iRhOLlZA6HEmn/+Gh9
 4orG67HNiJlbFiW3whxGizWsrtFNLsSP1YrEReYk9j1SoUHHzsu+ZtNfKuHIhK0sU07G1OPN
 2rDLlzUWR9Jc22INAkhVHOogOcc5ajMGhgWcBJMLCoi219HlX69LIDu3Y34uIg9QPZIC2jwr
 24W0kxmK6avJr7+n4o8m6sOJvhlumSp5TSNhRiKvAHB1I2JB8Q1yZCIPzx+w1ALxuoWiCdwV
 M/azguU42R17IuBzK0S3hPjXpEi2sK/k4pEPnHVUv9Cu09HCNnd6BRfFGjo8M9kZvw360gC1
 reeMdqGjwQ68o9x0R7NBRrtUOh48TDLXCANAg97wjPoy37dQE7e5Ag0EWYoE5AEQAMWS+aBV
 IJtCjwtfCOV98NamFpDEjBMrCAfLm7wZlmXy5I6o7nzzCxEw06P2rhzp1hIqkaab1kHySU7g
 dkpjmQ7Jjlrf6KdMP87mC/Hx4+zgVCkTQCKkIxNE76Ff3O9uTvkWCspSh9J0qPYyCaVta2D1
 Sq5HZ8WFcap71iVO1f2/FEHKJNz/YTSOS/W7dxJdXl2eoj3gYX2UZNfoaVv8OXKaWslZlgqN
 jSg9wsTv1K73AnQKt4fFhscN9YFxhtgD/SQuOldE5Ws4UlJoaFX/yCoJL3ky2kC0WFngzwRF
 Yo6u/KON/o28yyP+alYRMBrN0Dm60FuVSIFafSqXoJTIjSZ6olbEoT0u17Rag8BxnxryMrgR
 dkccq272MaSS0eOC9K2rtvxzddohRFPcy/8bkX+t2iukTDz75KSTKO+chce62Xxdg62dpkZX
 xK+HeDCZ7gRNZvAbDETr6XI63hPKi891GeZqvqQVYR8e+V2725w+H1iv3THiB1tx4L2bXZDI
 DtMKQ5D2RvCHNdPNcZeldEoJwKoA60yg6tuUquvsLvfCwtrmVI2rL2djYxRfGNmFMrUDN1Xq
 F3xozA91q3iZd9OYi9G+M/OA01husBdcIzj1hu0aL+MGg4Gqk6XwjoSxVd4YT41kTU7Kk+/I
 5/Nf+i88ULt6HanBYcY/+Daeo/XFABEBAAGJAjYEGAEIACAWIQT7om49ONNvHjv2jc5a3lvU
 aWv7pQUCWYoE5AIbDAAKCRBa3lvUaWv7pfmcEACKTRQ28b1y5ztKuLdLr79+T+LwZKHjX++P
 4wKjEOECCcB6KCv3hP+J2GCXDOPZvdg/ZYZafqP68Yy8AZqkfa4qPYHmIdpODtRzZSL48kM8
 LRzV8Rl7J3ItvzdBRxf4T/Zseu5U6ELiQdCUkPGsJcPIJkgPjO2ROG/ZtYa9DvnShNWPlp+R
 uPwPccEQPWO/NP4fJl2zwC6byjljZhW5kxYswGMLBwb5cDUZAisIukyAa8Xshdan6C2RZcNs
 rB3L7vsg/R8UCehxOH0C+NypG2GqjVejNZsc7bgV49EOVltS+GmGyY+moIzxsuLmT93rqyII
 5rSbbcTLe6KBYcs24XEoo49Zm9oDA3jYvNpeYD8rDcnNbuZh9kTgBwFN41JHOPv0W2FEEWqe
 JsCwQdcOQ56rtezdCJUYmRAt3BsfjN3Jn3N6rpodi4Dkdli8HylM5iq4ooeb5VkQ7UZxbCWt
 UVMKkOCdFhutRmYp0mbv2e87IK4erwNHQRkHUkzbsuym8RVpAZbLzLPIYK/J3RTErL6Z99N2
 m3J6pjwSJY/zNwuFPs9zGEnRO4g0BUbwGdbuvDzaq6/3OJLKohr5eLXNU3JkT+3HezydWm3W
 OPhauth7W0db74Qd49HXK0xe/aPrK+Cp+kU1HRactyNtF8jZQbhMCC8vMGukZtWaAwpjWiiH bA==
Message-ID: <ae78b0f8-88f5-7bc8-5f8c-d156be0098fc@gmail.com>
Date:   Thu, 7 Nov 2019 01:10:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cover.1573077364.git.asml.silence@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YbNOYq8HPruUZk6rRE5uiE9jcmgOuike6"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YbNOYq8HPruUZk6rRE5uiE9jcmgOuike6
Content-Type: multipart/mixed; boundary="NSlzYbVErR6pVFBZL5xbTLJl96MbMm6Zl";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Message-ID: <ae78b0f8-88f5-7bc8-5f8c-d156be0098fc@gmail.com>
Subject: Re: [PATCH v2 0/3] Inline sqe_submit
References: <cover.1573077364.git.asml.silence@gmail.com>
In-Reply-To: <cover.1573077364.git.asml.silence@gmail.com>

--NSlzYbVErR6pVFBZL5xbTLJl96MbMm6Zl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/11/2019 01:00, Pavel Begunkov wrote:
> The idea is to not pass struct sqe_submit as a separate entity,
> but always use req->submit instead, so there will be less stuff to
> care about.
>=20

Hope, I didn't missed anything here. In the meantime I'll run
tests and will let you know when it's done.


> Also, I've got steady +1% throughput improvement for nop tests.
> Though, it's highly system-dependent, and I wouldn't count on it.
>=20
> v2: fix use-after-free catched by Jens
>=20
>=20
> Pavel Begunkov (3):
>   io_uring: allocate io_kiocb upfront
>   io_uring: Use submit info inlined into req
>   io_uring: use inlined struct sqe_submit
>=20
>  fs/io_uring.c | 132 +++++++++++++++++++++++++-------------------------=

>  1 file changed, 65 insertions(+), 67 deletions(-)
>=20

--=20
Pavel Begunkov


--NSlzYbVErR6pVFBZL5xbTLJl96MbMm6Zl--

--YbNOYq8HPruUZk6rRE5uiE9jcmgOuike6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3DRLsACgkQWt5b1Glr
+6U3NA/9GfwXlaMtf3Vxkqmnfn7TQH5nA2LyjE7xqllnl8zkpAFI0Dfz+r3e3YE7
ujUd/huGGem3P76fx4VyVFA0Simrn/LG2rQv60zF42xajIQmerT38pmlFi/ruqNa
bUlcW0/Rtaf6DeldGH65TnLqVc9d88d6USjebpzT93DIqj4opubxBwpfms3KqFU/
qdewK7+L4lj/6p9RvrCd8aYep+yySiBD77SZU0rGmZtivpUR4lOYQulaVVW4zkpj
63iz+8Jj0HMN6yGAwrIvuyKO96Dv6Uw2EQPQUGw4vJbrN7687Rrkvr+HGMupavTE
UjTfciEvmyKYTwMkYcIOQ64EWqBOjqNmPFPFonahZ97KKr/hlqpV0Pv1+5fk9SAj
XOl2jHcFmOsfBDB2XL2dKOqVVrxHOpwUuXCobDgnEu2X6+t80ql9VucOZKYIayqT
CcfNaIt17f07524hI/cwd9UywuLGO2o6U4dDXs04zP37H4I/nZ+RxLdfjif3/h+q
sGKmpmiBkV+LykRZo0Pvh/x2CzCJkMN22UmvYmGHEUTcWDlhTM/bhnj5kLDCBG5X
/AAHnXTca48vhRc/mA6TLNByc+4wVulbptJSCIlSfRtEPz4aakEoV6BvEun88iSr
iz+EPOnBill4wVKANUCOBfgyayOWQ7TixjjCc77kG3K6VCQ8rkY=
=A/Bh
-----END PGP SIGNATURE-----

--YbNOYq8HPruUZk6rRE5uiE9jcmgOuike6--
