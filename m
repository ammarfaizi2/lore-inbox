Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUDGMjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 08:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbUDGMjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 08:39:16 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:48830 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263079AbUDGMjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 08:39:11 -0400
Date: Wed, 7 Apr 2004 14:39:09 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: drivers/char/dz.[ch]: reason for keeping?
Message-ID: <20040407123909.GZ27362@lug-owl.de>
Mail-Followup-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>
References: <20040404101241.A10158@flint.arm.linux.org.uk> <20040404111712.GE27362@lug-owl.de> <20040404122958.A14991@flint.arm.linux.org.uk> <20040404120051.GF27362@lug-owl.de> <Pine.LNX.4.55.0404071304170.5705@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bRBRdwDfUq+EPrFt"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0404071304170.5705@jurand.ds.pg.gda.pl>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bRBRdwDfUq+EPrFt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-07 13:16:48 +0200, Maciej W. Rozycki <macro@ds2.pg.gda.pl>
wrote in message <Pine.LNX.4.55.0404071304170.5705@jurand.ds.pg.gda.pl>:
> On Sun, 4 Apr 2004, Jan-Benedict Glaw wrote:
> > Interrupt setup is a bit tricky on the VAXen. First, they actually have
> > separated RX and TX IRQ and these aren't static. IRQ probing needs to be
> > redone (at least can't be easily copied) since the new dz_init() is
> > basically a complete new rewrite...
>=20
>  I think we need to separate the chipset driver from the=20
> implementation-specific details.  There are at least three configurations=
=20

That might be a good idea...

> in existence:
>=20
> 1. DECstation on-board serial ports for the 3100 (2100) and the 5000/200=
=20
> (there are minor differences which can be handled together, I think).
>=20
> 2. The PMAC-A TURBOchannel board.  This implies up to 24 ports in a single
> system if we ever support the DEC 3000/900 (3000/800) Alpha systems; 16
> ports otherwise. ;-)
>=20
> 3. VAX-based systems -- you know the details better.

>From my point of view, (1) and (3) are quite similar; the differences
are mostly:

	- Different base addresses

	- Separate RX and TX interrupt. This part is tricky because on
	  VAX, the triggered IRQ needs to be ACKed twice. On the CPU and
	  on the vsbus controller, as it seems. That is, both VAX IRQ
	  handlers explicitely ACK their respective vsbus IRQ.

	- Register offsets are offset_mips =3D offset_vax * 2.

> Note the existence of #2 above implies there may be two different kinds of
> such ports in a single system, be it a DECstation or a VAXstation (the
> 4000 series use these ports as well, don't they?).

They do. ...and I also think that there *may* exist Linux support for
the 3000 type Alphas at some time. So for TC systems, we need to walk
through the busses and search for cards, right?

Also, we should be able to mark specific ports special. First and second
onboard ports are expected to deal with keyboard and mouse/tablet, so
they need to advertise this fact towards SERIO subsystem.

I wasn't yet successful in getting the new driver to work on VAX, but
that's a problem of time (-> I'm currently doing additional payed work)
and lack of output (-> I'd really try to figure out how to access the
diagnostic LEDs in the 4000/60 chassis). I hope to finish the additional
work during upcoming Easter, so I'd continue work after that.

However, we can right now start to discuss how to split the current
driver into chip-specific and machine/bus-specific parts. First goal, of
course, should be to make it work with DECstations and VAXstations (it's
current users). IIRC, 2.6.x isn't yet expected to work on DECstations,
so I'll probably start to make it work for VAXen first.

I'm not that familiar with the TC busses. Do you have the same register
offsets on the TC chips compared to the onboard DZ11? (So are
register offsets machine specific or bus specific?)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--bRBRdwDfUq+EPrFt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAc/ZtHb1edYOZ4bsRAjyVAJ9TRQOUo6geWfN5Kp1Q1bIMOhJyOQCeLtOj
x7UbugSt38nYaBC9O3M6hf0=
=1LYF
-----END PGP SIGNATURE-----

--bRBRdwDfUq+EPrFt--
