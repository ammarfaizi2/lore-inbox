Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbUCMTfu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 14:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUCMTfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 14:35:50 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:34804 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263170AbUCMTfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 14:35:48 -0500
Date: Sat, 13 Mar 2004 19:35:49 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040313181352.GN30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403131915490.3730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2004, Andrea Arcangeli wrote:
> 
> yes, we should split in two patches, one is the "peparation" for a
> reused page->as.mapping, you know I did it differently to retain the
> swapper_space and avoiding to hook explicit "if (PageSwapCache)" checks
> into things like sync_page.
> 
> About using the union, I still prefer it, I've seen Linus in the
> pseudocode used an explicit cast too, but I don't feel safe with
> explicit casts, I prefer more breakage, than risking to forget
> converting any page->mapping into page_maping or similar issues with the
> casts ;)

Your union is right, and my casting lazy, no question of that.
It's just that we'd need to do a whole lot of cosmetic edits
to get fully building trees, distracting from the guts of it.

In my case, anyway, the number of places that actually use the
casting are very few (just rmap.c?), suspect it's same for you.

I'm certainly not arguing against sanity checks where needed,
just against treewide edits (or broken builds) for now.

> I'll return working on this after the weekend. You can find my latest
> status on the ftp, if you extract any interesting "common" bit from
> there just send it to me too. thanks.

Thanks a lot.  I don't imagine you've done the nonlinear vma case
yet, but when you or Rajesh do, please may I just steal it, okay?

Hugh

