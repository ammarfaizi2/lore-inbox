Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVEPSvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVEPSvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVEPSvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 14:51:13 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12550 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261804AbVEPSvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 14:51:02 -0400
Date: Mon, 16 May 2005 20:51:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] ext2: make ext2_count_free a static inline
Message-ID: <20050516185100.GE5112@stusta.de>
References: <20050513004731.GU3603@stusta.de> <20050513224004.3f68a1e8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513224004.3f68a1e8.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 10:40:04PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> >  --- linux-2.6.12-rc2-mm3-full/fs/ext2/ext2.h.old	2005-04-20 23:08:52.000000000 +0200
> >  +++ linux-2.6.12-rc2-mm3-full/fs/ext2/ext2.h	2005-04-20 23:14:21.000000000 +0200
> >  @@ -1,5 +1,6 @@
> >   #include <linux/fs.h>
> >   #include <linux/ext2_fs.h>
> >  +#include <linux/buffer_head.h>
> >   
> >   /*
> >    * second extended file system inode data in memory
> >  @@ -79,6 +80,22 @@
> >   	return container_of(inode, struct ext2_inode_info, vfs_inode);
> >   }
> >   
> >  +static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};
> >  +
> 
> This will cause a copy of `nibblemap' to be included in each compilation
> unit which uses ext2.h.  Unless the compiler is sufficiently smart to elide
> it, which it might be.  But then it might be sufficiently smart to generate
> a "you're not usig this" warning too.

gcc never generates a warning because it's used in the "static inline" 
function ext2_count_free (whether this function is used or not doesn't 
matter).

But I get your point.

> If it's only needed for EXT2_DEBUG then I'd be inclined to move it into one
> of the other .c files, inside EXT2_DEBUG.  Or just leave it as-is.

Sounds good.

Any suggestion into which file it should be moved?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

