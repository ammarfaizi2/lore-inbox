Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbTBETmp>; Wed, 5 Feb 2003 14:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbTBETmo>; Wed, 5 Feb 2003 14:42:44 -0500
Received: from [195.223.140.107] ([195.223.140.107]:20864 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264711AbTBETmm>;
	Wed, 5 Feb 2003 14:42:42 -0500
Date: Wed, 5 Feb 2003 20:51:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205195151.GJ19678@dualathlon.random>
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205114353.6591f4c8.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205114353.6591f4c8.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 11:43:53AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > In this context I don't mind which is the correct one.
> > 
> > I only would like to know what is supposed to be stored inside the
> > 2.5.59 tarball on kernel.org and what is supposed to be changed between
> > 2.5.59 and the 1.952.4.2 changeset.
> > 
> > The one I see in 2.5.59 (I double checked the tar.gz) is this:
> > 
> > void jfs_truncate(struct inode *ip)
> > {
> > 	jFYI(1, ("jfs_truncate: size = 0x%lx\n", (ulong) ip->i_size));
> > 
> > 	block_truncate_page(ip->i_mapping, ip->i_size, jfs_get_block);
> > 
> > And I see no changes in this area starting from 2.5.59, until changeset
> > 1.952.4.2. So I deduce my software is right and that either the 2.5.59
> > tarball or the 1.952.4.2 changeset are corrupt.
> 
> OK.  I see.
> 
> No, I cannot explain this either.  Shortly after 2.5.55, this change appears in the
> web interface:
> 
> 
> http://linux.bkbits.net:8080/linux-2.5/cset@1.879.43.1?nav=index.html|ChangeSet@-8w

yes I found it too a few minutes ago.

> 
> And revtool shows that change on Jan 09 this year.
> 
> But it does not appear in Linus's 2.5.59 tarball, and there appears to be no
> record in bitkeeper of where this change fell out of the tree.

yes, this is exactly the problem I run into.

> 
> In fact the above URL shows two instances of the same patch, with different
> human-written summaries, on the same day.
> 
> I believe that shaggy had some problem with the nobh stuff, so possibly the
> January 9 change was reverted in some manner, and it was reapplied
> post-2.5.59, and the web interface does now show the revert.  Revtool does
> not show it either.  Nor the reapply.
> 
> It is quite confusing.  Yes, something might have gone wrong.

it might be simply an error in the tarball, maybe Linus's tree isn't in
full sync with bk head. But something definitely is corrupt between
tarball and bk.

Andrea
