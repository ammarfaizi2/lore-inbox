Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbTCGJ6r>; Fri, 7 Mar 2003 04:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbTCGJ6q>; Fri, 7 Mar 2003 04:58:46 -0500
Received: from ltgp.iram.es ([150.214.224.138]:56705 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id <S261477AbTCGJ6c>;
	Fri, 7 Mar 2003 04:58:32 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 7 Mar 2003 11:03:31 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tom Rini <trini@kernel.crashing.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       randy.dunlap@verizon.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move SWAP option in menu
Message-ID: <20030307100330.GA4758@iram.es>
References: <3E657EBD.59E167D6@verizon.net> <20030305181748.GA11729@iram.es> <20030305131444.1b9b0cf2.rddunlap@osdl.org> <20030306184332.GA23580@ip68-0-152-218.tc.ph.cox.net> <20030306193344.GA29166@iram.es> <1046984808.18158.115.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046984808.18158.115.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 09:06:49PM +0000, Alan Cox wrote:
> On Thu, 2003-03-06 at 19:33, Gabriel Paubert wrote:
> > I'd be very surprised if it were possible to have swap on a MMU-less 
> > machine (no virtual memory, page faults, etc.). Except for this nitpick, 
> > the patch looks fine, but my knowledge of MM is close to zero (and 
> > also of the new config language, but I'll have to learn it soon).
> 
> You can, and people have had swapping long before virtual memory. 

Indeed, I was unclear. A long time ago some OS I used distinguished between 
swapping (getting rid of a whole process' address space) and paging. The
former one you can implement on any machine (with restrictions), the second 
one needs an MMU and that's what CONFIG_SWAP means AFAICT.

> Most ucLinux platforms can't swap because they can't dynamically relocate code.

I believe that dynamically relocating code is fairly easy (PIC may help too), 
but data is not: how do you relocate pointers of a swapped out process when
you swap it in at a different address?

I have fuzzy memories of a system in which you had a pair of
privileged registers (base and limit) which allowed you to implement
swapping and moving programs around in physical memories: all addresses
were checked against the limit and the base was added to perform
physical accesses. I might be wrong: it was about 20 years ago and I've
used so many different systems since then. But there is no such
mechanism on a 68000 for example (you could add it externally) and
it has its own problems (no easy way of sharing library code).

(Yes we're drifting way off-topic.)

> Linux 8086 can swap because it can use CS/DS updates to relocate code/data.

Unless I miss a subtle trick, that's using the segment registers as a
poor man's MMU. You can share library code with far calls but you can't 
use "far" data pointers, can you?

> The way it worked on older systems is that you never run a program which
> isnt entirely in memory. With that constraint you know it won't suddenely
> want data you don't have.

Oh yes, I've used such systems a loooong time ago. But I can't remember
the details well enough. 

	Gabriel.
