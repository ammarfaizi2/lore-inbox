Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290702AbSARTup>; Fri, 18 Jan 2002 14:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290795AbSARTuh>; Fri, 18 Jan 2002 14:50:37 -0500
Received: from chaos.analogic.com ([204.178.40.224]:21120 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290702AbSARTud>; Fri, 18 Jan 2002 14:50:33 -0500
Date: Fri, 18 Jan 2002 14:51:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Juhan Ernits <juhan@cc.ioc.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: misconfiguration of ne.o module in 2.2.19 damaged hardware. Is it normal? 
In-Reply-To: <Pine.GSO.4.21.0201182116001.21822-100000@suhkur.cc.ioc.ee>
Message-ID: <Pine.LNX.3.95.1020118143834.2105A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Juhan Ernits wrote:

> 
> 
> On Fri, 18 Jan 2002, Horst von Brand wrote:
> 
> > > I installed linux on this box (Debian 2.2r4, kernel version 2.2.19).
> > > Then when configuring the network the module ne.o was chosen. 
> > > I was sure about the io address but not so sure about the irq. So I
> > > configured the module with only io address parameter.
> > 
> > This is enough, IRQ can be found from that datum. I assume this is an ISA
> > NIC? If PCI, no such parameters are needed. BTW, NE clones are (in)famous
> > for their bizarre assortment of bugs, you might have hit one that doesn't
> > work with Linux.
> 
> It is (was) an ISA nic and the fun part is, that it had been working for
> me under minix & linux (under different hardware configuration though).
> 
> > What does lsmod(8) tell you? If you do an "modprobe ne io=..." what does it
> > say?
> 
> The bad part was, that I didnt do lsmod then. After reboot the card was
> rendered completely useless (except for a few probably functional diodes
> on the pc-board :-). 
> 
> > If your guess at IO is wrong, nothing happens. If the NIC is _not_ an NE,
> > strange things could very well happen. It might be broken, not installed
> > correctly, jumpers set wrong, ...
> 
> It was a jumperless ne2000 isa clone. The io adress was right alright, but
> i just left irq unspecified. And that fact drove me to bore the people on
> this list ...
> 
> My question is that how can the module detect false parameters and how is
> it possible to make it protect the hardware in such case? 
> 
> The module ne.o most probably managed to write some garbage to the nics
> flash address somehow and that makes me worry a bit.
> 
> 
> Juhan Ernits

These things use a SEEPROM (Serial EEPROM), they need bit-banger software
to perform a write. If you can boot DOS or FREE_DOS, use the software
you got with the card (or download the executable from the vendor's site),
and restore the parameters.

Since these ne2000* ISA boards need bit-banger software, to change
anything, it seems to me that some driver for some other board "thought"
it saw its hardware and tried to use its bit-banger software to enable the
I/O connector or change I/O configuration. The ne.c software does not
do bit-banging I/O so it can't be the culprit.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


