Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933020AbWF0JHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933020AbWF0JHd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933026AbWF0JHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:07:33 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:22988 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S933020AbWF0JHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:07:32 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Jens Axboe <axboe@suse.de>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Tue, 27 Jun 2006 19:07:24 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271739.13453.nigel@suspend2.net> <20060627075906.GK22071@suse.de>
In-Reply-To: <20060627075906.GK22071@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2286982.pnzIo7mAKn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606271907.27831.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2286982.pnzIo7mAKn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 17:59, Jens Axboe wrote:
> On Tue, Jun 27 2006, Nigel Cunningham wrote:
> > On Tuesday 27 June 2006 17:05, Jens Axboe wrote:
> > > On Tue, Jun 27 2006, Nigel Cunningham wrote:
> > > > On Tuesday 27 June 2006 15:36, Jens Axboe wrote:
> > > > > On Tue, Jun 27 2006, Nigel Cunningham wrote:
> > > > > > On Tuesday 27 June 2006 07:20, Rafael J. Wysocki wrote:
> > > > > > > On Monday 26 June 2006 18:54, Nigel Cunningham wrote:
> > > > > > > > Add Suspend2 extent support. Extents are used for storing t=
he
> > > > > > > > lists of blocks to which the image will be written, and are
> > > > > > > > stored in the image header for use at resume time.
> > > > > > >
> > > > > > > Could you please put all of the changes in
> > > > > > > kernel/power/extents.c into one patch? =A0It's quite difficul=
t to
> > > > > > > review them now, at least for me.
> > > > > >
> > > > > > I spent a long time splitting them up because I was asked in
> > > > > > previous iterations to break them into manageable chunks. How
> > > > > > about if I were to email you the individual files off line, so =
as
> > > > > > to not send the same amount again?
> > > > >
> > > > > Managable chunks means logical changes go together, one function
> > > > > per diff is really extreme and unreviewable. Support for extents =
is
> > > > > one logical change, so it's one patch. Unless of course you have =
to
> > > > > do some preparatory patches, then you'd do those separately.
> > > > >
> > > > > I must admit I thought you were kidding when I read through this
> > > > > extents patch series, having a single patch just adding includes!
> > > >
> > > > Sorry for fluffing it up. I'm pretty inexperienced, but I'm trying =
to
> > > > follow CodingStyle and all the other advice. If I'd known I'd
> > > > misunderstood what was wanted, I probably could have submitted this
> > > > months ago. Oh well. Live and learn. What would you have me do at
> > > > this point?
> > >
> > > Split up your patches differently, and not in so many steps. Ideally
> > > each step should work and compile, with each introducing some sort of
> > > functionality. Each patch should be reviewable on its own.
> >
> > The difficulty I have there is that suspending to disk doesn't seem to
> > me to be something where you can add a bit at a time like that. I do
> > have proc entries that allow you to say "Just freeze the processes and
> > prepare the metadata, then free it and exit" (freezer_test) and "Do
> > everything but actually writing the image and doing the atomic copy,
> > then exit (test_filter_speed), for diagnosing problems and tuning the
> > configuration, but if I start were to start again with nothing, I'd
> > only write the dynamic pageflags code to start with and submit it
> > (giving you lib/dyn_pageflags.c and kernel/power/pageflags.c), then
> > the refrigerator changes and the extent code and so on. I guess what
> > I'm trying to say is that I'm not mutating swsusp into suspend2 here,
> > and I don't think I can. Suspend2 is a reimplementation of swsusp, not
> > a series of incremental modifications. It uses completely different
> > methods for writing the image, storing the metadata and so on. Until
> > recently, the only thing it shared with swsusp was the refrigerator
> > and driver model calls, and even now the sharing of lowlevel code is
> > only a tiny fraction of all that is done.
>
> You can't split up what isn't composed of multiple things, of course. I
> didn't review your patches (sorry), but if you have changes outside of
> suspend2 itself, then you need to split these out. You could submit
> those patches seperately.

Ok. That I can certainly do, and I can post one patch per file in a logical=
=20
order.

> Now I haven't followed the suspend2 vs swsusp debate very closely, but
> it seems to me that your biggest problem with getting this merged is
> getting consensus on where exactly this is going. Nobody wants two
> different suspend modules in the kernel. So there are two options -
> suspend2 is deemed the way to go, and it gets merged and replaces
> swsusp. Or the other way around - people like swsusp more, and you are
> doomed to maintain suspend2 outside the tree.

Generally, I agree, although my understanding of Rafael and Pavel's mindset=
 is=20
that swsusp is a dead dog and uswsusp is the way they want to see things go=
=2E=20
swsusp is only staying for backwards compatability. If that's the case,=20
perhaps we can just replace swsusp with Suspend2 and let them have their=20
existing interface for uswsusp. Still not ideal, I agree, but it would be=20
progress.

> > Could I ask what might be a dumb question in this regard - why isn't
> > Reiser4 going through the same process? Is it an indication that I
> > shouldn't have submitted these patches and should have just asked
> > Andrew to take Suspend2 into mm, or is there something different
> > between Reiser4 and Suspend2 that I'm missing?
>
> That's not a dumb question at all. reiser4 hasn't been merged for years,
> so you probably don't want to look at that as an example :-)
>
> reiser4 is pretty much a separate entity, so it doesn't make sense so
> split that up much for submission. Core kernel changes (as always) need
> to be split, of course.

Ok. I didn't remember when reiser4 first appeared or how it got into -mm. I=
=20
guess I'm picturing suspend2 as similar because I'm thinking of Suspend2 as=
=20
pretty much a separate subsystem - it's interface to the rest of the kernel=
=20
can be defined in terms of freeze|thaw_processes, drivers_suspend|resume,=20
bmap|submit_bio and I'm imagining the Reiser4 would have a similar sort of=
=20
limited set of functions it uses for interfacing with the rest of the kerne=
l.

Regards,

Nigel

=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2286982.pnzIo7mAKn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoPVPN0y+n1M3mo0RAqKDAKCPVYwTQwCPqjHyQfmy5+fBxNdKggCdH+p9
ER0Vd0XYkXpn4Mq9R0CUpOs=
=Zq7D
-----END PGP SIGNATURE-----

--nextPart2286982.pnzIo7mAKn--
