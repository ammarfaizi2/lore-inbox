Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSGNTnb>; Sun, 14 Jul 2002 15:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317037AbSGNTna>; Sun, 14 Jul 2002 15:43:30 -0400
Received: from ns.suse.de ([213.95.15.193]:8459 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317034AbSGNTn2>;
	Sun, 14 Jul 2002 15:43:28 -0400
Date: Sun, 14 Jul 2002 21:43:34 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Paul McKenney <Paul.McKenney@us.ibm.com>
Subject: Re: [patch[ Simple Topology API
Message-ID: <20020714214334.A16892@wotan.suse.de>
References: <p73ofdbv1a4.fsf@oldwotan.suse.de> <Pine.LNX.4.44.0207141156540.19060-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207141156540.19060-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 12:17:25PM -0700, Linus Torvalds wrote:
> The whole "node" concept sounds broken. There is no such thing as a node,
> since even within nodes latencies will easily differ for different CPU's
> if you have local memories for CPU's within a node (which is clearly the
> only sane thing to do).

I basically agree, but then when you go for a full graph everything
becomes very complex. It's not clear if that much detail is useful 
for the application.

> latency is _not_ a "is this memory local to this CPU" kind of number, that
> simply doesn't make any sense. The fact is, what matters is the number of
> hops. Maybe you want to allow one hop, but not five.
> 
> Then, make the memory binding interface a function of just what kind of
> latency you allow from a set X of CPU's. Simple, straightforward, and it
> has a direct meaning in real life, which makes it unabiguous.

Hmm - that could be a problem for applications that care less about
latency, but more about equal use of bandwidth (see below).
They just want their datastructures to be spread out evenly over
all the available memory controllers. I don't see how that could be
done with a single latency value; you really need some more complete
idea about the topology.

At least on Hammer the latency difference is small enough that 
caring about the overall bandwidth makes more sense.

> And then you associate that zone-list with the process, and use that
> zone-list for all process allocations.

That's the basic idea sure for normal allocations from applications
that do not care much about NUMA.

But "numa aware" applications want to do other things like: 
- put some memory area into every node (e.g. for the numa equivalent of
per CPU data in the kernel)
- "stripe" a shared memory segment over all available memory subsystems
(e.g. to use memory bandwidth fully if you know your interconnect can
take it; that's e.g. the case on the Hammer)

As I understood it this API is supposed to be the base of such an 
NUMA API for applications (just offer the information, but no way
to use it usefully yet)

More comments from the NUMA gurus please.

-Andi

