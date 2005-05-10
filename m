Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVEJOgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVEJOgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 10:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVEJOgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 10:36:42 -0400
Received: from [195.23.16.24] ([195.23.16.24]:35776 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261620AbVEJOfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 10:35:04 -0400
Message-ID: <4280C68D.9010803@grupopie.com>
Date: Tue, 10 May 2005 15:34:53 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc4: IRQ14 nobody cared
References: <Pine.LNX.4.58.0505062245160.2233@ppc970.osdl.org>	 <427F6F00.9030305@grupopie.com> <58cb370e050509074352e98f6a@mail.gmail.com> <427F9FA2.30506@grupopie.com>
In-Reply-To: <427F9FA2.30506@grupopie.com>
Content-Type: multipart/mixed;
 boundary="------------050603080905050502040608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050603080905050502040608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paulo Marques wrote:
> Bartlomiej Zolnierkiewicz wrote:
>>
>> Perhaps you can try first -rc3 git snapshot (still a lot of stuff):
>> http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.12-rc3-git1.bz2 
> 
> I tried this version with the same results.
> 
> [...]
> so that first "if" statement translates to
> 
>  >     } else if (strncmp(str, "PCI", 3) == 0) {
> 
> which should be always valid for "PCI   ", and that message should never 
> appear :(
> 
> Well, sorry about the noise, I must dig deeper now...

Well, I've dug deeper now. It seems that having "acpi=ht" disables acpi 
in 2.6.12-rc4, but not on 2.6.12-rc3.

Looking at the code it seems that it should have been disabled even on 
2.6.12-rc3.

I've attached the dmesg from 2.6.12-rc3, 2.6.12-rc4 with "acpi=ht" 
(which fails to boot) and 2.6.12-rc4 without any "acpi=" on the command 
line.

It seems to be running smoothly now. I know now that I shouldn't have 
used "acpi=ht", but why did it work on previous kernels?

Even more, the kernel with "acpi=ht" seems out of control, like it has 
some memory overwrite problems. Symptoms include the error "Unknown 
bustype PCI    - ignoring", and a lot of other strange errors ("unknown 
bus type 0.", "PCI BIOS passed nonexistent PCI bus 0!", etc.).

-- 
Paulo Marques - www.grupopie.com

An expert is a person who has made all the mistakes that can be
made in a very narrow field.
Niels Bohr (1885 - 1962)

--------------050603080905050502040608
Content-Type: text/plain;
 name="output-2.6.12-rc3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="output-2.6.12-rc3"

Linux version 2.6.12-rc3 (pmarques@pmarqueslinux) (gcc version 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #5 SMP Thu May 5 12:34:41 WEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
 BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
 BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 130864
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126768 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000f9ea0
ACPI: XSDT (v001 A M I  OEMXSDT  0x08000305 MSFT 0x00000097) @ 0x1ff30100
ACPI: FADT (v003 A M I  OEMFACP  0x08000305 MSFT 0x00000097) @ 0x1ff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x08000305 MSFT 0x00000097) @ 0x1ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x08000305 MSFT 0x00000097) @ 0x1ff40040
ACPI: DSDT (v001  P4P8S P4P8S007 0x00000007 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  Product ID:  APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 20000000 (gap: 20000000:dfb80000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2612rc3 ro root=302 devfs=mount splash=silent acpi=ht resume=/dev/hda1
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2798.936 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514192k/523456k available (2052k kernel code, 8708k reserved, 970k data, 312k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5554.17 BogoMIPS (lpj=2777088)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay loop... 5586.94 BogoMIPS (lpj=2793472)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (11141.12 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0 attaching sched-domain:
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1 attaching sched-domain:
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
ASUS P4P800 detected. Disabling PnPBIOS
PnPBIOS: Disabled
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:1d.3[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1d.7[D] -> IRQ 23
PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:1f.5[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:02:05.0[A] -> IRQ 22
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
Total HugeTLB memory allocated, 0
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
vesafb: framebuffer at 0xe8000000, mapped to 0xe0880000, using 1875k, total 131072k
vesafb: mode is 800x600x16, linelength=1600, pages=135
vesafb: protected mode interface info at c000:54b5
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xe080ec00, 00:0c:6e:b5:15:91, IRQ 22
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC35L120AVV207-1, ATA DISK drive
hdb: SAMSUNG CD-ROM SC-152L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 1024KiB
hda: 241254720 sectors (123522 MB) w/7965KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at eisa.0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 7, 524288 bytes)
TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Starting balanced_irq
swsusp: Suspend partition has wrong signature?
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
devfs_mk_dev: could not append to parent for md/0
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
input: AT Translated Set 2 keyboard on isa0060/serio0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 312k freed
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
ts: Compaq touchscreen protocol output
Real Time Clock Driver v1.12
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000eec0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ef00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ef20
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000ef40
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfebff800
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
EXT3 FS on hda2, internal journal
Adding 811240k swap on /dev/hda1.  Priority:-1 extents:1
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
hdb: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
NET: Registered protocol family 17
eth0: link up, 100Mbps, half-duplex, lpa 0x40A1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 50175 usecs
intel8x0: clocking to 48000
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03b2e20(lo)
IPv6 over IPv4 tunneling driver
[drm] Initialized drm 1.0.0 20040925
[drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 SE]
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
lp0: using parport0 (polling).
lp0: console ready
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
SCSI subsystem initialized
st: Version 20050312, fixed bufsize 32768, s/g segs 256
eth0: no IPv6 routers present

--------------050603080905050502040608
Content-Type: text/plain;
 name="output-2.6.12-rc4-ht"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="output-2.6.12-rc4-ht"

Linux version 2.6.12-rc4 (pmarques@pmarqueslinux) (gcc version 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #23 SMP Tue May 10 13:14:35 WEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
 BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
 BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000ff780
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  Product ID:  APIC at: 0xFEE00000
Unknown bustype PCI    - ignoring
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 20000000 (gap: 20000000:dfb80000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2612rc4 ro root=302 devfs=mount console=ttyS0 splash=silent acpi=ht resume=/dev/hda1
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2798.936 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514188k/523456k available (2052k kernel code, 8712k reserved, 970k data, 316k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Booting processor 1/1 eip 3000
Initializing CPU#1
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (11124.73 BogoMIPS).
ENABLING IO-APIC IRQs
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
..TIMER: vector=0x31 pin1=-1 pin2=-1
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
unknown bus type 0.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
ASUS P4P800 detected. Disabling PnPBIOS
PnPBIOS: Disabled
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:02:05.0[A] -> IRQ 22
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
Total HugeTLB memory allocated, 0
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
vesafb: framebuffer at 0xe8000000, mapped to 0xe0880000, using 1875k, total 131072k
vesafb: mode is 800x600x16, linelength=1600, pages=135
vesafb: protected mode interface info at c000:54b5
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xe080ec00, 00:0c:6e:b5:15:91, IRQ 22
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI BIOS passed nonexistent PCI bus 0!
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L120AVV207-1, ATA DISK drive
hdb: SAMSUNG CD-ROM SC-152L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
irq 14: nobody cared!
 [<c0104023>] dump_stack+0x17/0x19
 [<c013f483>] __report_bad_irq+0x27/0x83
 [<c013f577>] note_interrupt+0x75/0x92
 [<c013f013>] __do_IRQ+0x129/0x136
 [<c010553e>] do_IRQ+0x26/0x3b
 [<c0103ae2>] common_interrupt+0x1a/0x20
 [<c01010cf>] cpu_idle+0x42/0x7e
 [<c03f68db>] start_kernel+0x16f/0x1a9
 [<c010020e>] 0xc010020e
handlers:
[<c027a93f>] (ide_intr+0x0/0x149)
Disabling IRQ #14
hda: max request size: 1024KiB
hda: lost interrupt

--------------050603080905050502040608
Content-Type: text/plain;
 name="output-2.6.12-rc4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="output-2.6.12-rc4"

Linux version 2.6.12-rc4 (pmarques@pmarqueslinux) (gcc version 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #26 SMP Tue May 10 15:05:04 WEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
 BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
 BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 130864
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126768 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000f9ea0
ACPI: XSDT (v001 A M I  OEMXSDT  0x08000305 MSFT 0x00000097) @ 0x1ff30100
ACPI: FADT (v003 A M I  OEMFACP  0x08000305 MSFT 0x00000097) @ 0x1ff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x08000305 MSFT 0x00000097) @ 0x1ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x08000305 MSFT 0x00000097) @ 0x1ff40040
ACPI: DSDT (v001  P4P8S P4P8S007 0x00000007 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 20000000:dfb80000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2612rc4 ro root=302 devfs=mount
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2798.903 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514188k/523456k available (2052k kernel code, 8712k reserved, 970k data, 316k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5537.79 BogoMIPS (lpj=2768896)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay loop... 5586.94 BogoMIPS (lpj=2793472)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (11124.73 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0 attaching sched-domain:
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1 attaching sched-domain:
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
ASUS P4P800 detected. Disabling PnPBIOS
PnPBIOS: Disabled
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:09: ioport range 0x680-0x6ff has been reserved
pnp: 00:09: ioport range 0x290-0x297 has been reserved
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
Total HugeTLB memory allocated, 0
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
vesafb: framebuffer at 0xe8000000, mapped to 0xe0880000, using 1875k, total 131072k
vesafb: mode is 800x600x16, linelength=1600, pages=135
vesafb: protected mode interface info at c000:54b5
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
eth0: RealTek RTL8139 at 0xe0804c00, 00:0c:6e:b5:15:91, IRQ 22
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC35L120AVV207-1, ATA DISK drive
hdb: SAMSUNG CD-ROM SC-152L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 1024KiB
hda: 241254720 sectors (123522 MB) w/7965KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at eisa.0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 7, 524288 bytes)
TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Starting balanced_irq
swsusp: Suspend partition has wrong signature?
ACPI wakeup devices: 
P0P4 MC97 USB1 USB2 USB3 USB4 EUSB PS2K PS2M ILAN 
ACPI: (supports S0 S1 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
devfs_mk_dev: could not append to parent for md/0
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
input: AT Translated Set 2 keyboard on isa0060/serio0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 316k freed
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
ts: Compaq touchscreen protocol output
Real Time Clock Driver v1.12
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000eec0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ef00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ef20
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000ef40
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfebff800
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
EXT3 FS on hda2, internal journal
Adding 811240k swap on /dev/hda1.  Priority:-1 extents:1
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
hdb: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
NET: Registered protocol family 17
eth0: link up, 100Mbps, half-duplex, lpa 0x40A1
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49183 usecs
intel8x0: clocking to 48000
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03b2e20(lo)
IPv6 over IPv4 tunneling driver
lp0: using parport0 (interrupt-driven).
lp0: console ready
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 SE]
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
SCSI subsystem initialized
st: Version 20050312, fixed bufsize 32768, s/g segs 256
eth0: no IPv6 routers present

--------------050603080905050502040608--
