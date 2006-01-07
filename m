Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422818AbWAMSrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422818AbWAMSrb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422820AbWAMSrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:47:31 -0500
Received: from nsm.pl ([62.111.143.37]:11014 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1422818AbWAMSr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:47:29 -0500
Date: Sat, 7 Jan 2006 14:16:33 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060107131633.GB9197@irc.pl>
References: <200601041200.03593.kernel@kolivas.org> <20060105175821.GA4010@irc.pl> <200601061022.46026.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <200601061022.46026.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: multipart/mixed; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2006 at 10:22:45AM +1100, Con Kolivas wrote:
> On Fri, 6 Jan 2006 04:58 am, Tomasz Torcz wrote:
> > On Wed, Jan 04, 2006 at 12:00:00PM +1100, Con Kolivas wrote:
> > > Added:
> > >  +2.6.15-dynticks-060101.patch
> >
> >   On practically unused (booted and logged in into GNOME, one terminal
> > emulator, clock gdesklet ticking) desktop system -- Sempron 2500+,
> > pmstats show between 450 and 600 Hz. Is this normal?
>=20
> Chances are your hardware is one that doesn't play well with dynticks the=
n.=20

  Let me elaborate. Hardware is desktop system, nforce2 chipset based
UP motherboard. CPU is Sempron 2500+. SATA disk, matrox card with fbcon,
Intel e1000 networking.

> Compile in the timer info and use the timertop utility to see if there re=
ally=20
> is something increasing your timer activity to 450HZ and if there isn't t=
hen=20
> it's a problem with dynticks and your hardware. This is the problem I'm=
=20
> currently seeing on SMP configs (too many HZ) and I have yet to figure ou=
t=20
> what it is about the IO APIC that makes this happen.

 Typical output look like:

 Timer Top v 0.9.8
 Ticks:  470      Period: 1 s (Up/Dn)      Skip Low Hz(z): Y      Clear(c)
 PID           Command   Freq(Hz)   Count           Function       Address=
=20
10946          timertop        1       14   process_timeout        c0121e08
 4480   netspeed_applet        1       52   process_timeout        c0121e08
 4132        gam_server       35     2011   process_timeout        c0121e08
 4321            python       47     2751   process_timeout        c0121e08
 5614             mrxvt        1      196   process_timeout        c0121e08
 4486              mono        9      531   process_timeout        c0121e08
 3605                 X       16     1137   it_real_fn             c011deff
 4463     mixer_applet2       10      526   process_timeout        c0121e08
   18                --        4      210   (module)               e2a3409b
 9936              ekg2        2      104   process_timeout        c0121e08
 5257             mrxvt        3      175   process_timeout        c0121e08
    0                 -        3      250   i8042_timer_func       c0230f2b
10139         powernowd        1       56   process_timeout        c0121e08
    0                 -        1       10   (module)               c1a13ed0
10705             mrxvt        2      168   process_timeout        c0121e08
 4485   multiload-apple        3      190   process_timeout        c0121e08
 5194        postmaster        4      290   process_timeout        c0121e08
    0                 -        2      126   (module)               cf85af40
    0                 -        1       46   neigh_periodic_time    c02a474a
 3511              ntpd        1       54   it_real_fn             c011deff
 4561              mono        2      108   process_timeout        c0121e08
    3        watchdog/0        1       56   process_timeout        c0121e08
 5247              tail        1       57   process_timeout        c0121e08

  gam_server uses inotify, but regardless polls some socket very
frequently. Python process is driving gDesklets, two of them are
updating every second -- a clock and disk bandwidth meter. mixer_applet
is doing someting stupid, but GNOME developers are aware of problem.

  I'm attaching:
  - dmesg from vanilla 2.6.15
  - dmesg from 2.6.15-ck1
  - .config from 2.6.15-ck1

  Hope this helps somehow to locate the problem.

--=20
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."


--1UWUbFP1cBYEclgG
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.6.15"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.15 (zdzichu@mother) (gcc version 3.4.5) #50 Tue Jan 3 15:=
46:54 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 126960 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x000f6b00
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff79c0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: ro resume=3D/dev/sda2 video=3Dmatroxfb:vesa:0x11A
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc0408000 soft=3Dc0407000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1747.095 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513972k/524224k available (2114k kernel code, 9696k reserved, 788k =
data, 172k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3497.64 BogoMIPS (lpj=3D69=
95291)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 0000=
0000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000=
000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000020 00000000 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: AMD Sempron(tm) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 apic1=3D0 pin1=3D0 apic2=3D-1 pin2=3D-1
checking if image is initramfs... it is
Freeing initrd memory: 1380k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=3D2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
Boot video device is 0000:02:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APCE] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Generic PHY: Registered new driver
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
PCI: Bridge: 0000:00:08.0
  IO window: 9000-afff
  MEM window: e9000000-eaffffff
  PREFETCH window: 30000000-300fffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: e6000000-e8ffffff
  PREFETCH window: e4000000-e5ffffff
PCI: Setting latency timer of device 0000:00:08.0 to 64
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1136538385.208:1): initialized
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [APC4] -> GSI 19 (level, high) =
-> IRQ 16
matroxfb: Matrox G550 detected
PInS memtype =3D 5
matroxfb: MTRR's turned on
matroxfb: 1280x1024x16bpp (virtual: 1280x6553)
matroxfb: framebuffer at 0xE4000000, mapped to 0xe0880000, size 33554432
Console: switching to colour frame buffer device 160x64
fb0: MATROX frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (32 C)
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
LXT970: Registered new driver
LXT971: Registered new driver
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: _NEC DVD_RW ND-3540A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
sata_sil 0000:01:0b.0: version 0.9
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [APC3] -> GSI 18 (level, high) =
-> IRQ 17
ata1: SATA max UDMA/100 cmd 0xE081C080 ctl 0xE081C08A bmdma 0xE081C000 irq =
17
ata2: SATA max UDMA/100 cmd 0xE081C0C0 ctl 0xE081C0CA bmdma 0xE081C008 irq =
17
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:=
207f
ata1: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata1(0): applying Seagate errata fix
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
mice: PS/2 mouse device common for all mice
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07 13:3=
0:21 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 5, 131072 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
ip_conntrack version 2.4 (4095 buckets, 32760 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
powernow-k8: Processor cpuid 681 not supported
Using IPI Shortcut mode
ACPI wakeup devices:=20
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1=20
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 172k freed
ReiserFS: dm-3: found reiserfs format "3.6" with standard journal
ReiserFS: dm-3: using ordered data mode
ReiserFS: dm-3: journal params: device dm-3, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-3: checking transaction log (dm-3)
ReiserFS: dm-3: Using r5 hash to sort names
Adding 996020k swap on /dev/sda2.  Priority:2 extents:1 across:996020k
cdrom: open failed.
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
cpufreq: Detected nForce2 chipset revision C1
cpufreq: FSB changing is maybe unstable and can lead to crashes and data lo=
ss.
cpufreq: FSB currently at 165 MHz, FID 10.5
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
cdrom: open failed.
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
ReiserFS: dm-2: found reiserfs format "3.6" with standard journal
ReiserFS: dm-2: using journaled data mode
ReiserFS: dm-2: journal params: device dm-2, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-2: checking transaction log (dm-2)
ReiserFS: dm-2: Using r5 hash to sort names

--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.6.15-ck1"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.15-ck1 (zdzichu@mother) (gcc version 3.4.5) #51 Thu Jan 5=
 18:40:03 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 126960 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x000f6b00
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff79c0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: ro resume=3D/dev/sda2 video=3Dmatroxfb:vesa:0x11A
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc040a000 soft=3Dc0409000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Using 3579 PM timer ticks per jiffy=20
Detected 1747.251 MHz processor.
Using pmtmr for high-res timesource
dyn-tick: Found suitable timer: pmtmr
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513964k/524224k available (2118k kernel code, 9704k reserved, 792k =
data, 172k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3496.14 BogoMIPS (lpj=3D17=
48073)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 0000=
0000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000=
000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000020 00000000 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: AMD Sempron(tm) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 apic1=3D0 pin1=3D0 apic2=3D-1 pin2=3D-1
checking if image is initramfs... it is
Freeing initrd memory: 1380k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=3D2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
Boot video device is 0000:02:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APCE] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Generic PHY: Registered new driver
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
PCI: Bridge: 0000:00:08.0
  IO window: 9000-afff
  MEM window: e9000000-eaffffff
  PREFETCH window: 30000000-300fffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: e6000000-e8ffffff
  PREFETCH window: e4000000-e5ffffff
PCI: Setting latency timer of device 0000:00:08.0 to 64
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1136633499.911:1): initialized
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [APC4] -> GSI 19 (level, high) =
-> IRQ 16
matroxfb: Matrox G550 detected
PInS memtype =3D 5
matroxfb: MTRR's turned on
matroxfb: 1280x1024x16bpp (virtual: 1280x6553)
matroxfb: framebuffer at 0xE4000000, mapped to 0xe0880000, size 33554432
Console: switching to colour frame buffer device 160x64
fb0: MATROX frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (31 C)
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
LXT970: Registered new driver
LXT971: Registered new driver
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: _NEC DVD_RW ND-3540A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
sata_sil 0000:01:0b.0: version 0.9
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [APC3] -> GSI 18 (level, high) =
-> IRQ 17
ata1: SATA max UDMA/100 cmd 0xE081C080 ctl 0xE081C08A bmdma 0xE081C000 irq =
17
ata2: SATA max UDMA/100 cmd 0xE081C0C0 ctl 0xE081C0CA bmdma 0xE081C008 irq =
17
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:=
207f
ata1: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata1(0): applying Seagate errata fix
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
mice: PS/2 mouse device common for all mice
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07 13:3=
0:21 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 5, 131072 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
ip_conntrack version 2.4 (4095 buckets, 32760 max) - 212 bytes per conntrack
input: AT Translated Set 2 keyboard as /class/input/input0
ip_tables: (C) 2000-2002 Netfilter core team
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
powernow-k8: Processor cpuid 681 not supported
Using IPI Shortcut mode
dyn-tick: Disabling APIC timer, using PIT reprogramming
dyn-tick: Maximum ticks to skip limited to 54
dyn-tick: Enabling dynamic tick timer v060101
ACPI wakeup devices:=20
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1=20
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 172k freed
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ReiserFS: dm-3: found reiserfs format "3.6" with standard journal
ReiserFS: dm-3: using ordered data mode
ReiserFS: dm-3: journal params: device dm-3, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-3: checking transaction log (dm-3)
ReiserFS: dm-3: Using r5 hash to sort names
Adding 996020k swap on /dev/sda2.  Priority:2 extents:1 across:996020k
cdrom: open failed.
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
cpufreq: Detected nForce2 chipset revision C1
cpufreq: FSB changing is maybe unstable and can lead to crashes and data lo=
ss.
cpufreq: FSB currently at 166 MHz, FID 10.5
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
cdrom: open failed.
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
ReiserFS: dm-2: found reiserfs format "3.6" with standard journal
ReiserFS: dm-2: using journaled data mode
ReiserFS: dm-2: journal params: device dm-2, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-2: checking transaction log (dm-2)
ReiserFS: dm-2: Using r5 hash to sort names

--1UWUbFP1cBYEclgG--

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFDv78xThhlKowQALQRAqyJAJ0Wawb+7IROUsSpGeVpOwUsdRoOggCeJpnW
2lVqzlM6G5fRGRDaDJ0XDgc=
=cbJE
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
