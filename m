Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265013AbUELAlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265013AbUELAlW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUELAYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:24:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15796 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263173AbUELAWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:22:22 -0400
Message-ID: <40A16E21.9080201@pobox.com>
Date: Tue, 11 May 2004 20:21:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zoltan Boszormenyi <zboszor@freemail.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial ATA (SATA) on Linux status report
References: <40A0A4EC.8050705@freemail.hu>
In-Reply-To: <40A0A4EC.8050705@freemail.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Boszormenyi wrote:
>> Promise TX2/TX4/SX4
>> -------------------
>> Summary: Per-host queues on all controllers. Full SATA control
>> including hotplug and PM on all but one controller.
>>
>> libata TX2/TX4 driver status: Production, but see issue #5.
>>
>> libata SX4 driver status: Production, but see issue #6.
>>
>>
>> Issue #5: Some boards appear to have PATA as well as SATA ports. PATA
>> is not currently supported, and no plans have yet been made to rectify
>> this. Ideally drivers/ide would drive PATA, but if they are the same
>> PCI device, that would not be feasible.
> 
> 
> $ /sbin/lspci
> ...
> 00:0d.0 RAID bus controller: Promise Technology, Inc.: Unknown device
> 3373 (rev 02)
> ...
> 
> This is the only Promise Tech. device shown.
> Here is the more detailed info about this, look at Region 1,
> and compare the VIA IDE controller below:
> 
> $ /sbin/lspci -vvv -s 00:0d.0
> 00:0d.0 RAID bus controller: Promise Technology, Inc.: Unknown device 
> 3373 (rev 02)
>         Subsystem: Micro-Star International Co., Ltd.: Unknown device 702e
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 96 (1000ns min, 4500ns max), cache line size 91
>         Interrupt: pin A routed to IRQ 17
>         Region 0: I/O ports at e800 [size=64]
>         Region 1: I/O ports at e400 [size=16]
>         Region 2: I/O ports at e000 [size=128]
>         Region 3: Memory at cffef000 (32-bit, non-prefetchable) [size=4K]
>         Region 4: Memory at cffa0000 (32-bit, non-prefetchable) [size=128K]
>         Capabilities: <available only to root>
> $ /sbin/lspci -vvv -s 00:0f.1
> 00:0f.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06) 
> (prog-if 8a [Master SecP PriP])
>         Subsystem: Micro-Star International Co., Ltd.: Unknown device 7020
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32
>         Interrupt: pin A routed to IRQ 20
>         Region 4: I/O ports at fc00 [size=16]
>         Capabilities: <available only to root>
> 
> Could it be that Region 1 of the Promise controller contains
> the PATA I/O ports? Then it could be driven with a drivers/ide
> driver... Maybe common locking is needed between sata_promise.c
> and a driver for it's PATA side, I don't know.

Nope, the PATA ports are stuck in the same place as the SATA ports...

	Jeff




