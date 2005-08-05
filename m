Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVHEWoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVHEWoW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVHEWoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:44:21 -0400
Received: from neveragain.de ([217.69.76.1]:23249 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S261968AbVHEWnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:43:41 -0400
Date: Sat, 6 Aug 2005 00:42:33 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: local DDOS? Kernel panic when accessing /proc/ioports
Message-ID: <20050805224233.GA26096@minerva.local.lan>
References: <20050805192628.GA24706@minerva.local.lan> <Pine.LNX.4.61.0508051538390.6245@chaos.analogic.com> <20050805214954.GA25533@minerva.local.lan> <20050805153344.5fb12313.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20050805153344.5fb12313.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender succeded SMTP AUTH authentication, not delayed by milter-greylist-1.4 (hobbit.neveragain.de [217.69.76.1]); Sat, 06 Aug 2005 00:43:41 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 05, 2005 at 03:33:44PM -0700, Andrew Morton wrote:
> Martin Loschwitz <madkiss@madkiss.org> wrote:
> >
> > On Fri, Aug 05, 2005 at 03:40:26PM -0400, linux-os (Dick Johnson) wrote:
> > >=20
> > > On Fri, 5 Aug 2005, Martin Loschwitz wrote:
> > >=20
> > > > Hi folks,
> > > >
> > > > I just ran into the following problem: Having updated my box to 2.6=
=2E12.3,
> > > > I tried to start YaST2 and noticed a kernel panic (see below). Some=
 quick
> > > > debugging brought the result that the kernel crashes while some use=
r (not
> > > > even root ...) tries to access /proc/ioports. Is this a known probl=
em and
> > > > if so, is a fix available?
> > > >
> > > > Ooops and ksymoops-output is attached.
> > > >
> > >=20
> > > This can happen if a module is unloaded that doesn't free its
> > > resources! Been there, done that.
> > >=20
> >=20
> > "This can happen" is not an acceptable explanation, I think.
>=20
> It's a very accurate one though.
>=20
> The most common cause of this bug is that some buggy kernel module has be=
en
> unloaded.  It forgot to release its I/O region.  When you later come along
> to look in /proc/ioports the kernel goes to fetch information from the
> memory which is "owned" by the module which isn't there any more.  Crash.
>=20
> So if you can identify which kernel module was loaded and then unloaded,
> we'll fix it up.

uhm -- well, okay, once again: If you boot knoppix with the "debug" argumen=
t,
it will start init but throw you on a very limited shell called "ash" right
after that. At least the "cat" command is included in that shell, and lsmod=
=20
is available as well.

I am pretty sure that until that very early moment, not a single module has
been unloaded -- infact, "rmmod" is not even called in the init script until
that moment. The only modules loaded were:

sbp2 ohci1394 usb_storage ub ehci_hcd usbcore

And that's it. So if you suspect some module to be the culprit, it must be
one of these.

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC8+tZHPo+jNcUXjARArdtAJ9VjyWKWkMarGCuK4oHqJJ7bkDipwCeIFTQ
2eDz3Nfo9QRdVm4xNlrot1g=
=YnUw
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
