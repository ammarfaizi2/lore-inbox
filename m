Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWBWXar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWBWXar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 18:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWBWXar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 18:30:47 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:19631 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932125AbWBWXaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 18:30:46 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Fri, 24 Feb 2006 09:27:45 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602232337.31075.rjw@sisk.pl> <20060223230439.GC1662@elf.ucw.cz>
In-Reply-To: <20060223230439.GC1662@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2794757.nZ9vu5GrKm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602240927.51338.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2794757.nZ9vu5GrKm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 24 February 2006 09:04, Pavel Machek wrote:
> > > [Because pagecache is freeable, anyway, so it will be freed. Now... I
> > > have seen some problems where free_some_memory did not free enough,
> > > and schedule()/retry helped a bit... that probably should be fixed.]
> >
> > It seems I need to understand correctly what the difference between what
> > we do and what Nigel does is.  I thought the Nigel's approach was to sa=
ve
> > some cache pages to disk first and use the memory occupied by them to
> > store the image data.  If so, is the page cache involved in that or
> > something else?
>
> I believe Nigel only saves pages that could have been freed anyway
> during phase1. Nigel, correct me here... suspend2 should work on same
> class of machines swsusp can, but will be able to save caches on
> machines where swsusp can not save any.

I'm not used to thinking in these terms :). It would be normally be right,=
=20
except that there will be some LRU pages that will never be freed. These=20
would allow suspend2 to work in some (not many) cases where swsusp can't.=20
It's been ages since I did the intensive testing on the image preparation=20
code, but I think that if we free as much memory as we can, we will always=
=20
still have at least a few hundred LRU pages left. That's not much, but on=20
machines with less ram, it might make the difference in a greater percentag=
e=20
of cases (compared to machines with more ram)?

If there were other pages that could be safely included in this set, we cou=
ld=20
perhaps make more cases where suspend2 could work but swsusp couldn't. LRU=
=20
was low hanging fruit, and I didn't bother looking beyond it.

Nigel

--nextPart2794757.nZ9vu5GrKm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/kT3N0y+n1M3mo0RAvM9AJ9M9AO8PbdczvuAtsQdnIFyWXbuNwCgsPKz
l7PyODFNU04cWwq0eVPu5ZM=
=IGrw
-----END PGP SIGNATURE-----

--nextPart2794757.nZ9vu5GrKm--
