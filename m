Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVKUWJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVKUWJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVKUWJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:09:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:55241 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751097AbVKUWJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:09:30 -0500
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>
In-Reply-To: <Pine.LNX.4.64.0511211339450.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
	 <24299.1132571556@warthog.cambridge.redhat.com>
	 <20051121121454.GA1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
	 <20051121190632.GG1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
	 <20051121194348.GH1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
	 <20051121211544.GA4924@elte.hu>
	 <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0511211339450.13959@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 09:06:42 +1100
Message-Id: <1132610802.26560.44.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On all PC hardware, having a zero in the PCI irq register basically means 
> that no irq is enabled. That's a _fact_. It's a fact however much you may 
> not like it. It's how the hardware comes up, and it's how the BIOS leaves 
> it. So "0" absolutely does mean "not allocated". 

It's not the case on various non-x86 architectures, not the case in the
PCI spec neither.

> Now, the second part of the story is that when it comes to PCI, it doesn't 
> matter what Apple, Sun, or pretty much anybody else has done.  The reason 
> PCI has a separate MMIO and IO space is that it comes from a PC 
> background, and the reason Apple and others use PCI is that through that, 
> there are thousands of controller cards that are sold for PC's that also 
> happen to work on non-PC's.

And ?

> So PC usage really is a defining part of PCI. It's what defines basically 
> _all_ of the testing, even under Linux. 
> 
> So let's face those facts:
>  - we have a 8-bit register (0-255) for firmware telling the kernel what 
>    the pre-allocated interrupt is.

That register is mostly useless on a wide range of architectures tho :)

>  - all of those 256 numbers _may_ in fact be valid on some piece of 
>    hardware.
>  - only one of those numbers (0) is de-facto the "no irq line set up" 
>    value.

No, it's not.

>  - pretty much all drivers have been tested mainly with 0 being the "no 
>    irq" value.
> 
> Those are FACTS. Denying them is a sign of stupidity.

I must have lost a lot of neurons in the past few years then.

> I'd suggest that if some architecture can't live with those facts, it 
> either:
> 
>  - define it's own PCI_NO_IRQ value, and face the fact that it will have 
>    to test the drivers and hope they work (and that a lot of them simply 
>    will _not_ work). 

Very few driver bother at all about the irq value. Most don't test it,
they just use it and be done with it, and that's the way it works. Some
drivers, mostly ISA stuff or legacy stuff or drivers that deal with old
weird chipsets actually look at the irq value, and those can be easily
fixed to use NO_IRQ. I really don't understand why you are making such a
fuss about this...


