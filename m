Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbTHaTcl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 15:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbTHaTcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 15:32:41 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:41144
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S261652AbTHaTci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 15:32:38 -0400
Subject: Re: [SHED] Questions.
From: Ian Kumlien <pomac@vapor.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1062355996.1313.4.camel@boobies.awol.org>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <1062355996.1313.4.camel@boobies.awol.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jMzqrIyAm/4npD7gPYXA"
Message-Id: <1062358285.5171.101.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 31 Aug 2003 21:31:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jMzqrIyAm/4npD7gPYXA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-08-31 at 20:53, Robert Love wrote:
> On Sun, 2003-08-31 at 06:07, Ian Kumlien wrote:
>=20
> > Why not use small quantum values for high pri processes and long for lo=
w
> > pri since the high pri processes will preempt the low pri processes
> > anyways. And for a server working under load with only a few processes
> > (assuming they are all low pri) would lessen the context switches.
>=20
> The rationale behind giving high priority processes a large timeslice is
> two-fold:
>=20
> (1) if they are interactive, then they won't actually use it all (this
> is the point you are making). But,
>=20
> (2) Having a large timeslice ensures that they have a high probability
> of having available timeslice when they _do_ need it.

Since they would have a high pri still, and preempt is there... it
should be back on the cpu pretty quick.

> So, yes, interactive processes can get by with a small timeslice,
> because that is by-definition all they need.  But they do need to run
> often (i.e., as I think you have mentioned in your last email,
> interactive processes are "run often for short periods"), so the large
> timeslice ensures that they are never expired.

But, it also creates problems for when a interactive process becomes a
cpu hog. Like this the detection should be faster, but should be slowed
down somewhat.

> A counterargument might be that the large timeslice is a detriment to
> other high priority processes.  But the thinking is that, by definition,
> interactive processes won't use all of the timeslice.  And thus will not
> hog the CPU.  If they do, the interactivity estimator will quickly bring
> them down.

But, hogs would instead cause a context switch hell and lessen the
throughput on server loads...

> That is the rationale in the current scheduler, anyhow.  Nick's current
> work is interesting, and a bit different.

Yes, saner imho =3D)

> > And a system with "interactive load" as well would, as i said, preempt
> > the lower pris. But this could also cause a problem... Imho there shoul=
d
> > be a "min quantum value" so that processes can't preempt a process that
> > was just scheduled (i dunno if this is implemented already though).=20
>=20
> I don't think this is a good idea.  I see your intention, but we have
> priorities for a reason.

I don't see how priorities would be questioned... Since, all i say is
that a task that gets preempted should have a guaranteed time on the cpu
so that we don't waste cycles doing context switches all the time.=20

I can see that Ingos current scheduler is good from a desktop
standpoint, but having it that way is not warranted when preempt comes
in to the picture (if i correctly understand it's workings)...=20
With preempt i actually see no reason for the priority inversion.. And
to answer someone who mailed about this before: "Yes, it does seem to be
slower than my Amigas, esp the ones that use Executive...".
(That feedback scheduler rocks =3D))

--=20
Ian Kumlien <pomac@vapor.com>

--=-jMzqrIyAm/4npD7gPYXA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Uk0N7F3Euyc51N8RAu6zAJ0SxJgVLrIw5ZbIR2x1s7k35ycsvACfdacT
BvsrirzVT3PU29KGSThaj4c=
=7oLj
-----END PGP SIGNATURE-----

--=-jMzqrIyAm/4npD7gPYXA--

