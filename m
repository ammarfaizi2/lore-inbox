Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUJVRZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUJVRZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUJVRVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:21:41 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:30621 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S266517AbUJVROa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:14:30 -0400
Date: Fri, 22 Oct 2004 19:15:28 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-ID: <20041022171528.GL14325@dualathlon.random>
References: <20041021011714.GQ24619@dualathlon.random> <200410212155.52264.jbarnes@sgi.com> <417880C3.4000807@yahoo.com.au> <200410212249.36535.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410212249.36535.jbarnes@sgi.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 10:49:36PM -0500, Jesse Barnes wrote:
> On Thursday, October 21, 2004 10:38 pm, Nick Piggin wrote:
> > That problem shouldn't exist any more, so your one zone per node (?)
> > NUMA systems, incremental min won't have any effect at all.
> 
> Well, it used to affect us, since as the allocator iterated over nodes, the 
> incremental min would increase, and so by the time we hit the 3rd or so node, 
> we were leaving quite a bit of memory unused.  I just don't want to return to 
> the bad old days.

yes, but all you care about is to turn off the incremental min, you
don't really care about lowmem_reserved, because you don't have floppies
that do ZONE_DMA allocations on ia64, x86-64 would oom-kill tasks just
because insmod floppy.o was running (and this is one of the showstopper
bugs in my queue, I had to disable forced the oom killer to workaroaund
it, apparently the vm can then later on free some page after many loops
despite without swap enabled).
