Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbTLGV3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264567AbTLGV2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:28:52 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:56736
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S264534AbTLGU4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:56:34 -0500
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
From: Ian Kumlien <pomac@vapor.com>
To: Jesse Allen <the3dfxdude@hotmail.com>
Cc: AMartin@nvidia.com, ross@datscreative.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20031207205906.GA425@tesore.local>
References: <1070827127.1991.16.camel@big.pomac.com>
	 <20031207205906.GA425@tesore.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+Y0c39MId7CSWLjA4Bof"
Message-Id: <1070830598.1996.23.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 07 Dec 2003 21:56:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+Y0c39MId7CSWLjA4Bof
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-12-07 at 21:59, Jesse Allen wrote:
> On Sun, Dec 07, 2003 at 08:58:47PM +0100, Ian Kumlien wrote:
> > > There are three parts to this email.
> > > a) apic mods.
> > > Lockups are due to too fast an apic acknowledge of apic timer int.
> > > Apic hard locked up the system - no nmi debug available.
> > > Fixed it by introducing a delay of at least 500ns into=20
> > > smp_apic_timer_interrupt() just prior to ack_APIC_irq().
> > > b) io-apic mods
> > > So I have fixed it too (tested on both my epox and albatron MOBOs).
> > > Firstly I found 8254 connected directly to pin 0 not pin 2 of io-apic=
.
> > > I have modified check_timer() in io_apic.c to trial connect pin and=20
> > > test for it after the existing test for connection to io-apic.=20
>=20
> So do you think Ross has found the connection between all three
> issues?  (Timer and NMI watchdog, IRQ 7, and CPU disconnect?)

Since disabling CPU disconnect or adding this delay both seems to fix
the deadlock, i see the rest as cool stuff.=20

> I suppose we should now try these changes other the last two.  From
> what he's saying, this will fix the lockup too.  Hopefully the patch
> will be refined =3D).  I probably won't be able to run this till
> tomorrow, and after I get it diffed for 2.6.  I've barely got the cpu
> disconnect patch going today, but haven't tested it because I can only
> access my nforce2 machine remotely =3D).  But from everything I'm
> hearing, the lockups are gone.

Yes, at least for me, and my machine really liked to deadlock.

I'm wondering however, could the ACK be moved down in the code? after
some handling? (i have no clue of how the code works, and even less
about how the hw part works, fyi)
But i thought that if it's moved then that might be a generic way to fix
it without adding a blocking delay.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-+Y0c39MId7CSWLjA4Bof
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/05QG7F3Euyc51N8RAuDDAKCoABwQpfItQTOHa9/1d+uH3+8SmQCghY5q
6S0qTtQSpt8MNfV3M5BfHpk=
=fzwl
-----END PGP SIGNATURE-----

--=-+Y0c39MId7CSWLjA4Bof--

