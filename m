Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264048AbUFPPep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbUFPPep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 11:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUFPPep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 11:34:45 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:29422 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S264048AbUFPPeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 11:34:37 -0400
Date: Wed, 16 Jun 2004 08:34:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] kbuild: default kernel image
Message-ID: <20040616153432.GI14528@smtp.west.cox.net>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204405.GB15243@mars.ravnborg.org> <20040614220549.L14403@flint.arm.linux.org.uk> <20040615044020.GC16664@mars.ravnborg.org> <20040615093807.A1164@flint.arm.linux.org.uk> <20040615085952.GA19197@infradead.org> <20040615210739.GM2310@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615210739.GM2310@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 11:07:39PM +0200, Sam Ravnborg wrote:
> On Tue, Jun 15, 2004 at 09:59:52AM +0100, Christoph Hellwig wrote:
> > In fact I'd love to reduce what the kernel builds to just
> > vmlinux and vmlinux.gz, but I guess all those lilo user will kill me ;-)
> I do not see the point in this.
> Better make life easier - but in a nice and structured way.
> Take a look at arch/ppc/boot/simple to see that the bootloader step is not trivial..

That's not a good example of why it's not trivial, really :)
- 2/5th are what final frob'ing do I need to run for the f/w.
- 1/5th are what extension to use in /tftpboot/
- 2/5th are what platform-specific bits do I need
And 1 (so I'm a bit of 100%, shoot me :)) is for an actual CONFIG
option, that we only use in the bootloader code as on very small memory
machines you might not want to load at the default address for your
platform.

We've actually talked about moving all of that code out and using, for
example, a stripped down U-Boot (the point of arch/ppc/boot/ stuffs is
to not depend on the f/w to do anything aside from load us into memory)
that'd just load up the kernel and let it go.  All of the information
that would be needed by such a program are already avail via IKCONFIG
(and could be stripped out afterwards I believe for size).

> The concept with a clean and lean kernel that cannot be used in real-life without
> doing lot's of stuff is a dead end.

Define "lot's of stuff".  IIRC, sparc* has always been just a vmlinux,
and 99% of pmac users use yaboot + vmlinux.

-- 
Tom Rini
http://gate.crashing.org/~trini/
