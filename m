Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUCSOjz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 09:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUCSOjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 09:39:55 -0500
Received: from mail.shareable.org ([81.29.64.88]:47502 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262063AbUCSOjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 09:39:53 -0500
Date: Fri, 19 Mar 2004 14:39:49 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Robert_Hentosh@Dell.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: spurious 8259A interrupt
Message-ID: <20040319143948.GD3897@mail.shareable.org>
References: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com> <20040319130609.GE2650@mail.shareable.org> <Pine.LNX.4.53.0403190825070.929@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0403190825070.929@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> > For those rare occasions when an interrupt handler wants to
> > re-enable interrupts (sti), _then_ it could mask the interrupt
> > that called the handler.
>
> It would work. However, the driver would then have to "know"
> if the interrupt came from IO-APIC or from the 8259. It also
> would have to "know" what IRQ it was actually using, etc.,

The generic interrupt handlers in Linux _do_ know all that.  They
need to, to mask the interrupt :)

The driver would not need to know: a global per-cpu variable can keep
track of where the most recent interrupt came from.

> So, all the dirty details were put in the kernel code so that the
> ISR only needs to know it was called as a result of an interrupt.

Yes, but that doesn't explain the masking.  It explains why there are
generic interrupt handlers (which know about the 8259, various APIC
etc.) and the driver interrupt handlers.

> There is no problem with masking ON/OFF the interrupt
> input to the 8259, In fact, this can be used to generate
> another (unreliable) edge if the IRQ line is still asserted.

No, there is no problem.  But there is a performance impact.  Masking
and unmasking the 8259 is an I/O operation which may be quite slow.

If we don't need it, why do we take the performance hit?

> The IRQ7 spurious is usually an artifact of a crappy motherboard
> design [+ good explanation].

Thanks.  That was very informative.

-- Jamie
