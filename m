Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315251AbSEGXDZ>; Tue, 7 May 2002 19:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315255AbSEGXDY>; Tue, 7 May 2002 19:03:24 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:52391 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315251AbSEGXDX>;
	Tue, 7 May 2002 19:03:23 -0400
Date: Wed, 8 May 2002 08:57:52 +1000
From: Anton Blanchard <anton@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Engebretsen <engebret@vnet.ibm.com>, linux-kernel@vger.kernel.org,
        jbarnes@sgi.com
Subject: Re: Memory Barrier Definitions
Message-ID: <20020507225752.GA21321@krispykreme>
In-Reply-To: <3CD830BE.CAB7FA96@vnet.ibm.com> <E175BY8-0008S4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You have
> 
> 	Compiler ordering
> 	CPU v CPU memory ordering
> 	CPU v I/O memory ordering
> 	I/O v I/O memory ordering

Yep. Maybe we could have:

CPU v CPU	smp_*mb or cpu_*mb 
CPU v I/O	*mb
I/O v I/O	io_*mb

Then again before Linus hits me on the head for hoarding vowels,

http://hypermail.spyroid.com/linux-kernel/archived/2001/week41/1270.html

I should suggest we make these a little less cryptic:

CPU v CPU	cpu_{read,write,memory}_barrier
CPU v I/O	{read,write,memory}_barrier
I/O v I/O	io_{read,write,memory}_barrier

> and our current heirarchy is a little bit more squashed than that. I'd 
> agree. We actually hit a corner case of this on the IDT winchip x86 where
> we run relaxed store ordering and have to define wmb() as a locked add of
> zero to the top of stack - which does have a penalty that isnt needed
> for CPU ordering.
> 
> How much of this impacts Mips64 ?

I remember some ia64 implementations have issues. Jesse, could you
fill us in again? I think you have problems with out of order
loads/stores to noncacheable space, right?

Anton
