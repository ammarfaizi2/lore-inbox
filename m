Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTIRRGc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 13:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbTIRRGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 13:06:32 -0400
Received: from ns.suse.de ([195.135.220.2]:2771 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261917AbTIRRGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 13:06:31 -0400
Date: Thu, 18 Sep 2003 19:06:29 +0200
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
Message-ID: <20030918170629.GC7917@wotan.suse.de>
References: <20030917202100.GC4723@wotan.suse.de> <Pine.LNX.4.44.0309171332200.2523-100000@laptop.osdl.org> <20030917211200.GA5997@wotan.suse.de> <20030918153831.GA7548@mail.jlokier.co.uk> <20030918160456.GC7548@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030918160456.GC7548@mail.jlokier.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18, 2003 at 05:04:56PM +0100, Jamie Lokier wrote:
> Jamie Lokier wrote:
> > > +	/* Don't check for LDT code segments because they could have
> > > +	   non zero bases. Better would be to add in the base in this case. */
> > > +	if (regs->xcs & (1<<2))
> > > +		return 0;
> > 
> > It is possible to have a non-standard code segment in the GDT, too.
> > Thus a better to check is "unlikely((regs->xcs & 0xffff) != __USER_CS)".
> 
> Ignore me here, I'm being dense - forgetting about __KERNEL_CS :)
> 
> My point is simply that non-zero base GDT segments are possible in
> userspace, and whatever code you add later to add the base should
> be aware of that.

I don't see how a non standard GDT is possible in user space. The GDT 
is only managed by the kernel. 2.6 offers to change it for NPTL, but
that only applies to data segments.

In vm86 mode the user can load a different base without LDT, but that
should not matter here (although it may be better to check for VM86 mode
too) 

-Andi
