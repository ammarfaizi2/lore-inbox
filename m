Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVEMSJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVEMSJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVEMSJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:09:51 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:8158 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262468AbVEMSJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:09:18 -0400
Date: Fri, 13 May 2005 14:09:15 -0400
To: "Michael H. Warfield" <mhw@wittsend.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sync option destroys flash!
Message-ID: <20050513180915.GH23488@csclub.uwaterloo.ca>
References: <1116001207.5239.38.camel@localhost.localdomain> <20050513171758.GB23621@csclub.uwaterloo.ca> <1116006828.5239.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116006828.5239.72.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 01:53:48PM -0400, Michael H. Warfield wrote:
> 	Yeah, I've heard that claimed but a real problem is that nobody can
> tell which ones do or don't until you've got a crispy chip.  I've looked
> and I haven't been able to find a single reference on any that you might
> pick up at Best Buy or Fry's.  I've never seen one that has it written
> on it that it has any sort of wear leveling like that.  But I guess we
> don't all buy our flash drives at an industrial supply house (forget
> Tiger Direct or CDW either - consumer grade).  I would bet that most
> people don't even REALIZE that flash has a limited life and wears out.

I believe any flash with a sandisk controller in it will do pretty good
wear leveling (I think all the ones labeled sandisk have their
controller, although they don't all have sandisk flash chips).  The
controller is what does the wear leveling.  At least for CF and SD this
is what they do.

> 	Unfortunately, it's the default under some RedHat stuff (yes, I've
> filed the bug reports) and the documentation on "mount" is incorrect and
> it's arguable if it's any value, and there's no warning of the risks.
> "User error" is a bit off the mark when the user has to take action he
> has no knowledge of to work around a destructive default he doesn't even
> know exists (here I'm referring specifically to the need to unmount the
> automounted flash and then remount it somewhere else without the unsafe
> options).

Well the documentation for mount isn't authorative on what the kernel
does.  Not sure where the authoritive information on how vfat treats
sync is (besides the source code).

> 	User error also boils down to removing drives before they are unmounted
> or sync'ed.  Windows seems to deal with this problem without jacking off
> on the FAT tables.  Why is it that Linux has a procedure that is
> potentially destructive and degrades performance so badly when MS gets
> away without it in Windows?  It's an MS file system.  One of the
> contributors on the Fedora list remarked that this explained why his USB
> keys were so slow on Linux compared to Windows.

Well perhaps what windows does is write the hole file, then update the
fat, then call sync immediately afterwards, or whenever a file is
closed, it calls sync on that file's information.

> 	Already filed bug reports with RedHat.  On both HAL and on the
> documentation for mount.

Well that is where the problem has to be solved.

> 	Oh?  It's of some use now?  Beyond degrading performance to the point
> that it takes many times longer to write a flash system in Linux than in
> Windows?  Yes, I know, don't use it.  What's it there for, then?  To
> protect idiots from removing drives before they're unmounted?  Those are
> the same idiots who will not know what happened when it burns up there
> drive and they are the least likely to use that option overtly.  Most
> people don't realize that it was being used without their knowledge
> (much less the risks associated with using it in the first place) and
> just thought it was a Linux problem that it took many times longer to
> write USB keys in Linux than in Windows.

It does help make sure data is written to fat drives right away,
although I don't ever think that should be enabled per filesystem
myself, some people seem to think it is the way to do things.  I think
an application should be responsible for calling sync on a file when it
considers it important.  If a filesystem doesn't honour that it is
broken (and yes many filesystems probably are broken that way).

> 	Rule number one should be "do no harm".  Maybe it should be under some
> "force" flag or something just warning people not to use it unless they
> really REALLY know what their doing.  I, personally, would never have
> used it under any circumstances.  I was shocked to discover that RedHat
> was doing this by default.  A warning to THEM would have been better
> than a warning to me, since I already knew not to do stupid shit like
> that.  Not sure who is responsible for that HAL package or what other
> distros may also be vulnerable to this.  I mostly blame RedHat for this
> problem first plus the mount man pages (which I suspect they replied on)
> second but I question if there shouldn't be a better way to avoid
> destroying hardware here.

flash drives have only been around a few years, and I guess in this case
redhat made a mistake.  I think any filesystem with sync mount option
would be very bad for flash drives.  This is not a fat problem, it's a
problem with how sync works with flash drives in general.  What do you
think would happen if you formated your flash disk with ext3 and mounted
it with sync?  It would die real quick too.

Removing proper sync option is not a solution just because you could do
harm.  Should we remove write access to the disk just because you might
let users run rm -rf /?  Isn't that allowing harm to be done by the user
too?

Len Sorensen
