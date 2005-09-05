Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVIEITv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVIEITv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVIEITv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:19:51 -0400
Received: from main.gmane.org ([80.91.229.2]:2536 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932359AbVIEITu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:19:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: 2.6.13 (was 2.6.11.11) and rsync oops (SATA or NFS related?)
Date: Mon, 05 Sep 2005 17:13:42 +0900
Message-ID: <dfguoq$eng$1@sea.gmane.org>
References: <dfg2sa$peu$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040502000705020604010503"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
In-Reply-To: <dfg2sa$peu$2@sea.gmane.org>
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040502000705020604010503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kalin KOZHUHAROV wrote:
> Hi, there.
> Long time no posting - didn't have kernel problems for long time :-)
> 
> That is why I am still running 2.6.11.11 (2.6.12 elsewhere). Will move
> to 2.6.13 soon.
> 
> Yesterday just bought a new SATAII drive (Seagate Barracuda 7200.8
> ST3300831AS) and while trying to rsync some data from the old drives the
> rsync process died with segfault. My SiI3112 controller is not SATAII,
> but it should work in SATA mode, have another drive for year+. Looking
> at the dmesg I saw 3 oopses (see the shortened .dmesg file). Run the
> ksymoops and got some output (see .ksymoops.bz2).
> 
> Although it does not seem very related to the drive, that is the only
> recent change in hardware, in software: udev . The machine (MB: A7V8X
> Deluxe) was working stable for 6 months with a few restarts.
> 
> As far as reproducibility goes, apart from those 3 oopses everything is
> OK, didn't even have to restart and am now continuing to rsync some
> 200GB more.
> 
> Any ideas as to what caused this?

OK, I upgraded to the latest 2.6.13 kernel and still got (similar?) oops.

Looking again at it it might be NFS (using v4 recently) related.

Will provide config if needed.

Attaching the new oops.


Any ideas what are all the warnings from ksymoops like that:

...
Warning (compare_maps): vmlinux symbol __crc_IO_APIC_get_PCI_irq_vector 
not found in System.map.  Ignoring System.map entry
Warning (compare_maps): vmlinux symbol __crc_I_BDEV not found in 
System.map.  Ignoring System.map entry
Warning (compare_maps): vmlinux symbol __crc_SELECT_DRIVE not found in 
System.map.  Ignoring System.map entry
...

Running ksymoops without "-v" option clears them, but... I shall I omit 
the "-m" option when I use "-v"?

BTW, runnig with CONFIG_PRINTK_TIME=y cannot pipe directly into ksymoops 
:-( Disabling.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|


--------------040502000705020604010503
Content-Type: text/plain;
 name="2005-09-05.3.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2005-09-05.3.dmesg"

[17179569.184000] Linux version 2.6.13-dorf (root@dorf) (gcc version 3.3.5-20050130 (Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #2 Mon Sep 5 11:50:42 JST 2005
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[17179569.184000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
[17179569.184000]  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
[17179569.184000]  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
[17179569.184000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[17179569.184000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[17179569.184000] 127MB HIGHMEM available.
[17179569.184000] 896MB LOWMEM available.
[17179569.184000] On node 0 totalpages: 262128
[17179569.184000]   DMA zone: 4096 pages, LIFO batch:1
[17179569.184000]   Normal zone: 225280 pages, LIFO batch:31
[17179569.184000]   HighMem zone: 32752 pages, LIFO batch:15
[17179569.184000] DMI 2.2 present.
[17179569.184000] ACPI: RSDP (v000 Nvidia                                ) @ 0x000f75e0
[17179569.184000] ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
[17179569.184000] ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
[17179569.184000] ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff74c0
[17179569.184000] ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
[17179569.184000] ACPI: Local APIC address 0xfee00000
[17179569.184000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[17179569.184000] Processor #0 6:10 APIC version 16
[17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[17179569.184000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[17179569.184000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[17179569.184000] ACPI: BIOS IRQ0 pin2 override ignored.
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[17179569.184000] ACPI: IRQ9 used by override.
[17179569.184000] ACPI: IRQ14 used by override.
[17179569.184000] ACPI: IRQ15 used by override.
[17179569.184000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[17179569.184000] Using ACPI (MADT) for SMP configuration information
[17179569.184000] Allocating PCI resources starting at 40000000 (gap: 40000000:bec00000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Kernel command line: root=/dev/hde1 udev nodevfs
[17179569.184000] mapped APIC to ffffd000 (fee00000)
[17179569.184000] mapped IOAPIC to ffffc000 (fec00000)
[17179569.184000] Initializing CPU#0
[17179569.184000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[    0.000000] Detected 1837.618 MHz processor.
[   26.404904] Using tsc for high-res timesource
[   26.406447] Console: colour VGA+ 80x25
[   26.407482] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   26.408067] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   26.433823] Memory: 1034860k/1048512k available (2283k kernel code, 12872k reserved, 1041k data, 176k init, 131008k highmem)
[   26.433857] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   26.512564] Calibrating delay using timer specific routine.. 3680.08 BogoMIPS (lpj=7360161)
[   26.512621] Security Framework v1.0.0 initialized
[   26.512642] Capability LSM initialized
[   26.512667] Mount-cache hash table entries: 512
[   26.512793] CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
[   26.512800] CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
[   26.512807] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   26.512828] CPU: L2 Cache: 512K (64 bytes/line)
[   26.512845] CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000 00000000 00000000
[   26.512851] Intel machine check architecture supported.
[   26.512869] Intel machine check reporting enabled on CPU#0.
[   26.512895] mtrr: v2.0 (20020519)
[   26.512913] CPU: AMD Athlon(tm) XP 2500+ stepping 00
[   26.512941] Enabling fast FPU save and restore... done.
[   26.512963] Enabling unmasked SIMD FPU exception support... done.
[   26.512988] Checking 'hlt' instruction... OK.
[   26.551531] ENABLING IO-APIC IRQs
[   26.551736] ..TIMER: vector=0x31 pin1=0 pin2=-1
[   26.696807] NET: Registered protocol family 16
[   26.696846] ACPI: bus type pci registered
[   26.712830] PCI: PCI BIOS revision 2.10 entry at 0xfb490, last bus=3
[   26.712855] PCI: Using configuration type 1
[   26.713170] ACPI: Subsystem revision 20050408
[   26.727547] ACPI: Interpreter enabled
[   26.727565] ACPI: Using IOAPIC for interrupt routing
[   26.728132] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   26.728151] PCI: Probing PCI hardware (bus 00)
[   26.728292] ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
[   26.732340] PCI: nForce2 C1 Halt Disconnect fixup
[   26.733264] Boot video device is 0000:03:00.0
[   26.733313] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   26.814195] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[   26.814730] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
[   26.814966] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB1._PRT]
[   26.815996] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 *12 14 15)
[   26.816452] ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   26.816915] ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   26.817363] ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 11 *12 14 15)
[   26.817808] ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   26.818269] ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   26.818716] ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   26.819161] ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   26.819606] ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   26.820050] ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   26.820503] ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   26.820977] ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 *12 14 15)
[   26.821422] ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   26.821866] ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 *12 14 15)
[   26.822306] ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   26.822749] ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   26.823174] ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
[   26.823532] ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
[   26.823890] ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
[   26.824246] ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
[   26.824617] ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
[   26.825066] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
[   26.825530] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
[   26.826002] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
[   26.826464] ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
[   26.826926] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
[   26.827385] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
[   26.827757] ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
[   26.828204] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
[   26.828672] ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
[   26.829128] ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
[   26.829589] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
[   26.833663] Linux Plug and Play Support v0.97 (c) Adam Belay
[   26.833694] pnp: PnP ACPI init
[   26.840541] pnp: PnP ACPI: found 15 devices
[   26.840602] PCI: Using ACPI for IRQ routing
[   26.840621] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   26.900345] PCI: Bridge: 0000:00:08.0
[   26.900362]   IO window: a000-bfff
[   26.900381]   MEM window: e0000000-e1ffffff
[   26.900408]   PREFETCH window: 40000000-400fffff
[   26.900428] PCI: Bridge: 0000:00:0c.0
[   26.900444]   IO window: c000-cfff
[   26.900463]   MEM window: dc000000-ddffffff
[   26.900481]   PREFETCH window: 40100000-401fffff
[   26.900500] PCI: Bridge: 0000:00:1e.0
[   26.900516]   IO window: disabled.
[   26.900534]   MEM window: de000000-dfffffff
[   26.900552]   PREFETCH window: d0000000-d7ffffff
[   26.900578] PCI: Setting latency timer of device 0000:00:08.0 to 64
[   26.900585] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   26.901230] pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
[   26.901251] pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
[   26.901271] pnp: 00:00: ioport range 0x4400-0x447f has been reserved
[   26.901290] pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
[   26.901310] pnp: 00:00: ioport range 0x4200-0x427f has been reserved
[   26.901329] pnp: 00:00: ioport range 0x4280-0x42ff has been reserved
[   26.901350] pnp: 00:01: ioport range 0x5000-0x503f has been reserved
[   26.901370] pnp: 00:01: ioport range 0x5500-0x553f has been reserved
[   26.901575] Machine check exception polling timer started.
[   26.902057] highmem bounce pool size: 64 pages
[   26.902120] VFS: Disk quotas dquot_6.5.1
[   26.902157] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   26.902226] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   26.902396] Initializing Cryptographic API
[   26.902546] ACPI: CPU0 (power states: C1[C1])
[   26.913088] Real Time Clock Driver v1.12
[   26.913201] PNP: PS/2 controller doesn't have AUX irq; using default 0xc
[   26.913222] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 112
[   26.914888] serio: i8042 AUX port at 0x60,0x64 irq 12
[   26.914966] serio: i8042 KBD port at 0x60,0x64 irq 1
[   26.914986] io scheduler noop registered
[   26.915021] io scheduler anticipatory registered
[   26.915046] io scheduler deadline registered
[   26.915074] io scheduler cfq registered
[   26.915129] Floppy drive(s): fd0 is 1.44M
[   26.932079] FDC 0 is a post-1991 82077
[   26.933292] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
[   26.933452] loop: loaded (max 8 devices)
[   26.933511] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   26.933531] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   26.933591] NFORCE2: IDE controller at PCI slot 0000:00:09.0
[   26.933629] NFORCE2: chipset revision 162
[   26.933645] NFORCE2: not 100% native mode: will probe irqs later
[   26.933666] NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
[   26.933691] NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
[   26.933720] NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
[   26.933746]     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
[   26.933790]     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
[   26.933830] Probing IDE interface ide0...
[   27.220373] hda: WDC WD1000BB-00CAA0, ATA DISK drive
[   27.893717] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   27.893771] Probing IDE interface ide1...
[   28.179946] hdc: WDC WD2000JB-00DUA0, ATA DISK drive
[   28.853174] ide1 at 0x170-0x177,0x376 on irq 15
[   28.853243] SiI3112 Serial ATA: IDE controller at PCI slot 0000:01:0b.0
[   28.853544] ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
[   28.853567] ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [APC3] -> GSI 18 (level, high) -> IRQ 16
[   28.853609] SiI3112 Serial ATA: chipset revision 2
[   28.853649] SiI3112 Serial ATA: 100% native mode on irq 16
[   28.853670]     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
[   28.853707]     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
[   28.853740] Probing IDE interface ide2...
[   29.139748] hde: WDC WD360GD-00FLA0, ATA DISK drive
[   29.812204] ide2 at 0xf8802080-0xf8802087,0xf880208a on irq 16
[   29.812259] Probing IDE interface ide3...
[   30.099321] hdg: ST3300831AS, ATA DISK drive
[   30.770788] hdg: applying pessimistic Seagate errata fix
[   30.770815] ide3 at 0xf88020c0-0xf88020c7,0xf88020ca on irq 16
[   30.770984] hda: max request size: 128KiB
[   30.785712] hda: 195371568 sectors (100030 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
[   30.785761] hda: cache flushes not supported
[   30.785816]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
[   30.820450] hdc: max request size: 1024KiB
[   30.836520] hdc: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
[   30.838090] hdc: cache flushes supported
[   30.838138]  hdc: hdc1 hdc2 hdc3 < hdc5 hdc6 > hdc4
[   30.857607] hde: max request size: 64KiB
[   30.860236] hde: 72303840 sectors (37019 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(133)
[   30.863203] hde: cache flushes supported
[   30.863245]  hde: hde1 hde2
[   30.876291] hdg: max request size: 7KiB
[   30.876534] hdg: 586072368 sectors (300069 MB) w/8192KiB Cache, CHS=36481/255/63
[   30.876680] hdg: cache flushes supported
[   30.876723]  hdg: hdg1
[   30.902599] mice: PS/2 mouse device common for all mice
[   30.902652] NET: Registered protocol family 2
[   30.942642] IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
[   30.943015] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[   30.945697] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[   30.946090] TCP: Hash tables configured (established 262144 bind 65536)
[   30.946110] TCP reno registered
[   30.946148] TCP bic registered
[   30.946180] NET: Registered protocol family 1
[   30.946202] NET: Registered protocol family 17
[   30.946258] Using IPI Shortcut mode
[   30.953562] ReiserFS: hde1: found reiserfs format "3.6" with standard journal
[   31.209222] input: AT Translated Set 2 keyboard on isa0060/serio0
[   31.872867] ReiserFS: hde1: using ordered data mode
[   31.882200] ReiserFS: hde1: journal params: device hde1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   31.883156] ReiserFS: hde1: checking transaction log (hde1)
[   31.917458] ReiserFS: hde1: Using r5 hash to sort names
[   31.917522] VFS: Mounted root (reiserfs filesystem) readonly.
[   31.917750] Freeing unused kernel memory: 176k freed
[   33.137724] Adding 1951888k swap on /dev/hda2.  Priority:-1 extents:1
[   33.154766] Adding 1775172k swap on /dev/hdc4.  Priority:-2 extents:1
[   40.413511] NET: Registered protocol family 10
[   40.413601] Disabled Privacy Extensions on device c0406000(lo)
[   40.413660] IPv6 over IPv4 tunneling driver
[   40.428095] usbcore: registered new driver usbfs
[   40.428437] usbcore: registered new driver hub
[   40.431602] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[   40.432434] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
[   40.432441] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, high) -> IRQ 17
[   40.432457] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   40.432461] ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
[   40.433002] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
[   40.433015] ohci_hcd 0000:00:02.0: irq 17, io mem 0xe2087000
[   40.489082] hub 1-0:1.0: USB hub found
[   40.489097] hub 1-0:1.0: 3 ports detected
[   40.494784] ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
[   40.494790] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 21 (level, high) -> IRQ 18
[   40.494803] PCI: Setting latency timer of device 0000:00:02.1 to 64
[   40.494807] ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
[   40.495197] ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
[   40.495207] ohci_hcd 0000:00:02.1: irq 18, io mem 0xe2082000
[   40.552998] hub 2-0:1.0: USB hub found
[   40.553011] hub 2-0:1.0: 3 ports detected
[   40.564845] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
[   40.564854] ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 20 (level, high) -> IRQ 19
[   40.564869] PCI: Setting latency timer of device 0000:00:02.2 to 64
[   40.564873] ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
[   40.564882] ehci_hcd 0000:00:02.2: debug port 1
[   40.565255] ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
[   40.565267] ehci_hcd 0000:00:02.2: irq 19, io mem 0xe2083000
[   40.565301] PCI: cache line size of 64 is not supported by device 0000:00:02.2
[   40.565304] ehci_hcd 0000:00:02.2: park 0
[   40.565309] ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[   40.566035] hub 3-0:1.0: USB hub found
[   40.566047] hub 3-0:1.0: 6 ports detected
[   40.593817] via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
[   40.594173] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
[   40.594180] ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC1] -> GSI 16 (level, high) -> IRQ 20
[   40.594187] PCI: Via IRQ fixup for 0000:01:0a.0, from 12 to 4
[   40.598855] eth0: VIA Rhine II at 0x1a000, 00:90:fe:53:3e:72, IRQ 20.
[   40.599587] eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
[   40.604290] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.35.
[   40.605659] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
[   40.605663] ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCH] -> GSI 22 (level, high) -> IRQ 17
[   40.605671] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   41.122558] eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
[   41.133812] ip_conntrack version 2.1 (8191 buckets, 65528 max) - 244 bytes per conntrack
[   41.236211] ip_tables: (C) 2000-2002 Netfilter core team
[   60.969593] kjournald starting.  Commit interval 5 seconds
[   60.969701] EXT3 FS on hda5, internal journal
[   60.969706] EXT3-fs: mounted filesystem with ordered data mode.
[   60.998460] ReiserFS: hda6: found reiserfs format "3.6" with standard journal
[   64.122908] ReiserFS: hda6: using ordered data mode
[   64.138274] ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   64.139222] ReiserFS: hda6: checking transaction log (hda6)
[   64.167702] ReiserFS: hda6: Using r5 hash to sort names
[   64.243615] kjournald starting.  Commit interval 5 seconds
[   64.243763] EXT3 FS on hdc5, internal journal
[   64.243768] EXT3-fs: mounted filesystem with ordered data mode.
[   64.275477] ReiserFS: hdc6: found reiserfs format "3.6" with standard journal
[   70.041841] ReiserFS: hdc6: using ordered data mode
[   70.062556] ReiserFS: hdc6: journal params: device hdc6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   70.063508] ReiserFS: hdc6: checking transaction log (hdc6)
[   70.130791] ReiserFS: hdc6: Using r5 hash to sort names
[   70.180513] ReiserFS: hde2: found reiserfs format "3.6" with standard journal
[   70.204844] ReiserFS: hde2: using ordered data mode
[   70.212164] ReiserFS: hde2: journal params: device hde2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   70.213093] ReiserFS: hde2: checking transaction log (hde2)
[   70.236919] ReiserFS: hde2: Using r5 hash to sort names
[   70.275254] ReiserFS: hdg1: found reiserfs format "3.6" with standard journal
[   84.028736] ReiserFS: hdg1: using ordered data mode
[   84.049235] ReiserFS: hdg1: journal params: device hdg1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   84.050184] ReiserFS: hdg1: checking transaction log (hdg1)
[   84.097576] ReiserFS: hdg1: Using r5 hash to sort names
[   86.298932] i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
[   86.299399] i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5500
[   89.571829] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[   90.079538] CSLIP: code copyright 1989 Regents of the University of California
[   90.084325] PPP generic driver version 2.4.2
[   97.658632] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[   97.658872] NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
[   97.658876] NFSD: starting 90-second grace period
[  177.723843] MPPE/MPPC encryption/compression module registered
[  209.587595] nfsd: last server has exited
[  209.587600] nfsd: unexporting all filesystems
[  209.677982] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[  209.678228] NFSD: starting 90-second grace period
[ 7638.386919] RPC: error 5 connecting to server 127.0.0.1
[ 7638.442963] RPC: error 5 connecting to server 127.0.0.1
[10824.759964] Unable to handle kernel paging request at virtual address 03cdc3e8
[10824.759971]  printing eip:
[10824.759973] c022aa99
[10824.759975] *pde = 00000000
[10824.759978] Oops: 0000 [#1]
[10824.759988] Modules linked in: sha1 arc4 ppp_mppe_mppc ipt_TCPMSS ipt_REJECT ipt_state iptable_filter iptable_mangle ppp_synctty ppp_async ppp_generic slhc w83l785ts asb100 i2c_sensor i2c_nforce2 i2c_core ext3 jbd mbcache ip_nat_ftp iptable_nat ip_tables ip_conntrack_ftp ip_conntrack forcedeth via_rhine mii ehci_hcd ohci_hcd usbcore ipv6
[10824.760098] CPU:    0
[10824.760099] EIP:    0060:[<c022aa99>]    Not tainted VLI
[10824.760101] EFLAGS: 00010296   (2.6.13-dorf) 
[10824.760128] EIP is at prio_tree_first+0x29/0xc0
[10824.760138] eax: 00000000   ebx: c1b9ddb4   ecx: c1b9ddb4   edx: 03cdc3d4
[10824.760150] esi: 00000000   edi: c11ccca0   ebp: 03cdc3e8   esp: c1b9dd48
[10824.760161] ds: 007b   es: 007b   ss: 0068
[10824.760169] Process kswapd0 (pid: 169, threadinfo=c1b9c000 task=c1b40a60)
[10824.760180] Stack: 000003ee 00000086 c03a27ec c13d7de0 c03a2838 c13d7dc0 c1b9ddb4 00000000 
[10824.760213]        c11ccca0 c1b9ddb4 c022abd4 c1b9ddb4 00000000 e5cdc3e0 00000001 f385ca08 
[10824.760246]        00000000 00000000 c11ccca0 c01403c7 c1b9ddb4 c01481f3 00000000 c1b9ddb4 
[10824.760279] Call Trace:
[10824.760299]  [<c022abd4>] prio_tree_next+0xa4/0xd0
[10824.760321]  [<c01403c7>] vma_prio_tree_next+0x27/0x60
[10824.760344]  [<c01481f3>] page_referenced_file+0x53/0xc0
[10824.760368]  [<c013dd8b>] __pagevec_release_nonlru+0x6b/0x90
[10824.760392]  [<c01482f6>] page_referenced+0x96/0xb0
[10824.760413]  [<c013ed42>] shrink_list+0xd2/0x3e0
[10824.760439]  [<c013f200>] shrink_cache+0x100/0x270
[10824.760462]  [<c013a143>] get_writeback_state+0x43/0x50
[10824.760487]  [<c013e91a>] shrink_slab+0x9a/0x1c0
[10824.760508]  [<c013f7ad>] shrink_zone+0xad/0xe0
[10824.760528]  [<c013fcc6>] balance_pgdat+0x2a6/0x3a0
[10824.760554]  [<c013fe9e>] kswapd+0xde/0x100
[10824.760574]  [<c012a920>] autoremove_wake_function+0x0/0x60
[10824.760598]  [<c012a920>] autoremove_wake_function+0x0/0x60
[10824.760620]  [<c013fdc0>] kswapd+0x0/0x100
[10824.760639]  [<c0100f65>] kernel_thread_helper+0x5/0x10
[10824.760660] Code: 89 f6 55 57 56 53 83 ec 18 8b 5c 24 2c 8b 6b 10 c7 03 00 00 00 00 c7 43 04 00 00 00 00 c7 43 08 00 00 00 00 c7 43 0c 00 00 00 00 <8b> 7d 00 85 ff 74 7c 8d 7c 24 14 8d 74 24 10 89 7c 24 0c 89 74 
[10824.761096]  <1>Unable to handle kernel paging request at virtual address 53a9da8c
[10826.747246]  printing eip:
[10826.747261] c022aa99
[10826.747277] *pde = 00000000
[10826.747293] Oops: 0000 [#2]
[10826.747310] Modules linked in: sha1 arc4 ppp_mppe_mppc ipt_TCPMSS ipt_REJECT ipt_state iptable_filter iptable_mangle ppp_synctty ppp_async ppp_generic slhc w83l785ts asb100 i2c_sensor i2c_nforce2 i2c_core ext3 jbd mbcache ip_nat_ftp iptable_nat ip_tables ip_conntrack_ftp ip_conntrack forcedeth via_rhine mii ehci_hcd ohci_hcd usbcore ipv6
[10826.747544] CPU:    0
[10826.747545] EIP:    0060:[<c022aa99>]    Not tainted VLI
[10826.747546] EFLAGS: 00010286   (2.6.13-dorf) 
[10826.747602] EIP is at prio_tree_first+0x29/0xc0
[10826.747620] eax: 00000000   ebx: f4259b0c   ecx: f4259b0c   edx: 53a9da78
[10826.747640] esi: 00000000   edi: c11ccc80   ebp: 53a9da8c   esp: f4259aa0
[10826.747660] ds: 007b   es: 007b   ss: 0068
[10826.747677] Process rsync (pid: 9243, threadinfo=f4258000 task=f6fc35f0)
[10826.747691] Stack: 00000082 00000000 d1857ca0 00000002 f7125934 f4259ae8 f4259b0c 00000000 
[10826.747763]        c11ccc80 f4259b0c c022abd4 f4259b0c 00000000 f0a9da84 00000001 f7125934 
[10826.747835]        00000000 00000000 c11ccc80 c01403c7 f4259b0c c01481f3 00000000 f4259b0c 
[10826.747909] Call Trace:
[10826.747938]  [<c022abd4>] prio_tree_next+0xa4/0xd0
[10826.747968]  [<c01403c7>] vma_prio_tree_next+0x27/0x60
[10826.747999]  [<c01481f3>] page_referenced_file+0x53/0xc0
[10826.748032]  [<c0156240>] try_to_free_buffers+0x50/0x90
[10826.748064]  [<c01482f6>] page_referenced+0x96/0xb0
[10826.748093]  [<c013ed42>] shrink_list+0xd2/0x3e0
[10826.748128]  [<c013f200>] shrink_cache+0x100/0x270
[10826.748158]  [<c02a217c>] ide_map_sg+0x9c/0xb0
[10826.748188]  [<c013a143>] get_writeback_state+0x43/0x50
[10826.748220]  [<c013a16c>] get_dirty_limits+0x1c/0xe0
[10826.748250]  [<c013a400>] throttle_vm_writeout+0x30/0x80
[10826.748280]  [<c013f7ad>] shrink_zone+0xad/0xe0
[10826.748309]  [<c013f859>] shrink_caches+0x79/0x90
[10826.748338]  [<c013f940>] try_to_free_pages+0xd0/0x1b0
[10826.748371]  [<c0138e79>] __alloc_pages+0x1a9/0x470
[10826.748404]  [<c013b4d9>] __do_page_cache_readahead+0xd9/0x110
[10826.748435]  [<c013b679>] blockable_page_cache_readahead+0x59/0xd0
[10826.748466]  [<c013b76a>] make_ahead_window+0x7a/0xb0
[10826.748496]  [<c013b845>] page_cache_readahead+0xa5/0x190
[10826.748527]  [<c0134f8c>] do_generic_mapping_read+0x56c/0x580
[10826.748563]  [<c0135251>] __generic_file_aio_read+0x1c1/0x200
[10826.748594]  [<c0134fa0>] file_read_actor+0x0/0xf0
[10826.748624]  [<c01352ea>] generic_file_aio_read+0x5a/0x80
[10826.748655]  [<c01513d7>] do_sync_read+0xc7/0x110
[10826.748691]  [<c012a920>] autoremove_wake_function+0x0/0x60
[10826.748723]  [<c0164f74>] sys_select+0x204/0x420
[10826.748754]  [<c0151502>] vfs_read+0xe2/0x1b0
[10826.748783]  [<c01518e1>] sys_read+0x51/0x80
[10826.748812]  [<c0102d15>] syscall_call+0x7/0xb
[10826.748844] Code: 89 f6 55 57 56 53 83 ec 18 8b 5c 24 2c 8b 6b 10 c7 03 00 00 00 00 c7 43 04 00 00 00 00 c7 43 08 00 00 00 00 c7 43 0c 00 00 00 00 <8b> 7d 00 85 ff 74 7c 8d 7c 24 14 8d 74 24 10 89 7c 24 0c 89 74 
[10826.749210]  <1>Unable to handle kernel paging request at virtual address 53a9daa8
[10826.989144]  printing eip:
[10826.989159] c0133e1e
[10826.989173] *pde = 00000000
[10826.989189] Oops: 0000 [#3]
[10826.989205] Modules linked in: sha1 arc4 ppp_mppe_mppc ipt_TCPMSS ipt_REJECT ipt_state iptable_filter iptable_mangle ppp_synctty ppp_async ppp_generic slhc w83l785ts asb100 i2c_sensor i2c_nforce2 i2c_core ext3 jbd mbcache ip_nat_ftp iptable_nat ip_tables ip_conntrack_ftp ip_conntrack forcedeth via_rhine mii ehci_hcd ohci_hcd usbcore ipv6
[10826.989438] CPU:    0
[10826.989439] EIP:    0060:[<c0133e1e>]    Not tainted VLI
[10826.989441] EFLAGS: 00010206   (2.6.13-dorf) 
[10826.989493] EIP is at sync_page+0x1e/0x50
[10826.989511] eax: 00000000   ebx: cf3b1e44   ecx: c11ccc80   edx: 53a9da78
[10826.989531] esi: cf3b1e4c   edi: c1802180   ebp: 00000000   esp: cf3b1dfc
[10826.989551] ds: 007b   es: 007b   ss: 0068
[10826.989568] Process rsync (pid: 9245, threadinfo=cf3b0000 task=f596c020)
[10826.989582] Stack: c1802180 c033a212 c11ccc80 c0133e00 f596c020 cf3b1e44 cf3b1e40 c11ccc80 
[10826.989655]        c01346a1 00000002 c11ccc80 00000000 00000000 f596c020 c012a980 cf3b1e58 
[10826.989727]        cf3b1e58 f0a9da78 c11ccc80 00000000 00000001 f596c020 c012a980 c1802180 
[10826.989799] Call Trace:
[10826.989826]  [<c033a212>] __wait_on_bit_lock+0x52/0x60
[10826.989860]  [<c0133e00>] sync_page+0x0/0x50
[10826.989888]  [<c01346a1>] __lock_page+0x91/0xa0
[10826.989917]  [<c012a980>] wake_bit_function+0x0/0x60
[10826.989949]  [<c012a980>] wake_bit_function+0x0/0x60
[10826.989978]  [<c013e2d8>] truncate_inode_pages+0x188/0x2a0
[10826.990015]  [<c016b95f>] generic_delete_inode+0x12f/0x140
[10826.990048]  [<c016bb15>] iput+0x55/0x70
[10826.990076]  [<c0168eaf>] dput+0xef/0x190
[10826.990105]  [<c0152713>] __fput+0x113/0x170
[10826.990137]  [<c0150c7d>] filp_close+0x4d/0x80
[10826.990165]  [<c0118f96>] put_files_struct+0x56/0xc0
[10826.990198]  [<c0119b91>] do_exit+0xf1/0x370
[10826.990225]  [<c0151961>] sys_write+0x51/0x80
[10826.990254]  [<c0119e84>] do_group_exit+0x34/0x70
[10826.990284]  [<c0102d15>] syscall_call+0x7/0xb
[10826.990316] Code: eb e8 8d 74 26 00 8d bc 27 00 00 00 00 83 ec 04 8b 4c 24 08 8b 01 8b 51 10 c1 e8 0f 83 e0 01 75 34 f6 c2 01 0f 45 d0 85 d2 74 12 <8b> 42 30 85 c0 74 0b 8b 50 08 85 d2 75 14 8d 74 26 00 e8 7b 60 
[10826.990681]  <1>Fixing recursive fault but reboot is needed!

--------------040502000705020604010503
Content-Type: application/octet-stream;
 name="2005-09-05.3.ksymoops.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="2005-09-05.3.ksymoops.bz2"

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
OFCQm+s/Rw==
--------------040502000705020604010503--

