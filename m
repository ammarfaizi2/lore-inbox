Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUG0WeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUG0WeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266678AbUG0Wc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:32:59 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:2308 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266674AbUG0Wat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:30:49 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20040727162759.GA32548@elte.hu>
References: <40F3F0A0.9080100@vision.ee>
	 <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu>  <20040727162759.GA32548@elte.hu>
Content-Type: multipart/mixed; boundary="=-5PDjBsPx03J+kVs1KOPL"
Date: Wed, 28 Jul 2004 00:30:40 +0200
Message-Id: <1090967441.1835.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5PDjBsPx03J+kVs1KOPL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-07-27 at 18:27 +0200, Ingo Molnar wrote:

> BIG WARNING: the hardirq-redirection feature is quite intrusive to
> drivers so it's possible that some drivers will break under it.  The
> changes done to the IDE driver might also endanger stability. Be careful
> when applying this patch to production systems. If your system doesnt
> boot then please try the voluntary-preempt=2 boot-option to turn off
> hardirq redirection.

I've seen an oops on my P4 machine when booting with voluntary-
preempt=3, but not with voluntary-preempt<3. I think it's related to the
serial controller (IRQ3 and IRQ4). Please, see attached dmesg.

--=-5PDjBsPx03J+kVs1KOPL
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=utf-8
Content-Transfer-Encoding: 8bit

Linux version 2.6.8-rc2-bk6-ck6 (root@glass.felipe-alfaro.com) (gcc version 3.4.1 20040714 (Red Hat 3.4.1-5)) #1 Wed Jul 28 00:00:29 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5610
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 IntelR                                    ) @ 0x000f6fe0
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff6dc0
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: ro root=/dev/hda2
Initializing CPU#0
CPU 0 irqstacks, hard=c039f000 soft=c039e000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2004.916 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515648k/524224k available (1779k kernel code, 7816k reserved, 759k data, 128k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3956.73 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        3febfbff 00000000 00000000 00000080
CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2004.0312 MHz.
..... host bus clock speed is 100.0215 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb0a0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI interrupt 0000:02:0d.0[A] -> GSI 21 (level, low) -> IRQ 21
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 001 01  1    1    0   1   0    1    1    B9
 12 000 00  1    0    0   0   0    0    0    00
 13 001 01  1    1    0   1   0    1    1    A9
 14 001 01  1    1    0   1   0    1    1    C1
 15 001 01  1    1    0   1   0    1    1    C9
 16 000 00  1    0    0   0   0    0    0    00
 17 001 01  1    1    0   1   0    1    1    B1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ17 -> 0:17
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ23 -> 0:23
.................................... done.
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
audit: initializing netlink socket (disabled)
audit(1090974113.678:0): initialized
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (55 C)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST3120022A, ATA DISK drive
hdb: ST380021A, ATA DISK drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-STDVD-ROM GDR8161B, ATAPI CD/DVD-ROM drive
hdd: PLEXTOR CD-R PX-W4824A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2
hdb: max request size: 128KiB
hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hdb: hdb1
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ACPI: (supports S0 S1 S3 S4bios S5)
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 128k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1f.2: Intel Corp. 82801BA/BAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 19, io base 0000b000
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1f.4: Intel Corp. 82801BA/BAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: irq 23, io base 0000b800
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
EXT3 FS on hda2, internal journal
usb 1-2: new low speed USB device using address 2
usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-0000:00:1f.2-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Adding 262136k swap on /swap.  Priority:-1 extents:67
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdc: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
ACPI: PCI interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:0c.0: 3Com PCI 3c905C Tornado at 0xa000. Vers LK1.1.19
ACPI: PCI interrupt 0000:02:0d.0[A] -> GSI 21 (level, low) -> IRQ 21
0000:02:0d.0: 3Com PCI 3c905C Tornado at 0xa400. Vers LK1.1.19
ip_tables: (C) 2000-2002 Netfilter core team
irq event 4: bogus return value ffffffff
 [<c0105b7e>] __report_bad_irq+0x24/0x7d
 [<c0105c3e>] note_interrupt+0x49/0x88
 [<c02bb3c2>] schedule+0x222/0x48d
 [<c0105f05>] do_hardirq+0x10f/0x191
 [<c0123cb5>] irqd+0x0/0xad
 [<c0123d55>] irqd+0xa0/0xad
 [<c0130010>] kthread+0x7c/0xa4
 [<c012ff94>] kthread+0x0/0xa4
 [<c0102249>] kernel_thread_helper+0x5/0xb
handlers:
irq event 3: bogus return value ffffffff
 [<c0105b7e>] __report_bad_irq+0x24/0x7d
 [<c0105c3e>] note_interrupt+0x49/0x88
 [<c02bb3c2>] schedule+0x222/0x48d
 [<c0105f05>] do_hardirq+0x10f/0x191
 [<c0123cb5>] irqd+0x0/0xad
 [<c0123d55>] irqd+0xa0/0xad
 [<c0130010>] kthread+0x7c/0xa4
 [<c012ff94>] kthread+0x0/0xa4
 [<c0102249>] kernel_thread_helper+0x5/0xb
handlers:
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:01.0 into 1x mode

--=-5PDjBsPx03J+kVs1KOPL--

