Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVFEOV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVFEOV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 10:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVFEOV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 10:21:26 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:18054 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261571AbVFEOUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 10:20:31 -0400
X-Comment: AT&T Maillennium special handling code - c
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Date: Sun, 5 Jun 2005 10:15:33 -0400
User-Agent: KMail/1.8
Cc: john stultz <johnstul@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <200506041440.09795.kernel-stuff@comcast.net> <20050605112840.GX23831@wotan.suse.de>
In-Reply-To: <20050605112840.GX23831@wotan.suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FkwoCQpIdMKCG8p"
Message-Id: <200506051015.33723.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_FkwoCQpIdMKCG8p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 05 June 2005 07:28, Andi Kleen wrote:
> Do you actually use pmtimer? Please send a dmesg log.
>
=46ull dmesg attached - 2.6.12-rc5 seems to use pmtimer.

=46rom 2.6.12-rc5 -
=2D--------------------------------------
Jun  5 10:04:04 tux-gentoo [    0.000000] time.c: Using 3.579545 MHz PM tim=
er.
Jun  5 10:04:04 tux-gentoo [    0.000000] time.c: Detected 797.956 MHz=20
processor.
Jun  5 10:04:04 tux-gentoo [   14.020805] time.c: Using PIT/TSC based=20
timekeeping.

And from 2.6.11-gentoo=20
=2D--------------------------------------
May  3 22:31:03 tux-gentoo time.c: Using 1.193182 MHz PIT timer.
May  3 22:31:03 tux-gentoo time.c: Detected 1994.883 MHz processor.

The differences in PM Timer MHz - is something wrong there? They seem to be=
=20
dependent on processor MHz which is 797 MHz (lowest cpufreq) in 2.6.12-rc5=
=20
and 1994 MHz (Highest cpufreq) on 2.6.11.

> Also note that pmtimer does not even drive the timer interrupt,
> just gettimeofday.

Could it be that the music players use gettimeofday() for time keeping? Sur=
e=20
enough they are broken with -rc5.

Parag

--Boundary-00=_FkwoCQpIdMKCG8p
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dm.out"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dm.out"

id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:4 APIC version 16
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: BIOS IRQ0 pin2 override ignored.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 30000000=
:cff80000)
[    0.000000] Checking aperture...
[    0.000000] CPU 0: aperture @ e8000000 size 128 MB
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: root=3D/dev/hda2 vga=3D0x317 video=3Dve=
safb:ywrap,mtrr
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[    0.000000] time.c: Using 3.579545 MHz PM timer.
[    0.000000] time.c: Detected 797.956 MHz processor.
[   14.020805] time.c: Using PIT/TSC based timekeeping.
[   14.020847] Console: colour dummy device 80x25
[   14.022212] Dentry cache hash table entries: 131072 (order: 8, 1048576 b=
ytes)
[   14.023558] Inode-cache hash table entries: 65536 (order: 7, 524288 byte=
s)
[   14.049027] Memory: 767948k/785856k available (2988k kernel code, 17204k=
 reserved, 1244k data, 184k init)
[   14.049137] Calibrating delay loop... 1581.05 BogoMIPS (lpj=3D790528)
[   14.071862] Mount-cache hash table entries: 256
[   14.072002] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[   14.072014] CPU: L2 Cache: 1024K (64 bytes/line)
[   14.072026] CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
[   14.123727] Using local APIC timer interrupts.
[   14.249130] Detected 12.468 MHz APIC timer.
[   14.249150] testing NMI watchdog ... OK.
[   14.259568] NET: Registered protocol family 16
[   14.259616] PCI: Using configuration type 1
[   14.259625] mtrr: v2.0 (20020519)
[   14.260253] ACPI: Subsystem revision 20050309
[   14.291197] ACPI: Interpreter enabled
[   14.291208] ACPI: Using IOAPIC for interrupt routing
[   14.291937] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   14.291949] PCI: Probing PCI hardware (bus 00)
[   14.293033] Boot video device is 0000:01:00.0
[   14.294186] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   14.296247] ACPI: Embedded Controller [EC0] (gpe 33)
[   14.342234] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
[   14.342704] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP0._PRT]
[   14.343933] ACPI: PCI Interrupt Link [LNK1] (IRQs 16 18 19) *0
[   14.344618] ACPI: PCI Interrupt Link [LNK2] (IRQs 16 18 19) *0
[   14.345313] ACPI: PCI Interrupt Link [LNK3] (IRQs 17) *0
[   14.346004] ACPI: PCI Interrupt Link [LNK4] (IRQs 16 18 19) *0, disabled.
[   14.346689] ACPI: PCI Interrupt Link [LNK5] (IRQs 16 18 19) *0
[   14.347367] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22) *0
[   14.348038] ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *0
[   14.348707] ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *0
[   14.349381] ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *0
[   14.350059] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22) *0, disabled.
[   14.350731] ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22) *0
[   14.351410] ACPI: PCI Interrupt Link [LMCI] (IRQs 20 21 22) *0
[   14.352093] ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22) *0, disabled.
[   14.352781] ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *0, disabled.
[   14.353227] SCSI subsystem initialized
[   14.353305] PCI: Using ACPI for IRQ routing
[   14.353315] PCI: If a device doesn't work, try "pci=3Drouteirq".  If it =
helps, post a report
[   14.353403] TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyb=
erus.ca)
[   14.353462] agpgart: Detected AGP bridge 0
[   14.353476] agpgart: Setting up Nforce3 AGP.
[   14.360612] agpgart: AGP aperture is 128M @ 0xe8000000
[   14.360650] PCI-DMA: Disabling IOMMU.
[   14.362164] Simple Boot Flag at 0x37 set to 0x1
[   14.362362] IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak=
 Exp $
[   14.363662] SGI XFS with ACLs, large block/inode numbers, no debug enabl=
ed
[   14.363826] Initializing Cryptographic API
[   14.363988] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   14.363997] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
[   14.364250] vesafb: framebuffer at 0xf0000000, mapped to 0xffffc20000100=
000, using 3072k, total 65536k
[   14.364268] vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D1
[   14.364276] vesafb: scrolling: redraw
[   14.364285] vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
[   14.379417] Console: switching to colour frame buffer device 128x48
[   14.379519] fb0: VESA VGA frame buffer device
[   14.380896] ACPI: AC Adapter [ACAD] (on-line)
[   14.490704] ACPI: Battery Slot [BAT1] (battery present)
[   14.490808] ACPI: Power Button (FF) [PWRF]
[   14.490882] ACPI: Lid Switch [LID]
[   14.491495] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   14.492706] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   14.503781] ACPI: Thermal Zone [THRM] (49 C)
[   14.527634] Real Time Clock Driver v1.12
[   14.527783] Non-volatile memory driver v1.2
[   14.527858] Linux agpgart interface v0.101 (c) Dave Jones
[   14.527955] [drm] Initialized drm 1.0.0 20040925
[   14.536630] i8042.c: Detected active multiplexing controller, rev 1.1.
[   14.541623] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   14.544230] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   14.544922] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   14.545923] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   14.546620] serio: i8042 KBD port at 0x60,0x64 irq 1
[   14.549091] Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sha=
ring disabled
[   14.553242] ACPI: PCI Interrupt Link [LMCI] enabled at IRQ 22
[   14.555816] ACPI: PCI Interrupt 0000:00:06.1[B] -> Link [LMCI] -> GSI 22=
 (level, low) -> IRQ 22
[   14.558482] io scheduler noop registered
[   14.561096] io scheduler anticipatory registered
[   14.563659] io scheduler deadline registered
[   14.566185] io scheduler cfq registered
[   14.569255] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 =
blocksize
[   14.572139] loop: loaded (max 8 devices)
[   14.574807] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   14.577388] ide: Assuming 33MHz system bus speed for PIO modes; override=
 with idebus=3Dxx
[   14.580068] NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
[   14.582717] Losing some ticks... checking if CPU frequency changed.
[   14.582743] NFORCE3-150: chipset revision 165
[   14.585354] NFORCE3-150: not 100% native mode: will probe irqs later
[   14.587971] NFORCE3-150: BIOS didn't set cable bits correctly. Enabling =
workaround.
[   14.590598] NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
[   14.593207]     ide0: BM-DMA at 0x2080-0x2087, BIOS settings: hda:DMA, h=
db:pio
[   14.595940]     ide1: BM-DMA at 0x2088-0x208f, BIOS settings: hdc:DMA, h=
dd:pio
[   14.598624] Probing IDE interface ide0...
[   14.862207] hda: FUJITSU MHT2060AT PL, ATA DISK drive
[   15.480618] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   15.483282] Probing IDE interface ide1...
[   16.154712] hdc: HL-DT-ST DVD+RW GCA-4040N, ATAPI CD/DVD-ROM drive
[   16.463014] ide1 at 0x170-0x177,0x376 on irq 15
[   16.465842] Probing IDE interface ide2...
[   16.978947] Probing IDE interface ide3...
[   17.491146] Probing IDE interface ide4...
[   18.003347] Probing IDE interface ide5...
[   18.515569] hda: max request size: 128KiB
[   18.589874] hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=3D655=
35/16/63, UDMA(100)
[   18.595599] hda: cache flushes supported
[   18.598307]  hda: hda1 hda2 hda3 hda4
[   18.639056] hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
[   18.641680] Uniform CD-ROM driver Revision: 3.20
[   18.646342] mice: PS/2 mouse device common for all mice
[   18.649010] Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (=
Thu Mar 24 10:33:39 2005 UTC).
[   18.653060] ALSA device list:
[   18.655739]   No soundcards found.
[   18.658428] NET: Registered protocol family 2
[   18.670369] IP: routing cache hash table of 8192 buckets, 64Kbytes
[   18.673378] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes)
[   18.677298] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   18.680836] TCP: Hash tables configured (established 131072 bind 65536)
[   18.683748] NET: Registered protocol family 1
[   18.686579] NET: Registered protocol family 10
[   18.689535] Disabled Privacy Extensions on device ffffffff804d4f40(lo)
[   18.692547] IPv6 over IPv4 tunneling driver
[   18.695622] NET: Registered protocol family 17
[   18.698491] NET: Registered protocol family 15
[   18.702516] powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (ver=
sion 1.00.09e)
[   18.707347] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
[   18.710312] powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0xa (1300 mV)
[   18.713133] powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
[   18.715959] cpu_init done, current fid 0x0, vid 0x12
[   18.723803] ACPI wakeup devices:=20
[   18.730427] USB0 USB1 USB2 PS2K PS2M MAC0=20
[   18.737028] ACPI: (supports S0 S3 S4 S5)
[   18.743579] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[   18.786926] input: AT Translated Set 2 keyboard on isa0060/serio0
[   18.824816] ReiserFS: hda2: found reiserfs format "3.6" with standard jo=
urnal
[   23.626367] ReiserFS: hda2: using ordered data mode
[   23.670621] ReiserFS: hda2: journal params: device hda2, size 8192, jour=
nal first block 18, max trans len 1024, max batch 900, max commit age 30, m=
ax trans age 30
[   23.689259] ReiserFS: hda2: checking transaction log (hda2)
[   23.886849] ReiserFS: hda2: Using r5 hash to sort names
[   23.893548] VFS: Mounted root (reiserfs filesystem) readonly.
[   23.900826] Freeing unused kernel memory: 184k freed
[   32.416092] Adding 2241056k swap on /dev/hda4.  Priority:-1 extents:1
[   50.875537] 8139too Fast Ethernet driver 0.9.27
[   50.890016] ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 19
[   50.890040] ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNK2] -> GSI 19=
 (level, low) -> IRQ 19
[   50.897072] eth0: RealTek RTL8139 at 0xffffc2000004e800, 00:0f:b0:01:01:=
65, IRQ 19
[   50.897082] eth0:  Identified 8139 chip type 'RTL-8101'
[   51.234948] input: PS/2 Generic Mouse on isa0060/serio4
[   59.845023] NTFS driver 2.1.22 [Flags: R/O MODULE].
[   60.530597] NTFS volume version 3.1.
[   60.601686] ReiserFS: hda3: found reiserfs format "3.6" with standard jo=
urnal
[   60.603757] ReiserFS: hda3: using ordered data mode
[   60.604511] ReiserFS: hda3: journal params: device hda3, size 8192, jour=
nal first block 18, max trans len 1024, max batch 900, max commit age 30, m=
ax trans age 30
[   60.608739] ReiserFS: hda3: checking transaction log (hda3)
[   62.319226] ReiserFS: hda3: Using r5 hash to sort names
[   62.584642] usbcore: registered new driver usbfs
[   62.610782] usbcore: registered new driver hub
[   64.290816] eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   72.660618] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 21
[   72.661010] ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUS2] -> GSI 21=
 (level, low) -> IRQ 21
[   72.661192] PCI: Setting latency timer of device 0000:00:02.2 to 64
[   72.661306] ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 USB 2.0
[   72.689419] ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus =
number 1
[   72.689791] ehci_hcd 0000:00:02.2: irq 21, io mem 0xe0004000
[   72.689969] PCI: cache line size of 64 is not supported by device 0000:0=
0:02.2
[   72.690078] ehci_hcd 0000:00:02.2: park 0
[   72.690199] ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, drive=
r 10 Dec 2004
[   72.704293] hub 1-0:1.0: USB hub found
[   72.704640] hub 1-0:1.0: 6 ports detected
[   74.918764] i2c_adapter i2c-0: nForce2 SMBus adapter at 0x2040
[   74.944919] i2c_adapter i2c-1: nForce2 SMBus adapter at 0x2000
[   75.219764] ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) =
Driver (PCI)
[   75.245808] PCI: Enabling device 0000:00:02.0 (0004 -> 0006)
[   75.247239] ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 20
[   75.247379] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 20=
 (level, low) -> IRQ 20
[   75.247553] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   75.247662] ohci_hcd 0000:00:02.0: nVidia Corporation nForce3 USB 1.1
[   75.782732] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus =
number 2
[   75.783105] ohci_hcd 0000:00:02.0: irq 20, io mem 0xe0000000
[   75.927665] hub 2-0:1.0: USB hub found
[   75.928014] hub 2-0:1.0: 3 ports detected
[   75.934011] PCI: Enabling device 0000:00:02.1 (0004 -> 0006)
[   75.935138] ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 22
[   75.935263] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS1] -> GSI 22=
 (level, low) -> IRQ 22
[   75.935431] PCI: Setting latency timer of device 0000:00:02.1 to 64
[   75.935538] ohci_hcd 0000:00:02.1: nVidia Corporation nForce3 USB 1.1 (#=
2)
[   76.527343] ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus =
number 3
[   76.527714] ohci_hcd 0000:00:02.1: irq 22, io mem 0xe0001000
[   77.073071] hub 3-0:1.0: USB hub found
[   77.073424] hub 3-0:1.0: 3 ports detected
[   78.087273] usb 3-1: new low speed USB device using ohci_hcd and address=
 2
[   78.854488] usbcore: registered new driver hiddev
[   78.936150] ACPI: PCI Interrupt Link [LACI] enabled at IRQ 21
[   78.936505] ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 21=
 (level, low) -> IRQ 21
[   78.936687] PCI: Setting latency timer of device 0000:00:06.0 to 64
[   79.035096] input: USB HID v1.11 Mouse [Microsoft Microsoft Wireless Opt=
ical Mouse=AE 1.0A] on usb-0000:00:02.1-1
[   79.035302] usbcore: registered new driver usbhid
[   79.035399] drivers/usb/input/hid-core.c: v2.01:USB HID core driver
[   80.740808] intel8x0_measure_ac97_clock: measured 49384 usecs
[   80.741165] intel8x0: clocking to 47409
[   81.464847] ACPI: PCI Interrupt 0000:00:06.1[B] -> Link [LMCI] -> GSI 22=
 (level, low) -> IRQ 22
[   81.465438] PCI: Setting latency timer of device 0000:00:06.1 to 64
[   81.939052] libata version 1.10 loaded.
[   84.554628] ieee1394: Initialized config rom entry `ip1394'
[   84.609398] ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
[   84.610734] ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 18
[   84.610871] ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNK1] -> GSI 18=
 (level, low) -> IRQ 18
[   84.766166] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[18]  MMIO=3D=
[e0108000-e01087ff]  Max Packet=3D[2048]
[   85.085423] 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
[   86.750731] USB Universal Host Controller Interface driver v2.2
[   87.937108] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[463f0200463f02=
00]
[   88.019837] eth1394: $Rev: 1247 $ Ben Collins <bcollins@debian.org>
[   88.026653] eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
[  104.291844] eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[  108.976114] powernowd[10717]: segfault at 00002aaaaacbe7c3 rip 00002aaaa=
ac03b2e rsp 00007fffff99deb0 error 7
[  130.985451] eth0: no IPv6 routers present
[  356.893427] codec_semaphore: semaphore is not ready [0x1][0x301300]
[  356.893844] codec_read 0: semaphore is not ready for register 0x76
[  356.896684] codec_semaphore: semaphore is not ready [0x1][0x301300]
[  356.896919] codec_read 1: semaphore is not ready for register 0x54

--Boundary-00=_FkwoCQpIdMKCG8p--
