Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135841AbRDTJnS>; Fri, 20 Apr 2001 05:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135839AbRDTJnJ>; Fri, 20 Apr 2001 05:43:09 -0400
Received: from cs.columbia.edu ([128.59.16.20]:53122 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S135838AbRDTJnF>;
	Fri, 20 Apr 2001 05:43:05 -0400
Date: Fri, 20 Apr 2001 02:42:55 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Roberto Nibali <ratz@tac.ch>
cc: <linux-kernel@vger.kernel.org>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <3ADFFB56.A9C84A2@tac.ch>
Message-ID: <Pine.LNX.4.33.0104200227420.5165-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2001, Roberto Nibali wrote:

> Hmm, but doesn't the code in 2.4.x improve the hard IRQ signal delivery
> even for UP systems with a local APIC table? I have an APIC aware board
> but I have only got 1 CPU on it and I currently need to run 2.2 kernel.
> But if you tell me that there is not much help, I'm ok with that, as 
> long as it wouldn't be better with APIC support :)

I think the UP-APIC support was added primarily to support the NMI oopser 
on UP systems. I might be wrong, though.

> > Well.. Space.c is a dinozaur. However, this is the 2.2 series and no more
> > surgery will happen on this kernel, at least normally.
> 
> So, what is your suggestion: Does this limitation do any harm or can I
> live with that and still run 16 eth devices and safely disregard the
> "early initialization ..." ?

You can safely disregard the "early initialization deferred" messages. 
They are essentially harmless.

As for the 16 eth ports limit, if you want to increase it, simply edit 
drivers/net/net_init.c and change the value of MAX_ETH_CARDS. This limit 
appears to also affect modules, so my earlier suggestion of using modules 
wouldn't have helped.

> > Because, again, this is legacy code. It works, it does the job, that's it.
> > All this crap is gone in 2.4.
> 
> I'll be porting my distribution to 2.4.x soon I think :)

If the only thing you need from your boxes is networking-related, than 
it's probably ok. Otherwise I'd wait a bit longer before putting 2.4 on 
production servers...

> Your driver works now and for me now need to mark it experimental. 

Yeah, I guess I'll submit a patch to remove the experimental bit, after 
the current code changes are accepted..

> It also works statically built into the kernel up to 4 quadboards. I
> hacked Space.c and enhanced the ``static struct device ethX_dev = { };''
> stuff.

You shouldn't need to do that, it's just wasted memory. The ethX_dev was
used mostly to avoid probing for ISA cards, which is completely irrelevant
when using PCI cards. As for the 4 quadboards limit, see above -- all you
need to change is MAX_ETH_CARDS.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.



