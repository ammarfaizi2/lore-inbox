Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313922AbSDJXCV>; Wed, 10 Apr 2002 19:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313923AbSDJXCU>; Wed, 10 Apr 2002 19:02:20 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:7299 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S313922AbSDJXCU>; Wed, 10 Apr 2002 19:02:20 -0400
Date: Wed, 10 Apr 2002 19:02:18 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
Message-ID: <20020410230218.GA7871@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CB4203D.C3BE7298@zip.com.au> <Pine.GSO.4.21.0204100725410.15110-100000@weyl.math.psu.edu> <3CB48F8A.DF534834@zip.com.au> <20020410221211.GA6076@ravel.coda.cs.cmu.edu> <3CB4B248.2807558D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 02:44:40PM -0700, Andrew Morton wrote:
> Jan Harkes wrote:
> > But Coda has 2 inodes, which one are you connecting to whose superblock.
> > My guess is that it would be correct to add inode->i_mapping->host to
> > inode->i_mapping->host->i_sb, which will be the underlying inode in
> > Coda's case, but host isn't guaranteed to be an inode, it just happens
> > to be an inode in all existing situations.
> 
> When a page is marked dirty, the path which is followed
> is page->mapping->host->i_sb.  So in this case the page will
> be attached to its page->mapping.dirty_pages, and
> page->mapping->host will be attached to page->mapping->host->i_sb.s_dirty
> 
> This is as it always was - I didn't change any of this.

As far as I can see, it should work just fine.

> > Coda's inodes don't have to get dirtied because we never write them out,
> > although the associated dirty pages do need to hit the disk eventually :)
> 
> Right.  Presumably, the pages hit the disk via the hosting inode's
> filesystem's mechanics.
>
> And it remains the case that Coda inodes will not be marked DIRTY_PAGES
> because set_page_dirty()'s page->mapping->host walk will arrive at
> the hosting inode.

Correct, we rely completely on the hosting (inode's) filesystem to
implement the actual file operations. So the hosting inode is the
one that becomes dirty and pushed to disk by bdflush.

Jan

