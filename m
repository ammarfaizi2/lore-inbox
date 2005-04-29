Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbVD2UnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbVD2UnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbVD2UnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:43:11 -0400
Received: from waste.org ([216.27.176.166]:55451 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262406AbVD2UkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:40:07 -0400
Date: Fri, 29 Apr 2005 13:39:59 -0700
From: Matt Mackall <mpm@selenic.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050429203959.GC21897@waste.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <20050429203027.GK17379@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429203027.GK17379@opteron.random>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 10:30:27PM +0200, Andrea Arcangeli wrote:
> On Thu, Apr 28, 2005 at 11:01:57PM -0700, Matt Mackall wrote:
> > change nodes so you've got to potentially traverse all the commits to
> > reconstruct a file's history. That's gonna be O(top-level changes)
> > seeks. This introduces a number of problems:
> > 
> > - no way to easily find previous revisions of a file
> >   (being able to see when a particular change was introduced is a
> >   pretty critical feature)
> > - no way to do bandwidth-efficient delta transfer
> > - no way to do efficient delta storage
> > - no way to do merges based on the file's history[1]
> 
> And IMHO also no-way to implement a git-on-the-fly efficient network
> protocol if tons of clients connects at the same time, it would be
> dosable etc... At the very least such a system would require an huge
> amount of ram. So I see the only efficient way to design a network
> protocol for git not to use git, but to import the data into mercurial
> and to implement the network protocol on top of mercurial.
> 
> The one downside is that git is sort of rock solid in the way it stores
> data on disk, it makes rsync usage trivial too, the git fsck is reliable
> and you can just sign the hash of the root of the tree and you sign
> everything including file contents. And of course the checkin is
> absolutely trivial and fast too.

Mercurial is ammenable to rsync provided you devote a read-only
repository to it on the client side. In other words, you rsync from
kernel.org/mercurial/linus to local/linus and then you merge from
local/linus to your own branch. Mercurial's hashing hierarchy is
similar to git's (and Monotone's), so you can sign a single hash of
the tree as well.

> With a more efficient diff-based storage like mercurial we'd be losing
> those fsck properties etc.. but those reliability properties don't worth
> the network and disk space they take IMHO, and the checkin time
> shouldn't be substantially different (still running in O(1) when
> appending at the head). And we could always store the hash of the
> changeset, to give it some basic self-checking.

I think I can implement a decent repository check similar to git, it's
just not been a priority.

-- 
Mathematics is the supreme nostalgia of our time.
