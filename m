Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWDYW0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWDYW0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 18:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWDYW0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 18:26:11 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:34213 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932175AbWDYW0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 18:26:10 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Wed, 26 Apr 2006 08:24:55 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200604242355.08111.rjw@sisk.pl> <200604260718.42681.nigel@suspend2.net> <200604260021.08888.rjw@sisk.pl>
In-Reply-To: <200604260021.08888.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart16374067.5hqYHQYcCd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604260825.04867.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart16374067.5hqYHQYcCd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 26 April 2006 08:21, Rafael J. Wysocki wrote:
> On Tuesday 25 April 2006 23:18, Nigel Cunningham wrote:
> > On Wednesday 26 April 2006 07:12, Rafael J. Wysocki wrote:
> > > On Tuesday 25 April 2006 22:32, Pavel Machek wrote:
> > > > > >   > -unsigned int count_data_pages(void)
> > > > > > >
> > > > > > > +/**
> > > > > > > + *	need_to_copy - determine if a page needs to be copied
> > > > > > > before saving. + *	Returns false if the page can be saved
> > > > > > > without copying. + */
> > > > > > > +
> > > > > > > +static int need_to_copy(struct page *page)
> > > > > > > +{
> > > > > > > +	if (!PageLRU(page) || PageCompound(page))
> > > > > > > +		return 1;
> > > > > > > +	if (page_mapped(page))
> > > > > > > +		return page_mapped_by_current(page);
> > > > > > > +
> > > > > > > +	return 1;
> > > > > > > +}
> > > > > >
> > > > > > I'd much rather VM internal type stuff get moved *out* of
> > > > > > kernel/power :(
> > > > >
> > > > > Well, I kind of agree, but I don't know where to place it under
> > > > > mm/.
> > > > >
> > > > > > It needs more comments too. Also, how important is it for the
> > > > > > page to be off the LRU?
> > > > >
> > > > > Hm, I'm not sure if that's what you're asking about, but the pages
> > > > > off the LRU are handled in a usual way, ie. copied when
> > > > > snapshotting the system.  The pages _on_ the LRU may be included =
in
> > > > > the snapshot image without copying, but I require them additional=
ly
> > > > > to be (a) mapped by someone and (b) not mapped by the current tas=
k.
> > > >
> > > > Why do you _want_ them mapped by someone?
> > >
> > > Because this means they belong to a task that is frozen and won't tou=
ch
> > > them (of course unless it's us).  The kernel has no reason to access
> > > them either (even after we resume devices) except for reclaiming, but
> > > that's handled explicitly.  Thus it's safe to include them in the ima=
ge
> > > without copying.
> > >
> > > As I said before, I think the page cache pages may be treated this way
> > > too. It probably applies to all of the LRU pages, but there may be so=
me
> > > corner cases.  The mapped pages are just easy to single out.
> >
> > It does apply to all of the LRU pages. This is what I've been doing for
> > years now. The only corner case I've come across is XFS. It still wants
> > to write data even when there's nothing to do and it's threads are froz=
en
> > (IIRC - haven't looked at it for a while). I got around that by freezing
> > bdevs when freezing processes.
>
> This means if we freeze bdevs, we'll be able to save all of the LRU pages,
> except for the pages mapped by the current task, without copying.  I think
> we can try to do this, but we'll need a patch to freeze bdevs for this
> purpose. ;-)

Isn't that a coincidence? I just happen to have the code right here! Not in=
 a=20
patch form that you'd want though - do you have any refrigerator changes in=
=20
mm at the moment, or can I use vanilla 2.6.17-rc2 process.c?

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart16374067.5hqYHQYcCd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETqHAN0y+n1M3mo0RAh4jAJ0RagUs5Z5+CNhjw6nJMBXoBlvmjwCgpZpx
Cv83z531kLPwny6ybfooO/E=
=Rhz7
-----END PGP SIGNATURE-----

--nextPart16374067.5hqYHQYcCd--
