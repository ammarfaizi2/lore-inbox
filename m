Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267073AbRGJSi4>; Tue, 10 Jul 2001 14:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267074AbRGJSir>; Tue, 10 Jul 2001 14:38:47 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:43412 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267073AbRGJSip>; Tue, 10 Jul 2001 14:38:45 -0400
Date: Tue, 10 Jul 2001 13:38:02 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200107101838.NAA23636@tomcat.admin.navo.hpc.mil>
To: root@chaos.analogic.com, Timur Tabi <ttabi@interactivesi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com>
...
> In Unix and Unix variants, it is by design, provided that the
> kernel exist within every process address space. Early Nixes
> like Ultrix, simply called the kernel entry point. Since it
> was protected, this trapped to the real kernel and the page-fault
> handler actually performed the work on behalf of the caller.
> 
> Unlike some OS (like VMS), a context-switch does not occur
> when the kernel provides services for the calling task.
> Therefore, it was most reasonable to have the kernel exist within
> each tasks address space. With modern processors, it doesn't make
> very much difference, you could have user space start at virtual
> address 0 and extend to virtual address 0xffffffff. However, this would
> not be Unix. It would also force the kernel to use additional
> CPU cycles when addressing a tasks virtual address space,
> i.e., when data are copied to/from user to kernel space.

I believe the VAX/VMS implementation shared OS and user space:

	p0	- user application		0
	p1	- system shared libraries	0x3fffffff
	p2	- kernel			0x7fffffff
		rest was I/O, cache memory	0xffffffff

It was a hardware design, not a function of the software.

UNIX origins were on a PDP-11. there were two sets of addressing registers
1 kernel, 1 user  (except on 11/45 - 1 kernel, 1 user, 1 "executive"
(never used except in some really strange form of extented shared library)

A full context switch was required. Kernel had to map a single 4KW window
to the user space for access to the parameters. Another 4KW window was used
to map the IO space. The remaining 6 mapping registers were used for supporting
the kernel virtual address. BTW, 1 KW = 2K Bytes, a mapping register could
map anything from 16 bytes to 8K bytes, if I remember correctly. The PDP 11
with memory management only had 16 mapping registers (8 user, 8 kernel) with
a maximum address of 64K bytes (16 bit addresses... my how far we've come).
The base hardware could only handle a maximum of 256 K bytes. More recent
cpu's expanded the size of the mapping registers (more bits/register) but did
not increase the number of registers. The last system (PDP-11/70 level) could
handle 4 MB of physical memory, but with all of the restrictions of the small
systems, just more processes were handled.

It was not possible to share memory between kernel/user other than that one
4KW window. The Linux 3G/1G split is a design choice for speed. It would still
be Linux even if it did 4G/0, just a different MM architecture with a lot
more overhead on intel x86 hardware.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
