Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287345AbRL3Gdl>; Sun, 30 Dec 2001 01:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287346AbRL3Gdb>; Sun, 30 Dec 2001 01:33:31 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:51387 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287345AbRL3Gd3>;
	Sun, 30 Dec 2001 01:33:29 -0500
Date: Sun, 30 Dec 2001 01:33:24 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd 
 kern  el panic woes
In-Reply-To: <3C2EB208.B2BA7CBF@zip.com.au>
Message-ID: <Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Dec 2001, Andrew Morton wrote:

> Would it be necessary to preallocate the holes at mmap() time?  Mad
> hand-waving: Could we not perform the instantiation at pagefault time,
> and give the caller SIGBUS if we cannot allocate the blocks?  Or if
> there's an IO error, or quota exceeded.

Allocation at mmap() Is Not Going To Happen.  Consider it vetoed.
There are applications that use mmap() on large and very sparse
files.
  
> Question: can someone please define BH_New?  Its lifecycle seems
> very vague.  We never actually seem to *clear* it anywhere for 
> ext2, and it appears that the kernel will keep on treating a
> clearly non-new buffer as "new" all the time.  ext3 explicitly
> clears BH_New in get_block(), if it finds the block was already
> present in the file.  I did this because we need the newness
> info for internal purposes.

It should be reset when we submit IO.  Breakage related to failing
allocation is indeed not new, but that's a long story.  And no,
"allocate on mmap()" is not a fix.

