Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbUCRBC2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 20:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbUCRBC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 20:02:27 -0500
Received: from legolas.restena.lu ([158.64.1.34]:12747 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S262220AbUCRBCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 20:02:10 -0500
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
From: Craig Bradney <cbradney@zip.com.au>
To: ross@datscreative.com.au
Cc: linux-kernel@vger.kernel.org, thomas.schlichter_at_web.de@albatron,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       len.brown_at_intel.com@albatron
In-Reply-To: <200403181019.02636.ross@datscreative.com.au>
References: <200403181019.02636.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Gjxl/XTIvbHI4XpFnyNB"
Message-Id: <1079571734.25542.4.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Mar 2004 02:02:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Gjxl/XTIvbHI4XpFnyNB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > > > a few days ago I noticed that my Athlon 3000+ was relatively hot (4=
9C)=20
> > > > although it was completely idle. At that time I was running 2.6.3-m=
m3 with=20
> > > > ACPI and IOAPIC-support enabled.=20
> > > >=20
> > > > As I tried 2.6.3, the idle temperature was at normal 39C. So I did =
do some=20
> > > > binary search with the -bk patches and found the patch that causes =
the high=20
> > > > idle temperature. It is ChangeSet@1.1626 aka 8259-timer-ack-fix.pat=
ch.=20
> > >=20
> > > Interesting -- the patch removes a pair of unnecessary for your=20
> > > configuration PIC accesses when using an I/O APIC NMI watchdog. You h=
ave=20
> > > the NMI watchdog enabled, don't you?=20
> =20
> > No, I don't use the NMI watchdog...=20
> >  So the optimization of removing these I/O accesses is bogus for my con=
figuration. Btw. I don't know if I already mentioned it, but I use the VIA =
KT400 chipset. Maybe this is of interest...=20
> =20
> > The only way to cool down my CPU was to enable timer_ack.=20
> >  I don't know how to help you, but of course I am willing to test patch=
es... ;-)=20
> >   Thomas=20
> =20
> I agree with Len Brown's comments to try to examine which power saving st=
ate but
> if you want to try to brute force C1 state ( only works if chipset suppor=
ted )
> you could try this patch for process.c,=20
> (ignore the io-apic patch as it is nforce2 specific).
>=20
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-02/6520.html
> The KERNEL ARG to invoke it is "idle=3DC1halt".=20
> =20
> It has an extra function pointer to prevent the power management idle rou=
tine
> hikjacking things after the command line arg has requested an idle routin=
e.
>=20
> These idle mods appear to assist more than just nforce2 Athlon boards.
> Thomas Herrmann has had success with an SIS740
>=20
> > Hi Ross,
> > I just want to let you know that your nforce2_idle patch does work with=
 the
> > SiS740 chipset too. While the current ACPI patch already routes the tim=
er of
> > the SiS740 to IO-APIC-edge with out the C1halt option of your nforce2_i=
dle
> > patch the system locked up when STPGNT was enabled. But after I applied=
 your
> > nforce2_idle patch to kernel 2.4.24 together with the C1halt kernel boo=
t
> > option, the system runs stable for hours.
> > Great work, thanks!
> > Best regards,   Thomas
>=20
> Craig Bradney has put it into the gentoo dev sources also.
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/1746.html

Ross, your patch is pretty damn stable.. I had to shut down the PC today
due to expected wiring changes (lucky, a blackout came before the wiring
changes!).. the PC was at over 8 days uptime. At first I thought the box
was cooler.. now my observations are as follows:
At idle and under load the motherboard temp is 1-2C lower.
At idle the CPU is about the same
When compiling it gets to be a bit hotter than before but I have taken
one fan offline so I'm not sure of the result but its still only reaches
45C. I'll try again soon with the 2nd fan on and see what its like.

Craig

--=-Gjxl/XTIvbHI4XpFnyNB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAWPUVi+pIEYrr7mQRAi4GAJ9IvLB9+Y5DyC7l5JjKzC0yI1ucFACgn9cG
qzIMYzNWPX+yyieg+Ng/Xd8=
=O6oP
-----END PGP SIGNATURE-----

--=-Gjxl/XTIvbHI4XpFnyNB--

