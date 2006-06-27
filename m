Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWF0HjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWF0HjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbWF0HjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:39:17 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:26301 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161027AbWF0HjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:39:16 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Jens Axboe <axboe@suse.de>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Tue, 27 Jun 2006 17:39:10 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271539.29540.nigel@suspend2.net> <20060627070505.GH22071@suse.de>
In-Reply-To: <20060627070505.GH22071@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7303281.tbUgj668hl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606271739.13453.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7303281.tbUgj668hl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 17:05, Jens Axboe wrote:
> On Tue, Jun 27 2006, Nigel Cunningham wrote:
> > On Tuesday 27 June 2006 15:36, Jens Axboe wrote:
> > > On Tue, Jun 27 2006, Nigel Cunningham wrote:
> > > > On Tuesday 27 June 2006 07:20, Rafael J. Wysocki wrote:
> > > > > On Monday 26 June 2006 18:54, Nigel Cunningham wrote:
> > > > > > Add Suspend2 extent support. Extents are used for storing the
> > > > > > lists of blocks to which the image will be written, and are
> > > > > > stored in the image header for use at resume time.
> > > > >
> > > > > Could you please put all of the changes in kernel/power/extents.c
> > > > > into one patch? =A0It's quite difficult to review them now, at le=
ast
> > > > > for me.
> > > >
> > > > I spent a long time splitting them up because I was asked in previo=
us
> > > > iterations to break them into manageable chunks. How about if I were
> > > > to email you the individual files off line, so as to not send the
> > > > same amount again?
> > >
> > > Managable chunks means logical changes go together, one function per
> > > diff is really extreme and unreviewable. Support for extents is one
> > > logical change, so it's one patch. Unless of course you have to do so=
me
> > > preparatory patches, then you'd do those separately.
> > >
> > > I must admit I thought you were kidding when I read through this
> > > extents patch series, having a single patch just adding includes!
> >
> > Sorry for fluffing it up. I'm pretty inexperienced, but I'm trying to
> > follow CodingStyle and all the other advice. If I'd known I'd
> > misunderstood what was wanted, I probably could have submitted this
> > months ago. Oh well. Live and learn. What would you have me do at this
> > point?
>
> Split up your patches differently, and not in so many steps. Ideally
> each step should work and compile, with each introducing some sort of
> functionality. Each patch should be reviewable on its own.

The difficulty I have there is that suspending to disk doesn't seem to me t=
o=20
be something where you can add a bit at a time like that. I do have proc=20
entries that allow you to say "Just freeze the processes and prepare the=20
metadata, then free it and exit" (freezer_test) and "Do everything but=20
actually writing the image and doing the atomic copy, then exit=20
(test_filter_speed), for diagnosing problems and tuning the configuration,=
=20
but if I start were to start again with nothing, I'd only write the dynamic=
=20
pageflags code to start with and submit it (giving you lib/dyn_pageflags.c=
=20
and kernel/power/pageflags.c), then the refrigerator changes and the extent=
=20
code and so on. I guess what I'm trying to say is that I'm not mutating=20
swsusp into suspend2 here, and I don't think I can. Suspend2 is a=20
reimplementation of swsusp, not a series of incremental modifications. It=20
uses completely different methods for writing the image, storing the metada=
ta=20
and so on. Until recently, the only thing it shared with swsusp was the=20
refrigerator and driver model calls, and even now the sharing of lowlevel=20
code is only a tiny fraction of all that is done.

Could I ask what might be a dumb question in this regard - why isn't Reiser=
4=20
going through the same process? Is it an indication that I shouldn't have=20
submitted these patches and should have just asked Andrew to take Suspend2=
=20
into mm, or is there something different between Reiser4 and Suspend2 that=
=20
I'm missing?

Regards,

Nigel

=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart7303281.tbUgj668hl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoOChN0y+n1M3mo0RAsASAKC2WrcFq/BuSjDZRVxdz05Qz+GCwgCfeVMB
CgtBKbILb4dlFooGbk7oudk=
=SfCF
-----END PGP SIGNATURE-----

--nextPart7303281.tbUgj668hl--
