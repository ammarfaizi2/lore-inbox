Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291418AbSBMGhM>; Wed, 13 Feb 2002 01:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291421AbSBMGhF>; Wed, 13 Feb 2002 01:37:05 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:38413 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id <S291418AbSBMGgz>;
	Wed, 13 Feb 2002 01:36:55 -0500
Message-Id: <200202130752.g1D7qDL22868@clueserver.org>
Content-Type: text/plain; charset=US-ASCII
From: Alan <alan@clueserver.org>
Reply-To: alan@clueserver.org
To: John Weber <john.weber@linuxhq.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.4 sound module problem
Date: Tue, 12 Feb 2002 21:18:17 -0800
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <fa.f4gi5iv.1ikenrc@ifi.uio.no> <fa.fo94urv.167g1q5@ifi.uio.no> <3C69F385.5050207@linuxhq.com>
In-Reply-To: <3C69F385.5050207@linuxhq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 February 2002 21:03, John Weber wrote:
> Alan wrote:
> > On Tuesday 12 February 2002 19:51, Albert Cranford wrote:
> >>Not sure if this was the same message I received. but here
> >>is the patch I used to get around my sound problem in
> >>2.5.4.
> >
> > Are you sure this is correct?  include/asm/io.h seems to indicate that
> > i/o addresses for PCI may not map correctly.  The sound card I am using
> > is PCI, not ISA.
>
> You should not use isa_virt_to_bus.  IIRC someone on this list worried
> about this exact thing happening.

Glad I checked before adding the patch... ]:>

> > Documentation/DMA-mapping.txt says that virt_to_bus is completly
> > depreciated and nothing should be using it.  Well, grepping the kernel
> > source shows that quite a bit still uses it.
>
> This is on the kernel janitor TODO, and we (janitors) will be tackling
> this shortly.  But your instinct is right, virt_to_bus shouldn't be
> everywhere.

IMHO 2.5.4 is pretty broken until that gets fixed.  the list is pretty long 
as well.

> > What it looks like, on first glance, is that virt_to_bus  was changed for
> > pci devices to give this error message.  (Since that symbol goes
> > nowhere.)  That effects a number of things, not just sound. (A whole
> > bunch of cardbus drivers I would guess...)
>
> This is correct.  It has been a policy to use pci_alloc_consistent
> instead of kmalloc/getfreepages and virt_to_bus, 2.5 is enforcing it now.

By breaking sound (in dmabuf and sound modules), cardbus (lots of places), 
and who knows what else.

"grep -r virt_to_bus | less" shows jut how bad it is going to be...

> It is boring work to change this in many drivers, but I don't know any
> better so I think it quite fun to go in and help :).  I'll start sending
> patches to the relevant maintainers shortly.

Thanks.

It just makes me wonder if anyone actually compiled this and ran it before it 
was released.

Back to 2.4.x land for a while i guess... (At least on this machine.)

