Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbRGJS3g>; Tue, 10 Jul 2001 14:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267067AbRGJS30>; Tue, 10 Jul 2001 14:29:26 -0400
Received: from [64.64.109.142] ([64.64.109.142]:63761 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S267065AbRGJS3P>; Tue, 10 Jul 2001 14:29:15 -0400
Message-ID: <3B4B4966.996DD91E@didntduck.org>
Date: Tue, 10 Jul 2001 14:28:54 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
CC: ttabi@interactivesi.com, linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
In-Reply-To: <200107101812.NAA01171@tomcat.admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> 
> Timur Tabi <ttabi@interactivesi.com>:
> > Jesse Pollard wrote:
> > >>So what are the limits without using PAE? Here I'm still having a little
> > >>problem finding definitive answers but ...
> > >>
> > >3 GB. Final answers are in the FAQ, and have been discussed before. You can
> > >also look in the Intel 80x86 CPU specifications.
> > >
> > >The only way to exceed current limits is via some form of segment register usage
> > >which will require a different compiler and a replacement of the memory
> > >architecture of x86 Linux implementation.
> > >
> >
> > Are you talking about using 48-bit pointers?
> >
> > (48-bit pointers, aka 16:32 pointers, on x86 are basically "far 32-bit
> > pointers".  That is, each pointer is stored as a 48-bit value, where 16
> > bits are for the selector/segment, and 32 bits are for the offset.
> 
> That sounds right - I'm not yet fully familiar with the low level intel
> x86 design yet. There is also (based on list email) a limit to how
> many page tables can be active. Two is desirable (one system, one user)
> but the x86 design only has one. This causes Linux (and maybe others too)
> to split the 32 bit range into a 3G (user) and 1G (system) address ranges
> to allow the page cache/cpu cache to work in a more optimum manner. If
> the entire page table were given to a user, then a full cache flush would
> have to be done on every context switch and system call. That would be
> very slow, but would allow a full 4G address for the user.

A full cache flush would be needed at every entry into the kernel,
including hardware interrupts.  Very poor for performance.

> The use of 48 bit addresses has the same problem. Doing the remapping for
> the segment + offset requires flushing the cache as well (the cache seems
> to be between the segment registers and the page tables - not sure, not
> necessarily coreect... I still have to get the new CPU specs...)
> 
> Any body want to offer a full reference? Or a tutorial on Intel addressing
> capability?.

Using segmentation does not give you access to any more memory without
dirty hacks using fault handlers.  The segment base is added to the
offset to get a linear address (truncated to 32 bits).  This linear
address is fed through the page tables to get the physical address.

--

				Brian Gerst
