Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbSKOO5y>; Fri, 15 Nov 2002 09:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbSKOO5y>; Fri, 15 Nov 2002 09:57:54 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:7430 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S266320AbSKOO5w>;
	Fri, 15 Nov 2002 09:57:52 -0500
Date: Fri, 15 Nov 2002 18:04:02 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Andrey Panin <pazke@orbita1.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: PC-9800 patch for 2.5.47-ac4: not merged yet (14/15) serial
Message-ID: <20021115150402.GA571@pazke.ipt>
Mail-Followup-To: Osamu Tomita <tomita@cinet.co.jp>,
	Andrey Panin <pazke@orbita1.ru>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	LKML <linux-kernel@vger.kernel.org>
References: <20021115131659.GA552@pazke.ipt> <3DD4F816.C6428F1E@cinet.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <3DD4F816.C6428F1E@cinet.co.jp>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On =D0=9F=D1=82=D0=BD, =D0=9D=D0=BE=D1=8F 15, 2002 at 10:35:18 +0900, Osamu=
 Tomita wrote:
> Andrey Panin wrote:
> >=20
> > On ????????, ??????????15, 2002 at 10:06:46 +0900, Osamu Tomita wrote:
> > > This is for serial port and onboard modem support.
> >=20
> > > @@ -376,7 +378,12 @@
> > >                           ((port->min =3D=3D 0x2f8) ||
> > >                            (port->min =3D=3D 0x3f8) ||
> > >                            (port->min =3D=3D 0x2e8) ||
> > > +#ifndef CONFIG_PC9800
> > >                            (port->min =3D=3D 0x3e8)))
> > > +#else
> > > +                          (port->min =3D=3D 0x3e8) ||
> > > +                          (port->min =3D=3D 0x8b0)))
> > > +#endif
> > >                               return 0;
> > >       }
> >=20
> > Why 0x8b0 should be added here ?
> > Is it one of default iobase value for C-bus PNP modems ?
> Yes. C-bus PNP modems use this default value. And old modem
> card is hard wired to this iobase.

Ok. But IMHO this way is better (check order doesn't matter here):

			((port->min =3D=3D 0x2f8) ||
			 (port->min =3D=3D 0x3f8) ||
			 (port->min =3D=3D 0x2e8) ||
                         (port->min =3D=3D 0x3e8) ||
#ifdef CONFIG_PC9800
                         (port->min =3D=3D 0x8b0) ||
#endif

                         (port->min =3D=3D 0x3e8)))
                              return 0;
	}

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE91QziBm4rlNOo3YgRAlJWAKCOwMhq6y92r+GGyc9mf5tFfKADEgCcCvaQ
xKpc5ZoCrLuNltldqDS3Js4=
=Rz5X
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
