Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270175AbTGUPBi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270173AbTGUPBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:01:37 -0400
Received: from melchior.nerv-un.net ([216.179.91.90]:40453 "EHLO nerv-un.net")
	by vger.kernel.org with ESMTP id S270151AbTGUPAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:00:41 -0400
Date: Mon, 21 Jul 2003 11:08:21 -0400
From: Mike Kershaw <dragorn@melchior.nerv-un.net>
To: Javier Achirica <achirica@telefonica.net>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Ritz <daniel.ritz@gmx.ch>,
       Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>
Subject: Re: [PATCH 2.5] fixes for airo.c
Message-ID: <20030721150821.GA18134@melchior.nerv-un.net>
References: <20030721133757.A24319@infradead.org> <Pine.SOL.4.30.0307211543010.25549-100000@tudela.mad.ttd.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0307211543010.25549-100000@tudela.mad.ttd.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Grargh.  At work all weekend.  Didn't have time to make a real patch.

Anyhow - Proposed changes to airo.c for rfmonitor mode.  I've been working
on making it quiet (not continually probing) and on making it enter "true"
rfmon mode (right now it doesn't, which is why user-controlled channel
hopping doesn't work).  Both of these are "special case" stuff that doesn't
affect normal users, but are near and dear to my own pursuits. :P

I've succeeded in the first, but not the second, so I hadn't released any
changed driver code.  The first is actually a very simple change - in the=
=20
code block that puts the driver into rfmon mode (around line 2480 on my=20
code) after setting:
config.rmode =3D RXMODE_RFMON | RXMODE_DISABLE_802_3_HEADER;
or=20
config.rmode =3D RXMODE_RFMON_ANYBSS | RXMODE_DISABLE_802_3_HEADER;

it should set:
config.scanMode =3D SCANMODE_PASSIVE;

and in the code block exiting rfmon mode, after:
config.opmode =3D 0;
it should set:
config.scanMode =3D SCANMODE_ACTIVE;

With my testing this stops the probing in rfmon (good) and doesn't have any
negative impacts.  More testing is, of course, a good idea.

I can try to come up with an exact diff but I figured I should get something
out while everyone is discussing changes, and I don't know how much time I'm
going to have in the coming weeks.

-m

--=20
I like my coffee like I like my friends -- Dark, and bitter.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/HAHk17KIInOLvbERAjUmAKCffVkSErNL0zETLt6W+ER4HeLCggCePZv1
ud7SL9cS4wujEluogOGrlZI=
=Y723
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
