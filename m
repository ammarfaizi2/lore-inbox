Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVCUXia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVCUXia (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVCUXhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:37:14 -0500
Received: from alpha.polcom.net ([217.79.151.115]:43755 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S262177AbVCUXbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:31:13 -0500
Date: Tue, 22 Mar 2005 00:33:00 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Li Shaohua <shaohua.li@intel.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
In-Reply-To: <1111422838.17576.22.camel@eeyore>
Message-ID: <Pine.LNX.4.62.0503220022290.7305@alpha.polcom.net>
References: <1110989436.8378.19.camel@eeyore>  <1111023217.15278.7.camel@sli10-desk.sh.intel.com>
  <1111082914.11380.30.camel@eeyore>  <1111108150.22239.6.camel@sli10-desk.sh.intel.com>
  <1111169239.13286.39.camel@eeyore> <1111422838.17576.22.camel@eeyore>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Bjorn Helgaas wrote:
> On Fri, 2005-03-18 at 11:07 -0700, Bjorn Helgaas wrote:
>> OK.  Try this one for size.  It differs from what's currently in
>> the tree in these ways:
>>
>>     - It's a quirk, so we don't have to clutter acpi_pci_irq_enable()
>>       and pirq_enable_irq() with Via-specific code.
>>
>>     - It doesn't do anything unless we're in PIC mode.  The comment
>>       suggests this issue only affects PIC routing.
>>
>>     - We do this for ALL Via devices.  The current code in the tree
>>       does it for all devices in the system IF there is a Via device
>>       with devfn==0, which misses Grzegorz's case.
>>
>> Does anybody have a pointer to a spec that talks about this?  It'd
>> be awfully nice to have a reference.
>>
>> Grzegorz, can you check to make sure this still works after all the
>> tweaking?
>
> Oops, I had the sense of the skip_ioapic_setup test reversed.  Corrected
> patch follows.

Hi,

Your patch applied with some problems:

patching file arch/i386/pci/irq.c
Hunk #2 succeeded at 1081 with fuzz 2 (offset 1 line).
patching file drivers/acpi/pci_irq.c
patching file drivers/pci/quirks.c
Hunk #1 succeeded at 678 (offset -5 lines).

(I do not know why).

Then I tested it and it works (at least my speedtouch still works).

Here is the log:

Mar 22 01:32:37 kangur Linux version 2.6.11-cko1 (root@kangur) (gcc 
version 3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #4 
Tue Mar 22 01:24:18 CET 2005
Mar 22 01:32:37 kangur BIOS-provided physical RAM map:
Mar 22 01:32:37 kangur BIOS-e820: 0000000000000000 - 000000000009fc00 
(usable)
Mar 22 01:32:37 kangur BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
Mar 22 01:32:37 kangur BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Mar 22 01:32:37 kangur BIOS-e820: 0000000000100000 - 000000001fff0000 
(usable)
Mar 22 01:32:37 kangur BIOS-e820: 000000001fff0000 - 000000001fff3000 
(ACPI NVS)
Mar 22 01:32:37 kangur BIOS-e820: 000000001fff3000 - 0000000020000000 
(ACPI data)
Mar 22 01:32:37 kangur BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
Mar 22 01:32:37 kangur 511MB LOWMEM available.
Mar 22 01:32:37 kangur On node 0 totalpages: 131056
Mar 22 01:32:37 kangur DMA zone: 4096 pages, LIFO batch:1
Mar 22 01:32:37 kangur Normal zone: 126960 pages, LIFO batch:16
Mar 22 01:32:37 kangur HighMem zone: 0 pages, LIFO batch:1
Mar 22 01:32:37 kangur DMI 2.2 present.
Mar 22 01:32:37 kangur ACPI: RSDP (v000 761686 
) @ 0x000f6a70
Mar 22 01:32:37 kangur ACPI: RSDT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3000
Mar 22 01:32:37 kangur ACPI: FADT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3040
Mar 22 01:32:37 kangur ACPI: DSDT (v001 761686 AWRDACPI 0x00001000 MSFT 
0x0100000c) @ 0x00000000
Mar 22 01:32:37 kangur ACPI: PM-Timer IO Port: 0x4008
Mar 22 01:32:37 kangur Allocating PCI resources starting at 20000000 (gap: 
20000000:dfff0000)
Mar 22 01:32:37 kangur Built 1 zonelists
Mar 22 01:32:37 kangur Kernel command line: ro root=/dev/hdb4
Mar 22 01:32:37 kangur Local APIC disabled by BIOS -- you can enable it 
with "lapic"
Mar 22 01:32:37 kangur mapped APIC to ffffd000 (01402000)
Mar 22 01:32:37 kangur Initializing CPU#0
Mar 22 01:32:37 kangur CPU 0 irqstacks, hard=b0477000 soft=b0476000
Mar 22 01:32:37 kangur PID hash table entries: 2048 (order: 11, 32768 
bytes)
Mar 22 01:32:37 kangur Detected 1203.036 MHz processor.
Mar 22 01:32:37 kangur Using pmtmr for high-res timesource
Mar 22 01:32:37 kangur Console: colour VGA+ 80x25
Mar 22 01:32:37 kangur Dentry cache hash table entries: 131072 (order: 7, 
524288 bytes)
Mar 22 01:32:37 kangur Inode-cache hash table entries: 65536 (order: 6, 
262144 bytes)
Mar 22 01:32:37 kangur Memory: 514940k/524224k available (2543k kernel 
code, 8732k reserved, 819k data, 156k init, 0k highmem)
Mar 22 01:32:37 kangur Checking if this processor honours the WP bit even 
in supervisor mode... Ok.
Mar 22 01:32:37 kangur Calibrating delay loop... 2375.68 BogoMIPS 
(lpj=1187840)
Mar 22 01:32:37 kangur Security Framework v1.0.0 initialized
Mar 22 01:32:37 kangur Capability LSM initialized
Mar 22 01:32:37 kangur Mount-cache hash table entries: 512 (order: 0, 4096 
bytes)
Mar 22 01:32:37 kangur CPU: After generic identify, caps: 0383f9ff 
c1cbf9ff 00000000 00000000 00000000 00000000 00000000Mar 22 01:32:37 
kangur CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 
00000000 00000000 00000000 00000000
Mar 22 01:32:37 kangur CPU: CLK_CTL MSR was 60071263. Reprogramming to 
20071263
Mar 22 01:32:37 kangur CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K 
(64 bytes/line)
Mar 22 01:32:37 kangur CPU: L2 Cache: 512K (64 bytes/line)
Mar 22 01:32:37 kangur CPU: After all inits, caps: 0383f9ff c1cbf9ff 
00000000 00000020 00000000 00000000 00000000
Mar 22 01:32:37 kangur Intel machine check architecture supported.
Mar 22 01:32:37 kangur Intel machine check reporting enabled on CPU#0.
Mar 22 01:32:37 kangur CPU: AMD Unknown CPU Type stepping 00
Mar 22 01:32:37 kangur Enabling fast FPU save and restore... done.
Mar 22 01:32:37 kangur Enabling unmasked SIMD FPU exception support... 
done.
Mar 22 01:32:37 kangur Checking 'hlt' instruction... OK.
Mar 22 01:32:37 kangur ACPI: setting ELCR to 0800 (from 0e20)
Mar 22 01:32:37 kangur NET: Registered protocol family 16
Mar 22 01:32:37 kangur PCI: PCI BIOS revision 2.10 entry at 0xfb690, last 
bus=1
Mar 22 01:32:37 kangur PCI: Using configuration type 1
Mar 22 01:32:37 kangur mtrr: v2.0 (20020519)
Mar 22 01:32:37 kangur ACPI: Subsystem revision 20050211
Mar 22 01:32:37 kangur ACPI: Interpreter enabled
Mar 22 01:32:37 kangur ACPI: Using PIC for interrupt routing
Mar 22 01:32:37 kangur ACPI: PCI Root Bridge [PCI0] (00:00)
Mar 22 01:32:37 kangur PCI: Probing PCI hardware (bus 00)
Mar 22 01:32:37 kangur ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Mar 22 01:32:37 kangur ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 
*10 11 12 14 15)
Mar 22 01:32:37 kangur ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 
10 *11 12 14 15)
Mar 22 01:32:37 kangur ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 
10 11 12 14 15)
Mar 22 01:32:37 kangur ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 
10 11 12 14 15) *9
Mar 22 01:32:37 kangur Linux Plug and Play Support v0.97 (c) Adam Belay
Mar 22 01:32:37 kangur pnp: PnP ACPI init
Mar 22 01:32:37 kangur pnp: PnP ACPI: found 12 devices
Mar 22 01:32:37 kangur SCSI subsystem initialized
Mar 22 01:32:37 kangur PCI: Using ACPI for IRQ routing
Mar 22 01:32:37 kangur ** PCI interrupts are no longer routed 
automatically.  If this
Mar 22 01:32:37 kangur ** causes a device to stop working, it is probably 
because the
Mar 22 01:32:37 kangur ** driver failed to call pci_enable_device().  As a 
temporary
Mar 22 01:32:37 kangur ** workaround, the "pci=routeirq" argument restores 
the old
Mar 22 01:32:37 kangur ** behavior.  If this argument makes the device 
work again,
Mar 22 01:32:37 kangur ** please email the output of "lspci" to 
bjorn.helgaas@hp.com
Mar 22 01:32:37 kangur ** so I can fix the driver.
Mar 22 01:32:37 kangur pnp: the driver 'system' has been registered
Mar 22 01:32:37 kangur pnp: match found with the PnP device '00:00' and 
the driver 'system'
Mar 22 01:32:37 kangur pnp: match found with the PnP device '00:01' and 
the driver 'system'
Mar 22 01:32:37 kangur Total HugeTLB memory allocated, 0
Mar 22 01:32:37 kangur VFS: Disk quotas dquot_6.5.1
Mar 22 01:32:37 kangur Dquot-cache hash table entries: 1024 (order 0, 4096 
bytes)
Mar 22 01:32:37 kangur SGI XFS with ACLs, security attributes, realtime, 
no debug enabled
Mar 22 01:32:37 kangur SGI XFS Quota Management subsystem
Mar 22 01:32:37 kangur Initializing Cryptographic API
Mar 22 01:32:37 kangur inotify device minor=63
Mar 22 01:32:37 kangur ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 
0x64, irq 1
Mar 22 01:32:37 kangur ACPI: PS/2 Mouse Controller [PS2M] at irq 12
Mar 22 01:32:37 kangur serio: i8042 AUX port at 0x60,0x64 irq 12
Mar 22 01:32:37 kangur serio: i8042 KBD port at 0x60,0x64 irq 1
Mar 22 01:32:37 kangur io scheduler noop registered
Mar 22 01:32:37 kangur io scheduler anticipatory registered
Mar 22 01:32:37 kangur io scheduler deadline registered
Mar 22 01:32:37 kangur io scheduler cfq registered
Mar 22 01:32:37 kangur 8139too Fast Ethernet driver 0.9.27
Mar 22 01:32:37 kangur ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Mar 22 01:32:37 kangur PCI: setting IRQ 11 as level-triggered
Mar 22 01:32:37 kangur ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 
(level, low) -> IRQ 11
Mar 22 01:32:37 kangur eth0: RealTek RTL8139 at 0xec00, 00:06:4f:00:73:8b, 
IRQ 11
Mar 22 01:32:37 kangur eth0:  Identified 8139 chip type 'RTL-8139C'
Mar 22 01:32:37 kangur Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Mar 22 01:32:37 kangur ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
Mar 22 01:32:37 kangur VP_IDE: IDE controller at PCI slot 0000:00:07.1
Mar 22 01:32:37 kangur PCI: Via PIC IRQ fixup for 0000:00:07.1, from 255 
to 0
Mar 22 01:32:37 kangur VP_IDE: chipset revision 6
Mar 22 01:32:37 kangur VP_IDE: not 100% native mode: will probe irqs later
Mar 22 01:32:37 kangur VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 
controller on pci0000:00:07.1
Mar 22 01:32:37 kangur ide0: BM-DMA at 0xc400-0xc407, BIOS settings: 
hda:pio, hdb:DMA
Mar 22 01:32:37 kangur ide1: BM-DMA at 0xc408-0xc40f, BIOS settings: 
hdc:pio, hdd:DMA
Mar 22 01:32:37 kangur Probing IDE interface ide0...
Mar 22 01:32:37 kangur hdb: SAMSUNG SV3063H, ATA DISK drive
Mar 22 01:32:37 kangur ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 22 01:32:37 kangur Probing IDE interface ide1...
Mar 22 01:32:37 kangur hdd: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM 
drive
Mar 22 01:32:37 kangur ide1 at 0x170-0x177,0x376 on irq 15
Mar 22 01:32:37 kangur pnp: the driver 'ide' has been registered
Mar 22 01:32:37 kangur hdb: max request size: 128KiB
Mar 22 01:32:37 kangur hdb: 59797584 sectors (30616 MB) w/426KiB Cache, 
CHS=59323/16/63, UDMA(100)
Mar 22 01:32:37 kangur hdb: cache flushes not supported
Mar 22 01:32:37 kangur hdb: hdb1 hdb2 hdb3 hdb4
Mar 22 01:32:37 kangur libata version 1.10 loaded.
Mar 22 01:32:37 kangur sata_sil version 0.8
Mar 22 01:32:37 kangur ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 
(level, low) -> IRQ 11
Mar 22 01:32:37 kangur ata1: SATA max UDMA/100 cmd 0xD0802080 ctl 
0xD080208A bmdma 0xD0802000 irq 11
Mar 22 01:32:37 kangur ata2: SATA max UDMA/100 cmd 0xD08020C0 ctl 
0xD08020CA bmdma 0xD0802008 irq 11
Mar 22 01:32:37 kangur ata1: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 
85:3469 86:3c41 87:4003 88:207f
Mar 22 01:32:37 kangur ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: 
lba48
Mar 22 01:32:37 kangur ata1: dev 0 configured for UDMA/100
Mar 22 01:32:37 kangur scsi0 : sata_sil
Mar 22 01:32:37 kangur ata2: no device found (phy stat 00000000)
Mar 22 01:32:37 kangur scsi1 : sata_sil
Mar 22 01:32:37 kangur Vendor: ATA       Model: WDC WD1600JD-00H  Rev: 
08.0
Mar 22 01:32:37 kangur Type:   Direct-Access                      ANSI 
SCSI revision: 05
Mar 22 01:32:37 kangur SCSI device sda: 312581808 512-byte hdwr sectors 
(160042 MB)
Mar 22 01:32:37 kangur SCSI device sda: drive cache: write back
Mar 22 01:32:37 kangur SCSI device sda: 312581808 512-byte hdwr sectors 
(160042 MB)
Mar 22 01:32:37 kangur SCSI device sda: drive cache: write back
Mar 22 01:32:37 kangur sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 
sda10 sda11 sda12 sda13 sda14 sda15 >
Mar 22 01:32:37 kangur Attached scsi disk sda at scsi0, channel 0, id 0, 
lun 0
Mar 22 01:32:37 kangur mice: PS/2 mouse device common for all mice
Mar 22 01:32:37 kangur input: AT Translated Set 2 keyboard on 
isa0060/serio0
Mar 22 01:32:37 kangur NET: Registered protocol family 2
Mar 22 01:32:37 kangur IP: routing cache hash table of 4096 buckets, 
32Kbytes
Mar 22 01:32:37 kangur TCP established hash table entries: 32768 (order: 
6, 262144 bytes)
Mar 22 01:32:37 kangur TCP bind hash table entries: 32768 (order: 5, 
131072 bytes)
Mar 22 01:32:37 kangur TCP: Hash tables configured (established 32768 bind 
32768)
Mar 22 01:32:37 kangur ip_conntrack version 2.1 (4095 buckets, 32760 max) 
- 216 bytes per conntrack
Mar 22 01:32:37 kangur ip_tables: (C) 2000-2002 Netfilter core team
Mar 22 01:32:37 kangur ipt_recent v0.3.1: Stephen Frost 
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Mar 22 01:32:37 kangur arp_tables: (C) 2002 David S. Miller
Mar 22 01:32:37 kangur NET: Registered protocol family 17
Mar 22 01:32:37 kangur ACPI wakeup devices:
Mar 22 01:32:37 kangur SLPB PCI0 USB0 USB1
Mar 22 01:32:37 kangur ACPI: (supports S0 S1 S4 S5)
Mar 22 01:32:37 kangur kjournald starting.  Commit interval 5 seconds
Mar 22 01:32:37 kangur EXT3-fs: mounted filesystem with ordered data mode.
Mar 22 01:32:37 kangur VFS: Mounted root (ext3 filesystem) readonly.
Mar 22 01:32:37 kangur Freeing unused kernel memory: 156k freed
Mar 22 01:32:37 kangur NET: Registered protocol family 1
Mar 22 01:32:37 kangur EXT3 FS on hdb4, internal journal
Mar 22 01:32:37 kangur NET: Registered protocol family 8
Mar 22 01:32:37 kangur NET: Registered protocol family 20
Mar 22 01:32:37 kangur CSLIP: code copyright 1989 Regents of the 
University of California
Mar 22 01:32:37 kangur PPP generic driver version 2.4.2
Mar 22 01:32:37 kangur input: PS/2 Generic Mouse on isa0060/serio1
Mar 22 01:32:37 kangur input: PC Speaker
Mar 22 01:32:37 kangur loop: loaded (max 8 devices)
Mar 22 01:32:37 kangur Non-volatile memory driver v1.2
Mar 22 01:32:37 kangur BIOS EDD facility v0.16 2004-Jun-25, 2 devices 
found
Mar 22 01:32:37 kangur vesafb: NVidia Corporation, NV15 Reference Board, 
Chip Rev A0 (OEM: NVidia)
Mar 22 01:32:37 kangur vesafb: VBE version: 3.0
Mar 22 01:32:37 kangur vesafb: protected mode interface info at c000:0f03
Mar 22 01:32:37 kangur vesafb: pmi: set display start = b00c0f3c, set 
palette = b00c0fb2
Mar 22 01:32:37 kangur vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 
3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
Mar 22 01:32:37 kangur vesafb: hardware supports DCC2 transfers
Mar 22 01:32:37 kangur vesafb: monitor limits: vf = 85 Hz, hf = 64 kHz, 
clk = 108 MHz
Mar 22 01:32:37 kangur vesafb: scrolling: redraw
Mar 22 01:32:37 kangur vesafb: framebuffer at 0xe8000000, mapped to 
0xd0900000, using 6144k, total 65536k
Mar 22 01:32:37 kangur fb0: VESA VGA frame buffer device
Mar 22 01:32:37 kangur Console: switching to colour frame buffer device 
128x48
Mar 22 01:32:37 kangur device-mapper: 4.4.0-ioctl (2005-01-12) 
initialised: dm-devel@redhat.com
Mar 22 01:32:37 kangur NTFS driver 2.1.22 [Flags: R/O MODULE].
Mar 22 01:32:37 kangur NTFS volume version 3.1.
Mar 22 01:32:37 kangur NTFS volume version 3.1.
Mar 22 01:32:37 kangur usbcore: registered new driver usbfs
Mar 22 01:32:37 kangur usbcore: registered new driver hub
Mar 22 01:32:37 kangur ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
Mar 22 01:32:37 kangur PCI: setting IRQ 10 as level-triggered
Mar 22 01:32:37 kangur ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 10 
(level, low) -> IRQ 10
Mar 22 01:32:37 kangur parport_pc: VIA 686A/8231 detected
Mar 22 01:32:37 kangur parport_pc: probing current configuration
Mar 22 01:32:37 kangur parport_pc: Current parallel port base: 0x378
Mar 22 01:32:37 kangur parport_pc: Strange, can't probe VIA parallel port: 
io=0x378, irq=7, dma=-1
Mar 22 01:32:37 kangur pnp: the driver 'parport_pc' has been registered
Mar 22 01:32:37 kangur pnp: match found with the PnP device '00:09' and 
the driver 'parport_pc'
Mar 22 01:32:37 kangur parport: PnPBIOS parport detected.
Mar 22 01:32:37 kangur parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
Mar 22 01:32:37 kangur USB Universal Host Controller Interface driver v2.2
Mar 22 01:32:37 kangur ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 
(level, low) -> IRQ 10
Mar 22 01:32:37 kangur PCI: Via PIC IRQ fixup for 0000:00:07.2, from 9 to 
10
Mar 22 01:32:37 kangur uhci_hcd 0000:00:07.2: UHCI Host Controller
Mar 22 01:32:37 kangur uhci_hcd 0000:00:07.2: irq 10, io base 0xc800
Mar 22 01:32:37 kangur uhci_hcd 0000:00:07.2: new USB bus registered, 
assigned bus number 1
Mar 22 01:32:37 kangur hub 1-0:1.0: USB hub found
Mar 22 01:32:37 kangur hub 1-0:1.0: 2 ports detected
Mar 22 01:32:37 kangur ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 
(level, low) -> IRQ 10
Mar 22 01:32:37 kangur PCI: Via PIC IRQ fixup for 0000:00:07.3, from 9 to 
10
Mar 22 01:32:37 kangur uhci_hcd 0000:00:07.3: UHCI Host Controller
Mar 22 01:32:37 kangur uhci_hcd 0000:00:07.3: irq 10, io base 0xcc00
Mar 22 01:32:37 kangur uhci_hcd 0000:00:07.3: new USB bus registered, 
assigned bus number 2
Mar 22 01:32:37 kangur hub 2-0:1.0: USB hub found
Mar 22 01:32:37 kangur hub 2-0:1.0: 2 ports detected
Mar 22 01:32:37 kangur usb 1-2: new full speed USB device using uhci_hcd 
and address 2
Mar 22 01:32:37 kangur Linux video capture interface: v1.00
Mar 22 01:32:37 kangur speedtch: Unknown symbol release_firmware
Mar 22 01:32:37 kangur speedtch: Unknown symbol request_firmware
Mar 22 01:32:37 kangur speedtch: Unknown symbol release_firmware
Mar 22 01:32:37 kangur speedtch: Unknown symbol request_firmware
Mar 22 01:32:37 kangur speedtch: Unknown symbol release_firmware
Mar 22 01:32:37 kangur speedtch: Unknown symbol request_firmware
Mar 22 01:32:37 kangur bttv: driver version 0.9.15 loaded
Mar 22 01:32:37 kangur bttv: using 32 buffers with 2080k (520 pages) each 
for capture
Mar 22 01:32:37 kangur bttv: Bt8xx card found (0).
Mar 22 01:32:37 kangur ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Mar 22 01:32:37 kangur PCI: setting IRQ 5 as level-triggered
Mar 22 01:32:37 kangur ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 5 
(level, low) -> IRQ 5
Mar 22 01:32:37 kangur bttv0: Bt878 (rev 17) at 0000:00:09.0, irq: 5, 
latency: 32, mmio: 0xf7000000
Mar 22 01:32:37 kangur bttv0: using: Prolink Pixelview PV-BT878P+ 
(Rev.4C,8E) [card=70,insmod option]
Mar 22 01:32:37 kangur bttv0: gpio: en=00000000, out=00000000 in=00ffc0ff 
[init]
Mar 22 01:32:37 kangur bttv0: using tuner=25
Mar 22 01:32:37 kangur bttv0: i2c: checking for MSP34xx @ 0x80... not 
found
Mar 22 01:32:37 kangur bttv0: i2c: checking for TDA9875 @ 0xb0... not 
found
Mar 22 01:32:37 kangur bttv0: i2c: checking for TDA7432 @ 0x8a... not 
found
Mar 22 01:32:37 kangur tvaudio: TV audio decoder + audio/video mux driver
Mar 22 01:32:37 kangur tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 
(PV951),ta8874z
Mar 22 01:32:37 kangur bttv0: i2c: checking for TDA9887 @ 0x86... not 
found
Mar 22 01:32:37 kangur tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
Mar 22 01:32:37 kangur tuner 0-0061: type set to 25 (LG PAL_I+FM 
(TAPC-I001D))
Mar 22 01:32:37 kangur bttv0: registered device video0
Mar 22 01:32:37 kangur bttv0: registered device vbi0
Mar 22 01:32:37 kangur bttv0: registered device radio0
Mar 22 01:32:37 kangur bttv0: PLL: 28636363 => 35468950 .. ok
Mar 22 01:32:37 kangur bttv0: add subdevice "remote0"
Mar 22 01:32:37 kangur gameport: pci0000:00:0b.1 speed 1242 kHz
Mar 22 01:32:37 kangur nvidia: module license 'NVIDIA' taints kernel.
Mar 22 01:32:37 kangur ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
Mar 22 01:32:37 kangur ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 10 
(level, low) -> IRQ 10
Mar 22 01:32:37 kangur NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module 
1.0-6629  Wed Nov  3 13:12:51 PST 2004
Mar 22 01:32:37 kangur Real Time Clock Driver v1.12
Mar 22 01:32:37 kangur Floppy drive(s): fd0 is 1.44M
Mar 22 01:32:37 kangur FDC 0 is a post-1991 82077
Mar 22 01:32:37 kangur Serial: 8250/16550 driver $Revision: 1.90 $ 8 
ports, IRQ sharing disabled
Mar 22 01:32:37 kangur ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar 22 01:32:37 kangur ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Mar 22 01:32:37 kangur pnp: the driver 'serial' has been registered
Mar 22 01:32:37 kangur pnp: match found with the PnP device '00:07' and 
the driver 'serial'
Mar 22 01:32:37 kangur ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar 22 01:32:37 kangur pnp: match found with the PnP device '00:08' and 
the driver 'serial'
Mar 22 01:32:37 kangur ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Mar 22 01:32:37 kangur usb 1-2: modprobe timed out on ep0in
Mar 22 01:32:37 kangur usbcore: registered new driver speedtch
Mar 22 01:32:37 kangur usb 1-2: found stage 1 firmware speedtch-1.bin
Mar 22 01:32:37 kangur usb 1-2: found stage 2 firmware speedtch-2.bin
Mar 22 01:32:39 kangur eth0: link down
Mar 22 01:32:39 kangur eth0: link down
Mar 22 01:32:40 kangur NET: Registered protocol family 10
Mar 22 01:32:40 kangur Disabled Privacy Extensions on device b03e6aa0(lo)
Mar 22 01:32:40 kangur IPv6 over IPv4 tunneling driver
Mar 22 01:32:41 kangur ADSL line is synchronising
Mar 22 01:32:41 kangur init: Entering runlevel: 3
Mar 22 01:32:43 kangur init: Activating demand-procedures for 'A'
Mar 22 01:32:51 kangur eth0: no IPv6 routers present
Mar 22 01:32:53 kangur DSL line goes up
Mar 22 01:32:53 kangur ADSL line is up (768 Kib/s down | 192 Kib/s up)


By the way - since some time I am getting the above

Mar 22 01:32:37 kangur speedtch: Unknown symbol release_firmware

messages on modprobing speedtch in my startup scripts. The message did not 
appeared with 2.6.11 at first (even after some VIA quirk related patches) 
and it is now 100% reproductible. I do not know what is causing it because 
I changed nearly nothing in the system setup. The funniest thing is that 
speedtch still works well. Can anybody say something? Is it harmless or 
what?

And what is this:

Mar 22 01:32:37 kangur usb 1-2: modprobe timed out on ep0in

???


Thanks,

Grzegorz Kulewski

