Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266905AbRGJRgq>; Tue, 10 Jul 2001 13:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266949AbRGJRgh>; Tue, 10 Jul 2001 13:36:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8577 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266905AbRGJRgb>; Tue, 10 Jul 2001 13:36:31 -0400
Date: Tue, 10 Jul 2001 13:35:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Timur Tabi <ttabi@interactivesi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
In-Reply-To: <3B4B3570.9090104@interactivesi.com>
Message-ID: <Pine.LNX.3.95.1010710131403.18337A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, Timur Tabi wrote:

> Chris Wedgwood wrote:
> 
> >How does FreeBSD do this? What about other OSs? Do they map out most
> >of userland on syscall entry and map it in as required for their
> >equivalents to copy_to/from_user? (Taking the performance hit in doing
> >so?)
> >
> 
> I don't know about *BSD, but in Windows NT/2000, even drivers run in 
> virtual space.  The OS is not monolithic, so address spaces are general 
  ^^^^^^^^^^^^^
> not "shared" as they are in Linux.
       ^^^^^^^

Everything in the kernel is virtual. There are some 1:1 mappings in
low-address space, but there is a PTE for everything addressed anywhere.
It has to be this way or paging would not work.  Linux is also not
as you say "monolithic". We have installable device drivers, you know.
They are logically within the kernel's virtual address space, but
may be anywhere in physical memory. Also, although the kernel is
uncompressed into memory slightly above 1 megabyte upon startup,
it could exist anywhere in physical memory. It's just easier to
make the 1:1 mappings exist where the kernel was started in 32-bit
linear mode, before paging was enabled.

The kernel has the capability (by design) of addressing anything it
wants. So, if this is what you mean by "shared", I guess you imply
that Windows can't address anything it wants? Of course it can.

In Unix and Unix variants, it is by design, provided that the
kernel exist within every process address space. Early Nixes
like Ultrix, simply called the kernel entry point. Since it
was protected, this trapped to the real kernel and the page-fault
handler actually performed the work on behalf of the caller.

Unlike some OS (like VMS), a context-switch does not occur
when the kernel provides services for the calling task.
Therefore, it was most reasonable to have the kernel exist within
each tasks address space. With modern processors, it doesn't make
very much difference, you could have user space start at virtual
address 0 and extend to virtual address 0xffffffff. However, this would
not be Unix. It would also force the kernel to use additional
CPU cycles when addressing a tasks virtual address space,
i.e., when data are copied to/from user to kernel space.

> 
> -- 
> Timur Tabi
> Interactive Silicon
> 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


