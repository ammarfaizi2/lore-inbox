Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316482AbSEUBRe>; Mon, 20 May 2002 21:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316483AbSEUBRd>; Mon, 20 May 2002 21:17:33 -0400
Received: from bitmover.com ([192.132.92.2]:55728 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316482AbSEUBRb>;
	Mon, 20 May 2002 21:17:31 -0400
Date: Mon, 20 May 2002 18:17:31 -0700
From: Larry McVoy <lm@bitmover.com>
To: Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] push down inclusion of buffer_head.h into users
Message-ID: <20020520181731.K2996@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020520190033.A414@infradead.org> <20020521011108.A22488@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

while it is true that BK will do the right thing if Linus applies this patch
and then you pull it, it's a lot nicer if you let him pull your tree.  

The problem is that you're going to have this in your tree as one delta and
Linus will have it in his tree as another delta.  When you pull, the data
will be in the tree twice.  That's not critical in this case, the amount of
data is relatively small, but it's still sort of messy.  While we can work
out that it is duplicate and make it so you don't have to merge it, it
increases the size of the revision history.  No big deal just this once,
but if everyone does this then we'll eventually get to a revision history
which is a lot less useful because of all the duplicates you have to wade
through to see why something was added.


On Tue, May 21, 2002 at 01:11:08AM +0100, Christoph Hellwig wrote:
> On Mon, May 20, 2002 at 07:00:33PM +0100, Christoph Hellwig wrote:
> > Now that fs.h grow due to the lock.h removal let's reduce it's overhead
> > again:  Instead of penalizing ever user of fs.h with the overhead of the
> > buffer head interface let it's users include it directly.
> > 
> > This also shows nicely which parts of the core kernel still depend on the
> > buffer head interface, and allows that to be cleaned up properly.
> > 
> > Please drop me a note if you have a reason to not include it as it is
> > painfull to update due to the number of files touched.
> 
> Updated to the latest BK tree, UP compilation failures fixed.
> Please include.
> 
> ===== drivers/block/blkpg.c 1.31 vs edited =====
> --- 1.31/drivers/block/blkpg.c	Sun May 19 13:49:48 2002
> +++ edited/drivers/block/blkpg.c	Tue May 21 01:46:38 2002
> @@ -36,6 +36,7 @@
>  #include <linux/genhd.h>
>  #include <linux/module.h>               /* for EXPORT_SYMBOL */
>  #include <linux/backing-dev.h>
> +#include <linux/buffer_head.h>
>  
>  #include <asm/uaccess.h>
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
