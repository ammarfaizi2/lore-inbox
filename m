Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTLNKiU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 05:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTLNKiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 05:38:20 -0500
Received: from purplechoc.demon.co.uk ([80.176.224.106]:3456 "EHLO
	skeleton-jack.localnet") by vger.kernel.org with ESMTP
	id S262041AbTLNKiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 05:38:19 -0500
Date: Sun, 14 Dec 2003 10:38:03 +0000
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, Peter Horton <pdh@colonel-panic.org>,
       linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
Message-ID: <20031214103803.GA916@skeleton-jack>
References: <20031213114134.GA9896@skeleton-jack> <20031213222626.GA20153@mail.shareable.org> <Pine.LNX.4.58.0312131740120.14336@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312131740120.14336@home.osdl.org>
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@colonel-panic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 13, 2003 at 05:41:16PM -0800, Linus Torvalds wrote:
> 
> On Sat, 13 Dec 2003, Jamie Lokier wrote:
> >
> > Peter Horton wrote:
> > > A quick look at sparc and sparc64 seem to show the same problem.
> >
> > D-cache incoherence with unsuitably aligned multiple MAP_FIXED
> > mappings is also observed on SH4, SH5, PA-RISC 1.1d.  The kernel may
> > have the same behaviour on those platforms: allowing a mapping that
> > should not be allowed.
> 
> Why?
> 
> If the user asks for it, it's the users own damn fault. Nobody guarantees
> cache coherency to users who require fixed addresses.
> 
> Just document it as a bug in the user program if this causes problems.
> Don't blame the kernel - the kernel is only doing what the user asked it
> to do.
> 

I've seen code written for X86 use MAP_FIXED to create self wrapping
ring buffers. Surely it's better to fail the mmap() on other archs
rather than for the code to fail in unexpected ways?

It's a bug either way ... either the test should be fixed up or it
should be removed from arch_get_unmapped_area() to save confusion.

P.
