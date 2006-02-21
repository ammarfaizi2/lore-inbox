Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161238AbWBUXum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161238AbWBUXum (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161239AbWBUXum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:50:42 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:21215 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1161238AbWBUXuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:50:40 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 22 Feb 2006 09:47:39 +1000
User-Agent: KMail/1.9.1
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602220700.55207.ncunningham@cyclades.com> <200602220038.18054.rjw@sisk.pl>
In-Reply-To: <200602220038.18054.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1404632.3Iq0SW9mkm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602220947.44506.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1404632.3Iq0SW9mkm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 22 February 2006 09:38, Rafael J. Wysocki wrote:
> On Tuesday 21 February 2006 22:00, Nigel Cunningham wrote:
> > On Wednesday 22 February 2006 06:40, Rafael J. Wysocki wrote:
> > > On Tuesday 21 February 2006 05:19, Dmitry Torokhov wrote:
> > > > On Monday 20 February 2006 21:57, Nigel Cunningham wrote:
> > > > > For the record, my thinking went: swsusp uses n (12?) bytes of me=
ta
> > > > > data for every page you save, where as using bitmaps makes that
> > > > > much closer to a constant value (a small variable amount for
> > > > > recording where the image will be stored in extents). 12 bytes per
> > > > > page is 3MB/1GB. If swsusp was to add support for multiple swap
> > > > > partitions or writing to files, those requirements might be closer
> > > > > to 5MB/GB.
> > > >
> > > > 5MB/GB amounts to 0.5% overhead, I don't think you should be
> > > > concerned here. Much more important IMHO is that IIRC swsusp requir=
es
> > > > to be able to free 1/2 of the physical memory whuch is hard on low
> > > > memory boxes.
> > >
> > > I see another point in using bitmaps: we could avoid modifying page
> > > flags and use bitmaps to store all of the temporary information.  I
> > > thought about it for some time and I think it's doable.
> >
> > It is doable - I'm doing it now, but am thinking about reverting part of
> > the code to use pbes again. If you're going to look at using bitmaps in
> > place of pbes, me changing would be a waste of time. Do you want me to
> > hold off for a while? (I'll happily do that, as I have far more than
> > enough to keep me occupied at the moment anyway).
>
> Well, I'd say so. :-)

Ok.

> Frankly, I didn't think of dropping PBEs right now, but in the long run
> that's worth considering, IMO.  The advantage of PBEs is that they are ea=
sy
> to handle in the assembly parts, but apart from this they are a bit
> wasteful (not very much, though).

=46ully agree. That's why I've sought to keep the copying in c - it makes i=
t=20
simpler to read and maintain (although at the expense of a little bit of=20
ugliness with that if in the stack page allocation or (old way) working har=
d=20
to make the C not use stack).

> The fact that we use page flags to store some suspend/resume-related
> information is a big disadvantage in my view, and I'd like to get rid of
> that in the future.  In principle we could use a bitmap, or rather two of
> them, to store the same information independently of the page flags, and =
if
> we use bitmaps for this purpose, we can use them also instead of PBEs.

If you use the 'dynamically allocated pageflags' code (sure, pick a better=
=20
name if you want), these changes will be pretty trivial - you can #define=20
macros that could make the transition just a matter of switching PageNosave=
=20
(eg) to PageSomethingElse. (Ditto for setting and clearing flags).

> At this point I'd have to look at your snapshot-related code and see if
> it's suitable for snapshot.c (in -mm now) somehow.  If you could point
> me to the specific parts of the suspend2 patch where this code is, I'd be
> grateful.

Sure. The bulk is in kernel/power/atomic_copy.c. Arch specific routines are=
=20
include/asm-<arch>/suspend2.h.

Regards,

Nigel


> Greetings,
> Rafael

--nextPart1404632.3Iq0SW9mkm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+6agN0y+n1M3mo0RAi5QAKCv1RlJIBdFREbqEV0zzYX2AwDiEgCffdJp
FKQ1f2ucCRu+gOXYO2ytc4c=
=WKkC
-----END PGP SIGNATURE-----

--nextPart1404632.3Iq0SW9mkm--
