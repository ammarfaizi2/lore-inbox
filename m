Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265042AbRGEMk4>; Thu, 5 Jul 2001 08:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265054AbRGEMkq>; Thu, 5 Jul 2001 08:40:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6273 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265043AbRGEMkl>; Thu, 5 Jul 2001 08:40:41 -0400
Date: Thu, 5 Jul 2001 08:37:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Vasu Varma P V <pvvvarma@techmas.hcltech.com>
cc: kernel Linux <linux-kernel@vger.kernel.org>
Subject: Re: DMA memory limitation?
In-Reply-To: <3B4453E6.F4342781@techmas.hcltech.com>
Message-ID: <Pine.LNX.3.95.1010705082119.19376B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2001, Vasu Varma P V wrote:

> Hi,
> 
> Is there any limitation on DMA memory we can allocate using
> kmalloc(size, GFP_DMA)? I am not able to acquire more than
> 14MB of the mem using this on my PCI SMP box with 256MB ram.
> I think there is restriction on ISA boards of 16MB.
> Can we increase it ?
> 
> thx,
> Vasu

14MB of DMA(able) memory?  Err. I think you are trying to
do something you would never need to do.

If your board has a PCI interface, it's got address-space
allocated where memory does not exist. That's for communicating
with the board. If this address-space contains memory on that
board, you treat it just like RAM. That's what the PCI bus
does for you.

Given this, your board may also be a "bus mastering" board.
This means that, given the correct programming sequence, it
can transfer data to or from any location accessible to the
PCI bus. This is the so-called DMA that PCI bus masters can
perform.

When you program such a board, you simply translate the
virtual address of the transfer area to the address that
the board understands. Look at /linux/Documentation/IO-mapping.txt

The GFP_DMA memory type to which you refer, is for boards that
must use the lower 16 MB of address space. Such boards are
usually on the ISA bus. Since the first 1 MB is pretty much
taken by ROM BIOS, screen-card BIOS, other controllers (like SCSI)
BIOS, etc., you are not going to increase it.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


