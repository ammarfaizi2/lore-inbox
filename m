Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161451AbWKOUyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161451AbWKOUyf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161483AbWKOUyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:54:35 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:11149 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1161451AbWKOUye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:54:34 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: x86-64 with nvidia MCP51 chipset: kernel does not find HPET
Date: Wed, 15 Nov 2006 21:55:17 +0100
User-Agent: KMail/1.9.5
Cc: "Langsdorf, Mark" <mark.langsdorf@amd.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Clemens Ladisch <clemens@ladisch.de>
References: <1449F58C868D8D4E9C72945771150BDF153774@SAUSEXMB1.amd.com> <1162234845.27037.37.camel@mindpipe>
In-Reply-To: <1162234845.27037.37.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4425912.Q4JQ7xCrIu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611152155.21072.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4425912.Q4JQ7xCrIu
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 30 Oktober 2006 20:00 schrieb Lee Revell:
> On Mon, 2006-10-30 at 11:07 -0600, Langsdorf, Mark wrote:
> > > I have a 6 month old x86-64 machine with nvidia MCP51 chipset on which
> > > the kernel does not detect the HPET.  According to HPET maintainer
> > > Clemens Ladisch, this machine certainly has one, but it cannot be
> > > enabled for lack of hardware documentation.
> > >
> > > Is there anything I can do to help debug this?
> >
[...]
> But, with some help from anonymous sources, I have been able to find the
> HPET and make it work using a userspace driver that pokes registers by
> mmap'ing /dev/mem.  So we just need a way to tell the kernel it's there.
> Presumably this would require a PCI quirk.
>
> Is this likely to be worth the trouble?

The new bios 0504 for my Asus M2NPV-VM has an bios option to enable HPET. N=
ow=20
Linux finds it (sorry for kmail line mangling):

diff -u 0405.txt 0504.txt
=2D-- 0405.txt    2006-11-15 21:38:40.000000000 +0100
+++ 0504.txt    2006-11-15 21:48:27.000000000 +0100
@@ -8,19 +8,20 @@
  BIOS-e820: 000000007bef0000 - 000000007bef3000 (ACPI NVS)
  BIOS-e820: 000000007bef3000 - 000000007bf00000 (ACPI data)
  BIOS-e820: 000000007c000000 - 0000000080000000 (reserved)
=2D BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
+ BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 Entering add_active_range(0, 0, 159) 0 entries of 256 used
 Entering add_active_range(0, 256, 507632) 1 entries of 256 used
 end_pfn_map =3D 1048576
=2DDMI 2.3 present.
=2DACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000=
f75e0
=2DACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @=20
0x000000007bef3040
=2DACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @=20
0x000000007bef30c0
=2DACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @=20
0x000000007befb280
=2DACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @=20
0x000000007befb4c0
=2DACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @=20
0x000000007befb1c0
=2DACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @=20
0x0000000000000000
+DMI 2.4 present.
+ACPI: RSDP (v002 Nvidia                                ) @ 0x00000000000f7=
560
+ACPI: XSDT (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @=20
0x000000007bef30c0
+ACPI: FADT (v003 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @=20
0x000000007befb3c0
+ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @=20
0x000000007befb5c0
+ACPI: HPET (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000098) @=20
0x000000007befb800
+ACPI: MCFG (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @=20
0x000000007befb880
+ACPI: MADT (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @=20
0x000000007befb500
+ACPI: DSDT (v001 NVIDIA ASUSACPI 0x00001000 MSFT 0x0100000e) @=20
0x0000000000000000
 Entering add_active_range(0, 0, 159) 0 entries of 256 used
 Entering add_active_range(0, 256, 507632) 1 entries of 256 used
 Zone PFN ranges:
@@ -57,11 +58,12 @@
 ACPI: IRQ14 used by override.
 ACPI: IRQ15 used by override.
 Setting APIC routing to flat
+ACPI: HPET id: 0x10de8201 base: 0xfefff000
 Using ACPI (MADT) for SMP configuration information
 Nosave address range: 000000000009f000 - 00000000000a0000
 Nosave address range: 00000000000a0000 - 00000000000f0000
 Nosave address range: 00000000000f0000 - 0000000000100000
=2DAllocating PCI resources starting at 88000000 (gap: 80000000:70000000)
+Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
 PERCPU: Allocating 32128 bytes of per cpu data
 Built 1 zonelists.  Total pages: 499166
 Kernel command line: root=3D/dev/sda5 init=3D/sbin/initng enable_8254_time=
r lapic
@@ -70,8 +72,8 @@
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
 Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
=2DMemory: 1993004k/2030528k available (3612k kernel code, 36784k reserved,=
=20
1435k data, 236k init)
=2DCalibrating delay using timer specific routine.. 4010.44 BogoMIPS=20
(lpj=3D2005221)
+Memory: 1993004k/2030528k available (3612k kernel code, 36788k reserved,=20
1435k data, 236k init)
+Calibrating delay using timer specific routine.. 4012.35 BogoMIPS=20
(lpj=3D2006178)
 Mount-cache hash table entries: 256
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 512K (64 bytes/line)
@@ -80,11 +82,11 @@
 Freeing SMP alternatives: 28k freed
 ACPI: Core revision 20060707
 Using local APIC timer interrupts.
=2Dresult 12526481
=2DDetected 12.526 MHz APIC timer.
+result 12528046
+Detected 12.528 MHz APIC timer.
 Booting processor 1/2 APIC 0x1
 Initializing CPU#1
=2DCalibrating delay using timer specific routine.. 4007.76 BogoMIPS=20
(lpj=3D2003881)
+Calibrating delay using timer specific routine.. 4008.33 BogoMIPS=20
(lpj=3D2004167)
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 512K (64 bytes/line)
 CPU: Physical Processor ID: 0
@@ -94,13 +96,12 @@
 CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 507 cycles)
 Brought up 2 CPUs
 testing NMI watchdog ... OK.
=2DDisabling vsyscall due to use of PM timer
=2Dtime.c: Using 3.579545 MHz WALL PM GTOD PM timer.
=2Dtime.c: Detected 2004.237 MHz processor.
=2Dmigration_cost=3D215
+time.c: Using 25.000000 MHz WALL HPET GTOD HPET timer.
+time.c: Detected 2004.485 MHz processor.
+migration_cost=3D193
 NET: Registered protocol family 16
 ACPI: bus type pci registered
=2DPCI: Using MMCONFIG at f0000000
+PCI: Using MMCONFIG at e0000000
 PCI: No mmconfig possible on device 00:18
 ACPI: Interpreter enabled
 ACPI: Using IOAPIC for interrupt routing
@@ -153,13 +154,15 @@
 ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
 Linux Plug and Play Support v0.97 (c) Adam Belay
 pnp: PnP ACPI init
=2Dpnp: PnP ACPI: found 16 devices
+pnp: PnP ACPI: found 17 devices
 SCSI subsystem initialized
 usbcore: registered new interface driver usbfs
 usbcore: registered new interface driver hub
 usbcore: registered new device driver usb
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a=
=20
report
+hpet0: at MMIO 0xfefff000, IRQs 2, 8, 31
+hpet0: 3 32-bit timers, 25000000 Hz
 pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
 pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
 pnp: 00:01: ioport range 0x4400-0x447f has been reserved
@@ -228,13 +231,14 @@
 ACPI: Thermal Zone [THRM] (40 C)
 lp: driver loaded but no devices found
 Real Time Clock Driver v1.12ac
+hpet_resources: 0xfefff000 is busy
 Non-volatile memory driver v1.2
 Software Watchdog Timer: 0.07 initialized. soft_noboot=3D0 soft_margin=3D6=
0 sec=20
(nowayout=3D 0)
 Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
 serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
 serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
=2D00:07: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
=2D00:08: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
+00:08: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
+00:09: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
 parport: PnPBIOS parport detected.
 parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
 lp0: using parport0 (interrupt-driven).

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart4425912.Q4JQ7xCrIu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFW365xU2n/+9+t5gRAvG3AJ9C2dVjsyhk/jleCzzcJdnY99XBBACg/My9
orgLthNg3iBjTpegb760S5g=
=cdY6
-----END PGP SIGNATURE-----

--nextPart4425912.Q4JQ7xCrIu--
