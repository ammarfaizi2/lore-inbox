Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263344AbTIAXEg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 19:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbTIAXEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 19:04:36 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:9940
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S263344AbTIAXEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 19:04:33 -0400
Subject: Re: [SHED] Questions.
From: Ian Kumlien <pomac@vapor.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
In-Reply-To: <200309011707.20135.phillips@arcor.de>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <1062369684.9959.166.camel@big.pomac.com>
	 <1062373274.1313.28.camel@boobies.awol.org>
	 <200309011707.20135.phillips@arcor.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-viiGbk+oJQWMjltMGsQw"
Message-Id: <1062457396.9959.243.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 02 Sep 2003 01:03:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-viiGbk+oJQWMjltMGsQw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[Forgot CC to LKML and Robert Love, sorry ]

On Mon, 2003-09-01 at 17:07, Daniel Phillips wrote:
> On Monday 01 September 2003 01:41, Robert Love wrote:
> > Priority inversion is bad, but the priority inversion in this case is
> > intended.  Higher priority tasks cannot starve lower ones.  It is a
> > classic Unix philosophy that 'all tasks make some forward progress'
>=20
> So if I have 1000 low priority tasks and one high priority task, all CPU=20
> bound, the high priority task gets 0.1% CPU.  This is not the desirable o=
r=20
> expected behaviour.

> My conclusion is, the strategy of expiring the whole active array before =
any=20
> expired tasks are allowed to run again is incorrect.  Instead, each activ=
e=20
> list should be refreshed from the expired list individually.  This does n=
ot=20
> affect the desirable O(1) scheduling property.  To prevent low priority=20
> starvation, the high-to-low scan should be elaborated to skip some runnab=
le,=20
> high priority tasks occasionally in a *controlled* way.

I like this idea.
You could handle the priority starvation with a "old process" boost.
(i don't know which would be simpler or if there is something even
simpler out there)

This would ensure that all processes are run sooner or later. Real
cpuhogs would run very seldom due to being starved, but run when they
get the boost. On a loaded system this might be desirable since most
login tools would be "normal" or "high pri" from the get go.
(there might be a problem with locks though)

This should also work hand in hand with timeslice changes imho. Aswell
as process preemption. If we assume that cpu hogs has work that they
want to get done, let em do it for as long as possible. If something
"important" happens, it'll be preempted right?

> IMHO, this minor change will provide a more solid, predictable base for C=
on=20
> and Nick's dynamic priority and dynamic timeslice experiments.

Most definitely.

--=20
Ian Kumlien <pomac@vapor.com>

--=-viiGbk+oJQWMjltMGsQw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/U9A07F3Euyc51N8RAiJnAKCYd0fCmbKrwNqDgLvHo2Er2ZQBGwCdGUI1
kZIOF7268eJGTw3DgC2Zcek=
=M1P7
-----END PGP SIGNATURE-----

--=-viiGbk+oJQWMjltMGsQw--

