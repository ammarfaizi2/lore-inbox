Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312208AbSCTVfd>; Wed, 20 Mar 2002 16:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312235AbSCTVfQ>; Wed, 20 Mar 2002 16:35:16 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25444 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312213AbSCTVfE>; Wed, 20 Mar 2002 16:35:04 -0500
Date: Wed, 20 Mar 2002 22:34:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
Message-ID: <20020320223425.P4268@dualathlon.random>
In-Reply-To: <127930000.1016651345@flay> <20020320212341.M4268@dualathlon.random> <20020320203520.A2003@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 08:35:20PM +0000, Christoph Hellwig wrote:
> On Wed, Mar 20, 2002 at 09:23:41PM +0100, Andrea Arcangeli wrote:
> > we need to walk pagetables not just from the current task and mapping
> > pagetables there would decrase the user address space too much.
> 
> Who sais it should be taken from user address space?
> For example openunix takes a small (I think 4MB) part of the normal KVA
> to be per-process mapped.

The only difference is that taking it from kernel space would require to
have different a whole block of 4k*512 naturally aligned virtual space
with PAE or 4k * 1024 w/o PAE. So taking it from userspace saves some
mbyte of kernel virtual address space. Also the higher level pagetables
there won't generate more overhead because they're necessary for the
previous user stack anyways.

> 
> > I think you're missing the problem with mainline. There is no shortage
> > of virtual address space, there is a shortage of physical ram in the
> > zone normal. So we cannot keep them in zone normal (and there's no such
> > thing as "mapping in zone_normal"). Maybe I misunderstood what you were
> > saying.
> 
> The problem is not the 4GB ZONE_NORMAL but the ~1GB KVA space.

Then you misunderstood what's the zone-normal, the zone normal is 800M
in size not 4GB. The 1GB of KVA is what constraint the size of the zone
normal to 800M. We're talking about the same thing, just looking at it
from different point of views.

> UnixWare/OpenUnix had huge problems getting all kernel structs for managing
> 16GB virtual into that - on the other hand their struct page is more
> then twice as big as ours..

We do pretty well with pte-highmem, there is some other bit that will be
better to optimize, but nothing major.

Andrea
