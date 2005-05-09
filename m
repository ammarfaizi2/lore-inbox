Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVEIKy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVEIKy3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 06:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVEIKyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 06:54:25 -0400
Received: from mail.gmx.de ([213.165.64.20]:54668 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261228AbVEIKx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 06:53:27 -0400
X-Authenticated: #153925
From: Bernd Paysan <bernd.paysan@gmx.de>
To: suse-amd64@suse.com
Subject: Re: [suse-amd64] False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Date: Mon, 9 May 2005 12:53:13 +0200
User-Agent: KMail/1.8
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <200505081445.26663.bernd.paysan@gmx.de> <20050508134035.GC15724@wotan.suse.de>
In-Reply-To: <20050508134035.GC15724@wotan.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1481439.Ky4IAl7PCk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505091253.21252.bernd.paysan@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1481439.Ky4IAl7PCk
Content-Type: multipart/mixed;
  boundary="Boundary-01=_aE0fCpdnEwj4qKj"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_aE0fCpdnEwj4qKj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 08 May 2005 15:40, Andi Kleen wrote:
> Your system should be using the HPET timer to work exactly around
> this. AMD 8000 has HPET. Can you post a boot.log?

Ok, boot.log attached. The only entry with hpet seems to indicate some=20
problems.

> A common problem however is that the irq 0 is misrouted somehow,
> and gets broadcasted and processed on multiple CPUs. That results
> in the time running far too fast. You can check that by looking
> at /proc/interrupts.

After rebooting today (and doing basically nothing), things look like that:

# while [ .T. ]; do sleep 1; echo -n $(date); grep timer /proc/interrupts;=
=20
done
Mo Mai 9 12:47:37 CEST 2005  0:    4156834    4466062    IO-APIC-edge  timer
Mo Mai 9 12:47:38 CEST 2005  0:    4157847    4466062    IO-APIC-edge  timer
Mo Mai 9 12:47:39 CEST 2005  0:    4158861    4466062    IO-APIC-edge  timer
Mo Mai 9 12:47:40 CEST 2005  0:    4159874    4466062    IO-APIC-edge  timer
Mo Mai 9 12:47:41 CEST 2005  0:    4160886    4466062    IO-APIC-edge  timer
Mo Mai 9 12:47:42 CEST 2005  0:    4161899    4466062    IO-APIC-edge  timer
Mo Mai 9 12:47:43 CEST 2005  0:    4162913    4466062    IO-APIC-edge  timer
Mo Mai 9 12:47:44 CEST 2005  0:    4163926    4466062    IO-APIC-edge  timer
Mo Mai 9 12:47:45 CEST 2005  0:    4164938    4466062    IO-APIC-edge  timer
Mo Mai 9 12:47:46 CEST 2005  0:    4165951    4466062    IO-APIC-edge  timer
Mo Mai 9 12:47:47 CEST 2005  0:    4166396    4466631    IO-APIC-edge  timer
Mo Mai 9 12:47:48 CEST 2005  0:    4166396    4467644    IO-APIC-edge  timer
Mo Mai 9 12:47:49 CEST 2005  0:    4166396    4468656    IO-APIC-edge  timer
Mo Mai 9 12:47:50 CEST 2005  0:    4166396    4469668    IO-APIC-edge  timer
Mo Mai 9 12:47:51 CEST 2005  0:    4166396    4470681    IO-APIC-edge  timer
Mo Mai 9 12:47:52 CEST 2005  0:    4166396    4471694    IO-APIC-edge  timer
Mo Mai 9 12:47:53 CEST 2005  0:    4166396    4472708    IO-APIC-edge  timer
Mo Mai 9 12:47:54 CEST 2005  0:    4166396    4473720    IO-APIC-edge  timer
Mo Mai 9 12:47:55 CEST 2005  0:    4166396    4474733    IO-APIC-edge  timer

Adding load to one CPU changes things:

# cat /dev/zero >/dev/null &
# speed
1000000
2000000
# while [ .T. ]; do sleep 1; echo -n $(date); grep timer /proc/interrupts;=
=20
done
Mo Mai 9 12:48:52 CEST 2005  0:    4195741    4500873    IO-APIC-edge  timer
Mo Mai 9 12:48:53 CEST 2005  0:    4195741    4501882    IO-APIC-edge  timer
Mo Mai 9 12:48:54 CEST 2005  0:    4195741    4502893    IO-APIC-edge  timer
Mo Mai 9 12:48:55 CEST 2005  0:    4195741    4503902    IO-APIC-edge  timer
Mo Mai 9 12:48:56 CEST 2005  0:    4195741    4504913    IO-APIC-edge  timer
Mo Mai 9 12:49:01 CEST 2005  0:    4195958    4505706    IO-APIC-edge  timer
Mo Mai 9 12:49:03 CEST 2005  0:    4196968    4505706    IO-APIC-edge  timer
Mo Mai 9 12:49:04 CEST 2005  0:    4197977    4505706    IO-APIC-edge  timer
Mo Mai 9 12:49:06 CEST 2005  0:    4198986    4505706    IO-APIC-edge  timer
Mo Mai 9 12:49:07 CEST 2005  0:    4199997    4505706    IO-APIC-edge  timer
Mo Mai 9 12:49:09 CEST 2005  0:    4201006    4505706    IO-APIC-edge  timer
Mo Mai 9 12:49:10 CEST 2005  0:    4202015    4505706    IO-APIC-edge  timer
Mo Mai 9 12:49:04 CEST 2005  0:    4202868    4505706    IO-APIC-edge  timer
Mo Mai 9 12:49:12 CEST 2005  0:    4203675    4505706    IO-APIC-edge  timer
Mo Mai 9 12:49:14 CEST 2005  0:    4204685    4505706    IO-APIC-edge  timer
Mo Mai 9 12:49:15 CEST 2005  0:    4205376    4505713    IO-APIC-edge  timer
Mo Mai 9 12:49:16 CEST 2005  0:    4205376    4506724    IO-APIC-edge  timer
Mo Mai 9 12:49:17 CEST 2005  0:    4205376    4507734    IO-APIC-edge  timer
Mo Mai 9 12:49:18 CEST 2005  0:    4205376    4508743    IO-APIC-edge  timer
Mo Mai 9 12:49:19 CEST 2005  0:    4205376    4509752    IO-APIC-edge  timer
Mo Mai 9 12:49:20 CEST 2005  0:    4205376    4510761    IO-APIC-edge  timer

After stopping the load, the hickups continue:

Mo Mai 9 12:56:28 CEST 2005  0:    4312541    4585753    IO-APIC-edge  timer
Mo Mai 9 12:56:29 CEST 2005  0:    4313554    4585753    IO-APIC-edge  timer
Mo Mai 9 12:56:30 CEST 2005  0:    4314568    4585753    IO-APIC-edge  timer
Mo Mai 9 12:57:20 CEST 2005  0:    4315424    4585756    IO-APIC-edge  timer
Mo Mai 9 12:57:21 CEST 2005  0:    4316437    4585756    IO-APIC-edge  timer
Mo Mai 9 12:57:22 CEST 2005  0:    4317449    4585756    IO-APIC-edge  timer
Mo Mai 9 12:57:23 CEST 2005  0:    4318461    4585756    IO-APIC-edge  timer
Mo Mai 9 12:57:24 CEST 2005  0:    4319474    4585756    IO-APIC-edge  timer

=2D-=20
Bernd Paysan
"If you want it done right, you have to do it yourself"
http://www.jwdt.com/~paysan/

--Boundary-01=_aE0fCpdnEwj4qKj
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="boot.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="boot.log"

Bootdata ok (command line is root=3D/dev/sda5 vga=3D0x317 selinux=3D0  spla=
sh=3Dsilent console=3Dtty0 resume=3D/dev/sda1)
Linux version 2.6.11.4-20a-smp (geeko@buildhost) (gcc version 3.3.5 2005011=
7 (prerelease) (SUSE Linux)) #1 SMP Wed Mar 23 21:52:37 UTC 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000e8ff0000 (usable)
 BIOS-e820: 00000000e8ff0000 - 00000000e8fff000 (ACPI data)
 BIOS-e820: 00000000e8fff000 - 00000000e9000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f6c=
b0
ACPI: RSDT (v001 A M I  OEMRSDT  0x04000518 MSFT 0x00000097) @ 0x00000000e8=
ff0000
ACPI: FADT (v001 A M I  OEMFACP  0x04000518 MSFT 0x00000097) @ 0x00000000e8=
ff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x04000518 MSFT 0x00000097) @ 0x00000000e8=
ff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x04000518 MSFT 0x00000097) @ 0x00000000e8=
fff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x04000518 MSFT 0x00000097) @ 0x00000000e8=
ff3b20
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x00000000e8=
ff3c30
ACPI: DSDT (v001  0AAAA 0AAAA000 0x00000000 INTL 0x02002026) @ 0x0000000000=
000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: Node 0 PXM 0 100000-7fffffff
SRAT: Node 1 PXM 1 80000000-e8ffffff
SRAT: Node 0 PXM 0 0-7fffffff
Bootmem setup node 0 0000000000000000-000000007fffffff
Bootmem setup node 1 0000000080000000-00000000e8feffff
On node 0 totalpages: 524287
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 520191 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 430063
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 430063 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfebff000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xfebff000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfebfe000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xfebfe000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ 1d20000000 size 256 MB
Aperture from northbridge cpu 0 beyond 4GB. Ignoring.
No AGP bridge found
Built 2 zonelists
Kernel command line: root=3D/dev/sda5 vga=3D0x317 selinux=3D0  splash=3Dsil=
ent console=3Dtty0 resume=3D/dev/sda1
bootsplash: silent mode.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1991.823 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 3751076k/3817408k available (2280k kernel code, 0k reserved, 1179k =
data, 212k init)
Calibrating delay loop... 3915.77 BogoMIPS (lpj=3D1957888)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0
checking if image is initramfs... it is
ACPI: Looking for DSDT in initrd... not found!
 not found!
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0
CPU0: AMD Opteron(tm) Processor 246 stepping 0a
per-CPU timeslice cutoff: 1024.34 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp ffff8100e8c67f58
Initializing CPU#1
Calibrating delay loop... 3981.31 BogoMIPS (lpj=3D1990656)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1
AMD Opteron(tm) Processor 246 stepping 0a
Total of 2 processors activated (7897.08 BogoMIPS).
Using local APIC timer interrupts.
Detected 12.448 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1115626867.414:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
vesafb: framebuffer at 0xfd000000, mapped to 0xffffc20000080000, using 6144=
k, total 8128k
vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D4
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
bootsplash 3.1.6-2004/03/31: looking for picture...<6> silentjpeg size 5713=
5 bytes,<6>...found (1024x768, 36789 bytes, v3).
Console: switching to colour frame buffer device 127x44
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12
hpet_acpi_add: no address or irqs in _CRS
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: loaded (max 8 devices)
mice: PS/2 mouse device common for all mice
input: PC Speaker
md: md driver 0.90.1 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 256Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
ACPI wakeup devices:=20
PCI1 USB0 USB1 PS2K UAR1 GOLA GLAN GOLB SMBC AC97 MODM PWRB=20
ACPI: (supports S0 S1 S4 S5)
=46reeing unused kernel memory: 212k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
SCSI subsystem initialized
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: SONY DVD RW DW-D56A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
3ware 9000 Storage Controller device driver for Linux v2.26.02.001.
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 27 (level, low) -> IRQ 169
scsi0 : 3ware 9000 Storage Controller
3w-9xxx: scsi0: Found a 3ware 9000 Storage Controller at 0xfc9ffc00, IRQ: 1=
69.
3w-9xxx: scsi0: Firmware FE9X 2.06.00.009, BIOS BE9X 2.03.01.051, Ports: 4.
  Vendor: AMCC      Model: 9500S-4LP  DISK   Rev: 2.06
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 136697856 512-byte hdwr sectors (69989 MB)
SCSI device sda: drive cache: write back, no read (daft)
SCSI device sda: 136697856 512-byte hdwr sectors (69989 MB)
SCSI device sda: drive cache: write back, no read (daft)
 sda: sda1 sda2 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 28 (level, low) -> IRQ 177
3w-9xxx: scsi0: ERROR: (0x03:0x0104): SGL entry has illegal length:address=
=3D0xE7E0C000, length=3D0xFE, cmd=3DX.
scsi_id[967]: 0:0:0:0: sg_io failed status 0x8 0x0 0x0 0x4
scsi_id[967]: 0:0:0:0: Unable to get INQUIRY vpd 1 page 0x0.
scsi1 : 3ware 9000 Storage Controller
3w-9xxx: scsi1: Found a 3ware 9000 Storage Controller at 0xfc6ffc00, IRQ: 1=
77.
3w-9xxx: scsi1: Firmware FE9X 2.06.00.009, BIOS BE9X 2.03.01.051, Ports: 12.
  Vendor: AMCC      Model: 9500S-12   DISK   Rev: 2.06
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdb: 1953038336 512-byte hdwr sectors (999956 MB)
SCSI device sdb: drive cache: write back, no read (daft)
SCSI device sdb: 1953038336 512-byte hdwr sectors (999956 MB)
SCSI device sdb: drive cache: write back, no read (daft)
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
  Vendor: AMCC      Model: 9500S-12   DISK   Rev: 2.06
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdc: 1953038336 512-byte hdwr sectors (999956 MB)
SCSI device sdc: drive cache: write back, no read (daft)
SCSI device sdc: 1953038336 512-byte hdwr sectors (999956 MB)
3w-9xxx: scsi1: ERROR: (0x03:0x0104): SGL entry has illegal length:address=
=3D0xE7DBB000, length=3D0xFE, cmd=3DX.
SCSI device sdc: drive cache: write back, no read (daft)
 sdc:<4>scsi_id[1114]: 1:0:0:0: sg_io failed status 0x8 0x0 0x0 0x4
 sdc1
Attached scsi disk sdc at scsi1, channel 0, id 1, lun 0
scsi_id[1114]: 1:0:0:0: Unable to get INQUIRY vpd 1 page 0x0.
3w-9xxx: scsi1: ERROR: (0x03:0x0104): SGL entry has illegal length:address=
=3D0xE80D6000, length=3D0xFE, cmd=3DX.
scsi_id[1152]: 1:0:1:0: sg_io failed status 0x8 0x0 0x0 0x4
scsi_id[1152]: 1:0:1:0: Unable to get INQUIRY vpd 1 page 0x0.
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 24 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:02:06.1[B] -> GSI 25 (level, low) -> IRQ 193
scsi2 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=3D7, PCI 33 or 66Mhz, 512=
 SCBs

(scsi2:A:6): 160.000MB/s transfers (80.000MHz DT, 16bit)
  Vendor: CERTANCE  Model: ULTRIUM 2         Rev: 1703
  Type:   Sequential-Access                  ANSI SCSI revision: 03
scsi3 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=3D7, PCI 33 or 66Mhz, 512=
 SCBs

hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
md: Autodetecting RAID arrays.
JBD: barrier-based sync failed on sda5 - disabling barriers
md: autorun ...
md: ... autorun DONE.
Adding 8393920k swap on /dev/sda1.  Priority:42 extents:1
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
lp: driver loaded but no devices found
cdrom: open failed.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
load_module: err 0xffffffffffffffef (dont worry)
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:03:00.0[D] -> GSI 19 (level, low) -> IRQ 201
ohci_hcd 0000:03:00.0: OHCI Host Controller
ohci_hcd 0000:03:00.0: irq 201, pci mem 0xfeafd000
ohci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:03:00.1[D] -> GSI 19 (level, low) -> IRQ 201
ohci_hcd 0000:03:00.1: OHCI Host Controller
ohci_hcd 0000:03:00.1: irq 201, pci mem 0xfeafe000
ohci_hcd 0000:03:00.1: new USB bus registered, assigned bus number 2
e100: Intel(R) PRO/100 Network Driver, 3.4.1-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
hub 2-0:1.0: USB hub found
Losing some ticks... checking if CPU frequency changed.
hub 2-0:1.0: 3 ports detected
load_module: err 0xffffffffffffffef (dont worry)
tg3.c:v3.23 (February 15, 2005)
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 185
eth0: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCI:66MHz:64-bit) 10/=
100/1000BaseT Ethernet 00:e0:81:29:af:1c
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap=
[1]=20
ACPI: PCI interrupt 0000:02:09.1[B] -> GSI 25 (level, low) -> IRQ 193
eth1: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCI:66MHz:64-bit) 10/=
100/1000BaseT Ethernet 00:e0:81:29:af:1d
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap=
[1]=20
ACPI: PCI interrupt 0000:03:08.0[A] -> GSI 18 (level, low) -> IRQ 209
e100: eth2: e100_probe: addr 0xfeafb000, irq 209, MAC addr 00:E0:81:29:AF:1B
st: Version 20041025, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi2, channel 0, id 6, lun 0
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 13421=
7727
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg2 at scsi1, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg3 at scsi2, channel 0, id 6, lun 0,  type 1
BIOS EDD facility v0.16 2004-Jun-25, 3 devices found
3w-9xxx: scsi1: ERROR: (0x03:0x0104): SGL entry has illegal length:address=
=3D0xCE4A2000, length=3D0xFE, cmd=3DX.
3w-9xxx: scsi1: ERROR: (0x03:0x0104): SGL entry has illegal length:address=
=3D0xCECE3000, length=3D0xFE, cmd=3DX.
scsi_id[4718]: 1:0:1:0: sg_io failed status 0x8 0x0 0x0 0x4
scsi_id[4718]: 1:0:1:0: Unable to get INQUIRY vpd 1 page 0x0.
scsi_id[4781]: 1:0:0:0: sg_io failed status 0x8 0x0 0x0 0x4
scsi_id[4781]: 1:0:0:0: Unable to get INQUIRY vpd 1 page 0x0.
3w-9xxx: scsi0: ERROR: (0x03:0x0104): SGL entry has illegal length:address=
=3D0xCF292000, length=3D0xFE, cmd=3DX.
scsi_id[4909]: 0:0:0:0: sg_io failed status 0x8 0x0 0x0 0x4
scsi_id[4909]: 0:0:0:0: Unable to get INQUIRY vpd 1 page 0x0.
cdrom: open failed.
3w-9xxx: scsi1: ERROR: (0x03:0x0104): SGL entry has illegal length:address=
=3D0xCEE2C000, length=3D0x24, cmd=3DX.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: sda7: found reiserfs format "3.6" with standard journal
ReiserFS: sda7: using ordered data mode
reiserfs: using flush barriers
ReiserFS: sda7: journal params: device sda7, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda7: checking transaction log (sda7)
reiserfs: disabling flush barriers on sda7
ReiserFS: sda7: Using r5 hash to sort names
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
reiserfs: using flush barriers
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
reiserfs: disabling flush barriers on dm-1
ReiserFS: dm-1: Using r5 hash to sort names
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
reiserfs: using flush barriers
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
reiserfs: disabling flush barriers on dm-0
ReiserFS: dm-0: Using r5 hash to sort names
ReiserFS: dm-2: found reiserfs format "3.6" with standard journal
ReiserFS: dm-2: using ordered data mode
reiserfs: using flush barriers
ReiserFS: dm-2: journal params: device dm-2, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-2: checking transaction log (dm-2)
reiserfs: disabling flush barriers on dm-2
ReiserFS: dm-2: Using r5 hash to sort names
Capability LSM initialized
ieee1394: Initialized config rom entry `ip1394'
ieee1394: raw1394: /dev/raw1394 device initialized
video1394: Installed video1394 module
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
mtrr: 0xfd000000,0x800000 overlaps existing 0xfd000000,0x400000
mtrr: 0xfd000000,0x800000 overlaps existing 0xfd000000,0x400000
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports 8 throttling states)
    ACPI-0484: *** Warning: Error getting cpuindex for acpiid 0x3
    ACPI-0484: *** Warning: Error getting cpuindex for acpiid 0x4
=46loppy drive(s): fd0 is 1.44M
=46DC 0 is a post-1991 82077
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
3w-9xxx: scsi0: ERROR: (0x03:0x0104): SGL entry has illegal length:address=
=3D0xD6866000, length=3D0x24, cmd=3DX.
3w-9xxx: scsi1: ERROR: (0x03:0x0104): SGL entry has illegal length:address=
=3D0x7D2CB000, length=3D0x24, cmd=3DX.
3w-9xxx: scsi1: ERROR: (0x03:0x0104): SGL entry has illegal length:address=
=3D0x7D2CB000, length=3D0x24, cmd=3DX.
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80425c00(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device ffff81007cc65000(sit0)
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.00.09e)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
cpu_init done, current fid 0xc, vid 0x2
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
cpu_init done, current fid 0xc, vid 0x2
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
3w-9xxx: scsi1: ERROR: (0x03:0x0104): SGL entry has illegal length:address=
=3D0x766DE000, length=3D0xFF, cmd=3DX.
3w-9xxx: scsi1: ERROR: (0x03:0x0104): SGL entry has illegal length:address=
=3D0x7C31B000, length=3D0xFF, cmd=3DX.
eth0: no IPv6 routers present
3w-9xxx: scsi0: ERROR: (0x03:0x0104): SGL entry has illegal length:address=
=3D0xDC53A000, length=3D0xFF, cmd=3DX.
subfs 0.9
end_request: I/O error, dev fd0, sector 0

--Boundary-01=_aE0fCpdnEwj4qKj--

--nextPart1481439.Ky4IAl7PCk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCf0Ehi4ILt2cAfDARAgx0AKDHVjm0kQ3CKEpnQSm38c8qxDPXPgCgxzj3
R1UFE4oeUVStn/QJ2YRIrcU=
=Feme
-----END PGP SIGNATURE-----

--nextPart1481439.Ky4IAl7PCk--
