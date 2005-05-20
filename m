Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVETHfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVETHfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 03:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVETHfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 03:35:55 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:45257 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261372AbVETHfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 03:35:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
Date: Fri, 20 May 2005 17:36:00 +1000
User-Agent: KMail/1.8
Cc: chen Shang <shangcs@gmail.com>, linux-kernel@vger.kernel.org,
       rml@tech9.net
References: <855e4e4605051909561f47351@mail.gmail.com> <855e4e46050520001215be7cde@mail.gmail.com> <428D8FEE.8030303@yahoo.com.au>
In-Reply-To: <428D8FEE.8030303@yahoo.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4106935.X5X8mRaZpy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505201736.02664.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4106935.X5X8mRaZpy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 20 May 2005 17:21, Nick Piggin wrote:
> chen Shang wrote:
> >I minimized my patch and against to 2.6.12-rc4 this time, see below.
> >
> >The new schedstat fields are for the test propose only, so I removed
> >them completedly from patch. Theoritically, requeue_task() is always
> >cheaper than dequeue_task() followed by enqueue_task(). So, if 99% of
> >priority recalculation trigger requeue_task(), it will save.
> >
> >In addition, my load is to build the kernel, which took around 30
> >minutes with around 30% CPU usage on 2x2 processors (duel processors
> >with HT enable).
> >Here is the statistics:
> >
> >CPU0: priority_changed (669 times), priority_unchanged(335,138 times)
> >CPU1: priority_changed (784 times), priority_unchanged(342,419 times)
> >CPU2: priority_changed (782 times), priority_unchanged(283,494 times)
> >CPU3: priority_changed (872 times), priority_unchanged(365,865 times)
>
> OK that gives you a good grounds to look at the patch, but _performance_
> improvement is what is needed to get it included.

If you end up using requeue_task() in the fast path and it is hit frequentl=
y=20
with your code you'll need to modify requeue_task to be inline as well.=20
Currently it is hit only via sched_yield and once every 10 scheduler ticks=
=20
which is why it is not inline. The performance hit will be demonstrable if =
it=20
is hit in every schedule()

Cheers,
Con

--nextPart4106935.X5X8mRaZpy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCjZNiZUg7+tp6mRURApx7AKCR9sNLWMTIYPt4h3Q5Uxq1ewXL3gCfZ5z3
lrX6Et1wk8/+SX/tIYVdgAc=
=OPro
-----END PGP SIGNATURE-----

--nextPart4106935.X5X8mRaZpy--
