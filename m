Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136671AbREARXS>; Tue, 1 May 2001 13:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136672AbREARXI>; Tue, 1 May 2001 13:23:08 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:1035 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136671AbREARXC>; Tue, 1 May 2001 13:23:02 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
Date: 1 May 2001 10:22:39 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9cmrcv$20e$1@penguin.transmeta.com>
In-Reply-To: <OF7A9C6B22.E1638E60-ON85256A3F.004EADC7@urscorp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <OF7A9C6B22.E1638E60-ON85256A3F.004EADC7@urscorp.com>,
 <mike_phillips@urscorp.com> wrote:
>>mike_phillips@urscorp.com wrote:
>>> 
>>> To get the pcmcia ibmtr driver (ibmtr/ibmtr_cs) working on ppc, all the
>>> isa_read/write's have to be changed to regular read/write due to the 
>lack
>>> of the isa_read/write functions for ppc.
>
>> Treat it like a PCI device and use ioremap().  Then change isa_readl()
>> to readl() etc.
>
>Bleurgh, the latest version of the driver (not in the kernel yet) searches 
>for turbo based cards by checking the isa address space from 0xc0000 - 
>0xe0000 in 8k chunks. So we'd have to ioremap each 8k section, check it, 
>find out the adapter isn't there and then iounmap it. 
>
>Oh well, if that's what it takes =:0

I would suggest the opposite approach instead: make the PPC just support
isa_readx/isa_writex instead.

Much simpler, and doesn't need changes to (correct) driver sources.

I bet that the patch will be smaller too. It's a simple case of
 - do the ioremap() _once_ at bootup, save the result in a static
   variable somewhere.
 - implement the (one-liner) isa_readx/isa_writex functions.

On many architectures you don't even need to do the ioremap, as it's
always available (same as on x86).

		Linus
