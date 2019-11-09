Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A123FC43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 10:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0FB21848
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 10:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOIogcti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfKIKdU (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 05:33:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35626 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfKIKdU (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 05:33:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id 8so8685729wmo.0
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 02:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=aPFEe3DBZv+jrGrj3C0YIThvevMLT1enLwP8xXSLL9c=;
        b=vOIogcti2oLZQYl4VDJq8oxD7d39qqzguUwMczR8qAIaI3QD2VPVyZ2vOd6r5XIG2T
         rIP9cIQmIci3m1VOk5aVIXKrnzEPj/rZhP4I8hsUNWAEHe/zs8Wq6nLIJ1TyPrCDI+Z+
         qMv3O2Y73lphS7yGXWfnfi5AvBGCB6//qZgoAdHveo/S06VQuIQ691XqbN49XnRBrOm2
         wQ8vFexeZDjcHure+BmVD11+HVVxXze1uXb2CJewEW/kRWE2FHIaTZVr6/AmzfwD8Z5L
         vR+5rTyekO4q0TR6xOKKRLiON/dob18QyuqUFTVwGMNmRrf9RBTOVcYOaWdOpulpao5w
         IipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=aPFEe3DBZv+jrGrj3C0YIThvevMLT1enLwP8xXSLL9c=;
        b=CqsRzqkSi4ZQDAgFRNDg1tOAj3JcZbiNm3aTAcLQyiKM8qhkke5zA6OmIrjdDY/rvS
         f2JytYRREicvh0XerZppgJtUrSqZ+bWCUK6EGFLs4PRWx/TgHCc5HXy93fzunhWlhR/3
         9JDSu5XqdG9JPIdBSJ63llROk/Ix6eUAlzmUSZussK1q0N3u7bLf+pGtlc5dZxgJVmxH
         B1kmHCXgrzRUgMo+gKomkIRB18RPJvpB7fdjsyg/IkIlSX6fm2V+V3oprNhT1UC99Zqk
         8hhbVReeD7vniKx2NXl7sK3F/mIuNWnNHwr4f4Py8lF8Ad9ulCONTdVLMJD4Ob4KQFMn
         8YWg==
X-Gm-Message-State: APjAAAXNfCP6sgybXHu6fPb/o32BkWG8ppiIixzrPgUThNWXAp3zdKjn
        d66RJBrC+UuIGJykpjTQDCW09oNG
X-Google-Smtp-Source: APXvYqxWXPipXZobGhZd7Ur84stgcfFxn45Oh510Zd4R/f4CZiqcqKR4JqgjH7F+oaeTlxG4RaB+iA==
X-Received: by 2002:a1c:b1c3:: with SMTP id a186mr12571367wmf.10.1573295597233;
        Sat, 09 Nov 2019 02:33:17 -0800 (PST)
Received: from [192.168.43.163] ([109.126.130.90])
        by smtp.gmail.com with ESMTPSA id f13sm8333349wrq.96.2019.11.09.02.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2019 02:33:16 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
 <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
 <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
 <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
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
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
Message-ID: <e3c1f9a8-bd6a-ea08-1450-0d7a55a843a6@gmail.com>
Date:   Sat, 9 Nov 2019 13:33:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aeFirukvpkhRYEEDzug9jJL2dGgqWDThQ"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aeFirukvpkhRYEEDzug9jJL2dGgqWDThQ
Content-Type: multipart/mixed; boundary="KsMblITMaM9uQwLo1wVNFzBrI9HEoLsCX";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <e3c1f9a8-bd6a-ea08-1450-0d7a55a843a6@gmail.com>
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
 <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
 <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
 <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>
In-Reply-To: <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>

--KsMblITMaM9uQwLo1wVNFzBrI9HEoLsCX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/11/2019 17:05, Jens Axboe wrote:
> On 11/8/19 2:56 AM, Pavel Begunkov wrote:
>> On 08/11/2019 03:19, Jens Axboe wrote:
>>> On 11/7/19 4:21 PM, Jens Axboe wrote:
>>>> I'd like some feedback on this one. Even tith the overflow backpress=
ure
>>>> patch, we still have a potentially large gap where applications can
>>>> submit IO before we get any dropped events in the CQ ring. This is
>>>> especially true if the execution time of those requests are long
>>>> (unbounded).
>>>>
>>>> This adds IORING_SETUP_INFLIGHT, which if set, will return -EBUSY if=
 we
>>>> have more IO pending than we can feasibly support. This is normally =
the
>>>> CQ ring size, but of IORING_SETUP_CQ_NODROP is enabled, then it's tw=
ice
>>>> the CQ ring size.
>>>>
>>>> This helps manage the pending queue size instead of letting it grow
>>>> indefinitely.
>>>>
>>>> Note that we could potentially just make this the default behavior -=

>>>> applications need to handle -EAGAIN returns already, in case we run =
out
>>>> of memory, and if we change this to return -EAGAIN as well, then it
>>>> doesn't introduce any new failure cases. I'm tempted to do that...
>>>>
>>>> Anyway, comments solicited!
>> What's wrong with giving away overflow handling to the userspace? It
>> knows its inflight count, and it shouldn't be a problem to allocate
>> large enough rings. The same goes for the backpressure patch. Do you
>> have a particular requirement/user for this?
>=20
> There are basically two things at play here:
>=20
> - The backpressure patch helps with users that can't easily size the
>   ring. This could be library use cases, or just normal use cases that
>   don't necessarily know how big the ring needs to be. Hence they need
>   to size for the worst case, which is wasteful.
>=20
> - For this case, it's different. I just want to avoid having the
>   application having potential tons of requests in flight. Before the
>   backpressure patch, if you had more than the CQ ring size inflight,
>   you'd get dropped events. Once you get dropped events, it's game over=
,
>   the application has totally lost track. Hence I think it's safe to
>   unconditionally return -EBUSY if we exceed that limit.
>=20
> The first one helps use cases that couldn't really io_uring before, the=

> latter helps protect against use cases that would use a lot of memory.
> If the request for the latter use case takes a long time to run, the
> problem is even worse.

I see, thanks. I like the point with having an upper-bound for inflight
memory. Seems, the patch doesn't keep it strict and we can get more
than specified. Is that so?

As an RFC, we could think about using static request pool, e.g.=20
with sbitmap as in blk-mq. Would also be able to get rid of some
refcounting. However, struggle to estimate performance difference.

>=20
>> Awhile something could be done {efficiently,securely,etc} in the
>> userspace, I would prefer to keep the kernel part simpler.
>=20
> For this particular patch, the majority of issues will just read the sq=

> head and mask, which we will just now anyway. The extra cost is
> basically a branch and cmp instruction. There's no way you can do that
> in userspace that efficiently, and it helps protect the kernel.
>=20
I'm more concern about complexity, and bugs as consequences. The second
concern is edge cases and an absence of formalised guarantees for that.

For example, it could fetch and submit only half of a link because of
failed io_get_req(). Shouldn't it be kind of atomic? From the
userspace perspective I'd prefer so.


> I'm not a fan of adding stuff we don't need either, but I do believe we=

> need this one.
>=20

--=20
Pavel Begunkov


--KsMblITMaM9uQwLo1wVNFzBrI9HEoLsCX--

--aeFirukvpkhRYEEDzug9jJL2dGgqWDThQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3GldwACgkQWt5b1Glr
+6XekhAAi5qfUsQ86MTXpGU+KmlkWTj+vWCHkM+jiV+kqn7CfYyuXOM3hoWD/byX
M+P4KCSTV5Wjho/eHT32TcxIV49Iw+VCZ042YmBbP95YglL55RPGd5scouY3RmjJ
rUEYK86NQGq9Trr7mfdv41liegn63tUTMwJbz9RR+1sExOvH7mjoKSYsA5PPq1uI
2AFJyTa1IU9+jibmCL+RvBqNGsfQsQ/BLs+Hqq4WzEzEgDnncofqnhn2ntyViZ6h
0N+oxQSq7SBdx1FxTatZVNMrd9xN67lj7TDT9yuc99ecouYTinEaFx4M8kcfOwx9
Qf7my8WgTdacoZNGb12mYPLbMTvH8Uolur1Lu2GIc5uowDJnu1Rvx0SHuDuCqQoV
+9DSAmS1fcXiBAnLlsdfM7UZ13ohmclaxC3LNBYncny4dzOvvtlZ4WZjb2scBdJp
yOB16ZUyHUA0ThuQD1T84J0YUkbi0h3mjUpz9Wn3A7gLFzcbGGEeTG3Gyp1GQFBD
MWHH25h4ivq5CXKUK+pwF4jx+Vh0guDSJP8DN2Gd4zYKheBTC0AdMePKr86YMuKX
KpMdgMGmHqqcs8LnEe2XfAyUlylPzNfjMmbKoNJLi+MM3NFlPTfYcnElR8BZ8LRi
0pd73UaNGUy4f0GGijM5cdbCNlgYfEM7WwlGcfxHZy0BRCcProc=
=TFl6
-----END PGP SIGNATURE-----

--aeFirukvpkhRYEEDzug9jJL2dGgqWDThQ--
