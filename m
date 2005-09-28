Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbVI1E4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVI1E4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 00:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbVI1E4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 00:56:44 -0400
Received: from pool-151-202-105-53.ny325.east.verizon.net ([151.202.105.53]:53174
	"EHLO blaze.homeip.net") by vger.kernel.org with ESMTP
	id S1030187AbVI1E4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 00:56:43 -0400
Date: Wed, 28 Sep 2005 00:56:32 -0400
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ccalica@gmail.com,
       xorg@lists.freedesktop.org
Subject: Re: 2.6.14-rc2-mm1
Message-ID: <20050928045630.GA9960@blazebox.homeip.net>
References: <20050925220037.GA8776@blazebox.homeip.net> <20050925164421.75c734d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <20050925164421.75c734d2.akpm@osdl.org>
X-Mailer: Mutt http://www.mutt.org
X-Operating-System: Slackware 10.2.0
X-Kernel-Version: Linux blaze 2.6.13.2 i686
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 25, 2005 at 04:44:21PM -0700, Andrew Morton wrote:
> Paul Blazejowski <paulb@blazebox.homeip.net> wrote:
> >
> >  Upon quick testing the latest mm kernel it appears there's some kind of
> >  race condition when using dual core cpu esp when using XORG and USB
> >  (although PS2 has same issue) kebyboard rate being too fast.
> >=20
> >  The same behaviour happens on vanilla 2.6.13 kernel. Reporting this al=
so
> >  to XORG list in hopes to help debug this issue.
>=20
> Is it possible to narrow this down a bit further?  Was 2.6.12 OK?
>=20
> If we can identify two reasonably-close-in-time versions either side of t=
he
> regression then the next step would be to run `dmesg -s 1000000' under bo=
th
> kernel versions, then run `diff -u dmesg.good dmesg.bad'.
>=20
>=20

No 2.6.12 is not OK. I don't think there's any regression between the
recent kernels. It just does not work on 3 of them i tried so far.

I am attatching diff from 2.6.12/2.6.13 against 2.6.14-rc2-mm1.

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dm2612-dm2614.diff"
Content-Transfer-Encoding: quoted-printable

--- dm2612	2005-09-26 02:02:15.000000000 -0400
+++ dm2614	2005-09-26 01:16:52.000000000 -0400
@@ -1,4 +1,4 @@
-Linux version 2.6.12.6 (root@blaze) (gcc version 3.3.6) #1 SMP Mon Sep 26 =
01:40:47 EDT 2005
+Linux version 2.6.14-rc2-mm1 (root@blaze) (gcc version 3.3.6) #1 SMP Sun S=
ep 25 17:03:22 EDT 2005
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
@@ -12,9 +12,10 @@
 511MB LOWMEM available.
 found SMP MP-table at 000f5a30
 On node 0 totalpages: 131056
-  DMA zone: 4096 pages, LIFO batch:1
-  Normal zone: 126960 pages, LIFO batch:31
-  HighMem zone: 0 pages, LIFO batch:1
+  DMA zone: 4096 pages, LIFO batch:2
+  DMA32 zone: 0 pages, LIFO batch:2
+  Normal zone: 126960 pages, LIFO batch:64
+  HighMem zone: 0 pages, LIFO batch:2
 DMI 2.3 present.
 ACPI: RSDP (v000 Nvidia                                ) @ 0x000f7dc0
 ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
@@ -42,22 +43,22 @@
 ACPI: IRQ15 used by override.
 Enabling APIC mode:  Flat.  Using 1 I/O APICs
 Using ACPI (MADT) for SMP configuration information
-Allocating PCI resources starting at 20000000 (gap: 20000000:c0000000)
+Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
 Built 1 zonelists
-Kernel command line: root=3D/dev/sda1 ro vmalloc=3D256M console=3DttyS0,57=
600n8 console=3Dtty0 rootflags=3Dquota elevator=3Dcfq vga=3D795
 mapped APIC to ffffd000 (fee00000)
 mapped IOAPIC to ffffc000 (fec00000)
 Initializing CPU#0
-CPU 0 irqstacks, hard=3Dc041a000 soft=3Dc0418000
+Kernel command line: root=3D/dev/sda1 ro vmalloc=3D256M console=3DttyS0,57=
600n8 console=3Dtty0 rootflags=3Dquota elevator=3Dcfq vga=3D795
+CPU 0 irqstacks, hard=3Dc043e000 soft=3Dc043c000
 PID hash table entries: 2048 (order: 11, 32768 bytes)
-Detected 2352.374 MHz processor.
+Detected 2352.758 MHz processor.
 Using tsc for high-res timesource
 Console: colour dummy device 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 515352k/524224k available (2289k kernel code, 8380k reserved, 617k=
 data, 236k init, 0k highmem)
+Memory: 515152k/524224k available (2390k kernel code, 8560k reserved, 662k=
 data, 232k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... O=
k.
-Calibrating delay loop... 4653.05 BogoMIPS (lpj=3D2326528)
+Calibrating delay using timer specific routine.. 4708.36 BogoMIPS (lpj=3D2=
354180)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 000=
00001 00000000 00000003
 CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 0000=
0001 00000000 00000003
@@ -67,41 +68,37 @@
 CPU: After all inits, caps: 178bfbff e3d3fbff 00000000 00000010 00000001 0=
0000000 00000003
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
-Enabling fast FPU save and restore... done.
+mtrr: v2.0 (20020519)
+Enabling fast FPU save and restore... <7>spurious 8259A interrupt: IRQ7.
+done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
 CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
 Booting processor 1/1 eip 2000
-CPU 1 irqstacks, hard=3Dc041b000 soft=3Dc0419000
+CPU 1 irqstacks, hard=3Dc043f000 soft=3Dc043d000
 Initializing CPU#1
-Calibrating delay loop... 4702.20 BogoMIPS (lpj=3D2351104)
+Calibrating delay using timer specific routine.. 4704.69 BogoMIPS (lpj=3D2=
352349)
 CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 000=
00001 00000000 00000003
 CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 0000=
0001 00000000 00000003
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 512K (64 bytes/line)
-CPU 1(2) -> Core 0
+CPU 1(2) -> Core 1
 CPU: After all inits, caps: 178bfbff e3d3fbff 00000000 00000010 00000001 0=
0000000 00000003
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#1.
 CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
-Total of 2 processors activated (9355.26 BogoMIPS).
+Total of 2 processors activated (9413.05 BogoMIPS).
 ENABLING IO-APIC IRQs
 ..TIMER: vector=3D0x31 pin1=3D0 pin2=3D-1
 checking TSC synchronization across 2 CPUs:=20
 CPU#0 had 0 usecs TSC skew, fixed it up.
 CPU#1 had 0 usecs TSC skew, fixed it up.
 Brought up 2 CPUs
-CPU0 attaching sched-domain:
- domain 0: span 3
-  groups: 1 2
-CPU1 attaching sched-domain:
- domain 0: span 3
-  groups: 2 1
 NET: Registered protocol family 16
+ACPI: bus type pci registered
 PCI: PCI BIOS revision 3.00 entry at 0xf2740, last bus=3D5
-PCI: Using configuration type 1
-mtrr: v2.0 (20020519)
-ACPI: Subsystem revision 20050309
+PCI: Using MMCONFIG
+ACPI: Subsystem revision 20050902
 ACPI: Interpreter enabled
 ACPI: Using IOAPIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (0000:00)
@@ -148,12 +145,37 @@
 SCSI subsystem initialized
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a =
report
-pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
-pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
-pnp: 00:00: ioport range 0x4400-0x447f has been reserved
-pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
-pnp: 00:00: ioport range 0x4800-0x487f has been reserved
-pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
+pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
+pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
+pnp: 00:01: ioport range 0x4400-0x447f has been reserved
+pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
+pnp: 00:01: ioport range 0x4800-0x487f has been reserved
+pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
+PCI: Bridge: 0000:00:09.0
+  IO window: 8000-afff
+  MEM window: d0000000-d1ffffff
+  PREFETCH window: 30000000-300fffff
+PCI: Bridge: 0000:00:0b.0
+  IO window: disabled.
+  MEM window: disabled.
+  PREFETCH window: disabled.
+PCI: Bridge: 0000:00:0c.0
+  IO window: disabled.
+  MEM window: disabled.
+  PREFETCH window: disabled.
+PCI: Bridge: 0000:00:0d.0
+  IO window: disabled.
+  MEM window: disabled.
+  PREFETCH window: disabled.
+PCI: Bridge: 0000:00:0e.0
+  IO window: disabled.
+  MEM window: c8000000-cfffffff
+  PREFETCH window: c0000000-c7ffffff
+PCI: Setting latency timer of device 0000:00:09.0 to 64
+PCI: Setting latency timer of device 0000:00:0b.0 to 64
+PCI: Setting latency timer of device 0000:00:0c.0 to 64
+PCI: Setting latency timer of device 0000:00:0d.0 to 64
+PCI: Setting latency timer of device 0000:00:0e.0 to 64
 Total HugeTLB memory allocated, 0
 VFS: Disk quotas dquot_6.5.1
 Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
@@ -165,17 +187,22 @@
 vesafb: protected mode interface info at c000:d620
 vesafb: scrolling: redraw
 vesafb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
+vesafb: Mode is VGA compatible
 Console: switching to colour frame buffer device 160x64
 fb0: VESA VGA frame buffer device
 ACPI: Power Button (FF) [PWRF]
+ACPI: Power Button (CM) [PWRB]
 ACPI: Fan [FAN] (on)
+ACPI: CPU0 (power states: C1[C1])
+ACPI: CPU1 (power states: C1[C1])
 ACPI: Thermal Zone [THRM] (40 C)
 PNP: No PS/2 controller found. Probing ports directly.
 serio: i8042 AUX port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
-Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
+Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
 ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
 ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
+mice: PS/2 mouse device common for all mice
 io scheduler noop registered
 io scheduler anticipatory registered
 io scheduler deadline registered
@@ -194,13 +221,9 @@
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 Probing IDE interface ide1...
 Probing IDE interface ide1...
-Probing IDE interface ide2...
-Probing IDE interface ide3...
-Probing IDE interface ide4...
-Probing IDE interface ide5...
 ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
-ACPI: PCI Interrupt 0000:05:08.0[A] -> Link [APC3] -> GSI 18 (level, low) =
-> IRQ 18
-scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
+ACPI: PCI Interrupt 0000:05:08.0[A] -> Link [APC3] -> GSI 18 (level, low) =
-> IRQ 16
+scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
         <Adaptec 29160 Ultra160 SCSI adapter>
         aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs
=20
@@ -208,15 +231,14 @@
   Type:   CD-ROM                             ANSI SCSI revision: 02
  target0:0:4: Beginning Domain Validation
  target0:0:4: Domain Validation skipping write tests
-(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
+ target0:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
  target0:0:4: Ending Domain Validation
   Vendor: IBM       Model: IC35L036UWD210-0  Rev: S5CQ
   Type:   Direct-Access                      ANSI SCSI revision: 03
 scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
  target0:0:6: Beginning Domain Validation
-WIDTH IS 1
-(scsi0:A:6): 6.600MB/s transfers (16bit)
-(scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
+ target0:0:6: wide asynchronous.
+ target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
  target0:0:6: Ending Domain Validation
 SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
 SCSI device sda: drive cache: write back
@@ -224,22 +246,24 @@
 SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
 Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
-mice: PS/2 mouse device common for all mice
 device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
 NET: Registered protocol family 2
-IP: routing cache hash table of 4096 buckets, 32Kbytes
+IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
 TCP established hash table entries: 32768 (order: 6, 262144 bytes)
 TCP bind hash table entries: 32768 (order: 6, 262144 bytes)
 TCP: Hash tables configured (established 32768 bind 32768)
+TCP reno registered
+TCP bic registered
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 Starting balanced_irq
+Using IPI Shortcut mode
 BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
 XFS mounting filesystem sda1
 Ending clean XFS mount for filesystem: sda1
 VFS: Mounted root (xfs filesystem) readonly.
-Freeing unused kernel memory: 236k freed
-Adding 506008k swap on /dev/sda7.  Priority:-1 extents:1
+Freeing unused kernel memory: 232k freed
+Adding 506008k swap on /dev/sda7.  Priority:-1 extents:1 across:506008k
 Linux agpgart interface v0.101 (c) Dave Jones
 XFS mounting filesystem sda2
 Ending clean XFS mount for filesystem: sda2
@@ -249,35 +273,35 @@
 Ending clean XFS mount for filesystem: sda5
 XFS mounting filesystem sda6
 Ending clean XFS mount for filesystem: sda6
-forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.32.
+forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.41.
 ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
-ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) =
-> IRQ 23
+ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) =
-> IRQ 17
 PCI: Setting latency timer of device 0000:00:0a.0 to 64
 eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
 eth0: no link during initialization.
 eth0: link up.
 ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
-ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level, low) =
-> IRQ 17
-ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level, low) =
-> IRQ 17
+ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level, low) =
-> IRQ 18
+ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level, low) =
-> IRQ 18
 eth1: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
       PrefPort:A  RlmtMode:Check Link State
 ieee1394: Initialized config rom entry `ip1394'
-ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
-ACPI: PCI Interrupt 0000:05:07.2[B] -> Link [APC3] -> GSI 18 (level, low) =
-> IRQ 18
-ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[18]  MMIO=3D[d100f000-d100=
f7ff]  Max Packet=3D[2048]
+ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
+ACPI: PCI Interrupt 0000:05:07.2[B] -> Link [APC3] -> GSI 18 (level, low) =
-> IRQ 16
+ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[16]  MMIO=3D[d100f000-d100=
f7ff]  Max Packet=3D[2048]
 ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
-ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level, low) =
-> IRQ 16
-ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=3D[16]  MMIO=3D[d100d000-d100=
d7ff]  Max Packet=3D[2048]
+ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level, low) =
-> IRQ 19
+ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=3D[19]  MMIO=3D[d100d000-d100=
d7ff]  Max Packet=3D[2048]
 gameport: EMU10K1 is pci0000:05:07.1/gameport0, io 0x8400, speed 1193kHz
-ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, low) =
-> IRQ 17
+ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, low) =
-> IRQ 18
 Installing spdif_bug patch: Audigy 2 Platinum [SB0240P]
-libata version 1.11 loaded.
-sata_nv version 0.6
+libata version 1.12 loaded.
+sata_nv version 0.8
 ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
-ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level, low) =
-> IRQ 22
+ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level, low) =
-> IRQ 20
 PCI: Setting latency timer of device 0000:00:07.0 to 64
-ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 22
-ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 22
+ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 20
+ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 20
 ata1: no device found (phy stat 00000000)
 scsi1 : sata_nv
 ata2: no device found (phy stat 00000000)
@@ -289,13 +313,14 @@
 ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 21
 ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0091065c55]
 ata3: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003 88=
:407f
-ata3: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
+ata3: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
 nv_sata: Primary device added
 nv_sata: Primary device removed
 nv_sata: Secondary device added
 nv_sata: Secondary device removed
 ata3: dev 0 configured for UDMA/133
 scsi3 : sata_nv
+ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d800004f6359]
 ata4: no device found (phy stat 00000000)
 scsi4 : sata_nv
   Vendor: ATA       Model: WDC WD2000JD-00H  Rev: 08.0
@@ -309,35 +334,34 @@
 nv_sata: Secondary device added
 nv_sata: Secondary device removed
  sdb1 sdb2
-ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d800004f6359]
 Attached scsi disk sdb at scsi3, channel 0, id 0, lun 0
 PCI: Enabling device 0000:00:04.0 (0000 -> 0003)
 ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
-ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 20 (level, low) =
-> IRQ 20
+ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 20 (level, low) =
-> IRQ 22
 PCI: Setting latency timer of device 0000:00:04.0 to 64
-intel8x0_measure_ac97_clock: measured 49659 usecs
-intel8x0: clocking to 46738
+intel8x0_measure_ac97_clock: measured 51749 usecs
+intel8x0: clocking to 46867
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
 ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
-ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 23 (level, low) =
-> IRQ 23
+ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 23 (level, low) =
-> IRQ 17
 PCI: Setting latency timer of device 0000:00:02.1 to 64
 ehci_hcd 0000:00:02.1: EHCI Host Controller
 ehci_hcd 0000:00:02.1: debug port 1
 ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
-ehci_hcd 0000:00:02.1: irq 23, io mem 0xfeb00000
+ehci_hcd 0000:00:02.1: irq 17, io mem 0xfeb00000
 PCI: cache line size of 64 is not supported by device 0000:00:02.1
 ehci_hcd 0000:00:02.1: park 0
 ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 10 ports detected
-ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
+ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
 ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
-ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, low) =
-> IRQ 22
+ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, low) =
-> IRQ 20
 PCI: Setting latency timer of device 0000:00:02.0 to 64
 ohci_hcd 0000:00:02.0: OHCI Host Controller
 ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
-ohci_hcd 0000:00:02.0: irq 22, io mem 0xd2004000
+ohci_hcd 0000:00:02.0: irq 20, io mem 0xd2004000
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 10 ports detected
 usb 1-2: new high speed USB device using ehci_hcd and address 2
@@ -356,11 +380,13 @@
 input: USB HID v1.10 Keyboard [Microsoft Natural Keyboard Pro] on usb-0000=
:00:02.0-3.1
 input: USB HID v1.10 Device [Microsoft Natural Keyboard Pro] on usb-0000:0=
0:02.0-3.1
 usbcore: registered new driver usbhid
-drivers/usb/input/hid-core.c: v2.01:USB HID core driver
+drivers/usb/input/hid-core.c: v2.6:USB HID core driver
 Real Time Clock Driver v1.12
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a post-1991 82077
 parport: PnPBIOS parport detected.
 parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,E=
CP,DMA]
-gameport: NS558 PnP Gameport is pnp00:0b/gameport0, io 0x201, speed 917kHz
-USB Universal Host Controller Interface driver v2.2
+gameport: NS558 PnP Gameport is pnp00:0b/gameport0, io 0x201, speed 903kHz
+USB Universal Host Controller Interface driver v2.3
+NET: Registered protocol family 10
+IPv6 over IPv4 tunneling driver

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dm2613-dm2614.diff"
Content-Transfer-Encoding: quoted-printable

--- dm2613	2005-09-26 01:55:34.000000000 -0400
+++ dm2614	2005-09-26 01:16:52.000000000 -0400
@@ -1,4 +1,4 @@
-Linux version 2.6.13.1 (root@blaze) (gcc version 3.3.6) #2 SMP Mon Sep 12 =
13:29:14 EDT 2005
+Linux version 2.6.14-rc2-mm1 (root@blaze) (gcc version 3.3.6) #1 SMP Sun S=
ep 25 17:03:22 EDT 2005
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
@@ -12,9 +12,10 @@
 511MB LOWMEM available.
 found SMP MP-table at 000f5a30
 On node 0 totalpages: 131056
-  DMA zone: 4096 pages, LIFO batch:1
-  Normal zone: 126960 pages, LIFO batch:31
-  HighMem zone: 0 pages, LIFO batch:1
+  DMA zone: 4096 pages, LIFO batch:2
+  DMA32 zone: 0 pages, LIFO batch:2
+  Normal zone: 126960 pages, LIFO batch:64
+  HighMem zone: 0 pages, LIFO batch:2
 DMI 2.3 present.
 ACPI: RSDP (v000 Nvidia                                ) @ 0x000f7dc0
 ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
@@ -42,22 +43,22 @@
 ACPI: IRQ15 used by override.
 Enabling APIC mode:  Flat.  Using 1 I/O APICs
 Using ACPI (MADT) for SMP configuration information
-Allocating PCI resources starting at 20000000 (gap: 20000000:c0000000)
+Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
 Built 1 zonelists
-Kernel command line: root=3D/dev/sda1 ro vmalloc=3D256M console=3DttyS0,57=
600n8 console=3Dtty0 rootflags=3Dquota elevator=3Dcfq vga=3D795
 mapped APIC to ffffd000 (fee00000)
 mapped IOAPIC to ffffc000 (fec00000)
 Initializing CPU#0
-CPU 0 irqstacks, hard=3Dc0469000 soft=3Dc0467000
+Kernel command line: root=3D/dev/sda1 ro vmalloc=3D256M console=3DttyS0,57=
600n8 console=3Dtty0 rootflags=3Dquota elevator=3Dcfq vga=3D795
+CPU 0 irqstacks, hard=3Dc043e000 soft=3Dc043c000
 PID hash table entries: 2048 (order: 11, 32768 bytes)
-Detected 2352.785 MHz processor.
+Detected 2352.758 MHz processor.
 Using tsc for high-res timesource
 Console: colour dummy device 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 514984k/524224k available (2353k kernel code, 8756k reserved, 877k=
 data, 228k init, 0k highmem)
+Memory: 515152k/524224k available (2390k kernel code, 8560k reserved, 662k=
 data, 232k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... O=
k.
-Calibrating delay using timer specific routine.. 4708.36 BogoMIPS (lpj=3D2=
354181)
+Calibrating delay using timer specific routine.. 4708.36 BogoMIPS (lpj=3D2=
354180)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 000=
00001 00000000 00000003
 CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 0000=
0001 00000000 00000003
@@ -68,14 +69,15 @@
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
 mtrr: v2.0 (20020519)
-Enabling fast FPU save and restore... done.
+Enabling fast FPU save and restore... <7>spurious 8259A interrupt: IRQ7.
+done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
 CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
 Booting processor 1/1 eip 2000
-CPU 1 irqstacks, hard=3Dc046a000 soft=3Dc0468000
+CPU 1 irqstacks, hard=3Dc043f000 soft=3Dc043d000
 Initializing CPU#1
-Calibrating delay using timer specific routine.. 4704.68 BogoMIPS (lpj=3D2=
352342)
+Calibrating delay using timer specific routine.. 4704.69 BogoMIPS (lpj=3D2=
352349)
 CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 000=
00001 00000000 00000003
 CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 0000=
0001 00000000 00000003
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
@@ -85,7 +87,7 @@
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#1.
 CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
-Total of 2 processors activated (9413.04 BogoMIPS).
+Total of 2 processors activated (9413.05 BogoMIPS).
 ENABLING IO-APIC IRQs
 ..TIMER: vector=3D0x31 pin1=3D0 pin2=3D-1
 checking TSC synchronization across 2 CPUs:=20
@@ -95,13 +97,12 @@
 NET: Registered protocol family 16
 ACPI: bus type pci registered
 PCI: PCI BIOS revision 3.00 entry at 0xf2740, last bus=3D5
-PCI: Using configuration type 1
-ACPI: Subsystem revision 20050408
+PCI: Using MMCONFIG
+ACPI: Subsystem revision 20050902
 ACPI: Interpreter enabled
 ACPI: Using IOAPIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (0000:00)
 PCI: Probing PCI hardware (bus 00)
-ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
 PCI: Transparent bridge - 0000:00:09.0
 Boot video device is 0000:01:00.0
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
@@ -144,16 +145,16 @@
 SCSI subsystem initialized
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a =
report
-pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
-pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
-pnp: 00:00: ioport range 0x4400-0x447f has been reserved
-pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
-pnp: 00:00: ioport range 0x4800-0x487f has been reserved
-pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
+pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
+pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
+pnp: 00:01: ioport range 0x4400-0x447f has been reserved
+pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
+pnp: 00:01: ioport range 0x4800-0x487f has been reserved
+pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
 PCI: Bridge: 0000:00:09.0
   IO window: 8000-afff
   MEM window: d0000000-d1ffffff
-  PREFETCH window: 20000000-200fffff
+  PREFETCH window: 30000000-300fffff
 PCI: Bridge: 0000:00:0b.0
   IO window: disabled.
   MEM window: disabled.
@@ -175,7 +176,6 @@
 PCI: Setting latency timer of device 0000:00:0c.0 to 64
 PCI: Setting latency timer of device 0000:00:0d.0 to 64
 PCI: Setting latency timer of device 0000:00:0e.0 to 64
-Machine check exception polling timer started.
 Total HugeTLB memory allocated, 0
 VFS: Disk quotas dquot_6.5.1
 Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
@@ -187,6 +187,7 @@
 vesafb: protected mode interface info at c000:d620
 vesafb: scrolling: redraw
 vesafb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
+vesafb: Mode is VGA compatible
 Console: switching to colour frame buffer device 160x64
 fb0: VESA VGA frame buffer device
 ACPI: Power Button (FF) [PWRF]
@@ -201,7 +202,10 @@
 Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
 ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
 ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
+mice: PS/2 mouse device common for all mice
 io scheduler noop registered
+io scheduler anticipatory registered
+io scheduler deadline registered
 io scheduler cfq registered (default)
 RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
@@ -219,20 +223,18 @@
 Probing IDE interface ide1...
 ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
 ACPI: PCI Interrupt 0000:05:08.0[A] -> Link [APC3] -> GSI 18 (level, low) =
-> IRQ 16
-scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
+scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
         <Adaptec 29160 Ultra160 SCSI adapter>
         aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs
=20
   Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
   Type:   CD-ROM                             ANSI SCSI revision: 02
- target0:0:4: asynchronous.
  target0:0:4: Beginning Domain Validation
  target0:0:4: Domain Validation skipping write tests
  target0:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
  target0:0:4: Ending Domain Validation
   Vendor: IBM       Model: IC35L036UWD210-0  Rev: S5CQ
   Type:   Direct-Access                      ANSI SCSI revision: 03
- target0:0:6: asynchronous.
 scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
  target0:0:6: Beginning Domain Validation
  target0:0:6: wide asynchronous.
@@ -244,12 +246,11 @@
 SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
 Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
-mice: PS/2 mouse device common for all mice
 device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
 NET: Registered protocol family 2
 IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
-TCP established hash table entries: 32768 (order: 7, 524288 bytes)
-TCP bind hash table entries: 32768 (order: 6, 393216 bytes)
+TCP established hash table entries: 32768 (order: 6, 262144 bytes)
+TCP bind hash table entries: 32768 (order: 6, 262144 bytes)
 TCP: Hash tables configured (established 32768 bind 32768)
 TCP reno registered
 TCP bic registered
@@ -257,13 +258,12 @@
 NET: Registered protocol family 17
 Starting balanced_irq
 Using IPI Shortcut mode
-swsusp: Suspend partition has wrong signature?
 BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
 XFS mounting filesystem sda1
 Ending clean XFS mount for filesystem: sda1
 VFS: Mounted root (xfs filesystem) readonly.
-Freeing unused kernel memory: 228k freed
-Adding 506008k swap on /dev/sda7.  Priority:-1 extents:1
+Freeing unused kernel memory: 232k freed
+Adding 506008k swap on /dev/sda7.  Priority:-1 extents:1 across:506008k
 Linux agpgart interface v0.101 (c) Dave Jones
 XFS mounting filesystem sda2
 Ending clean XFS mount for filesystem: sda2
@@ -273,7 +273,7 @@
 Ending clean XFS mount for filesystem: sda5
 XFS mounting filesystem sda6
 Ending clean XFS mount for filesystem: sda6
-forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.35.
+forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.41.
 ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
 ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) =
-> IRQ 17
 PCI: Setting latency timer of device 0000:00:0a.0 to 64
@@ -285,10 +285,6 @@
 ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level, low) =
-> IRQ 18
 eth1: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
       PrefPort:A  RlmtMode:Check Link State
-nvidia: module license 'NVIDIA' taints kernel.
-ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 (level, low) =
-> IRQ 16
-PCI: Setting latency timer of device 0000:01:00.0 to 64
-NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7676  Fri Jul 29 =
12:58:54 PDT 2005
 ieee1394: Initialized config rom entry `ip1394'
 ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
 ACPI: PCI Interrupt 0000:05:07.2[B] -> Link [APC3] -> GSI 18 (level, low) =
-> IRQ 16
@@ -300,7 +296,7 @@
 ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, low) =
-> IRQ 18
 Installing spdif_bug patch: Audigy 2 Platinum [SB0240P]
 libata version 1.12 loaded.
-sata_nv version 0.6
+sata_nv version 0.8
 ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
 ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level, low) =
-> IRQ 20
 PCI: Setting latency timer of device 0000:00:07.0 to 64
@@ -317,18 +313,18 @@
 ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 21
 ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0091065c55]
 ata3: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003 88=
:407f
-ata3: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
+ata3: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
 nv_sata: Primary device added
 nv_sata: Primary device removed
 nv_sata: Secondary device added
 nv_sata: Secondary device removed
 ata3: dev 0 configured for UDMA/133
 scsi3 : sata_nv
+ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d800004f6359]
 ata4: no device found (phy stat 00000000)
 scsi4 : sata_nv
   Vendor: ATA       Model: WDC WD2000JD-00H  Rev: 08.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
-ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d800004f6359]
 SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
 SCSI device sdb: drive cache: write back
 SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
@@ -343,14 +339,14 @@
 ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
 ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 20 (level, low) =
-> IRQ 22
 PCI: Setting latency timer of device 0000:00:04.0 to 64
-intel8x0_measure_ac97_clock: measured 50740 usecs
-intel8x0: clocking to 46837
+intel8x0_measure_ac97_clock: measured 51749 usecs
+intel8x0: clocking to 46867
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
 ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
 ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 23 (level, low) =
-> IRQ 17
 PCI: Setting latency timer of device 0000:00:02.1 to 64
-ehci_hcd 0000:00:02.1: nVidia Corporation CK804 USB Controller
+ehci_hcd 0000:00:02.1: EHCI Host Controller
 ehci_hcd 0000:00:02.1: debug port 1
 ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
 ehci_hcd 0000:00:02.1: irq 17, io mem 0xfeb00000
@@ -363,12 +359,12 @@
 ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
 ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, low) =
-> IRQ 20
 PCI: Setting latency timer of device 0000:00:02.0 to 64
-ohci_hcd 0000:00:02.0: nVidia Corporation CK804 USB Controller
+ohci_hcd 0000:00:02.0: OHCI Host Controller
 ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
 ohci_hcd 0000:00:02.0: irq 20, io mem 0xd2004000
-usb 1-2: new high speed USB device using ehci_hcd and address 2
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 10 ports detected
+usb 1-2: new high speed USB device using ehci_hcd and address 2
 hub 1-2:1.0: USB hub found
 hub 1-2:1.0: 4 ports detected
 i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
@@ -384,11 +380,13 @@
 input: USB HID v1.10 Keyboard [Microsoft Natural Keyboard Pro] on usb-0000=
:00:02.0-3.1
 input: USB HID v1.10 Device [Microsoft Natural Keyboard Pro] on usb-0000:0=
0:02.0-3.1
 usbcore: registered new driver usbhid
-drivers/usb/input/hid-core.c: v2.01:USB HID core driver
+drivers/usb/input/hid-core.c: v2.6:USB HID core driver
 Real Time Clock Driver v1.12
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a post-1991 82077
 parport: PnPBIOS parport detected.
 parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,E=
CP,DMA]
-gameport: NS558 PnP Gameport is pnp00:0b/gameport0, io 0x201, speed 917kHz
+gameport: NS558 PnP Gameport is pnp00:0b/gameport0, io 0x201, speed 903kHz
 USB Universal Host Controller Interface driver v2.3
+NET: Registered protocol family 10
+IPv6 over IPv4 tunneling driver

--FL5UXtIhxfXey3p5--

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDOiJ+wu5Nmh3PsiMRAu+jAJ4hEph44YnYK9wdcjdv53KAc3mLAQCffYmv
E0bbKNVT4qwhBTQIeNNLEA0=
=igRQ
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
