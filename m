Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274523AbRITWNJ>; Thu, 20 Sep 2001 18:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274582AbRITWM7>; Thu, 20 Sep 2001 18:12:59 -0400
Received: from [195.223.140.107] ([195.223.140.107]:58613 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274523AbRITWMv>;
	Thu, 20 Sep 2001 18:12:51 -0400
Date: Fri, 21 Sep 2001 00:13:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010921001305.F729@athlon.random>
In-Reply-To: <20010920231804.C729@athlon.random> <Pine.GSO.4.21.0109201736550.5631-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109201736550.5631-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Sep 20, 2001 at 05:40:00PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 05:40:00PM -0400, Alexander Viro wrote:
> 
> 
> On Thu, 20 Sep 2001, Andrea Arcangeli wrote:
> 
> > > Sigh... Try BLKFLSBUF + write() + BLKFLSBUF.
> > 
> > write will return -EIO and second BLKFLSBUF will do nothing.
> 
> Now compare that with behaviour of -pre10 (not to mention the
> (in)sanity of "this ioctl() will make all IO on the fd fail until
> somebody opens the same file" semantics).

It's not that insane: the address space is allocated at open time.
After you drop it with BLKFLSBUF you will have to open the device again
to reallocate a new address space. I could just truncate the physical
address space, there are no other users, but then the inode would remain
pinned forever, and so until we include your ipinning fix this looked an
acceptable two liner band-aid I guess (again, real fix is yours, all I'm
saying is that it can't oops any longer ;).

thanks,
Andrea
