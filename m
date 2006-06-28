Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbWF1XPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWF1XPG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWF1XPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:15:05 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:17820 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751768AbWF1XPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:15:03 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Thu, 29 Jun 2006 09:14:54 +1000
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, Jens Axboe <axboe@suse.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606290825.50674.nigel@suspend2.net> <20060628224428.GC27526@elf.ucw.cz>
In-Reply-To: <20060628224428.GC27526@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5908876.fcCl1guKX0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606290914.58784.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5908876.fcCl1guKX0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 29 June 2006 08:44, Pavel Machek wrote:
> Hi!
>
> > > > > So I don't really see the future of suspend2 because of this...
> > > >
> > > > But what Rafael and Pavel are doing is really only moving the highe=
st
> > > > level of controlling logic to userspace (ok, and maybe compression
> > > > and encryption too). Everything important (freezing other processes,
> > > > atomic copy and the guts of the I/O) is still done by the kernel.
> > >
> > > Can you do the same and move compression/encryption to userspace, too?
> > >
> > > And actually that "highest level" covers >50% of suspend2 code. That
> > > would be around 7K lines of code removed from kernel if you did the
> > > same, and suspend2 patch would be half the size...
> >
> > That's not true. The compression and encryption support add ~1000 lines,
> > as you pointed out the other day. If I moved compression and encryption
> > support to userspace, I'd remove 1000 lines and:
> >
> > - add more code for getting the pages copied to and from userspace
>
> No, if your main loop is already in userspace, you do not need to add
> any more code. And you'd save way more than 1000 lines:
>
> * encryption/compression can be removed
>
> * but that means that writer plugins/filters can be removed
>
> * if you do compress/encrypt in userspace, you can remove that ugly
> netlink thingie, and just display progress in userspace, too
>
> ...and then, image writing can be moved to userspace...
>
> * swapfile support
>
> * partition support
>
> * plus their plugin infrastructure.

That's going way beyond your inital suggestion. And you haven't responded t=
o=20
the other points (which have instead been deleted).

> > > > If we take the problem one step further, and begin to think about
> > > > checkpointing, they're in even bigger trouble. I'll freely admit th=
at
> > > > I'd have to redesign the way I store data so that random parts of t=
he
> > > > image could be replaced, have hooks in mm to be able to learn what
> > > > pages need have changed and would also need filesystem support to
> > > > handle that part of the problem, but I'd at least be working in the
> > > > right domain.
> > >
> > > Could you explain? I do not get the checkpointing remark.
> >
> > Sure. Suspending to disk is a pretty similar problem to checkpointing,
> > except that you want to continue running afterwards, keep the image and
> > modify it from time to time based on the changes in memory (having a
> > checkpointing filesystem too, of course). My point is that modifying
> > uswsusp to do checkpointing would be far harder precisely because you've
> > pushed the highest level logic to userspace. It would be far more
> > complicated, if not impossible for you to make the adjustments to do
> > checkpointing.
>
> Aha, that's probably better done with Xen, anyway :-).

Well, if you're going to put it in the too hard basket, it will have to be.

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart5908876.fcCl1guKX0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEow1yN0y+n1M3mo0RAgM4AJ9UfKt+umrAQU9njtsLNBOksrtSgwCg86yI
WHaGhzPilupfUFn7Pix6ISU=
=lFkJ
-----END PGP SIGNATURE-----

--nextPart5908876.fcCl1guKX0--
