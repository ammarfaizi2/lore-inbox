Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269926AbUJTLKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269926AbUJTLKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270017AbUJTLH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:07:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47368 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269917AbUJTLBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:01:53 -0400
Date: Wed, 20 Oct 2004 12:01:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: New consolidate irqs vs . probe_irq_*()
Message-ID: <20041020120140.J1047@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Anton Blanchard <anton@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
References: <16758.3807.954319.110353@cargo.ozlabs.ibm.com> <20041020083358.GB23396@elte.hu> <1098261745.6263.9.camel@gaston> <20041020100103.G1047@flint.arm.linux.org.uk> <1098269455.20955.1.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1098269455.20955.1.camel@gaston>; from benh@kernel.crashing.org on Wed, Oct 20, 2004 at 08:50:56PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 08:50:56PM +1000, Benjamin Herrenschmidt wrote:
> > yenta_socket has always used it.  Its rather fundamental to the way
> > that the PCMCIA core has worked for the last I don't know how many
> > years.
> > 
> > Nothing new.  Maybe something in PPC64 land broke recently?
> 
> No, what happened is that until the big irq unification, ppc and ppc64
> probe_* were no-ops. Probing of "ISA" irqs is a big no-no on most non
> x86 architectures.

Well, I've no plans to rewrite that bit of PCMCIA anytime soon,
especially as my time is very precious over the next two months
or so.

Remember that PCMCIA effectively has its own IRQ router which requires
the PCMCIA code to know which IRQs are physically connected and which
aren't.  Unfortunately, there's no way to get that information as far
as I know except by the published method in the code.

So even if I had time to look at this, I doubt anything would change.
I think it's a necessary evil.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
