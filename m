Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263706AbTIBK01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 06:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbTIBK01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 06:26:27 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:6357
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S263706AbTIBK0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 06:26:23 -0400
Subject: Re: [SHED] Questions.
From: Ian Kumlien <pomac@vapor.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
In-Reply-To: <200309021023.24763.kernel@kolivas.org>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <200309011707.20135.phillips@arcor.de>
	 <1062457396.9959.243.camel@big.pomac.com>
	 <200309021023.24763.kernel@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D4a9TOTDiPw0qSblus2h"
Message-Id: <1062498307.5171.267.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 02 Sep 2003 12:25:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D4a9TOTDiPw0qSblus2h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-09-02 at 02:23, Con Kolivas wrote:
> On Tue, 2 Sep 2003 09:03, Ian Kumlien wrote:
> > On Mon, 2003-09-01 at 17:07, Daniel Phillips wrote:
> > > IMHO, this minor change will provide a more solid, predictable base f=
or
> > > Con and Nick's dynamic priority and dynamic timeslice experiments.
> >
> > Most definitely.
>=20
> No, the correct answer is maybe... if after it's redesigned and put throu=
gh=20
> lots of testing to ensure it doesn't create other regressions. I'm not sa=
ying=20
> it isn't correct, just that it's a major architectural change you're=20
> promoting. Now isn't the time for that.
>=20
> Why not just wait till 2.6.10 and plop in a new scheduler a'la dropping i=
n a=20
> new vm into 2.4.10... <sigh>=20

Wouldn't a new scheduler be easier to test? And your patches changes
it's behavior quite a lot. Wouldn't they require the same testing?
(And Nicks for that mater, who changes more)

> The cpu scheduler simply isn't broken as the people on this mailing list =
seem=20
> to think it is. While my tweaks _look_ large, they're really just tweakin=
g=20
> the way the numbers feed back into a basically unchanged design. All the=20
> incremental changes have been modifying the same small sections of sched.=
c=20
> over and over again. Nick's changes change the size of timeslices and the=
=20
> priority variation in a much more fundamental way but still use the basic=
=20
> architecture of the scheduler.=20

But, can't this scheduler suffer from starvation? If the run queue is
long enough? Either via that deadline or via processes not running...

Wouldn't a starved process boost ensure that even hogs on a loaded
system got their share now and then?

You could say that the problem the current scheduler has is that it's
not allowed to starve anything, thats why we add stuff to give
interactive bonus. But if it *was* allowed to starve but gave bonus to
the starved processes that would make most of the interactive detection
useless (yes, we still need the "didn't use their timeslice" bit and
with a timeslice that gets smaller the higher the pri we'd automagically
balance most processes).

(As usual my assumptions might be really wrong...)

> Promoting a new scheduler design entirely is admirable and ultimately pro=
bably=20
> worth pursuing but not 2.6 stuff.

Well, discussing and creating it is one thing. Implementing it is
another. Accepting the patch is still up to the-powers-that-be(tm)

--=20
Ian Kumlien <pomac@vapor.com>

--=-D4a9TOTDiPw0qSblus2h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/VHAC7F3Euyc51N8RApDUAJ4zu6jGOKBlQRfNklW1UqnEFC5eSQCbBMnv
cGyMlg8bRpsnztpSSz/dvNQ=
=Zpq1
-----END PGP SIGNATURE-----

--=-D4a9TOTDiPw0qSblus2h--

