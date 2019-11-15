Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8600C432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 21:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EBD20733
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 21:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvNjKUgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfKOVWm (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:22:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38323 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfKOVWl (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 16:22:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so12436425wro.5;
        Fri, 15 Nov 2019 13:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=psFo+9vLpsFcKyLgLfgXUXNGysKSHMq979GpJNOxW1w=;
        b=fvNjKUgpWCiQ2ibPpe1+8vQ33kwIw7n1L3SztsQhj+DJLtlHlp7R2kv3vOIYX+x2z9
         sh+z/uZ32hIX9kdAiy9H2GtYS/ygGcS0z6H9ITlsfJ8YuUyaUt1zv25IGGzCFeaC2cMY
         3No5KE9mo2bsKLB6mFKRGanckNeQ6ZkVZ9k1PUrKmhz0wRi3xgkSqshLIDtmo+HIxjWn
         oe9AsPT1lM3SDAyiCgvrZrrABFfTVwsqkSOO9qGqSo9F1b/EV0fRe/Evwd4wh6IR0w7N
         UM7vteaZcTP0mDuq/K5JbUxjBhRkcuKaa/FVTK/JxKgyuTz72+oYmM1HJNNhg/G9TJX5
         PXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=psFo+9vLpsFcKyLgLfgXUXNGysKSHMq979GpJNOxW1w=;
        b=byzZl4E9MfqICokbieWQydVvqtKPL6SMLsNAga+BSLcSit1rBW51FszLslGfaD8qkC
         yJLxUO2ciJOwxQU9bPSfJooV5xZoalTFgfIHoL6gFUxMad18g/Jywf+dGR1cf14zsNoL
         MwGXNmt6bLMZxTBFBpP7569o0FmAltX7OkqZSfw3o3VN/n/eyV9CeuQbUIatE9meCoRs
         ENENtjAHw1/hgUONaS/0XKUQfbeILxUvNrDKIogdc7ofIqMjyob7QwEfOSE9NPE1uyN4
         CJyi6uQWJ15gU50D+pWNFIiP0m/qxIVwJw7SLUWpgw62Ew1b9W4SDZlzf2I+XbM+cpUM
         ZjLA==
X-Gm-Message-State: APjAAAUmbq94tpGW2yrU6JZaeS+zACVUH0Jr0ThlvjYqEc+6IhIWEVQ2
        C2DO8xbIXGbwmtDnp0bCLJU9qeR2
X-Google-Smtp-Source: APXvYqzhc9dGOLDIfXmNIMgLdnbGZ1ZdLv8u+z+dLztlYEC06ye+PR86P2DID4hin9+9UC4eQfjn4A==
X-Received: by 2002:adf:dc90:: with SMTP id r16mr18512980wrj.258.1573852957671;
        Fri, 15 Nov 2019 13:22:37 -0800 (PST)
Received: from [192.168.43.69] ([109.126.151.234])
        by smtp.gmail.com with ESMTPSA id d202sm10361509wmd.47.2019.11.15.13.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 13:22:37 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
 <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
 <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>
 <aabbed5f-db68-4a48-1596-28ac4110ce95@gmail.com>
 <2b35c1a0-69bf-1e50-8bda-2fff73bac8de@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
Message-ID: <06929659-a545-87c8-fbf4-edfc01c69520@gmail.com>
Date:   Sat, 16 Nov 2019 00:22:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <2b35c1a0-69bf-1e50-8bda-2fff73bac8de@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WfibiKLt60dhuLhOFWpbHyvOgAhwqgCau"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WfibiKLt60dhuLhOFWpbHyvOgAhwqgCau
Content-Type: multipart/mixed; boundary="RUwitEMDpz2e00Zl5zAJXGYKPiZY2zv9E";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
Message-ID: <06929659-a545-87c8-fbf4-edfc01c69520@gmail.com>
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
 <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
 <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>
 <aabbed5f-db68-4a48-1596-28ac4110ce95@gmail.com>
 <2b35c1a0-69bf-1e50-8bda-2fff73bac8de@kernel.dk>
In-Reply-To: <2b35c1a0-69bf-1e50-8bda-2fff73bac8de@kernel.dk>

--RUwitEMDpz2e00Zl5zAJXGYKPiZY2zv9E
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15/11/2019 22:34, Jens Axboe wrote:
> How about something like this? Should work (and be valid) to have any
> sequence of timeout links, as long as there's something in front of it.=

> Commit message has more details.

If you don't mind, I'll give a try rewriting this. A bit tight
on time, so hopefully by this Sunday.

In any case, there are enough of edge cases, I need to spend some
time to review and check it.

>=20
>=20
> commit 437fd0500d08f32444747b861c72cd58a4b833d5
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Nov 14 19:39:52 2019 -0700
>=20
>     io_uring: fix sequencing issues with linked timeouts
>    =20
>     We have an issue with timeout links that are deeper in the submit c=
hain,
>     because we only handle it upfront, not from later submissions. Move=
 the
>     prep + issue of the timeout link to the async work prep handler, an=
d do
>     it normally for non-async queue. If we validate and prepare the tim=
eout
>     links upfront when we first see them, there's nothing stopping us f=
rom
>     supporting any sort of nesting.
>    =20
>     Ensure that we handle the sequencing of linked timeouts correctly a=
s
>     well. The loop in io_req_link_next() isn't necessary, and it will n=
ever
>     do anything, because we can't have both REQ_F_LINK_TIMEOUT set and =
have
>     dependent links.

REQ1 -> LINKED_TIMEOUT -> REQ2 -> REQ3
Is this a valid case? Just to check that I got this "can't have both" rig=
ht.
If no, why so? I think there are a lot of use cases for this.


>    =20
>     Reported-by: Pavel Begunkov <asml.silence@gmail.com>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index a0204b48866f..47d61899b8ba 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -352,6 +352,7 @@ struct io_kiocb {
>  #define REQ_F_MUST_PUNT		4096	/* must be punted even for NONBLOCK */
>  #define REQ_F_INFLIGHT		8192	/* on inflight list */
>  #define REQ_F_COMP_LOCKED	16384	/* completion under lock */
> +#define REQ_F_FREE_SQE		32768
>  	u64			user_data;
>  	u32			result;
>  	u32			sequence;
> @@ -390,6 +391,8 @@ static void __io_free_req(struct io_kiocb *req);
>  static void io_put_req(struct io_kiocb *req);
>  static void io_double_put_req(struct io_kiocb *req);
>  static void __io_double_put_req(struct io_kiocb *req);
> +static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req);
> +static void io_queue_linked_timeout(struct io_kiocb *req);
> =20
>  static struct kmem_cache *req_cachep;
> =20
> @@ -524,7 +527,8 @@ static inline bool io_sqe_needs_user(const struct i=
o_uring_sqe *sqe)
>  		 opcode =3D=3D IORING_OP_WRITE_FIXED);
>  }
> =20
> -static inline bool io_prep_async_work(struct io_kiocb *req)
> +static inline bool io_prep_async_work(struct io_kiocb *req,
> +				      struct io_kiocb **link)
>  {
>  	bool do_hashed =3D false;
> =20
> @@ -553,13 +557,17 @@ static inline bool io_prep_async_work(struct io_k=
iocb *req)
>  			req->work.flags |=3D IO_WQ_WORK_NEEDS_USER;
>  	}
> =20
> +	*link =3D io_prep_linked_timeout(req);
>  	return do_hashed;
>  }
> =20
>  static inline void io_queue_async_work(struct io_kiocb *req)
>  {
> -	bool do_hashed =3D io_prep_async_work(req);
>  	struct io_ring_ctx *ctx =3D req->ctx;
> +	struct io_kiocb *link;
> +	bool do_hashed;
> +
> +	do_hashed =3D io_prep_async_work(req, &link);
> =20
>  	trace_io_uring_queue_async_work(ctx, do_hashed, req, &req->work,
>  					req->flags);
> @@ -569,6 +577,9 @@ static inline void io_queue_async_work(struct io_ki=
ocb *req)
>  		io_wq_enqueue_hashed(ctx->io_wq, &req->work,
>  					file_inode(req->file));
>  	}
> +
> +	if (link)
> +		io_queue_linked_timeout(link);
>  }
> =20
>  static void io_kill_timeout(struct io_kiocb *req)
> @@ -868,30 +879,26 @@ static void io_req_link_next(struct io_kiocb *req=
, struct io_kiocb **nxtptr)
>  	 * safe side.
>  	 */
>  	nxt =3D list_first_entry_or_null(&req->link_list, struct io_kiocb, li=
st);
> -	while (nxt) {
> +	if (nxt) {
>  		list_del_init(&nxt->list);
>  		if (!list_empty(&req->link_list)) {
>  			INIT_LIST_HEAD(&nxt->link_list);
>  			list_splice(&req->link_list, &nxt->link_list);
>  			nxt->flags |=3D REQ_F_LINK;
> +		} else if (req->flags & REQ_F_LINK_TIMEOUT) {
> +			wake_ev =3D io_link_cancel_timeout(nxt);
> +			nxt =3D NULL;
>  		}
> =20
>  		/*
>  		 * If we're in async work, we can continue processing the chain
>  		 * in this context instead of having to queue up new async work.
>  		 */
> -		if (req->flags & REQ_F_LINK_TIMEOUT) {
> -			wake_ev =3D io_link_cancel_timeout(nxt);
> -
> -			/* we dropped this link, get next */
> -			nxt =3D list_first_entry_or_null(&req->link_list,
> -							struct io_kiocb, list);
> -		} else if (nxtptr && io_wq_current_is_worker()) {
> -			*nxtptr =3D nxt;
> -			break;
> -		} else {
> -			io_queue_async_work(nxt);
> -			break;
> +		if (nxt) {
> +			if (nxtptr && io_wq_current_is_worker())
> +				*nxtptr =3D nxt;
> +			else
> +				io_queue_async_work(nxt);
>  		}
>  	}
> =20
> @@ -916,6 +923,9 @@ static void io_fail_links(struct io_kiocb *req)
> =20
>  		trace_io_uring_fail_link(req, link);
> =20
> +		if (req->flags & REQ_F_FREE_SQE)
> +			kfree(link->submit.sqe);
> +
>  		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
>  		    link->submit.sqe->opcode =3D=3D IORING_OP_LINK_TIMEOUT) {
>  			io_link_cancel_timeout(link);
> @@ -2651,8 +2661,12 @@ static void io_wq_submit_work(struct io_wq_work =
**workptr)
> =20
>  	/* if a dependent link is ready, pass it back */
>  	if (!ret && nxt) {
> -		io_prep_async_work(nxt);
> +		struct io_kiocb *link;
> +
> +		io_prep_async_work(nxt, &link);
>  		*workptr =3D &nxt->work;
> +		if (link)
> +			io_queue_linked_timeout(link);
>  	}
>  }
> =20
> @@ -2832,7 +2846,6 @@ static int io_validate_link_timeout(struct io_kio=
cb *req)
>  static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req)
>  {
>  	struct io_kiocb *nxt;
> -	int ret;
> =20
>  	if (!(req->flags & REQ_F_LINK))
>  		return NULL;
> @@ -2841,14 +2854,6 @@ static struct io_kiocb *io_prep_linked_timeout(s=
truct io_kiocb *req)
>  	if (!nxt || nxt->submit.sqe->opcode !=3D IORING_OP_LINK_TIMEOUT)
>  		return NULL;
> =20
> -	ret =3D io_validate_link_timeout(nxt);
> -	if (ret) {
> -		list_del_init(&nxt->list);
> -		io_cqring_add_event(nxt, ret);
> -		io_double_put_req(nxt);
> -		return ERR_PTR(-ECANCELED);
> -	}
> -
>  	if (nxt->submit.sqe->timeout_flags & IORING_TIMEOUT_ABS)
>  		nxt->timeout.data->mode =3D HRTIMER_MODE_ABS;
>  	else
> @@ -2862,16 +2867,9 @@ static struct io_kiocb *io_prep_linked_timeout(s=
truct io_kiocb *req)
> =20
>  static void __io_queue_sqe(struct io_kiocb *req)
>  {
> -	struct io_kiocb *nxt;
> +	struct io_kiocb *nxt =3D io_prep_linked_timeout(req);
>  	int ret;
> =20
> -	nxt =3D io_prep_linked_timeout(req);
> -	if (IS_ERR(nxt)) {
> -		ret =3D PTR_ERR(nxt);
> -		nxt =3D NULL;
> -		goto err;
> -	}
> -
>  	ret =3D __io_submit_sqe(req, NULL, true);
> =20
>  	/*
> @@ -2899,10 +2897,6 @@ static void __io_queue_sqe(struct io_kiocb *req)=

>  			 * submit reference when the iocb is actually submitted.
>  			 */
>  			io_queue_async_work(req);
> -
> -			if (nxt)
> -				io_queue_linked_timeout(nxt);
> -
>  			return;
>  		}
>  	}
> @@ -2947,6 +2941,10 @@ static void io_queue_link_head(struct io_kiocb *=
req, struct io_kiocb *shadow)
>  	int need_submit =3D false;
>  	struct io_ring_ctx *ctx =3D req->ctx;
> =20
> +	if (unlikely(req->flags & REQ_F_FAIL_LINK)) {
> +		ret =3D -ECANCELED;
> +		goto err;
> +	}
>  	if (!shadow) {
>  		io_queue_sqe(req);
>  		return;
> @@ -2961,9 +2959,11 @@ static void io_queue_link_head(struct io_kiocb *=
req, struct io_kiocb *shadow)
>  	ret =3D io_req_defer(req);
>  	if (ret) {
>  		if (ret !=3D -EIOCBQUEUED) {
> +err:
>  			io_cqring_add_event(req, ret);
>  			io_double_put_req(req);
> -			__io_free_req(shadow);
> +			if (shadow)
> +				__io_free_req(shadow);
>  			return;
>  		}
>  	} else {
> @@ -3020,6 +3020,14 @@ static void io_submit_sqe(struct io_kiocb *req, =
struct io_submit_state *state,
>  	if (*link) {
>  		struct io_kiocb *prev =3D *link;
> =20
> +		if (READ_ONCE(s->sqe->opcode) =3D=3D IORING_OP_LINK_TIMEOUT) {
> +			ret =3D io_validate_link_timeout(req);
> +			if (ret) {
> +				prev->flags |=3D REQ_F_FAIL_LINK;
> +				goto err_req;
> +			}
> +		}
> +
>  		sqe_copy =3D kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
>  		if (!sqe_copy) {
>  			ret =3D -EAGAIN;
>=20

--=20
Pavel Begunkov


--RUwitEMDpz2e00Zl5zAJXGYKPiZY2zv9E--

--WfibiKLt60dhuLhOFWpbHyvOgAhwqgCau
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3PFw8ACgkQWt5b1Glr
+6XsQg//VS9A0csxC0Js9Rosu9aMZtcFRqqbHvGIGa9H4rStvUc5ulneDsAyxj9Y
vWVXj7r6ExiF1AO/K7Mm7O8cStYdQIpEyMrSmWVbcibC8HQ4nzbqZ+v+DUuB/3vF
5PehwoR5a4zRSAIZNEm+0JWLzZQqX7lJ+JT7uv9QdocvqE/muCanVKwZXZaQUt2i
FllabDgmh+X8+7NUqduRKWLfHTNioswR4p6VO3ECl1yJFtYqDPaYhSPWvBvigr62
uNa1ni68bcQGlD25aA1uy5OF6fUTk+WiNOC0J3rr51GSQeG6rCVqrh4Jk1X13CKl
O1S6gRgATpEmhH6cRdZsoo04ZIMS+JzBtc9Zup8mQ2lCyTVWx4UabRttYyb94uBd
vhQsBwb/s7prat0O41eDTT3s6pxdBVaTFhcgwk3T9pRrTJXqrAEg6+jgS5bjmlrg
l4WNicjbI4yxf0GV8uTuK6G/bsNCNankggDmPq7hjEVuRieFhMzPQmg78B9NUW3I
6QeTqoWz4qbWpOio0Q1k12bE17B5KlL8QB3jWWVkS/UXRKjrmGW3aryx48zC80lq
Y+KYO7i7voSWjFnuVxxr0Vrkv+ETNXsIrhSOaQpc59wTGkCMLpGbiqmatH47lqVk
ojpWrZZrNBbujMNCAupR/NeP+diu8FHgOpw6dJlVqUYtkMK3Hrs=
=TRq0
-----END PGP SIGNATURE-----

--WfibiKLt60dhuLhOFWpbHyvOgAhwqgCau--
