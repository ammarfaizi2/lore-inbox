Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318916AbSHEWQ0>; Mon, 5 Aug 2002 18:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318920AbSHEWQZ>; Mon, 5 Aug 2002 18:16:25 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:3820 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S318916AbSHEWQY>; Mon, 5 Aug 2002 18:16:24 -0400
Date: Mon, 5 Aug 2002 22:44:15 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Jeff Dike <jdike@karaya.com>, alan@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode
Message-ID: <20020805224415.A579@linux-m68k.org>
References: <200208031233.g73CXUB02612@devserv.devel.redhat.com> <200208031529.KAA01655@ccure.karaya.com> <20020805154607.7c021c56.us15@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020805154607.7c021c56.us15@os.inf.tu-dresden.de>; from us15@os.inf.tu-dresden.de on Mon, Aug 05, 2002 at 03:46:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 03:46:07PM +0200, Udo A. Steinberg wrote:
> On Sat, 03 Aug 2002 10:29:42 -0500
> Jeff Dike <jdike@karaya.com> wrote:
> 
> > alan@redhat.com said:
> > > the alternatives like a seperate process and ptrace are not pretty either
> 
> I have implemented a usermode version of the Fiasco µ-kernel that uses
> a seperate process for the kernel and one process for each task. The kernel
> process attaches to all tasks via ptrace.
> When the kernel wants to change the MM of a task it puts some trampoline code
> on a page mapped into each task's address space and has the task execute that
> code on behalf of the kernel.
> With that setup we have complete address space protection without all the
> trouble of jail at the expense of a few context switches for each mmap, munmap
> or mprotect operation.

very interesting, what is the handiest way to do "syscalls" in this model?
Ptrace is still basically signal driven so I would expect it has still some 
unnecessary overhead?

> I would also very much like an extension that would allow one process to modify
> the MM of another, possibly via an extended ptrace interface or a new syscall.
> Also it would be nice if there was an alternate way to get at the cr2 register,
> trap number and error code other than from a SIGSEGV handler.

that's what signals are for, too bad they are slow.

> > Then, the current UML tracing thread would handle the kernel side of things
> > and sit in its own address space nicely protected from its processes.
> 
> Yes. I already have this part working for our kernel, so it's not just theory.
> I believe things could run yet another bit faster if we didn't have to do the
> trampoline map operations.

they are very expensive because of the way ptrace accesses the other process
memory, did you try a piece of shared memory ?

Richard
