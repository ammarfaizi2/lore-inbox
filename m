Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRCWFtg>; Fri, 23 Mar 2001 00:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129529AbRCWFt1>; Fri, 23 Mar 2001 00:49:27 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:61935 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S129524AbRCWFtQ>; Fri, 23 Mar 2001 00:49:16 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103230548.f2N5mM407684@webber.adilger.int>
Subject: Re: [linux-lvm] EXT2-fs panic (device lvm(58,0)):
In-Reply-To: <Pine.LNX.4.33.0103222100370.18794-100000@devserv.devel.redhat.com>
 from Alexander Viro at "Mar 22, 2001 09:04:15 pm"
To: Alexander Viro <aviro@redhat.com>
Date: Thu, 22 Mar 2001 22:48:22 -0700 (MST)
CC: "Stephen C. Tweedie" <sct@redhat.com>, linux-fsdevel@webber.adilger.int,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro writes:
> On Fri, 23 Mar 2001, Stephen C. Tweedie wrote:
> > On Wed, Mar 07, 2001 at 01:35:05PM -0700, Andreas Dilger wrote:
> > > The only remote possibility is in ext2_free_blocks() if block+count
> > > overflows a 32-bit unsigned value.  Only 2 places call ext2_free_blocks()
> > > with a count != 1, and ext2_free_data() looks to be OK.  The other
> > > possibility is that i_prealloc_count is bogus - that is it!  Nowhere
> > > is i_prealloc_count initialized to zero AFAICS.
> > >
> > Did you ever push this to Alan and/or Linus?  This looks pretty
> > important!
> 
> It isn't. Check fs/inode.c::clean_inode(). Specifically,
>         memset(&inode->u, 0, sizeof(inode->u));
> The thing is called both by get_empty_inode() and by get_new_inode() (the
> former - just before returning, the latter - just before calling
> ->read_inode()).

If this is the case, then all of the other zero initializations can be
removed as well.  I figured that if most of the fields needed to be
zeroed, then ones _not_ being zeroed would lead to this problem.

FYI Stephen, the original poster followed up that the problem was with
an IBM SCSI RAID card...

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
