Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318510AbSHENnO>; Mon, 5 Aug 2002 09:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318505AbSHENnO>; Mon, 5 Aug 2002 09:43:14 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:52879 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S318502AbSHENnN>; Mon, 5 Aug 2002 09:43:13 -0400
Date: Mon, 5 Aug 2002 15:46:07 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Jeff Dike <jdike@karaya.com>
Cc: alan@redhat.com, mingo@elte.hu, rz@linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode
Message-Id: <20020805154607.7c021c56.us15@os.inf.tu-dresden.de>
In-Reply-To: <200208031529.KAA01655@ccure.karaya.com>
References: <200208031233.g73CXUB02612@devserv.devel.redhat.com>
	<200208031529.KAA01655@ccure.karaya.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Aug 2002 10:29:42 -0500
Jeff Dike <jdike@karaya.com> wrote:

> alan@redhat.com said:
> > the alternatives like a seperate process and ptrace are not pretty either

I have implemented a usermode version of the Fiasco µ-kernel that uses
a seperate process for the kernel and one process for each task. The kernel
process attaches to all tasks via ptrace.
When the kernel wants to change the MM of a task it puts some trampoline code
on a page mapped into each task's address space and has the task execute that
code on behalf of the kernel.
With that setup we have complete address space protection without all the
trouble of jail at the expense of a few context switches for each mmap, munmap
or mprotect operation.

I would also very much like an extension that would allow one process to modify
the MM of another, possibly via an extended ptrace interface or a new syscall.
Also it would be nice if there was an alternate way to get at the cr2 register,
trap number and error code other than from a SIGSEGV handler.

> All I would need to make this work is for one process to be able to change
> the mm of another.

Yes, exactly.

> Then, the current UML tracing thread would handle the kernel side of things
> and sit in its own address space nicely protected from its processes.

Yes. I already have this part working for our kernel, so it's not just theory.
I believe things could run yet another bit faster if we didn't have to do the
trampoline map operations.

-Udo.
