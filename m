Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWDSTxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWDSTxh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWDSTxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:53:37 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:42899 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751206AbWDSTxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:53:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=CAiixkolzEKrsk1Te5cCkZJfFANaWNgzShNBKhL4wSX4AKsJkmO7/F00vYE5oe9om6FGzc4jyLr0jj4D/Xulo0whoRzzV8K5itG6S0gIc9EPCmkzJnyClvV5WmSelfb1nojvH7X1Qpsv5iNftVFRnGI/qkbGrdPBcuRcOz1q3YU=
Message-ID: <44469507.6000006@gmail.com>
Date: Wed, 19 Apr 2006 12:52:39 -0700
From: Hua Zhong <hzhong@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [BUG]: soft lockup detected on CPU#0!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened once during boot for both 2.6.17-rc1 and rc2, but not every time.

The Linux is running inside VMWare. I'm attaching the logs.

When this happens eth0 fails to come up as IRQ 9 is disabled. Both happens inside update_process_times().

1. rc1

Linux version 2.6.17-rc1 (root@build-hzhong) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.1)) #1 Mon Apr 10 15:47:38 PDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f3f0000 (usable)
 BIOS-e820: 000000001f3f0000 - 000000001f3ff000 (ACPI data)
 BIOS-e820: 000000001f3ff000 - 000000001f400000 (ACPI NVS)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
499MB LOWMEM available.
On node 0 totalpages: 127984
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 123888 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f52c0
ACPI: RSDT (v001 A M I  OEMRSDT  0x09000520 MSFT 0x00000097) @ 0x1f3f0000
ACPI: FADT (v002 A M I  OEMFACP  0x09000520 MSFT 0x00000097) @ 0x1f3f0200
ACPI: OEMB (v001 A M I  OEMBIOS  0x09000520 MSFT 0x00000097) @ 0x1f3ff040
ACPI: DSDT (v001  AMIBI AMIBI002 0x00000002 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 20000000 (gap: 1f400000:e0bc0000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 2983.569 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 504104k/511936k available (1467k kernel code, 7236k reserved, 566k data, 140k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6100.63 BogoMIPS (lpj=12201260)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 07c0a97b 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 07c0a97b 00000000 00000000 00000000 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: After all inits, caps: 07c0a97b 00000000 00000000 00000180 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 0a00)
checking if image is initramfs... it is
Freeing initrd memory: 299k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-043f claimed by PIIX4 ACPI
PCI quirk: region 0440-044f claimed by PIIX4 SMB
Boot video device is 0000:00:08.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0c: ioport range 0x400-0x43f could not be reserved
pnp: 00:0c: ioport range 0x370-0x371 has been reserved
pnp: 00:0c: ioport range 0x440-0x44f has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:08.0
* Found PM-Timer Bug on this chipset. Due to workarounds for a bug,
* this time source is slow.  Consider trying other time sources (clock=)
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
Limiting direct PCI/PCI transfers.
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a TI16750
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a TI16750
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a TI16750
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a TI16750
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
0000:00:0a.0: DC21140 at 0xec00, h/w address 00:03:ff:01:01:40,
eth%d: Using generic MII device control. If the board doesn't operate, 
please mail the following dump to the author:

MII device address: 0
MII CR:  3100
MII SR:  782c
MII ID0: fff
MII ID1: fc41
MII ANA: 1e1
MII ANC: 41e1
MII 16:  400
MII 17:  8008
MII 18:  7800

      and requires IRQ9 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Virtual HD, ATA DISK drive
hdb: Virtual HD, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Virtual CD, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 41942880 sectors (21474 MB) w/64KiB Cache, CHS=41610/16/63, DMA
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdb: max request size: 128KiB
hdb: 41942880 sectors (21474 MB) w/64KiB Cache, CHS=41610/16/63, DMA
 hdb: unknown partition table
hdc: ATAPI DVD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 

ACPI: (supports S0 S5)
Freeing unused kernel memory: 140k freed
trackpoint.c: failed to get extended button data
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
IBM TrackPoint firmware: 0x01, buttons: 0/0
input: TPPS/2 IBM TrackPoint as /class/input/input1
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 82078.
ACPI: Power Button (FF) [PWRF]
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1052216k swap on /dev/hda5.  Priority:-1 extents:1 across:1052216k
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
pnp: Device 00:0a disabled.
eth0: media is 100Mb/s.
BUG: soft lockup detected on CPU#0!
 <c012f53b> softlockup_tick+0x7f/0x8e   <c011e5bc> update_process_times+0x35/0x57
 <c0104fee> timer_interrupt+0x3d/0x60   <c012f648> handle_IRQ_event+0x21/0x4a
 <c012f6e9> __do_IRQ+0x78/0xcb   <c0104110> do_IRQ+0x42/0x4f
 <c0102c2a> common_interrupt+0x1a/0x20   <c01b2869> acpi_ev_gpe_detect+0xee/0xfa
 <c01b1296> acpi_ev_sci_xrupt_handler+0x12/0x19   <c01ac9fa> acpi_irq+0xb/0x14
 <c012f648> handle_IRQ_event+0x21/0x4a   <c012f6e9> __do_IRQ+0x78/0xcb
 <c0104110> do_IRQ+0x42/0x4f   <c0102c2a> common_interrupt+0x1a/0x20
 <c01f4270> dc21140m_autoconf+0xa36/0xaca   <c01f3e96> dc21140m_autoconf+0x65c/0xaca
 <c01f7941> de4x5_switch_mac_port+0xc9/0x116   <c01f6903> dc21140_infoleaf+0x49/0xbd
 <c01f4dab> srom_autoconf+0x8/0x9   <c01f248b> de4x5_ast+0x25/0x76
 <c011e706> run_timer_softirq+0x11f/0x159   <c01f2466> de4x5_ast+0x0/0x76
 <c011b4f9> __do_softirq+0x35/0x7d   <c011b563> do_softirq+0x22/0x26
 <c0104115> do_IRQ+0x47/0x4f   <c0102c2a> common_interrupt+0x1a/0x20
 <c01f2f86> autoconf_media+0xa4/0xaf   <c01f1a8d> de4x5_init+0x1e/0x22
 <c01f1837> de4x5_open+0x4c/0x284   <c026d6bb> __mutex_lock_slowpath+0x297/0x367
 <c0224417> dev_open+0x2d/0x64   <c022552e> dev_change_flags+0x47/0xea
 <c02553f3> devinet_ioctl+0x261/0x4c5   <c0256d3e> inet_ioctl+0x70/0x8d
 <c021cbd7> sock_ioctl+0x18c/0x1a7   <c021ca4b> sock_ioctl+0x0/0x1a7
 <c0156fb0> do_ioctl+0x1c/0x42   <c01571f4> vfs_ioctl+0x178/0x186
 <c015722c> sys_ioctl+0x2a/0x42   <c01029f7> sysenter_past_esp+0x54/0x75
irq 9: nobody cared (try booting with the "irqpoll" option)
 <c012fbf9> __report_bad_irq+0x2b/0x68   <c012fcc2> note_interrupt+0x73/0x99
 <c012f70a> __do_IRQ+0x99/0xcb   <c0104110> do_IRQ+0x42/0x4f
 <c0102c2a> common_interrupt+0x1a/0x20   <c01f4270> dc21140m_autoconf+0xa36/0xaca
 <c01f3e96> dc21140m_autoconf+0x65c/0xaca   <c01f7941> de4x5_switch_mac_port+0xc9/0x116
 <c01f6903> dc21140_infoleaf+0x49/0xbd   <c01f4dab> srom_autoconf+0x8/0x9
 <c01f248b> de4x5_ast+0x25/0x76   <c011e706> run_timer_softirq+0x11f/0x159
 <c01f2466> de4x5_ast+0x0/0x76   <c011b4f9> __do_softirq+0x35/0x7d
 <c011b563> do_softirq+0x22/0x26   <c0104115> do_IRQ+0x47/0x4f
 <c0102c2a> common_interrupt+0x1a/0x20   <c01f2f86> autoconf_media+0xa4/0xaf
 <c01f1a8d> de4x5_init+0x1e/0x22   <c01f1837> de4x5_open+0x4c/0x284
 <c026d6bb> __mutex_lock_slowpath+0x297/0x367   <c0224417> dev_open+0x2d/0x64
 <c022552e> dev_change_flags+0x47/0xea   <c02553f3> devinet_ioctl+0x261/0x4c5
 <c0256d3e> inet_ioctl+0x70/0x8d   <c021cbd7> sock_ioctl+0x18c/0x1a7
 <c021ca4b> sock_ioctl+0x0/0x1a7   <c0156fb0> do_ioctl+0x1c/0x42
 <c01571f4> vfs_ioctl+0x178/0x186   <c015722c> sys_ioctl+0x2a/0x42
 <c01029f7> sysenter_past_esp+0x54/0x75  
handlers:
[<c01ac9ef>] (acpi_irq+0x0/0x14)
Disabling IRQ #9
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present

2. rc2

Linux version 2.6.17-rc2 (root@build-hzhong) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.1)) #6 Wed Apr 19 12:29:31 PDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f3f0000 (usable)
 BIOS-e820: 000000001f3f0000 - 000000001f3ff000 (ACPI data)
 BIOS-e820: 000000001f3ff000 - 000000001f400000 (ACPI NVS)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
499MB LOWMEM available.
On node 0 totalpages: 127984
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 123888 pages, LIFO batch:31
DMI 2.3 present.
Allocating PCI resources starting at 20000000 (gap: 1f400000:e0bc0000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 2966.176 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 504104k/511936k available (1470k kernel code, 7236k reserved, 568k data, 140k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6103.48 BogoMIPS (lpj=12206961)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 07c0a97b 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 07c0a97b 00000000 00000000 00000000 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: After all inits, caps: 07c0a97b 00000000 00000000 00000180 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 0a00)
checking if image is initramfs... it is
Freeing initrd memory: 299k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-043f claimed by PIIX4 ACPI
PCI quirk: region 0440-044f claimed by PIIX4 SMB
Boot video device is 0000:00:08.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0c: ioport range 0x400-0x43f could not be reserved
pnp: 00:0c: ioport range 0x370-0x371 has been reserved
pnp: 00:0c: ioport range 0x440-0x44f has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:08.0
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
Limiting direct PCI/PCI transfers.
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a TI16750
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a TI16750
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a TI16750
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a TI16750
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
0000:00:0a.0: DC21140 at 0xec00, h/w address 00:03:ff:01:01:40,
eth%d: Using generic MII device control. If the board doesn't operate, 
please mail the following dump to the author:

MII device address: 0
MII CR:  3100
MII SR:  782c
MII ID0: fff
MII ID1: fc41
MII ANA: 1e1
MII ANC: 41e1
MII 16:  400
MII 17:  8008
MII 18:  7800

      and requires IRQ9 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Virtual HD, ATA DISK drive
hdb: Virtual HD, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Virtual CD, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 41942880 sectors (21474 MB) w/64KiB Cache, CHS=41610/16/63, DMA
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdb: max request size: 128KiB
hdb: 41942880 sectors (21474 MB) w/64KiB Cache, CHS=41610/16/63, DMA
 hdb: unknown partition table
hdc: ATAPI DVD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 

ACPI: (supports S0 S5)
Freeing unused kernel memory: 140k freed
trackpoint.c: failed to get extended button data
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
IBM TrackPoint firmware: 0x01, buttons: 0/0
input: TPPS/2 IBM TrackPoint as /class/input/input1
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 82078.
ACPI: Power Button (FF) [PWRF]
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1052216k swap on /dev/hda5.  Priority:-1 extents:1 across:1052216k
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
pnp: Device 00:0a disabled.
eth0: media is 100Mb/s.
BUG: soft lockup detected on CPU#0!
 <c012f507> softlockup_tick+0x7f/0x8e   <c011e5d4> update_process_times+0x35/0x57
 <c0105036> timer_interrupt+0x3d/0x60   <c012f614> handle_IRQ_event+0x21/0x4a
 <c012f6b5> __do_IRQ+0x78/0xcb   <c0104158> do_IRQ+0x42/0x4f
 <c0102c2a> common_interrupt+0x1a/0x20   <c01ad08f> acpi_irq+0x0/0x14
 <c01ad08f> acpi_irq+0x0/0x14   <c012f614> handle_IRQ_event+0x21/0x4a
 <c012f6b5> __do_IRQ+0x78/0xcb   <c0104158> do_IRQ+0x42/0x4f
 <c0102c2a> common_interrupt+0x1a/0x20   <c01f4ab8> dc21140m_autoconf+0xa36/0xaca
 <c01f46de> dc21140m_autoconf+0x65c/0xaca   <c01f8189> de4x5_switch_mac_port+0xc9/0x116
 <c01f714b> dc21140_infoleaf+0x49/0xbd   <c01f55f3> srom_autoconf+0x8/0x9
 <c01f2cd3> de4x5_ast+0x25/0x76   <c011e71e> run_timer_softirq+0x11f/0x159
 <c01f2cae> de4x5_ast+0x0/0x76   <c011b529> __do_softirq+0x35/0x7d
 <c011b593> do_softirq+0x22/0x26   <c010415d> do_IRQ+0x47/0x4f
 <c01f2761> de4x5_interrupt+0x0/0x1a6   <c0102c2a> common_interrupt+0x1a/0x20
 <c01f2761> de4x5_interrupt+0x0/0x1a6   <c0145f07> kmem_cache_alloc+0x0/0x4e
 <c012fa38> request_irq+0x38/0x84   <c01f20ef> de4x5_open+0xbc/0x284
 <c0224dcf> dev_open+0x2d/0x64   <c0225ee6> dev_change_flags+0x47/0xea
 <c0255dab> devinet_ioctl+0x261/0x4c5   <c02576f6> inet_ioctl+0x70/0x8d
 <c021d58d> sock_ioctl+0x18c/0x1a7   <c021d401> sock_ioctl+0x0/0x1a7
 <c0156e74> do_ioctl+0x1c/0x42   <c01570b8> vfs_ioctl+0x178/0x186
 <c01570f0> sys_ioctl+0x2a/0x42   <c01029f7> sysenter_past_esp+0x54/0x75
irq 9: nobody cared (try booting with the "irqpoll" option)
 <c012fbc5> __report_bad_irq+0x2b/0x68   <c012fc8e> note_interrupt+0x73/0x99
 <c012f6d6> __do_IRQ+0x99/0xcb   <c0104158> do_IRQ+0x42/0x4f
 <c0102c2a> common_interrupt+0x1a/0x20   <c01f4ab8> dc21140m_autoconf+0xa36/0xaca
 <c01f46de> dc21140m_autoconf+0x65c/0xaca   <c01f8189> de4x5_switch_mac_port+0xc9/0x116
 <c01f714b> dc21140_infoleaf+0x49/0xbd   <c01f55f3> srom_autoconf+0x8/0x9
 <c01f2cd3> de4x5_ast+0x25/0x76   <c011e71e> run_timer_softirq+0x11f/0x159
 <c01f2cae> de4x5_ast+0x0/0x76   <c011b529> __do_softirq+0x35/0x7d
 <c011b593> do_softirq+0x22/0x26   <c010415d> do_IRQ+0x47/0x4f
 <c01f2761> de4x5_interrupt+0x0/0x1a6   <c0102c2a> common_interrupt+0x1a/0x20
 <c01f2761> de4x5_interrupt+0x0/0x1a6   <c0145f07> kmem_cache_alloc+0x0/0x4e
 <c012fa38> request_irq+0x38/0x84   <c01f20ef> de4x5_open+0xbc/0x284
 <c0224dcf> dev_open+0x2d/0x64   <c0225ee6> dev_change_flags+0x47/0xea
 <c0255dab> devinet_ioctl+0x261/0x4c5   <c02576f6> inet_ioctl+0x70/0x8d
 <c021d58d> sock_ioctl+0x18c/0x1a7   <c021d401> sock_ioctl+0x0/0x1a7
 <c0156e74> do_ioctl+0x1c/0x42   <c01570b8> vfs_ioctl+0x178/0x186
 <c01570f0> sys_ioctl+0x2a/0x42   <c01029f7> sysenter_past_esp+0x54/0x75
handlers:
[<c01ad08f>] (acpi_irq+0x0/0x14)
Disabling IRQ #9
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
