Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbUCKWUt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUCKWUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:20:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261783AbUCKWUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:20:45 -0500
Date: Thu, 11 Mar 2004 17:20:32 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <Pine.LNX.4.44.0403111248450.1402-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403111551050.29254-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004, Hugh Dickins wrote:

> length of your essay on vma merging, it strikes me that you've taken
> a wrong direction in switching from my anon mm to your anon vma.
> 
> Go by vmas and you have tiresome problems as they are split and merged,
> very commonly.  Plus you have the overhead of new data structure per vma.

There's of course a blindingly simple alternative.  

Add every anonymous page to an "anon_memory" inode.  Then
everything is in effect file backed.  Using the same page
refcounting we already do, holes get shot into that "file".

The swap cache code provides a filesystem like mapping
from the anon_memory "files" to the on-disk stuff, or the
anon_memory file pages are resident in memory.

As a side effect, it also makes it possible to get rid
of the swapoff code, simply move the anon_memory file
pages from disk into memory...

We can avoid BSD memory object like code by simply having
multiple processes share the same anon_memory inode, allocating
extents of virtual space at once to reduce VMA count.

Not sure to which extent this is similar to what Hugh's stuff
already does though, or if it's just a different way of saying
how it's done ... I need to re-read the code ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan



