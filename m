Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRCWCGO>; Thu, 22 Mar 2001 21:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRCWCFz>; Thu, 22 Mar 2001 21:05:55 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:38550 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129242AbRCWCFn>; Thu, 22 Mar 2001 21:05:43 -0500
Date: Thu, 22 Mar 2001 21:04:15 -0500 (EST)
From: Alexander Viro <aviro@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [linux-lvm] EXT2-fs panic (device lvm(58,0)):
In-Reply-To: <20010323013914.M7756@redhat.com>
Message-ID: <Pine.LNX.4.33.0103222100370.18794-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Stephen C. Tweedie wrote:

> Hi,
>
> On Wed, Mar 07, 2001 at 01:35:05PM -0700, Andreas Dilger wrote:
>
> > The only remote possibility is in ext2_free_blocks() if block+count
> > overflows a 32-bit unsigned value.  Only 2 places call ext2_free_blocks()
> > with a count != 1, and ext2_free_data() looks to be OK.  The other
> > possibility is that i_prealloc_count is bogus - that is it!  Nowhere
> > is i_prealloc_count initialized to zero AFAICS.
> >
> Did you ever push this to Alan and/or Linus?  This looks pretty
> important!

It isn't. Check fs/inode.c::clean_inode(). Specifically,
        memset(&inode->u, 0, sizeof(inode->u));
The thing is called both by get_empty_inode() and by get_new_inode() (the
former - just before returning, the latter - just before calling
->read_inode()).
								Cheers,
									Al

