Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTBESgb>; Wed, 5 Feb 2003 13:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbTBESgb>; Wed, 5 Feb 2003 13:36:31 -0500
Received: from [195.223.140.107] ([195.223.140.107]:18816 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S263366AbTBESg2>;
	Wed, 5 Feb 2003 13:36:28 -0500
Date: Wed, 5 Feb 2003 19:45:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205184535.GG19678@dualathlon.random>
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205102308.68899bc3.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 10:23:08AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> >  void jfs_truncate(struct inode *ip)
> >  {
> > -       jFYI(1, ("jfs_truncate: size = 0x%lx\n", (ulong) ip->i_size));
> > +       jfs_info("jfs_truncate: size = 0x%lx", (ulong) ip->i_size);
> > 
> >         nobh_truncate_page(ip->i_mapping, ip->i_size);
> > 	^^^^^^^^^^^^^^^^^^
> 
> This is the correct version.  Since 2.5.59, jfs was switched over to not use
> buffer_heads.

In this context I don't mind which is the correct one.

I only would like to know what is supposed to be stored inside the
2.5.59 tarball on kernel.org and what is supposed to be changed between
2.5.59 and the 1.952.4.2 changeset.

The one I see in 2.5.59 (I double checked the tar.gz) is this:

void jfs_truncate(struct inode *ip)
{
	jFYI(1, ("jfs_truncate: size = 0x%lx\n", (ulong) ip->i_size));

	block_truncate_page(ip->i_mapping, ip->i_size, jfs_get_block);

And I see no changes in this area starting from 2.5.59, until changeset
1.952.4.2. So I deduce my software is right and that either the 2.5.59
tarball or the 1.952.4.2 changeset are corrupt.

I can't yet fetch a full tree out of bitkepper yet (you know the network
protocol must be reverse engeneered first), I can only fetch
incrementals with metadata and raw patch so far because this is the
thing I care about most, after I've all the changesets in live form in
my db I don't mind too much about the ability to checkout a the whole
tree too, since I can do the same starting from my open db rather than
using the proprietary one.

Andrea
