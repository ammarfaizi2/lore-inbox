Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132726AbRAZJQT>; Fri, 26 Jan 2001 04:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132562AbRAZJQJ>; Fri, 26 Jan 2001 04:16:09 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:18565 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S132726AbRAZJP7>; Fri, 26 Jan 2001 04:15:59 -0500
Date: Fri, 26 Jan 2001 14:43:37 +0530 (IST)
From: V Ganesh <ganesh@veritas.com>
Message-Id: <200101260913.OAA06269@vxindia.veritas.com>
To: linux-kernel@vger.kernel.org
Subject: Re: inode->i_dirty_buffers redundant ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie <sct@redhat.com> wrote:

: That would only complicate things: it would mean we'd have to scan
: both lists on fsync instead of just the one, for example.  There are a

we already do; filemap_fdatasync() is called first in sys_fsync(), though
it usually doesn't have much work I guess.

: number of places where we need buffer lists for dirty data anyway,
: such as for bdflush's background sync to disk.  We also maintain the
: per-page buffer lists as caches of the virtual-to-physical mapping to
: avoid redundant bmap()ping.  So, removing the buffer_heads which alias
: the page cache data isn't an option.  Given that, it's as well to keep
: all the inode's dirty buffers in the one place.

keeping dirty pages in the address space list doesn't preclude any of the
above. the pages could still have buffer_heads attached to them, and
these would cache the block location and be a part of the dirty buffer
list used by bdflush.
I guess both approaches would be roughly the same from a performance
point of view. I feel that keeping all data pages in the address space is more
elegant from a design point of view, but that's quite subjective, of course.

ganesh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
