Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263053AbVEIF5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbVEIF5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 01:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbVEIF5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 01:57:23 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:37521 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263053AbVEIF5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 01:57:13 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Haoqiang Zheng <haoqiang@gmail.com>
Subject: Re: [RFC PATCH] swap-sched: schedule with dynamic dependency detection (2.6.12-rc3)
Date: Mon, 9 May 2005 15:57:30 +1000
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <d6e6e6dd050507231174d99fb0@mail.gmail.com> <200505090926.59335.kernel@kolivas.org> <d6e6e6dd0505082056538221bd@mail.gmail.com>
In-Reply-To: <d6e6e6dd0505082056538221bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13455496.3xMmjm2pOQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505091557.32810.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13455496.3xMmjm2pOQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, 9 May 2005 13:56, Haoqiang Zheng wrote:
> On 5/8/05, Con Kolivas <kernel@kolivas.org> wrote:
> > Ok so how does it respond to process_load in contest?
>
> Based on my measurements, the "process_load" processes run at a
> dynamic priority of 115--122.  Which is also pretty much the dynamic
> priority range of the gcc processes.  At a certain point, the vanilla
> Linux scheduler may select either a process_load process or a gcc/make
> process to run, depending on which current runnable task has the
> highest dynamic priority.
>
> With swap-sched enabled, the virtual runnable tasks (tasks that are
> blocked because of waiting for another task) are kept in runqueue.
> For example, if a contest process_load task A with prio 115 blocks on
> waiting for another contest task B with prio 122, task A will remain
> in runqueue.  Task A may be selected by the vanilla scheduler to run
> since it has a high priority. On noticing that A is a virtual runnable
> task, swap-sched further select B to run in place of A. So in the end,
> B will be select to run. Without swap-sched, A will be removed from
> the runqueue once it's blocked, and task B can hardly get a chance to
> run since it has a low priority. That's why at
> http://swap-sched.sourceforge.net/node9.html, process_load has a much
> higher LCPU% when swap-sched is enabled.

While your swap-sched allows tasks waiting on other tasks to run better, it=
=20
also introduces a greater degree of unfairness in cpu resource sharing. By=
=20
allowing the dependent tasks to stay on the runqueue you increase=20
substantially their share of the resources they would otherwise have gotten=
=2E=20
The whole point of decrementing priority and runqueue expiration is to=20
maintain fairness and you're introducing another way to delay that system=20
from working. process_load is not the ideal task to test this unfairness on=
=20
this design but even that shows twice as much cpu usage with your own tests=
=2E=20
How do you propose to ensure we maintain fairness in this model ?

Cheers,
Con

--nextPart13455496.3xMmjm2pOQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCfvvMZUg7+tp6mRURAl1tAJ9yKp8dKXSONkRIXNIAD1eHCorEdACeMPQ1
pNZ0tmoIOj44MBrK5g9Ji38=
=5SCr
-----END PGP SIGNATURE-----

--nextPart13455496.3xMmjm2pOQ--
