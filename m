Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154044AbQAXWzb>; Mon, 24 Jan 2000 17:55:31 -0500
Received: by vger.rutgers.edu id <S154260AbQAXWl2>; Mon, 24 Jan 2000 17:41:28 -0500
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:33684 "EHLO mailhost.uni-koblenz.de") by vger.rutgers.edu with ESMTP id <S154462AbQAXWeZ>; Mon, 24 Jan 2000 17:34:25 -0500
Date: Tue, 25 Jan 2000 03:38:07 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Jamie Lokier <lkd@tantalophile.demon.co.uk>
Cc: dg50@daimlerchrysler.com, linux-kernel@vger.rutgers.edu
Subject: Re: SMP Theory (was: Re: Interesting analysis of linux kernel threading by IBM)
Message-ID: <20000125033807.B6090@uni-koblenz.de>
References: <OFC8E00C6C.FBE80B06-ON85256870.007B8178@notes.chrysler.com> <20000125005645.A5940@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20000125005645.A5940@pcep-jamie.cern.ch>
X-Accept-Language: de,en,fr
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, Jan 25, 2000 at 12:56:45AM +0100, Jamie Lokier wrote:

> dg50@daimlerchrysler.com wrote:
> > If this is indeed the case (please correct any misconceptions I have) then
> > it strikes me that perhaps the hardware design of SMP is broken. That
> > instead of sharing main memory, each processor should have it's own main
> > memory. You connect the various main memory chunks to the "primary" CPU via
> > some sort of very wide, very fast memory bus, and then when you spawn a
> > thread, you instead do something more like a fork - copy the relevent
> > process and data to the child cpu's private main memory (perhaps via some
> > sort of blitter) over this bus, and then let that CPU go play in its own
> > sandbox for a while.
> 
> I think you just reinvented NUMA -- Non-Uniform Memory Access.  Every
> CPU can access the others' memory, but you really want them to
> concentrate on their own.  SGI does some boxes like that.

SGI does ccNUMA, cache coherent NUMA.  The difference is that unlike in
`real' NUMA machines each processor on a node has access to memory in each
node directly.  A node in an Origin system is a dual CPU SMP system.

> Linux even has a memory allocator which is moving in the direction of
> supporting those things.

It's actually the start of the support for the Origin series but other
systems are expected to jump the wagon.

> > Which really is more like the "array of uni-processor boxen joined by a
> > network" model than it is current SMP - just with a REALLY fast&wide
> > network pipe that just happens to be in the same physical box.
> 
> It's been proposed to have multiple instances of the OS running too,
> instead of one OS running on all CPUs.

Ok, but users and application developers still want the entire system to
feel like a single system.

  Ralf

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
