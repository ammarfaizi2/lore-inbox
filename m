Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVBTIzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVBTIzx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 03:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVBTIzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 03:55:53 -0500
Received: from [81.23.229.73] ([81.23.229.73]:56035 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261651AbVBTIzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 03:55:25 -0500
From: Norbert van Nobelen <norbert-kernel@edusupport.nl>
Organization: EduSupport BV
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Yenta TI: ... no PCI interrupts. Fish. Please report.
Date: Sun, 20 Feb 2005 09:55:19 +0100
User-Agent: KMail/1.6.2
References: <1108850049.8413.143.camel@localhost.localdomain>
In-Reply-To: <1108850049.8413.143.camel@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200502200955.19404.norbert-kernel@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tried it to get it to work without ACPI in the kernel at all, and 
start from there?

Best regards,

Norbert

On Saturday 19 February 2005 22:54, you wrote:
> Hi everyone,
>
> I've been banging my head on this one a couple of days with no luck.
>
> I have a IBM Thinkpad G41 with a pentium4M with Hyperthreading.  I can't
> get the PCMCIA working at all.  I've tried turning off hyperthreading,
> I've tried with and without preempt, I've even added pci=noacpi. I've
> added Len's ACPI patches, but nothing works.
>
> Here's lspci -vvv:
>
> 0000:00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
>         Subsystem: IBM: Unknown device 0579
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
>         Capabilities: <available only to root>
>
> 0000:00:00.1 System peripheral: Intel Corp. 855GM/GME GMCH Memory I/O
> Control Registers (rev 02) Subsystem: IBM: Unknown device 057a
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>
> 0000:00:00.3 System peripheral: Intel Corp. 855GM/GME GMCH Configuration
> Process Registers (rev 02) Subsystem: IBM: Unknown device 057b
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
> DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>
> 0000:00:01.0 PCI bridge: Intel Corp. 855GME GMCH Host-to-AGP Bridge
> (Virtual PCI-to-PCI) (rev 02) (prog-if 00 [Normal decode]) Control: I/O+
> Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
> FastB2B- Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 96
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>         I/O behind bridge: 0000f000-00000fff
>         Memory behind bridge: c1000000-c1ffffff
>         Prefetchable memory behind bridge: e0000000-efffffff
>         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
>
>
> [ ... USB controllers snipped out ... ]
>
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81) (prog-if 00
> [Normal decode]) Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop- ParErr- Stepping- SERR+ FastB2B- Status: Cap- 66MHz- UDF-
> FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
>         Latency: 0
>         Bus: primary=00, secondary=02, subordinate=08, sec-latency=168
>         I/O behind bridge: 00003000-00006fff
>         Memory behind bridge: c2000000-cfffffff
>         Prefetchable memory behind bridge: f0000000-f7ffffff
>         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>
> 0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev
> 01) Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
> DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 0
>
> [ ... snipped out IDE Bridge controllers too ... ]
>
> 0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus
> Controller (rev 01) Subsystem: IBM: Unknown device 0547
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
> DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Interrupt: pin B
> routed to IRQ 11
>         Region 4: I/O ports at 1880 [size=32]
>
> [ ... snipped audio VGA NVidia and Ethernet controllers ... ]
>
> 0000:02:01.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus
> Controller (rev 01) Subsystem: IBM ThinkPad T30/T40
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 168, Cache
> Line Size: 0x20 (128 bytes)
>         Interrupt: pin A routed to IRQ 177
>         Region 0: Memory at 3fefb000 (32-bit, non-prefetchable) [size=4K]
>         Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
>         Memory window 0: 40000000-403ff000 (prefetchable)
>         Memory window 1: 40400000-407ff000
>         I/O window 0: 00004000-000040ff
>         I/O window 1: 00004400-000044ff
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
> PostWrite+ 16-bit legacy interface ports at 0001
>
> 0000:02:01.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus
> Controller (rev 01) Subsystem: IBM ThinkPad T30/T40
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 168, Cache
> Line Size: 0x20 (128 bytes)
>         Interrupt: pin B routed to IRQ 185
>         Region 0: Memory at 3fefc000 (32-bit, non-prefetchable) [size=4K]
>         Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
>         Memory window 0: 40800000-40bff000 (prefetchable)
>         Memory window 1: 40c00000-40fff000
>         I/O window 0: 00004800-000048ff
>         I/O window 1: 00004c00-00004cff
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt-
> PostWrite+ 16-bit legacy interface ports at 0001
>
>
>
> The above is probably more than anyone needs, but if I should show the
> whole listing (USB, Audio and all), just let me know and I can post all
> of it too.
>
>
> And here's the dmesg:
>
> Linux Kernel Card Services
>   options:  [pci] [cardbus] [pm]
> ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 20 (level, low) -> IRQ 177
> Yenta: CardBus bridge found at 0000:02:01.0 [1014:0512]
> Yenta: Using INTVAL to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: socket 0000:02:01.0, mfunc 0x01001c22, devctl 0x64
> Yenta TI: socket 0000:02:01.0 probing PCI interrupt failed, trying to fix
> Yenta TI: socket 0000:02:01.0 no PCI interrupts. Fish. Please report.
> Yenta: ISA IRQ mask 0x0000, PCI irq 0
> Socket status: ffffffff
> ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 21 (level, low) -> IRQ 185
> Yenta: CardBus bridge found at 0000:02:01.1 [1014:0512]
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: socket 0000:02:01.1, mfunc 0x01001c22, devctl 0x64
> Yenta TI: socket 0000:02:01.1 probing PCI interrupt failed, trying to fix
> Yenta TI: socket 0000:02:01.1 no PCI interrupts. Fish. Please report.
> Yenta: ISA IRQ mask 0x0000, PCI irq 0
> Socket status: 4410080c
>
> (the above is from kernel.org 2.6.10 with Len's ACPI patches).
>
> I've tried this with Debian stock kernels: 2.4.27-1-386, 2.6.8-2-686,
> 2.6.9-1-686, 2.6.10-1-686-smp
>
> I've also tried kernel.org kernels with 2.6.9, 2.6.10 and
> 2.6.11-rc3-mm2.  As I've mentioned, I've added Len's ACPI patches to
> 2.6.10 and still nothing works. I've tried disable_clkrun but still
> nothing. I've found a couple of other patches on the net and nothing
> works.
>
> I've tried debugging this but PCMCIA is not my strong spot, so all I can
> tell you is that the interrupt never comes in when Yenta probes it.
>
> Does anyone else out there have a IBM Thinkpad G41 and have this
> working? Or, do you have it and it is not working.  I get no power to
> the PCMCIA card slots, so they are basically useless now.
>
> Any ideas would be appreciated.
>
> Thanks,
>
> -- Steve
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
<a href="http://www.edusupport.nl">EduSupport: Linux Desktop for schools and 
small to medium business in The Netherlands and Belgium</a>
