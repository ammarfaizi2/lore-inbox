Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264999AbRFUPRx>; Thu, 21 Jun 2001 11:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265000AbRFUPRd>; Thu, 21 Jun 2001 11:17:33 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:3845 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S264999AbRFUPR0>; Thu, 21 Jun 2001 11:17:26 -0400
Date: Thu, 21 Jun 2001 11:16:42 -0400
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>, Stefan.Bader@de.ibm.com
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>
Subject: Re: correction: fs/buffer.c underlocking async pages
Message-ID: <470160000.993136602@tiny>
In-Reply-To: <20010621170813.F29084@athlon.random>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, June 21, 2001 05:08:13 PM +0200 Andrea Arcangeli
<andrea@suse.de> wrote:

> 
> It seems we can more simply drop the tmp->b_end_io == end_buffer_io_async
> check enterely and safely. Possibly we could build a debugging logic to
> make sure nobody ever lock down a buffer mapped on a pagecache that is
> under async I/O (which in realty is "sync" I/O, you know the async/sync
> names of the kernel io callbacks are the opposite of realty ;).
> 
> The reason it seems safe to me is that when a pagecache is under async
> I/O (async in kernel terms) it says locked all the time until the last
> call of the async I/O callback, and _nobody_ is ever allowed to mess
> with the anon bh overlapped on the pagecache while the page stays locked
> down. As far as the async end_io callback is recalled it means the page
> is still locked down so we know if the end_io callback points to
> something else it's because of a underlying remapper, nobody else would
> be allowed to play the bh of a page locked down.

Think of a mixture of fsync_inode_buffers and async i/o on page.  Since
fsync_inode_buffers uses ll_rw_block, if that end_io handler is the last to
run the page never gets unlocked.

-chris

