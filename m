Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbSL2ELC>; Sat, 28 Dec 2002 23:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbSL2ELC>; Sat, 28 Dec 2002 23:11:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13843 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266356AbSL2ELB>; Sat, 28 Dec 2002 23:11:01 -0500
Date: Sat, 28 Dec 2002 20:13:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Dike <jdike@karaya.com>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Allow UML kernel to run in a separate host address space
In-Reply-To: <200212282337.SAA04085@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44.0212282010080.2029-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Dec 2002, Jeff Dike wrote:

> torvalds@transmeta.com said:
> > On Sat, 28 Dec 2002, Jeff Dike wrote:
> > 
> > > 3 - Ability to manipulate a child's address space (i.e. mmap, munmap,
> > > mprotect on an address space which is not current->mm)
> >
> > Well, #3 falls under "ptrace()" as far as I'm concerned,
> 
> Not exactly.  UML needs to be able to fiddle an address space that has no
> process in it (swapout, COWing, maybe a few other things).  

But that is an address space that it should already has access to through, 
since it created it in the first place (ie it would fall under the normal 
"sys_mm_indirect()" case).

The thing that I _really_ don't want to have is soem uncontrolled way to 
generate accesses to existing "struct mm_struct"s, since that is really 
dangerous from a security standpoint.

We could have a PTRACE_GET_MM_FD kind of thing for ptrace (and then the 
gdb/tracer can use that to create mappings in the process), but the reason 
I want that "hook" to be through ptrace itself is simply that it's a known 
interface to control other unrelated processes.

So if you create the MM's yourself, you can use the indirection directly. 
But if you want to control your children or unrelated processes, you use 
ptrace to get the hook. 

		Linus

