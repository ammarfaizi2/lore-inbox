Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUCLST1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 13:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbUCLST0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 13:19:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9445 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262381AbUCLSSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 13:18:48 -0500
Date: Fri, 12 Mar 2004 13:18:30 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040312174429.GE30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403121314590.6494-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Andrea Arcangeli wrote:
> On Fri, Mar 12, 2004 at 12:23:22PM -0500, Rik van Riel wrote:

> > ... and use the offset into the struct address_space as
> > the page->index, NOT the virtual address inside the mm.

> As I said in the last email the prio_tree will not work for the
> anonvmas, because every vma in the same range will map to different
> pages. So you'll find more vmas than the ones you're interested about.
> This doesn't happen with inodes. with inodes every vma queued into the
> i_mmap will be mapping to the right page _if_ it's pte_present == 1.

You don't have multiple VMAs mapping to same pages, but in
the same range in the address_space.

Note that the per-process virtual memory != per "fork-group"
backing address_space ...

> with your anonymous address space shared by childs the prio_tree will
> find lots of vmas in different vma->vm_mm, each one pointing to
> different pages.

Nope.  I wish I was better with graphical programs, or I'd
draw you a picture. ;)

> > Having the same code everywhere will definately help
> > simplifying things.
> 
> Reusing the same code would be good I agree, but I don't think it would
> work as well as with the inodes,

> prio_tree is not free, it's still O(log(N)) and I prefer a design where
> the common case is N == 1 like with anon_vma (with your address-space
> design N would be >1 normally in a server app).

It's all a space-time overhead.  Do you want more structures
allocated and a more complex mremap, or do you eat the O(log(N))
lookup ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

