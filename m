Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTGFMSF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 08:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbTGFMSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 08:18:05 -0400
Received: from mx02.qsc.de ([213.148.130.14]:60091 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S262093AbTGFMSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 08:18:00 -0400
Date: Sun, 6 Jul 2003 14:36:35 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O2int 0307041440 for 2.5.74-mm1
Message-ID: <20030706123635.GA657@gmx.de>
References: <200307041459.33326.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <200307041459.33326.kernel@kolivas.org>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.5.74-mm1-ww1-O2int-0307041440 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2003 at 02:59:08PM +1000, Con Kolivas wrote:
Content-Description: clearsigned data
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Here is a patch against the current O1int patch in 2.5.74-mm1.
> Since the O1int didn't mean anything I thought I'd call this O2int.
>=20
> This one wont blow you away but tames those corner cases.
>=20
> Changes:
> The child penalty is set on 80% which means that tasks that wait on their=
=20
> children have children forking just on the edge of the interactive delta =
so=20
> they shouldn't starve their own children.
>=20
> The non linear sleep avg boost is scaled down slightly to prevent this=20
> particular boost from being capable of making a task highly interactive. =
This=20
> makes very new tasks less likely to have a little spurt of too high prior=
ity.
>=20
> Idle tasks now get their static priority over the full time they've been=
=20
> running rather than starting again at 1 second. This makes it harder for =
idle=20
> tasks to suddenly become highly interactive and _then_ fork an interactiv=
e=20
> bomb. Not sure on this one yet.
>=20
> The sched_exit penalty to parents of cpu hungry children is scaled accord=
ingly=20
> (was missed on the original conversion so works better now).
>=20
> Hysteresis on interactive buffer removed (was unecessary).
>=20
> Minor cleanup.
>=20
> Known issue remaining:
> Mozilla acts just like X in that it is mostly interactive but has bursts =
of=20
> heavy cpu activity so it gets the same bonus as X. However it makes X jer=
ky=20
> during it's heavy cpu activity, and might in some circumstances make audi=
o=20
> skip. Fixing this kills X smoothness as they seem very similar to the=20
> estimator. Still haven't sorted a workaround for this one but I'm working=
 on=20
> it. Ingo's original timeslice granularity patch helps a little and may be=
=20
> worth resuscitating (and the desktop only people can change the granulari=
ty=20
> down to 10ms to satisfy their needs).
>=20
> Con

this one behaves worse than the previou one. When loading a big page
(such as www.heise.de or www.ebay.de) and moving the mouse in circles=20
it gets very jumpy.


--=20
Regards,

Wiktor Wodecki

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/CBfT6SNaNRgsl4MRArVsAJ41mY0atWNFNAGMUx6aBbs/yz2YCQCfSzY6
6Pf5vKHV1YvCp5ZZbbyIXXM=
=HByo
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
