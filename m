Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274171AbRIXVEO>; Mon, 24 Sep 2001 17:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274172AbRIXVEF>; Mon, 24 Sep 2001 17:04:05 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:4847 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274170AbRIXVDu>; Mon, 24 Sep 2001 17:03:50 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Mon, 24 Sep 2001 15:04:02 -0600
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.10 + ext3
Message-ID: <20010924150402.G14526@turbolinux.com>
Mail-Followup-To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <1001280620.3540.33.camel@gromit.house> <9om4ed$1hv$1@penguin.transmeta.com>, <9om4ed$1hv$1@penguin.transmeta.com> <20010923193008.A13982@vitelus.com> <3BAEAC52.677C064C@zip.com.au>, <3BAEAC52.677C064C@zip.com.au> <20010923214507.A15014@vitelus.com> <3BAEC254.2A29B495@zip.com.au> <20010924204946.C9688@kushida.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010924204946.C9688@kushida.jlokier.co.uk>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 24, 2001  20:49 +0100, Jamie Lokier wrote:
> Andrew Morton wrote:
> > And the main reason for having the same on-disk format is not, IMO, to
> > ease migration between the two filesystems.  That's just a once-off
> > activity.
> 
> I disagree that it's a once-off activity.  I've been known to switch
> between ext2 and ext3 and ext2 and ext3...  just so I can boot old
> kernels such as rescue disks.  It's nice to be able to do this.

Well, you don't need to remove the journal just to boot off of a rescue
disk.  The only requirement is that you have a clean unmount of the ext3
filesystem (although if you DO have a booting problem that can also be a
bit of a challenge).

> Also I don't think resize2fs resizes the journal (but I may be wrong),
> so I've converted ext3 to ext2 to resize a filesystem, then converted
> back.

I think you're wrong on this one.  As long as you unmount the filesystem,
resize2fs should be able to handle it (as will ext2resize).

> I did have a big disaster once when I compiled ext3 into a kernel and
> not ext2 (which I left as a module).  You can guess, it couldn't mount
> the root filesystem.

Yes, this is one reason why removing the journal all the time is a bad
idea.  This won't be a problem at some point in the future when it is
possible for the ext3 code to mount an unjournaled filesystem (ala ext2),
but that still needs a bit of work that isn't very high priority.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

