Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135245AbRDZJdm>; Thu, 26 Apr 2001 05:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135249AbRDZJdg>; Thu, 26 Apr 2001 05:33:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32780 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S135245AbRDZJdX>; Thu, 26 Apr 2001 05:33:23 -0400
Date: Thu, 26 Apr 2001 11:33:18 +0200
From: Jan Kara <jack@suse.cz>
To: Chris Mason <mason@suse.com>
Cc: Pavel Machek <pavel@suse.cz>, viro@math.psu.edu,
        kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: [patch] linux likes to kill bad inodes
Message-ID: <20010426113318.A2766@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010425220120.A1540@bug.ucw.cz> <466810000.988230486@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <466810000.988230486@tiny>; from mason@suse.com on Wed, Apr 25, 2001 at 04:28:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> On Wednesday, April 25, 2001 10:01:20 PM +0200 Pavel Machek <pavel@suse.cz>
> wrote:
> 
> > Hi!
> > 
> >> > Hi!
> >> > 
> >> > I had a temporary disk failure (played with acpi too much). What
> >> > happened was that disk was not able to do anything for five minutes
> >> > or so. When disk recovered, linux happily overwrote all inodes it
> >> > could not read while disk was down with zeros -> massive disk
> >> > corruption.
> >> > 
> >> > Solution is not to write bad inodes back to disk.
> >> > 
> >> 
> >> Wouldn't we rather make it so bad inodes don't get marked dirty at all?
> > 
> > I guess this is cheaper: we can mark inode dirty at 1000 points, but
> > you only write it at one point.
> 
> Whoops, I worded that poorly.  To me, it seems like a bug to dirty a bad
> inode.  If this patch works, it is because somewhere, somebody did
> something with a bad inode, and thought the operation worked (otherwise,
> why dirty it?).  
> 
> So yes, even if we dirty them in a 1000 different places, we need to find
> the one place that believes it can do something worthwhile to a bad inode.
  Yes checking those places where bad inode gets dirty is probably good
idea. But I'd add test to write_inode anyway together with warning that
this shouldn't happen.

								Honza

--
Jan Kara <jack@suse.cz>
SuSE Labs
