Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267035AbRGJSNQ>; Tue, 10 Jul 2001 14:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbRGJSNG>; Tue, 10 Jul 2001 14:13:06 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:29588 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267035AbRGJSM5>; Tue, 10 Jul 2001 14:12:57 -0400
Date: Tue, 10 Jul 2001 13:12:54 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200107101812.NAA01171@tomcat.admin.navo.hpc.mil>
To: ttabi@interactivesi.com, linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <ttabi@interactivesi.com>:
> Jesse Pollard wrote:
> >>So what are the limits without using PAE? Here I'm still having a little
> >>problem finding definitive answers but ...
> >>
> >3 GB. Final answers are in the FAQ, and have been discussed before. You can
> >also look in the Intel 80x86 CPU specifications.
> >
> >The only way to exceed current limits is via some form of segment register usage
> >which will require a different compiler and a replacement of the memory
> >architecture of x86 Linux implementation.
> >
> 
> Are you talking about using 48-bit pointers?
> 
> (48-bit pointers, aka 16:32 pointers, on x86 are basically "far 32-bit 
> pointers".  That is, each pointer is stored as a 48-bit value, where 16 
> bits are for the selector/segment, and 32 bits are for the offset.

That sounds right - I'm not yet fully familiar with the low level intel
x86 design yet. There is also (based on list email) a limit to how
many page tables can be active. Two is desirable (one system, one user)
but the x86 design only has one. This causes Linux (and maybe others too)
to split the 32 bit range into a 3G (user) and 1G (system) address ranges
to allow the page cache/cpu cache to work in a more optimum manner. If
the entire page table were given to a user, then a full cache flush would
have to be done on every context switch and system call. That would be
very slow, but would allow a full 4G address for the user.

The use of 48 bit addresses has the same problem. Doing the remapping for
the segment + offset requires flushing the cache as well (the cache seems
to be between the segment registers and the page tables - not sure, not
necessarily coreect... I still have to get the new CPU specs...)

Any body want to offer a full reference? Or a tutorial on Intel addressing
capability?.


-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
