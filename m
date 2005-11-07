Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965340AbVKGUFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965340AbVKGUFk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965344AbVKGUFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:05:20 -0500
Received: from [213.136.55.209] ([213.136.55.209]:33467 "EHLO inaps3.inap.se")
	by vger.kernel.org with ESMTP id S964901AbVKGUEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:04:49 -0500
Message-ID: <436FB350.6020309@inap.se>
Date: Mon, 07 Nov 2005 21:04:32 +0100
From: Johan Palmqvist <johan.palmqvist@inap.se>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hpt366 driver oops or panic with HighPoint RocketRAID 1520 SATA (HPT372N)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When used with a HighPoint RocketRAID 1520 SATA (HPT372N) the hpt366 
driver, compiled as a module, oops'es on loading. If the driver is 
compiled into the kernel it causes a kernel panic on boot while 
detecting the card. Kernels tested: 2.6.13.2, 2.6.13.4 and 2.6.14. 
Please CC any answers to me since I'm not on the list.


lspci -vvv:

0000:00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX 
Host bridge (rev 02)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 1.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- 
FW- Rate=<none>

0000:00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX 
AGP bridge (rev 02) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: e4000000-e7ffffff
         Prefetchable memory behind bridge: 30000000-300fffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

0000:00:0d.0 RAID bus controller: Triones Technologies, Inc. 
HPT372A/372N (rev 02)
         Subsystem: Triones Technologies, Inc.: Unknown device 0001
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 2000ns max), Cache Line Size: 0x08 (32 
bytes)
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at d800 [size=8]
         Region 1: I/O ports at dc00 [size=4]
         Region 2: I/O ports at e000 [size=8]
         Region 3: I/O ports at e400 [size=4]
         Region 4: I/O ports at e800 [size=256]
         Expansion ROM at e9000000 [disabled] [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


dmesg:

HPT372A: IDE controller at PCI slot 0000:00:0d.0
PCI: Enabling device 0000:00:0d.0 (0005 -> 0007)
PCI: Found IRQ 11 for device 0000:00:0d.0
HPT372A: chipset revision 2
HPT372A: 100% native mode on irq 11
hpt: HPT372N detected, using 372N timing.
FREQ: 122 PLL: 45
HPT37XN: unknown bus timing [48 4].
hpt: no known IDE timings, disabling DMA.
hpt: HPT372N detected, using 372N timing.
FREQ: 168 PLL: 66
HPT37XN: unknown bus timing [69 4].
hpt: no known IDE timings, disabling DMA.
Probing IDE interface ide2...
hde: ST3250823AS, ATA DISK drive
Unable to handle kernel NULL pointer dereference at virtual address
00000000
  printing eip:
e08553a1
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: hpt366 i2c_piix4 i2c_core e100 mii
CPU:    0
EIP:    0060:[<e08553a1>]    Not tainted VLI
EFLAGS: 00010286   (2.6.14)
EIP is at pci_bus_clock_list+0x11/0x50 [hpt366]
eax: 0000000c   ebx: 00000000   ecx: 80006850   edx: 00000cfd
esi: 0000000c   edi: c1595c00   ebp: df69e940   esp: dffc9e24
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 3415, threadinfo=dffc9000 task=df9cc5c0)
Stack: 0c000000 00000040 e08557ad 0000000c 00000000 00000051 00000000
0c000000
        30070000 cff8ffff 00000000 00442cb0 c0442cb0 00000000 dfbb443e
c0442c20
        c02752da c0442cb0 0000000c c1595c00 0000000b 0000000b c0442cb0
00000246
Call Trace:
  [<e08557ad>] hpt372_tune_chipset+0xdd/0x170 [hpt366]
  [<c02752da>] probe_hwif+0x4aa/0x530
  [<c0275375>] probe_hwif_init_with_fixup+0x15/0x90
  [<c0278c0d>] ide_setup_pci_device+0x5d/0xa0
  [<c021c766>] __pci_device_probe+0x56/0x70
  [<c021c7af>] pci_device_probe+0x2f/0x50
  [<c0250da3>] driver_probe_device+0x43/0xd0
  [<c0250eb0>] __driver_attach+0x0/0x50
  [<c0250ef1>] __driver_attach+0x41/0x50
  [<c02502dd>] bus_for_each_dev+0x5d/0x80
  [<c0250f25>] driver_attach+0x25/0x30
  [<c0250eb0>] __driver_attach+0x0/0x50
  [<c0250839>] bus_add_driver+0x89/0xf0
  [<c021ca22>] pci_register_driver+0x62/0x90
  [<e08574ef>] hpt366_ide_init+0xf/0x14 [hpt366]
  [<c0133251>] sys_init_module+0xc1/0x1a0
  [<c0102d05>] syscall_call+0x7/0xb
Code: 9b df 85 c0 74 e4 eb d2 83 c4 08 31 c0 5b 5e 5f 5d c3 90 8d b4 26
00 00 00 00 53 83 ec 04 0f b6 44 24 0c 8b 5c 24 10 88 44 24 03 <0f> b6
03 84 c0 74 28 38 44 24 03 74 22 8d 43 08 89 c1 eb 03 83
