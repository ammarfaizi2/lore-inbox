Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVECV6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVECV6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 17:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVECV6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 17:58:52 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:65449 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261836AbVECV6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 17:58:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Haoqiang Zheng <haoqiang@gmail.com>
Subject: Re: question about contest benchmark
Date: Wed, 4 May 2005 07:58:56 +1000
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <d6e6e6dd05050311115d256213@mail.gmail.com>
In-Reply-To: <d6e6e6dd05050311115d256213@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1338770.D3XpWRR7IH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505040758.58752.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1338770.D3XpWRR7IH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 4 May 2005 04:11, Haoqiang Zheng wrote:
> I am wondering how we should interpret the CONTEST benchmark results.
> I tried CONTEST with process_load on 2.6.12-rc3 (single CPU, P4 2.8G,
> 1G RAM). The CPU usage of kernel compiling is 28.9%, the load consumes
> 70.1% and the ratio is 3.98.  Based on what Con says, the result is
> bad since the ratio is high. I did some tracing and found the
> background load (contest) runs at a dynamic priority of 115-120, which
> is often higher than the dynamic priority of the kernel compiling
> processes. This explains why the process_load consumes so much CPU.
>
>  My question is why is the result bad at all? One could certainly
> argue that contest processes shouldn't consume so much CPU time since
> they are considered to be background jobs. But why is kernel compiling
> considered foreground jobs? Why making kernel compiling faster is
> better? Actually, I am wondering if CONTEST is an appropriate
> benchmark to report system responsiveness at all?

I don't think in my readme do I say anywhere what is the ideal balance.=20
Process_load is a uniquely different load to the other loads which are=20
various combinations of cpu and i/o. It spawns processes that wake up, hand=
=20
their data off to another process and go to sleep. Thus the processes behav=
e=20
like interactive one with their frequent waiting, but share their effective=
=20
group cpu usage amongst all the process_child processes running so none of=
=20
them is actually seen as cpu bound. Furthermore there are massive numbers o=
f=20
context switches between them meaning there is a large in-kernel "system"=20
load that is done on behalf of the process_child ren. The purpose of the=20
process_load in contest is to ensure that an interactive design is not=20
DoS'able by processes behaving like this. Process_load spawns 4 times as ma=
ny=20
processes as the timed 'make' in contest so theoretically ideal cpu balance=
=20
between them should show process_load having 4x as much cpu as the make.=20
Because their cpu binding is so intermittent it's hard to balance them=20
perfectly. Anyway the balance in your output seems pretty good. When the=20
interactive design goes horribly wrong process_load consumes 100 times as=20
much cpu as the 'make'.

>
>  Any comments?
>
>  BTW, what benchmark do you guys use to test system responsiveness?

Note that interactivity is not responsiveness which some people try to meas=
ure=20
with contest, and there is still no interactivity benchmark. Responsiveness=
=20
is the ability of the system to continue performing tasks at a reasonable=20
pace under various system loads. Interactivity is having low scheduling=20
latency and jitter in those tasks where human interaction would notice the=
=20
latency and jitter - and what constitutes and interactive tasks has not bee=
n=20
quantified although we all know what they are when using the pc.

Cheers,
Con

--nextPart1338770.D3XpWRR7IH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCd/QiZUg7+tp6mRURAndZAJ9UzW8FfYLz6r2++JJBxgaMxwU9WgCeKj8x
XnK1RSYhe37CNUmm5Ty5aVY=
=Jnwc
-----END PGP SIGNATURE-----

--nextPart1338770.D3XpWRR7IH--
