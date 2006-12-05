Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967571AbWLEHlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967571AbWLEHlx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 02:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967496AbWLEHlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 02:41:53 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:5013 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967571AbWLEHlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 02:41:52 -0500
From: Ian Campbell <ijc@hellion.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
In-Reply-To: <1165263296.6152.8.camel@localhost.localdomain>
References: <1165153834.5499.40.camel@localhost.localdomain>
	 <1165259962.6152.5.camel@localhost.localdomain>
	 <1165261226.5499.54.camel@localhost.localdomain>
	 <1165263296.6152.8.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ui24DhsqwC79Tv3iHA1c"
Date: Tue, 05 Dec 2006 07:41:38 +0000
Message-Id: <1165304498.5499.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: PMTMR running too fast
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ui24DhsqwC79Tv3iHA1c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-12-04 at 12:14 -0800, john stultz wrote:
> On Mon, 2006-12-04 at 19:40 +0000, Ian Campbell wrote:
> > On Mon, 2006-12-04 at 11:19 -0800, john stultz wrote:
> > > On Sun, 2006-12-03 at 13:50 +0000, Ian Campbell wrote:
> > > > In older kernels arch/i386/kernel/timers/timer_pm.c:verify_pmtmr_ra=
te
> > > > contained a check for sensible PMTMR rate and disabled that clockso=
urce
> > > > if it was found to be out of spec[0]. This check seems to have been=
 lost
> > > > in the transition to drivers/clocksource/acpi_pm.c, the removal is =
in
> > > > 61743fe445213b87fb55a389c8d073785323ca3e "Time: i386 Conversion - p=
art
> > > > 4: Remove Old timer_opts Code"[1] and the check is not present in t=
he
> > > > replacement 5d0cf410e94b1f1ff852c3f210d22cc6c5a27ffa "Time: i386
> > > > Clocksource Drivers"[2].
> > >=20
> > > Fedora has a bug covering this:
> > > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D211902
> >=20
> > > > Is there a specific reason the check was removed (I couldn't see on=
 in
> > > > the archives) or was it simply overlooked? Without it I need to pas=
s
> > > > clocksource=3Dtsc to have 2.6.18 work correctly on an older K6 syst=
em with
> > > > an Aladdin chipset (will dig out the precise details if required). =
Would
> > > > a patch to reintroduce the check be acceptable or would some sort o=
f
> > > > blacklist based solution be more acceptable?
> > >=20
> > > If I recall correctly, it was pulled because there was some question =
as
> > > to if it was actually needed (x86_64 didn't need it) and it slows dow=
n
> > > the boot time (although not by much).=20
> > >=20
> > > I'm fine just re-adding it. Although if the number of affected system=
s
> > > are small we could just blacklist it (Ian, mind sending dmidecode
> > > output?).
>=20
> I don't have a dev box to test on at the moment, but here's a quick hack
> attempt at re-adding the code. Does the following work for you?=20

I get:
        PM-Timer running at invalid rate: 200% of normal - aborting.
        ...
        Time: pit clocksource has been installed.
       =20
Without the clocksource parameter.

Should tsc be preferred to pit though?

/sys/devices/system/clocksource/clocksource0/available_clocksource now
shows "jiffies tsc pit" and current_clocksource is "pit".

Thanks,
Ian.

--=20
Ian Campbell

love, n.:
	When it's growing, you don't mind watering it with a few tears.

--=-ui24DhsqwC79Tv3iHA1c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFdSKxM0+0qS9rzVkRAlLqAJ4pAbltnZ9E2Fsv7Z/Ro0uNjmbLIwCcD9uL
WJHmlrQKypA2hUXUIonQqeo=
=kDMa
-----END PGP SIGNATURE-----

--=-ui24DhsqwC79Tv3iHA1c--

