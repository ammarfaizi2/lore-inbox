Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUG0KTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUG0KTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 06:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUG0KTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 06:19:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:43920 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263117AbUG0KTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 06:19:34 -0400
Date: Tue, 27 Jul 2004 12:19:27 +0200
From: Karsten Keil <kkeil@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [I4L] Fix IRQ-sharing lockup in nj_s
Message-ID: <20040727101927.GA11952@pingi3.kke.suse.de>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040727082241.GA15624@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20040727082241.GA15624@gondor.apana.org.au>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.4-52-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yes, correct.

On Tue, Jul 27, 2004 at 06:22:41PM +1000, Herbert Xu wrote:
> Hi:
>=20
> This is a backport of a fix that's already in 2.6.  The problem is that
> nj_s is enabling interrupts before the handler is even installed.  This
> patch delays the call until after the handler has been registered.
>=20
> Cheers,
> --=20
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Signed-off-by: Karsten Keil <kkeil@suse.de>

=3D=3D=3D=3D=3D drivers/isdn/hisax/nj_s.c 1.7 vs edited =3D=3D=3D=3D=3D
--- 1.7/drivers/isdn/hisax/nj_s.c	2002-04-01 11:02:11 +10:00
+++ edited/drivers/isdn/hisax/nj_s.c	2004-07-27 18:19:41 +10:00
@@ -130,6 +130,7 @@
 			release_io_netjet(cs);
 			return(0);
 		case CARD_INIT:
+			reset_netjet_s(cs);
 			inittiger(cs);
 			clear_pending_isac_ints(cs);
 			initisac(cs);
@@ -262,7 +263,6 @@
 	} else {
 		request_region(cs->hw.njet.base, bytecnt, "netjet-s isdn");
 	}
-	reset_netjet_s(cs);
 	cs->readisac  =3D &NETjet_ReadIC;
 	cs->writeisac =3D &NETjet_WriteIC;
 	cs->readisacfifo  =3D &NETjet_ReadICfifo;

--=20
Karsten Keil
SuSE Labs
ISDN development
--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBiwvo5VVC52CNcQRAloqAJ47q1TBPwS5XZ04wCv4yrrIBkAUbQCfZsC6
Z+nbXPWmDLXk3/t+ApxhEfs=
=Q03j
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
