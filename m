Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVGLV3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVGLV3B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVGLV25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:28:57 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:53123 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262444AbVGLV1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:27:12 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ondemand cpufreq ineffective in 2.6.12 ?
Date: Wed, 13 Jul 2005 07:26:50 +1000
User-Agent: KMail/1.8.1
Cc: Eric Piel <Eric.Piel@lifl.fr>, Ken Moffat <ken@kenmoffat.uklinux.net>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0507111702410.2222@ppg_penguin.kenmoffat.uklinux.net> <200507122152.26106.kernel@kolivas.org> <1121180244.2632.55.camel@mindpipe>
In-Reply-To: <1121180244.2632.55.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1242368.t6GhPaKmzn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507130726.52654.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1242368.t6GhPaKmzn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 13 Jul 2005 00:57, Lee Revell wrote:
> On Tue, 2005-07-12 at 21:52 +1000, Con Kolivas wrote:
> > > Well, it's just the default settings of the kernel which has changed.
> > > If you want the old behaviour, you can use (with your admin hat): echo
> > > 1 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice IMHO it
> > > seems quite fair, if you have a process nice'd to 10 it probably means
> > > you are not in a hurry.
> >
> > That's not necessarily true. Most people use 'nice' to have the cpu bou=
nd
> > task not affect their foreground applications, _not_ because they don't
> > care how long they take.
>
> But the scheduler should do this on its own!

That is a most unusual thing to tell the person who tuned the crap out of t=
he=20
2.6 scheduler so that it would do this.

> If people are having to=20
> renice kernel compiles to maintain decent interactive performance (and
> yes, I have to do the same thing sometimes) the scheduler is BROKEN,
> period.

Two tasks being the same nice level still implies they should receive the s=
ame=20
proportion of cpu. Anything else breaks the implied fairness of nice levels=
=2E=20
Whether you agree with this approach or not, it is expected. No, cpu=20
distribution is never _perfectly_ split 50/50 when nice levels are the same=
=20
but we try our best to do so while maintaining interactivity.=20

A more useful argument would be that you'd like to have two sets of nice=20
levels - one perhaps called latnice implying which tasks you want latency=20
critical but still want to have the same cpu and one called cpunice which=20
affects the amount of cpu but not the latency. Some would like complete=20
control over both nices while others want the scheduler to do everything fo=
r=20
them. Either way, you want a compile to be both latnice and cpunice. Our=20
current nice is both latnice and cpunice, and if nice levels are equal the=
=20
scheduler does a heck of a lot of its own latnice based on behaviour. It's=
=20
not perfect and nothing ever is.=20

Cheers,
Con

--nextPart1242368.t6GhPaKmzn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC1DWcZUg7+tp6mRURAp9bAJ9p71j+lmbbF2rtDEAYzXQhFthT+QCfYm/F
mQXmRYNPdHFadTZtbyQ0NUY=
=UOUM
-----END PGP SIGNATURE-----

--nextPart1242368.t6GhPaKmzn--
