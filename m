Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHP4P>; Thu, 8 Feb 2001 10:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129063AbRBHP4F>; Thu, 8 Feb 2001 10:56:05 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:12557 "HELO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S129031AbRBHPz6>; Thu, 8 Feb 2001 10:55:58 -0500
Message-ID: <8C91B010B3B7994C88A266E1A72184D3116FCE@cceexc19.americas.cpqcorp.net>
From: "Zink, Dan" <Dan.Zink@COMPAQ.com>
To: "'Martin Mares'" <mj@suse.cz>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'al10@inf.tu-dresden.de'" <al10@inf.tu-dresden.de>
Subject: RE: [Patch] ServerWorks peer bus fix for 2.4.x
Date: Thu, 8 Feb 2001 10:00:13 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> What leads you to your belief it's correct? The lspci dump Adam has sent
> to the list shows that there's something utterly wrong with our
understanding
> of the ServerWorks config registers -- they seem to say that the primary
> bus numbers are 00 and 01, but in reality they are 00 and 02.

If you look at the lspci output below, you will find that this server has
root
busses 0, 2, and 7.  Also, the BIOS reports the last bus to be 10.
Accordingly,
offset 44 and 45 of function 0 are 2 and 10.  For function 1 they are 0 and
1.
That matches the comment in the kernel about them being the first and last
bus.
 
> For now, it will be better to comment out the whole ServerWorks fixup
thing
> and let the generic peer bus code do its magic work -- it's far better to
rely
> on BIOS and chipset to behave sanely (i.e., BIOS reporting last_bus not
lower
> than the real one and chipset not decoding out-of-range bus numbers) than
on
> guesses of register values which are probably wrong, at least until we
have
> some more examples for comparison.

I agree with this.  Especially given the fact that it will require less
maintenance
down the road.  It would be hard to keep up with the ever-changing chipset
world.

> and also try commenting out the lines
> 
> 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SERVERWORKS,	
> PCI_DEVICE_ID_SERVERWORKS_HE,		pci_fixup_serverworks },
> 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SERVERWORKS,	
> PCI_DEVICE_ID_SERVERWORKS_LE,		pci_fixup_serverworks },
> 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SERVERWORKS,	
> PCI_DEVICE_ID_SERVERWORKS_CMIC_HE,	pci_fixup_serverworks },
> 
> in arch/i386/kernel/pci-pc.c, please?

I had already tried that with good results.  Everything works fine if we
don't use
the pci_fixup_serverworks function.

Thanks,
Dan


Here is the output of 'lspci -MH1 -vvx' slightly edited to reduce the
length...

00:00.0 Host bridge: ServerWorks CNB20HE (rev 21)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 66 11 08 00 00 00 00 00 21 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.1 Host bridge: ServerWorks CNB20HE (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64, cache line size 08
00: 66 11 08 00 47 01 00 22 01 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.2 Host bridge: ServerWorks: Unknown device 0006
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
00: 66 11 06 00 42 01 00 22 00 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.3 Host bridge: ServerWorks: Unknown device 0006
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
00: 66 11 06 00 42 01 00 22 00 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 System peripheral: Compaq Computer Corporation Advanced System
Management Controller
	Subsystem: Compaq Computer Corporation: Unknown device b0f3
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 255
	Region 0: I/O ports at 1800
	Region 1: Memory at cabf0000 (32-bit, non-prefetchable)
00: 11 0e f0 a0 43 01 00 02 00 00 80 08 00 00 00 00
10: 01 18 00 00 00 00 bf ca 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e f3 b0
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00

00:0f.0 ISA bridge: ServerWorks OSB4 (rev 4f)
	Subsystem: ServerWorks OSB4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 66 11 00 02 07 00 00 02 4f 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 00 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a [Master
SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 2c00
00: 66 11 11 02 45 01 00 02 00 8a 01 01 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 2c 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:05.0 PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug
Controller (rev 12)
	Subsystem: Compaq Computer Corporation: Unknown device a2f8
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at dcef0000 (32-bit, non-prefetchable)
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
		Address: 0000000000000000  Data: 0000
00: 11 0e f7 a0 42 01 30 02 12 00 04 08 00 00 00 00
10: 00 00 ef dc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e f8 a2
30: 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 00 00

07:05.0 PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug
Controller (rev 12)
	Subsystem: Compaq Computer Corporation: Unknown device a2f9
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f7ff0000 (32-bit, non-prefetchable)
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
		Address: 0000000000000000  Data: 0000
00: 11 0e f7 a0 42 01 30 02 12 00 04 08 00 00 00 00
10: 00 00 ff f7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e f9 a2
30: 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 00 00


Summary of buses:

00: Primary host bus
02: Secondary host bus (?)
07: Secondary host bus (?)


Here is the complete output of 'lspci -vvxxx -s0:0'...

00:00.0 Host bridge: ServerWorks CNB20HE (rev 21)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 66 11 08 00 00 00 00 00 21 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 02 0a 00 00 00 71 03 3b 00 00 00 00
50: 00 00 00 00 f3 0b 00 00 00 00 00 10 40 00 00 00
60: 00 00 c0 10 00 01 07 07 00 00 00 00 00 00 00 00
70: 04 2a 00 aa 90 0c ff 2f 09 18 80 00 00 60 00 00
80: 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00 00
90: 08 fa 3e 5f 01 00 f0 00 05 00 f0 00 00 00 00 00
a0: 00 01 02 20 04 05 06 07 00 00 00 00 00 00 00 00
b0: ff 7e fc 7f cf 78 de df e7 d2 c0 ee f3 be 80 60
c0: ac 0c 7f 0f 00 00 00 00 00 00 00 00 01 07 c0 fe
d0: 00 30 fc 8f 00 00 00 00 00 00 00 00 01 00 00 00
e0: 04 00 00 00 aa 78 ff 7d ff ff 78 aa 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 c0 00 00 00

00:00.1 Host bridge: ServerWorks CNB20HE (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64, cache line size 08
00: 66 11 08 00 47 01 00 22 01 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 01 18 00 80 00 00 4b 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 02 00 20 00 01 02 00 10 41 3c 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 90 0c ab 0c 00 00 00 00 00 00 00 00 01 07 00 00
d0: 00 00 0c 2c 00 00 00 00 00 00 00 00 01 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: df fa f6 7b bf b3 f7 3f 00 00 00 00 c2 0d 00 00

00:00.2 Host bridge: ServerWorks: Unknown device 0006
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
00: 66 11 06 00 42 01 00 22 00 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 02 06 00 00 00 00 00 0e 00 00 00 20
50: 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 2a 00 aa 90 0c ff 0f 00 00 00 00 00 00 00 00
80: 10 00 00 00 91 00 ce 50 d5 04 00 10 00 00 00 00
90: 90 54 40 49 94 94 d0 56 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: ac 0c ce 0d 00 00 00 00 00 00 00 00 01 07 00 00
d0: 00 30 fc 5f 10 d1 40 06 30 01 50 1c 01 00 00 00
e0: 11 d0 45 d4 00 00 00 00 00 00 00 00 c4 00 00 00
f0: 40 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.3 Host bridge: ServerWorks: Unknown device 0006
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
00: 66 11 06 00 42 01 00 22 00 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 07 0a 00 00 00 00 00 0e 00 00 00 00
50: 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 2a 00 aa 90 0c ff 0f 00 00 00 00 00 00 00 00
80: 10 00 00 00 91 00 ce 50 d5 04 00 10 00 00 00 00
90: 30 dc 00 04 d0 54 90 10 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 c1 00 29 44 00 00 00 00 00 00 00 00
c0: cf 0d 7f 0f 00 00 00 00 00 00 00 00 01 07 00 00
d0: 00 60 fc 8f b0 55 00 31 10 9e 58 a1 01 00 00 00
e0: 50 9c 59 d5 00 00 00 00 00 00 00 00 c6 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
