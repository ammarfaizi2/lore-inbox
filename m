Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbUKDCRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbUKDCRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUKDCPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:15:10 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:65252 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262095AbUKDCIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 21:08:47 -0500
Date: Thu, 4 Nov 2004 03:08:35 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: avoid asmlinkage on x86 traps/interrupts
Message-ID: <20041104020835.GL3571@dualathlon.random>
References: <Pine.LNX.4.58.0411021250310.2187@ppc970.osdl.org> <20041103090710.GV3571@dualathlon.random> <Pine.LNX.4.58.0411030719061.2187@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411030719061.2187@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 07:19:59AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 3 Nov 2004, Andrea Arcangeli wrote:
> > 
> > I guess it'd be nicer to simply move the output into the input with "a",
> > "d", "b", and the not add any output at all, and put "eax/edx" back into
> > the clobbers.
> 
> Ehh.. You aren't allowed to clobber inputs. Try it with any modern version 
> of gcc.

Didn't know about that, thanks.

I wonder why they don't forbid it completely then. I mean, what's magic
about an input parmeter here? Clobbers are about the internals of
the asm (they've nothing to do about the setup before the asm runs, and
the input only has to do with the prepartion, so clobbers and input
seems fully orthogonal concepts to me). The only reason clobber exists
is to avoid you to declare a worthless local variable, clobbers are
strictly needed only for "cc" and "memory" (or any other piece of cpu not
reachable via the output operands). So I believe they should allow
general purpose register clobbers always or never, I don't see why
there's this special case.  Maybe for robustness to force people to
write a more verbose version like you had to do for this reason? No idea.
