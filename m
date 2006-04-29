Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751867AbWD2KGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbWD2KGk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 06:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWD2KGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 06:06:40 -0400
Received: from 10.121.9.213.dsl.getacom.de ([213.9.121.10]:59101 "EHLO
	ds666.l4x.org") by vger.kernel.org with ESMTP id S1751859AbWD2KGj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 06:06:39 -0400
Message-ID: <44533AA0.5060002@l4x.org>
Date: Sat, 29 Apr 2006 12:06:24 +0200
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060228 Thunderbird/1.5 Mnenhy/0.6.0.104
MIME-Version: 1.0
To: mogensv@vip.cybercity.dk
CC: Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060427185813.GB6039@l4x.org> <4451594D.5060705@gmail.com> <4452AFAF.3000101@l4x.org> <4452B165.6090905@gmail.com> <445329A0.8020001@vip.cybercity.dk>
In-Reply-To: <445329A0.8020001@vip.cybercity.dk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.149
X-SA-Exim-Mail-From: jdi@l4x.org
Subject: Re: sata_sil24 resetting controller...
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on ds666.l4x.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mogens Valentin wrote:
> Tejun Heo wrote:
>> Jan Dittmer wrote:
>>
>>> Tejun Heo wrote:
>>>
>>>>> serror=0x0[4297873.266000] sata_sil24 ata1: resetting controller...
>>>>> [4297873.267000] ata1: status=0x50 { DriveReady SeekComplete }
>>>>> [4297873.267000] sdc: Current: sense key=0x0
>>>>> [4297873.267000]     ASC=0x0 ASCQ=0x0
>>>>>
>>>>> The time between these events varies from .5s to up to 10s, resync 
>>>>> speed is
>>>>> pretty bad (6mb/s) but appears(!) to be working.
>>>>> This is with vanilla 2.6.17-rc3, sata drivers built into the kernel.
>>>>> Find below /proc/interrupts and lspci output. Boot dmesg output was 
>>>>> washed
>>>>> away by above messages, sorry.
>>>>>
>>>>> What's the cause of the error, can I ignore it or will it destroy
>>>>> my raid eventually? I'm now about 5% through the resync process, 
>>>>> with an estimated finish in 1260 minutes.
>>>>>
>>>>>
>>>>> $ lspci -vv -s 03:04.0
>>>>> 0000:03:04.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X 
>>>>> Serial ATA Controller (rev 01)
>>>>>     Subsystem: Silicon Image, Inc.: Unknown device 7124
>>>>>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>>>>> ParErr- Stepping+ SERR- FastB2B-
>>>>>     Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
>>>>> <TAbort- <MAbort- >SERR- <PERR-
>>>>>     Latency: 32
>>>>>     Interrupt: pin A routed to IRQ 22
>>>>>     Region 0: Memory at fa800000 (64-bit, non-prefetchable) [size=128]
>>>>>     Region 2: Memory at fa000000 (64-bit, non-prefetchable) [size=32K]
>>>>>     Region 4: I/O ports at 9400 [size=16]
>>>>>     Expansion ROM at fe900000 [disabled] [size=512K]
>>>>>     Capabilities: [64] Power Management version 2
>>>>>         Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
>>>>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>>>         Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>>>>>     Capabilities: [40] PCI-X non-bridge device.
>>>>>         Command: DPERE- ERO+ RBC=0 OST=5
>>>>>         Status: Bus=3 Dev=4 Func=0 64bit+ 133MHz+ SCD- USC-, 
>>>>> DC=simple, DMMRBC=2, DMOST=5, DMCRS=4, RSCEM-
>>>> So, slow down the PCI-X bus.  It can usually be done from BIOS setup 
>>>> menu.  Does your machine has a riser board which extends or changes 
>>>> orientation of PCI-X bus?  Motherboard vendors describe the bus 
>>>> frequency limit when using riser boards in the manual but sometimes 
>>>> server vendors forget to set them.  Heck, some of them don't even 
>>>> know what that is.
>>>
>>> Hmm I don't have a riser card and I don't have a setting for the 
>>> frequency,
>>> nor a jumper.
>>> I plugged the card in another slot, next to a 66MHz only card. So now 
>>> I've
>>> it working with 66MHz (checked with lspci), but my drive isn't 
>>> initialized
>>> properly anymore:
>>>
>>> [4294690.486000] libata version 1.20 loaded.
>>> [4294690.486000] sata_sil24 0000:03:04.0: version 0.23
>>> [4294690.486000] ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 24 (level, 
>>> low) -> IRQ 22
>>> [4294690.487000] ata1: SATA max UDMA/100 cmd 0xF8810000 ctl 0x0 bmdma 
>>> 0x0 irq 22
>>> [4294690.487000] ata2: SATA max UDMA/100 cmd 0xF8812000 ctl 0x0 bmdma 
>>> 0x0 irq 22
>>> [4294690.487000] ata3: SATA max UDMA/100 cmd 0xF8814000 ctl 0x0 bmdma 
>>> 0x0 irq 22
>>> [4294690.487000] ata4: SATA max UDMA/100 cmd 0xF8816000 ctl 0x0 bmdma 
>>> 0x0 irq 22
>>> [4294690.800000] ata1: SATA link up 3.0 Gbps (SStatus 123)
>>> [4294690.801000] ata1: dev 0 cfg 49:5145 82:0000 83:0000 84:0000 
>>> 85:0000 86:0000 87:0000 88:0000
>>> [4294690.801000] ata1: dev 0 ATA-0, max MWDMA2, 16514064 sectors: CHS 
>>> 16383/16/63
>>> [4294690.802000] ata1: dev 0 model number mismatch 'WDC 
>>> WD3200re/sasats_li42S' != ''
>>> [4294690.802000] ata1: dev 0 revalidation failed (errno=-19)
>>> [4294690.802000] ata1: failed to revalidate after set xfermode
>>> [4294690.802000] scsi2 : sata_sil24
>>> [4294691.003000] ata2: SATA link down (SStatus 0)
>>> [4294691.003000] scsi3 : sata_sil24
>>> [4294691.204000] ata3: SATA link down (SStatus 0)
>>> [4294691.204000] scsi4 : sata_sil24
>>> [4294691.405000] ata4: SATA link down (SStatus 0)
>>> [4294691.405000] scsi5 : sata_sil24
>>>
>>> Can this still be a pci bus problem? I get the same error on every 
>>> reboot.
>> Hmmm.. max MWDMA2?  Something is very off with your configuration.  Can 
>> you try the card in another box or on a regular PCI slot?
> 
> Since moving the card to another slot changes the behaviour/problem, I'm 
> thinking it might be a mobo implementation problem with slots 
> interacting WRT IRQ, like in the older PCI-IRQ problem days.
> 
> You might try shifting that card and other cards in various slots and 
> dump the IRQ table for each combination. Maybe simply take out any other 
> cards you can live without while trying out the various slots.

I shifted the sata card into a 66MHz, 32bit PCI slot now and the
problems went away. Just for the record, this is an Asus PU-DLS
mainboard with E7501 chipset. Now I can dd from all devices without
any error messages, giving me about 360mb/s continuous throughput for
6 devices which isn't that bad I suppose.
The card gets assigned irq 22 in both configurations but in the
latter the irq is shared with the on-board usb-uhci controller
which somehow seems to work better...

Thanks for all your help,

Jan


