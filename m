Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D45C432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25EC206E3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHhiWlTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfKMVbR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:31:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38540 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVbR (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:31:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so4095126wro.5
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=GjPVsn/MrMOtKyUx13OIrI9u0EEdG8/zjI1yWHps4iE=;
        b=CHhiWlTq2DqVEzVXouOXVlIg0fcnQWBXz8bcpCJnk/oGTyUAkLZ1nREbvZ3qF0ghxP
         7dZytWkmU/8G/GIaQbrLnSS0UHjA2HiEFIuf7EcxxmjI3nVIW7Zec/ujNDbvKC1Zftlj
         GH44HD0DAs296CAbVy6v+QRjNDqCuzSMlT4lHb0HYMIB2g8+slcYYP+TKzV9V/TbNSnm
         +Jdpq0TFtw0fU7JKDkcXUwESQLUv1+hIrkJ43DYnUdb8ckWo2QF7U1/yONmLYuW7OwJ4
         qmzeTBuBUiaB3J2/9at6dJyPEz0eXOBX4/F/cjpYdnUxjLWv+niG23flblqZdckMyz+o
         gkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=GjPVsn/MrMOtKyUx13OIrI9u0EEdG8/zjI1yWHps4iE=;
        b=WG8z4k29PZB/i21ABWH8PY/Jt8Z09o3juLtIp63OEQZz/AyZWgwGfKeCcaF9sW6Im5
         IG5E0e6XWL7K/QPvUKYmxtaADe4gOEJq4Sn3amw28HjZBuZkHpw27EGWeBZE0y3ZmZ2/
         po6MqhZjlqLMhiNVVyeRuSU/+AmSodrvdMevboaR+hc2OQWxPG/rjTlsl3miPUqFdgZd
         3UMju6DQYL7v1r1yHVgjkU3/Kpz/z+DcIFgypiQ72k/JRplzOwbZWt1JrvfP885LAvBK
         jm9ZyDVeeEKdkxzhCxOuKN7sot0W+LtTssAkktzzxv7qvhpdo1H3w4zPRDYCbgd179fG
         LAfA==
X-Gm-Message-State: APjAAAWifPuVDfGTybWpNFKNdJgaeve3RAxOv2tj3tAiIECLZOktEHx8
        sH6Apl64N7k7CVK1S+8RoTvNH6mJ
X-Google-Smtp-Source: APXvYqzpXaqxcIf7jjzIQK/NONbYKpqvjwAohTWwCtG/Prali+9MCFKODr34QzY9C4ajvlMR0iIgmA==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr4816925wrq.40.1573680674294;
        Wed, 13 Nov 2019 13:31:14 -0800 (PST)
Received: from [192.168.43.29] ([109.126.149.223])
        by smtp.gmail.com with ESMTPSA id j22sm5286504wrd.41.2019.11.13.13.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:31:13 -0800 (PST)
Subject: Re: [liburing PATCH] io_uring: invalid fd for file-less operations
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <b74f30f890ef054cff370f3f8fae68fd264e1c5e.1573680315.git.asml.silence@gmail.com>
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
Message-ID: <e1c72e14-804a-4787-a397-edd4ce048175@gmail.com>
Date:   Thu, 14 Nov 2019 00:31:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <b74f30f890ef054cff370f3f8fae68fd264e1c5e.1573680315.git.asml.silence@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="o5JGEpNDdpNnAZ7zBx874lUkjb7CoNmVY"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o5JGEpNDdpNnAZ7zBx874lUkjb7CoNmVY
Content-Type: multipart/mixed; boundary="XxtusH9tFe5lfeQvuKnRXPV6bSv8ElS2Y";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <e1c72e14-804a-4787-a397-edd4ce048175@gmail.com>
Subject: Re: [liburing PATCH] io_uring: invalid fd for file-less operations
References: <b74f30f890ef054cff370f3f8fae68fd264e1c5e.1573680315.git.asml.silence@gmail.com>
In-Reply-To: <b74f30f890ef054cff370f3f8fae68fd264e1c5e.1573680315.git.asml.silence@gmail.com>

--XxtusH9tFe5lfeQvuKnRXPV6bSv8ElS2Y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14/11/2019 00:27, Pavel Begunkov wrote:
> If an operation doesn't need a file, set fd to an invalid value.
> This would help to spot an unwanted fdget() in the kernel, and is
> conceptually more correct (though negotiable)
>=20

Either we can add a test with close(0) beforehand, but it
won't much help with new opcodes in the future.=20

--=20
Pavel Begunkov


--XxtusH9tFe5lfeQvuKnRXPV6bSv8ElS2Y--

--o5JGEpNDdpNnAZ7zBx874lUkjb7CoNmVY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3MdhUACgkQWt5b1Glr
+6VkKQ//bEvEPknehB3r50Zo269hAom4e+FdUHSwspzQr0s7LmhgRfw0Ai4lt4IO
D0E2kALH0lrzntEZSdyShQ0K+OEgtKXYceAuFUHUHqHUa+Fn6vTvKNOTOaxVYJGE
/TSOw+pyQgMaePy+BE/ebnupyVbNCcrz/urWX/c8SzMpxbfGL4tmcpoEPauG8z46
IsfNqZTEdU3Y0BunVRuI8JxF2/Nhy5dMp5sz+4lFamP2oFFAfp9DAqmq+Nlj6usH
BGhFAlAabJFQwmmS0KVymxJzmj5zA9p92XCiwjYFRt9Pthp2PzfToU5X4q5SRyc2
O7iOcxBzVsRNb1SaLtAymbV9r0vXHkXAL0VIwYt6DHekOIyutKhLg0JEp3Dvhtui
juppPU4m80jPgoWHpRUgrQwznBPjS+BIwKr6cXoKzAhH5IQHie/KxpECwdennDS+
SletV1AuZeNv+1uQyZQYAdjF6KNXWRR91F2j3jv+m44B/E/9glZHIXKmHaTrHtYg
Jo1IwMZ7EsaCwTMI7sT1QCmta3ZP7WFwPxMMKT/WHXHfIXZLCBbUZCBwI+fh1Tqk
3LtJFporCszE5a3uRMRG0b89vUSCevf64nHmahtqTGAx7/lczpLGCS7PcXtZjIos
syU8FvKm9Cx/d5W45f3iIPzjzETRxFl1HSwOBOQsZ1f8mrjLKsY=
=6FZW
-----END PGP SIGNATURE-----

--o5JGEpNDdpNnAZ7zBx874lUkjb7CoNmVY--
