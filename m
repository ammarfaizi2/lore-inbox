Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276330AbRJGMUw>; Sun, 7 Oct 2001 08:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276334AbRJGMUn>; Sun, 7 Oct 2001 08:20:43 -0400
Received: from pii.grimes-family.com ([209.177.4.67]:8258 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S276330AbRJGMUc>; Sun, 7 Oct 2001 08:20:32 -0400
Date: Sun, 7 Oct 2001 08:21:01 -0400
From: "David M. Grimes" <dmgrime@appliedtheory.com>
To: Jim Crilly <noth@noth.is.eleet.ca>
Cc: Rob Turk <r.turk@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx panic
Message-ID: <20011007082101.A30955@appliedtheory.com>
In-Reply-To: <1002451051.3718.20.camel@warblade> <9ppc3l$cde$1@ncc1701.cistron.net> <1002454137.284.6.camel@warblade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1002454137.284.6.camel@warblade>; from noth@noth.is.eleet.ca on Sun, Oct 07, 2001 at 07:28:57AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 07:28:57AM -0400, Jim Crilly wrote:
> Both disks on the controller are Seagate Cheetahs, the one being worked
> during the panic is a ST39204LW, the other disk is a ST318451LW.

I've seen this on a 2-disk system (both Seagate ST150176LW) on a
VA-Systems onboad AIC 7xxx.  I enabled TCQ, and noticed the default
depth increased sometime around 2.4.10, not exactly sure when (it used
to be 8, now much higher).  I've seen it on both disks.

In drivers/scsi/aic7xxx/aic7xxx_osm.h is the #define for NSEG, and I
changed it from 128 to 512, and it stopped the problem.  Question is,
why was the TCQ depth increased, and should NSEG have been upped with
it?

> 
> I did have TCQ enabled and I left it at the default of 255, I'll try a
> lower value tomorrow, since it's so late.

This also fixed my problem, I left NSEG at 128 and lowered the TCQ depth
back to 8.  This worked fine as well.

I'll be intereted to see what the eventual outcome of this is, so I can
apply the "right" fix!

Anyhow, thought you might want another datapoint.

  Thanks,

  Dave

> 
> Jim
> 
> On Sun, 2001-10-07 at 06:48, Rob Turk wrote:
> > "Jim Crilly" <noth@noth.is.eleet.ca> wrote in message
> > news:cistron.1002451051.3718.20.camel@warblade...
> > > I got a reproducible panic while running dbench simulating 25+ clients,
> > > the new aic7xxx driver panics with "Too few segs for dma mapping.
> > > "Increase AHC_NSEG". The partition in question is FAT32 and on a
> > > different disk than /, I'm not using HIGHMEM. I am using XFS and the
> > > preempt patches, but I don't think they're related to the panic.
> > >
> > > The odd thing, is if I run dbench in the same manner on my / partition,
> > > which is on a different disk on the same controller, it goes fine. It
> > > seems, to my untrained eye anyway, to be a bad interaction between the
> > > vfat driver and the aic7xxx driver.
> > >
> > > I'm using the old aic7xxx driver right now and it's fine, has anyone
> > > else seen anything like this?
> > >
> > > Jim
> > 
> > Since this seems to fail on just one disk, it might have to do with one of the
> > disk characteristics, like command queue depth. Did you enable Tagged Command
> > Queueing, and if so, can you try playing around with the maximum depth?
> > 
> > Rob
