Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbWD0S6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWD0S6T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWD0S6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:58:19 -0400
Received: from 10.121.9.213.dsl.getacom.de ([213.9.121.10]:27577 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S965014AbWD0S6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:58:18 -0400
Date: Thu, 27 Apr 2006 20:58:14 +0200
From: jdi@l4x.org
To: jgarzik@pobox.com
Cc: jdi@l4x.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: sata_sil24 resetting controller...
Message-ID: <20060427185813.GB6039@l4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just received a DawiControl DC-4300 SATA-2 RAID card
(sil3124 based) together with a Western Digital WD3200KS 
hard drive which should support sata2 and ncq in its
full glory. Basic read/write tests with dd went ok,
so I started to reshape my raid5 array. Since the reshape
started my kernel log gets swamped with the following messages:

[4297871.909000] sata_sil24 ata1: resetting controller...
[4297871.909000] ata1: status=0x50 { DriveReady SeekComplete }
[4297871.909000] sdc: Current: sense key=0x0
[4297871.909000]     ASC=0x0 ASCQ=0x0
[4297873.266000] ata1: error interrupt on port0
[4297873.266000]   stat=0x80000001 irq=0xb60002 cmd_err=35 sstatus=0x123
serror=0x0[4297873.266000] sata_sil24 ata1: resetting controller...
[4297873.267000] ata1: status=0x50 { DriveReady SeekComplete }
[4297873.267000] sdc: Current: sense key=0x0
[4297873.267000]     ASC=0x0 ASCQ=0x0

The time between these events varies from .5s to up to 10s, resync speed is
pretty bad (6mb/s) but appears(!) to be working.
This is with vanilla 2.6.17-rc3, sata drivers built into the kernel.
Find below /proc/interrupts and lspci output. Boot dmesg output was washed
away by above messages, sorry.

What's the cause of the error, can I ignore it or will it destroy
my raid eventually? I'm now about 5% through the resync process, with 
an estimated finish in 1260 minutes.

Thanks,

Jan


$ lspci -vv -s 03:04.0
0000:03:04.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 01)
	Subsystem: Silicon Image, Inc.: Unknown device 7124
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at fa800000 (64-bit, non-prefetchable) [size=128]
	Region 2: Memory at fa000000 (64-bit, non-prefetchable) [size=32K]
	Region 4: I/O ports at 9400 [size=16]
	Expansion ROM at fe900000 [disabled] [size=512K]
	Capabilities: [64] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [40] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=5
		Status: Bus=3 Dev=4 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=2, DMOST=5, DMCRS=4, RSCEM-
	Capabilities: [54] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

$ lspci

0000:00:00.0 Host bridge: Intel Corporation E7501 Memory Controller Hub (rev 01)
0000:00:00.1 ff00: Intel Corporation E7500/E7501 Host RASUM Controller (rev 01)
0000:00:02.0 PCI bridge: Intel Corporation E7500/E7501 Hub Interface B PCI-to-PCI Bridge (rev 01)
0000:00:1d.0 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #1) (rev 02)
0000:00:1d.1 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #2) (rev 02)
0000:00:1d.2 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #3) (rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corporation 82801CA LPC Interface Controller (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 82801CA Ultra ATA Storage Controller (rev 02)
0000:01:1c.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
0000:01:1d.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev 04)
0000:01:1e.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
0000:01:1f.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev 04)
0000:02:03.0 Mass storage controller: Promise Technology, Inc. PDC20268 (Ultra100 TX2) (rev 02)
0000:02:05.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
0000:02:05.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
0000:03:03.0 Ethernet controller: Intel Corporation 82544GC Gigabit Ethernet Controller (LOM) (rev 02)
0000:03:04.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 01)
0000:04:01.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 02)
0000:04:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
0000:04:03.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI Video and Audio Decoder (rev 05)
0000:04:03.2 Multimedia controller: Conexant CX23880/1/2/3 PCI Video and Audio Decoder [MPEG Port] (rev 05)
0000:04:03.4 Multimedia controller: Conexant CX23880/1/2/3 PCI Video and Audio Decoder [IR Port] (rev 05)

$ cat /proc/interrupts

           CPU0       CPU1       CPU2       CPU3       
  0:     585143     480193    1343927    1340601    IO-APIC-edge  timer
  1:          9          0          1          0    IO-APIC-edge  i8042
  7:          0          0          0          0    IO-APIC-edge  parport0
  8:          4          0          0          0    IO-APIC-edge  rtc
  9:          0          0          0          0   IO-APIC-level  acpi
 14:     206162     136159     141145     134456    IO-APIC-edge  ide0
 16:    3024021          0          0          0   IO-APIC-level  eth0
 17:        139          0      48709          0   IO-APIC-level  eth1
 18:          0          0          0          0   IO-APIC-level  uhci_hcd:usb3
 19:      83632     396995     247509     324823   IO-APIC-level  ide2, ide3
 20:      12682      32985      15646      34963   IO-APIC-level  aic79xx
 21:         15          0          0          0   IO-APIC-level  aic79xx
 22:     103851     230769     219349     209174   IO-APIC-level  libata
 23:          0          0          0          0   IO-APIC-level  uhci_hcd:usb1
 24:          0          0          0          0   IO-APIC-level  uhci_hcd:usb2
 25:      46521     202715     249695     116146   IO-APIC-level  cx88[0]
NMI:          0          0          0          0 
LOC:    3749323    3749326    3749308    3749317 
ERR:          0
MIS:          0
