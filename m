Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293156AbSCEFRH>; Tue, 5 Mar 2002 00:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293154AbSCEFQ6>; Tue, 5 Mar 2002 00:16:58 -0500
Received: from rj.sgi.com ([204.94.215.100]:1424 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S293052AbSCEFQp>;
	Tue, 5 Mar 2002 00:16:45 -0500
Date: Mon, 4 Mar 2002 21:16:13 -0800 (PST)
From: Samuel Ortiz <sortiz@dbear.engr.sgi.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Matt Dobson <colpatch@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <265890000.1015293303@flay>
Message-ID: <Pine.LNX.4.33.0203042109060.12307-100000@dbear.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Mar 2002, Martin J. Bligh wrote:

> > it's not more complex than the current way, it's just different and it's
> > not strict, but it's the best one for allocations that doesn't "prefer"
> > memory from a certain node, but OTOH we don't have an API to define
> > 'waek' or 'strict' allocation bheaviour so the default would better be
> > the 'strict' one like in oldnuma. Infact in the future we may want to
> > have also a way to define a "very strict" allocation, that means it
> > won't fallback into the other nodes at all, even if there's plenty of
> > memory free on them.  An API needs to be built with some bitflag
> > specifying the "strength" of the numa affinity required. Your layout
> > provides the 'weakest' approch, that is perfectly fine for some kind of
> > non-numa-aware allocations, just like "very strict" will be necessary
> > for the relocation bindings (if we cannot relocate in the right node
> > there's no point to relocate in another node, let's ingore complex
> > topologies for now :).
>
> Actually, we (IBM) do have a simple API to do this that Matt Dobson
> has been working on that's nearing readiness (& publication). I've
> been coding up a patch to _alloc_pages today that has both a strict
> and non-strict binding in it. It first goes through your "preferred" set of
> nodes (defined on a per-process basis), then again looking for any
> node that you've not strictly banned from the list - I hope that's
> sufficient for what you're discussing? I'll try to publish my part tommorow,
> definitely this week - it'll be easy to see how it works in conjunction with
> the API, though the rest of the API might be a little longer before arrival ....
SGI's CpuMemSets is supposed to do that as well. We are now able to bind a
process to a set of memories, and soon we will be able to specify how
strict the allocation can be. Right now, if a process is allowed to
allocate memory from node 0, 2, and 3, it won't look outside of this set.
The memory set granularity is smaller though, because it depends on the
process, and the cpu (and thus the node) this process is running on.
The CpuMemSets have been tested and are available on the Linux Scalability
Effort sourceforge page, if you want to give it a try...

Samuel.



