Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTEDQ52 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 12:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbTEDQ52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 12:57:28 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:2059 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261177AbTEDQ5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 12:57:20 -0400
Date: Sun, 4 May 2003 19:09:47 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: will be able to load new kernel without restarting?
Message-ID: <20030504170947.GM27494@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <freemail.20030403212422.18231@fm9.freemail.hu> <20030503205656.GA19352@middle.of.nowhere> <200305032252.h43Mq7X9006633@turing-police.cc.vt.edu> <200305041200000380.00B553E1@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GeONROBiaq1zPAtT"
Content-Disposition: inline
In-Reply-To: <200305041200000380.00B553E1@smtp.comcast.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GeONROBiaq1zPAtT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-05-04 12:00:00 -0400, rmoser <mlmoser@comcast.net>
wrote in message <200305041200000380.00B553E1@smtp.comcast.net>:
> You silly boys.  Thinking everything is impossible.  The old kernel
> is just a shadow of the new one... just a shadow............  I'll try
> spitting out a basic sketch.  This I'm sure you've done but if not,
> fix it.  I'm an idiot, so this won't work as-is.
>=20
> For starters, freeze the system.  halt EVERYTHING.
>=20
> Now load the new kernel.
>=20
> Now you have this thing in RAM.  Fine.  It's not running but it's in
> RAM.
>=20
> Start feeding data over to it.  In a manner it can understand.  You know,
> make all the modules work with a standard named stream (check the
> Advanced Tracker planning file at the very end:
> http://advancedtracker.sourceforge.net/at/__at.plan.txt
> I did copy it below, so you don't have to go there).  This is the
> hard part--Module compatibility through defined names.  This would
> bloat the kernel, so think about it and maybe you'll figure out a good
> way.

Sounds like being a nice feature (esp. for 24/7 uptime), but it also
sounds like a *lot* of bloat. You'll have to encode (and to decode) any
single bit if data. But - where to put all that? See, it you're having
some Gigabytes of ram, you probably end with > 100MB only describing all
those single pages (4..8K) of RAM. Encode that into a named stream - you
end up with > 1GB of data. Then, you also need to encode the whole state
of any drivers.

What do you do if drivers/mm/you-name-it changed and now uses different
data structures? In fact, any two choosen kernels may potentially use
different data structures. So for the newly-to-load kernel, you need
stream decoders for all possible older kernels. Bloat again.

So if I would need something like that, I think kexec is the way to go,
possibly with a second machine for failover (to even close the kexec
booting gap).

However - if you like this feature so much you'd die for: nobody stops
you to implement a proof-of-concept:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--GeONROBiaq1zPAtT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tUlbHb1edYOZ4bsRAmTEAJ9nSPZCVtsbAVRogpBBFUCruvZaVACfb12C
vZp7TCxxq7XbyYgeCGY8aK4=
=+rM+
-----END PGP SIGNATURE-----

--GeONROBiaq1zPAtT--
