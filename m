Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318984AbSHWRya>; Fri, 23 Aug 2002 13:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319007AbSHWRya>; Fri, 23 Aug 2002 13:54:30 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:51840
	"HELO ghanima.endorphin.org") by vger.kernel.org with SMTP
	id <S318984AbSHWRy3>; Fri, 23 Aug 2002 13:54:29 -0400
Date: Fri, 23 Aug 2002 19:58:38 +0200
To: linux-kernel@vger.kernel.org
Subject: Does IRQ code touch FS code? (2.4.x)
Message-ID: <20020823175838.GA1374@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: "Fruhwirth Clemens" <clemens@endorphin.org>
X-Delivery-Agent: TMDA/0.47 (Python 2.1.3 on linux2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

As Marcello isn't sure if he should change the IV metric in 2.4.x/loop.c, I
decided to circumvent the problem with an ugly hack.=20
My hack (for cryptoloop of cryptoapi) depends on the fact that=20
blksize[MAJOR_LOOP][SOME_MINOR] does not change within the loop thread.=20

The loop thread, however, runs with IRQs enabled. So IRQ handler code might
break my assumption that blksize[..] does not change. As far as I can see
there is just fs code which touches blksize. So my question is:=20

Is IRQ code allowed to touch FS code?

I hope some kernel wizard can clarify that issue for me. My guess is, that
IRQ code is not allowed to touch FS code, since FS code makes liberal use
of schedule(), which is forbidden for IRQ code.

Thanks, Clemens

Please CC.

--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9ZnfOHkYGUbdPrgQRAh3+AJwLxGwX/znhnRImbFyJnyxBpX/17ACdFO8j
ItuGLeEZYCWiv3KbybLKLVI=
=UaZu
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
