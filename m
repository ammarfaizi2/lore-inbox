Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWIVTds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWIVTds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWIVTds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:33:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964808AbWIVTds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:33:48 -0400
Date: Fri, 22 Sep 2006 12:33:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Orion Poplawski <orion@cora.nwra.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to debug random bus errors?
In-Reply-To: <ef15fm$uhs$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.64.0609221225500.4388@g5.osdl.org>
References: <ef15fm$uhs$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Sep 2006, Orion Poplawski wrote:
>
> We're seeing programs die with "bus error" (SIGBUS) randomly on a dual
> processor Opteron machine.  I've run memtest86+ and cpuburn stress tests with
> no failure.  gdb on a core file seems uninteresting.  Is there some way to
> trace the kernel to try to get more insight?

Which kernel?

Opterons in SMP environments had a TLB flushing bug if the tlb flush 
filter was enabled.

We've had that fixed for a long time, but if you have a kernel older that 
2.6.14-rc2 or so (but still new enough to use the four-level page tables: 
it's not a big window), you can hit the bug. We fixed it pretty much 
exactly a year go ("Sat Sep 17, 2005").

Other than that, does it tend to happen to the same particular program? It 
might just be a user space bug that needs a specific set of things to 
happen. Some of those bugs go away when you disable address space 
randomization etc, since they can depend on just pure luck (or rather, 
lack there-of).

If it happens to lots of different programs, and you sometimes see 
SIGSEGV's and occasionally perhaps data corruption, that does tend to 
indicate memory problems (or wild kernel pointers, but on the whole memory 
problems tend to be more common).

			Linus
