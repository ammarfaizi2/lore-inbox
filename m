Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314409AbSENRBM>; Tue, 14 May 2002 13:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315877AbSENRBL>; Tue, 14 May 2002 13:01:11 -0400
Received: from mark.mielke.cc ([216.209.85.42]:41993 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S314409AbSENRBK>;
	Tue, 14 May 2002 13:01:10 -0400
Date: Tue, 14 May 2002 12:55:36 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Elladan <elladan@eskimo.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Message-ID: <20020514125536.B22935@mark.mielke.cc>
In-Reply-To: <elladan@eskimo.com> <200205131709.g4DH9Fjv006328@pincoya.inf.utfsm.cl> <20020513105250.A30395@eskimo.com> <20020513185723.A2657@infradead.org> <20020514092254.A2581@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Notice how the space can only be filled up if a setuid program is used
to actually fill it up. Even if it is a partial 'security feature', every
administrator knows that setuid violates security in a non-natural way.

1) Provide a patch and see if it is accepted.

2) Convince somebody else that they should put time into features of
   questionable value such as this one.

mark



On Tue, May 14, 2002 at 09:22:54AM -0700, Elladan wrote:
> I went to google and attempted to find information about the root
> reserve space for ext2, as a user wondering about the feature would.  I
> couldn't find any documentation that states it's purely a fragmentation
> and convenience feature.  I did, however, find documents stating
> otherwise.  Note how even Documentation/filesystems/ext2.txt states that
> it's a security feature?
> 
> If this is not a security feature, Documentation/filesystems/ext2.txt
> needs to be changed.  Eg., 
> 
> "In ext2, there is a mechanism for reserving a certain number of blocks
> for a particular user (normally the super-user).  This is intended to
> keep the filesystem from filling up entirely, which helps combat
> fragmentation.  The super-user may still use this space.  Note that this
> is not a security feature, and is only provided for convenience -
> various methods exist where a user may circumvent this reservation and
> use the space if they so wish.  Quotas or separate filesystems should be
> used if reliable space limits are needed."
> 
> 
> 
> 1. http://web.mit.edu/tytso/www/linux/ext2intro.html
> 
> Design and Implementation of the Second Extended Filesystem
> 
> [....] Ext2fs reserves some blocks for the super user (root). Normally,
> 5% of the blocks are reserved. This allows the administrator to recover
> easily from situations where user processes fill up filesystems.
> 
> 
> 2. Documentation/filesystems/ext2.txt
> 
> Reserved Space
> --------------
> 
> In ext2, there is a mechanism for reserving a certain number of blocks
> for a particular user (normally the super-user).  This is intended to
> allow for the system to continue functioning even if non-priveleged
> users fill up all the space available to them (this is independent of
> filesystem quotas).  It also keeps the filesystem from filling up
> entirely which helps combat fragmentation.
> 
> 
> 3. Note what mke2fs prints:
> 
> 3275 blocks (5.00%) reserved for the super user
> 
> It does not say "reserved to combat fragmentation"
> 
> 
> -J
> 
> 
> On Mon, May 13, 2002 at 06:57:23PM +0100, Christoph Hellwig wrote:
> > On Mon, May 13, 2002 at 10:52:50AM -0700, Elladan wrote:
> > > > It is _not_ a security feature, it is meant to keep the filesystem from
> > > > fragmenting too badly. root can use that space, since root can do whatever
> > > > she wants anyway.
> > > 
> > > But it *appears* to be a security feature.  Thus, someone might
> > > incorrectly depend on it, unless it's clearly documented as otherwise.
> > 
> > So what.  People rely on chroot() as security feature all the time and
> > we don't "fix" it either.  If you need security nothing but gaining
> > knowledge about all details helps.
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

