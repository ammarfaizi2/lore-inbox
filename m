Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbUJWTxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbUJWTxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 15:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUJWTxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 15:53:19 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:36799 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S261289AbUJWTxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 15:53:04 -0400
Message-ID: <417AB69E.8010709@verizon.net>
Date: Sat, 23 Oct 2004 15:53:02 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Jez <dave.jez@seznam.cz>
CC: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PCI & IRQ problems on TI Extensa 600CD
References: <20041023142906.GA15789@stud.fit.vutbr.cz>
In-Reply-To: <20041023142906.GA15789@stud.fit.vutbr.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [209.158.211.53] at Sat, 23 Oct 2004 14:53:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Jez wrote:
>   Hi Martin,
> 
>   i spent few last nights with my Extensa. This notebook has PCI 2.1 wich
> works only under m$ window$ :-(. I tried many version of kernel, 2.2,
> 2.4 and 2.6 tree and nothing helps me. I tried pci=bios pci=bios,biosirq
> kernel options, PCI=BIOS instead of ANY...
>   Result is always same:
> PCI: No IRQ known for interrupt pin A of device 00:04.0.
>   this cause for example that PCMCIA doesn't work. See attached dmesg log
> and other files for details.
>   In Window$ everythink works OK and IRQ routing table is get from PCI
> BIOS.
> 
>   Any ideas?
> 

I've got the same problem with the Cardbus bridge on my old Thinkpad 760ED - I 
think your laptop is as old as mine (Pentium 166 - 1996 or thereabouts).

The problem with mine is that the Cardbus bridge doesn't get a vaild IRQ written 
into the chip by the BIOS, and Linux relies on the BIOS to do it on older 
machines.  I haven't found an answer yet - I'm just getting into this stuff 
myself, and don't understand PCI well enough to code a fix.  It is good to know 
that it is not an IBM-only problem.

> 00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1521 [Aladdin III] (rev 1c)
> 00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1523 (rev 07)
> 00:02.1 IDE interface: Acer Laboratories Inc. [ALi] M5219 (rev 20)
> 00:04.0 CardBus bridge: Texas Instruments PCI1130 (rev 04)
> 00:04.1 CardBus bridge: Texas Instruments PCI1130 (rev 04)
> 00:06.0 VGA compatible controller: Chips and Technologies F65550 (rev 45)
> 

> 00:02.1 Class 0101: 10b9:5219 (rev 20) (prog-if fa)
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (500ns min, 1000ns max)
> 	Interrupt: pin A routed to IRQ 0
> 	Region 4: I/O ports at fcf0 [size=16]
> 00: b9 10 19 52 05 00 80 02 20 fa 01 01 00 40 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: f1 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 02 04
> 
> 00:04.0 Class 0607: 104c:ac12 (rev 04)
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64, cache line size 04
> 	Interrupt: pin A routed to IRQ 0
> 	Region 0: Memory at 02800000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=00, secondary=01, subordinate=05, sec-latency=176
> 	Memory window 0: fffff000-00000000
> 	Memory window 1: fffff000-00000000
> 	I/O window 0: 0000fffc-00000003
> 	I/O window 1: 0000fffc-00000003
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
> 	16-bit legacy interface ports at 0001
> 00: 4c 10 12 ac 07 00 00 02 04 00 07 06 04 40 82 00
> 10: 00 00 80 02 00 00 00 02 00 01 05 b0 00 f0 ff ff
> 20: 00 00 00 00 00 f0 ff ff 00 00 00 00 fc ff 00 00
> 30: 00 00 00 00 fc ff 00 00 00 00 00 00 ff 01 c0 00
> 40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:04.1 Class 0607: 104c:ac12 (rev 04)
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64, cache line size 04
> 	Interrupt: pin B routed to IRQ 0
> 	Region 0: Memory at 02802000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=00, secondary=06, subordinate=0a, sec-latency=176
> 	Memory window 0: 00000000-00000000
> 	Memory window 1: fffff000-00000000
> 	I/O window 0: 0000fffc-00000003
> 	I/O window 1: 0000fffc-00000003
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
> 	16-bit legacy interface ports at 0001
> 00: 4c 10 12 ac 07 00 00 02 04 00 07 06 04 40 82 00
> 10: 00 20 80 02 00 00 00 22 00 06 0a b0 00 00 00 00
> 20: 00 00 00 00 00 f0 ff ff 00 00 00 00 fc ff 00 00
> 30: 00 00 00 00 fc ff 00 00 00 00 00 00 ff 02 c0 00
> 40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>

Just out of curiosity - does lspci -vvb show the interrupt pins on the Cardbus 
bridge routed to IRQ 255?

If so, it might be a problem with the TI bridge chip.  IIRC, that's the same model 
chip as in my laptop.
