Return-Path: <SRS0=S5qu=ZQ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92E6C432C0
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 08:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50C820706
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 08:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0SL08am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKXI5c (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 24 Nov 2019 03:57:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36997 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKXI5c (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 24 Nov 2019 03:57:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so11022643wmf.2
        for <io-uring@vger.kernel.org>; Sun, 24 Nov 2019 00:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=t+3j9RdCxcgyYomcA4EHYdiKD9qEYwr6H2u5S1YhmPg=;
        b=Q0SL08amcPLpjrFY21OIO5D8v6bQbvA/SekLYWezn6UoLHeIFDVNW9UnfDAx7bC5Gh
         CaQGMohg5aQIoK/buMCpondhKiS3+h1mXLxoU1dWa45cYhkRtHG1YXExLFcu5DCYBZgN
         MMwHUbuls7DVjIglccP4G7oZg4Kk1ZoJhev/GkkceJKvX7k8Wo37NVKavd5xH0qAJv2V
         gaCzkCAZPiHqv29Ccb6codPK2zAnKHZdtTN3FN+olBWHE9Rr9uvdSdGiWWOZSmtIszw8
         1bongbbewAmNwN5DaSTuDaDUnrVgFpuUHP8W+N7/pxJz+H9jY/1G2xKtnwkm4G7+g9om
         6WLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=t+3j9RdCxcgyYomcA4EHYdiKD9qEYwr6H2u5S1YhmPg=;
        b=eEpYAelT2LQnznzkobZLDOM7aisE2rSIpDi6PgwaPdyqajIWllR5w+z55uvIqEBIoT
         G2Jc2TRpSD4SSSuGAz/XVyWxODaCJbdmrMOWerrjaBITy0e1FlPzL3vbrrXmJSS80tMI
         fGT/XxgyDdKWF24PHxwsv351SxFfBloMQniDVIdOSu6YMt8ZM8Hj1qUWL9lxoG3HEQB3
         ClfXRYboC6mnu/NxFFyTXGeeAypPiDxRMyQcdUoRdcg3Qx0sbbkpRzaYUd9m6mfvgBBm
         do74JNszJOWreKsKKAngd9qcZuC6fRkeM24VcTVPnDdaBBDYf0QQNiA/IMUGm3frgq0q
         TuYg==
X-Gm-Message-State: APjAAAV2CqwzXTSXbnsVeIzydlnWwgKAG7nUXKVwQkgMqZc67Myd5q8/
        K3Xrrgv2yO5mtjuQMk0+ED6WxudI
X-Google-Smtp-Source: APXvYqw3OuQYA24gQJx43JV6nB0kyyEkXk7zYjobWaHZmsG/X+uYrNdqAmY4T3TiERq65p7gmOrk4Q==
X-Received: by 2002:a05:600c:2389:: with SMTP id m9mr24483178wma.65.1574585848813;
        Sun, 24 Nov 2019 00:57:28 -0800 (PST)
Received: from [192.168.43.199] ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id h15sm5496473wrb.44.2019.11.24.00.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2019 00:57:28 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC 0/2] fix in-kernel segfault
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <cover.1574549055.git.asml.silence@gmail.com>
 <fb952a30-3e42-fa81-f0ea-200b7acbf6a9@kernel.dk>
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
Message-ID: <cb4c9440-a974-a8df-5eb1-5aa37ae2936c@gmail.com>
Date:   Sun, 24 Nov 2019 11:57:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <fb952a30-3e42-fa81-f0ea-200b7acbf6a9@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fNMWh0AoYOg5A8RHMDjN081S7iUGtTaYN"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fNMWh0AoYOg5A8RHMDjN081S7iUGtTaYN
Content-Type: multipart/mixed; boundary="3R2fJnldcb7q4USmH4M0ESRF16a8KCavb";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <cb4c9440-a974-a8df-5eb1-5aa37ae2936c@gmail.com>
Subject: Re: [RFC 0/2] fix in-kernel segfault
References: <cover.1574549055.git.asml.silence@gmail.com>
 <fb952a30-3e42-fa81-f0ea-200b7acbf6a9@kernel.dk>
In-Reply-To: <fb952a30-3e42-fa81-f0ea-200b7acbf6a9@kernel.dk>

--3R2fJnldcb7q4USmH4M0ESRF16a8KCavb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24/11/2019 02:08, Jens Axboe wrote:
> On 11/23/19 3:49 PM, Pavel Begunkov wrote:
>> There is a bug hunging my system when run fixed-link with /dev/urandom=

>> instead of /dev/zero (see patch 1/2).
>>
>> As for me, the easiest way to fix is to grab mm and use userspace
>> address for this specific case (as it's done in patches). The other
>> way is to kmap/vmap, but the first should be short-lived and the
>> second needs mm anyway.
>>
>> Ideas how to do it better way? Suggestions and corrections are welcome=
=2E
>=20
> OK, took a quick look. kmap() etc doesn't need context, but the copy

Thanks! What copy do you mean? The first and pretty short version was
with kmap.
e.g. while(count) { read(kmap()); ...; knumap(); }

I'll send this shortly. What I don't like here, is that it passes
kmapped virtual address as "void __user *". Is that ok?
=09

> does. How about just ensuring we grab the mm for cases that don't have
> ->read_iter() or ->write_iter() and then just map and copy in that
> loop that handles that exact case? I think that's cleaner than what
> you have.
>=20

--=20
Pavel Begunkov




--3R2fJnldcb7q4USmH4M0ESRF16a8KCavb--

--fNMWh0AoYOg5A8RHMDjN081S7iUGtTaYN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3aRekACgkQWt5b1Glr
+6Xg1A/9EiwzaBm6iyBpD6zYWmO1kNdzCBcCeSOHHRaoga8t6j89FSHnKx5ZNjYT
W1i6O1IQWTtViHyWjof/3sQ/VhX/Su6qyXIU6Dh1Q3ccFdJpx7UN5NqjAx3z1asC
svDCyMJP/OuQq4U9MLqKz6MwPz2f1sXmFTPuRtFNVZzOhr4KeHCYxbsh4Ae5OgA3
fjZ9RumKVj6HTrrN4Ixtf8yLF4uSeRU2wJk2caI9OiUtZ+BsVZn8Pl6Jwdf9p9VM
NgEiud/UoxxFLX3xVcPbsuLHxbiRJJuE4+s+HtSOVW211ABehTQyET/zn7CClby5
Oi0WdqADtFrUzX7VW6BoNYIrgB7ej+Mhl/BsSaG+ytR1NooyqQvmjDaq4FJjX6XW
Y8GvUZc6TiVUm5djf5Gt2Mvuz4ZDExQTd5eWtW+d7lkQH5K2vR5UXnb5LenVe+GL
hfC1m+Q8FqLtmB+0Al+jWuCK9qXIJi/G8TCQDVVN/cz4fHgZq3wXthfMO+mVgKDZ
xudmqO5G1eS8a0vu+itxjpWAJfNKuLqtmnbPGqzhbltgSMH8sGxOSxcoeRdnZTiB
y/BM5OG/cT4cHWeVf6nOBc91CHYqf5f2jP0IaICrxstggDyxSg5/Ij2JxPk35G0a
1TIlRYqMq8ZMbJe0VnE567/Y5AG62byDStqsZvY2+IUeeAwUoNU=
=YqfY
-----END PGP SIGNATURE-----

--fNMWh0AoYOg5A8RHMDjN081S7iUGtTaYN--
