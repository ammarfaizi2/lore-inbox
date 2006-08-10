Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030549AbWHJDGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030549AbWHJDGj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 23:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030552AbWHJDGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 23:06:39 -0400
Received: from atpro.com ([12.161.0.3]:58385 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1030549AbWHJDGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 23:06:39 -0400
Date: Wed, 9 Aug 2006 23:06:02 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: Michael Loftis <mloftis@wgops.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
Message-ID: <20060810030602.GA29664@mail>
Mail-Followup-To: Molle Bestefich <molle.bestefich@gmail.com>,
	Michael Loftis <mloftis@wgops.com>, linux-kernel@vger.kernel.org
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com> <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com> <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com> <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com> <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com> <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/06 08:28:34PM +0200, Molle Bestefich wrote:
> Michael Loftis wrote:
> >> Is there no intelligent ordering of
> >> shutdown events in Linux at all?
> >
> >The kernel doesn't perform those, your distro's init scripts do that.
> 
> Right.  It's all just "Linux" to me ;-).
> 

Then I guess it's time to break out the learning cap and figure out what's
what. =)

> (Maybe the kernel SHOULD coordinate it somehow,
> seems like some of the distros are doing a pretty bad job as is.)
> 

That's pretty much impossible, the best the kernel can do is send signals
to all of the running processes. If anything requires anything more
complicated (and many do) then even worse things will happen.

> >And various distros have various success at doing the right thing.  I've 
> >had
> >the best luck with Debian and Ubuntu doing this in the right order.  RH
> >seems to insist on turning off the network then network services such as
> >sshd.
> 
> Seems things are worse than that.  Seems like it actually kills the
> block device before it has successfully (or forcefully) unmounted the
> filesystems.  Thus the killing must also be before stopping Samba,
> since that's what was (always is) holding the filesystem.
> 
> It's indeed a redhat, though - Red Hat Linux release 9 (Shrike).
> 

Why are you using such an old distribution? I know it's only been 3 years,
but a lot has changed and I don't think anyone supports RH9 or earlier
anymore.

> >> Samba was serving files to remote computers and had no desire to let
> >> go of the filesystem while still running.  After 5 seconds or so,
> >> Linux just shutdown the MD device with the filesystem still mounted.
> >
> >The kernel probably didn't do this, usually by the time the kernel gets to
> >this point init has already sent kills to everything.  If it hasn't it
> >points to problems with your init scripts, not the kernel.
> 
> Ok, so LKML is not appropriate for the init script issue.
> Never mind that, I'll just try another distro when time comes.
> 
> I'd really like to know what the "Block bitmap for group not in group"
> message means (block bitmap is pretty self explanatory, but what's a
> group?).
> 

ext2 breaks the filesystem up into block groups, a while guess about the
error message would be that it couldn't find the block bitmap for a certain
group or the bitmap that it did find wasn't in the correct group.

Jim.
