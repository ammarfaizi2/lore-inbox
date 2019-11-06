Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA09EC5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 18:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87ECA217F4
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 18:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sn9mMAd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfKFSpN (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:45:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40539 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfKFSpM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 13:45:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id f3so4668390wmc.5;
        Wed, 06 Nov 2019 10:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=pTtcjzE4gcfXY2oC9auH4Lg58vX66UWVnO46DhTh4V8=;
        b=sn9mMAd9WWyJY+KtfCKwzz1QvgeztH1G6Dn0MS0tEKAxim+QfZq6SdVMT9YBAzF4Yn
         ADEo+1osru+BiAjsqiBb4hvSezS5K6So2wlBlywjH6oWbh8VOfxIUc8GYfP4/5fWtCWb
         jJdOhwPOU8Eg6W2pyTJz3JvU8KUwhGJPDPJ2q5E/1AyrB8LMpZ7jrYTz11gJeQIe4XnX
         ckW/rtv82PCYKKDOYw6KKL7RDbY7Jwmnuv502h4An3wYd6c90oO8/FMrE53UH12mai8W
         7F9dfhQ/MAt0i3cWYi1GnV7lKML1VtrZxbDpiLkx300Js6udt/t4csSK6caSowGT0N9t
         GvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=pTtcjzE4gcfXY2oC9auH4Lg58vX66UWVnO46DhTh4V8=;
        b=KxFyMTG4M374q6ZMwkcQY1Et7Wp1aqPe0+zSuwO9/woUA74YqRTh81z+jxN7vqxGRs
         btBnQmchNThdq2SymnzVSeCUaz30VKfNAprPclp8wI0iXXy27vZHD8XeMVrwDGyz9k0X
         2RUeIYHuXsUi3Jc2Oyvl6oLi/d8VbZFAe73w8BGCQAN6TnwnDVdv0JymN2zHjpji6G7h
         YrK7JCNjfRZuAqCJxBRajO4GsWCsitr2QCjearinH4YfkeF2PtVg7gipoWiJR18vN41T
         aHIpY7iQ7RzKoJb33dzSgrtQ8exZ87ovXalLDY/BvfbuuJU7gYU3DZ4s5ScIb/vGHJz7
         1PZQ==
X-Gm-Message-State: APjAAAWdhQlstskxK1Od5Etp7XTZLUDejCFcCnU3mVNB0HY0Zh6tUx2q
        oL9ndO32hnbBjWJYztfgNRoUxr+D
X-Google-Smtp-Source: APXvYqwJE3IxbJZW6tMZ3PW1hLz9bVGJZ4CD4BT/V4SUO8isNL+2/2o2F8mlMiNXFlrUgt/UvF2aUQ==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr3832224wmj.91.1573065909454;
        Wed, 06 Nov 2019 10:45:09 -0800 (PST)
Received: from [192.168.43.132] ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id h8sm25989285wrc.73.2019.11.06.10.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 10:45:08 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <b10f96d7-ecc4-e835-555e-739f22d3e505@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] io_uring: fixup a few spots where link failure isn't
 flagged
Message-ID: <ee474592-8e97-eb11-0f95-84607bed033d@gmail.com>
Date:   Wed, 6 Nov 2019 21:44:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b10f96d7-ecc4-e835-555e-739f22d3e505@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D3zAmtLzjVYjDmYZSzsxkD8gQNYgFCyKB"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D3zAmtLzjVYjDmYZSzsxkD8gQNYgFCyKB
Content-Type: multipart/mixed; boundary="mS2t0GKemTQ7AVHG13nyzjc5nUf10xjRF";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <ee474592-8e97-eb11-0f95-84607bed033d@gmail.com>
Subject: Re: [PATCH] io_uring: fixup a few spots where link failure isn't
 flagged
References: <b10f96d7-ecc4-e835-555e-739f22d3e505@kernel.dk>
In-Reply-To: <b10f96d7-ecc4-e835-555e-739f22d3e505@kernel.dk>

--mS2t0GKemTQ7AVHG13nyzjc5nUf10xjRF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06/11/2019 06:32, Jens Axboe wrote:
> If a request fails, we need to ensure we set REQ_F_FAIL_LINK on it if
> REQ_F_LINK is set. Any failure in the chain should break the chain.
>=20
> We were missing a few spots where this should be done. It might be nice=

> to generalize this somewhat at some point, as long as we factor in the
> fact that failure looks different for each request type.
>=20

The completion path also starts to get complicated, especially
non-uniform handling of links there.

i.e. io_put_req() -> io_put_req_find_next() ->
	io_free_req() -> __io_free_req()
Plus, io_free_req_many(), which can be used only in some cases.

My compiler didn't even inlined it, so there are 4 CALLs.
Though, still in TODO list.


> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>=20
> --
>=20
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index bda27b52fd5b..4edc94aab17e 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -1672,6 +1672,8 @@ static int io_send_recvmsg(struct io_kiocb *req, =
const struct io_uring_sqe *sqe,
>  	}
> =20
>  	io_cqring_add_event(req->ctx, sqe->user_data, ret);
> +	if (ret < 0 && (req->flags & REQ_F_LINK))
> +		req->flags |=3D REQ_F_FAIL_LINK;
>  	io_put_req(req, nxt);
>  	return 0;
>  }
> @@ -1787,6 +1789,8 @@ static int io_poll_remove(struct io_kiocb *req, c=
onst struct io_uring_sqe *sqe)
>  	spin_unlock_irq(&ctx->completion_lock);
> =20
>  	io_cqring_add_event(req->ctx, sqe->user_data, ret);
> +	if (ret < 0 && (req->flags & REQ_F_LINK))
> +		req->flags |=3D REQ_F_FAIL_LINK;
>  	io_put_req(req, NULL);
>  	return 0;
>  }
> @@ -1994,6 +1998,8 @@ static enum hrtimer_restart io_timeout_fn(struct =
hrtimer *timer)
>  	spin_unlock_irqrestore(&ctx->completion_lock, flags);
> =20
>  	io_cqring_ev_posted(ctx);
> +	if (req->flags & REQ_F_LINK)
> +		req->flags |=3D REQ_F_FAIL_LINK;
>  	io_put_req(req, NULL);
>  	return HRTIMER_NORESTART;
>  }
> @@ -2035,6 +2041,8 @@ static int io_timeout_remove(struct io_kiocb *req=
,
>  		io_commit_cqring(ctx);
>  		spin_unlock_irq(&ctx->completion_lock);
>  		io_cqring_ev_posted(ctx);
> +		if (req->flags & REQ_F_LINK)
> +			req->flags |=3D REQ_F_FAIL_LINK;
>  		io_put_req(req, NULL);
>  		return 0;
>  	}
> @@ -2328,6 +2336,8 @@ static void io_wq_submit_work(struct io_wq_work *=
*workptr)
>  	io_put_req(req, NULL);
> =20
>  	if (ret) {
> +		if (req->flags & REQ_F_LINK)
> +			req->flags |=3D REQ_F_FAIL_LINK;
>  		io_cqring_add_event(ctx, sqe->user_data, ret);
>  		io_put_req(req, NULL);
>  	}
>=20

--=20
Pavel Begunkov


--mS2t0GKemTQ7AVHG13nyzjc5nUf10xjRF--

--D3zAmtLzjVYjDmYZSzsxkD8gQNYgFCyKB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3DFKYACgkQWt5b1Glr
+6VxfA//ZcBrUxeAwlt+DZeoJha48M6YVxNgUKAFmoVFI8Z71Er2xlpoNNze/agj
WL5hiLorfaMgyXB+KFJ8Le9IlBzI5qdsJjGCVmjDDFBdZPQNV3KiyriCQiokzy5j
3s94GrzBLLmiKyORSCq0StrF91X7EGUaMLDsJX1ec9AgQJG53zL5xwTZD1kNhFmJ
IN1DFysJk19pdKrbptUnCoKjE88IlTOIMv6j4F6/q13kLh6YLLr/4MRx/bbSeol0
/hKPkkoUCzsSw5eLciqQV7JVZZAoKZMcGACJ7Xp+j3YXyU6fKhORW0s+f33QV+kL
5ry9HWmWtk/+LTwTNon0yfuYectG4WOAOrJ3TQpPkjdsZ9gH0deRLaVeqd+k3sgG
V3kKEWsneSmwC98jm83H6+9LLBAiVl9twUE7vVdNRQcLsH/O73ME9EewjCktk+UE
/huvhLG1DrTqVBv774BIdGX+oAGHwnUlAAVhf5GfYKHPg6OF/wAjJJX8IJazN0md
y7S1mTbmsDSKO7ojgdWVZlqdhNu/HPP6nqIFhu3rLN866DNm1UL4zeMbBhI4HR9V
DLSX0Dz2l7LtTc4dm7ENoJnAIEoPHfpmV68eLrX3oUmKPFUqm9feaeZOuapV0yf8
00re0AGD+kFiGV3zSm5S1enMoTJscnuKtQk8pwXp7ohPmGYfqnU=
=/5Ib
-----END PGP SIGNATURE-----

--D3zAmtLzjVYjDmYZSzsxkD8gQNYgFCyKB--
