Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312194AbSCTVPb>; Wed, 20 Mar 2002 16:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312190AbSCTVPN>; Wed, 20 Mar 2002 16:15:13 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:24651 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S312193AbSCTVPA>; Wed, 20 Mar 2002 16:15:00 -0500
Date: Wed, 20 Mar 2002 21:17:31 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et
 al
In-Reply-To: <20020320203520.A2003@infradead.org>
Message-ID: <Pine.LNX.4.21.0203202109020.1721-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Christoph Hellwig wrote:
> On Wed, Mar 20, 2002 at 09:23:41PM +0100, Andrea Arcangeli wrote:
> > we need to walk pagetables not just from the current task and mapping
> > pagetables there would decrase the user address space too much.
> 
> Who sais it should be taken from user address space?
> For example openunix takes a small (I think 4MB) part of the normal KVA
> to be per-process mapped.

Linux would want it to come from the user address space because it has
no precedent for per-process addressing in the kernel address space,
and much simpler to keep it that way.

> > I think you're missing the problem with mainline. There is no shortage
> > of virtual address space, there is a shortage of physical ram in the
> > zone normal. So we cannot keep them in zone normal (and there's no such
> > thing as "mapping in zone_normal"). Maybe I misunderstood what you were
> > saying.
> 
> The problem is not the 4GB ZONE_NORMAL but the ~1GB KVA space.
> UnixWare/OpenUnix had huge problems getting all kernel structs for managing
> 16GB virtual into that - on the other hand their struct page is more
> then twice as big as ours..

Which is more good reason to put user-address-space-specific-mappings
(page table mappings; the filepage mapping case is less obvious) in
the user address space (but of course not accessible to the user) -
probably above user stack, since that's already of indefinite size.

Hugh

