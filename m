Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWCIML7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWCIML7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWCIML7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:11:59 -0500
Received: from mail.phnxsoft.com ([195.227.45.4]:35846 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S932314AbWCIML6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:11:58 -0500
Message-ID: <44101B83.9060503@imap.cc>
Date: Thu, 09 Mar 2006 13:11:47 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc5-mm3
References: <5NHCi-8jp-5@gated-at.bofh.it>
In-Reply-To: <5NHCi-8jp-5@gated-at.bofh.it>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4D7F6823BFF7D88C9B590D15"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4D7F6823BFF7D88C9B590D15
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/

This panics and dies during early boot with a divide error in kmem_cache_init
on my Dell GX110.

Screen messages (copied manually, beware of typos):

--------8<--------8<--------8<--------8<--------8<--------8<--------8<--------8<
divide error: 0000 [#1]
PREEMPT
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<c04766d5>]   Not tainted VLI
EFLAGS: 00010246   (2.6.16-rc5-mm3-noinitrd #1)
EIP is at kmem_cache_init+0xe2/0x2cf
eax: 00001000   ebx: c040606c   ecx: 000003f9   edx: 00000000
esi: c0406180   edi: c048b86c   ebp: 00510007   esp: c0465fe0
ds: 007b  es: 007b  ss: 0068
Process swapper (pid: 0, threadinfo=c0464000 task=c03ffc00)
Stack: <0>00001000 00000002 00099100 c0458800 00510007 c04664a1 c0497720 c0100199
Call Trace:
<c04664a1> start_kernel+0x132/0x2b8
<0>Kernel panic - not syncing: Attempted to kill the idle task!
-------->8-------->8-------->8-------->8-------->8-------->8-------->8-------->8

This is how it comes up with 2.6.16-rc5-mm2 which runs just fine:

--------8<--------8<--------8<--------8<--------8<--------8<--------8<--------8<
Inspecting /boot/System.map-2.6.16-rc5-mm2-noinitrd
Loaded 26134 symbols from /boot/System.map-2.6.16-rc5-mm2-noinitrd.
Symbols match kernel version 2.6.16.
No module symbols loaded - kernel modules not enabled.

klogd 1.4.1, log source = ksyslog started.
<5>[    0.000000] Linux version 2.6.16-rc5-mm2-noinitrd (ts@gx110) (gcc version 4.0.2 20050901 (prerelease) (SUSE Linux)) #1 PREEMPT Fri Mar 3 20:20:19 CET 2006
<6>[    0.000000] BIOS-provided physical RAM map:
<4>[    0.000000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
<4>[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4>[    0.000000]  BIOS-e820: 0000000000100000 - 0000000017eac000 (usable)
<4>[    0.000000]  BIOS-e820: 0000000017eac000 - 0000000018000000 (reserved)
<4>[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
<5>[    0.000000] 382MB LOWMEM available.
<7>[    0.000000] On node 0 totalpages: 97964
<7>[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
<7>[    0.000000]   DMA32 zone: 0 pages, LIFO batch:0
<7>[    0.000000]   Normal zone: 93868 pages, LIFO batch:31
<7>[    0.000000]   HighMem zone: 0 pages, LIFO batch:0
<6>[    0.000000] DMI 2.3 present.
<7>[    0.000000] ACPI: RSDP (v000 DELL                                  ) @ 0x000fd790
<7>[    0.000000] ACPI: RSDT (v001 DELL    GX110   0x00000007 ASL  0x00000061) @ 0x000fd7a4
<7>[    0.000000] ACPI: FADT (v001 DELL    GX110   0x00000007 ASL  0x00000061) @ 0x000fd7cc
<7>[    0.000000] ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000b) @ 0x00000000
<6>[    0.000000] ACPI: PM-Timer IO Port: 0x808
<4>[    0.000000] Allocating PCI resources starting at 20000000 (gap: 18000000:e7b00000)
<4>[    0.000000] Detected 931.113 MHz processor.
<4>[   36.306277] Built 1 zonelists
<5>[   36.306283] Kernel command line: root=/dev/hda3 selinux=0 x11i=vesa video=intelfb:mode=1024x768-32@70
<4>[   36.306758] Local APIC disabled by BIOS -- you can enable it with "lapic"
<7>[   36.306783] mapped APIC to ffffd000 (016be000)
<6>[   36.306791] Enabling fast FPU save and restore... done.
<6>[   36.306798] Enabling unmasked SIMD FPU exception support... done.
<6>[   36.306806] Initializing CPU#0
<4>[   36.306920] PID hash table entries: 2048 (order: 11, 32768 bytes)
<4>[   36.528461] Console: colour VGA+ 80x25
<4>[   36.530748] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
<4>[   36.532366] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
<6>[   36.580081] Memory: 379940k/391856k available (2099k kernel code, 11396k reserved, 1375k data, 184k init, 0k highmem)
<4>[   36.580181] Checking if this processor honours the WP bit even in supervisor mode... Ok.
<4>[   36.658682] Calibrating delay using timer specific routine.. 1863.59 BogoMIPS (lpj=3727195)
<6>[   36.658924] Security Framework v1.0.0 initialized
<6>[   36.658992] SELinux:  Disabled at boot.
<4>[   36.659103] Mount-cache hash table entries: 512
<7>[   36.659769] CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
<7>[   36.659786] CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
<6>[   36.659810] CPU: L1 I cache: 16K, L1 D cache: 16K
<6>[   36.659899] CPU: L2 cache: 256K
<7>[   36.659957] CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
<6>[   36.659973] Intel machine check architecture supported.
<6>[   36.660035] Intel machine check reporting enabled on CPU#0.
<4>[   36.660134] CPU: Intel Pentium III (Coppermine) stepping 0a
<6>[   36.660288] Checking 'hlt' instruction... OK.
<6>[   36.674824] SMP alternatives: switching to UP code
<6>[   36.674885] Freeing SMP alternatives: 0k freed
<4>[   36.698455] ACPI: setting ELCR to 0200 (from 0e20)
<6>[   36.702372] NET: Registered protocol family 16
<6>[   36.702677] ACPI: bus type pci registered
<6>[   36.702750] PCI: Using configuration type 1
<6>[   36.704987] ACPI: Subsystem revision 20060210
<6>[   36.717834] ACPI: Interpreter enabled
<6>[   36.717912] ACPI: Using PIC for interrupt routing
<6>[   36.720715] ACPI: PCI Root Bridge [PCI0] (0000:00)
<7>[   36.720797] PCI: Probing PCI hardware (bus 00)
<6>[   36.720932] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
<7>[   36.726250] Boot video device is 0000:00:01.0
<4>[   36.726410] PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
<4>[   36.726484] PCI quirk: region 0880-08bf claimed by ICH4 GPIO
<6>[   36.727267] PCI: Transparent bridge - 0000:00:1e.0
<7>[   36.727374] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>[   36.736679] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
<4>[   36.754720] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 15)
<4>[   36.756840] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
<4>[   36.759046] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 15)
<4>[   36.761159] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
<6>[   36.762140] Linux Plug and Play Support v0.97 (c) Adam Belay
<6>[   36.762254] pnp: PnP ACPI init
<6>[   36.791389] pnp: PnP ACPI: found 13 devices
<6>[   36.791979] usbcore: registered new driver usbfs
<6>[   36.792359] usbcore: registered new driver hub
<6>[   36.793373] PCI: Using ACPI for IRQ routing
<6>[   36.793441] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
<4>[   36.793704] Setting up standard PCI resources
<6>[   36.801664] pnp: 00:0c: ioport range 0x800-0x85f could not be reserved
<6>[   36.801740] pnp: 00:0c: ioport range 0xc00-0xc7f has been reserved
<6>[   36.801807] pnp: 00:0c: ioport range 0x860-0x8ff could not be reserved
<4>[   36.804652] PCI: Ignore bogus resource 6 [0:0] of 0000:00:01.0
<6>[   36.804742] PCI: Bridge: 0000:00:1e.0
<6>[   36.804800]   IO window: e000-efff
<6>[   36.804863]   MEM window: fd000000-feffffff
<6>[   36.804924]   PREFETCH window: 20000000-200fffff
<7>[   36.805001] PCI: Setting latency timer of device 0000:00:1e.0 to 64
<6>[   36.806341] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
<5>[   36.806415] apm: overridden by ACPI.
<4>[   36.806472] initcall at 0xc04721ee: apm_init+0x0/0x2f8(): returned with error code -19
<4>[   36.806845] initcall at 0xc0475b85: init_hpet_clocksource+0x0/0x72(): returned with error code -19
<6>[   36.817255] audit: initializing netlink socket (disabled)
<5>[   36.817404] audit(1141805849.240:1): initialized
<4>[   36.818047] Total HugeTLB memory allocated, 0
<5>[   36.818684] VFS: Disk quotas dquot_6.5.1
<4>[   36.818846] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>[   36.819965] Initializing Cryptographic API
<6>[   36.820048] io scheduler noop registered
<6>[   36.820162] io scheduler anticipatory registered
<6>[   36.820264] io scheduler deadline registered (default)
<6>[   36.820448] io scheduler cfq registered
<6>[   36.822275] ACPI: Power Button (FF) [PWRF]
<4>[   36.824622] ACPI Error (acpi_processor-0488): Getting cpuindex for acpiid 0x2 [20060210]
<6>[   36.825026] isapnp: Scanning for PnP cards...
<6>[   37.180109] isapnp: No Plug & Play device found
<6>[   37.413972] Real Time Clock Driver v1.12ac
<6>[   37.415480] Linux agpgart interface v0.101 (c) Dave Jones
<6>[   37.415969] agpgart: Detected an Intel i810 E Chipset.
<6>[   37.423950] agpgart: detected 4MB dedicated video ram.
<6>[   37.431144] agpgart: AGP aperture is 64M @ 0xf8000000
<4>[   37.432961] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
<7>[   37.433034] PCI: setting IRQ 9 as level-triggered
<6>[   37.433041] ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
<4>[   37.440891] i810-i2c: Probe DDC1 Bus
<4>[   37.442391] i810-i2c: Unable to read EDID block.
<4>[   37.443853] i810-i2c: Unable to read EDID block.
<4>[   37.445314] i810-i2c: Unable to read EDID block.
<4>[   37.445374] i810-i2c: Probe DDC2 Bus
<4>[   37.446893] i810-i2c: Unable to read EDID block.
<4>[   37.448355] i810-i2c: Unable to read EDID block.
<4>[   37.449816] i810-i2c: Unable to read EDID block.
<4>[   37.449875] i810-i2c: Probe DDC3 Bus
<4>[   37.449931] i810-i2c: Getting EDID from BIOS
<4>[   37.449990] i810fb_init_pci: DDC probe successful
<4>[   37.450051] i810fb_init_pci: Unable to get Mode Database
<4>[   37.465222] Console: switching to colour frame buffer device 80x30
<4>[   37.467349] I810FB: fb0         : Intel(R) 810E Framebuffer Device v0.9.0
<4>[   37.467353] I810FB: Video RAM   : 4096K
<4>[   37.467356] I810FB: Monitor     : H: 29-30 KHz V: 60-60 Hz
<4>[   37.467360] I810FB: Mode        : 640x480-8bpp@60Hz
<6>[   37.475552] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
<6>[   37.480127] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<6>[   37.482826] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<6>[   37.487498] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<6>[   37.490628] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<6>[   37.493698] Floppy drive(s): fd0 is 1.44M
<6>[   37.511882] FDC 0 is a National Semiconductor PC87306
<4>[   37.520473] RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
<6>[   37.527680] loop: loaded (max 8 devices)
<4>[   37.531677] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
<7>[   37.534067] PCI: setting IRQ 5 as level-triggered
<6>[   37.534381] ACPI: PCI Interrupt 0000:01:0c.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
<4>[   37.539399] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
<6>[   37.544587] 0000:01:0c.0: 3Com PCI 3c905C Tornado at d881ec00.
<6>[   37.569770] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>[   37.572683] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>[   37.578910] ICH: IDE controller at PCI slot 0000:00:1f.1
<6>[   37.581890] ICH: chipset revision 2
<6>[   37.584777] ICH: not 100% native mode: will probe irqs later
<6>[   37.587739]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
<6>[   37.593841]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
<7>[   37.599964] Probing IDE interface ide0...
<4>[   37.885962] hda: IC35L060AVER07-0, ATA DISK drive
<4>[   38.557761] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<7>[   38.561509] Probing IDE interface ide1...
<4>[   39.296985] hdc: TOSHIBA DVD-ROM SDM2012C, ATAPI CD/DVD-ROM drive
<4>[   39.968691] ide1 at 0x170-0x177,0x376 on irq 15
<6>[   39.974226] hda: max request size: 128KiB
<6>[   39.987855] hda: 120103200 sectors (61492 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(66)
<6>[   39.994600] hda: cache flushes not supported
<6>[   39.998219]  hda: hda1 hda2 hda3 hda4
<6>[   40.030449] usbcore: registered new driver libusual
<6>[   40.034306] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
<6>[   40.042547] serio: i8042 AUX port at 0x60,0x64 irq 12
<6>[   40.045916] serio: i8042 KBD port at 0x60,0x64 irq 1
<6>[   40.050108] mice: PS/2 mouse device common for all mice
<6>[   40.054472] input: PC Speaker as /class/input/input0
<6>[   40.086375] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>[   40.089315] md: bitmap version 4.39
<6>[   40.092376] NET: Registered protocol family 2
<4>[   40.128518] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
<4>[   40.132236] TCP established hash table entries: 16384 (order: 6, 262144 bytes)
<4>[   40.139255] TCP bind hash table entries: 16384 (order: 6, 327680 bytes)
<6>[   40.143936] TCP: Hash tables configured (established 16384 bind 16384)
<6>[   40.146992] TCP reno registered
<6>[   40.150279] TCP bic registered
<6>[   40.153198] NET: Registered protocol family 1
<4>[   40.156542] Using IPI Shortcut mode
<4>[   40.159319] initcall at 0xc0130fb6: software_resume+0x0/0xd1(): returned with error code -2
<6>[   40.165722] ACPI: wakeup devices: PCI0 USB0 PCI1  KBD
<6>[   40.169285] ACPI: (supports S0 S1 S4 S5)
<6>[   40.173633] md: Autodetecting RAID arrays.
<6>[   40.176467] md: autorun ...
<6>[   40.179178] md: ... autorun DONE.
<6>[   40.181825] Time: tsc clocksource has been installed.
<5>[   40.197747] ReiserFS: hda3: found reiserfs format "3.6" with standard journal
<5>[   41.522590] ReiserFS: hda3: using ordered data mode
<5>[   41.537444] ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
<5>[   41.551230] ReiserFS: hda3: checking transaction log (hda3)
<5>[   41.597774] ReiserFS: hda3: Using r5 hash to sort names
<4>[   41.601265] VFS: Mounted root (reiserfs filesystem) readonly.
<6>[   41.604343] Freeing unused kernel memory: 184k freed
<4>[   41.607624] Write protecting the kernel read-only data: 954k
<6>[   42.865625] md: Autodetecting RAID arrays.
<3>[   42.865700] BUG: sleeping function called from invalid context at mm/slab.c:2752
<4>[   42.865707] in_atomic():1, irqs_disabled():1
<4>[   42.865714]  <c014fb4c> kmem_cache_alloc+0x20/0x77   <c02595ce> i810fb_cursor+0x1bd/0x2c9
<4>[   42.865769]  <c01a3760> search_by_key+0x1a5/0xe04   <c020f047> bit_cursor+0x475/0x498
<4>[   42.865811]  <c020c3cb> fbcon_cursor+0x226/0x25b   <c020ebd2> bit_cursor+0x0/0x498
<4>[   42.865827]  <c024ddd6> hide_cursor+0x1d/0x53   <c02519d0> vt_console_print+0x8b/0x21e
<4>[   42.865853]  <c0251945> vt_console_print+0x0/0x21e   <c0117b54> __call_console_drivers+0x34/0x40
<4>[   42.865875]  <c0117d54> release_console_sem+0xeb/0x185   <c01186ba> vprintk+0x298/0x2d9
<4>[   42.865892]  <c0168e00> d_splice_alias+0xc7/0xe3   <c0191622> reiserfs_lookup+0xed/0xf8
<4>[   42.865913]  <c011870d> printk+0x12/0x16   <c029f270> md_ioctl+0xc3/0x1289
<4>[   42.865941]  <c030c150> _spin_unlock+0xf/0x23   <c030c150> _spin_unlock+0xf/0x23
<4>[   42.865972]  <c030c150> _spin_unlock+0xf/0x23   <c016942f> inode_init_once+0x1a3/0x1cd
<4>[   42.865988]  <c01f228f> blkdev_driver_ioctl+0x49/0x59   <c01f29a0> blkdev_ioctl+0x6b6/0x6d6
<4>[   42.866018]  <c030b712> __mutex_lock_slowpath+0x2ca/0x39a   <c012af2d> debug_mutex_add_waiter+0x14/0x27
<4>[   42.866048]  <c015aa0e> do_open+0x5b/0x32a   <c030b712> __mutex_lock_slowpath+0x2ca/0x39a
<4>[   42.866065]  <c015aa0e> do_open+0x5b/0x32a   <c030c150> _spin_unlock+0xf/0x23
<4>[   42.866079]  <c030c232> _read_unlock_irq+0x10/0x24   <c0138a0d> find_get_page+0x35/0x3a
<4>[   42.866097]  <c013a11b> filemap_nopage+0x1a1/0x31f   <c030c150> _spin_unlock+0xf/0x23
<4>[   42.866113]  <c01439af> __handle_mm_fault+0x3e5/0x757   <c015a329> block_ioctl+0x13/0x16
<4>[   42.866128]  <c015a316> block_ioctl+0x0/0x16   <c01634d8> do_ioctl+0x1c/0x5d
<4>[   42.866152]  <c016376e> vfs_ioctl+0x255/0x268   <c01637c7> sys_ioctl+0x46/0x5f
<4>[   42.866168]  <c0102b3b> sysenter_past_esp+0x54/0x75
<6>[   42.997457] md: autorun ...
<6>[   43.001103] md: ... autorun DONE.
<6>[   46.263181] device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
<3>[   46.263269] BUG: sleeping function called from invalid context at mm/slab.c:2752
<4>[   46.263276] in_atomic():1, irqs_disabled():1
<4>[   46.263283]  <c014fb4c> kmem_cache_alloc+0x20/0x77   <c02595ce> i810fb_cursor+0x1bd/0x2c9
<4>[   46.263339]  <c020f047> bit_cursor+0x475/0x498   <c0101d39> __switch_to+0x19/0x1b4
<4>[   46.263370]  <c020c3cb> fbcon_cursor+0x226/0x25b   <c020ebd2> bit_cursor+0x0/0x498
<4>[   46.263386]  <c024ddd6> hide_cursor+0x1d/0x53   <c02519d0> vt_console_print+0x8b/0x21e
<4>[   46.263412]  <c0251945> vt_console_print+0x0/0x21e   <c0117b54> __call_console_drivers+0x34/0x40
<4>[   46.263436]  <c0117d54> release_console_sem+0xeb/0x185   <c01186ba> vprintk+0x298/0x2d9
<4>[   46.263453]  <c0263ede> class_device_add+0x234/0x25b   <c011870d> printk+0x12/0x16
<4>[   46.263482]  <d885f196> dm_interface_init+0x51/0x58 [dm_mod]   <d885f0d2> dm_init+0x12/0x39 [dm_mod]
<4>[   46.263548]  <c012e4ac> sys_init_module+0x1259/0x13a5   <c0102b3b> sysenter_past_esp+0x54/0x75
<6>[   48.444915] NTFS driver 2.1.26 [Flags: R/W MODULE].
<3>[   48.445001] BUG: sleeping function called from invalid context at mm/slab.c:2752
<4>[   48.445007] in_atomic():1, irqs_disabled():1
<4>[   48.445015]  <c014fb4c> kmem_cache_alloc+0x20/0x77   <c02595ce> i810fb_cursor+0x1bd/0x2c9
<4>[   48.445073]  <c013d256> __alloc_pages+0x2c0/0x2d2   <c020f047> bit_cursor+0x475/0x498
<4>[   48.445110]  <c030c150> _spin_unlock+0xf/0x23   <c020c3cb> fbcon_cursor+0x226/0x25b
<4>[   48.445141]  <c020ebd2> bit_cursor+0x0/0x498   <c024ddd6> hide_cursor+0x1d/0x53
<4>[   48.445169]  <c02519d0> vt_console_print+0x8b/0x21e   <c0251945> vt_console_print+0x0/0x21e
<4>[   48.445183]  <c0117b54> __call_console_drivers+0x34/0x40   <c0117d54> release_console_sem+0xeb/0x185
<4>[   48.445208]  <c01186ba> vprintk+0x298/0x2d9   <c0189818> sysfs_new_dirent+0x17/0x56
<4>[   48.445236]  <c013c75d> free_pages_bulk+0x27/0x234   <c011870d> printk+0x12/0x16
<4>[   48.445252]  <d885f00b> init_ntfs_fs+0xb/0x1a1 [ntfs]   <c012e4ac> sys_init_module+0x1259/0x13a5
<4>[   48.445293]  <c0102b3b> sysenter_past_esp+0x54/0x75
<6>[   48.596640] NTFS volume version 3.1.
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.
-------->8-------->8-------->8-------->8-------->8-------->8-------->8-------->8

(Yeah, that sleeping BUG has been around for some time, I have been meaning
to report it but never got around to it, sorry.)

HTH
Tilman

--
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeöffnet mindestens haltbar bis: (siehe Rückseite)

--------------enig4D7F6823BFF7D88C9B590D15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEEBuDMdB4Whm86/kRAiLoAJwINqLOD6ozwugtkakNFvg8d41M+gCeNavM
UcSdb0T2fFRT5Ipx/2rcpgE=
=mmJy
-----END PGP SIGNATURE-----

--------------enig4D7F6823BFF7D88C9B590D15--
