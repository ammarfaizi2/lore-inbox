Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275232AbTHRWyW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275233AbTHRWyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:54:21 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:16354 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S275232AbTHRWyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:54:13 -0400
Date: Tue, 19 Aug 2003 00:54:22 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Paolo Ornati <javaman@katamail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Documentation for PC Architecture
Message-ID: <20030818225422.GA23927@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Paolo Ornati <javaman@katamail.com>,
	linux-kernel@vger.kernel.org
References: <200308181127.43093.javaman@katamail.com> <20030818185507.GB8297@www.13thfloor.at> <200308182244.01727.javaman@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200308182244.01727.javaman@katamail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 11:11:53PM +0200, Paolo Ornati wrote:
> >
> > > Curiosity: since the memory addresses from 640KB to 1MB are reserved for
> > > memory mapped I/O (video memory) and BIOS ROM... the corrispondent range
> > > in
> >
> > uh oh ...
> >
> > > the REAL MEMORY isn't usable and so we lost 384KB of memory. Is this
> > > right?
> >
> > for DOS, withouth upper memory manager yes ;)
> 
> I'm talking about an OS in protected mode... in any case how 
> can I access to this memory region if it's mapped for other things?

this is usually done via the MMU which can do miracolous
things to memory and addresses ...

> I've done some tests with a simple kernel which I wrote: all that region 
> (except video memory at 0xb8000) results "read only"...

because it is usually designated as rom area, which naturally
is read only ... 

> So I THINK YOU mean: "you can use more than 640KB in real mode using 
> a memory manager that "remap" 0xC0000 (for example) to 0x100000 or 
> something like it"

basically a memory manager (depending on the processors 
capabilities) does either use memory mapping or simple
memory exchanging between designated regions and above
1M+64k memory ...

given an apropriate address mapping (via mmu) you should
be able to access the entire memory (not just the first
megabyte) without disturbing any memory mapped hardware ...

how could this be possible? simple there are 32 address
lines on a full 386 and above, which gives you 4GB of
physical memory addresses, now the memory mapped hardware
(pci,agp, but also isa) is only activated if the address
lies within a defined range. memory can be designated to
a different range, like (ep)roms ...

for example the Intel 386EX allows to define signals for
each configured memory range (chip selects) to enable or
disable the devices (memory) on demand, other systems
use some chipset/onboard logic to do this ...

> Right?
> 
> bye,
> 	Paolo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
