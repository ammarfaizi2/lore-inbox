Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275270AbTHSBCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275278AbTHSBCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:02:18 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:22145 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275270AbTHSBCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:02:07 -0400
Date: Tue, 19 Aug 2003 02:02:05 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Paolo Ornati <javaman@katamail.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Documentation for PC Architecture
Message-ID: <20030819010205.GE11081@mail.jlokier.co.uk>
References: <200308181127.43093.javaman@katamail.com> <20030818185507.GB8297@www.13thfloor.at> <200308182244.01727.javaman@katamail.com> <20030818225422.GA23927@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030818225422.GA23927@www.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Pötzl wrote:
> On Mon, Aug 18, 2003 at 11:11:53PM +0200, Paolo Ornati wrote:
> > >
> > > > Curiosity: since the memory addresses from 640KB to 1MB are reserved for
> > > > memory mapped I/O (video memory) and BIOS ROM... the corrispondent range
> > > > in
> > >
> > > uh oh ...
> > >
> > > > the REAL MEMORY isn't usable and so we lost 384KB of memory. Is this
> > > > right?
> > >
> > > for DOS, withouth upper memory manager yes ;)
> > 
> > I'm talking about an OS in protected mode... in any case how 
> > can I access to this memory region if it's mapped for other things?
> 
> this is usually done via the MMU which can do miracolous
> things to memory and addresses ...
> 
> > I've done some tests with a simple kernel which I wrote: all that region 
> > (except video memory at 0xb8000) results "read only"...
> 
> because it is usually designated as rom area, which naturally
> is read only ... 
> 
> > So I THINK YOU mean: "you can use more than 640KB in real mode using 
> > a memory manager that "remap" 0xC0000 (for example) to 0x100000 or 
> > something like it"
> 
> basically a memory manager (depending on the processors 
> capabilities) does either use memory mapping or simple
> memory exchanging between designated regions and above
> 1M+64k memory ...

The MMU _is_ used to remap memory addresses.  It is part of the CPU itself.
But it translates what's called "virtual address" space to "physical
address space".  Physical addresses seemingly map directly to RAM and
memory-mapped I/O.

Paolo's question is, what happens to the 384k of _physical_ addresses
starting at 0xa0000, which should correspond with 384k of actual
physical RAM?

If you use the MMU to map a virtual address to the physical addresses from
0xa0000..0xfffff, then whichever virtual addresses you chose will map to
video memory, ROM, BIOS etc.

The answer is that after the MMU has translated, a _second_ address
translation takes place, outside the CPU, which maps the physical addresses
so that a hole is created in the RAM without any RAM going missing.  This
second translation is done by the motherboard chipset.

Enjyo,
-- Jamie

