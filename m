Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270125AbUJTMdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270125AbUJTMdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269517AbUJTMd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:33:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64521 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270125AbUJTMcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:32:05 -0400
Date: Wed, 20 Oct 2004 13:31:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: New consolidate irqs vs . probe_irq_*()
Message-ID: <20041020133158.B14627@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Anton Blanchard <anton@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
References: <16758.3807.954319.110353@cargo.ozlabs.ibm.com> <20041020083358.GB23396@elte.hu> <1098261745.6263.9.camel@gaston> <20041020100103.G1047@flint.arm.linux.org.uk> <1098269455.20955.1.camel@gaston> <20041020120140.J1047@flint.arm.linux.org.uk> <16758.20925.984734.83651@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16758.20925.984734.83651@cargo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Oct 20, 2004 at 09:53:33PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 09:53:33PM +1000, Paul Mackerras wrote:
> Russell King writes:
> 
> > Remember that PCMCIA effectively has its own IRQ router which requires
> > the PCMCIA code to know which IRQs are physically connected and which
> > aren't.  Unfortunately, there's no way to get that information as far
> > as I know except by the published method in the code.
> 
> On my powerbook, the pcmcia/cardbus controller has one interrupt,
> which is used both for card status changes and for card functional
> interrupts.  It doesn't have an ISA bus and it doesn't have an 8259
> interrupt controller, and interrupts 0-15 aren't anything like what
> they might be on a PC.  This is why (as Ben says) there is no point
> probing for interrupts, and why on ppc (or at least on powermacs) the
> probe functions are no-ops.

Correct - and Ben's comments seem to imply that yenta is wrong for doing
so.  I'm making the point that it isn't.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
