Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270307AbUJTMBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270307AbUJTMBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270055AbUJTLyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:54:05 -0400
Received: from ozlabs.org ([203.10.76.45]:63415 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S270123AbUJTLxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:53:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16758.20925.984734.83651@cargo.ozlabs.ibm.com>
Date: Wed, 20 Oct 2004 21:53:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: New consolidate irqs vs . probe_irq_*()
In-Reply-To: <20041020120140.J1047@flint.arm.linux.org.uk>
References: <16758.3807.954319.110353@cargo.ozlabs.ibm.com>
	<20041020083358.GB23396@elte.hu>
	<1098261745.6263.9.camel@gaston>
	<20041020100103.G1047@flint.arm.linux.org.uk>
	<1098269455.20955.1.camel@gaston>
	<20041020120140.J1047@flint.arm.linux.org.uk>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:

> Remember that PCMCIA effectively has its own IRQ router which requires
> the PCMCIA code to know which IRQs are physically connected and which
> aren't.  Unfortunately, there's no way to get that information as far
> as I know except by the published method in the code.

On my powerbook, the pcmcia/cardbus controller has one interrupt,
which is used both for card status changes and for card functional
interrupts.  It doesn't have an ISA bus and it doesn't have an 8259
interrupt controller, and interrupts 0-15 aren't anything like what
they might be on a PC.  This is why (as Ben says) there is no point
probing for interrupts, and why on ppc (or at least on powermacs) the
probe functions are no-ops.

Paul.
