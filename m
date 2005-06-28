Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVF1UqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVF1UqD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVF1Uno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:43:44 -0400
Received: from nysv.org ([213.157.66.145]:4021 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261606AbVF1Ujv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:39:51 -0400
Date: Tue, 28 Jun 2005 23:39:34 +0300
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Reiser <reiser@namesys.com>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050628203934.GG11013@nysv.org>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB5E1A.70903@namesys.com> <1119609680.17066.81.camel@localhost.localdomain> <20050627091808.GC11013@nysv.org> <42BFCAE7.6070708@yahoo.com.au> <20050627125555.GE11013@nysv.org> <42C09877.90800@yahoo.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s8uQA167RD2xhjBe"
Content-Disposition: inline
In-Reply-To: <42C09877.90800@yahoo.com.au>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s8uQA167RD2xhjBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2005 at 10:23:19AM +1000, Nick Piggin wrote:

>The scheduler interfaces are probably among the most stable
>in the kernel. Con was talking about internal implementation.

Hmm, I'm by no means a kernel developer, but looking at the
patches, it looked like the functions were just renamed and
maybe something else was changed.

I may be totally wrong here, and I apologize in advance if I am,
but it seems to me like there would be no real need in changing
some syntax?

>I get the feeling your friend is making up some tall tales if he
>says he rewrote the networking code to be much better than it is
>now. But I can guarantee him that if he has it will be of great
>interest to the network developers.

Yeah, I just talked this over with him.

[
 IF THIS IS BULLSHIT, LET ME KNOW AND I'LL CORRECT HIM ;)
 POINTERS TO RELEVANT DOCUMENTATION ALSO WELCOME ;)
]

His grudge was that conntrack was used everywhere, not like
in 2.4, with a slow lookup in proc, that made it unusable
for large nat systems.

They wrote some reimplementation of the lookup part, which
they didn't release.

Then they figured out how to capture the packets before
reaching conntrack and doing some mojo on them and reinjecting
them somewhere later or bypassing conntrack altogether.

However, his opinions were even less motivated than mine,
it seems, as he didn't have anything except some ipfilter
archives he read, where they cursed the Linux way of
doing things.

I haven't looked all too deeply into the network part, though,
as I'm starting to get lazy and like to have a separate,
dedicated piece of hardware do the network stuff for me...

So maybe I should just retract my comments and look into
every possible subsystem's development and see for myself,
which I don't have time for :)

>I'm pretty sure it isn't a scheduler slowdown, but rather the
>system is getting disk bound. I think the reporter has
>performance back to 2.6.10 levels - it is actually something I
>still have to follow up on, but it is difficult because the
>reporter isn't able to share his code, although he's otherwise
>very helpful.

It's just that for cases like these testing would be great.

I'm not really sure how to do it, though, as it would require
a lot of hardware and time and someone who can write a decent
test suite.

If anyone has links to good test suites, I'm all ears :)

So, any chances of something being messed up in the disk
part of the code?

=2E..Too bad I just heard a big slowdown-in-disk-i/o curse
was caused by dma falling off, for whatever reason (bug?)
so that can't be used as forensics either :P

>If slowdowns do get merged, it is generally because they either
>haven't been reported until being merged or they make an accepted
>tradeoff. Not that they haven't been tested.
>
>Let's just get this straight, no amount of QA other than releasing
>a kernel and asking people to use it is going to find all the bugs
>that will be encountered.

Would you think a separate dev tree would help here?

I've also talked long with a guy from one of our major customers
who says he's been losing faith in Linux over the past year, as
his boxes are going oops or panicking every once in a while.

The problem is that their system is too redundantly set up for
a single oops or panic to matter much, so I haven't convinced them
to report bugs. They'd rather boot the boxes and curse.

He just figured it odd that this started happening after the new
dev model, but the timelines are too granular for a real correlation.
Just a strong gut feeling, and that's the kind of FUD that makes
people look to *BSD, and a gut feeling that may have some merit
to it, although it could never be proven. So don't take that
as a flame or anything, just an observation :P

Sure it must be difficult developing the kernel, if it were easier,
I'd probably be at it too, but people don't like not being well
informed of accepted tradeoffs, as they might not accept said
tradeoff, and tracking what caused it may be too much.

A lot of people out there don't like vendor kernels either,
with 65536 backported patches and the 65537th voids your warranty.

It's also probably very difficult to do analytical QA before
submitting code, as bugs ALWAYS run through.

But my gut tells me this -mm thing may not be the optimal way,
as people are more scared of -mm, where some things may or
may not work, than a separate dev tree, of which kerneltrap
or whoever can post "this is severely broken, test if you like"
and "this seems to be going mostly strong now, test it on your
everyday desktop"

A lot of complaints seem to come from people who use=20
patchsets with half-assed backports and experimental code,
having a separate tree may drive these people to use
the experimental stuff knowing what it is, instead of
believing their patch set is as good as vanilla.

>I mostly agree with you apart from your specific examples I think
>we could do things better, and most of us have made some big blunders,
>However there is just no way that bringing any of that up will help
>Reiser4 being merged.

Myeah, if I try to keep it a bit more on topic, I'm just saying that
Reiser4 (sans metas) has been heavily tested, and now that the
Namesys guys are apparently beautifying the code, we should be
good with everything.

Still, this is an instinct, but it seems like the bigger VFS
overhauls would be easier to do in an official dev tree with
a big note saying "THIS WILL BE BROKEN FOR A MONTH."

If this was the case, so bad that people couldn't develop=20
anything with the dev tree, it would probably be easier to=20
maintain a rollback-vfs-changes patch than constantly keeping=20
in sync with -mm.

That method could be used for every system undergoing extensive
work that shows up in other systems.

The difference may not be big, but it may be enough.

Thanks!

--=20
mjt


--s8uQA167RD2xhjBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCwbWGIqNMpVm8OhwRAmeFAJ9frvYgBnaWqZA1BZw90irYwWQuNwCgz5Fe
YCGchWeI9w4+xQ9Z4FxA3Xk=
=WAeL
-----END PGP SIGNATURE-----

--s8uQA167RD2xhjBe--
