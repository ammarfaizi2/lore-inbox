Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWB1Q3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWB1Q3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 11:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbWB1Q3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 11:29:43 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:49891 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S1750918AbWB1Q3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 11:29:42 -0500
Date: Tue, 28 Feb 2006 11:29:37 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15.4 amd64 + tuplip multiport cards only work with irqpoll 
Message-ID: <Pine.LNX.4.64.0602281116120.22973@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I have a an amd64 machine here that fails to bring up it's network 
interfaces without the "irqpoll" boot option.. if that option is not 
enabled I get:
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
irq 17: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff8013c965>{__report_bad_irq+48} <ffffffff8013ca47>{note_interrupt+122}
       <ffffffff8013c264>{__do_IRQ+210} <ffffffff80110df6>{do_IRQ+45}
       <ffffffff8010ec2c>{ret_from_intr+0} <ffffffff802485d1>{SkGeIsrOnePort+21}
       <ffffffff8013c161>{handle_IRQ_event+41} <ffffffff8013c23c>{__do_IRQ+170}
       <ffffffff80110df6>{do_IRQ+45} <ffffffff8010ec2c>{ret_from_intr+0}
        <EOI> <ffffffff80262f00>{tulip_select_media+2030} <ffffffff80264095>{tulip_up+1969}
       <ffffffff80264093>{tulip_up+1967} <ffffffff80264177>{tulip_open+55}
       <ffffffff802ab579>{dev_open+57} <ffffffff802ac90e>{dev_change_flags+87}
       <ffffffff802fb4cd>{devinet_ioctl+647} <ffffffff802fd53a>{inet_ioctl+76}
       <ffffffff802a311f>{sock_ioctl+426} <ffffffff8016cac1>{do_ioctl+41}
       <ffffffff8016cd8f>{vfs_ioctl+415} <ffffffff8016cddc>{sys_ioctl+60}
       <ffffffff8010e68a>{system_call+126} 
handlers:
[tulip_interrupt+0/2185] (tulip_interrupt+0x0/0x889)
[tulip_interrupt+0/2185] (tulip_interrupt+0x0/0x889)
Disabling IRQ #17
irq 18: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff8013c965>{__report_bad_irq+48} <ffffffff8013ca47>{note_interrupt+122}
       <ffffffff8013c264>{__do_IRQ+210} <ffffffff80110df6>{do_IRQ+45}
       <ffffffff8010ec2c>{ret_from_intr+0}  <EOI> 
handlers:
[tulip_interrupt+0/2185] (tulip_interrupt+0x0/0x889)
Feb 28 10:40:37 localhost last message repeated 2 times
Disabling IRQ #18
irq 19: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff8013c965>{__report_bad_irq+48} <ffffffff8013ca47>{note_interrupt+122}
       <ffffffff8013c264>{__do_IRQ+210} <ffffffff80110df6>{do_IRQ+45}
       <ffffffff8010ec2c>{ret_from_intr+0}  <EOI> <ffffffff80338d3d>{thread_return+0}
       <ffffffff8010c90e>{default_idle+0} <ffffffff8010c946>{default_idle+56}
       <ffffffff8010ca9c>{cpu_idle+63} <ffffffff80492792>{start_kernel+360}
       <ffffffff80492269>{x86_64_start_kernel+381} 
handlers:
[tulip_interrupt+0/2185] (tulip_interrupt+0x0/0x889)
Feb 28 10:40:38 localhost last message repeated 3 times
Disabling IRQ #19

gw-nat:~# cat /proc/interrupts
           CPU0
  0:     385587    IO-APIC-edge  timer
  1:          8    IO-APIC-edge  i8042
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:       2151    IO-APIC-edge  ide0
 15:         20    IO-APIC-edge  ide1
 16:       2716   IO-APIC-level  SysKonnect SK-98xx, eth2, eth6, eth9,
eth16, eth19
 17:         24   IO-APIC-level  eth1, eth5, eth12, eth15, eth18
 18:         12   IO-APIC-level  eth3, eth7, eth10, eth13, eth20
 19:         12   IO-APIC-level  eth4, eth8, eth11, eth14, eth17
NMI:        101
LOC:     385436
ERR:          0
MIS:          0


Bootdata ok (command line is root=/dev/hda3 ro console=tty0 irqpoll)
Linux version 2.6.15.4 (root@gw-nat) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #3 PREEMPT Tue Feb 28 10:57:30 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fa880
ACPI: XSDT (v001 A M I  OEMXSDT  0x11000503 MSFT 0x00000097) @ 0x000000003ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x11000503 MSFT 0x00000097) @ 0x000000003ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x11000503 MSFT 0x00000097) @ 0x000000003ffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x11000503 MSFT 0x00000097) @ 0x000000003ffc0040
ACPI: DSDT (v001  A0277 A0277001 0x00000001 MSFT 0x0100000d) @ 0x0000000000000000
On node 0 totalpages: 257489
  DMA zone: 3047 pages, LIFO batch:0
  DMA32 zone: 254442 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bf780000)
Checking aperture...
CPU 0: aperture @ e0000000 size 256 MB
Built 1 zonelists
Kernel command line: root=/dev/hda3 ro console=tty0 irqpoll
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 1802.324 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 1027968k/1048256k available (2129k kernel code, 19608k reserved, 874k data, 156k init)
Calibrating delay using timer specific routine.. 3611.86 BogoMIPS (lpj=1805932)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
mtrr: v2.0 (20020519)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 02
Using local APIC timer interrupts.
Detected 12.516 MHz APIC timer.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:06:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 256M @ 0xe0000000
PCI-DMA: Disabling IOMMU.
pnp: 00:06: ioport range 0x680-0x6ff has been reserved
pnp: 00:06: ioport range 0x290-0x297 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: faf00000-fbffffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:00:09.0
  IO window: d000-efff
  MEM window: fa700000-faefffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
  IO window: b000-cfff
  MEM window: f9f00000-fa6fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: 9000-afff
  MEM window: f9700000-f9efffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: 7000-8fff
  MEM window: f8f00000-f96fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: 5000-6fff
  MEM window: f8700000-f8efffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:01.0 to 64
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
io scheduler noop registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
loop: loaded (max 8 devices)
ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 16
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
Linux Tulip driver version 1.1.13 (May 11, 2002)
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:05:04.0[A] -> GSI 16 (level, low) -> IRQ 17
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip0:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth1: Digital DS21140 Tulip rev 34 at ffffc20000004000, 00:00:D1:1F:E2:1D, IRQ 17.
ACPI: PCI Interrupt 0000:05:05.0[A] -> GSI 17 (level, low) -> IRQ 16
tulip1:  Controller 1 of multiport board.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip1:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip1:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth2: Digital DS21140 Tulip rev 34 at ffffc20000006000, EEPROM not present, 00:00:D1:1F:E2:1E, IRQ 16.
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:05:06.0[A] -> GSI 18 (level, low) -> IRQ 18
tulip2:  Controller 2 of multiport board.
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip2:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip2:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth3: Digital DS21140 Tulip rev 34 at ffffc20000012000, EEPROM not present, 00:00:D1:1F:E2:1F, IRQ 18.
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:05:07.0[A] -> GSI 19 (level, low) -> IRQ 19
tulip3:  Controller 3 of multiport board.
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip3:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip3:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth4: Digital DS21140 Tulip rev 34 at ffffc20000014000, EEPROM not present, 00:00:D1:1F:E2:20, IRQ 19.
ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 16 (level, low) -> IRQ 17
tulip4:  EEPROM default media type Autosense.
tulip4:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip4:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip4:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth5: Digital DS21140 Tulip rev 34 at ffffc20000016000, 00:00:D1:20:1C:2E, IRQ 17.
ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 17 (level, low) -> IRQ 16
tulip5:  Controller 1 of multiport board.
tulip5:  EEPROM default media type Autosense.
tulip5:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip5:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip5:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth6: Digital DS21140 Tulip rev 34 at ffffc2000001e000, EEPROM not present, 00:00:D1:20:1C:2F, IRQ 16.
ACPI: PCI Interrupt 0000:04:06.0[A] -> GSI 18 (level, low) -> IRQ 18
tulip6:  Controller 2 of multiport board.
tulip6:  EEPROM default media type Autosense.
tulip6:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip6:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip6:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth7: Digital DS21140 Tulip rev 34 at ffffc20000020000, EEPROM not present, 00:00:D1:20:1C:30, IRQ 18.
ACPI: PCI Interrupt 0000:04:07.0[A] -> GSI 19 (level, low) -> IRQ 19
tulip7:  Controller 3 of multiport board.
tulip7:  EEPROM default media type Autosense.
tulip7:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip7:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip7:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth8: Digital DS21140 Tulip rev 34 at ffffc20000022000, EEPROM not present, 00:00:D1:20:1C:31, IRQ 19.
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 17 (level, low) -> IRQ 16
tulip8:  EEPROM default media type Autosense.
tulip8:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip8:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip8:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth9: Digital DS21140 Tulip rev 34 at ffffc20000024000, 00:00:D1:1E:50:CF, IRQ 16.
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 18 (level, low) -> IRQ 18
tulip9:  Controller 1 of multiport board.
tulip9:  EEPROM default media type Autosense.
tulip9:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip9:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip9:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth10: Digital DS21140 Tulip rev 34 at ffffc20000026000, EEPROM not present, 00:00:D1:1E:50:D0, IRQ 18.
ACPI: PCI Interrupt 0000:03:06.0[A] -> GSI 19 (level, low) -> IRQ 19
tulip10:  Controller 2 of multiport board.
tulip10:  EEPROM default media type Autosense.
tulip10:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip10:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip10:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth11: Digital DS21140 Tulip rev 34 at ffffc20000028000, EEPROM not present, 00:00:D1:1E:50:D1, IRQ 19.
ACPI: PCI Interrupt 0000:03:07.0[A] -> GSI 16 (level, low) -> IRQ 17
tulip11:  Controller 3 of multiport board.
tulip11:  EEPROM default media type Autosense.
tulip11:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip11:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip11:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth12: Digital DS21140 Tulip rev 34 at ffffc2000002a000, EEPROM not present, 00:00:D1:1E:50:D2, IRQ 17.
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 18 (level, low) -> IRQ 18
tulip12:  EEPROM default media type Autosense.
tulip12:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip12:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip12:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth13: Digital DS21140 Tulip rev 34 at ffffc2000002c000, 00:00:D1:1E:7F:6C, IRQ 18.
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 19 (level, low) -> IRQ 19
tulip13:  Controller 1 of multiport board.
tulip13:  EEPROM default media type Autosense.
tulip13:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip13:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip13:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth14: Digital DS21140 Tulip rev 34 at ffffc2000002e000, EEPROM not present, 00:00:D1:1E:7F:6D, IRQ 19.
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 16 (level, low) -> IRQ 17
tulip14:  Controller 2 of multiport board.
tulip14:  EEPROM default media type Autosense.
tulip14:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip14:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip14:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth15: Digital DS21140 Tulip rev 34 at ffffc20000030000, EEPROM not present, 00:00:D1:1E:7F:6E, IRQ 17.
ACPI: PCI Interrupt 0000:02:07.0[A] -> GSI 17 (level, low) -> IRQ 16
tulip15:  Controller 3 of multiport board.
tulip15:  EEPROM default media type Autosense.
tulip15:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip15:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip15:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth16: Digital DS21140 Tulip rev 34 at ffffc20000032000, EEPROM not present, 00:00:D1:1E:7F:6F, IRQ 16.
ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 19 (level, low) -> IRQ 19
tulip16:  EEPROM default media type Autosense.
tulip16:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip16:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip16:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth17: Digital DS21140 Tulip rev 34 at ffffc20000034000, 00:00:92:A7:8A:A0, IRQ 19.
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 16 (level, low) -> IRQ 17
tulip17:  Controller 1 of multiport board.
tulip17:  EEPROM default media type Autosense.
tulip17:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip17:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip17:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth18: Digital DS21140 Tulip rev 34 at ffffc20000036000, EEPROM not present, 00:00:92:A7:8A:A1, IRQ 17.
ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 17 (level, low) -> IRQ 16
tulip18:  Controller 2 of multiport board.
tulip18:  EEPROM default media type Autosense.
tulip18:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip18:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip18:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth19: Digital DS21140 Tulip rev 34 at ffffc20000038000, EEPROM not present, 00:00:92:A7:8A:A2, IRQ 16.
ACPI: PCI Interrupt 0000:01:07.0[A] -> GSI 18 (level, low) -> IRQ 18
tulip19:  Controller 3 of multiport board.
tulip19:  EEPROM default media type Autosense.
tulip19:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip19:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip19:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth20: Digital DS21140 Tulip rev 34 at ffffc2000003a000, EEPROM not present, 00:00:92:A7:8A:A3, IRQ 18.
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 4
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD800JB-00JJC0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LTN486S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
I2O subsystem v1.288
i2o: max drivers = 8
I2O Configuration OSM v1.248
I2O Bus Adapter OSM v$Rev$
I2O Block Device OSM v1.287
I2O ProcFS OSM v1.145
i2c /dev entries driver
input: AT Translated Set 2 keyboard as /class/input/input1
netem: version 1.1
u32 classifier
    OLD policer on 
Netfilter messages via NETLINK v0.30.
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
ip_conntrack version 2.4 (4094 buckets, 32752 max) - 312 bytes per conntrack
ctnetlink v0.90: registering with nfnetlink.
ip_conntrack_pptp version 3.1 loaded
ip_nat_pptp version 3.0 loaded
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
ClusterIP Version 0.8 loaded successfully
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xa, vid 0x6
ACPI wakeup devices: 
PCI0 PS2K UAR1 AC97 USB1 USB2 USB3 USB4 EHCI PWRB SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 156k freed
Adding 979956k swap on /dev/hda2.  Priority:-1 extents:1 across:979956k
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
