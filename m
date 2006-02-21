Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWBUXi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWBUXi0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWBUXi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:38:26 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:50569 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751221AbWBUXiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:38:25 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 22 Feb 2006 00:38:17 +0100
User-Agent: KMail/1.9.1
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602212140.57566.rjw@sisk.pl> <200602220700.55207.ncunningham@cyclades.com>
In-Reply-To: <200602220700.55207.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602220038.18054.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 21 February 2006 22:00, Nigel Cunningham wrote:
> On Wednesday 22 February 2006 06:40, Rafael J. Wysocki wrote:
> > On Tuesday 21 February 2006 05:19, Dmitry Torokhov wrote:
> > > On Monday 20 February 2006 21:57, Nigel Cunningham wrote:
> > > > For the record, my thinking went: swsusp uses n (12?) bytes of meta
> > > > data for every page you save, where as using bitmaps makes that much
> > > > closer to a constant value (a small variable amount for recording where
> > > > the image will be stored in extents). 12 bytes per page is 3MB/1GB. If
> > > > swsusp was to add support for multiple swap partitions or writing to
> > > > files, those requirements might be closer to 5MB/GB.
> > >
> > > 5MB/GB amounts to 0.5% overhead, I don't think you should be concerned
> > > here. Much more important IMHO is that IIRC swsusp requires to be able to
> > > free 1/2 of the physical memory whuch is hard on low memory boxes.
> >
> > I see another point in using bitmaps: we could avoid modifying page flags
> > and use bitmaps to store all of the temporary information.  I thought about
> > it for some time and I think it's doable.
> 
> It is doable - I'm doing it now, but am thinking about reverting part of the 
> code to use pbes again. If you're going to look at using bitmaps in place of 
> pbes, me changing would be a waste of time. Do you want me to hold off for a 
> while? (I'll happily do that, as I have far more than enough to keep me 
> occupied at the moment anyway).

Well, I'd say so. :-)

Frankly, I didn't think of dropping PBEs right now, but in the long run
that's worth considering, IMO.  The advantage of PBEs is that they are easy to
handle in the assembly parts, but apart from this they are a bit wasteful
(not very much, though).

The fact that we use page flags to store some suspend/resume-related
information is a big disadvantage in my view, and I'd like to get rid of that
in the future.  In principle we could use a bitmap, or rather two of them,
to store the same information independently of the page flags, and
if we use bitmaps for this purpose, we can use them also instead of
PBEs.

At this point I'd have to look at your snapshot-related code and see if
it's suitable for snapshot.c (in -mm now) somehow.  If you could point
me to the specific parts of the suspend2 patch where this code is, I'd be
grateful.

Greetings,
Rafael
