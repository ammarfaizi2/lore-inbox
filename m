Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbTIAWUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTIAWUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:20:50 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:4564
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S263312AbTIAWUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:20:40 -0400
Subject: Re: [SHED] Questions.
From: Ian Kumlien <pomac@vapor.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200309011250.48238.kernel@kolivas.org>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <1062373274.1313.28.camel@boobies.awol.org>
	 <1062374409.5171.194.camel@big.pomac.com>
	 <200309011250.48238.kernel@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dNjwcSkcDtW44blBeNEb"
Message-Id: <1062454763.5171.204.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 02 Sep 2003 00:19:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dNjwcSkcDtW44blBeNEb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-09-01 at 04:50, Con Kolivas wrote:
> On Mon, 1 Sep 2003 10:00, Ian Kumlien wrote:
> > On Mon, 2003-09-01 at 01:41, Robert Love wrote:
> > > This implies that a high priority, which has exhausted its timeslice,
> > > will not be allowed to run again until _all_ other runnable tasks
> > > exhaust their timeslice (this ignores the reinsertion into the active
> > > array of interactive tasks, but that is an optimization that just
> > > complicates this discussion).
> >
> > So it's penalised by being in the corner for one go? or just pri
> > penalised (sounds like it could get a corner from what you wrote... Or
> > is it time for bed).
>=20
> Please read my RFC=20
> (http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D106178160825835&w=3D2=
) which=20
> has this extensively explained. If this were the case after one timeslice=
,=20
> then dragging a window in X at load of say 32 would be impossible; the wi=
ndow=20
> would move for 0.1 second, stand still for 3.2 seconds then move for anot=
her=20
> 0.1 second.

Thats nicely written, but it feels very complex...
The more i read it the more i like the "currency" implementation in
Executive (since i never understood how feedback worked exactly, it was
a while ago since i read it).

Just give all processes money to spend on cpu time... Set a high limit
and let em spend =3D)

> > > > Damn thats a tough cookie, i still think that the priority inversio=
n is
> > > > bad. Don't know enough about this to actually provide a solution...
> > > > Any one else that has a view point?
> > >
> > > Priority inversion is bad, but the priority inversion in this case is
> > > intended.  Higher priority tasks cannot starve lower ones.  It is a
> > > classic Unix philosophy that 'all tasks make some forward progress'
> >
> > Yes, like the feedback scheduler...
>=20
> Priority inversion to some extent will exist in any scheduler design that=
 has=20
> priorities. There are solutions available but they incur a performance=20
> penalty elsewhere (some people are currently experimenting). The inversio=
n=20
> problems inherent in my earlier patches are largely gone with the duratio=
n=20
> and severity of inversion being either equal to or smaller than the insta=
nces=20
> that occur in the vanilla scheduler. Nick's approach may work around it=20
> differently but documentation is hard to find (hint Nick*).

What i meant with priority inversion is that highpri should have small
timeslices and low pri should have large... Sorry if i was unclear.
(maybe the same size timeslice but separated in to timeunits)

> > > > Hummm, the skips in xmms tells me that something is bad..
> > > > (esp since it works perfectly on the previus scheduler)
> > >
> > > A lot of this is just the interactivity estimator making the wrong
> > > estimate.
> >
> > Yes, But... When you come from AmigaOS, and have used Executive...
> > things like this is dis concerning. Executive is a scheduler addition
> > for amigaos that has many schedulers to choose from. One of which is th=
e
> > original feedback scheduler. While a feedback scheduler consumes some
> > cpu it still allows you to play mp3's while surfing the net on a 50 mhz
> > 68060. Hearing about 500mhz machines that skip is somewhat.. odd.
>=20
> That's in an attempt to make them as high throughput machines as possible=
.=20
> Xmms skipping is basically killed off as a problem in both Nick's and my=20
> patches. If it still remains it is almost certainly a disk i/o problem (n=
o=20
> dma) or hitting swap memory.

Humm, ok... The only desktop i have where i have switched between O(1)
and common is my laptop... which sadly didn't run either nick or your
work... So i have no comparison with your or nicks work.

> > Well, there is latency and there is latency. To take the AmigaOS
> > example. Voyager, a webbrowser for AmigaOS uses MUI (a fully dynamic gu=
i
> > with weighted(prioritized) sections) and renders images. It's responsiv=
e
> > even on a 40mhz 68040 using Executive with the feedback scheduler.
>=20
> Multiple processors to do different tasks on amigas kinda helped there...

Well, yes, but... Not when it comes to scheduling.

> > 500 mhz is a lot of horsepower when it comes to playing mp3's and
> > scheduling.. It feels like something is wrong when i see all these
> > discussions but i most certainly don't know enough to even begin to
> > understand it. I only tried to show the thing i thought was really wron=
g
> > but you do have a point with the runqueues and timeslices =3DP
>=20
> Things are _never ever ever ever_ as simple as they appear on the surface=
.

If they were... Life would be boring =3DP

--=20
Ian Kumlien <pomac@vapor.com>

--=-dNjwcSkcDtW44blBeNEb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/U8Xr7F3Euyc51N8RAhurAKCF6ZGcB4kHZIo8C0/V8xID+j38YACeIjjb
rQa+tW0GjZBrM1NrvayIPug=
=q06D
-----END PGP SIGNATURE-----

--=-dNjwcSkcDtW44blBeNEb--

