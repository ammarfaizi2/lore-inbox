Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135243AbRDZJ3c>; Thu, 26 Apr 2001 05:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135249AbRDZJ3X>; Thu, 26 Apr 2001 05:29:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21772 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S135242AbRDZJ3G>; Thu, 26 Apr 2001 05:29:06 -0400
Date: Thu, 26 Apr 2001 11:28:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Chris Mason <mason@suse.com>
Cc: viro@math.psu.edu, kernel list <linux-kernel@vger.kernel.org>,
        jack@atrey.karlin.mff.cuni.cz, torvalds@transmeta.com
Subject: Re: [patch] linux likes to kill bad inodes
Message-ID: <20010426112846.A2497@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010425220120.A1540@bug.ucw.cz> <466810000.988230486@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <466810000.988230486@tiny>; from mason@suse.com on Wed, Apr 25, 2001 at 04:28:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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

Would it make sense to put the check into write_inode_ with BUG() and
return, then?

> So yes, even if we dirty them in a 1000 different places, we need to find
> the one place that believes it can do something worthwhile to a bad
> inode.

Could not it be something as simple as atime update?

								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
