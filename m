Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbUCRUAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbUCRUAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:00:31 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13191
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262903AbUCRUAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:00:22 -0500
Date: Thu, 18 Mar 2004 21:01:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, hch@infradead.org,
       drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: sched_setaffinity usability
Message-ID: <20040318200111.GA16743@dualathlon.random>
References: <40595842.5070708@redhat.com> <20040318112913.GA13981@elte.hu> <20040318120709.A27841@infradead.org> <Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org> <20040318182407.GA1287@elte.hu> <20040318103352.1a65126a.akpm@osdl.org> <20040318183944.GA3710@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318183944.GA3710@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 07:39:44PM +0100, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > >  Right now the VDSO mostly contains code and exception-handling data, but
> > >  it could contain real, userspace-visible data just as much: info that is
> > >  only known during the kernel build. There's basically no cost in adding
> > >  more fields to the VDSO, and it seems to be superior to any of the other
> > >  approaches. Is there any reason not to do it?
> > 
> > It's x86-specific?
> 
> x86-64 has a VDSO page as well, and it can be implemented on any

it doesn't.

> architecture that wants to accelerate syscalls in user-space (and/or

x86-64 is the first arch ever implementing vsyscalls in production with
the fastest possible API.

The API doesn't contemplate the idea of relocating the vsyscall address,
but it can be extended easily with a relocation API.

> wants to provide alternate methods of system-entry).

there's no need of alternate methods of system-entry in x86-64, luckily
Intel merged the optimal extremely optimized syscall/sysexit from AMD
instead of only providing sysenter/sysexit like they do in the 32bit
cpus.

The way x86-64 implements the entry.S code is ultraoptimized since we
don't save a full stack for all syscalls except fork and few othrs that
needs to see all the registers, we've two different stack frames
depending on which syscalls is running.

Intel also provides sysenter/sysexit but that's useless on 64bit since
syscall/sysret is the standard in 64bit mode.
