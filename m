Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292281AbSBTU1Y>; Wed, 20 Feb 2002 15:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292282AbSBTU1P>; Wed, 20 Feb 2002 15:27:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16772 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292281AbSBTU0z>; Wed, 20 Feb 2002 15:26:55 -0500
Date: Wed, 20 Feb 2002 15:29:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jason Yan <jasonyanjk@yahoo.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: initialize page tables --  Re: paging question
In-Reply-To: <20020220195513.EIBW1236.tomts21-srv.bellnexxia.net@abc337>
Message-ID: <Pine.LNX.3.95.1020220151844.11610A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Jason Yan wrote:

> Thank you Dick
> 
> Oops, I use a wrong subject, what I want to ask is how the pg0 be initialized
> 
> in head.S,
> 
> 395 .org 0x2000
> 396 ENTRY(pg0)

Last I checked the page-table was 1 megabyte + that origin. Anyways,
it doesn't matter. It is all referenced by labels which are fixed up
by the linker.

> 
> so $pg0-__PAGE_OFFSET = 0x2000 - 0xC0000000 = 40002000, how comes bff00000 ?
> 
> >84 movl $pg0-_PAGE_OFFSET,%edi
> 
> %edi = bff00000 (or 40002000) ?
> 
> >87 2:      stosl
> 
> that's  move %eax  to  %es:%edi, __KERNEL_DS = 0x18, so %es is 0x18,
> according the gdt_table, 0x00cf92000000ffff, the base linear address
> is 0x00000000, that means
> %es:%edi = bff00000 (or 40002000), how can the %eax be moved into an
                                     EAX contents ^^^
> nonexist ram, cause at that time, no page directory and and page table
> yet.

The RAM exists and is addressed as linear address space because the
paging bit in CR0 isn't set yet. This is the reason why all the
operations that change or modify paging have to be done in a region
where there is a 1:1 physical/virtual address translation. If the
correct PTEs are present, once the paging bit is set, the stuff
being executed doesn't change, but now exists at the (unchanged)
virtual address.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

