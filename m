Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSGAHvz>; Mon, 1 Jul 2002 03:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSGAHvy>; Mon, 1 Jul 2002 03:51:54 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:56327 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S315440AbSGAHvx>; Mon, 1 Jul 2002 03:51:53 -0400
Date: Mon, 1 Jul 2002 09:54:18 +0200
From: Kurt Garloff <garloff@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
Message-ID: <20020701075418.GA13908@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0206281730160.12542-100000@freak.distro.conectiva> <E17O7yk-0007w5-00@the-village.bc.nu> <20020630035058.A884@localhost.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20020630035058.A884@localhost.park.msu.ru>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ivan, Alan, Marcelo,

On Sun, Jun 30, 2002 at 03:50:58AM +0400, Ivan Kokshaysky wrote:
> On Sat, Jun 29, 2002 at 03:28:50AM +0100, Alan Cox wrote:
> > Please back it back in. The bug is the Alpha port. Alpha needs its own =
OSF
> > readv/writev entry point which masks the top bits.
>=20
> Ouch. The new entry point just because of this?!
> Marcelo, if you're going to back in that patch, please apply
> the following on the top of it.

This patch indeed makes acroread & netscape work again on my alpha. Nice
spotting.
Don't we know about the type of binary? (Like personality ...)
So we could use something like
   ssize_t len
 #ifdef __alpha__
   if (current->personality =3D=3D DEC_OSF_OLD)
     len =3D (int) iov[i].iov_len;
   else
     len =3D (ssize_t) iov[i].iov_len;
 #else
   len =3D (ssize_t) iov[i].iov_len;
 #endif

Not really beautiful, but working for all cases.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9IAqqxmLh6hyYd04RAuEyAKDVqVZ3EacioGqsRum49M5tUStOQACgnLyH
C29DWxfhT2/7N69j8ruvwlA=
=Gw5B
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
