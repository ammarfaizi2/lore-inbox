Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbRGJU2r>; Tue, 10 Jul 2001 16:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267125AbRGJU2i>; Tue, 10 Jul 2001 16:28:38 -0400
Received: from oxmail4.ox.ac.uk ([163.1.2.33]:5508 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S267121AbRGJU2Z>;
	Tue, 10 Jul 2001 16:28:25 -0400
Date: Tue, 10 Jul 2001 21:19:50 +0100
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Timur Tabi <ttabi@interactivesi.com>, linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
Message-ID: <20010710211950.A70@sable.ox.ac.uk>
In-Reply-To: <3B4B3570.9090104@interactivesi.com> <Pine.LNX.3.95.1010710131403.18337A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.3.95.1010710131403.18337A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Jul 10, 2001 at 01:35:43PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson writes:
> On Tue, 10 Jul 2001, Timur Tabi wrote:
> 
> > Chris Wedgwood wrote:
> > 
> > >How does FreeBSD do this? What about other OSs? Do they map out most
> > >of userland on syscall entry and map it in as required for their
> > >equivalents to copy_to/from_user? (Taking the performance hit in doing
> > >so?)
> > >
> > 
> > I don't know about *BSD, but in Windows NT/2000, even drivers run in 
> > virtual space.  The OS is not monolithic, so address spaces are general 
>   ^^^^^^^^^^^^^
> > not "shared" as they are in Linux.
>        ^^^^^^^
> 
> Therefore, it was most reasonable to have the kernel exist within
> each tasks address space. With modern processors, it doesn't make
> very much difference, you could have user space start at virtual
> address 0 and extend to virtual address 0xffffffff. However, this would
> not be Unix. It would also force the kernel to use additional
> CPU cycles when addressing a tasks virtual address space,
> i.e., when data are copied to/from user to kernel space.

This is rather misleading and Intel-architecture-specific rather than
Unix-specific. For example, Linux on S/390 uses a complete 2Gb address
space (31 bits; the limit of addressability on the 32-bit S/390
architecture) for the current task and a separate 2GB address space for
the kernel. The kernel is not mapped into the "current" address space
but features of the architecture which provide for separate concurrent
address spaces via special registers are used. Copies between kernel
space and user space use special instructions which reference these
address space registers automagically.

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>   <-- This email address will break
Unix Systems Programmer                   when I quit OUCS on Jul 20th. Send
Oxford University Computing Services    private mail to mbeattie@clueful.co.uk
                                      I'll sort out my IBM email address soon.
