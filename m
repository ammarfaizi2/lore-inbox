Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262887AbVCDMTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbVCDMTy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVCDMSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:18:14 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:51409 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S262911AbVCDLeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:34:06 -0500
Subject: Re: Strange crashes of kernel v2.6.11
From: Steffen Michalke <StMichalke@web.de>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109799292.15072.9.camel@boxen>
References: <1109787428.6828.14.camel@pinky.local>
	 <1109799292.15072.9.camel@boxen>
Content-Type: multipart/mixed; boundary="=-sGGurYT+TYVje10gWQkF"
Date: Fri, 04 Mar 2005 12:33:55 +0100
Message-Id: <1109936036.6712.8.camel@pinky.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sGGurYT+TYVje10gWQkF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Mittwoch, den 02.03.2005, 22:34 +0100 schrieb Alexander Nyberg: 
> > I recently upgraded from linux kernel v2.6.10 to v2.6.11.
> > Some programs like evolution 2.0 and leafnode2 crash the whole system
> > immediatedly now.
> 
> You mean when you run evolution the box hangs up completely? (you can't
> kill X, switch to another console etc.)

Thank you for your hints.

When I looked into that problem recently, I remarked that the system
does not actually crash but is locked totally:

I use the device-mapper modules for encrypting files (loopback devices
with aes-i586-encryption). They can be set up in the usual manner, but
filesystem operations now lock the accessing processes, which cannot be
killed afterwards.
If the kernel has been compiled with preemption the system slows down
considerably after those operations; enabling prempting The Big Kernel
Lock locks the whole system at filesystem access (that looked like a
system crash). That's why I could not find any messages in the logs.

If I use a non-preemptive v2.6.11-kernel (vanilla, by the way) the
system keeps on running the normal way, but every process which tries to
work with files in device-mapped directories is unkillable locked.

It seems to be a problem with the dm-*- or loop-modules.

I enclosed the ouput of dmesg and ver_linux.

Kind regards
Steffen


--=-sGGurYT+TYVje10gWQkF
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Linux version 2.6.11 (root@pinky) (gcc version 3.4.3 (SuSE Linux)) #10 Fri Mar 4 10:14:12 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffd0000 (usable)
 BIOS-e820: 000000001ffd0000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (usable)
 BIOS-e820: 00000000feea0000 - 0000000100000000 (reserved)
512MB LOWMEM available.
found SMP MP-table at 000f7c40
On node 0 totalpages: 131072
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126976 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000e0010
ACPI: RSDT (v001 COMPAQ CPQ0014  0x20001127  0x00000000) @ 0x000e0080
ACPI: FADT (v001 COMPAQ SOLANO   0x00000001  0x00000000) @ 0x000e0130
ACPI: SSDT (v001 COMPAQ CORE_UTL 0x00000001 MSFT 0x0100000d) @ 0x000e0d81
ACPI: SSDT (v001 COMPAQ VILLTBL1 0x00000001 MSFT 0x0100000d) @ 0x000e0ef5
ACPI: SSDT (v001 COMPAQ     FHUB 0x00000001 MSFT 0x0100000d) @ 0x000e2d98
ACPI: MADT (v001 COMPAQ SOLANO   0x00000001  0x00000000) @ 0x000e01a4
ACPI: SSDT (v001 COMPAQ     APIC 0x00000001 MSFT 0x0100000d) @ 0x000e2d22
ACPI: SSDT (v001 COMPAQ       S3 0x00000001 MSFT 0x0100000d) @ 0x000e24c0
ACPI: SSDT (v001 COMPAQ   PIDETM 0x00000001 MSFT 0x0100000d) @ 0x000e2664
ACPI: SSDT (v001 COMPAQ     GTF0 0x00000001 MSFT 0x0100000d) @ 0x000e290a
ACPI: SSDT (v001 COMPAQ   SIDETM 0x00000001 MSFT 0x0100000d) @ 0x000e27b4
ACPI: SSDT (v001 COMPAQ     GTF2 0x00000001 MSFT 0x0100000d) @ 0x000e2b10
ACPI: SSDT (v001 COMPAQ     GTF3 0x00000001 MSFT 0x0100000d) @ 0x000e2c19
ACPI: DSDT (v001 COMPAQ     DSDT 0x00000001 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 20000000:deea0000)
Built 1 zonelists
Kernel command line: root=/dev/ide/host0/bus0/target0/lun0/part3 hdc=ide-cd hdd=ide-cd
ide_setup: hdc=ide-cd
ide_setup: hdd=ide-cd
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 930.391 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 516104k/524288k available (1588k kernel code, 7468k reserved, 629k data, 140k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1839.10 BogoMIPS (lpj=919552)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xe8316, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *9
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
ACPI: PS/2 Keyboard Controller [KBD] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller at PCI slot 0000:00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2460-0x2467, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2468-0x246f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6B200P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SONY CD-RW CRX1611, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG DVD-ROM SD-612, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 398297088 sectors (203928 MB) w/8192KiB Cache, CHS=24792/255/63, UDMA(66)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 140k freed
NET: Registered protocol family 1
Adding 1036184k swap on /dev/ide/host0/bus0/target0/lun0/part2.  Priority:42 extents:1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 440M
agpgart: AGP aperture is 64M @ 0x48000000
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1f.2: Intel Corp. 82801AA USB
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 19, io base 0x2440
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.2: detected 2 ports
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Intel Corp. 82801AA USB
usb usb1: Manufacturer: Linux 2.6.11 uhci_hcd
usb usb1: SerialNumber: 0000:00:1f.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: state 5 ports 2 chg 0006 evt 0007
hub 1-0:1.0: port 1, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
uhci_hcd 0000:00:1f.2: suspend_hc
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
ACPI: PCI interrupt 0000:02:0a.0[A] -> GSI 18 (level, low) -> IRQ 18
natsemi eth0: NatSemi DP8381[56] at 0x40000000 (0000:02:0a.0), 00:a0:cc:78:a1:fc, IRQ 18, port TP.
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X DVD-ROM drive, 512kB Cache, UDMA(33)
SCSI subsystem initialized
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
input: PC Speaker
Real Time Clock Driver v1.12
hdc: DMA disabled
eth0: DSPCFG accepted after 0 usec.
eth0: link up.
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03031c0(lo)
IPv6 over IPv4 tunneling driver
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49028 usecs
intel8x0: clocking to 41136
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
eth0: no IPv6 routers present
loop: loaded (max 8 devices)
ReiserFS: dm-0: warning: read_super_block: found reiserfs format "3.6" with non-standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 512, journal first block 18, max trans len 256, max batch 225, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names

--=-sGGurYT+TYVje10gWQkF
Content-Disposition: attachment; filename=ver_linux
Content-Type: text/plain; name=ver_linux; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux pinky 2.6.11 #10 Fri Mar 4 10:14:12 CET 2005 i686 i686 i386 GNU/Linux
 
Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.91.0.2
util-linux             2.12c
mount                  2.12c
module-init-tools      3.1-pre5
e2fsprogs              1.35
jfsutils               1.1.7
reiserfsprogs          3.6.18
reiser4progs           line
PPP                    2.4.2
isdn4k-utils           3.5
nfs-utils              1.0.6
Linux C Library        x  1 root root 1359489 Oct  2 02:30 /lib/tls/libc.so.6
Dynamic linker (ldd)   2.3.3
Linux C++ Library      6.0.3
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   030
Modules Loaded         aes_i586 loop parport_pc lp parport snd_pcm_oss usblp snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc md5 ipv6 nfs lockd sunrpc rtc pcspkr dm_crypt dm_mod joydev sg scsi_mod ide_cd cdrom natsemi crc32 uhci_hcd intel_agp agpgart hw_random usbcore unix

--=-sGGurYT+TYVje10gWQkF--

