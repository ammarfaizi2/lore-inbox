Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131375AbRAKTSq>; Thu, 11 Jan 2001 14:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130232AbRAKTSg>; Thu, 11 Jan 2001 14:18:36 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8228 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130162AbRAKTSS>; Thu, 11 Jan 2001 14:18:18 -0500
Date: Thu, 11 Jan 2001 20:18:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: technews@egsx.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: inode leak 2.2.12+ why??
Message-ID: <20010111201840.F892@athlon.random>
In-Reply-To: <Pine.LNX.4.10.10101111349240.2361-100000@egsx.com> <20010111201627.E892@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010111201627.E892@athlon.random>; from andrea@suse.de on Thu, Jan 11, 2001 at 08:16:27PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 08:16:27PM +0100, Andrea Arcangeli wrote:
> On Thu, Jan 11, 2001 at 02:01:58PM -0500, technews@egsx.com wrote:
> > Hi,
> > 
> > The most puzzling thing is happeneing.  I have compiled a vanillat 2.2.18
> > kernel with scsi aic7xxx compiled in, 3com network support. (nothing fancy
> > no sound, no isdn, video, etc...)
> > 
> > I installed this kernel on a redhat 5.2 system, it boots in fine, but then
> > after some time I get messages saying fork: resource unavailable.  I
> > checked the inodes and I was chocked to see the number goingg up and up
> > without stopping.  I changed the value of inode-max to a high number, and
> > at the same time file-max, but to no avail.  Once it hits that max, it
> > will not allow me to do anything but shutdown the power to restart.
> 
> Yes, this is a known limitation of the icache (and 2.4.x still can't shrink the
> filp pool, infact I'm surprised such pool is still there, I'd kill the filp
> poll enterely and I'd use the slab cache for that that should be more efficient
> in SMP and it's dynamic, should be just a few liner plus some code removal).
> 
> Your mistake is been to enlarge the inode-max, you shouldn't do that.
> 2.2.19pre7aa1 uses smarter calculations to setup the inode-max and icache hash
> size (so you're more likely to get sane values for servers), I suggest to try
> it without touching inode-max from its default value and see what happens.

BTW, earlier 2.2.12 really had inode-leak bugs, but those are fixed in the
latest 2.2.1x (so make sure `uname -r` says 2.2.18 ;).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
