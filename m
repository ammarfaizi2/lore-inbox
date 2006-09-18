Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751836AbWIRQew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbWIRQew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbWIRQew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:34:52 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:27738 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751836AbWIRQet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:34:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=C7OOR3h4QHeMqYMyuOn5fvOZ7v+DibGBorIayLas8aiSx6R0TpTlJN4pxSdaI3S++GReSqk2fS/W/gbIa92tgzjPf+uISQ8RcXJKjCGGDmwbAoN9aw/zTh9HHKngFa6HgnaU4wXlaeCyOdLaUh5EkmiMmEVxvx7KmoChEqLqBh0=
Message-ID: <450ECA92.1040501@gmail.com>
Date: Tue, 19 Sep 2006 01:34:26 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Emmanuel Benisty <benisty.e@gmail.com>
CC: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: ata_piix: add map 01b for ICH7M & DMA (Intel 945GM Express)
References: <c1f41c620609180826j21b9c9b7r4bb335b81f26ddc2@mail.gmail.com>	 <450EBCBF.5090403@gmail.com> <c1f41c620609180905oc4b526jb41239157404e93a@mail.gmail.com>
In-Reply-To: <c1f41c620609180905oc4b526jb41239157404e93a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[cc'ing lkml]

Emmanuel Benisty wrote:
[--snip--]
> I am really getting strange behaviours on that machine. For example, when
> copying a large file through LAN, the transfert rate is quite low. If
> I run hdparm -tT /dev/sda during the transfert, it will speed up (a
> lot) during the 1st test, slow down to initial speed when the test is
> finished, speed ud for the 2nd test and back again to the slow rate.

That is weird but doesn't seem to be a libata problem.  Can you describe 
in more detail - what method did you use to copy the file?  How low is 
low transfer rate and how high does it get?  What's the result of hdparm 
-tT?  Also, can you try to transfer from /dev/zero and see what happens?

And what other strange behaviors do you see?

I think it might be a scheduler issue or some weird IRQ routing problem 
although not very likely as IRQs are not shared.

I'm leaving full dmesg for lkml readers.

> Linux version 2.6.18-rc7-ARCH (root@blackout) (gcc version 4.1.1) #1 SMP PREEMPT Tue Sep 19 04:40:11 ICT 2006
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001f690000 (usable)
>  BIOS-e820: 000000001f690000 - 000000001f700000 (ACPI NVS)
>  BIOS-e820: 000000001f700000 - 0000000020000000 (reserved)
>  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
>  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
>  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
>  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
> 0MB HIGHMEM available.
> 502MB LOWMEM available.
> found SMP MP-table at 000f5bd0
> On node 0 totalpages: 128656
>   DMA zone: 4096 pages, LIFO batch:0
>   Normal zone: 124560 pages, LIFO batch:31
> DMI present.
> ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f5a30
> ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1f695446
> ACPI: FADT (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x1f69ddee
> ACPI: MADT (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x1f69de62
> ACPI: HPET (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x1f69deca
> ACPI: MCFG (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x1f69df02
> ACPI: TCPA (v001 PTLTD  CALISTGA 0x06040000  PTL 0x00000001) @ 0x1f69df3e
> ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x1f69df70
> ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1f69dfd8
> ACPI: SSDT (v001 SataRe  SataPri 0x00001000 INTL 0x20050624) @ 0x1f696526
> ACPI: SSDT (v001 SataRe  SataSec 0x00001000 INTL 0x20050624) @ 0x1f695e94
> ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20050624) @ 0x1f695492
> ACPI: DSDT (v001 INTEL  CALISTGA 0x06040000 MSFT 0x0100000e) @ 0x00000000
> ACPI: PM-Timer IO Port: 0x1008
> ACPI: Local APIC address 0xfee00000
> ACPI: 2 duplicate APIC table ignored.
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 6:14 APIC version 20
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Processor #1 6:14 APIC version 20
> ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
> ACPI: IOAPIC (id[0x02] address[0xfec28000] gsi_base[24])
> IOAPIC[1]: apic_id 2, version 255, address 0xfec28000, GSI 24-279
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Enabling APIC mode:  Flat.  Using 2 I/O APICs
> ACPI: HPET id: 0x8086a201 base: 0xfed00000
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
> Detected 1729.378 MHz processor.
> Built 1 zonelists.  Total pages: 128656
> Kernel command line: root=/dev/sda6 ro vga=773
> mapped APIC to ffffd000 (fee00000)
> mapped IOAPIC to ffffc000 (fec00000)
> mapped IOAPIC to ffffb000 (fec28000)
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Initializing CPU#0
> PID hash table entries: 2048 (order: 11, 8192 bytes)
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 505396k/514624k available (2257k kernel code, 8640k reserved, 711k data, 228k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Using HPET for base-timer
> Calibrating delay using timer specific routine.. 3463.12 BogoMIPS (lpj=6926250)
> Security Framework v1.0.0 initialized
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
> CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
> monitor/mwait feature present.
> using mwait in idle threads.
> CPU: L1 I cache: 32K, L1 D cache: 32K
> CPU: L2 cache: 2048K
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 0
> CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c189 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> Compat vDSO mapped to ffffe000.
> Checking 'hlt' instruction... OK.
> SMP alternatives: switching to UP code
> ACPI: Core revision 20060707
> CPU0: Intel Genuine Intel(R) CPU           T2250  @ 1.73GHz stepping 08
> SMP alternatives: switching to SMP code
> Booting processor 1/1 eip 3000
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 3458.59 BogoMIPS (lpj=6917180)
> CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
> CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
> monitor/mwait feature present.
> CPU: L1 I cache: 32K, L1 D cache: 32K
> CPU: L2 cache: 2048K
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 1
> CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c189 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#1.
> CPU1: Intel Genuine Intel(R) CPU           T2250  @ 1.73GHz stepping 08
> Total of 2 processors activated (6921.71 BogoMIPS).
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> checking TSC synchronization across 2 CPUs: passed.
> Brought up 2 CPUs
> migration_cost=63
> checking if image is initramfs... it is
> Freeing initrd memory: 599k freed
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: Using MMCONFIG
> Setting up standard PCI resources
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> Boot video device is 0000:00:02.0
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
> PCI: Transparent bridge - 0000:00:1e.0
> PCI: Bus #0b (-#0e) is hidden behind transparent bridge #0a (-#0a) (try 'pci=assign-busses')
> Please report the result to linux-kernel to fix this permanently
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 10 *11)
> ACPI: PCI Interrupt Link [LNKC] (IRQs *10 11)
> ACPI: PCI Interrupt Link [LNKD] (IRQs *10 11)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNKF] (IRQs *10 11)
> ACPI: PCI Interrupt Link [LNKG] (IRQs *10 11)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 10 *11)
> ACPI: Embedded Controller [EC0] (gpe 23) interrupt mode.
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 11 devices
> SCSI subsystem initialized
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> pnp: 00:07: ioport range 0x6a0-0x6af has been reserved
> pnp: 00:07: ioport range 0x6b0-0x6ff has been reserved
> PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
> PCI: Bridge: 0000:00:1c.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1c.1
>   IO window: 2000-2fff
>   MEM window: d8000000-d9ffffff
>   PREFETCH window: d2000000-d3ffffff
> PCI: Bridge: 0000:00:1c.2
>   IO window: 3000-3fff
>   MEM window: da000000-dbffffff
>   PREFETCH window: d4000000-d5ffffff
> PCI: Bus 11, cardbus bridge: 0000:0a:09.0
>   IO window: 00004400-000044ff
>   IO window: 00004800-000048ff
>   PREFETCH window: 30000000-31ffffff
>   MEM window: 32000000-33ffffff
> PCI: Bridge: 0000:00:1e.0
>   IO window: 4000-4fff
>   MEM window: dc000000-dc0fffff
>   PREFETCH window: 30000000-31ffffff
> ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1c.0 to 64
> ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 17
> PCI: Setting latency timer of device 0000:00:1c.1 to 64
> ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
> PCI: Setting latency timer of device 0000:00:1c.2 to 64
> PCI: Enabling device 0000:00:1e.0 (0104 -> 0107)
> PCI: Setting latency timer of device 0000:00:1e.0 to 64
> ACPI: PCI Interrupt 0000:0a:09.0[A] -> GSI 22 (level, low) -> IRQ 19
> NET: Registered protocol family 2
> IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
> TCP established hash table entries: 16384 (order: 5, 196608 bytes)
> TCP bind hash table entries: 8192 (order: 4, 98304 bytes)
> TCP: Hash tables configured (established 16384 bind 8192)
> TCP reno registered
> Simple Boot Flag at 0x36 set to 0x1
> apm: BIOS not found.
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> PCI: Setting latency timer of device 0000:00:1c.0 to 64
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:00:1c.0:pcie00]
> Allocate Port Service[0000:00:1c.0:pcie02]
> Allocate Port Service[0000:00:1c.0:pcie03]
> PCI: Setting latency timer of device 0000:00:1c.1 to 64
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:00:1c.1:pcie00]
> Allocate Port Service[0000:00:1c.1:pcie02]
> Allocate Port Service[0000:00:1c.1:pcie03]
> PCI: Setting latency timer of device 0000:00:1c.2 to 64
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:00:1c.2:pcie00]
> Allocate Port Service[0000:00:1c.2:pcie02]
> Allocate Port Service[0000:00:1c.2:pcie03]
> vesafb: framebuffer at 0xc0000000, mapped to 0xe0080000, using 1536k, total 7872k
> vesafb: mode is 1024x768x8, linelength=1024, pages=9
> vesafb: protected mode interface info at 00ff:44f0
> vesafb: scrolling: redraw
> vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
> Console: switching to colour frame buffer device 128x48
> fb0: VESA VGA frame buffer device
> ACPI: AC Adapter [ADP1] (off-line)
> ACPI: Battery Slot [BAT0] (battery present)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Lid Switch [LID0]
> ACPI: Sleep Button (CM) [SLPB]
> ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
> ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
> ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
> ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
> ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
> ACPI: Thermal Zone [TZS0] (36 C)
> ACPI: Thermal Zone [TZS1] (46 C)
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
> loop: loaded (max 8 devices)
> PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> i8042.c: Detected active multiplexing controller, rev 1.1.
> serio: i8042 AUX0 port at 0x60,0x64 irq 12
> serio: i8042 AUX1 port at 0x60,0x64 irq 12
> serio: i8042 AUX2 port at 0x60,0x64 irq 12
> serio: i8042 AUX3 port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Starting balanced_irq
> Using IPI No-Shortcut mode
> ACPI: (supports S0 S3 S4 S5)
> Time: tsc clocksource has been installed.
> Freeing unused kernel memory: 228k freed
> Time: hpet clocksource has been installed.
> libata version 2.00 loaded.
> ata_piix 0000:00:1f.2: version 2.00
> ata_piix 0000:00:1f.2: MAP [ IDE IDE P1 P3 ]
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 20
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
> scsi0 : ata_piix
> input: AT Translated Set 2 keyboard as /class/input/input0
> ata1.00: ATA-6, max UDMA/100, 156301488 sectors: LBA48 
> ata1.00: ata1: dev 0 multi count 16
> ata1.01: ATAPI, max UDMA/33
> ata1.00: configured for UDMA/33
> ata1.01: configured for UDMA/33
>   Vendor: ATA       Model: HTS541080G9AT00   Rev: MB4O
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: MATSHITA  Model: DVD-RAM UJ-850S   Rev: 1.50
>   Type:   CD-ROM                             ANSI SCSI revision: 05
> ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
> scsi1 : ata_piix
> ATA: abnormal status 0x7F on port 0x177
> Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1a0b1, caps: 0xa04713/0x204000
> input: SynPS/2 Synaptics TouchPad as /class/input/input1
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 sda3 < sda5 sda6 >
> sd 0:0:0:0: Attached scsi disk sda
> sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.20
> sr 0:0:1:0: Attached scsi CD-ROM sr0
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 21
> PCI: Setting latency timer of device 0000:00:1d.7 to 64
> ehci_hcd 0000:00:1d.7: EHCI Host Controller
> ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:1d.7: debug port 1
> PCI: cache line size of 32 is not supported by device 0000:00:1d.7
> ehci_hcd 0000:00:1d.7: irq 21, io mem 0xdc444000
> ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 8 ports detected
> USB Universal Host Controller Interface driver v3.0
> ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 21
> PCI: Setting latency timer of device 0000:00:1d.0 to 64
> uhci_hcd 0000:00:1d.0: UHCI Host Controller
> uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
> uhci_hcd 0000:00:1d.0: irq 21, io base 0x00001820
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> usb 1-6: new high speed USB device using ehci_hcd and address 2
> ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
> PCI: Setting latency timer of device 0000:00:1d.1 to 64
> uhci_hcd 0000:00:1d.1: UHCI Host Controller
> uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
> uhci_hcd 0000:00:1d.1: irq 20, io base 0x00001840
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> usb 1-6: configuration #1 chosen from 1 choice
> ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
> PCI: Setting latency timer of device 0000:00:1d.2 to 64
> uhci_hcd 0000:00:1d.2: UHCI Host Controller
> uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
> uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001860
> usb usb4: configuration #1 chosen from 1 choice
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 17
> PCI: Setting latency timer of device 0000:00:1d.3 to 64
> uhci_hcd 0000:00:1d.3: UHCI Host Controller
> uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
> uhci_hcd 0000:00:1d.3: irq 17, io base 0x00001880
> usb usb5: configuration #1 chosen from 1 choice
> hub 5-0:1.0: USB hub found
> hub 5-0:1.0: 2 ports detected
> Yenta: CardBus bridge found at 0000:0a:09.0 [1025:0080]
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: socket 0000:0a:09.0, mfunc 0x01aa1b22, devctl 0x44
> Real Time Clock Driver v1.12ac
> sdhci: Secure Digital Host Controller Interface driver, 0.12
> sdhci: Copyright(c) Pierre Ossman
> Yenta: ISA IRQ mask 0x0cf8, PCI irq 19
> Socket status: 30000006
> Yenta: Raising subordinate bus# of parent bus (#0a) from #0a to #0e
> pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
> cs: IO port probe 0x4000-0x4fff: clean.
> pcmcia: parent PCI bridge Memory window: 0xdc000000 - 0xdc0fffff
> pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x31ffffff
> ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 20
> sdhci: SDHCI controller found at 0000:0a:01.0 [1180:0822] (rev 19)
> ACPI: PCI Interrupt 0000:0a:01.0[B] -> GSI 21 (level, low) -> IRQ 22
> mmc0: SDHCI at 0xdc000800 irq 22 DMA
> Linux agpgart interface v0.101 (c) Dave Jones
> ieee80211_crypt: registered algorithm 'NULL'
> ieee80211: 802.11 data/management/control stack, git-1.1.13
> ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
> ipw3945: version magic '2.6.18-rc6-ARCH SMP preempt mod_unload 686 REGPARM gcc-4.1' should be '2.6.18-rc7-ARCH SMP preempt mod_unload 686 REGPARM gcc-4.1'
> ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 19
> PCI: Setting latency timer of device 0000:00:1b.0 to 64
> input: PC Speaker as /class/input/input2
> 8139too Fast Ethernet driver 0.9.27
> hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
> cs: IO port probe 0x100-0x3af: excluding 0x370-0x377
> cs: IO port probe 0x3e0-0x4ff: excluding 0x3f0-0x3f7 0x4d0-0x4d7
> cs: IO port probe 0x820-0x8ff: clean.
> cs: IO port probe 0xc00-0xcf7: clean.
> cs: IO port probe 0xa00-0xaff: clean.
> ACPI: PCI Interrupt 0000:0a:07.0[A] -> GSI 23 (level, low) -> IRQ 21
> agpgart: Detected an Intel 945GM Chipset.
> eth0: RealTek RTL8139 at 0xe0034800, 00:16:d3:44:10:a3, IRQ 21
> eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
> agpgart: Detected 7932K stolen memory.
> agpgart: AGP aperture is 256M @ 0xc0000000
> 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
> EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
> EXT3 FS on sda6, internal journal
> ReiserFS: sda5: found reiserfs format "3.6" with standard journal
> ReiserFS: sda5: using ordered data mode
> ReiserFS: sda5: journal params: device sda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> ReiserFS: sda5: checking transaction log (sda5)
> ReiserFS: sda5: Using r5 hash to sort names
> Adding 1710912k swap on /dev/sda2.  Priority:-1 extents:1 across:1710912k
> eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
> NET: Registered protocol family 10
> lo: Disabled Privacy Extensions
> IPv6 over IPv4 tunneling driver
> [drm] Initialized drm 1.0.1 20051102
> ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 17
> [drm] Initialized i915 1.5.0 20060119 on minor 0
> eth0: no IPv6 routers present

-- 
tejun
