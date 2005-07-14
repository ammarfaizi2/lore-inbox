Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVGNAtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVGNAtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVGNArR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:47:17 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:27849 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262861AbVGNAqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:46:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
Date: Thu, 14 Jul 2005 10:46:25 +1000
User-Agent: KMail/1.8.1
Cc: Bill Davidsen <davidsen@tmr.com>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200507122110.43967.kernel@kolivas.org> <200507141021.55020.kernel@kolivas.org> <Pine.LNX.4.62.0507131726390.11024@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0507131726390.11024@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2292893.RydbJ4xdA9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507141046.27788.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2292893.RydbJ4xdA9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 14 Jul 2005 10:31, David Lang wrote:
> On Thu, 14 Jul 2005, Con Kolivas wrote:
> > On Thu, 14 Jul 2005 03:54, Bill Davidsen wrote:
> >> Con Kolivas wrote:
> >>> On Tue, 12 Jul 2005 21:57, David Lang wrote:
> >>>> for audio and video this would seem to be a fairly simple scaleing
> >>>> factor (or just doing a fixed amount of work rather then a fixed
> >>>> percentage of the CPU worth of work), however for X it is probably
> >>>> much more complicated (is the X load really linearly random in how
> >>>> much work it does, or is it weighted towards small amounts with
> >>>> occasional large amounts hitting? I would guess that at least beyond=
 a
> >>>> certin point the liklyhood of that much work being needed would be
> >>>> lower)
> >>>
> >>> Actually I don't disagree. What I mean by hardware changes is more
> >>> along the lines of changing the hard disk type in the same setup.
> >>> That's what I mean by careful with the benchmarking. Taking the resul=
ts
> >>> from an athlon XP and comparing it to an altix is silly for example.
> >>
> >> I'm going to cautiously disagree. If the CPU needed was scaled so it
> >> represented a fixed number of cycles (operations, work units) then the
> >> effect of faster CPU would be shown. And the total power of all attach=
ed
> >> CPUs should be taken into account, using HT or SMP does have an effect
> >> of feel.
> >
> > That is rather hard to do because each architecture's interpretation of
> > fixed number of cycles is different and this doesn't represent their
> > speed in the real world. The calculation when interbench is first run to
> > see how many "loops per ms" took quite a bit of effort to find just how
> > many loops each different cpu would do per ms and then find a way to ma=
ke
> > that not change through compiler optimised code. The "loops per ms"
> > parameter did not end up being proportional to cpu Mhz except on the sa=
me
> > cpu type.
>
> right, but the amount of cpu required to do a specific task will also vary
> significantly between CPU families for the same task as well. as long as
> the loops don't get optimized away by the compiler I think you can setup
> some loops to do the same work on each CPU, even if they take
> significantly different amounts of time (as an off-the-wall, obviously
> untested example you could make your 'loop' be a calculation of Pi and for
> the 'audio' test you compute the first 100 digits, for the video test you
> compute the first 1000 digits, and for the X test you compute a random
> number of digits between 10 and 10000)

Once again I don't disagree, and the current system of loops_per_ms does=20
exactly that and can be simply used as a fixed number of loops already. My=
=20
point was there'd be argument about what sort of "loop" or load should be=20
used as each cpu type would do different "loops" faster and they won't=20
necessarily represent video, audio or X in the real world. Currently the lo=
op=20
in interbench is simply:
	for (i =3D 0 ; i < loops ; i++)
	     asm volatile("" : : : "memory");

and if noone argues i can use that for fixed workload.

Cheers,
Con

--nextPart2292893.RydbJ4xdA9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC1bXjZUg7+tp6mRURAla6AJ9ei3kWWsv54sfTL0xBRflsUaqYGACghZTz
HWsfSAn6feIyvgphNTKDa34=
=bTJR
-----END PGP SIGNATURE-----

--nextPart2292893.RydbJ4xdA9--
