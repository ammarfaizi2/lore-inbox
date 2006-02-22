Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWBVWoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWBVWoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWBVWoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:44:07 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:36517 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751563AbWBVWoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:44:05 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Thu, 23 Feb 2006 08:41:06 +1000
User-Agent: KMail/1.9.1
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602220947.44506.ncunningham@cyclades.com> <200602221949.31933.rjw@sisk.pl>
In-Reply-To: <200602221949.31933.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1975720.7IOlHTZi9H";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602230841.10227.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1975720.7IOlHTZi9H
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 23 February 2006 04:49, Rafael J. Wysocki wrote:
> > > Frankly, I didn't think of dropping PBEs right now, but in the long r=
un
> > > that's worth considering, IMO.  The advantage of PBEs is that they are
> > > easy to handle in the assembly parts, but apart from this they are a
> > > bit wasteful (not very much, though).
> >
> > Fully agree. That's why I've sought to keep the copying in c - it makes
> > it simpler to read and maintain (although at the expense of a little bit
> > of ugliness with that if in the stack page allocation
>
> Well, that's a bit too much ugliness for me, sorry.
>
> > or (old way) working hard to make the C not use stack).
>
> I'd rather not get rid of the assembly parts.  Instead, I'd modify them to
> handle bitmaps.  I'm not going to drop them.

Well, if you do this, and I can, I will start using the code too. I don't k=
now=20
x86/x86_64/ppc/... assembly enough that I could help, but I would be willin=
g=20
to drop the current code if yours was usable. Come to that, (as I already=20
said), I'm willing to work on switching to pbes prior to that and seeing if=
=20
we can share that code earlier, if you want me to and I can find the time.

> > > The fact that we use page flags to store some suspend/resume-related
> > > information is a big disadvantage in my view, and I'd like to get rid
> > > of that in the future.  In principle we could use a bitmap, or rather
> > > two of them, to store the same information independently of the page
> > > flags, and if we use bitmaps for this purpose, we can use them also
> > > instead of PBEs.
> >
> > If you use the 'dynamically allocated pageflags' code (sure, pick a
> > better name if you want), these changes will be pretty trivial - you can
> > #define macros that could make the transition just a matter of switching
> > PageNosave (eg) to PageSomethingElse. (Ditto for setting and clearing
> > flags).
>
> I think it could be done without that code and I'd prefer to do so.  In
> fact, we only need to remember:
> (a) saveable pages
> (b) pages used to store the data from (a)
> (c) pages allocated by us that we should release eventually
> (generally that may be a broader set than just (b)).
> That's 3 bitmaps total and no need for using any more sophisticated stuff,
> if I remember everything correctly.

Maybe I have tunnel vision, but I'd be surprised if you didn't end up with=
=20
something similar - I've tried to make it as simple as possible, and am=20
basically doing the same thing (even if I'm using different terms for some =
of=20
the concepts). I'd certainly be willing to interact on "Why did you do it=20
this way?" questions and make changes if a better way is shown to me.

> > > At this point I'd have to look at your snapshot-related code and see =
if
> > > it's suitable for snapshot.c (in -mm now) somehow.  If you could point
> > > me to the specific parts of the suspend2 patch where this code is, I'd
> > > be grateful.
> >
> > Sure. The bulk is in kernel/power/atomic_copy.c. Arch specific routines
> > are include/asm-<arch>/suspend2.h.
>
> OK, thanks.

Thank you! I much prefer this kind of interaction. It's far more constructi=
ve.

Nigel

--nextPart1975720.7IOlHTZi9H
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/OiGN0y+n1M3mo0RAupkAJ4287WLvTdHuvAh+NASqoRupybjwwCgzXOc
GjyjqUxmThDD0QgdC9SVIpw=
=N85S
-----END PGP SIGNATURE-----

--nextPart1975720.7IOlHTZi9H--
