Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314375AbSEMSRS>; Mon, 13 May 2002 14:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314377AbSEMSRR>; Mon, 13 May 2002 14:17:17 -0400
Received: from rj.SGI.COM ([192.82.208.96]:3477 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S314375AbSEMSRQ>;
	Mon, 13 May 2002 14:17:16 -0400
Date: Mon, 13 May 2002 11:16:52 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Anton Blanchard <anton@samba.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Dave Engebretsen <engebret@vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory Barrier Definitions
Message-ID: <20020513181652.GC1236450@sgi.com>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dave Engebretsen <engebret@vnet.ibm.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CD830BE.CAB7FA96@vnet.ibm.com> <E175BY8-0008S4-00@the-village.bc.nu> <20020507225752.GA21321@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 08:57:52AM +1000, Anton Blanchard wrote:
> 
> > You have
> > 
> > 	Compiler ordering
> > 	CPU v CPU memory ordering
> > 	CPU v I/O memory ordering
> > 	I/O v I/O memory ordering
> 
> Yep. Maybe we could have:
> 
> CPU v CPU	smp_*mb or cpu_*mb 
> CPU v I/O	*mb
> I/O v I/O	io_*mb
> 
> Then again before Linus hits me on the head for hoarding vowels,
> 
> http://hypermail.spyroid.com/linux-kernel/archived/2001/week41/1270.html
> 
> I should suggest we make these a little less cryptic:
> 
> CPU v CPU	cpu_{read,write,memory}_barrier
> CPU v I/O	{read,write,memory}_barrier
> I/O v I/O	io_{read,write,memory}_barrier
> 
> > and our current heirarchy is a little bit more squashed than that. I'd 
> > agree. We actually hit a corner case of this on the IDT winchip x86 where
> > we run relaxed store ordering and have to define wmb() as a locked add of
> > zero to the top of stack - which does have a penalty that isnt needed
> > for CPU ordering.
> > 
> > How much of this impacts Mips64 ?
> 
> I remember some ia64 implementations have issues. Jesse, could you
> fill us in again? I think you have problems with out of order
> loads/stores to noncacheable space, right?

Both MIPS64 and our NUMA IA64 implementation have weakly ordered I/O.
The primitives outlined above should be sufficient to order I/O and
memory references on both platforms without unnecessary penalties.
Thanks for adding me to the Cc: list, sorry it took me so long to
respond.

It might also be good to summarize the ordering issues in a document
in the Documentation directory.  I've got a little something started
(see the ia64 patch for 2.5) for I/O ordering, and I have another
document that covers CPU memory ordering too that I could probably
contribute.

Thanks,
Jesse
