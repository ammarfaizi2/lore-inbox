Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274431AbRITL5b>; Thu, 20 Sep 2001 07:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274429AbRITL5W>; Thu, 20 Sep 2001 07:57:22 -0400
Received: from ns.caldera.de ([212.34.180.1]:42187 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S274431AbRITL5I>;
	Thu, 20 Sep 2001 07:57:08 -0400
Date: Thu, 20 Sep 2001 13:57:17 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Kevin Corry <corry@ecn.purdue.edu>
Cc: linux-kernel@vger.kernel.org, hch@ns.caldera.de, adilger@turbolabs.com
Subject: Re: IBMs LVM?
Message-ID: <20010920135717.A11737@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	Kevin Corry <corry@ecn.purdue.edu>, linux-kernel@vger.kernel.org,
	hch@ns.caldera.de, adilger@turbolabs.com
In-Reply-To: <200109142155.f8ELtVi03827@shay.ecn.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109142155.f8ELtVi03827@shay.ecn.purdue.edu>; from corry@ecn.purdue.edu on Fri, Sep 14, 2001 at 04:55:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, enough work done - back to the flamefests :)

On Fri, Sep 14, 2001 at 04:55:31PM -0500, Kevin Corry wrote:
> I think this particular issue is being slightly mistaken. There are no
> facilities in EVMS to "migrate" one type of volume to another type of volume.
> For instance, if a user has an OS/2 box and uses OS/2 LVM volumes, EVMS will
> support that format directly. However, it currently does not allow that volume
> to be converted to, say, a Linux LVM volume. If this is the user's desire, he
> will have to create new volumes using the Linux LVM module, and move the data
> between the volumes. In future designs there may be support for doing this kind
> of operation on-line, but that would be as close as we would get to doing a
> "migration".

That's my position as well, good.

> Well, I certainly find it interesting to hear you say this. This whole 
> notion (which I have personally thought is completely rediculous from 
> the start) was put in due to suggestions from you.


Noe need for FUD here.  Please recall the 

	Subject: Re: [Evms] Questions about portability

thread in 01/2001, specificly my post

	Message-ID: <20010111142355.A10524@caldera.de>

> > I think such an patch would be accepted much more likely. You know
> > Linus (and we all :)) likes ripping out code.
> >
> > If you come and say: this patch nukes all special cases for MD, LVM
> > and partition handling, the code is now X lines less I bet he will
> > like it.
> 
> We have discussed this quite a bit recently, and we seem pretty well split
> on what we should do (as it seems you are). The crux of what we have decided
> is that we don't want to suddenly force EVMS on all Linux users (by removing
> the partition code, etc). Rather, we were going to put another option in the
> EVMS configuration menu to allow removal of this code at compile time.

Blarg.  All this this code is obsolete but you can force it back in stuff
will make Linux as unmaintainable and bloated as the commercial UNICEs.

If we have a nice, leight-weight abstraction there is no reason to not use
it.  Of course your code is currently neither small nor nicely abstracted..

Anyway, I will get my design for improved block device stacking and unified
partition discovery back from the attic and implement a protopy ontop of
the bio patchset.  I'll Cc my ennouncement to evms-devel, you're free to
layer ontop if you want.

> On a very brief check, my LVM module in the EVMS kernel code is about
> 2800 lines, with the actual LVM kernel code taking up about 3700 lines.

3700 lines of 2800?  My current CVS sais it's about 2800.

> All together, drivers/md has about 12k lines and drivers/evms has about
> 16k lines. Of course, that also includes support for the partitioning code,
> generic snapshotting, bad-block relocation, and OS/2 and AIX compatibility.
> However, that doesn't currently include a port of MD. But I honestly can't
> see the core MD code being more than another few k-lines, and hopefully a
> nearly straight port of the personality modules.

Currently the md codee is about 10k LOC, that includes raid0/1/4/5, linear
and mutlipathing and high-speed checksumming code

	Christoph

