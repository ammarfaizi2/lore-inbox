Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbTIAABi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbTIAABb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:01:31 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:39117
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S263068AbTIAABX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:01:23 -0400
Subject: Re: [SHED] Questions.
From: Ian Kumlien <pomac@vapor.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1062373274.1313.28.camel@boobies.awol.org>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <1062355996.1313.4.camel@boobies.awol.org>
	 <1062358285.5171.101.camel@big.pomac.com>
	 <1062359478.1313.9.camel@boobies.awol.org>
	 <1062369684.9959.166.camel@big.pomac.com>
	 <1062373274.1313.28.camel@boobies.awol.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-stmoaLYopWOvMo+4CbOw"
Message-Id: <1062374409.5171.194.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 01 Sep 2003 02:00:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-stmoaLYopWOvMo+4CbOw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-09-01 at 01:41, Robert Love wrote:
> On Sun, 2003-08-31 at 18:41, Ian Kumlien wrote:
>=20
> > hummm, I assume that a high pri process can preempt a low pri process..=
.
> > The rest sounds sane to me =3D), Please tell me what i'm missing.. =3D)
>=20
> No no.  The rule is "the highest priority process with timeslice
> remaining runs" not just "the highest priority process runs."

Then i'm beginning to agree with the time unit... Large timeslice but in
units for high pri tasks... So that high pri can run (if needed) 2 or 3
times / timeslice.

More like MAX_QUANT_ON_QUEUE/MIN_QUANT or so...=20

> Otherwise, timeslice wouldn't matter much!

Just sounds odd to me.

> When a process exhausts its timeslice, it is moved to the "expired"
> list.  When all currently running tasks expire their timeslice, the
> scheduler begins servicing from the "expired" list (which then becomes
> the "active" list, and the old active list becomes the expired).

Ok, good solution

> This implies that a high priority, which has exhausted its timeslice,
> will not be allowed to run again until _all_ other runnable tasks
> exhaust their timeslice (this ignores the reinsertion into the active
> array of interactive tasks, but that is an optimization that just
> complicates this discussion).

So it's penalised by being in the corner for one go? or just pri
penalised (sounds like it could get a corner from what you wrote... Or
is it time for bed).

> If timeslices did not play a role, then high priority tasks would always
> monopolize the system.

> This is a classic priority-based round-robin scheduler.

> > > Once a task exhausts its timeslice, it cannot run until all other tas=
ks
> > > exhaust their timeslice.  If this were not the case, high priority ta=
sks
> > > could monopolize the system.
> >=20
> > All other? including sleeping?... How many tasks can be assumed to run
> > on the cpu at a time?....
>=20
> I wasn't clear: all other _runnable_ tasks.

Yes, but how many runable tasks would you have on a system in one go,
while maintaining interactivity...
(Ie, what amount would the scheduler actually have to deal with..)

> Once a task "expires" (exhausts its timeslice), it will not run again
> until all other tasks, even those of a lower priority, exhaust their
> timeslice.

Yeah, it seems like my idea would need several run queues with diff
timeslices to make up.

> This is a major difference between normal tasks and real-time tasks.
>=20
> > Should preempt send the new quantum value to all "low pri, high quantum=
"
> > processes?
>=20
> I don't follow this?

Never mind, bad idea, sucky thing... =3DP

> > Damn thats a tough cookie, i still think that the priority inversion is
> > bad. Don't know enough about this to actually provide a solution...=20
> > Any one else that has a view point?
>=20
> Priority inversion is bad, but the priority inversion in this case is
> intended.  Higher priority tasks cannot starve lower ones.  It is a
> classic Unix philosophy that 'all tasks make some forward progress'

Yes, like the feedback scheduler...=20

> If you need to guarantee that a task always runs when runnable, you want
> real-time.

... yes... =3D)

> If you just want to give a scheduling boost, to ensure greater
> runnability, lower latency, and larger timeslices... nice values
> suffice.

nicevalues/pri is always the best way imho.

> > Hummm, the skips in xmms tells me that something is bad..=20
> > (esp since it works perfectly on the previus scheduler)
>=20
> A lot of this is just the interactivity estimator making the wrong
> estimate.

Yes, But... When you come from AmigaOS, and have used Executive...
things like this is dis concerning. Executive is a scheduler addition
for amigaos that has many schedulers to choose from. One of which is the
original feedback scheduler. While a feedback scheduler consumes some
cpu it still allows you to play mp3's while surfing the net on a 50 mhz
68060. Hearing about 500mhz machines that skip is somewhat.. odd.

And afair it has no real interactivity estimator.=20

(If you are interested you can always search for Executive on aminet..
It has several scheduler policies including those that work great on
small machines (25mhz or so))

> > Since it's rescheduled after a short runtime or, might be.
> > From someones mail i saw (afair), there was much more context switches
> > in 2.6 than in 2.4. And each schedule consumes time and cycles.
>=20
> Context switches (as in process to process changes) should be about the
> same?

Apparently they are not... I should have saved the link...

> Interrupt frequency has gone up in x86 (1000 vs 100).  Maybe that is
> what they are seeing.

I dunno, i didn't pay that much attention and i can't find it now =3DP

> > Oh yes, but otoh, if you are really keen on the latency then you'll do
> > realtime =3D)
>=20
> Agreed.  But at the same time, not every "interactive" task should be
> real-time.  In fact, nearly all should not.  I do not want my text
> editor or mailer to be RT, for example.

Well, there is latency and there is latency. To take the AmigaOS
example. Voyager, a webbrowser for AmigaOS uses MUI (a fully dynamic gui
with weighted(prioritized) sections) and renders images. It's responsive
even on a 40mhz 68040 using Executive with the feedback scheduler.

500 mhz is a lot of horsepower when it comes to playing mp3's and
scheduling.. It feels like something is wrong when i see all these
discussions but i most certainly don't know enough to even begin to
understand it. I only tried to show the thing i thought was really wrong
but you do have a point with the runqueues and timeslices =3DP

> They just need a scheduling boost.

imho, that shouldn't really be needed... =3DP
(although executive apparently had a pri boost for active window... I
doubt that i ran with it though... Been a while =3D))

--=20
Ian Kumlien <pomac@vapor.com>

--=-stmoaLYopWOvMo+4CbOw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/UowJ7F3Euyc51N8RAqrFAJ497vvRG9IdB7w5LgeU1UkkEKxu+ACff/45
n/vmALZrOK7ADdrCiBXlrmY=
=6pzS
-----END PGP SIGNATURE-----

--=-stmoaLYopWOvMo+4CbOw--

