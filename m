Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWBTPv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWBTPv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWBTPv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:51:58 -0500
Received: from [217.7.64.195] ([217.7.64.195]:1230 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1030293AbWBTPv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:51:56 -0500
From: Ernst Herzberg <list-lkml@net4u.de>
Reply-To: earny@net4u.de
Organization: Net4U
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc4 bridge/iptables Oops
Date: Mon, 20 Feb 2006 16:51:50 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201651.50217.list-lkml@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This machine oopses one to three (or more?) times a day. Occurs since upgrading 
from -rc3 to -rc4 (and adding/reconfiguring raid).

It is reproducable, i have only to wait 10min to a couple of hours:-)

Opps copy/pasted from a serial console, long lines maybe truncated.
dmesg is from the _previous_ boot/oops....

-------------------------------------------
Oops: 0000 [#1]
PREEMPT
Modules linked in: ebt_log ebt_ip ebtable_filter ebtables nfsd exportfs lockd sunrpc w83627hf hwmon_vid i2c_isa xt_tcpudp xt_state ipt_MASQUERADE iptable_e
CPU:    0
EIP:    0060:[<b033fbf3>]    Not tainted VLI
EFLAGS: 00010282   (2.6.16-rc4 #3)
EIP is at xfrm_lookup+0x1f/0x47d
eax: 00000000   ebx: b0452bb4   ecx: 00000000   edx: b0452bb4
esi: b0452c90   edi: d6c9aa58   ebp: 80000000   esp: b0452b08
ds: 007b   es: 007b   ss: 0068
Process vtund (pid: 12035, threadinfo=b0452000 task=ef8cb030)
Stack: <0>b0452000 d6c9aa58 b0452bc4 00000000 f153b56a b0452b84 d6c9aa58 f1546181
       b03e5d20 00000000 b0452bb4 b0452bb0 b0452b84 b0452b94 f1546511 d804fd24
       d6c9aa58 b0452b94 d6c9aa58 00000000 b0452b84 f15465a6 d6c9aa58 00000000
Call Trace:
 [<f153b56a>] ip_conntrack_tuple_taken+0x2c/0x3e [ip_conntrack]
 [<f1546181>] ip_nat_used_tuple+0x1f/0x2b [ip_nat]
 [<f1546511>] get_unique_tuple+0xca/0xe6 [ip_nat]
 [<f15465a6>] ip_nat_setup_info+0x79/0x1fd [ip_nat]
 [<b033ac28>] ip_xfrm_me_harder+0x5d/0x14b
 [<f154b882>] ip_nat_out+0xb2/0xde [iptable_nat]
 [<b034d154>] br_dev_queue_push_xmit+0x0/0x12a
 [<b0302a2d>] nf_iterate+0x52/0x7e
 [<b034d154>] br_dev_queue_push_xmit+0x0/0x12a
 [<b034d154>] br_dev_queue_push_xmit+0x0/0x12a
 [<b0302ac1>] nf_hook_slow+0x68/0x115
 [<b034d154>] br_dev_queue_push_xmit+0x0/0x12a
 [<b0352cfb>] br_nf_post_routing+0x164/0x1b9
 [<b034d154>] br_dev_queue_push_xmit+0x0/0x12a
 [<b0302a2d>] nf_iterate+0x52/0x7e
 [<b034d154>] br_dev_queue_push_xmit+0x0/0x12a
 [<b034d154>] br_dev_queue_push_xmit+0x0/0x12a
 [<b0302ac1>] nf_hook_slow+0x68/0x115
 [<b034d154>] br_dev_queue_push_xmit+0x0/0x12a
 [<b034d2d1>] br_forward_finish+0x53/0x5f
 [<b034d154>] br_dev_queue_push_xmit+0x0/0x12a
 [<b0352491>] br_nf_forward_finish+0x55/0x121
 [<b034d27e>] br_forward_finish+0x0/0x5f
 [<b0352642>] br_nf_forward_ip+0xe5/0x191
 [<b035243c>] br_nf_forward_finish+0x0/0x121
 [<b0302a2d>] nf_iterate+0x52/0x7e
 [<b034d27e>] br_forward_finish+0x0/0x5f
 [<b034d27e>] br_forward_finish+0x0/0x5f
 [<b0302ac1>] nf_hook_slow+0x68/0x115
 [<b034d27e>] br_forward_finish+0x0/0x5f
 [<b034d3a8>] __br_forward+0x62/0x6c
 [<b034d27e>] br_forward_finish+0x0/0x5f
 [<b034d49d>] br_flood+0x7b/0xcb
 [<b034d346>] __br_forward+0x0/0x6c
 [<b034d50f>] br_flood_forward+0xf/0x14
 [<b034d346>] __br_forward+0x0/0x6c
 [<b034dfb1>] br_handle_frame_finish+0x102/0x11d
 [<b0351896>] br_nf_pre_routing_finish+0xeb/0x38a
 [<b034deaf>] br_handle_frame_finish+0x0/0x11d
 [<f154b568>] ip_nat_fn+0x93/0x224 [iptable_nat]
 [<f153bc80>] ip_conntrack_in+0x174/0x286 [ip_conntrack]
 [<f154b724>] ip_nat_in+0x2b/0xd7 [iptable_nat]
 [<b03517ab>] br_nf_pre_routing_finish+0x0/0x38a
 [<b0302a2d>] nf_iterate+0x52/0x7e
 [<b03517ab>] br_nf_pre_routing_finish+0x0/0x38a
 [<b03517ab>] br_nf_pre_routing_finish+0x0/0x38a
 [<b0302ac1>] nf_hook_slow+0x68/0x115
 [<b03517ab>] br_nf_pre_routing_finish+0x0/0x38a
 [<b0352195>] br_nf_pre_routing+0x2f9/0x53c
 [<b03517ab>] br_nf_pre_routing_finish+0x0/0x38a
 [<b0302a2d>] nf_iterate+0x52/0x7e
 [<b034deaf>] br_handle_frame_finish+0x0/0x11d
 [<b034deaf>] br_handle_frame_finish+0x0/0x11d
 [<b0302ac1>] nf_hook_slow+0x68/0x115
 [<b034deaf>] br_handle_frame_finish+0x0/0x11d
 [<b034e175>] br_handle_frame+0x1a9/0x208
 [<b034deaf>] br_handle_frame_finish+0x0/0x11d
 [<b02ee950>] netif_receive_skb+0x1e4/0x2e6
 [<b02eeaca>] process_backlog+0x78/0xec
 [<b02eec68>] net_rx_action+0x12a/0x1af
 [<b011f602>] __do_softirq+0x3e/0x8a
 [<b010520d>] do_softirq+0x41/0x50
 =======================
 [<b02ee69b>] netif_rx_ni+0x42/0x4b
 [<b0290d60>] tun_chr_writev+0x140/0x1be
 [<b0290dde>] tun_chr_write+0x0/0x24
 [<b0290dfe>] tun_chr_write+0x20/0x24
 [<b0156723>] vfs_write+0x96/0x16e
 [<b01568a6>] sys_write+0x41/0x6a
 [<b0102df1>] syscall_call+0x7/0xb
Code: 8b 7c 24 10 8b 6c 24 14 83 c4 18 c3 55 57 56 53 81 ec 84 00 00 00 89 44 24 2c 89 54 24 28 89 4c 24 24 8b 00 89 44 24 20 8b 40 7c <0f> b7 00 66 89 44
 <0>Kernel panic - not syncing: Fatal exception in interrupt

------------------dmesg--------------------

Linux version 2.6.16-rc4 (root@oernie) (gcc version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #3 PREEMPT Mon Feb 20 02:13:12 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
1023MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 262064
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 257968 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000fad80
ACPI: XSDT (v001 A M I  OEMXSDT  0x09000507 MSFT 0x00000097) @ 0x3ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x09000507 MSFT 0x00000097) @ 0x3ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x09000507 MSFT 0x00000097) @ 0x3ffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x09000507 MSFT 0x00000097) @ 0x3ffc0040
ACPI: DSDT (v001  A0030 A0030011 0x00000011 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bfb80000)
Built 1 zonelists
Kernel command line: root=/dev/md2 vga=0x31a console=ttyS0,38400n8 console=tty0
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=b0453000 soft=b0452000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2799.151 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Memory: 1034212k/1048256k available (2400k kernel code, 13544k reserved, 796k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5606.29 BogoMIPS (lpj=11212582)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0a: ioport range 0x680-0x6ff has been reserved
pnp: 00:0a: ioport range 0x290-0x297 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: fe900000-fe9fffff
  PREFETCH window: d7e00000-f7dfffff
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fea00000-feafffff
  PREFETCH window: f7e00000-f7efffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Machine check exception polling timer started.
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xe8000000, mapped to 0xf0880000, using 5120k, total 131072k
vesafb: mode is 1280x1024x16, linelength=2560, pages=50
vesafb: protected mode interface info at c000:56df
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
hw_random: RNG not detected
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized drm 1.0.1 20051102
[drm] Initialized radeon 1.21.0 20051229 on minor 0
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 21 (level, low) -> IRQ 16
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:09.0: 3Com PCI 3c905C Tornado at f0804400. Vers LK1.1.19
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 17
eth1: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI Interrupt 0000:02:0d.0[A] -> GSI 21 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:02:0d.0, from 5 to 0
eth2: VIA Rhine II at 0x1d000, 00:05:5d:dd:0a:80, IRQ 16.
eth2: MII PHY found at address 8, status 0x7829 advertising 01e1 Link 45e1.
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6Y080P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SAMSUNG SP0802N, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: max request size: 512KiB
hdc: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF60 irq 18
ata2: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF68 irq 18
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:20ff
ata1: dev 0 ATA-7, max UDMA7, 488397168 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:20ff
ata2: dev 0 ATA-7, max UDMA7, 488397168 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_promise 0000:02:04.0: version 1.03
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 23 (level, low) -> IRQ 19
ata3: SATA max UDMA/133 cmd 0xF0806200 ctl 0xF0806238 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xF0806280 ctl 0xF08062B8 bmdma 0x0 irq 19
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:80ff
ata3: dev 0 ATA-7, max UDMA7, 488397168 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_promise
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:80ff
ata4: dev 0 ATA-7, max UDMA7, 488397168 sectors: LBA48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_promise
  Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
sd 3:0:0:0: Attached scsi generic sg3 type 0
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  3578.000 MB/sec
raid5: using function: pIII_sse (3578.000 MB/sec)
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Feb 20 2006
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 15
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Using IPI Shortcut mode
ACPI wakeup devices: 
P0P4 MC97 USB1 USB2 USB3 USB4 EUSB PS2K ILAN 
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: hdc3 has different UUID to sdd1
md: hdc2 has different UUID to sdd1
md: hdc1 has different UUID to sdd1
md: hda3 has different UUID to sdd1
md: hda2 has different UUID to sdd1
md: hda1 has different UUID to sdd1
md: created md3
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1><sdb1><sda1>
raid5: device sdd1 operational as raid disk 3
raid5: device sdc1 operational as raid disk 2
raid5: device sdb1 operational as raid disk 1
raid5: device sda1 operational as raid disk 0
raid5: allocated 4195kB for md3
raid5: raid level 5 set md3 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4 fd:0
 disk 0, o:1, dev:sda1
 disk 1, o:1, dev:sdb1
 disk 2, o:1, dev:sdc1
 disk 3, o:1, dev:sdd1
md: considering hdc3 ...
md:  adding hdc3 ...
md: hdc2 has different UUID to hdc3
md: hdc1 has different UUID to hdc3
md:  adding hda3 ...
md: hda2 has different UUID to hdc3
md: hda1 has different UUID to hdc3
md: created md2
md: bind<hda3>
md: bind<hdc3>
md: running: <hdc3><hda3>
md2: setting max_sectors to 32, segment boundary to 8191
raid0: looking at hdc3
raid0:   comparing hdc3(76035520) with hdc3(76035520)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hda3
raid0:   comparing hda3(77894592) with hdc3(76035520)
raid0:   NOT EQUAL
raid0:   comparing hda3(77894592) with hda3(77894592)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
raid0: zone 1
raid0: checking hda3 ... contained as device 0
  (77894592) is smallest!.
raid0: checking hdc3 ... nope.
raid0: zone->nb_dev: 1, size: 1859072
raid0: current zone offset: 77894592
raid0: done.
raid0 : md_size is 153930112 blocks.
raid0 : conf->hash_spacing is 152071040 blocks.
raid0 : nb_zone is 2.
raid0 : Allocating 8 bytes for hash.
md: considering hdc2 ...
md:  adding hdc2 ...
md: hdc1 has different UUID to hdc2
md:  adding hda2 ...
md: hda1 has different UUID to hdc2
md: created md1
md: bind<hda2>
md: bind<hdc2>
md: running: <hdc2><hda2>
md1: setting max_sectors to 32, segment boundary to 8191
raid0: looking at hdc2
raid0:   comparing hdc2(1951808) with hdc2(1951808)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hda2
raid0:   comparing hda2(1952896) with hdc2(1951808)
raid0:   NOT EQUAL
raid0:   comparing hda2(1952896) with hda2(1952896)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
raid0: zone 1
raid0: checking hda2 ... contained as device 0
  (1952896) is smallest!.
raid0: checking hdc2 ... nope.
raid0: zone->nb_dev: 1, size: 1088
raid0: current zone offset: 1952896
raid0: done.
raid0 : md_size is 3904704 blocks.
raid0 : conf->hash_spacing is 3903616 blocks.
raid0 : nb_zone is 2.
raid0 : Allocating 8 bytes for hash.
md: considering hdc1 ...
md:  adding hdc1 ...
md:  adding hda1 ...
md: created md0
md: bind<hda1>
md: bind<hdc1>
md: running: <hdc1><hda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
ReiserFS: md2: found reiserfs format "3.6" with standard journal
ReiserFS: md2: using ordered data mode
ReiserFS: md2: journal params: device md2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md2: checking transaction log (md2)
ReiserFS: md2: replayed 7 transactions in 0 seconds
ReiserFS: md2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding 3904696k swap on /dev/md1.  Priority:-1 extents:1 across:3904696k
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Linux video capture interface: v1.00
saa7146: register extension 'dvb'.
ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 17
saa7146: found saa7146 @ mem f1024000 (revision 1, irq 17) (0x13c2,0x0003).
DVB: registering new adapter (Technotrend/Hauppauge WinTV Nexus-S rev2.X).
adapter has MAC addr = 00:d0:5c:23:85:9b
dvb-ttpci: gpioirq unknown type=0 len=0
dvb-ttpci: info @ card 0: firm f0240009, rtsl b0250018, vid 71010068, app 80002622
dvb-ttpci: firmware @ card 0 supports CI link layer interface
dvb-ttpci: Crystal audio DAC @ card 0 detected
saa7146_vv: saa7146 (0): registered device video0 [v4l2]
saa7146_vv: saa7146 (0): registered device vbi0 [v4l2]
DVB: registering frontend 0 (ST STV0299 DVB-S)...
input: DVB on-card IR receiver as /class/input/input2
dvb-ttpci: found av7110-0.
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
bttv0: Bt878 (rev 17) at 0000:02:0c.0, irq: 20, latency: 64, mmio: 0xf7efe000
bttv0: detected: Pinnacle PCTV Sat [card=94], PCI subsystem ID is 11bd:001c
bttv0: using: Pinnacle PCTV Sat [card=94,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=009f00fc [init]
bttv0: using tuner=-1
bttv0: registered device video1
bttv0: registered device vbi1
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: add subdevice "dvb0"
bt878: DVB driver version 0.0.1 loaded
bt878: DVB interface found (0).
ACPI: PCI Interrupt 0000:02:0c.1[A] -> GSI 20 (level, low) -> IRQ 20
bt878_probe: card id=[0x1c11bd],[ Pinnacle PCTV Sat ] has DVB functions.
bt878(0): Bt878 (rev 17) at 02:0c.1, irq: 20, latency: 64, memory: 0xf7eff000
DVB: registering new adapter (bttv0).
DVB: registering frontend 1 (Conexant CX24110 DVB-S)...
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: md3: found reiserfs format "3.6" with standard journal
ReiserFS: md3: using ordered data mode
ReiserFS: md3: journal params: device md3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md3: checking transaction log (md3)
ReiserFS: md3: replayed 15 transactions in 4 seconds
ReiserFS: md3: Using r5 hash to sort names
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 21, io base 0x0000ef00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 22, io base 0x0000ef20
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ef40
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 21, io base 0x0000ef80
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
usb 4-2: new full speed USB device using uhci_hcd and address 2
usb 4-2: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
input: Cypress Semi. Cypress Ultra Mouse as /class/input/input3
input: USB HID v1.10 Mouse [Cypress Semi. Cypress Ultra Mouse] on usb-0000:00:1d.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Initializing USB Mass Storage driver...
scsi4 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 19, io mem 0xfebffc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 5-8: new high speed USB device using ehci_hcd and address 3
usb 5-8: configuration #1 chosen from 1 choice
scsi5 : SCSI emulation for USB Mass Storage devices
usb 4-2: USB disconnect, address 2
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usb 2-1: USB disconnect, address 2
usb 2-1: new low speed USB device using uhci_hcd and address 3
usb 2-1: configuration #1 chosen from 1 choice
input: Cypress Semi. Cypress Ultra Mouse as /class/input/input4
input: USB HID v1.10 Mouse [Cypress Semi. Cypress Ultra Mouse] on usb-0000:00:1d.1-1
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 54585 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:02:03.0, from 5 to 4
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[20]  MMIO=[feaff800-feafffff]  Max Packet=[2048]  IR/IT contexts=[4/8]
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
parport0: Printer, Hewlett-Packard OfficeJet T Series
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d800006d7518]
  Vendor: WDC WD25  Model: 00JB-00GVA0       Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
sde: Write Protect is off
sde: Mode Sense: 03 00 00 00
sde: assuming drive cache: write through
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
sde: Write Protect is off
sde: Mode Sense: 03 00 00 00
sde: assuming drive cache: write through
 sde: sde1
sd 5:0:0:0: Attached scsi disk sde
sd 5:0:0:0: Attached scsi generic sg4 type 0
usb-storage: device scan complete
device eth1 entered promiscuous mode
eth1: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  disabled
    tx-checksum:     disabled
    rx-checksum:     disabled
br1: port 1(eth1) entering learning state
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 21 (level, low) -> IRQ 16
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
NET: Registered protocol family 17
NET: Registered protocol family 24
process `named' is using obsolete setsockopt SO_BSDCOMPAT
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8189 buckets, 65512 max) - 232 bytes per conntrack
br1: topology change detected, propagating
br1: port 1(eth1) entering forwarding state
w83627hf 9191-0290: Reading VID from GPIO5
device tap0 entered promiscuous mode
br1: port 2(tap0) entering listening state
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: unable to find recovery directory /var/lib/nfs/v4recovery
NFSD: starting 90-second grace period
Ebtables v2.0 registered
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: reserved bits set (4) in mode 0x1f004a0f. Fixed.
agpgart: X tried to set rate=x12. Setting to AGP3 x8 mode.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
[drm] Loading R200 Microcode
br1: port 2(tap0) entering learning state
br1: received tcn bpdu on port 2(tap0)
br1: topology change detected, propagating
br1: topology change detected, propagating
br1: port 2(tap0) entering forwarding state

------------ config ----------------

on request, email is big enough:)


<earny/>
