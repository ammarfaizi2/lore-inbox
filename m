Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274267AbRISXat>; Wed, 19 Sep 2001 19:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274270AbRISXaj>; Wed, 19 Sep 2001 19:30:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47036 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274267AbRISXac>;
	Wed, 19 Sep 2001 19:30:32 -0400
Date: Wed, 19 Sep 2001 19:30:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010920010338.B720@athlon.random>
Message-ID: <Pine.GSO.4.21.0109191915120.901-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Andrea Arcangeli wrote:

> On Wed, Sep 19, 2001 at 05:17:23PM -0400, Alexander Viro wrote:
> > fsync_dev() is not needed for raw devices or swap.  It _is_ needed for
> > file access.
> 
> then what's the difference between raw devices and swap.

Keep in mind that at some point we may want to add exclusions - e.g.
"swapon() messing with block_size when accidentially called for mounted
fs" problem can be easily solved that way - that's probably the
simplest way to deal with it.  Ditto for RAID vs. filesystem - current
code for that is ugly and not too reliable.
 
> And there's reason we should we avoid the fsync_dev with the raw devices
> and swap.

Umm... Not doing unnecessary work?  Semantics of releasing a block device
depends on the kind of use.  BTW, I'm less than sure that fsync_dev() is
the right thing for file access now that you've got that in pagecache -
__block_fsync() seems to be more correct thing to do.

> I just found it an useless complication.

<shrug> in the eye of beholder...

/me goes to get some sleep.

