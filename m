Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965264AbWJBS0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbWJBS0I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbWJBS0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:26:07 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:26316 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S965264AbWJBS0D (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:26:03 -0400
Message-Id: <200610021825.k92IPSnd008215@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 00/21] high resolution timers / dynamic ticks - V2
In-Reply-To: Your message of "Mon, 02 Oct 2006 15:43:02 +0200."
             <1159796582.1386.9.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <200610021302.k92D23W1003320@turing-police.cc.vt.edu>
            <1159796582.1386.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159813528_5418P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 14:25:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159813528_5418P
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1159811830_54180"

This is a multipart MIME message.

--==_Exmh_1159811830_54180
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

(Sorry for the size of the note, there's some 50K of logs attached)

On Mon, 02 Oct 2006 15:43:02 +0200, Thomas Gleixner said:
> Can you please send me the bootlog and further dmesg output (especially=

> when related to timers / cpufreq).

I booted the box to single-user both times, and then started cpuspeed.
I then did a cat of /proc/interrupts, /proc/uptime, and a date command,
waited 60 seconds according to my watch, and repeated.  I then dumped
the dmesg.  The -dyntick kernel moved 'uptime' almost exactly 45 seconds
(almost certainly a by-product of running at 1.2Ghz rather than 1.6Ghz).
Does the dyntick code make any unwritten assumptions about a jiffie or
bogomips remaining constant?

Attached - config diff, date and /proc dumps from both -mm2 and -mm2-dynt=
ick,
and the dmesg's from both boots.

Yell if you have any other questions/suggestions/etc..

> > I'm also seeing gkrellm reporting about 25% CPU use when =22near-idle=
=22 (X is up
> > but not much is going on) when that's usually down around 5-6%.  I ne=
ed to
> > collect some oprofile numbers and investigate that as well.
>
> I look into the accounting fixups again.
I still need to get oprofile runs of this and see what's going on.

--==_Exmh_1159811830_54180
Content-Type: text/plain ; name="config.diff"; charset=iso-8859-1
Content-Description: config.diff
Content-Disposition: attachment; filename="config.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.18-mm2/.config	2006-10-02 10:11:34.000000000 -0400
+++ linux-2.6.18-mm2-hrt-dyntick5/.config	2006-10-02 02:19:09.000000000 -=
0400
=40=40 -1,10 +1,11 =40=40
 =23
 =23 Automatically generated make config: don't edit
-=23 Linux kernel version: 2.6.18-mm2
-=23 Mon Oct  2 10:11:34 2006
+=23 Linux kernel version: 2.6.18-mm2-hrt-dyntick5
+=23 Mon Oct  2 02:19:09 2006
 =23
 CONFIG_X86_32=3Dy
 CONFIG_GENERIC_TIME=3Dy
+CONFIG_GENERIC_CLOCKEVENTS=3Dy
 CONFIG_LOCKDEP_SUPPORT=3Dy
 CONFIG_STACKTRACE_SUPPORT=3Dy
 CONFIG_SEMAPHORE_SLEEPERS=3Dy
=40=40 -103,6 +104,9 =40=40
 =23
 =23 Processor type and features
 =23
+CONFIG_HIGH_RES_TIMERS=3Dy
+CONFIG_HIGH_RES_RESOLUTION=3D1000
+CONFIG_NO_HZ=3Dy
 =23 CONFIG_SMP is not set
 CONFIG_X86_PC=3Dy
 =23 CONFIG_X86_ELAN is not set
=40=40 -2007,6 +2011,7 =40=40
 CONFIG_LOG_BUF_SHIFT=3D17
 =23 CONFIG_DETECT_SOFTLOCKUP is not set
 =23 CONFIG_SCHEDSTATS is not set
+CONFIG_TIMER_STATS=3Dy
 =23 CONFIG_DEBUG_SLAB is not set
 =23 CONFIG_DEBUG_PREEMPT is not set
 =23 CONFIG_DEBUG_RT_MUTEXES is not set

--==_Exmh_1159811830_54180
Content-Type: text/plain ; name="date.mm2"; charset=iso-8859-1
Content-Description: date.mm2
Content-Disposition: attachment; filename="date.mm2"
Content-Transfer-Encoding: quoted-printable

           CPU0      =20
  0:      60357    XT-PIC-level    timer
  1:        183    XT-PIC-level    i8042
  2:          0    XT-PIC-level    cascade
  5:          0    XT-PIC-level    Intel 82801CA-ICH3
  6:          3    XT-PIC-level    floppy
  8:          1    XT-PIC-level    rtc
  9:          1    XT-PIC-level    acpi
 11:         39    XT-PIC-level    uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd=
:usb3, ohci1394, yenta, yenta, yenta, pcmcia2.0
 12:        114    XT-PIC-level    i8042
 14:       2045    XT-PIC-level    libata
 15:          0    XT-PIC-level    libata
NMI:          0=20
LOC:          0=20
ERR:          0
MIS:          0
58.75 50.70
Mon Oct  2 11:32:07 EDT 2006
           CPU0      =20
  0:     120338    XT-PIC-level    timer
  1:        256    XT-PIC-level    i8042
  2:          0    XT-PIC-level    cascade
  5:          0    XT-PIC-level    Intel 82801CA-ICH3
  6:          3    XT-PIC-level    floppy
  8:          1    XT-PIC-level    rtc
  9:          1    XT-PIC-level    acpi
 11:         39    XT-PIC-level    uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd=
:usb3, ohci1394, yenta, yenta, yenta, pcmcia2.0
 12:        114    XT-PIC-level    i8042
 14:       2058    XT-PIC-level    libata
 15:          0    XT-PIC-level    libata
NMI:          0=20
LOC:          0=20
ERR:          0
MIS:          0
116.04 110.64
Mon Oct  2 11:33:04 EDT 2006

--==_Exmh_1159811830_54180
Content-Type: text/plain ; name="date.mm2-dyntick"; charset=iso-8859-1
Content-Description: date.mm2-dyntick
Content-Disposition: attachment; filename="date.mm2-dyntick"
Content-Transfer-Encoding: quoted-printable

           CPU0      =20
  0:      15931    XT-PIC-level    timer
  1:        164    XT-PIC-level    i8042
  2:          0    XT-PIC-level    cascade
  5:          0    XT-PIC-level    Intel 82801CA-ICH3
  6:          3    XT-PIC-level    floppy
  8:          1    XT-PIC-level    rtc
  9:          0    XT-PIC-level    acpi
 11:         38    XT-PIC-level    uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd=
:usb3, ohci1394, yenta, yenta, yenta, pcmcia2.0
 12:        114    XT-PIC-level    i8042
 14:       2066    XT-PIC-level    libata
 15:          0    XT-PIC-level    libata
NMI:          0=20
LOC:          0=20
ERR:          0
MIS:          0
73.89 6.84
Mon Oct  2 11:23:24 EDT 2006
           CPU0      =20
  0:      24314    XT-PIC-level    timer
  1:        205    XT-PIC-level    i8042
  2:          0    XT-PIC-level    cascade
  5:          0    XT-PIC-level    Intel 82801CA-ICH3
  6:          3    XT-PIC-level    floppy
  8:          1    XT-PIC-level    rtc
  9:          0    XT-PIC-level    acpi
 11:         38    XT-PIC-level    uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd=
:usb3, ohci1394, yenta, yenta, yenta, pcmcia2.0
 12:        114    XT-PIC-level    i8042
 14:       2079    XT-PIC-level    libata
 15:          0    XT-PIC-level    libata
NMI:          0=20
LOC:          0=20
ERR:          0
MIS:          0
118.96 11.36
Mon Oct  2 11:24:09 EDT 2006

--==_Exmh_1159811830_54180
Content-Type: text/plain ; name="dmesg.mm2"; charset=iso-8859-1
Content-Description: dmesg.mm2
Content-Disposition: attachment; filename="dmesg.mm2"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.18-mm2 (valdis=40turing-police.cc.vt.edu) (gcc version =
4.1.1 20060926 (Red Hat 4.1.1-26)) =231 PREEMPT Mon Oct 2 10:45:34 EDT 20=
06
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 00000=
0000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000=
000000a0000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000002fee2800 end: 00000=
0002ffe2800 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000002ffe2800 size: 000000000001d800 end: 00000=
00030000000 type: 2
copy_e820_map() start: 00000000feda0000 size: 0000000000060000 end: 00000=
000fee00000 type: 2
copy_e820_map() start: 00000000ffb80000 size: 0000000000480000 end: 00000=
00100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ffe2800 (usable)
 BIOS-e820: 000000002ffe2800 - 0000000030000000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
767MB LOWMEM available.
Entering add_active_range(0, 0, 196578) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   196578
early_node_map=5B1=5D active PFN ranges
    0:        0 ->   196578
On node 0 totalpages: 196578
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1503 pages used for memmap
  Normal zone: 190979 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) =40 0x000fde50
ACPI: RSDT (v001 DELL    CPi R   0x27d40107 ASL  0x00000061) =40 0x000fde=
64
ACPI: FADT (v001 DELL    CPi R   0x27d40107 ASL  0x00000061) =40 0x000fde=
90
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) =40 0x000000=
00
ACPI: PM-Timer IO Port: 0x808
Allocating PCI resources starting at 40000000 (gap: 30000000:ceda0000)
Detected 1595.436 MHz processor.
Built 1 zonelists.  Total pages: 195043
Kernel command line: vga=3D794 quiet crashkernel=3D64M=4016M single
Local APIC disabled by BIOS -- you can enable it with =22lapic=22
mapped APIC to ffffd000 (05603000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU=230
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 706936k/786312k available (2406k kernel code, 78804k reserved, 10=
41k data, 180k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xf0800000 - 0xfffb5000   ( 247 MB)
    lowmem  : 0xc0000000 - 0xeffe2000   ( 767 MB)
      .init : 0xc04e6000 - 0xc0513000   ( 180 kB)
      .data : 0xc0359960 - 0xc045e0a8   (1041 kB)
      .text : 0xc0100000 - 0xc0359960   (2406 kB)
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
Calibrating delay using timer specific routine.. 3192.27 BogoMIPS (lpj=3D=
1596136)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 3febf9ff 00000000 00000000 00000000 00=
000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: 3febf9ff 00000000 00000000 00000080 00000000 =
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU=230.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz stepping 04
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0800)
checking if image is initramfs... it is
Freeing initrd memory: 1824k freed
NET: Registered protocol family 16
ACPI: ACPI Dock Station Driver=20
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbfee, last bus=3D2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge =5BPCI0=5D (0000:00)
ACPI: Assume root bridge =5B=5C_SB_.PCI0=5D bus is 0
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0._PRT=5D
ACPI: PCI Interrupt Link =5BLNKA=5D (IRQs 9 10 *11)
ACPI: PCI Interrupt Link =5BLNKB=5D (IRQs 5 7) *11
ACPI: PCI Interrupt Link =5BLNKC=5D (IRQs 9 10 *11)
ACPI: PCI Interrupt Link =5BLNKD=5D (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0.AGP_._PRT=5D
ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0.PCIE._PRT=5D
ACPI: Power Resource =5BPADA=5D (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
Intel 82802 RNG detected
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try =22pci=3Drouteirq=22.  If it helps, po=
st a report
NetLabel: Initializing
NetLabel:  domain hash size =3D 128
NetLabel:  protocols =3D UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:02: ioport range 0x800-0x805 could not be reserved
pnp: 00:02: ioport range 0x808-0x80f could not be reserved
pnp: 00:03: ioport range 0x806-0x807 has been reserved
pnp: 00:03: ioport range 0x810-0x85f could not be reserved
pnp: 00:03: ioport range 0x860-0x87f has been reserved
pnp: 00:03: ioport range 0x880-0x8bf has been reserved
pnp: 00:03: ioport range 0x8c0-0x8df has been reserved
pnp: 00:03: ioport range 0x8e0-0x8ff has been reserved
pnp: 00:08: ioport range 0x900-0x91f has been reserved
pnp: 00:08: ioport range 0x3f0-0x3f1 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: fc000000-fdffffff
  PREFETCH window: d8000000-e7ffffff
PCI: Bus 3, cardbus bridge: 0000:02:01.0
  IO window: 0000e000-0000e0ff
  IO window: 0000e400-0000e4ff
  PREFETCH window: 40000000-41ffffff
  MEM window: f4000000-f5ffffff
PCI: Bus 7, cardbus bridge: 0000:02:01.1
  IO window: 0000e800-0000e8ff
  IO window: 0000f000-0000f0ff
  PREFETCH window: 42000000-43ffffff
  MEM window: f6000000-f7ffffff
PCI: Bus 11, cardbus bridge: 0000:02:03.0
  IO window: 0000f400-0000f4ff
  IO window: 0000f800-0000f8ff
  PREFETCH window: 44000000-45ffffff
  MEM window: fa000000-fbffffff
PCI: Bridge: 0000:00:1e.0
  IO window: e000-ffff
  MEM window: f4000000-fbffffff
  PREFETCH window: 40000000-46ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:02:01.0 (0000 -> 0003)
ACPI: PCI Interrupt Link =5BLNKD=5D enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:01.0=5BA=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
PCI: Enabling device 0000:02:01.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:02:01.1=5BA=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
ACPI: PCI Interrupt 0000:02:03.0=5BA=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
speedstep: frequency transition measured seems out of range (0 nSec), fal=
ling back to a safe one of 500000 nSec.
audit: initializing netlink socket (disabled)
audit(1159803069.386:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
vesafb: framebuffer at 0xe0000000, mapped to 0xf0880000, using 5120k, tot=
al 32768k
vesafb: mode is 1280x1024x16, linelength=3D2560, pages=3D1
vesafb: protected mode interface info at c000:e140
vesafb: pmi: set display start =3D c00ce185, set palette =3D c00ce20a
vesafb: pmi: ports =3D b4c3 b503 ba03 c003 c103 c403 c503 c603 c703 c803 =
c903 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03 ff03=20
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
ACPI: Video Device =5BVID=5D (multi-head: yes  rom: no  post: no)
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is=
 60 seconds).
Hangcheck: Using get_cycles().
Serial: 8250/16550 driver =24Revision: 1.90 =24 4 ports, IRQ sharing enab=
led
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ACPI: PCI Interrupt Link =5BLNKB=5D enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6=5BB=5D -> Link =5BLNKB=5D -> GSI 5 (leve=
l, low) -> IRQ 5
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
RAMDISK driver initialized: 16 RAM disks of 10240K size 1024 blocksize
loop: loaded (max 8 devices)
ACPI: PCI Interrupt Link =5BLNKC=5D enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:00.0=5BA=5D -> Link =5BLNKC=5D -> GSI 11 (lev=
el, low) -> IRQ 11
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:00.0: 3Com PCI 3c905C Tornado at f0804c00.
ACPI: PCI Interrupt 0000:02:08.0=5BA=5D -> Link =5BLNKC=5D -> GSI 11 (lev=
el, low) -> IRQ 11
0000:02:08.0: 3Com PCI 3c905C Tornado at f0806800.
libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac7
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link =5BLNKA=5D enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.1=5BA=5D -> Link =5BLNKA=5D -> GSI 11 (lev=
el, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
scsi0 : ata_piix
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PC=
I)
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0=5BA=5D -> Link =5BLNKA=5D -> GSI 11 (lev=
el, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
usb usb1: new device found, idVendor=3D0000, idProduct=3D0000
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-mm2 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
usb usb1: configuration =231 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1=5BB=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 11, io base 0x0000bf40
usb usb2: new device found, idVendor=3D0000, idProduct=3D0000
usb usb2: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-mm2 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
usb usb2: configuration =231 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2=5BC=5D -> Link =5BLNKC=5D -> GSI 11 (lev=
el, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf20
usb usb3: new device found, idVendor=3D0000, idProduct=3D0000
usb usb3: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.18-mm2 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
usb usb3: configuration =231 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller =5BPNP0303:KBC,PNP0f13:PS2M=5D at 0x60,0x64 irq 1,12=

serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
ata1.00: ATA-6, max UDMA/100, 117210240 sectors: LBA=20
ata1.00: ata1: dev 0 multi count 8
ata1.01: ATAPI, max UDMA/33
ata1.00: configured for UDMA/100
usb 2-2: new low speed USB device using uhci_hcd and address 2
ata1.01: configured for UDMA/33
scsi1 : ata_piix
usb 2-2: new device found, idVendor=3D045e, idProduct=3D0023
usb 2-2: new device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 2-2: Product: Microsoft Trackball Optical=AE
usb 2-2: Manufacturer: Microsoft
usb 2-2: configuration =231 chosen from 1 choice
input: Microsoft Microsoft Trackball Optical=AE as /class/input/input2
input: USB HID v1.00 Mouse =5BMicrosoft Microsoft Trackball Optical=AE=5D=
 on usb-0000:00:1d.1-2
input: DualPoint Stick as /class/input/input3
input: AlpsPS/2 ALPS DualPoint TouchPad as /class/input/input4
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2060A 0000 PQ: 0 ANSI=
: 5
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda:<6>i2c /dev entries driver
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel=40r=
edhat.com
EDAC MC: Ver: 2.0.1 Oct  2 2006
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 13=
:55:50 2006 UTC).
ACPI: PCI Interrupt 0000:00:1f.5=5BB=5D -> Link =5BLNKB=5D -> GSI 5 (leve=
l, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ALSA device list:
  No soundcards found.
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
Freeing unused kernel memory: 180k freed
Write protecting the kernel read-only data: 433k
 sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
scsi 0:0:1:0: CD-ROM            TOSHIBA  CDRW/DVD SDR2102 1D13 PQ: 0 ANSI=
: 5
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:1:0: Attached scsi CD-ROM sr0
intel8x0_measure_ac97_clock: measured 50385 usecs
intel8x0: clocking to 48000
video bus notify
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  6 users, 5 roles, 2013 types, 80 bools, 1 sens, 1024 cats
security:  58 classes, 111120 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts=

SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts=

SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1159803074.616:2): policy loaded auid=3D4294967295
audit(1159803074.993:3): avc:  denied  =7B execute =7D for  pid=3D458 com=
m=3D=22rc.sysinit=22 name=3D=22hostname=22 dev=3Ddm-0 ino=3D33031 scontex=
t=3Dsystem_u:system_r:initrc_t:s0 tcontext=3Dsystem_u:object_r:hostname_e=
xec_t:s0 tclass=3Dfile
audit(1159803074.993:4): avc:  denied  =7B execute_no_trans =7D for  pid=
=3D458 comm=3D=22rc.sysinit=22 name=3D=22hostname=22 dev=3Ddm-0 ino=3D330=
31 scontext=3Dsystem_u:system_r:initrc_t:s0 tcontext=3Dsystem_u:object_r:=
hostname_exec_t:s0 tclass=3Dfile
audit(1159803074.993:5): avc:  denied  =7B read =7D for  pid=3D458 comm=
=3D=22rc.sysinit=22 name=3D=22hostname=22 dev=3Ddm-0 ino=3D33031 scontext=
=3Dsystem_u:system_r:initrc_t:s0 tcontext=3Dsystem_u:object_r:hostname_ex=
ec_t:s0 tclass=3Dfile
Real Time Clock Driver v1.12ac
audit(1159803078.140:6): avc:  denied  =7B dac_override =7D for  pid=3D48=
8 comm=3D=22dmesg=22 capability=3D1 scontext=3Dsystem_u:system_r:dmesg_t:=
s0 tcontext=3Dsystem_u:system_r:dmesg_t:s0 tclass=3Dcapability
audit(1159803079.947:7): avc:  denied  =7B dac_override =7D for  pid=3D55=
9 comm=3D=22pam_console_app=22 capability=3D1 scontext=3Dsystem_u:system_=
r:pam_console_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:system_r:pam_console_t=
:s0-s0:c0.c1023 tclass=3Dcapability
ACPI: PCI Interrupt 0000:02:01.2=5BA=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D=5B11=5D  MMIO=3D=5Bf8fff0=
00-f8fff7ff=5D  Max Packet=3D=5B2048=5D  IR/IT contexts=3D=5B4/4=5D
Yenta: CardBus bridge found at 0000:02:01.0 =5B1028:00d5=5D
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:01.0, mfunc 0x05033002, devctl 0x64
Yenta: CardBus bridge found at 0000:02:01.1 =5B1028:00d5=5D
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:01.1, mfunc 0x05033002, devctl 0x64
Yenta: CardBus bridge found at 0000:02:03.0 =5B12a3:ab01=5D
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:03.0, mfunc 0x01000002, devctl 0x60
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.00 (30-Jul-2006)
iTCO_wdt: Found a ICH3-M TCO device (Version=3D1, TCOBASE=3D0x0860)
iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
Linux agpgart interface v0.101 (c) Dave Jones
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000020
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xffff
cs: IO port probe 0xe000-0xffff: clean.
pcmcia: parent PCI bridge Memory window: 0xf4000000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x46ffffff
ohci1394: fw-host0: Running dma failed because Node ID is not valid
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xffff
cs: IO port probe 0xe000-0xffff: clean.
pcmcia: parent PCI bridge Memory window: 0xf4000000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x46ffffff
agpgart: Detected an Intel i845 Chipset.
agpgart: AGP aperture is 64M =40 0xe8000000
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000010
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xffff
cs: IO port probe 0xe000-0xffff: clean.
pcmcia: parent PCI bridge Memory window: 0xf4000000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x46ffffff
pccard: CardBus card inserted into slot 0
PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:00.0=5BA=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
PCI: Setting latency timer of device 0000:03:00.0 to 64
eth2: Xircom cardbus revision 3 at irq 11=20
PCI: Enabling device 0000:03:00.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:00.1=5BA=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
0000:03:00.1: ttyS1 at I/O 0xe080 (irq =3D 11) is a 16550A
ohci1394: fw-host0: AT dma reset ctx=3D0, aborting transmission
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
pccard: PCMCIA card inserted into slot 2
ieee1394: Host added: ID:BUS=5B0-00:1023=5D  GUID=5B374fc0002a71c021=5D
cs: memory probe 0xf4000000-0xfbffffff: excluding 0xf4000000-0xf8ffffff 0=
xfa000000-0xfbffffff
pcmcia: registering new device pcmcia2.0
orinoco 0.15 (David Gibson <hermes=40gibson.dropbear.id.au>, Pavel Roskin=
 <proski=40gnu.org>, et al)
orinoco_cs 0.15 (David Gibson <hermes=40gibson.dropbear.id.au>, Pavel Ros=
kin <proski=40gnu.org>, et al)
pcmcia: request for exclusive IRQ could not be fulfilled.
pcmcia: the driver needs updating to supported shared IRQ lines.
cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
eth2: Hardware identity 0005:0004:0005:0000
eth2: Station identity  001f:0001:0008:000a
eth2: Firmware determined as Lucent/Agere 8.10
eth2: Ad-hoc demo mode supported
eth2: IEEE standard IBSS ad-hoc mode supported
eth2: WEP supported, 104-bit key
eth2: MAC address 00:02:2D:5C:11:48
eth2: Station name =22HERMES I=22
eth2: ready
eth2: orinoco_cs at 2.0, irq 11, io 0xe100-0xe13f
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Dell laptop SMM driver v1.14 21/02/2005 Massimo Dal Zotto (dz=40debian.or=
g)
Netfilter messages via NETLINK v0.30.
audit(1159803085.289:8): avc:  denied  =7B getattr =7D for  pid=3D457 com=
m=3D=22rc.sysinit=22 name=3D=22hostname=22 dev=3Ddm-0 ino=3D33031 scontex=
t=3Dsystem_u:system_r:initrc_t:s0 tcontext=3Dsystem_u:object_r:hostname_e=
xec_t:s0 tclass=3Dfile
ACPI: AC Adapter =5BAC=5D (on-line)
ACPI: Battery Slot =5BBAT0=5D (battery absent)
ACPI: Battery Slot =5BBAT1=5D (battery absent)
ACPI: Lid Switch =5BLID=5D
ACPI: Power Button (CM) =5BPBTN=5D
ACPI: Sleep Button (CM) =5BSBTN=5D
Using specific hotkey driver
ACPI: Processor =5BCPU0=5D (supports 8 throttling states)
ACPI: Thermal Zone =5BTHM=5D (67 C)
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-11, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-7, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-8, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-9, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-10, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-6, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-4, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-5, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-1, type ext3), uses xattr
Adding 1572856k swap on /dev/rootvg/swap.  Priority:-1 extents:1 across:1=
572856k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_cont=
exts
audit(1159803121.098:9): avc:  denied  =7B getattr =7D for  pid=3D1508 co=
mm=3D=22bash=22 name=3D=22cpuspeed=22 dev=3Ddm-0 ino=3D197100 scontext=3D=
system_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:initrc_exec_t:=
s0 tclass=3Dfile
audit(1159803121.098:10): avc:  denied  =7B execute =7D for  pid=3D1508 c=
omm=3D=22bash=22 name=3D=22cpuspeed=22 dev=3Ddm-0 ino=3D197100 scontext=
=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:initrc_exec=
_t:s0 tclass=3Dfile
audit(1159803121.098:11): avc:  denied  =7B read =7D for  pid=3D1508 comm=
=3D=22bash=22 name=3D=22cpuspeed=22 dev=3Ddm-0 ino=3D197100 scontext=3Dsy=
stem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:initrc_exec_t:s0=
 tclass=3Dfile
audit(1159803122.483:12): avc:  denied  =7B execute_no_trans =7D for  pid=
=3D1535 comm=3D=22bash=22 name=3D=22cpuspeed=22 dev=3Ddm-0 ino=3D197100 s=
context=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:init=
rc_exec_t:s0 tclass=3Dfile
audit(1159803122.527:13): avc:  denied  =7B ioctl =7D for  pid=3D1535 com=
m=3D=22cpuspeed=22 name=3D=22cpuspeed=22 dev=3Ddm-0 ino=3D197100 scontext=
=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:initrc_exec=
_t:s0 tclass=3Dfile
audit(1159803122.572:14): avc:  denied  =7B getattr =7D for  pid=3D1535 c=
omm=3D=22cpuspeed=22 name=3D=22cpuspeed=22 dev=3Ddm-7 ino=3D295240 sconte=
xt=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:cpuspeed_=
exec_t:s0 tclass=3Dfile
audit(1159803122.617:15): avc:  denied  =7B execute =7D for  pid=3D1539 c=
omm=3D=22bash=22 name=3D=22cpuspeed=22 dev=3Ddm-7 ino=3D295240 scontext=
=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:cpuspeed_ex=
ec_t:s0 tclass=3Dfile
audit(1159803122.617:16): avc:  denied  =7B read =7D for  pid=3D1539 comm=
=3D=22bash=22 name=3D=22cpuspeed=22 dev=3Ddm-7 ino=3D295240 scontext=3Dsy=
stem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:cpuspeed_exec_t:=
s0 tclass=3Dfile
audit(1159803122.617:17): avc:  denied  =7B execute_no_trans =7D for  pid=
=3D1540 comm=3D=22bash=22 name=3D=22cpuspeed=22 dev=3Ddm-7 ino=3D295240 s=
context=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:cpus=
peed_exec_t:s0 tclass=3Dfile
TSC appears to be running slowly. Marking it as unstable
Time: acpi_pm clocksource has been installed.

--==_Exmh_1159811830_54180
Content-Type: text/plain ; name="dmesg.mm2-dyntick"; charset=iso-8859-1
Content-Description: dmesg.mm2-dyntick
Content-Disposition: attachment; filename="dmesg.mm2-dyntick"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.18-mm2-hrt-dyntick5 (valdis=40turing-police.cc.vt.edu) =
(gcc version 4.1.1 20060926 (Red Hat 4.1.1-26)) =231 PREEMPT Mon Oct 2 02=
:41:10 EDT 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 00000=
0000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000=
000000a0000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000002fee2800 end: 00000=
0002ffe2800 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000002ffe2800 size: 000000000001d800 end: 00000=
00030000000 type: 2
copy_e820_map() start: 00000000feda0000 size: 0000000000060000 end: 00000=
000fee00000 type: 2
copy_e820_map() start: 00000000ffb80000 size: 0000000000480000 end: 00000=
00100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ffe2800 (usable)
 BIOS-e820: 000000002ffe2800 - 0000000030000000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
767MB LOWMEM available.
Entering add_active_range(0, 0, 196578) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   196578
early_node_map=5B1=5D active PFN ranges
    0:        0 ->   196578
On node 0 totalpages: 196578
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1503 pages used for memmap
  Normal zone: 190979 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) =40 0x000fde50
ACPI: RSDT (v001 DELL    CPi R   0x27d40107 ASL  0x00000061) =40 0x000fde=
64
ACPI: FADT (v001 DELL    CPi R   0x27d40107 ASL  0x00000061) =40 0x000fde=
90
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) =40 0x000000=
00
ACPI: PM-Timer IO Port: 0x808
Allocating PCI resources starting at 40000000 (gap: 30000000:ceda0000)
Detected 1595.398 MHz processor.
Built 1 zonelists.  Total pages: 195043
Kernel command line: vga=3D794 quiet crashkernel=3D64M=4016M single
Local APIC disabled by BIOS -- you can enable it with =22lapic=22
mapped APIC to ffffd000 (05603000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU=230
Clock event device pit configured with caps set: 07
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 706888k/786312k available (2412k kernel code, 78852k reserved, 10=
44k data, 180k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xf0800000 - 0xfffb5000   ( 247 MB)
    lowmem  : 0xc0000000 - 0xeffe2000   ( 767 MB)
      .init : 0xc04e8000 - 0xc0515000   ( 180 kB)
      .data : 0xc035b03f - 0xc0460128   (1044 kB)
      .text : 0xc0100000 - 0xc035b03f   (2412 kB)
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
Calibrating delay using timer specific routine.. 3192.28 BogoMIPS (lpj=3D=
1596144)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 3febf9ff 00000000 00000000 00000000 00=
000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: 3febf9ff 00000000 00000000 00000080 00000000 =
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU=230.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz stepping 04
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0800)
checking if image is initramfs... it is
Freeing initrd memory: 1824k freed
NET: Registered protocol family 16
ACPI: ACPI Dock Station Driver=20
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbfee, last bus=3D2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge =5BPCI0=5D (0000:00)
ACPI: Assume root bridge =5B=5C_SB_.PCI0=5D bus is 0
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0._PRT=5D
ACPI: PCI Interrupt Link =5BLNKA=5D (IRQs 9 10 *11)
ACPI: PCI Interrupt Link =5BLNKB=5D (IRQs 5 7) *11
ACPI: PCI Interrupt Link =5BLNKC=5D (IRQs 9 10 *11)
ACPI: PCI Interrupt Link =5BLNKD=5D (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0.AGP_._PRT=5D
ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0.PCIE._PRT=5D
ACPI: Power Resource =5BPADA=5D (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
Intel 82802 RNG detected
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try =22pci=3Drouteirq=22.  If it helps, po=
st a report
NetLabel: Initializing
NetLabel:  domain hash size =3D 128
NetLabel:  protocols =3D UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:02: ioport range 0x800-0x805 could not be reserved
pnp: 00:02: ioport range 0x808-0x80f could not be reserved
pnp: 00:03: ioport range 0x806-0x807 has been reserved
pnp: 00:03: ioport range 0x810-0x85f could not be reserved
pnp: 00:03: ioport range 0x860-0x87f has been reserved
pnp: 00:03: ioport range 0x880-0x8bf has been reserved
pnp: 00:03: ioport range 0x8c0-0x8df has been reserved
pnp: 00:03: ioport range 0x8e0-0x8ff has been reserved
pnp: 00:08: ioport range 0x900-0x91f has been reserved
pnp: 00:08: ioport range 0x3f0-0x3f1 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: fc000000-fdffffff
  PREFETCH window: d8000000-e7ffffff
PCI: Bus 3, cardbus bridge: 0000:02:01.0
  IO window: 0000e000-0000e0ff
  IO window: 0000e400-0000e4ff
  PREFETCH window: 40000000-41ffffff
  MEM window: f4000000-f5ffffff
PCI: Bus 7, cardbus bridge: 0000:02:01.1
  IO window: 0000e800-0000e8ff
  IO window: 0000f000-0000f0ff
  PREFETCH window: 42000000-43ffffff
  MEM window: f6000000-f7ffffff
PCI: Bus 11, cardbus bridge: 0000:02:03.0
  IO window: 0000f400-0000f4ff
  IO window: 0000f800-0000f8ff
  PREFETCH window: 44000000-45ffffff
  MEM window: fa000000-fbffffff
PCI: Bridge: 0000:00:1e.0
  IO window: e000-ffff
  MEM window: f4000000-fbffffff
  PREFETCH window: 40000000-46ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:02:01.0 (0000 -> 0003)
ACPI: PCI Interrupt Link =5BLNKD=5D enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:01.0=5BA=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
PCI: Enabling device 0000:02:01.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:02:01.1=5BA=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
ACPI: PCI Interrupt 0000:02:03.0=5BA=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
speedstep: frequency transition measured seems out of range (0 nSec), fal=
ling back to a safe one of 500000 nSec.
audit: initializing netlink socket (disabled)
audit(1159802531.385:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
vesafb: framebuffer at 0xe0000000, mapped to 0xf0880000, using 5120k, tot=
al 32768k
vesafb: mode is 1280x1024x16, linelength=3D2560, pages=3D1
vesafb: protected mode interface info at c000:e140
vesafb: pmi: set display start =3D c00ce185, set palette =3D c00ce20a
vesafb: pmi: ports =3D b4c3 b503 ba03 c003 c103 c403 c503 c603 c703 c803 =
c903 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03 ff03=20
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
ACPI: Video Device =5BVID=5D (multi-head: yes  rom: no  post: no)
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is=
 60 seconds).
Hangcheck: Using get_cycles().
Serial: 8250/16550 driver =24Revision: 1.90 =24 4 ports, IRQ sharing enab=
led
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ACPI: PCI Interrupt Link =5BLNKB=5D enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6=5BB=5D -> Link =5BLNKB=5D -> GSI 5 (leve=
l, low) -> IRQ 5
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
RAMDISK driver initialized: 16 RAM disks of 10240K size 1024 blocksize
loop: loaded (max 8 devices)
ACPI: PCI Interrupt Link =5BLNKC=5D enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:00.0=5BA=5D -> Link =5BLNKC=5D -> GSI 11 (lev=
el, low) -> IRQ 11
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:00.0: 3Com PCI 3c905C Tornado at f0804c00.
ACPI: PCI Interrupt 0000:02:08.0=5BA=5D -> Link =5BLNKC=5D -> GSI 11 (lev=
el, low) -> IRQ 11
0000:02:08.0: 3Com PCI 3c905C Tornado at f0806800.
libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac7
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link =5BLNKA=5D enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.1=5BA=5D -> Link =5BLNKA=5D -> GSI 11 (lev=
el, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
scsi0 : ata_piix
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PC=
I)
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0=5BA=5D -> Link =5BLNKA=5D -> GSI 11 (lev=
el, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
usb usb1: new device found, idVendor=3D0000, idProduct=3D0000
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-mm2-hrt-dyntick5 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
usb usb1: configuration =231 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1=5BB=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 11, io base 0x0000bf40
usb usb2: new device found, idVendor=3D0000, idProduct=3D0000
usb usb2: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-mm2-hrt-dyntick5 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
usb usb2: configuration =231 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2=5BC=5D -> Link =5BLNKC=5D -> GSI 11 (lev=
el, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf20
usb usb3: new device found, idVendor=3D0000, idProduct=3D0000
usb usb3: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.18-mm2-hrt-dyntick5 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
usb usb3: configuration =231 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller =5BPNP0303:KBC,PNP0f13:PS2M=5D at 0x60,0x64 irq 1,12=

serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
ata1.00: ATA-6, max UDMA/100, 117210240 sectors: LBA=20
ata1.00: ata1: dev 0 multi count 8
ata1.01: ATAPI, max UDMA/33
ata1.00: configured for UDMA/100
usb 2-2: new low speed USB device using uhci_hcd and address 2
ata1.01: configured for UDMA/33
scsi1 : ata_piix
usb 2-2: new device found, idVendor=3D045e, idProduct=3D0023
usb 2-2: new device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 2-2: Product: Microsoft Trackball Optical=AE
usb 2-2: Manufacturer: Microsoft
usb 2-2: configuration =231 chosen from 1 choice
input: Microsoft Microsoft Trackball Optical=AE as /class/input/input2
input: USB HID v1.00 Mouse =5BMicrosoft Microsoft Trackball Optical=AE=5D=
 on usb-0000:00:1d.1-2
input: DualPoint Stick as /class/input/input3
input: AlpsPS/2 ALPS DualPoint TouchPad as /class/input/input4
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2060A 0000 PQ: 0 ANSI=
: 5
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda:<6>i2c /dev entries driver
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel=40r=
edhat.com
EDAC MC: Ver: 2.0.1 Oct  2 2006
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 13=
:55:50 2006 UTC).
ACPI: PCI Interrupt 0000:00:1f.5=5BB=5D -> Link =5BLNKB=5D -> GSI 5 (leve=
l, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ALSA device list:
  No soundcards found.
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
Clock event device pit configured with caps set: 08
Switched to high resolution mode on CPU 0
Freeing unused kernel memory: 180k freed
Write protecting the kernel read-only data: 434k
 sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
scsi 0:0:1:0: CD-ROM            TOSHIBA  CDRW/DVD SDR2102 1D13 PQ: 0 ANSI=
: 5
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:1:0: Attached scsi CD-ROM sr0
intel8x0_measure_ac97_clock: measured 51386 usecs
intel8x0: clocking to 48000
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  6 users, 5 roles, 2013 types, 80 bools, 1 sens, 1024 cats
security:  58 classes, 111120 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts=

SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts=

SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1159802536.642:2): policy loaded auid=3D4294967295
audit(1159802537.006:3): avc:  denied  =7B execute =7D for  pid=3D457 com=
m=3D=22rc.sysinit=22 name=3D=22hostname=22 dev=3Ddm-0 ino=3D33031 scontex=
t=3Dsystem_u:system_r:initrc_t:s0 tcontext=3Dsystem_u:object_r:hostname_e=
xec_t:s0 tclass=3Dfile
audit(1159802537.006:4): avc:  denied  =7B execute_no_trans =7D for  pid=
=3D457 comm=3D=22rc.sysinit=22 name=3D=22hostname=22 dev=3Ddm-0 ino=3D330=
31 scontext=3Dsystem_u:system_r:initrc_t:s0 tcontext=3Dsystem_u:object_r:=
hostname_exec_t:s0 tclass=3Dfile
audit(1159802537.006:5): avc:  denied  =7B read =7D for  pid=3D457 comm=
=3D=22rc.sysinit=22 name=3D=22hostname=22 dev=3Ddm-0 ino=3D33031 scontext=
=3Dsystem_u:system_r:initrc_t:s0 tcontext=3Dsystem_u:object_r:hostname_ex=
ec_t:s0 tclass=3Dfile
Real Time Clock Driver v1.12ac
audit(1159802539.162:6): avc:  denied  =7B dac_override =7D for  pid=3D48=
7 comm=3D=22dmesg=22 capability=3D1 scontext=3Dsystem_u:system_r:dmesg_t:=
s0 tcontext=3Dsystem_u:system_r:dmesg_t:s0 tclass=3Dcapability
audit(1159802540.991:7): avc:  denied  =7B dac_override =7D for  pid=3D54=
2 comm=3D=22pam_console_app=22 capability=3D1 scontext=3Dsystem_u:system_=
r:pam_console_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:system_r:pam_console_t=
:s0-s0:c0.c1023 tclass=3Dcapability
ACPI: PCI Interrupt 0000:02:01.2=5BA=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D=5B11=5D  MMIO=3D=5Bf8fff0=
00-f8fff7ff=5D  Max Packet=3D=5B2048=5D  IR/IT contexts=3D=5B4/4=5D
Yenta: CardBus bridge found at 0000:02:01.0 =5B1028:00d5=5D
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:01.0, mfunc 0x05033002, devctl 0x64
Yenta: CardBus bridge found at 0000:02:01.1 =5B1028:00d5=5D
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:01.1, mfunc 0x05033002, devctl 0x64
Yenta: CardBus bridge found at 0000:02:03.0 =5B12a3:ab01=5D
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:03.0, mfunc 0x01000002, devctl 0x60
Linux agpgart interface v0.101 (c) Dave Jones
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.00 (30-Jul-2006)
iTCO_wdt: Found a ICH3-M TCO device (Version=3D1, TCOBASE=3D0x0860)
iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
agpgart: Detected an Intel i845 Chipset.
agpgart: AGP aperture is 64M =40 0xe8000000
ohci1394: fw-host0: Running dma failed because Node ID is not valid
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000020
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xffff
cs: IO port probe 0xe000-0xffff: clean.
pcmcia: parent PCI bridge Memory window: 0xf4000000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x46ffffff
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xffff
cs: IO port probe 0xe000-0xffff: clean.
pcmcia: parent PCI bridge Memory window: 0xf4000000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x46ffffff
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000010
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xffff
cs: IO port probe 0xe000-0xffff: clean.
pcmcia: parent PCI bridge Memory window: 0xf4000000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x46ffffff
pccard: CardBus card inserted into slot 0
PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:00.0=5BA=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
PCI: Setting latency timer of device 0000:03:00.0 to 64
eth2: Xircom cardbus revision 3 at irq 11=20
PCI: Enabling device 0000:03:00.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:00.1=5BA=5D -> Link =5BLNKD=5D -> GSI 11 (lev=
el, low) -> IRQ 11
0000:03:00.1: ttyS1 at I/O 0xe080 (irq =3D 11) is a 16550A
ohci1394: fw-host0: AT dma reset ctx=3D0, aborting transmission
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
pccard: PCMCIA card inserted into slot 2
ieee1394: Host added: ID:BUS=5B0-00:1023=5D  GUID=5B374fc0002a71c021=5D
cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: memory probe 0xf4000000-0xfbffffff: excluding 0xf4000000-0xf8ffffff 0=
xfa000000-0xfbffffff
pcmcia: registering new device pcmcia2.0
cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
orinoco 0.15 (David Gibson <hermes=40gibson.dropbear.id.au>, Pavel Roskin=
 <proski=40gnu.org>, et al)
orinoco_cs 0.15 (David Gibson <hermes=40gibson.dropbear.id.au>, Pavel Ros=
kin <proski=40gnu.org>, et al)
pcmcia: request for exclusive IRQ could not be fulfilled.
pcmcia: the driver needs updating to supported shared IRQ lines.
eth2: Hardware identity 0005:0004:0005:0000
eth2: Station identity  001f:0001:0008:000a
eth2: Firmware determined as Lucent/Agere 8.10
eth2: Ad-hoc demo mode supported
eth2: IEEE standard IBSS ad-hoc mode supported
eth2: WEP supported, 104-bit key
eth2: MAC address 00:02:2D:5C:11:48
eth2: Station name =22HERMES I=22
eth2: ready
eth2: orinoco_cs at 2.0, irq 11, io 0xe100-0xe13f
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Dell laptop SMM driver v1.14 21/02/2005 Massimo Dal Zotto (dz=40debian.or=
g)
Netfilter messages via NETLINK v0.30.
audit(1159802546.388:8): avc:  denied  =7B getattr =7D for  pid=3D456 com=
m=3D=22rc.sysinit=22 name=3D=22hostname=22 dev=3Ddm-0 ino=3D33031 scontex=
t=3Dsystem_u:system_r:initrc_t:s0 tcontext=3Dsystem_u:object_r:hostname_e=
xec_t:s0 tclass=3Dfile
ACPI: AC Adapter =5BAC=5D (on-line)
ACPI: Battery Slot =5BBAT0=5D (battery absent)
ACPI: Battery Slot =5BBAT1=5D (battery absent)
ACPI: Lid Switch =5BLID=5D
ACPI: Power Button (CM) =5BPBTN=5D
ACPI: Sleep Button (CM) =5BSBTN=5D
Using specific hotkey driver
ACPI: Processor =5BCPU0=5D (supports 8 throttling states)
ACPI: Thermal Zone =5BTHM=5D (68 C)
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-11, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-7, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-8, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-9, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-10, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-6, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-4, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-5, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-1, type ext3), uses xattr
Adding 1572856k swap on /dev/rootvg/swap.  Priority:-1 extents:1 across:1=
572856k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_cont=
exts
audit(1159802586.630:9): avc:  denied  =7B getattr =7D for  pid=3D1502 co=
mm=3D=22bash=22 name=3D=22spamassassin=22 dev=3Ddm-0 ino=3D197880 scontex=
t=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:initrc_exe=
c_t:s0 tclass=3Dfile
audit(1159802586.630:10): avc:  denied  =7B execute =7D for  pid=3D1502 c=
omm=3D=22bash=22 name=3D=22spamassassin=22 dev=3Ddm-0 ino=3D197880 sconte=
xt=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:initrc_ex=
ec_t:s0 tclass=3Dfile
audit(1159802586.630:11): avc:  denied  =7B read =7D for  pid=3D1502 comm=
=3D=22bash=22 name=3D=22spamassassin=22 dev=3Ddm-0 ino=3D197880 scontext=
=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:initrc_exec=
_t:s0 tclass=3Dfile
audit(1159802592.469:12): avc:  denied  =7B execute_no_trans =7D for  pid=
=3D1525 comm=3D=22bash=22 name=3D=22cpuspeed=22 dev=3Ddm-0 ino=3D197100 s=
context=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:init=
rc_exec_t:s0 tclass=3Dfile
audit(1159802592.506:13): avc:  denied  =7B ioctl =7D for  pid=3D1525 com=
m=3D=22cpuspeed=22 name=3D=22cpuspeed=22 dev=3Ddm-0 ino=3D197100 scontext=
=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:initrc_exec=
_t:s0 tclass=3Dfile
audit(1159802592.551:14): avc:  denied  =7B getattr =7D for  pid=3D1525 c=
omm=3D=22cpuspeed=22 name=3D=22cpuspeed=22 dev=3Ddm-7 ino=3D295240 sconte=
xt=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:cpuspeed_=
exec_t:s0 tclass=3Dfile
audit(1159802592.585:15): avc:  denied  =7B execute =7D for  pid=3D1529 c=
omm=3D=22bash=22 name=3D=22cpuspeed=22 dev=3Ddm-7 ino=3D295240 scontext=
=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:cpuspeed_ex=
ec_t:s0 tclass=3Dfile
audit(1159802592.585:16): avc:  denied  =7B read =7D for  pid=3D1529 comm=
=3D=22bash=22 name=3D=22cpuspeed=22 dev=3Ddm-7 ino=3D295240 scontext=3Dsy=
stem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:cpuspeed_exec_t:=
s0 tclass=3Dfile
audit(1159802592.586:17): avc:  denied  =7B execute_no_trans =7D for  pid=
=3D1530 comm=3D=22bash=22 name=3D=22cpuspeed=22 dev=3Ddm-7 ino=3D295240 s=
context=3Dsystem_u:system_r:sysadm_t:s0 tcontext=3Dsystem_u:object_r:cpus=
peed_exec_t:s0 tclass=3Dfile

--==_Exmh_1159811830_54180--


--==_Exmh_1159813528_5418P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFIVmYcC3lWbTT17ARAokoAKCFt2D7AXkl9RXk3oKxzWOFuGcVAQCgg2eD
SEiEIdltYi/xdtm213pecHY=
=ZQCw
-----END PGP SIGNATURE-----

--==_Exmh_1159813528_5418P--
