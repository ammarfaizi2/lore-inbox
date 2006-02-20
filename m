Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWBTA2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWBTA2R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWBTA2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:28:17 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:61122 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751125AbWBTA2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:28:16 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 10:24:57 +1000
User-Agent: KMail/1.9.1
Cc: Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602200709.17955.nigel@suspend2.net> <20060219212952.GI15311@elf.ucw.cz>
In-Reply-To: <20060219212952.GI15311@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4182184.XGEJ7lCOTE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602201025.01823.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4182184.XGEJ7lCOTE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 20 February 2006 07:29, Pavel Machek wrote:
> Hi!
>
> > > swsusp is also available today, and works better than you think. It is
> > > slightly slower, but has all the other
> > > features you listed in 2.6.16-rc3.
> >
> > It is a lot slower because it does all it's I/O synchronously, doesn't
> > compress the image and throws away memory until at least half is
> > free.
>
> uswsusp does compress image (20% speedup, in recent CVS) and do
> asynchronous I/O.

Only 20? You must be doing something horribly wrong. Asynchronous I/O shoud=
l=20
get the speed from whatever you're getting without it to the maximum the=20
drive can handle. LZF should double the speed again on a CPU that's fast=20
enough that the bottleneck is the disk.

> > > > The only con I see is the complexity of the code, but then again,
> > > > Nigel
> > >
> > > ..but thats a big con.
> >
> > It's fud. Hopefully as I post more suspend2 patches to LKML, people will
> > see that Suspend2 is simpler than what you are planning.
>
> For what I'm planning, all the neccessary patches are already in -mm
> tree. And they are *really* simple. If you can get suspend2 to 1000
> lines of code (like Rafael did with uswsusp), we can have something to
> talk about.

Turn it round the right way. If you can get the functionality of Suspend2=20
using userspace only, then we have something to talk about.

> > > > From a user, and contributor, point of view, I really do not
> > > > understand why not even trying to push a working implementation into
> > > > mainline (I know that you cannot just apply the Suspend 2 patches a=
nd
> > > > shipping it,
> > >
> > > It is less work to port suspend2's features into userspace than to ma=
ke
> > > suspend2 acceptable to mainline. Both will mean big changes, and may
> > > cause some short-term problems, but it will be less pain than
> > > maintaining suspend2 forever. Please help with the former...
> >
> > That's not true. I've taken time to look at what would be involved in
> > making suspend2 match the changes you're doing, and I've decided it's
> > just not worth the effort.
> >
> > Let's be clear. uswsusp is not really moving suspend-to-disk to
> > userspace. What it is doing is leaving everything but some code for
> > writing the image in kernel space, and implementing ioctls to give a
> > userspace program the ability to request that other processes be frozen,
> > the snapshot prepared and so on. Pages in the snapshot are copied to
> > userspace, possibly compressed or encrypted there in future, then fed
> > back to kernel space so it can use the swap routines to do the writing.
> > Very little of substance is being done in userspace. In short, all it's
> > doing is adding the complexity of
>
> Maybe very little of substance is being done in userspace, but all the
> uglyness can stay there. I no longer need LZF in kernel, special
> netlink API for progress bar (progress bar naturally lives in
> userland), no plugin infrastructure needed, etc.

And you do need?...

> If you can do suspend2 without putting stuff listed above into kernel,
> and in acceptable ammount of code... we can see. But you should really
> put suspend2 code into userspace, and be done with that. Feel free to
> spam l-k a bit more, but using existing infrastructure in -mm is right
> way to go, and it is easier, too.

It is only easier because you're not comparing apples with apples. I have n=
o=20
desire to spam LKML with this pointless discussion, so I'm just going to ge=
t=20
on with submitting patches for review.

Rgards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart4182184.XGEJ7lCOTE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+QxdN0y+n1M3mo0RAvrFAJ9L/qmF8OBRrONL8hE34/+MHpg+PwCfTvHF
aq8c0oxH1z/StEsynVXoD1A=
=sSEb
-----END PGP SIGNATURE-----

--nextPart4182184.XGEJ7lCOTE--
