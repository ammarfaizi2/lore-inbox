Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbUCSNGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbUCSNGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:06:18 -0500
Received: from mail.shareable.org ([81.29.64.88]:40334 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262930AbUCSNGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:06:14 -0500
Date: Fri, 19 Mar 2004 13:06:10 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Robert_Hentosh@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: spurious 8259A interrupt
Message-ID: <20040319130609.GE2650@mail.shareable.org>
References: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert_Hentosh@Dell.com wrote:
> >  IRQ10 asserted
> >  INTACK cycle lets PIC deliver vector to processor
> >  processor masks IRQ10 in PIC
> >  processor sends EOI command to PIC
> >  processor reads a status register in the NIC, which causes IRQ10 to be
> >  deasserted
> >  processor unmasks IRQ10 in PIC

> The PIC defaults to IRQ7 because of its design, when IRQ10 was already
> cleared. Sticking delays in is not viable in a generic ISR routing.  A
> possible fix to this issue would be to issue the EOI after the read to
> the status register on the NIC, and I see some documentation on the PIC
> that actually suggests that this is the way to service an interrupt.
> This seemed like a risky change, since sending the EOI and using the
> mask has been in use for some time and the change would effect all
> devices using interrupts.

That reminds me: why does Linux mask the IRQ anyway?

Why doesn't it simply call the handler functions, and then send EOI to
the PIC with no unmasking?

For those rare occasions when an interrupt handler wants to re-enable
interrupts (sti), _then_ it could mask the interrupt that called the handler.

Why wouldn't that work?

-- Jamie
