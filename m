Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbUCLQZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 11:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUCLQZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 11:25:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38297 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261738AbUCLQZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 11:25:41 -0500
Date: Fri, 12 Mar 2004 11:25:27 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040312131103.GS30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403121121500.6494-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Andrea Arcangeli wrote:

> I don't see what you mean with sharing the same address space between
> parent and child, whatever _global_ mm wide address space is screwed by
> mremap, if you don't use the pg_off to ofset the page->index, the
> vm_start/vm_end means nothing.

At mremap time, you don't change the page->index at all,
but only the vm_start/vm_end.  Think of it as an mm_struct
pointing to a struct address_space with its anonymous
memory.  On exec() the mm_struct gets a new address_space,
on fork parent and child share them.

Sharing is good enough, because there is PAGE_SIZE times
more space in a struct address_space than there's available
virtual memory in one single process.  That means that for
a daemon like apache every child can simply get its own 4GB
subset of the address space for any new VMAs, while mapping
the inherited VMAs in the same way any other file is mapped.

> I think the anonmm design is flawed and it has no way to handle
> mremap reasonably well,

There's no difference between mremap() of anonymous memory
and mremap() of part of an mmap() range of a file...

At least, there doesn't need to be.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

