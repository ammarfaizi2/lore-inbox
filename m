Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVGYGb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVGYGb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVGYGbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 02:31:55 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:45456 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261661AbVGYGbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 02:31:08 -0400
In-Reply-To: <877jfhnxrp.fsf@devron.myhome.or.jp>
References: <e93921519c29efda5b7a304d019dcc94@helenandmark.org> <877jfhnxrp.fsf@devron.myhome.or.jp>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4e427d7187338fdc6012b8ae6a458040@helenandmark.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Mark Burton <mark@helenandmark.org>
Subject: Re: tx queue start entry x dirty entry y (was 8139too PCI IRQ issues)
Date: Mon, 25 Jul 2005 08:30:34 +0200
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
X-Mailer: Apple Mail (2.622)
X-Spam-Virus: No
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[I'm currently having nasty ISP problems, so I've removed myself from 
the list for the time-being, as e-mail is struggling to get through to 
me -- hence the delay in my reply to this, SORRY]

>
> Probably it's the miss config of PIC. Can you post more info?

Thanks for helping! :-)))

>
>   - /proc/interrupt

more /proc/interrupts
            CPU0
   0:     473349    IO-APIC-edge  timer
   1:         10    IO-APIC-edge  i8042
   2:          0          XT-PIC  cascade
   5:          1    IO-APIC-edge  soundblaster
   7:          2    IO-APIC-edge  parport0
   9:       8152    IO-APIC-edge  aic7xxx
  10:      19988    IO-APIC-edge  eth0
  11:        577    IO-APIC-edge  ohci_hcd, ohci_hcd, ohci_hcd, 
ohci_hcd, eth1
  12:        101    IO-APIC-edge  i8042
  14:      51421    IO-APIC-edge  ide0
NMI:          0
LOC:     473350
ERR:          0
MIS:          0

>   - mptable

I'm running a single (old) processor, and I dont have mptable 
installed.... I can't even find a package for it, am I missing 
something? Sorry!

>   - 8259A.pl

perl 8259A.pl
irq 0: 00, edge
irq 1: 00, edge
irq 2: 00, edge
irq 3: 00, edge
irq 4: 00, edge
irq 5: 00, edge
irq 6: 00, edge
irq 7: 00, edge
irq 8: 0a, edge
irq 9: 0a, level
irq 10: 0a, edge
irq 11: 0a, level
irq 12: 0a, edge
irq 13: 0a, edge
irq 14: 0a, edge
irq 15: 0a, edge


>   - lspci -vvv

0000:00:00.0 Non-VGA unclassified device: Intel Corp. 82378ZB/IB, 
82379AB (SIO, SIO.A) PCI to ISA Bridge (rev 88)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:01.0 IDE interface: Silicon Image, Inc. (formerly CMD 
Technology Inc) PCI0646 (rev 01) (prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (500ns min, 1000ns max)
         Interrupt: pin A routed to IRQ 14
         Region 0: I/O ports at <ignored>
         Region 1: I/O ports at <ignored>
         Region 2: I/O ports at <ignored>
         Region 3: I/O ports at <ignored>
         Region 4: I/O ports at fc00 [size=16]

0000:00:02.0 SCSI storage controller: Adaptec AIC-7880U
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (2000ns min, 2000ns max), Cache Line Size: 0x08 
(32 bytes)
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at f800 [disabled] [size=256]
         Region 1: Memory at ffbfc000 (32-bit, non-prefetchable) 
[size=4K]

0000:00:0b.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W 
[Millennium] (rev 01) (prog-if 00 [VGA])
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at a0000000 (32-bit, non-prefetchable) 
[size=16K]
         Region 1: Memory at a0800000 (32-bit, prefetchable) [size=8M]
         Expansion ROM at d0000000 [disabled] [size=64K]

0000:00:0d.0 USB Controller: Lucent Microelectronics USS-344S USB 
Controller (rev 11) (prog-if 10 [OHCI])
         Subsystem: Lucent Microelectronics USS-344S USB Controller
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (750ns min, 21500ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at ffbec000 (32-bit, non-prefetchable) 
[size=4K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:00:0d.1 USB Controller: Lucent Microelectronics USS-344S USB 
Controller (rev 11) (prog-if 10 [OHCI])
         Subsystem: Lucent Microelectronics USS-344S USB Controller
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (750ns min, 21500ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at ffbdc000 (32-bit, non-prefetchable) 
[size=4K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:00:0d.2 USB Controller: Lucent Microelectronics USS-344S USB 
Controller (rev 11) (prog-if 10 [OHCI])
         Subsystem: Lucent Microelectronics USS-344S USB Controller
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (750ns min, 21500ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at ffbcc000 (32-bit, non-prefetchable) 
[size=4K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:00:0d.3 USB Controller: Lucent Microelectronics USS-344S USB 
Controller (rev 11) (prog-if 10 [OHCI])
         Subsystem: Lucent Microelectronics USS-344S USB Controller
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (750ns min, 21500ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at ffbbc000 (32-bit, non-prefetchable) 
[size=4K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at f400 [size=256]
         Region 1: Memory at ffbac000 (32-bit, non-prefetchable) 
[size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:14.0 RAM memory: Intel Corp. 450KX/GX [Orion] - 82453KX/GX 
Memory controller (rev 04)
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:19.0 Host bridge: Intel Corp. 450KX/GX [Orion] - 82454KX/GX PCI 
bridge (rev 04)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)


> -- 

On 23 Jul 2005, at 21:11, OGAWA Hirofumi wrote:

> Mark Burton <mark@helenandmark.org> writes:
>
>> Hi,
>> I'm getting similar results to Nick Warne, in that when my ethernet is
>> stressed at all (for instance by NFS), I end up with
>> nfs: server..... not responding, still trying
>> nfs: server .... OK
>>
>> With a realtec card, I get errors in /var/spool/messages along the
>> lines of:
>> Jul  3 14:31:13 localhost kernel: eth1: Transmit timeout, status 0c
>> 0005 c07f media 00.
>> Jul  3 14:31:13 localhost kernel: eth1: Tx queue start entry 1160
>> dirty entry 1156.
>> Jul  3 14:31:13 localhost kernel: eth1:  Tx descriptor 0 is
>> 0008a03c. (queue head)
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

