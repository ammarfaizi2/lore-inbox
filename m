Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbWFVV1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbWFVV1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWFVV1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:27:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:16868 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932648AbWFVV1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:27:24 -0400
Message-ID: <449B0B3C.2020904@manoweb.com>
Date: Thu, 22 Jun 2006 23:27:24 +0200
From: Alessio Sangalli <alesan@manoweb.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, alan@lxorguk.ukuu.org.uk,
       penberg@cs.Helsinki.FI, linux-kernel@vger.kernel.org,
       ink@jurassic.park.msu.ru, dtor_core@ameritech.net
Subject: Re: [PATCH] cardbus: revert IO window limit
References: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI> <20060622001104.9e42fc54.akpm@osdl.org> <1150976158.15275.148.camel@localhost.localdomain> <Pine.LNX.4.64.0606220917080.5498@g5.osdl.org> <20060622093606.2b3b1eb7.akpm@osdl.org> <Pine.LNX.4.64.0606221005410.5498@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606221005410.5498@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:98b9443de46bd48dbf34b16449aa5d76
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 22 Jun 2006, Andrew Morton wrote:
>> OK, thanks.  All we have on Alessio's machine is "freezes at boot if APM is enabled"
>> (http://lkml.org/lkml/2006/6/16/33).  Any suggestions as to how to proceed
>> with that?
> 
> It would be interesting to see the output of "/sbin/lspci -vvx" with a 
> working and a non-working kernel (obviously APM has to be disabled for 
> this test).
> 
> And the full bootup dmesg for both cases (preferably with CONFIG_PCI_DEBUG 
> enabled)
> 
> Alessio?


Ok I've found how to enable PCI_DEBUG (I had to enable kernel debugging
first).

**************************************************
"git clone" of the kernel repository
compiled it without APM support:
**************************************************

# /sbin/lspci -vvx
00:00.0 Host bridge: Intel Corp. 82440MX Host Bridge (rev 01)
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
00: 86 80 94 71 06 00 00 22 01 00 00 06 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.1 Multimedia audio controller: Intel Corp. 82440MX AC'97 Audio
Controller
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 1600 [size=256]
        Region 1: I/O ports at 1500 [size=64]
00: 86 80 95 71 05 00 00 00 00 00 01 04 00 00 00 00
10: 01 16 00 00 01 15 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:00.2 Modem: Intel Corp. 82440MX AC'97 Modem Controller (prog-if 00
[Generic])
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 1800 [size=256]
        Region 1: I/O ports at 1700 [size=128]
00: 86 80 96 71 05 00 00 00 00 00 03 07 00 00 00 00
10: 01 18 00 00 01 17 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:07.0 ISA bridge: Intel Corp. 82440MX ISA Bridge (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 86 80 98 71 0f 00 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corp. 82440MX EIDE Controller (prog-if 80
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1100 [size=16]
00: 86 80 99 71 05 00 80 02 00 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corp. 82440MX USB Universal Host
Controller (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 240
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 1200 [size=32]
00: 86 80 9a 71 05 00 80 02 00 00 03 0c 00 f0 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 12 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00

00:07.3 Bridge: Intel Corp. 82440MX Power Management Controller
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 86 80 9b 71 01 00 80 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 24020000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 20000000-21fff000 (prefetchable)
        Memory window 1: 22000000-23fff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001
00: 4c 10 50 ac 07 00 10 02 01 00 07 06 08 a8 02 00
10: 00 00 02 24 a0 00 00 02 00 01 04 b0 00 00 00 20
20: 00 f0 ff 21 00 00 00 22 00 f0 ff 23 00 10 00 00
30: fc 10 00 00 00 14 00 00 fc 14 00 00 0a 01 c0 05
40: 11 0e 0d 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 VGA compatible controller: ATI Technologies Inc Rage Mobility
P/M (rev 64) (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (2000ns min), cache line size 04
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at c1000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 24000000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 52 4c 87 00 90 02 64 00 00 03 04 00 00 00
10: 00 00 00 c0 01 30 00 00 00 00 00 c1 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
30: 00 00 00 00 5c 00 00 00 00 00 00 00 ff 01 08 00

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 3e00 [size=256]
        Region 1: Memory at e9100000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 80 00 00
10: 01 3e 00 00 00 00 10 e9 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40

00:0b.0 FireWire (IEEE 1394): NEC Corporation IEEE 1394 [OrangeLink]
Host Controller (rev 02) (prog-if 10 [OHCI])
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 04
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 24021000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 33 10 cd 00 56 01 90 02 02 10 00 0c 04 40 00 00
10: 00 10 02 24 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 00

# dmesg
Linux version 2.6.17-g9fda2669 (root@thor) (gcc version 3.4.6 (Gentoo
3.4.6-r1, ssp-3.4.5-1.0, pie-8.7.9)) #9 PREEMPT Thu Jun 22 23:12:24 CEST
2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fffffc0 (ACPI data)
 BIOS-e820: 000000000fffffc0 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 61424 pages, LIFO batch:15
DMI not present or invalid.
Allocating PCI resources starting at 20000000 (gap: 10000000:effc0000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=git ro root=301
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Detected 500.182 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256432k/262080k available (1946k kernel code, 5152k reserved,
657k data, 120k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1001.09 BogoMIPS
(lpj=500548)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0387f9ff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xeb180, last bus=0
Setting up standard PCI resources
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [8086/7194] 000600 00
PCI: Calling quirk c01de102 for 0000:00:00.0
PCI: Calling quirk c02941c5 for 0000:00:00.0
PCI: Calling quirk c029432b for 0000:00:00.0
PCI: Calling quirk c029448a for 0000:00:00.0
PCI: Found 0000:00:00.1 [8086/7195] 000401 00
PCI: Calling quirk c01de102 for 0000:00:00.1
PCI: Calling quirk c02941c5 for 0000:00:00.1
PCI: Calling quirk c029432b for 0000:00:00.1
PCI: Calling quirk c029448a for 0000:00:00.1
PCI: Found 0000:00:00.2 [8086/7196] 000703 00
PCI: Calling quirk c01de102 for 0000:00:00.2
PCI: Calling quirk c02941c5 for 0000:00:00.2
PCI: Calling quirk c029432b for 0000:00:00.2
PCI: Calling quirk c029448a for 0000:00:00.2
PCI: Found 0000:00:07.0 [8086/7198] 000601 00
PCI: Calling quirk c01de102 for 0000:00:07.0
PCI: Calling quirk c02941c5 for 0000:00:07.0
PCI: Calling quirk c029432b for 0000:00:07.0
PCI: Calling quirk c029448a for 0000:00:07.0
PCI: Found 0000:00:07.1 [8086/7199] 000101 00
PCI: Calling quirk c01de102 for 0000:00:07.1
PCI: Calling quirk c02941c5 for 0000:00:07.1
PCI: Calling quirk c029432b for 0000:00:07.1
PCI: Calling quirk c029448a for 0000:00:07.1
PCI: Found 0000:00:07.2 [8086/719a] 000c03 00
PCI: Calling quirk c01de102 for 0000:00:07.2
PCI: Calling quirk c02941c5 for 0000:00:07.2
PCI: Calling quirk c029432b for 0000:00:07.2
PCI: Calling quirk c029448a for 0000:00:07.2
PCI: Found 0000:00:07.3 [8086/719b] 000680 00
PCI: Calling quirk c01de102 for 0000:00:07.3
PCI: Calling quirk c02941c5 for 0000:00:07.3
PCI: Calling quirk c029432b for 0000:00:07.3
PCI: Calling quirk c029448a for 0000:00:07.3
PCI: Found 0000:00:08.0 [104c/ac50] 000607 02
PCI: Calling quirk c01de102 for 0000:00:08.0
PCI: Calling quirk c02941c5 for 0000:00:08.0
PCI: Calling quirk c029448a for 0000:00:08.0
PCI: Found 0000:00:09.0 [1002/4c52] 000300 00
PCI: Calling quirk c01de102 for 0000:00:09.0
PCI: Calling quirk c02941c5 for 0000:00:09.0
PCI: Calling quirk c029448a for 0000:00:09.0
Boot video device is 0000:00:09.0
PCI: Found 0000:00:0a.0 [10ec/8139] 000200 00
PCI: Calling quirk c01de102 for 0000:00:0a.0
PCI: Calling quirk c02941c5 for 0000:00:0a.0
PCI: Calling quirk c029448a for 0000:00:0a.0
PCI: Found 0000:00:0b.0 [1033/00cd] 000c00 00
PCI: Calling quirk c01de102 for 0000:00:0b.0
PCI: Calling quirk c02941c5 for 0000:00:0b.0
PCI: Calling quirk c029448a for 0000:00:0b.0
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:08.0, config 000040, pass 0
PCI: Scanning behind PCI bridge 0000:00:08.0, config 000040, pass 1
PCI: Bus scan for 0000:00 returning with max=04
PCI: Using IRQ router PIIX/ICH [8086/7198] at 0000:00:07.0
PCI: Cannot allocate resource region 0 of device 0000:00:0b.0
PCI: BIOS reporting unknown device 00:01
PCI: BIOS reporting unknown device 00:02
  got res [24000000:2401ffff] bus [24000000:2401ffff] flags 7202 for BAR
6 of 0000:00:09.0
  got res [24020000:24020fff] bus [24020000:24020fff] flags 200 for BAR
0 of 0000:00:08.0
PCI: moved device 0000:00:08.0 resource 0 (200) to 24020000
  got res [24021000:24021fff] bus [24021000:24021fff] flags 200 for BAR
0 of 0000:00:0b.0
PCI: moved device 0000:00:0b.0 resource 0 (200) to 24021000
PCI: Bus 1, cardbus bridge: 0000:00:08.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 20000000-21ffffff
  MEM window: 22000000-23ffffff
PCI: Found IRQ 10 for device 0000:00:08.0
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
NTFS driver 2.1.27 [Flags: R/O].
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
PCI: Calling quirk c01de03c for 0000:00:00.0
PCI: Calling quirk c0244ebc for 0000:00:00.0
PCI: Calling quirk c01de03c for 0000:00:00.1
PCI: Calling quirk c0244ebc for 0000:00:00.1
PCI: Calling quirk c01de03c for 0000:00:00.2
PCI: Calling quirk c0244ebc for 0000:00:00.2
PCI: Calling quirk c01de03c for 0000:00:07.0
PCI: Calling quirk c0244ebc for 0000:00:07.0
PCI: Calling quirk c01de03c for 0000:00:07.1
PCI: Calling quirk c0244ebc for 0000:00:07.1
PCI: Calling quirk c01de03c for 0000:00:07.2
PCI: Calling quirk c0244ebc for 0000:00:07.2
PCI: Calling quirk c01de03c for 0000:00:07.3
PCI: Calling quirk c0244ebc for 0000:00:07.3
PCI: Calling quirk c01de03c for 0000:00:08.0
PCI: Calling quirk c0244ebc for 0000:00:08.0
PCI: Calling quirk c01de03c for 0000:00:09.0
PCI: Calling quirk c0244ebc for 0000:00:09.0
PCI: Calling quirk c01de03c for 0000:00:0a.0
PCI: Calling quirk c0244ebc for 0000:00:0a.0
PCI: Calling quirk c01de03c for 0000:00:0b.0
PCI: Calling quirk c0244ebc for 0000:00:0b.0
vesafb: framebuffer at 0xc0000000, mapped to 0xd0800000, using 1536k,
total 4096k
vesafb: mode is 1024x768x8, linelength=1024, pages=4
vesafb: protected mode interface info at c000:4f84
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=6:6:6:6, shift=0:0:0:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.27
PCI: Found IRQ 10 for device 0000:00:0a.0
IRQ routing conflict for 0000:00:0a.0, have irq 11, want irq 10
eth0: RealTek RTL8139 at 0x3e00, 00:40:d0:17:96:b1, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 0
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: IC25N020ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1768KiB Cache, CHS=38760/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
PCI: Found IRQ 10 for device 0000:00:08.0
Yenta: CardBus bridge found at 0000:00:08.0 [0e11:000d]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:08.0, mfunc 0x017c1602, devctl 0x64
Yenta: ISA IRQ mask 0x02d8, PCI irq 10
Socket status: 30000010
USB Universal Host Controller Interface driver v3.0

PCI: IRQ 11 for device 0000:00:07.2 doesn't match PIRQ mask - try
pci=usepirqmask
<6>PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:0b.0
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x00001200
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for
USB modems and ISDN adapters
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22
10:27:24 2006 UTC).
PCI: Setting latency timer of device 0000:00:00.1 to 64
input: AT Translated Set 2 keyboard as /class/input/input0
pccard: PCMCIA card inserted into slot 0
intel8x0_measure_ac97_clock: measured 50113 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 440MX with CS4299 at 0x1600, irq 5
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
Synaptics Touchpad, model: 1, fw: 4.1, id: 0x8848a1, caps: 0x0/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input1
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: replayed 12 transactions in 7 seconds
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 120k freed
Adding 265064k swap on /dev/hda2.  Priority:-1 extents:1 across:265064k
ReiserFS: hda1: Removing [15923 112983 0x0 SD]..done
ReiserFS: hda1: There were 1 uncompleted unlinks/truncates. Completed
NTFS volume version 3.1.
pcmcia: Detected deprecated PCMCIA ioctl usage from process: cardmgr.
pcmcia: This interface will soon be removed from the kernel; please
expect breakage unless you upgrade to new tools.
pcmcia: see
http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff
0xe0000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

**************************************************
I reverted commit 4196c3af25d98204216a5d6c37ad2cb303a1f2bf
and compiled it *with* APM support:
**************************************************

# /sbin/lspci -vvx
00:00.0 Host bridge: Intel Corp. 82440MX Host Bridge (rev 01)
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
00: 86 80 94 71 06 00 00 22 01 00 00 06 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.1 Multimedia audio controller: Intel Corp. 82440MX AC'97 Audio
Controller
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 1600 [size=256]
        Region 1: I/O ports at 1500 [size=64]
00: 86 80 95 71 05 00 00 00 00 00 01 04 00 00 00 00
10: 01 16 00 00 01 15 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:00.2 Modem: Intel Corp. 82440MX AC'97 Modem Controller (prog-if 00
[Generic])
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 1800 [size=256]
        Region 1: I/O ports at 1700 [size=128]
00: 86 80 96 71 05 00 00 00 00 00 03 07 00 00 00 00
10: 01 18 00 00 01 17 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:07.0 ISA bridge: Intel Corp. 82440MX ISA Bridge (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 86 80 98 71 0f 00 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corp. 82440MX EIDE Controller (prog-if 80
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1100 [size=16]
00: 86 80 99 71 05 00 80 02 00 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corp. 82440MX USB Universal Host
Controller (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 240
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 1200 [size=32]
00: 86 80 9a 71 05 00 80 22 00 00 03 0c 00 f0 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 12 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00

00:07.3 Bridge: Intel Corp. 82440MX Power Management Controller
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 86 80 9b 71 01 00 80 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 24020000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 20000000-21fff000 (prefetchable)
        Memory window 1: 22000000-23fff000
        I/O window 0: 00002000-00002fff
        I/O window 1: 00004000-00004fff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001
00: 4c 10 50 ac 07 00 10 02 01 00 07 06 08 a8 02 00
10: 00 00 02 24 a0 00 00 02 00 01 04 b0 00 00 00 20
20: 00 f0 ff 21 00 00 00 22 00 f0 ff 23 00 20 00 00
30: fc 2f 00 00 00 40 00 00 fc 4f 00 00 0a 01 c0 05
40: 11 0e 0d 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 VGA compatible controller: ATI Technologies Inc Rage Mobility
P/M (rev 64) (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (2000ns min), cache line size 04
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at c1000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 24000000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 52 4c 87 00 90 02 64 00 00 03 04 00 00 00
10: 00 00 00 c0 01 30 00 00 00 00 00 c1 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
30: 00 00 00 00 5c 00 00 00 00 00 00 00 ff 01 08 00

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 3e00 [size=256]
        Region 1: Memory at e9100000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 80 00 00
10: 01 3e 00 00 00 00 10 e9 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40

00:0b.0 FireWire (IEEE 1394): NEC Corporation IEEE 1394 [OrangeLink]
Host Controller (rev 02) (prog-if 10 [OHCI])
        Subsystem: Compaq Computer Corporation: Unknown device 000d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 04
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 24021000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 33 10 cd 00 56 01 90 02 02 10 00 0c 04 40 00 00
10: 00 10 02 24 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 00

# dmesg
Linux version 2.6.17-g95e5c611 (root@thor) (gcc version 3.4.6 (Gentoo
3.4.6-r1, ssp-3.4.5-1.0, pie-8.7.9)) #5 PREEMPT Thu Jun 22 22:12:00 CEST
2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fffffc0 (ACPI data)
 BIOS-e820: 000000000fffffc0 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 61424 pages, LIFO batch:15
DMI not present or invalid.
Allocating PCI resources starting at 20000000 (gap: 10000000:effc0000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=git-b ro root=301
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Detected 500.038 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256420k/262080k available (1951k kernel code, 5164k reserved,
660k data, 124k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1001.07 BogoMIPS
(lpj=500536)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0387f9ff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xeb180, last bus=0
Setting up standard PCI resources
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [8086/7194] 000600 00
PCI: Calling quirk c01df586 for 0000:00:00.0
PCI: Calling quirk c0295649 for 0000:00:00.0
PCI: Calling quirk c02957af for 0000:00:00.0
PCI: Calling quirk c029590e for 0000:00:00.0
PCI: Found 0000:00:00.1 [8086/7195] 000401 00
PCI: Calling quirk c01df586 for 0000:00:00.1
PCI: Calling quirk c0295649 for 0000:00:00.1
PCI: Calling quirk c02957af for 0000:00:00.1
PCI: Calling quirk c029590e for 0000:00:00.1
PCI: Found 0000:00:00.2 [8086/7196] 000703 00
PCI: Calling quirk c01df586 for 0000:00:00.2
PCI: Calling quirk c0295649 for 0000:00:00.2
PCI: Calling quirk c02957af for 0000:00:00.2
PCI: Calling quirk c029590e for 0000:00:00.2
PCI: Found 0000:00:07.0 [8086/7198] 000601 00
PCI: Calling quirk c01df586 for 0000:00:07.0
PCI: Calling quirk c0295649 for 0000:00:07.0
PCI: Calling quirk c02957af for 0000:00:07.0
PCI: Calling quirk c029590e for 0000:00:07.0
PCI: Found 0000:00:07.1 [8086/7199] 000101 00
PCI: Calling quirk c01df586 for 0000:00:07.1
PCI: Calling quirk c0295649 for 0000:00:07.1
PCI: Calling quirk c02957af for 0000:00:07.1
PCI: Calling quirk c029590e for 0000:00:07.1
PCI: Found 0000:00:07.2 [8086/719a] 000c03 00
PCI: Calling quirk c01df586 for 0000:00:07.2
PCI: Calling quirk c0295649 for 0000:00:07.2
PCI: Calling quirk c02957af for 0000:00:07.2
PCI: Calling quirk c029590e for 0000:00:07.2
PCI: Found 0000:00:07.3 [8086/719b] 000680 00
PCI: Calling quirk c01df586 for 0000:00:07.3
PCI: Calling quirk c0295649 for 0000:00:07.3
PCI: Calling quirk c02957af for 0000:00:07.3
PCI: Calling quirk c029590e for 0000:00:07.3
PCI: Found 0000:00:08.0 [104c/ac50] 000607 02
PCI: Calling quirk c01df586 for 0000:00:08.0
PCI: Calling quirk c0295649 for 0000:00:08.0
PCI: Calling quirk c029590e for 0000:00:08.0
PCI: Found 0000:00:09.0 [1002/4c52] 000300 00
PCI: Calling quirk c01df586 for 0000:00:09.0
PCI: Calling quirk c0295649 for 0000:00:09.0
PCI: Calling quirk c029590e for 0000:00:09.0
Boot video device is 0000:00:09.0
PCI: Found 0000:00:0a.0 [10ec/8139] 000200 00
PCI: Calling quirk c01df586 for 0000:00:0a.0
PCI: Calling quirk c0295649 for 0000:00:0a.0
PCI: Calling quirk c029590e for 0000:00:0a.0
PCI: Found 0000:00:0b.0 [1033/00cd] 000c00 00
PCI: Calling quirk c01df586 for 0000:00:0b.0
PCI: Calling quirk c0295649 for 0000:00:0b.0
PCI: Calling quirk c029590e for 0000:00:0b.0
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:08.0, config 000040, pass 0
PCI: Scanning behind PCI bridge 0000:00:08.0, config 000040, pass 1
PCI: Bus scan for 0000:00 returning with max=04
PCI: Using IRQ router PIIX/ICH [8086/7198] at 0000:00:07.0
PCI: Cannot allocate resource region 0 of device 0000:00:0b.0
PCI: BIOS reporting unknown device 00:01
PCI: BIOS reporting unknown device 00:02
  got res [24000000:2401ffff] bus [24000000:2401ffff] flags 7202 for BAR
6 of 0000:00:09.0
  got res [24020000:24020fff] bus [24020000:24020fff] flags 200 for BAR
0 of 0000:00:08.0
PCI: moved device 0000:00:08.0 resource 0 (200) to 24020000
  got res [24021000:24021fff] bus [24021000:24021fff] flags 200 for BAR
0 of 0000:00:0b.0
PCI: moved device 0000:00:0b.0 resource 0 (200) to 24021000
PCI: Bus 1, cardbus bridge: 0000:00:08.0
  IO window: 00002000-00002fff
  IO window: 00004000-00004fff
  PREFETCH window: 20000000-21ffffff
  MEM window: 22000000-23ffffff
PCI: Found IRQ 10 for device 0000:00:08.0
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
NTFS driver 2.1.27 [Flags: R/O].
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
PCI: Calling quirk c01df4c0 for 0000:00:00.0
PCI: Calling quirk c0246340 for 0000:00:00.0
PCI: Calling quirk c01df4c0 for 0000:00:00.1
PCI: Calling quirk c0246340 for 0000:00:00.1
PCI: Calling quirk c01df4c0 for 0000:00:00.2
PCI: Calling quirk c0246340 for 0000:00:00.2
PCI: Calling quirk c01df4c0 for 0000:00:07.0
PCI: Calling quirk c0246340 for 0000:00:07.0
PCI: Calling quirk c01df4c0 for 0000:00:07.1
PCI: Calling quirk c0246340 for 0000:00:07.1
PCI: Calling quirk c01df4c0 for 0000:00:07.2
PCI: Calling quirk c0246340 for 0000:00:07.2
PCI: Calling quirk c01df4c0 for 0000:00:07.3
PCI: Calling quirk c0246340 for 0000:00:07.3
PCI: Calling quirk c01df4c0 for 0000:00:08.0
PCI: Calling quirk c0246340 for 0000:00:08.0
PCI: Calling quirk c01df4c0 for 0000:00:09.0
PCI: Calling quirk c0246340 for 0000:00:09.0
PCI: Calling quirk c01df4c0 for 0000:00:0a.0
PCI: Calling quirk c0246340 for 0000:00:0a.0
PCI: Calling quirk c01df4c0 for 0000:00:0b.0
PCI: Calling quirk c0246340 for 0000:00:0b.0
vesafb: framebuffer at 0xc0000000, mapped to 0xd0800000, using 1536k,
total 4096k
vesafb: mode is 1024x768x8, linelength=1024, pages=4
vesafb: protected mode interface info at c000:4f84
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=6:6:6:6, shift=0:0:0:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.27
PCI: Found IRQ 10 for device 0000:00:0a.0
IRQ routing conflict for 0000:00:0a.0, have irq 11, want irq 10
eth0: RealTek RTL8139 at 0x3e00, 00:40:d0:17:96:b1, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 0
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: IC25N020ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1768KiB Cache, CHS=38760/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
PCI: Found IRQ 10 for device 0000:00:08.0
Yenta: CardBus bridge found at 0000:00:08.0 [0e11:000d]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:08.0, mfunc 0x017c1602, devctl 0x64
Yenta: ISA IRQ mask 0x02d8, PCI irq 10
Socket status: 30000010
USB Universal Host Controller Interface driver v3.0

PCI: IRQ 11 for device 0000:00:07.2 doesn't match PIRQ mask - try
pci=usepirqmask
<6>PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:0b.0
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x00001200
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for
USB modems and ISDN adapters
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22
10:27:24 2006 UTC).
PCI: Setting latency timer of device 0000:00:00.1 to 64
input: AT Translated Set 2 keyboard as /class/input/input0
pccard: PCMCIA card inserted into slot 0
intel8x0_measure_ac97_clock: measured 50190 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 440MX with CS4299 at 0x1600, irq 5
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
Synaptics Touchpad, model: 1, fw: 4.1, id: 0x8848a1, caps: 0x0/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input1
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 124k freed
Adding 265064k swap on /dev/hda2.  Priority:-1 extents:1 across:265064k
NTFS volume version 3.1.
pcmcia: Detected deprecated PCMCIA ioctl usage from process: cardmgr.
pcmcia: This interface will soon be removed from the kernel; please
expect breakage unless you upgrade to new tools.
pcmcia: see
http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff
0xe0000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1


Like before, I'm available for any other test.

bye, thank you very much
Alessio Sangalli


