Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUCRJGy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbUCRJGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:06:54 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:22471 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262450AbUCRJGp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:06:45 -0500
Date: Thu, 18 Mar 2004 09:51:33 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Nate Lawson <nate@root.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Peter Chubb <peter@chubb.wattle.id.au>,
       Karol Kozimor <sziwan@hell.org.pl>, john stultz <johnstul@us.ibm.com>,
       acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Message-ID: <20040318085133.GA15526@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Nate Lawson <nate@root.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Karol Kozimor <sziwan@hell.org.pl>,
	john stultz <johnstul@us.ibm.com>, acpi-devel@lists.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>
References: <16471.43776.178128.198317@wombat.chubb.wattle.id.au> <200403162340.57546.dtor_core@ameritech.net> <20040317095314.GB14983@dominikbrodowski.de> <20040317145312.X3595@root.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20040317145312.X3595@root.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 17, 2004 at 02:56:27PM -0800, Nate Lawson wrote:
> On Wed, 17 Mar 2004, Dominik Brodowski wrote:
> > On Tue, Mar 16, 2004 at 11:40:57PM -0500, Dmitry Torokhov wrote:
> > > On Tuesday 16 March 2004 08:33 pm, Peter Chubb wrote:
> > > > >>>>> "Dmitry" =3D=3D Dmitry Torokhov <dtor_core@ameritech.net> wri=
tes:
> > > >
> > > > Dmitry> On Tuesday 16 March 2004 07:13 pm, Karol Kozimor wrote:
> > > > >> Thus wrote john stultz: > Hmm. This is untested, but I think this
> > > > >> should do the trick.
> > > > >>
> > > > >> Hmm... without the patch, neither cpu MHz nor bogomips are updat=
ed,
> > > > >> with the patch cpu MHz value seems correct (both using acpi.ko a=
nd
> > > > >> speedstep-ich.ko, but the bogomips is still at its initial value.
> > > > >> Best regards,
> > > > >>
> > > >
> > > > Dmitry> Karol, do you have a P4? AFAIK P4's TSC is stable even if c=
ore
> > > > Dmitry> frequence changes so loop_per_juffy (=3D=3D bogomips) need =
not be
> > > > Dmitry> updated.
> > > >
> > > > The TSC is variable rate for Pentium-IV if you're using clock
> > > > modulation.
> > > >
> > > > Peter C
> > > >
> > >
> > > I understand that by clock modulation you mean throttling as opposed =
to
> > > true SpeedStep... OK, that means that for P4+ we somehow need to figu=
re
> > > out whether the CPU is throttled or not to correctly calculate delays.
> > > Is there a clean way to get this data?
> >
> > Hm, will have one patch to test it ready later today -- and a basic pat=
ch to
> > do this distinction is in the hiding of my notebook's harddisk already.=
=2E.
> > who's willing to do some testing on his SpeedStep-capable Pentium 4 - M=
obile.
>=20
> Instead of all this gymnastics, how about:

It's not so much gymnastics -- implementing different handling for cpufreq
drivers which do not affect the TSC is easy. It's just difficult to get to
know what drivers/CPUs are affected... and the test run you did yesterday
helped in evaluating this. Thanks for doing so.
=20
> 1. If using Px states, state is unknown until first "set" event.

Normally, when using cpufreq drivers the original state is known -- only the
ACPI spec has this severe flaw, but there are tries for a workaround [patch
is submitted]

> 2. Implement priorities for time source selection and a generic timer API.
> This gets around the need to get the clock rate correct to have system
> timers work.  On FreeBSD, this is /sys/kern/kern_tc.c

IIRC, John Stultz intends to do a major upgrade of the timing code in 2.7.

	Dominik

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAWWMVZ8MDCHJbN8YRAgTpAJ0TBQxl6ukms526cctWQixRajHBUACfYe5S
BvYijW695DQURjL16UwNmRc=
=PPdA
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
