Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266102AbUBCTnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUBCTXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:23:53 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62911
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266105AbUBCSfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 13:35:02 -0500
Date: Tue, 3 Feb 2004 19:34:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ulrich Drepper <drepper@redhat.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040203183458.GB26076@dualathlon.random>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040201012803.GN26076@dualathlon.random> <401F251C.2090300@redhat.com> <20040203085224.GA15738@mail.shareable.org> <20040203162515.GY26076@dualathlon.random> <20040203173716.GC17895@mail.shareable.org> <20040203181001.GA26076@dualathlon.random> <20040203182310.GA18326@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203182310.GA18326@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 06:23:10PM +0000, Jamie Lokier wrote:
> Andrea Arcangeli wrote:
> > vsyscalls will never execute anything like execve. They can at most
> > modify userspace memory a fixed address, so if the userspace isn't
> > fixed, then nothing can be done with a vsyscall.
> 
> Are we talking about the same x86_64?

I did, I don't think it worth to backport to i386 btw.

> 
> I see this in arch/x86_64/vsyscall.S:
> 
> __kernel_vsyscall:
> .LSTART_vsyscall:
> 	push	%ebp
> .Lpush_ebp:
> 	movl	%ecx, %ebp
> 	syscall
> 
> Is that page not mapped into userspace?

this code wasn't there last time I worked on it, it's not in 2.4 either.
I assume it's mapped in userspace, but I'm unsure why it's necessary. I
need to think more about it to understand why such code is there and how
can it be removed. I was taking about the .c file not this new .S one.
