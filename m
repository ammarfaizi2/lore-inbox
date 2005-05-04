Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVEDMMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVEDMMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 08:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVEDMMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 08:12:37 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:24044 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261676AbVEDMM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 08:12:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Carlos Carvalho <carlos@fisica.ufpr.br>
Subject: Re: problem with nice values and cpu consumption in 2.6.11-5
Date: Wed, 4 May 2005 22:12:24 +1000
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
References: <17015.35256.12650.37887@fisica.ufpr.br>
In-Reply-To: <17015.35256.12650.37887@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1778492.AlAufnxKsl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505042212.26453.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1778492.AlAufnxKsl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 4 May 2005 00:24, Carlos Carvalho wrote:
> Look at this cpu usage in a two-processor machine:
>
>   893 user1   39  19  7212 5892  492 R 99.7  1.1   3694:29 mi41
>  1118 user2   25   0  155m  61m  624 R 50.0 12.3 857:54.18 b170-se.x
>  1186 user3   25   0  155m  62m  640 R 50.2 12.3 103:25.22 b170-se.x
>
> The job with nice 19 seems to be using 100% of cpu time while the
> other two nice 0 jobs share a single processor with 50% only. This is
> persistent, not a transient. I did a kill -STOP to the nice 19 job and
> a kill -CONT, and for a while it decreased the cpu usage but later
> returned to the above.
>
> This is with kernel 2.6.11-5 and top 3.2.5. What's the reason for this
> (apparent??) mis-behavior and how can I correct it? This is important
> because the machine is used for number-crunching and users get really
> upset when they don't get the expected share of cpu time...

We currently do not have "nice" aware SMP balancing. The balancing is purel=
y=20
designed with throughput in mind, and something about the behaviour of the=
=20
tasks you are running makes the scheduler design to balance them in this wa=
y.=20
The only way around this is to use affinities to bind tasks to cpus. The on=
ly=20
cross-cpu "nice" awareness we currently have is between hyperthread (SMT)=20
logical siblings, and not true physical cores.

I've been experimenting with code to make the SMP balancing "nice" aware bu=
t=20
the balancing design in the 2.6 scheduler changes every 3 minutes for some=
=20
apparent gain somewhere (it is getting impossible to track these) and there=
=20
is no baseline for me to work off, so I have, for the moment, given up on=20
that idea.

Cheers,
Con

--nextPart1778492.AlAufnxKsl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCeLwqZUg7+tp6mRURAjQ3AJ9Ad3oPIChfY7bONn71eioJyj1QgwCfXvaS
aZKRSqnMBogy1uLUUZ3y7RI=
=Tqod
-----END PGP SIGNATURE-----

--nextPart1778492.AlAufnxKsl--
