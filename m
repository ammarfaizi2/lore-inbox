Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUCSUJn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUCSUJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:09:43 -0500
Received: from mail.cyclades.com ([64.186.161.6]:61841 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261924AbUCSUJk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:09:40 -0500
Date: Fri, 19 Mar 2004 16:46:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 oops in do_softirq
In-Reply-To: <Pine.LNX.4.58.0403190942360.23532@r2-pc.dcs.qmul.ac.uk>
Message-ID: <Pine.LNX.4.44.0403191644200.1953-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Mar 2004, Matt Bernstein wrote:

> Hi,
> 
> Our big student fileserver has crashed two nights in a row (while the
> dumps were running). I didn't have time to capture the oops the first
> time; this time I've copied it by hand. The modules having changed are
> credit to my initrd. The machine is a dual-Athlon running Debian woody.
> 
> We've recently changed the gigabit NIC from a 33MHz, 64-bit fibre acenic
> under 2.4.23 (stable for at least weeks) to a 66MHz, 64-bit copper ns83820
> under 2.4.25 while changing our switches. It had run fine for a week.
> 
> Here's some possibly irrelevant information: I can provide plenty more if
> need be! (I've tried to run a memtest86+ but had to abort at 9am, as our
> students have a deadline..)
> 
> Cheers,
> 
> Matt
> 
> Linux version 2.4.25 (mb@absinthe-pc) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-118)) #1 SMP Wed Mar 10 11:22:38 GMT 2004
> 
> 00:09.0 Ethernet controller: National Semiconductor Corporation DP83820 10/100/1000 Ethernet Controller
>         Subsystem: Netgear: Unknown device 622a
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (2750ns min, 13000ns max), cache line size 10
>         Interrupt: pin A routed to IRQ 17
>         Region 0: I/O ports at 1000 [size=256]
>         Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=4K]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
> 
> Unable to handle kernel NULL pointer dereference at virtual address 
> 00000000 printing eip:
> c011e5c0
> *pde = 00000000
> Oops: 0002
> CPU: 0
> EIP: 0010:[<c011e5c0>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010213
> eax: 00000000 ebx: 00000002 ecx: 00000000 edx: c024d688
		     ********

Looks like one bit got flipped, causing the crash. 

Most probably bad hardware. Try memtest86 for longer periods (the weekend 
is here :))

> 00000000 <_EIP>:
> Code;  c011e5c0 <do_softirq+70/e0>   <=====
>    0:   f7 c3 01 00 00 00         test   $0x1,%ebx   <=====

