Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272586AbTHPEKW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 00:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272587AbTHPEKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 00:10:22 -0400
Received: from rrba-bras-192-221.telkom-ipnet.co.za ([165.165.192.221]:34176
	"EHLO nosferatu.lan") by vger.kernel.org with ESMTP id S272586AbTHPEKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 00:10:10 -0400
Subject: Re: [PATCH]O15int for interactivity
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200308122226.11557.kernel@kolivas.org>
References: <200308122226.11557.kernel@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XbiEhFXQyTxOjhZfWwhD"
Message-Id: <1061007006.11207.23.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 16 Aug 2003 06:10:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XbiEhFXQyTxOjhZfWwhD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-12 at 15:22, Con Kolivas wrote:
> This patch addresses the problem of tasks that preempt their children whe=
n=20
> they're forking, wasting cpu cycles until they get demoted to a priority =
where=20
> they no longer preempt their child. Although this has been said to be a d=
esign=20
> flaw in the applications, it can cause sustained periods of starvation du=
e to=20
> this coding problem, and the more I looked, the more examples I found of =
this=20
> happening.
>=20
> Tasks now cannot preempt their own children. This speeds up the startup o=
f=20
> child applications (eg pgp signed email).
>=20
> This change has allowed tasks to stay at higher priority for much longer =
so=20
> the sleep avg decay of high credit tasks has been changed to match the ra=
te of=20
> rise during periods of sleep (which I wanted to do originally but was lim=
ited=20
> by the first problem). This makes for much more sustained interactivity a=
t=20
> extreme loads, and much less X jerkiness.
>=20

Ok, finally had the chance to test O15.

Seems ok this side now with HT enabled.  I did a few tests and here
is just briefly some notes:

1)  It does take a bit longer to compile anything when the system is
    under load.  Roughly with two make -j{6,12}s going, with mm1
    and about 1 second, and with bk3 and O15 about two seconds.  I
    did not run too many passes on the bk3&O15 combination, so could
    be just some or other change in environment.  Non issue for me.

2)  XMMS/whatever still do not skip (nothing different from vanilla
    bk[13].

3)  The only major difference now between vanilla bk, and bk3+O15 or
    mm[12] and O15, is that doing the 'window wiggle test' (*g*) do
    not start to jerk after about 10 seconds as in vanilla.  It is
    either way of no significance to me, as I do not in general do
    anything that I can think of that simulate this.  With vanilla
    though, response is there immediately if the window is let go of.

4)  The evolution thread doing expunging (pop3 side) when finished
    getting mail do seem to take a bit longer.  Guess it could be
    similar to the wine issues others have seen, but once again no
    real show stopper for me (I do expect some loss in response if
    there is high load).

5)  On bk3+O15 it seems like load is a tad higher for the same
    type of tests (23-26 with vanilla, 23-28 with mm, and about
    25-30 with vanilla bk3+o13).  I guess it might be some changes
    between bk3 and mm that your stuff have a minor dependency on,
    or changes from bk1 to bk3, as bk1 was what I used for testing
    without O15.

All in all, mouse is fine, mozilla do not 'pause'/whatever when
changing tabs/scrolling (both O15 and vanilla), XMMS do not
skip, etc.


Regards,

--=20

Martin Schlemmer




--=-XbiEhFXQyTxOjhZfWwhD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Pa6eqburzKaJYLYRAoJGAJ4ws/SecFnce0xQVezIz61PD9YReQCgls0x
3IkqQMVr+6Ye9vlU3Nz5Pc4=
=YOLK
-----END PGP SIGNATURE-----

--=-XbiEhFXQyTxOjhZfWwhD--

