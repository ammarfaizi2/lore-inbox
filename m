Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290777AbSAYSon>; Fri, 25 Jan 2002 13:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290779AbSAYSoZ>; Fri, 25 Jan 2002 13:44:25 -0500
Received: from chaos.analogic.com ([204.178.40.224]:17536 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290777AbSAYSoD>; Fri, 25 Jan 2002 13:44:03 -0500
Date: Fri, 25 Jan 2002 13:43:27 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: chus Medina <chuslists@hotmail.com>
cc: linux-kernel@vger.kernel.org, chus@glue.umd.edu
Subject: Re: PCI #LOCK assertion
In-Reply-To: <F4T0giSftNtzsG06vdG0001152a@hotmail.com>
Message-ID: <Pine.LNX.3.95.1020125132236.1362A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002, chus Medina wrote:

> 
> Hola,
> 
> I need to create module to perform atomic transactions through the PCI bus 
> between the processor and an IDE hard disk. The PCI bus specifications 2.2 
> point to the #LOCK signal to perform such a transaction. Is possible to 
> assert the #LOCK signal of the PCI bus using the Linux Kernel? How? I didnt 
> see any pointers in include/pci.h or anywhere in the source code.
> 
> I will truly appreciate any help/pointers,
> 
> Jesus
> 

On Intel machines, you precede a memory access with the 'lock'
instruction. With CPUs i486, and later, only the accessed page
is locked at that instant. Earlier CPUs locked the whole bus.

The PCI/Bus controller handles the #LOCK signal itself to guarantee
the atomicity of a transaction. You should never have to do this
yourself. If you think you have to, just precede each PCI/Bus
address-space access with the 'lock' instruction. You just make
your own version of the readl/readw/readb/etc macros that are
provided. You may find that this deadlocks, though, and all bets
are off. You may have just locked the PCI/Bus off the bus when
you needed it most!!

If you are finding something 'strange' in your PCI/Bus accesses,
it is probably because you didn't use 'nocache' when you obtained
address-space for your PCI Device, i.e., ioremap_nocache() instead of
ioremap().


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


