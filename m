Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbTDVMtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 08:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbTDVMtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 08:49:33 -0400
Received: from havoc.daloft.com ([64.213.145.173]:21900 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262700AbTDVMtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 08:49:31 -0400
Date: Tue, 22 Apr 2003 09:01:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: boot messages
Message-ID: <20030422130135.GA16465@gtf.org>
References: <UTC200304221245.h3MCjp122735.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200304221245.h3MCjp122735.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 02:45:51PM +0200, Andries.Brouwer@cwi.nl wrote:
> Comparing my net sources with the vanilla sources showed
> a series of differences of which I sent most to you
> a moment ago. We still have one point of discussion.
> 
> >> I suppose these can be removed altogether.
> >> For now #if 0 ... #endif.
> 
> > would it not be preferable to mark these as KERN_DEBUG instead?
> 
> I don't think so, but am willing to be convinced by Alan
> in the case of lba48 messages. In the other cases these
> messages just have to go.

FWIW, we don't like adding ifdefs to the kernel anyway.  Even if
you disagree WRT my KERN_DEBUG point, a tangent objection is also to
the #if's themselves.  I prefer a C if, or looking at the driver and
finding an appropriate existing #ifdef DEBUG construct.


> Boot messages must tell us what hardware is detected.
> We must not have debugging messages stating how
> much memory is allocated for slab cache or so.
> One can ask /proc after booting, and unless there are
> serious bugs in the code such things do not affect booting.
> 
> When disk hardware is detected, I want to see manufacturer,
> model, serial number and capacity.
> When ethernet hardware is detected, I want to see manufacturer,
> model and MAC address. (Possibly also IRQ and ioport.)

agreed

For ethernet: mmio/pio port, mac addr, irq.  Most PCI net drivers should
already do this, and patches to add missing information are welcome.


> You never reacted, so I keep saying this until you either
> take this patch or explain why in case of this particular driver
> it is a bad idea to reveal the MAC address in the boot messages.

well, you did the right thing, with resending :)


> [I have also more general patches making sure that the MAC address
> is printed in a uniform way by all drivers, but that comes later.]
> 
> Some more or less unrelated stuff below the patch.
> 
> Andries
> 
> diff -u --recursive --new-file -X /linux/dontdiff a/drivers/net/3c59x.c b/drivers/net/3c59x.c
> --- a/drivers/net/3c59x.c	Sun Apr 20 12:59:32 2003
> +++ b/drivers/net/3c59x.c	Sun Apr 20 19:07:00 2003

this looks ok to me.

In fact, I am wondering why this code wasn't here before, in fact,
because Donald Becker (original author) is usually pretty good about
printing out the MAC/etc. information for each interface found.


> A separate discussion:
> Ethernet cards are numbered differently by different kernels.
> A bit annoying, and I have tried to fix this a few times,
> but probably one just should accept it.
> The previous time this came up people answered and said:
> use "nameif".

Two points here:

1) official answer is, "if you want stable ethernet interface naming,
use nameif"

2) I have been told more than once that ethernet device allocation order
changed between 2.4 and 2.5.  I consider this a bug, and welcome patches
to fix it.  Note, though, that the recent PCI probe order fixes that
went in via Andrew Morton may have addressed this issue for some people.

	Jeff




