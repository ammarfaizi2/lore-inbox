Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269931AbUJTLHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269931AbUJTLHD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269401AbUJTK7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:59:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:31647 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269926AbUJTK6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:58:02 -0400
Subject: Re: New consolidate irqs vs . probe_irq_*()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <20041020092017.GA28054@elte.hu>
References: <16758.3807.954319.110353@cargo.ozlabs.ibm.com>
	 <20041020083358.GB23396@elte.hu> <1098261745.6263.9.camel@gaston>
	 <20041020084838.GA25798@elte.hu> <1098262403.6278.16.camel@gaston>
	 <20041020092017.GA28054@elte.hu>
Content-Type: text/plain
Message-Id: <1098269765.20949.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 20:56:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 19:20, Ingo Molnar wrote:
>
> .../...
>
> this is not a concept that would be too useful for the server space, but
> it sure could be useful for the produce-and-forget PC mass-market. We
> are playing a constant and mostly losing catchup game with BIOS quirks.
> 
> what can never work fully reliably is of course what the feature was
> used for primarily: ISA :-) One-time edge-triggered interrupts that get
> lost are nasty ...
> 
> so i thought autodetect.c could survive in the generic code - maybe we
> can make something really nice out of it, based on Alan's patch.

Hrm... Okay, maybe, but I'd rather keep it disabled for now on ppc and
ppc64, there is simply no case there where the interrupt informations
are incorrect :) And the way PCMCIA uses it is a bit nasty imho, besides
the current interface passing in a mask isn't really useable when your
max interrupt number goes beyond the size of a long.

Note that the reason why it dies on ppc atm is that it calls the irq
desc functions like shutdown() without testing if they exist in the
first place...

Looking at the code, it seems that I need to add startup() & shutdown()
callbacks to all my irq controllers so they do the equivalent of enable
and disable at least ...

Ben. 

