Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTHaLoo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 07:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTHaLoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 07:44:44 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:49068
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S261226AbTHaLok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 07:44:40 -0400
Subject: Re: [SHED] Questions.
From: Ian Kumlien <pomac@vapor.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F51DC86.8040800@cyberone.com.au>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <3F51CB44.3080805@cyberone.com.au> <1062325465.5171.60.camel@big.pomac.com>
	 <3F51D0BD.8030307@cyberone.com.au> <1062326980.9959.65.camel@big.pomac.com>
	 <3F51D4A4.4090501@cyberone.com.au> <1062328131.5171.77.camel@big.pomac.com>
	 <3F51DC86.8040800@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FyzcOs0fdCoFG/kCGrt3"
Message-Id: <1062330208.9959.87.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 31 Aug 2003 13:43:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FyzcOs0fdCoFG/kCGrt3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-08-31 at 13:31, Nick Piggin wrote:
> Ian Kumlien wrote:
>=20
> >[Forgot to CC LKML last time, so i didn't remove old text ]
> >
> >On Sun, 2003-08-31 at 12:57, Nick Piggin wrote:
> >
> >
> >>Heh, well we discuss stuff sometimes, but we disagree on things.
> >>Which is a good thing because now our eggs are in two baskets.
> >>
> >
> >Yes, but sometimes it feels like a merger would be better... As long as
> >the propper quantum usage prevails =3D)

> Nope. They're going in different directions. We'd slow each other down.

Okis.

> >>Yeah quite a lot. Lots included removing the interactivity stuff.
> >>
> >
> >Humm, yeah, that should work automatically with the "used the full
> >quantum" if thats still in that is... =3D)
> >
>=20
> You've lost me here.
> My stuff is the opposite of what the interactivity stuff is trying
> to do. The interactivity stuff _does_ kind of implement variable
> timeslices in the form of re queueing stuff. I think it would be a
> nightmare for them to put my variable timeslices on top of that and
> then get it to all work properly.

Well, i dunno how your patch works (i forget =3D))... But afair ingos
interactivity patches was about the amount of the quantum that was used.
And combining that with high =3D small and low =3D large would automaticall=
y
balance the priorities accordingly.

> >>Yeah it is, but the process will still take a lot of the penalty,
> >>and if it is using a lot of CPU in context switching, then it will
> >>get a lower priority anyway. Possibly there could be a very small
> >>additional penalty per context switch, but so far it hasn't been
> >>a big problem AFAIK.
> >>
> >
> >Well my idea was more... The highest pri gets MIN_QUANT and a preemt
> >can't happen faster than MIN_QUANT or so..=20
> >
>=20
> My idea is to try to make it as simple as possible, and no
> simpler (as a great man put it!). So more is less if you
> know what I mean.

Yup =3D)

> I think this is going against how the scheduler (and UNIX
> schedulers in general) have generally behaved. Its very likely
> that you'd be better off fixing your app / other broken bit
> of kernel code though.
>=20
> I don't know... maybe...

Humm i thought more in the direction of:
Preempt prior to MIN_QUANT being used -> put it on the runqueue as the
next process being scheduled, change the running tasks timeslice ->
continue with current task.

(make the current tasks timeslice appear as used.)

> >If i remember correctly, 2.6 spends much more time doing the actual
> >context switches (not time / context switch but amount during this
> >period). The new 1000 HZ thingy doesn't have to have that effect...
> >
> >And since to many context switches are inefficient imho, some standoffs
> >would be good =3D)
> >
>=20
> I'm not sure. I think the 1000HZ thing is mainly from timer interrupts.
> The scheduler should be pretty well agnostic to the 100->1000 change,
> other than having higher resolution. Increased context switches might
> indicate something is not being scaled with HZ properly though.

hummm i dunno, but afair the scheduler uses that timing aswell...=20

> Yes context switches are inefficient. The tradeoff is vs scheduling
> latency and there is no way around that.

Thus, keeping preempt from being able to preempt other tasks prior to
MIN_QUANT being used is bad.. =3D)

Which also might fix the "child preempting parent on fork" problem that
con patched afair.
(dunno if you have the same problem though...)

--=20
Ian Kumlien <pomac@vapor.com>

--=-FyzcOs0fdCoFG/kCGrt3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Ud9g7F3Euyc51N8RAg8iAJ9Wdg5VUt4BoOwmyjS8TYReQM1MyACdHIY3
X3mFag0EamA0BZ3F3GFmE1E=
=aOU5
-----END PGP SIGNATURE-----

--=-FyzcOs0fdCoFG/kCGrt3--

