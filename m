Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSKYOEe>; Mon, 25 Nov 2002 09:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263310AbSKYOEe>; Mon, 25 Nov 2002 09:04:34 -0500
Received: from www.qskills.net ([212.204.70.2]:32928 "EHLO mail.qskills.net")
	by vger.kernel.org with ESMTP id <S263291AbSKYOE2>;
	Mon, 25 Nov 2002 09:04:28 -0500
Date: Mon, 25 Nov 2002 16:11:49 +0100
From: Richard Mueller <mueller@teamix.net>
X-Mailer: The Bat! (v1.61) Business
Reply-To: Richard Mueller <mueller@teamix.net>
Organization: Teamix GmbH
X-Priority: 3 (Normal)
Message-ID: <140282249663.20021125161149@teamix.net>
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] D-Link DFE-580TX: Only 3 Ports working
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel-developers (esp. Donald ;) )

I am experiencing very strange problems with the
"D-Link DFE-580TX 4 port Server Adapter" in our enviroment.

The kernel can only use the first three Ports. The forth Port
is detected but reports some problems with the MII-Transciever.

It should not be a NIC-hardwareproblem (used a second one - same
problems).

But read with your own eyes:

host:~# cat /proc/version
Linux version 2.4.20-rc2 (root@host) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 SMP Mon Nov 25 14:20:56 CET
2002

host:~# dmesg |grep eth
eth0: OEM i82557/i82558 10/100 Ethernet, 00:20:ED:18:22:55, IRQ 30.
eth1: OEM i82557/i82558 10/100 Ethernet, 00:20:ED:18:22:54, IRQ 29.
eth2: D-Link DFE-580TX 4 port Server Adapter at 0xb800, 00:05:5d:64:9f:9d, IRQ 21.
eth2: MII PHY found at address 1, status 0x782d advertising 01e1.
eth3: D-Link DFE-580TX 4 port Server Adapter at 0xb400, 00:05:5d:64:9f:9c, IRQ 20.
eth3: MII PHY found at address 1, status 0x782d advertising 01e1.
eth4: D-Link DFE-580TX 4 port Server Adapter at 0xb000, 00:05:5d:64:9f:9b, IRQ 21.
eth4: MII PHY found at address 1, status 0x782d advertising 01e1.
eth5: D-Link DFE-580TX 4 port Server Adapter at 0xbe00, 00:00:00:00:00:00, IRQ 20.
eth5: No MII transceiver found, aborting.  ASIC status ffffffff

host:~# lspci -v
00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
        Flags: bus master, medium devsel, latency 64

00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
        Flags: bus master, medium devsel, latency 16

00:07.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Server Adapter
        Flags: bus master, medium devsel, latency 64, IRQ 29
        Memory at fe9fc000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 9800 [size=64]
        Memory at fe600000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at fe500000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

00:08.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Server Adapter
        Flags: bus master, medium devsel, latency 64, IRQ 30
        Memory at fe9fd000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at a800 [size=64]
        Memory at fe800000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at fe700000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

00:09.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0008
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 31
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at a000 [size=256]
        Memory at fe9ff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fe9c0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
        Subsystem: ServerWorks OSB4 South Bridge
        Flags: bus master, medium devsel, latency 0

00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at ffa0 [size=16]

01:04.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
        Flags: bus master, 66Mhz, medium devsel, latency 72, IRQ 26
        I/O ports at c000 [size=256]
        Memory at febff400 (64-bit, non-prefetchable) [size=1K]
        Memory at febf8000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2

01:04.1 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
        Flags: bus master, 66Mhz, medium devsel, latency 72, IRQ 27
        I/O ports at d000 [size=256]
        Memory at febff800 (64-bit, non-prefetchable) [size=1K]
        Memory at febfa000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2

01:05.0 SCSI storage controller: ICP Vortex Computersysteme GmbH GDT 8x23RZ
        Subsystem: ICP Vortex Computersysteme GmbH GDT 8x23RZ
        Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 20
        Memory at fc0fc000 (32-bit, prefetchable) [size=16K]
        Expansion ROM at febf0000 [disabled] [size=32K]
        Capabilities: [80] Power Management version 2

01:07.0 PCI bridge: Intel Corp.: Unknown device b152 (prog-if 00 [Normal decode])
        Flags: bus master, medium devsel, latency 64
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: fea00000-feafffff
        Prefetchable memory behind bridge: 00000000fbf00000-00000000fbf00000
        Capabilities: [dc] Power Management version 2

02:04.0 Ethernet controller: D-Link System Inc Sundance Ethernet (rev 12)
        Subsystem: D-Link System Inc: Unknown device 1012
        Flags: bus master, medium devsel, latency 64, IRQ 20
        I/O ports at be00 [size=128]
        Expansion ROM at feac0000 [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

02:05.0 Ethernet controller: D-Link System Inc Sundance Ethernet (rev 12)
        Subsystem: D-Link System Inc: Unknown device 1012
        Flags: bus master, medium devsel, latency 64, IRQ 21
        I/O ports at b000 [size=128]
        Expansion ROM at fead0000 [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

02:06.0 Ethernet controller: D-Link System Inc Sundance Ethernet (rev 12)
        Subsystem: D-Link System Inc: Unknown device 1012
        Flags: bus master, medium devsel, latency 64, IRQ 20
        I/O ports at b400 [size=128]
        Expansion ROM at feae0000 [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

02:07.0 Ethernet controller: D-Link System Inc Sundance Ethernet (rev 12)
        Subsystem: D-Link System Inc: Unknown device 1012
        Flags: bus master, medium devsel, latency 64, IRQ 21
        I/O ports at b800 [size=128]
        Expansion ROM at feaf0000 [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
        
host:~# alta-diag -aa
alta-diag.c:v2.00 4/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Sundance Technology Alta adapter at 0xb800.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:64:9f:9d.
Sundance Technology Alta chip registers at 0xb800
 0x00: 0000 0000 0000 0000 0408 0000 0000 0000
 0x10: 0000 0000 0408 0000 279e 0000 0000 0000
 0x20: 0000 0000 0000 0000 0000 0000 0000 0000
 0x30: 4063 0000 530e 02ff 0000 0000 1ffc 1ffc
 0x40: 0000 0000 f8f8 0000 0000 ---- 0000 0100
 0x50: 0000 0000 0500 645d 9d9f 05ea 0800 00e1
 0x60: 0000 0000 0000 0000 0000 0000 0000 0000
 0x70: 0000 0000 0000 0000 0000 0000 0000 0000
Index #2: Found a Sundance Technology Alta adapter at 0xb400.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:64:9f:9c.
Sundance Technology Alta chip registers at 0xb400
 0x00: 0000 0000 0000 0000 0408 0000 0000 0000
 0x10: 0000 0000 0408 0000 1060 0000 0000 0000
 0x20: 0000 0000 0000 0000 0000 0000 0000 0000
 0x30: 4063 0000 0989 02ff 0000 0000 1ffc 1ffc
 0x40: 0000 0000 f8f8 0000 0000 ---- 0000 0100
 0x50: 0000 0000 0500 645d 9c9f 05ea 0800 00e0
 0x60: 0000 0000 0000 0000 0000 0000 0000 0000
 0x70: 0000 0000 0000 0000 0000 0000 0000 0000
Index #3: Found a Sundance Technology Alta adapter at 0xb000.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:64:9f:9b.
Sundance Technology Alta chip registers at 0xb000
 0x00: 0000 0000 0000 0000 0408 0000 0000 0000
 0x10: 0000 0000 0408 0000 f935 0000 0000 0000
 0x20: 0000 0000 0000 0000 0000 0000 0000 0000
 0x30: 4063 0000 576d 02ff 0000 0000 1ffc 1ffc
 0x40: 0000 0000 f8f8 0000 0000 ---- 0000 0100
 0x50: 0000 0000 0500 645d 9b9f 05ea 0800 00e0
 0x60: 0000 0000 0000 0000 0000 0000 0000 0000
 0x70: 0000 0000 0000 0000 0000 0000 0000 0000
Index #4: Found a Sundance Technology Alta adapter at 0xbe00.

The appears not to exist!  The following info is probably bogus.

  Receive mode is 0xff: Promiscuous.
  MAC mode is ffff: full duplex NON-ETHERNET-STANDARD FEATURES SET.
  Tx status ff, threshold 65535.
 Tx status stack: ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff
  Interrupt status is ffff: Interrupt summary PCI bus fault Tx Done Event MAC Control Frame Receive done Receive started Software triggered interrupt Update statistics Link status changed Tx DMA done Rx DMA done
  Station address ff:ff:ff:ff:ff:ff.
Sundance Technology Alta chip registers at 0xbe00
 0x00: ffff ffff ffff ffff ffff ffff ffff ffff
 0x10: ffff ffff ffff ffff ffff ffff ffff ffff
 0x20: ffff ffff ffff ffff ffff ffff ffff ffff
 0x30: ffff ffff ffff ffff ffff ffff ffff ffff
 0x40: ffff ffff ffff ffff ffff ---- ffff ffff
 0x50: ffff ffff ffff ffff ffff ffff ffff ffff
 0x60: ffff ffff ffff ffff ffff ffff ffff ffff
 0x70: ffff ffff ffff ffff ffff ffff ffff ffff
EEPROM read failed. [repeated very often]

host:~# alta-diag -ee
alta-diag.c:v2.00 4/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Sundance Technology Alta adapter at 0xb800.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:64:9f:9d.
EEPROM contents:
0x000:  2afc c063 1186 1012 0000 0000 0000 0000
0x008:  0000 0000 0000 0000 0000 0000 0000 0000
0x010:  0500 645d 9d9f 0064 0000 0000 0000 0000
0x018:  3400 0100 3702 0300 083a 3f04 0303 0103
0x020:  0000 0000 0000 0000 0000 0000 0000 0000
0x028:  0000 0000 0000 0000 0000 0000 0000 0000
0x030:  0000 0000 0000 0000 0000 0000 0000 0000
0x038:  0000 0000 0000 0000 0000 0000 0000 0000
0x040:  0000 0000 0000 0000 0000 0000 0000 0000
0x048:  0000 0000 0000 0000 0000 0000 0000 0000
0x050:  0000 0000 0000 0000 0000 0000 0000 0000
0x058:  0000 0000 0000 0000 0000 0000 0000 0000
0x060:  0000 0000 0000 0000 0000 0000 0000 0000
0x068:  0000 0000 0000 0000 0000 0000 0000 0000
0x070:  0000 0000 0000 0000 0000 0000 0000 0000
0x078:  0000 0000 0000 0000 4283 7e15 e32d 530e
0x080:  2afc c063 1186 1012 0000 0000 0000 0000
0x088:  0000 0000 0000 0000 0000 0000 0000 0000
0x090:  0500 645d 9d9f 0064 0000 0000 0000 0000
0x098:  3400 0100 3702 0300 083a 3f04 0303 0103
0x0a0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0a8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f8:  0000 0000 0000 0000 4283 7e15 e32d 530e
EEPROM Subsystem IDs, Vendor 1186 Device 1012.
  EEPROM Station address is 00:05:5d:64:9f:9d.
  Configuration 2afc, ASIC Control c063.
Index #2: Found a Sundance Technology Alta adapter at 0xb400.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:64:9f:9c.
EEPROM contents:
0x000:  2afc c063 1186 1012 0000 0000 0000 0000
0x008:  0000 0000 0000 0000 0000 0000 0000 0000
0x010:  0500 645d 9c9f 0064 0000 0000 0000 0000
0x018:  3400 0100 3702 0300 083a 3f04 0303 0103
0x020:  0000 0000 0000 0000 0000 0000 0000 0000
0x028:  0000 0000 0000 0000 0000 0000 0000 0000
0x030:  0000 0000 0000 0000 0000 0000 0000 0000
0x038:  0000 0000 0000 0000 0000 0000 0000 0000
0x040:  0000 0000 0000 0000 0000 0000 0000 0000
0x048:  0000 0000 0000 0000 0000 0000 0000 0000
0x050:  0000 0000 0000 0000 0000 0000 0000 0000
0x058:  0000 0000 0000 0000 0000 0000 0000 0000
0x060:  0000 0000 0000 0000 0000 0000 0000 0000
0x068:  0000 0000 0000 0000 0000 0000 0000 0000
0x070:  0000 0000 0000 0000 0000 0000 0000 0000
0x078:  0000 0000 0000 0000 59c2 1099 c064 0989
0x080:  2afc c063 1186 1012 0000 0000 0000 0000
0x088:  0000 0000 0000 0000 0000 0000 0000 0000
0x090:  0500 645d 9c9f 0064 0000 0000 0000 0000
0x098:  3400 0100 3702 0300 083a 3f04 0303 0103
0x0a0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0a8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f8:  0000 0000 0000 0000 59c2 1099 c064 0989
EEPROM Subsystem IDs, Vendor 1186 Device 1012.
  EEPROM Station address is 00:05:5d:64:9f:9c.
  Configuration 2afc, ASIC Control c063.
Index #3: Found a Sundance Technology Alta adapter at 0xb000.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:64:9f:9b.
EEPROM contents:
0x000:  2afc c063 1186 1012 0000 0000 0000 0000
0x008:  0000 0000 0000 0000 0000 0000 0000 0000
0x010:  0500 645d 9b9f 0064 0000 0000 0000 0000
0x018:  3400 0100 3702 0300 083a 3f04 0303 0103
0x020:  0000 0000 0000 0000 0000 0000 0000 0000
0x028:  0000 0000 0000 0000 0000 0000 0000 0000
0x030:  0000 0000 0000 0000 0000 0000 0000 0000
0x038:  0000 0000 0000 0000 0000 0000 0000 0000
0x040:  0000 0000 0000 0000 0000 0000 0000 0000
0x048:  0000 0000 0000 0000 0000 0000 0000 0000
0x050:  0000 0000 0000 0000 0000 0000 0000 0000
0x058:  0000 0000 0000 0000 0000 0000 0000 0000
0x060:  0000 0000 0000 0000 0000 0000 0000 0000
0x068:  0000 0000 0000 0000 0000 0000 0000 0000
0x070:  0000 0000 0000 0000 0000 0000 0000 0000
0x078:  0000 0000 0000 0000 1f44 c24c 2eda 576d
0x080:  2afc c063 1186 1012 0000 0000 0000 0000
0x088:  0000 0000 0000 0000 0000 0000 0000 0000
0x090:  0500 645d 9b9f 0064 0000 0000 0000 0000
0x098:  3400 0100 3702 0300 083a 3f04 0303 0103
0x0a0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0a8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f8:  0000 0000 0000 0000 1f44 c24c 2eda 576d
EEPROM Subsystem IDs, Vendor 1186 Device 1012.
  EEPROM Station address is 00:05:5d:64:9f:9b.
  Configuration 2afc, ASIC Control c063.
Index #4: Found a Sundance Technology Alta adapter at 0xbe00.

The appears not to exist!  The following info is probably bogus.

  Receive mode is 0xff: Promiscuous.
  MAC mode is ffff: full duplex NON-ETHERNET-STANDARD FEATURES SET.
  Tx status ff, threshold 65535.
 Tx status stack: ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff
  Interrupt status is ffff: Interrupt summary PCI bus fault Tx Done Event MAC Control Frame Receive done Receive started Software triggered interrupt Update statistics Link status changed Tx DMA done Rx DMA done
  Station address ff:ff:ff:ff:ff:ff.
EEPROM read failed. [repeated]
EEPROM contents:
0x000:  0000 0000 0000 0000 0000 0000 0000 0000
0x008:  0000 0000 0000 0000 0000 0000 0000 0000
0x010:  0000 0000 0000 0000 0000 0000 0000 0000
0x018:  0000 0000 0000 0000 0000 0000 0000 0000
0x020:  0000 0000 0000 0000 0000 0000 0000 0000
0x028:  0000 0000 0000 0000 0000 0000 0000 0000
0x030:  0000 0000 0000 0000 0000 0000 0000 0000
0x038:  0000 0000 0000 0000 0000 0000 0000 0000
0x040:  0000 0000 0000 0000 0000 0000 0000 0000
0x048:  0000 0000 0000 0000 0000 0000 0000 0000
0x050:  0000 0000 0000 0000 0000 0000 0000 0000
0x058:  0000 0000 0000 0000 0000 0000 0000 0000
0x060:  0000 0000 0000 0000 0000 0000 0000 0000
0x068:  0000 0000 0000 0000 0000 0000 0000 0000
0x070:  0000 0000 0000 0000 0000 0000 0000 0000
0x078:  0000 0000 0000 0000 0000 0000 0000 0000
0x080:  0000 0000 0000 0000 0000 0000 0000 0000
0x088:  0000 0000 0000 0000 0000 0000 0000 0000
0x090:  0000 0000 0000 0000 0000 0000 0000 0000
0x098:  0000 0000 0000 0000 0000 0000 0000 0000
0x0a0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0a8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f8:  0000 0000 0000 0000 0000 0000 0000 0000
EEPROM Subsystem IDs, Vendor 0000 Device 0000.
  EEPROM Station address is 00:00:00:00:00:00.
  Configuration 0000, ASIC Control 0000.

host:~# alta-diag -mm
alta-diag.c:v2.00 4/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Sundance Technology Alta adapter at 0xb800.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:64:9f:9d.
 MII PHY found at address 0, status 0x782d.
 MII PHY found at address 1, status 0x782d.
 MII PHY #0 transceiver registers:
   1000 782d 0022 1630 01e1 45e1 0007 2001
   1000 782d 0022 1630 01e1 45e1 0007 2001
   1000 782d 0022 1630 01e1 45e1 0007 2001
   0000 0000 0000 0000 0000 0000 0000 0000.
 MII PHY #1 transceiver registers:
   1000 782d 0022 1630 01e1 45e1 0007 2001
   1000 782d 0022 1630 01e1 45e1 0007 2001
   1000 782d 0022 1630 01e1 45e1 0007 2001
   0000 0000 0000 0000 0000 0000 0000 0000.
 MII PHY #0 transceiver registers:
   1000 782d 0022 1630 01e1 45e1 0007 2001
   1000 782d 0022 1630 01e1 45e1 0007 2001
   1000 782d 0022 1630 01e1 45e1 0007 2001
   0000 0000 0000 0000 0000 0000 0000 0000.
 Basic mode control register 0x1000: Auto-negotiation enabled.
 Basic mode status register 0x782d ... 782d.
   Link status: established.
   Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Vendor ID is 00:08:85:--:--:--, model 35 rev. 0.
   No specific information is known about this transceiver type.
 I'm advertising 01e1: 100baseTx-FD 100baseTx 10baseT-FD 10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Negotiation  completed.
Monitoring the MII transceiver status.
16:03:29.681  Baseline value of MII BMSR (basic mode status register) is 782d.  

[end of Cut'n'Paste]

eth2 to eth3 are working without any problems.

I don't have any idea what the reason could be.
Maybe some of the almighty kernel hackers have. ;-)

have a nice week.

Richard

-- 
Richard Mueller     mailto:mueller@teamix.net  Fon: +49 9171 896287
Teamix GmbH         http://www.teamix.de       Fax: +49 9171 896286

