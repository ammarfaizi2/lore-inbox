Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269412AbRHGUL7>; Tue, 7 Aug 2001 16:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269411AbRHGULu>; Tue, 7 Aug 2001 16:11:50 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:65247 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S269421AbRHGULk>;
	Tue, 7 Aug 2001 16:11:40 -0400
Message-ID: <3B704BBE.A3AA1C99@candelatech.com>
Date: Tue, 07 Aug 2001 13:12:46 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>,
        "eepro100@scyld.com" <eepro100@scyld.com>
Subject: Problem with Linux 2.4.7 and builtin eepro on Intel's EEA2 motherboard.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver seems to lock up for a while and then recover...

Aug  7 11:55:19 lanf1 last message repeated 5 times
Aug  7 11:56:04 lanf1 last message repeated 21 times
Aug  7 11:56:07 lanf1 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug  7 11:56:07 lanf1 kernel: eth0: Transmit timed out: status 0050  0cf0 at 900/928 command 000c0000.
Aug  7 11:58:53 lanf1 kernel: eepro100: wait_for_cmd_done timeout!
Aug  7 11:59:34 lanf1 last message repeated 10 times
Aug  7 12:00:02 lanf1 last message repeated 16 times
Aug  7 12:00:05 lanf1 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug  7 12:00:05 lanf1 kernel: eth0: Transmit timed out: status 0050  0cf0 at 1151/1179 command 000c0000.
Aug  7 12:02:24 lanf1 kernel: eepro100: wait_for_cmd_done timeout!
Aug  7 12:02:47 lanf1 last message repeated 14 times
Aug  7 12:03:09 lanf1 su(pam_unix)[5778]: session opened for user root by lanforge(uid=500)
Aug  7 12:03:24 lanf1 kernel: eepro100: wait_for_cmd_done timeout!
Aug  7 12:03:33 lanf1 last message repeated 10 times
Aug  7 12:03:37 lanf1 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug  7 12:03:37 lanf1 kernel: eth0: Transmit timed out: status 0050  0c80 at 1954/1982 command 000c0000.



[root@lanf1 bin]# eepro100-diag eth0 -aa -ee -mm -f
eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82562 EEPro100 adapter at 0xdf00.
i82557 chip registers at 0xdf00:
  0c000090 0f1123e0 00000000 00080002 18250021 00000600
  No interrupt sources are pending.
   The transmit unit state is 'Active'.
   The receive unit state is 'Ready'.
  This status is unusual for an activated interface.
 The Command register has an unprocessed command 0c00(?!).
EEPROM contents, size 64x16:
    00: 0300 9f47 c4df 1a03 0000 0201 4701 0000
  0x08: 0000 0000 49b2 3013 8086 007f ffff ffff
  0x10: ffff ffff ffff ffff ffff ffff ffff ffff
  0x18: ffff ffff ffff ffff ffff ffff ffff ffff
  0x20: ffff ffff ffff ffff ffff ffff ffff ffff
  0x28: ffff ffff ffff ffff ffff ffff ffff ffff
  0x30: 0000 ffff ffff ffff ffff ffff ffff ffff
  0x38: ffff ffff ffff 0000 ffff ffff ffff f5f4
 The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
  Station address 00:03:47:9F:DF:C4.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
 MII PHY #1 transceiver registers:
  3100 782d 02a8 0330 05e1 0021 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  2404 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0010 0000 0000 0000.
  Baseline value of MII status register is 782d.

NOTE:  The eepro100-diag program hangs here, and will not
continue after at least 2 minutes.  Ctrl-c does stop it
though...

Interestingly enough, a minute after I did this, the whole
machine locked up hard :(



Here is an lspci I did before the lockup.

(The 82557 below is not a problem, it is the other Intel NIC.)
[root@lanf1 /root]# lspci -vvvv
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
	Subsystem: Intel Corporation: Unknown device 4532
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [88] #09 [f104]

00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset Graphics Controller]  (rev 02) (prog-if 00 [VGA])
	Subsystem: Intel Corporation: Unknown device 4532
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at ffa80000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ff400000-ff8fffff
	Prefetchable memory behind bridge: f6a00000-f6afffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82820 820 (Camino 2) Chipset ISA Bridge (ICH2) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82820 820 (Camino 2) Chipset IDE U100 (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation: Unknown device 4532
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub A) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 4532
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ef40 [size=32]

00:1f.3 SMBus: Intel Corporation 82820 820 (Camino 2) Chipset SMBus (rev 02)
	Subsystem: Intel Corporation: Unknown device 4532
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at efa0 [size=16]

00:1f.4 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub B) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 4532
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at ef80 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2445 (rev 02)
	Subsystem: Intel Corporation: Unknown device 4656
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 9
	Region 0: I/O ports at e800 [size=256]
	Region 1: I/O ports at ef00 [size=64]

01:08.0 Ethernet controller: Intel Corporation 82820 820 (Camino 2) Chipset Ethernet (rev 01)
	Subsystem: Intel Corporation: Unknown device 3013
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ff6ff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at df00 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f6aff000 (32-bit, prefetchable) [size=4K]
	Region 1: I/O ports at df80 [size=32]
	Region 2: Memory at ff800000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at ff700000 [disabled] [size=1M]

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
