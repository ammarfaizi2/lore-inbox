Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbWDYVTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWDYVTu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWDYVTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:19:49 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:65509 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751547AbWDYVTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:19:49 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Wed, 26 Apr 2006 07:18:36 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200604242355.08111.rjw@sisk.pl> <20060425203256.GD6379@elf.ucw.cz> <200604252312.26249.rjw@sisk.pl>
In-Reply-To: <200604252312.26249.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1391673.hOPRmanWJe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604260718.42681.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1391673.hOPRmanWJe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 26 April 2006 07:12, Rafael J. Wysocki wrote:
> Hi,
>
> On Tuesday 25 April 2006 22:32, Pavel Machek wrote:
> > > >   > -unsigned int count_data_pages(void)
> > > > >
> > > > > +/**
> > > > > + *	need_to_copy - determine if a page needs to be copied before
> > > > > saving. + *	Returns false if the page can be saved without copyin=
g.
> > > > > + */
> > > > > +
> > > > > +static int need_to_copy(struct page *page)
> > > > > +{
> > > > > +	if (!PageLRU(page) || PageCompound(page))
> > > > > +		return 1;
> > > > > +	if (page_mapped(page))
> > > > > +		return page_mapped_by_current(page);
> > > > > +
> > > > > +	return 1;
> > > > > +}
> > > >
> > > > I'd much rather VM internal type stuff get moved *out* of
> > > > kernel/power :(
> > >
> > > Well, I kind of agree, but I don't know where to place it under mm/.
> > >
> > > > It needs more comments too. Also, how important is it for the page =
to
> > > > be off the LRU?
> > >
> > > Hm, I'm not sure if that's what you're asking about, but the pages off
> > > the LRU are handled in a usual way, ie. copied when snapshotting the
> > > system.  The pages _on_ the LRU may be included in the snapshot image
> > > without copying, but I require them additionally to be (a) mapped by
> > > someone and (b) not mapped by the current task.
> >
> > Why do you _want_ them mapped by someone?
>
> Because this means they belong to a task that is frozen and won't touch
> them (of course unless it's us).  The kernel has no reason to access them
> either (even after we resume devices) except for reclaiming, but that's
> handled explicitly.  Thus it's safe to include them in the image without
> copying.
>
> As I said before, I think the page cache pages may be treated this way to=
o.
> It probably applies to all of the LRU pages, but there may be some corner
> cases.  The mapped pages are just easy to single out.

It does apply to all of the LRU pages. This is what I've been doing for yea=
rs=20
now. The only corner case I've come across is XFS. It still wants to write=
=20
data even when there's nothing to do and it's threads are frozen (IIRC -=20
haven't looked at it for a while). I got around that by freezing bdevs when=
=20
freezing processes.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1391673.hOPRmanWJe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETpIyN0y+n1M3mo0RAkntAKDj+r9NEsWFiL6dBZVV/MyDFsfzlwCcDzPM
8D40EMGtK/BzOYL8YAkNcGU=
=9IJx
-----END PGP SIGNATURE-----

--nextPart1391673.hOPRmanWJe--
