Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318225AbSIFB3d>; Thu, 5 Sep 2002 21:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318224AbSIFB3d>; Thu, 5 Sep 2002 21:29:33 -0400
Received: from rom.cscaper.com ([216.19.195.129]:39615 "HELO mail.cscaper.com")
	by vger.kernel.org with SMTP id <S318221AbSIFB3c>;
	Thu, 5 Sep 2002 21:29:32 -0400
Subject: DMA borked in 2.4.20-pre5-ac1
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
From: "Joseph N. Hall" <joseph@5sigma.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 5 Sep 2002 18:36 -0700
X-mailer: Mailer from Hell v1.0
Message-Id: <20020906012932Z318221-685+43270@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I got tired of living DMA hell with the Soyo Dragon Ultra 
Platinum m/b (KT333a), and bought an ALi-based m/b instead,
an IWill XP333-R.  But ... to my dismay I had no DMA at all
when booting under 2.4.20-pre5-ac1, which at least gave me
hard disk DMA on the Soyo.  Also under 2.4.20-pre5-ac1
hdparm -d1 /dev/hda refused to work, and hdparm -X66 
/dev/hda segfaulted:

Sep  4 19:38:14 dhcppc5 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Sep  4 19:38:14 dhcppc5 kernel:  printing eip:
Sep  4 19:38:14 dhcppc5 kernel: 00000000
Sep  4 19:38:14 dhcppc5 kernel: *pde = 00000000
Sep  4 19:38:14 dhcppc5 kernel: Oops: 0000
Sep  4 19:38:14 dhcppc5 kernel: CPU:    0
Sep  4 19:38:14 dhcppc5 kernel: EIP:    0010:[<00000000>]    Not tainted
Sep  4 19:38:14 dhcppc5 kernel: EFLAGS: 00010286
Sep  4 19:38:14 dhcppc5 kernel: eax: 00000042   ebx: 000000fa   ecx: 80002054   edx: 00000cfe
Sep  4 19:38:14 dhcppc5 kernel: esi: c02ef9f0   edi: 00000056   ebp: c02ef940   esp: e02abdb8
Sep  4 19:38:14 dhcppc5 kernel: ds: 0018   es: 0018   ss: 0018
Sep  4 19:38:14 dhcppc5 kernel: Process hdparm (pid: 2077, stackpage=e02ab000)
Sep  4 19:38:14 dhcppc5 kernel: Stack: c0190cd9 c02ef9f0 000000fa 00000001 42000056 000000fa 00000000 00000056
Sep  4 19:38:14 dhcppc5 kernel:        c253ac00 c01a210e c02ef9f0 00000042 e02abdf3 00000001 fa42be1c e02abe90
Sep  4 19:38:14 dhcppc5 kernel:        e02abe90 c02ef9f0 e02abe1c c01939f7 c02ef9f0 00000042 00000004 42557540
Sep  4 19:38:14 dhcppc5 kernel: Call Trace:    [<c0190cd9>] [<c01a210e>] [<c01939f7>] [<c01328c9>] [<c017088c>]
Sep  4 19:38:14 dhcppc5 kernel:   [<c016d6d8>] [<c016cfec>] [<c0198122>] [<c016f18c>] [<c013f6a3>] [<c01462e6>]
Sep  4 19:38:14 dhcppc5 kernel:   [<c01087a3>]
Sep  4 19:38:14 dhcppc5 kernel:
Sep  4 19:38:14 dhcppc5 kernel: Code:  Bad EIP value.

Here are some syslog messages.  I'm not in the mood to go retrieve
the 2.4.20-pre5-ac1 dmesg, but will do it if asked.

Under 2.4.20-pre5-ac1:

Sep  5 18:16:33 dhcppc5 kernel: Linux version 2.4.20-pre5-ac1 (root@dhcppc4) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #4 Sun Sep 1 22:06:11 PDT 2002

Sep  5 18:16:41 dhcppc5 kernel: ALI15X3: IDE controller at PCI slot 00:04.0
Sep  5 18:16:41 dhcppc5 kernel: PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using pci=biosirq.
Sep  5 18:16:41 dhcppc5 kernel: ALI15X3: chipset revision 196
Sep  5 18:16:41 dhcppc5 kernel: ALI15X3: not 100%% native mode: will probe irqs later
Sep  5 18:16:41 dhcppc5 kernel: ALI15X3: simplex device with no drives: DMA disabled
Sep  5 18:16:41 dhcppc5 kernel: ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
Sep  5 18:16:41 dhcppc5 kernel: ALI15X3: simplex device with no drives: DMA disabled
Sep  5 18:16:41 dhcppc5 kernel: ide1: ALI15X3 Bus-Master DMA disabled (BIOS)

Under 2.4.19:
Sep  5 18:20:03 dhcppc5 kernel: Linux version 2.4.19 (root@dhcppc4) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #6 Sun Sep 1 22:07:45 PDT 2002

Sep  5 18:20:04 dhcppc5 kernel: ALI15X3: IDE controller on PCI bus 00 dev 20
Sep  5 18:20:04 dhcppc5 kernel: PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using pci=biosirq.
Sep  5 18:20:04 dhcppc5 kernel: ALI15X3: chipset revision 196
Sep  5 18:20:04 dhcppc5 kernel: ALI15X3: not 100%% native mode: will probe irqs later
Sep  5 18:20:04 dhcppc5 kernel:     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
Sep  5 18:20:04 dhcppc5 kernel:     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA

00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) (prog-if 8a [Master SecP PriP])
        Subsystem: Acer Laboratories Inc. [ALi] M5229 IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at a000 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
        Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0


