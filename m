Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbRGJTO5>; Tue, 10 Jul 2001 15:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267104AbRGJTOr>; Tue, 10 Jul 2001 15:14:47 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:12483 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S267102AbRGJTOh>; Tue, 10 Jul 2001 15:14:37 -0400
Date: Tue, 10 Jul 2001 14:14:38 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
In-Reply-To: <200107101838.NAA23636@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.LNX.4.33.0107101358540.21770-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, Jesse Pollard wrote:
> "Richard B. Johnson" <root@chaos.analogic.com>
[snip]
> > Unlike some OS (like VMS), a context-switch does not occur
> > when the kernel provides services for the calling task.
> > Therefore, it was most reasonable to have the kernel exist within
> > each tasks address space. With modern processors, it doesn't make
> > very much difference, you could have user space start at virtual
> > address 0 and extend to virtual address 0xffffffff. However, this would
> > not be Unix. It would also force the kernel to use additional
> > CPU cycles when addressing a tasks virtual address space,
> > i.e., when data are copied to/from user to kernel space.
>
> I believe the VAX/VMS implementation shared OS and user space:
>
> 	p0	- user application		0
> 	p1	- system shared libraries	0x3fffffff
> 	p2	- kernel			0x7fffffff
> 		rest was I/O, cache memory	0xffffffff
>
> It was a hardware design, not a function of the software.

Correct, except that "p2" is called S0.  IIRC it is the top quarter of the
address space, and there's a reserved S1 region.  The command interpreter
is also mapped into P2.  The very top of memory is reserved for device
registers.

> UNIX origins were on a PDP-11. there were two sets of addressing registers
> 1 kernel, 1 user  (except on 11/45 - 1 kernel, 1 user, 1 "executive"
> (never used except in some really strange form of extented shared library)

Early '11s didn't have the Ispace/Dspace split.  My PDP11 databook is at
home, and I don't trust my memory far enough to say which model introduced
the split.  My recollection is that the earliest implementation was an
add-on board which monitored the Unibus address lines and fired interrupts
when it thought its programmed memory access rules were violated.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Make a good day.

