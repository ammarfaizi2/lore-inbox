Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVBURRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVBURRP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 12:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVBURRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 12:17:14 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:7612 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262043AbVBURQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 12:16:28 -0500
Subject: Re: [rsbac] Thoughts on the "No Linux Security Modules framework"
	old claims
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: RSBAC Discussion and Announcements <rsbac@rsbac.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
In-Reply-To: <200502211119.24845.ao@rsbac.org>
References: <1108507089.3826.83.camel@localhost.localdomain>
	 <200502211119.24845.ao@rsbac.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QRx/cjt8oYrxsltvMphZ"
Date: Mon, 21 Feb 2005 18:15:51 +0100
Message-Id: <1109006151.4100.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QRx/cjt8oYrxsltvMphZ
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 21-02-2005 a las 11:19 +0100, Amon Ott escribi=F3:
> Hi folks,
>=20
> this is a late reply, because I was away for a week

Hey ao, I was looking for you last week, nice to know you're back
again ;)

>=20
> Documentation is a general problem in all projects, not only the=20
> kernel. For me, this has never been an issue against LSM, although=20
> some things, especially the weird stacking, should be documented to=20
> avoid errors in implementation.

Yes, I definitely agree with this, it's just that there's a need of
people being able to contribute to it and have something done.=20

> I strongly object against the "no overhead" argument, as I did many=20
> times before. Overhead should be low, and it can be. Security comes=20
> with some costs - you can either say "minimize overhead at all=20
> costs", "maximize security at all costs", or try to make a good=20
> balance. IMHO, the first has been selected as a guide for LSM to get=20
> it accepted for mainline, which I still regard as a bad decision.

Anyways, LSM does *not* provide the solution itself, so, commenting that
the framework achieved such following the point 1 it's not completely
accurate.
It's just the *way* to deploy such security, unless you *deply and
implement* something following such *way*.
The costs come when you stop using the framework itself and making use
of a solution that relies in it, then the overhead it's a thing in
charge of the people who use and design the solution.

> As pointed out in another reply, the actual real world overhead is=20
> pretty small - even with more extensive and data gathering hooks like=20
> those of RSBAC. Even making MAC decisions with logging checks before=20
> the Linux DAC decisions should be acceptable, because in almost all=20
> cases access will be granted anyway, so the order of calls does not=20
> matter.

I agree, but it depends on what do you want to achieve with such use of
checks and logics.
=20
> This is a portability issue, these interfaces are very Linux specific,=20
> some are even kernel version specific. The good old syscall is very=20
> portable, and you can use a dispatcher to march dozens of calls=20
> through this.

Of course many interfaces are Linux specific, that's how they wanted to
do them :)
But, for example, this wasn't a reason to stop the effort to port
SELinux functionalities to FreeBSD by the TrustedBSD project.

Maybe it's not all the big the problem seems to be, or at least I hope.

> There is a separate auditing subsystem now, but this was not my point.=20
> Access decisions can be logged where they happen, or in some central=20
> dispatcher.

If it achieves the goal that you remark, why you should care on how
exactly auditing happens within the framework if you are going to
externally make use of such features?

> Some people even want to override DAC, because it is quite limited. I=20
> agree that this is dangerous - overriding should be off by default,=20
> and there must be a big warning.

Yes, but adding such checks add further overhead and if they are
implmented in a dirty-#if-#etc manner, then it's not up for mainline,
AFAIK, but this should be commented by an "official" kernel folk.

> Actually, in RSBAC you have separate decisions for every active=20
> decision module - up to 13 decisions for each request, plus the=20
> runtime loaded modules registered through the REG facility. This is=20
> not a problem, if it gives you a real benefit. My usual configuration=20
> has 7 modules active, and the overhead is still low.

Yes, but again, it depends if we are talking about high scalability
systems or whatever uncommon-for-us (at least me, :P) environment.
Then the lowest overhead can't be acceptable.

> No, they do not override LSM checks - they cannot grant access, if LSM=20
> wants to deny it.

I mean that it depends on when the LSM hook is called, if before or
after the DAC checks.

> There are cases where Linux DAC and MAC cannot live happily together,=20
> because Linux DAC is too limited.

Agreed.

> Again, I disagree. If you look at the age old discussion RSBAC vs.=20
> SELinux between Stephen Smalley and me, he criticized that even the=20
> few structures available in RSBAC hooks were dangerous.
>=20
> Now LSM exposes many, many more of them, and expects modules to use=20
> them directly. Most RSBAC modules work without ever touching the few=20
> structures.

It depends on which scope you're talking about.
=46rom rom the side of the developer, it's a thing in charge of such developer
to bother with them with care.

> It is easy to freeze the kernel, but it is much easier, if you must=20
> access lots of structures under locking conditions you do not know=20
> about (and which might change between kernel versions).

I agree with you with that point, anyways, that's a point I can't talk
further.

> The stacking problem is a direct consequence of the design with=20
> distributed single user hooks. It has been criticized from the very=20
> beginning and since then people have been trying to solve it.
>=20
> Another big problem is that there is only one pointer at some kernel=20
> structures for attribute data - which module is allowed to use this?=20
> The first? Any? How do you know whether it is used or not?
> =20

I'm not someone really concerned about the stacking issue as I notice in
my first email, but regarding your structures-related comment.. for
example task_struct or others? normally the structures are defined in a
manner that they can access properties members of other structures (ie.
inode) or make use of globally available structures (ie. current).
What you can't do is to initialize them without knowing if they are
already initialized and so on, again this is more related with developer
side than a weak implementation.

>=20
> Without rechecking the current state: At least the last time I=20
> checked, the hardwired kernel capabilities were explicitely disabled=20
> when LSM got switched on. You had to use the capabilities LSM module=20
> instead, which was not able to stack. It always had to be the last in=20
> the chain, thus effectively sealing against any other LSM module to=20
> be loaded later.
>=20

Yes, it gets registered as primary but you can pass a disabling argument
to it so it wouldn't prevent you for making use of other modules.
(ie. SELinux uses another "slot").

> You completely missed my point: The first LSM module decides, whether=20
> to call all the others or not, and so on through the chain. Most LSM=20
> modules do not call the others, if they want to deny access=20
> themselves.

I agree with you, but going back to stacking issue then this is just a
consequence.

> This works fine with stateless security models, but it gives you a=20
> hell of a pain for a stateful model - or with non-access control=20
> modules, e.g. for virus scanners, which always want to check even for=20
> denied accesses.

Haven't worked out such features, but will notice after I do it :)

> Well, this "personal" and the other problems happen to make LSM=20
> unusable for RSBAC, GRSecurity and others.

Yes, it's a personal remark.

> The split code argument has another, severe variant:
>=20
> As all hooks stand independent beside each other and there is no=20
> central decision function, you can never be sure that your LSM module=20
> catches all relevant events in a given kernel version - unless you=20
> inspect every kernel version and either add lots of #ifdefs, or=20
> restrict your module to one single kernel version.

Yes, that's maintenance overhead but again a thing that can be solved
with collaboration between both independent developers and the kernel
folks.

> The problem is getting worse (again) with stacking - you can never be=20
> sure, that you pass all relevant events to the modules registered=20
> after yours.
> The concept behind the central function is the "reference monitor", a=20
> central component, which is guaranteed to get requests for all=20
> accesses to make access control decisions.
>=20

I agree, the point is that a good stacking design can solve most of
these issues AFAIK.

> Sorry, but unfortunately, security is usually more complex than what=20
> most children can comprehend. A simple interface does not=20
> automatically make its usage simple. The side effects with locking=20
> and races can be severe.

:)
I agree, just didn't wanted to enter into a *real* political flame on
what security can mean for me or others.

> Again, this was not my point. For decisions in most real security=20
> models, you need some metadata. You can gather this in the hooks, and=20
> thus avoid direct kernel data structure access, or gather it in the=20
> decision logic. If you do the latter, you have to redo the gathering=20
> in the post call - with possibly different results because of=20
> parallel processes.

Yes.

> > -> 9. Amount of Work
> >=20
> > Again it's a personal remark, not objective.
> > At least from my point of view, I've needed less time to achieve the
> > same goal by using the LSM framework.
>=20
> What where your goals? Did you have a complete, more extensive=20
> infrastructure, which you had to change to LSM? What models did you=20
> implement?

I didn't re-invented the wheel, didn't needed to change anything within
the LSM framework (at least talking about MAC for example), etc.
I hadn't time to implement further models, but I will give some a try
after I get finished some personal stuff.

> Your guess is wrong, I was hinting more at SELinux than at Immunix=20
> here. My statements were political, because many decisions look very=20
> political. And, as explicitely written, they presented my personal=20
> impressions on the whole process.

It was a good bunch of all of them, just supposed you were talking on
Immunix.

> When this happened, it seemed clear, that after selling the patents=20
> anything could happen. Think of SCO and how they hindered Linux, and=20
> then rethink what problems might appear with clearly accepted patents=20
> all over the business and in various distributions.
>=20
> Well, I am sure most people here agree that software patents are bad=20
> for free software, so let's not dig into this.

Sure ;)

> Companies are there to make money, not to provide public benefits.=20
> Sad, but true.

I can't disagree with this one, but sometimes licenses make companies
doing things they even don't like, which are of our own benefit.

> I appreciate you continued struggle against us thick headed developers=20
> to get a better common solution.=20

Just trying to help and make noise around, wondering if something comes
up :)

> Still, some problems are deeper than=20
> they appear, and you will often have politics or even massive company=20
> interests involved.

Yes, sadly.
Anyways, it's only a matter of politics, but a really difficult one.

Cheers and many thanks for your comments,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-QRx/cjt8oYrxsltvMphZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCGhdHDcEopW8rLewRAm16AJ412Y9rolQK5lINqAmDDoQID3hTUgCgsPur
nw8anQ3+MKTHgkaT9XVxfjY=
=T01X
-----END PGP SIGNATURE-----

--=-QRx/cjt8oYrxsltvMphZ--

