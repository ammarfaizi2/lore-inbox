Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265127AbSJPP6T>; Wed, 16 Oct 2002 11:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbSJPP6S>; Wed, 16 Oct 2002 11:58:18 -0400
Received: from thunk.org ([140.239.227.29]:28368 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S265127AbSJPP6S>;
	Wed, 16 Oct 2002 11:58:18 -0400
Date: Wed, 16 Oct 2002 12:04:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Add extended attributes to ext2/3
Message-ID: <20021016160408.GB8210@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@digeo.com>,
	Andreas Gruenbacher <agruen@suse.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E181a3N-0006No-00@snap.thunk.org> <3DACAC0C.D4C497C1@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DACAC0C.D4C497C1@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 05:00:12PM -0700, Andrew Morton wrote:
> 
> This should be converted to use sector_t for >2TB support, and tested
> with CONFIG_LBD=y and n.
> 

It's only used to store an ext2/3 block number (not a 512 byte sector
number, but a 1k, 2k, or 4k fs block number).  

Changing it to be sector_t wouldn't hurt, but it would be less
efficient if CONFIG_LBD were turned on, since ext2/3 would only store
32 bit values into it.  If someone needed it for the future, the
change could take place then.  It's a simple change: change the type
of e_block, in mbcache.h, and the type of "block" in the function
parameters of mb_cache_entry_insert and mb_cache_entry_get, and you're
done.  No change would be needed in the ext3 code.

> The use of a dev_t search key is a bit old-fashioned.  Maybe
> use the address of inode->i_sb->s_bdev?

Sure, that would be easy enough to do.  In the next patch....

						- Ted
