Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbWF1X1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWF1X1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWF1X1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:27:07 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:58526 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751777AbWF1X1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:27:06 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Thu, 29 Jun 2006 09:26:58 +1000
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606280947.58916.nigel@suspend2.net> <200606290035.12177.rjw@sisk.pl>
In-Reply-To: <200606290035.12177.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2812188.PkgrgeXlcR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606290927.02181.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2812188.PkgrgeXlcR
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 29 June 2006 08:35, Rafael J. Wysocki wrote:
> On Wednesday 28 June 2006 01:47, Nigel Cunningham wrote:
> > On Wednesday 28 June 2006 08:19, Rafael J. Wysocki wrote:
> > > On Tuesday 27 June 2006 11:35, Nigel Cunningham wrote:
> > > > On Tuesday 27 June 2006 19:26, Rafael J. Wysocki wrote:
> > > > > > > Now I haven't followed the suspend2 vs swsusp debate very
> > > > > > > closely, but it seems to me that your biggest problem with
> > > > > > > getting this merged is getting consensus on where exactly this
> > > > > > > is going. Nobody wants two different suspend modules in the
> > > > > > > kernel. So there are two options - suspend2 is deemed the way
> > > > > > > to go, and it gets merged and replaces swsusp. Or the other w=
ay
> > > > > > > around - people like swsusp more, and you are doomed to
> > > > > > > maintain suspend2 outside the tree.
> > > > > >
> > > > > > Generally, I agree, although my understanding of Rafael and
> > > > > > Pavel's mindset is that swsusp is a dead dog and uswsusp is the
> > > > > > way they want to see things go. swsusp is only staying for
> > > > > > backwards compatability. If that's the case, perhaps we can just
> > > > > > replace swsusp with Suspend2 and let them have their existing
> > > > > > interface for uswsusp. Still not ideal, I agree, but it would be
> > > > > > progress.
> > > > >
> > > > > Well, ususpend needs some core functionality to be provided by the
> > > > > kernel, like freezing/thawing processes (this is also used by the
> > > > > STR), snapshotting the system memory.  These should be shared with
> > > > > the in-kernel suspend, be it swsusp or suspend2.
> > > >
> > > > If I modify suspend2 so that from now on it replaces swsusp, using
> > > > noresume, resume=3D and echo disk > /sys/power/state in a way that's
> > > > backward compatible with swsusp and doesn't interfere with uswsusp
> > > > support, would you be happy? IIRC, Pavel has said in the past he
> > > > wishes I'd just do that, but he's not you of course.
> > >
> > > That depends on how it's done.  For sure, I wouldn't like it to be do=
ne
> > > in the "everything at once" manner.
> >
> > I'm not sure I get what you're saying. Do you mean you'd prefer them to
> > coexist for a time in mainline? If so, I'd point out that suspend2 uses
> > different parameters at the moment precisely so they can coexist, so th=
at
> > wouldn't be any change.
>
> No, I'd like it to be done in small steps.  Actually as small as possible,
> so that it's always clear what we are going to do and why.
>
> If you want to start right now, please submit a bdevs freezing patch
> without any non-essential additions.

Well, I admit that I'd far prefer to work with you than Pavel, but aren't w=
e=20
still just going to reach a point where you say "But that should be done in=
=20
userspace" and I say "But I disagree that userspace is the right place for=
=20
suspend to disk" and we stalemate? What then? It seems that I've already=20
wasted a lot of effort listening to requests to split Suspend2 up into=20
digestable chunks for review, only to find that they're not the digestable=
=20
chunks people wanted to digest. I don't want to spent my time slicing and=20
dicing in another way, only to find that the customer doesn't like that mea=
l=20
presentation either.

Can't we instead do what we started to do with the pageflags support? That =
is,=20
look at the files one at a time, beginning with those that implement the mo=
re=20
primitive functions, such as pageflags and extents and the like, verifying=
=20
that they're implemented ok. Then progress to the higher level functions an=
d=20
check that they combine the primitives together okay, and so on. Or (if you=
=20
prefer), do the reverse, beginning with suspend.c and progressing down into=
=20
the details?

I guess the other question is, at the end of this, do you have to understan=
d=20
perfectly and completely how Suspend2 works? If not, are there things I cou=
ld=20
do to help? (Straight off, it occurs to me that I should get around to=20
completing and updating the Documentation - it might help you a lot).

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2812188.PkgrgeXlcR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoxBGN0y+n1M3mo0RAo/wAKDRj8chuYO/8VamwZJw9xbOceoutwCgznKz
1cxkNpuvbRMhem9l0ap+Qsc=
=yJQH
-----END PGP SIGNATURE-----

--nextPart2812188.PkgrgeXlcR--
