Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbUDHSs2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUDHSs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:48:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:55220 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262244AbUDHSs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:48:26 -0400
Date: Thu, 8 Apr 2004 19:48:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: rmap: page_mapping barrier
In-Reply-To: <20040408180749.GL31667@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0404081936400.7559-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004, Andrea Arcangeli wrote:
> 
> I'll do further checking on this when I'm back from vacations on 14,

Have a good one.

> though if you didn't find anything by that time it most certainly means
> there's no race ;).

I'm afraid we can't deduce the nonexistence of a race from my failure
to search very hard.

> I don't want to discourage you in searching for more
> races in this area ;), I just don't see problems. BTW, if my tree will
> have a problem here, anonmm should have it too, maybe the other way

Oh yes, we're quite equal on this: I wasn't trying to blacken
your approach, just raising an issue and asking for help.

> around not (really Hugh, my approch of being transparent with
> page_mapping if far superior, you may find it ugly to check for
> swapper_inode in the pagecache entry/exit points but then it gets
> everything right and more obviously, just see the backing-dev-unplugging
> code, and the swap_unplug_fn stuff, I only had to change a page->mapping
> into a page_mapping in block_sync_page [the per-mapping unplug stuff]
> and everything else just worked without rejects).

On that we differ, and always shall, I expect.  Yes, carrying around
the PageSwapCache? &swapper_space stuff does make sync_page look
cleaner, and shrink_list quite a lot easier - I gave up on trying to
eliminate it completely, would uglify shrink_list too much.  But it
is a fiction, and for everywhere else (I think that's correct) it's
just baggage - made sense when you could stuff it in page->mapping
and then forget about it, but a lot less sense if we have to check
PageSwapCache all over (even if that is hidden in an inline function).

Hugh

