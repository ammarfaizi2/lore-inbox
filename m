Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423699AbWJaRW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423699AbWJaRW7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423702AbWJaRW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:22:59 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:27781 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1423699AbWJaRWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:22:53 -0500
Date: Tue, 31 Oct 2006 18:20:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mark Lord <lkml@rtr.ca>
cc: Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 is problematic in VMware
In-Reply-To: <4547584F.6000702@rtr.ca>
Message-ID: <Pine.LNX.4.61.0610311551370.6900@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610290953010.4585@yvahk01.tjqt.qr>
 <45463B7D.8050002@vmware.com> <Pine.LNX.4.61.0610310857280.23540@yvahk01.tjqt.qr>
 <4547584F.6000702@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> My experience with VMware on several recent processors (mostly P-M family)
> is that it crawls unless I force this first:
> echo 1 > /sys/module/processor/parameters/max_cstate

My host processor is non-throttable
Uni-processor.

I tried with some kernels (hey, vmware had serial ports?)
For whatever reason, the timecounting is not accurate.
As you can see, the time difference between "WP bit" and the calibration 
thing is less than half a second inside the guest, but on the host, 
the delay is several seconds.
The Capture Movie feature gets it right 
http://jengelh.hopto.org/f/2618delay.avi
One can see that it pauses before calibration (already mentioned that) 
and once again after NET: ... during IP init!? What's going on :(

---2.6.18.1, CONFIG_SMP=n---
Linux version 2.6.18.1-default (jengelh@ichi) (gcc version 4.1.0 (SUSE Linux)) #1 Tue Oct 31 09:57:59 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ef0000 (usable)
 BIOS-e820: 0000000007ef0000 - 0000000007efc000 (ACPI data)
 BIOS-e820: 0000000007efc000 - 0000000007f00000 (ACPI NVS)
 BIOS-e820: 0000000007f00000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
128MB LOWMEM available.
DMI present.
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 10000000 (gap: 08000000:f6c00000)
Detected 1665.681 MHz processor.
Built 1 zonelists.  Total pages: 32768
Kernel command line: time console=ttyS0 BOOT_IMAGE=nosmp 
[   13.858905] Enabling fast FPU save and restore... done.
[   13.859113] Enabling unmasked SIMD FPU exception support... done.
[   13.859188] Initializing CPU#0
[   13.860525] PID hash table entries: 1024 (order: 10, 4096 bytes)
[   13.864585] Console: colour VGA+ 80x25
[   13.868460] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[   13.868460] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[   13.868460] Memory: 126504k/131072k available (1704k kernel code, 4040k reserved, 537k data, 168k init, 0k highmem)
[   13.868460] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   13.946021] Calibrating delay using timer specific routine.. 3328.37 BogoMIPS (lpj=6656759)
[   13.948272] Security Framework v1.0.0 initialized
[   13.948417] Mount-cache hash table entries: 512
[   13.948417] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   13.948499] CPU: L2 Cache: 256K (64 bytes/line)
[   13.948551] Intel machine check architecture supported.
[   13.948612] Intel machine check reporting enabled on CPU#0.
[   13.948676] Compat vDSO mapped to ffffe000.
[   13.948725] CPU: AMD Athlon(tm) XP 2000+ stepping 00
[   13.948784] Checking 'hlt' instruction... OK.
[   13.960686] ACPI: Core revision 20060707
[   13.961885] ACPI: setting ELCR to 0200 (from 0e00)
[   13.964247] NET: Registered protocol family 16
[   13.964456] ACPI: bus type pci registered
[   13.964502] PCI: PCI BIOS revision 2.10 entry at 0xfd9a0, last bus=1
[   13.964576] PCI: Using configuration type 1
[   13.964624] Setting up standard PCI resources
[   13.964675] ACPI: Interpreter enabled
[   13.964717] ACPI: Using PIC for interrupt routing
[   13.964772] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   13.964827] PCI quirk: region 1000-103f claimed by PIIX4 ACPI
[   13.964894] PCI quirk: region 1040-104f claimed by PIIX4 SMB
[   13.964959] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 14 15) *0, disabled.
[   13.965066] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 14 15)
[   13.965158] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 14 15)
[   13.965250] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 14 15)
[   13.965343] Linux Plug and Play Support v0.97 (c) Adam Belay
[   13.965408] pnp: PnP ACPI init
[   13.965444] pnp: PnP ACPI: found 12 devices
[   13.965492] PnPBIOS: Disabled by ACPI PNP
[   13.965539] PCI: Using ACPI for IRQ routing
[   13.965587] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   13.965682] PCI: Bridge: 0000:00:01.0
[   13.965725]   IO window: disabled.
[   13.965765]   MEM window: disabled.
[   13.965805]   PREFETCH window: disabled.
[   13.965851] NET: Registered protocol family 2
[   14.008670] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[   14.017662] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[   14.025097] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[   14.029523] TCP: Hash tables configured (established 4096 bind 2048)
[   14.036980] TCP reno registered
[   14.045051] Simple Boot Flag at 0x36 set to 0x1
[   14.053222] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[   14.057657] apm: overridden by ACPI.
[   14.076686] audit: initializing netlink socket (disabled)
[   14.081364] audit(1162314009.392:1): initialized
[   14.089309] Total HugeTLB memory allocated, 0
[   14.100691] VFS: Disk quotas dquot_6.5.1
[   14.104679] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   14.113325] Initializing Cryptographic API
[   14.120467] io scheduler noop registered
[   14.124389] io scheduler cfq registered (default)
[   14.128621] Limiting direct PCI/PCI transfers.
[   14.140826] isapnp: Scanning for PnP cards...
[   15.109133] isapnp: No Plug & Play device found
[   15.140984] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   15.156220] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   15.168252] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   15.180599] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   15.192245] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   15.205079] RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
[   15.224403] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOUS] at 0x60,0x64 irq 1,12
[   16.205087] serio: i8042 AUX port at 0x60,0x64 irq 12
[   16.208573] serio: i8042 KBD port at 0x60,0x64 irq 1
[   16.216376] mice: PS/2 mouse device common for all mice
[   16.235528] NET: Registered protocol family 1
[   16.239689] Using IPI Shortcut mode
[   16.247342] Time: tsc clocksource has been installed.
[   16.252287] ACPI: (supports S0 S1 S5)
[   16.283295] input: AT Translated Set 2 keyboard as /class/input/input0
[   16.292423] VFS: Cannot open root device "<NULL>" or unknown-block(3,2)
[   16.299595] Please append a correct "root=" boot option
[   16.303861] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(3,2)
[   16.311893]  

---vanilla 2.6.18.1, CONFIG_SMP=y---
Linux version 2.6.18.1-default (jengelh@ichi) (gcc version 4.1.0 (SUSE Linux)) #1 SMP Tue Oct 31 09:54:27 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ef0000 (usable)
 BIOS-e820: 0000000007ef0000 - 0000000007efc000 (ACPI data)
 BIOS-e820: 0000000007efc000 - 0000000007f00000 (ACPI NVS)
 BIOS-e820: 0000000007f00000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
128MB LOWMEM available.
found SMP MP-table at 000f6ce0
DMI present.
Using APIC driver default
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 10000000 (gap: 08000000:f6c00000)
Detected 1665.682 MHz processor.
Built 1 zonelists.  Total pages: 32768
Kernel command line: time console=ttyS0 BOOT_IMAGE=smp 
[   11.020838] Enabling fast FPU save and restore... done.
[   11.020895] Enabling unmasked SIMD FPU exception support... done.
[   11.020966] Initializing CPU#0
[   11.022287] PID hash table entries: 1024 (order: 10, 4096 bytes)
[   11.026347] Console: colour VGA+ 80x25
[   11.030222] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[   11.030222] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[   11.030222] Memory: 126004k/131072k available (1868k kernel code, 4472k reserved, 641k data, 208k init, 0k highmem)
[   11.030222] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   11.107875] Calibrating delay using timer specific routine.. 3191.31 BogoMIPS (lpj=6382621)
[   11.110178] Security Framework v1.0.0 initialized
[   11.110178] Mount-cache hash table entries: 512
[   11.110178] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   11.110179] CPU: L2 Cache: 256K (64 bytes/line)
[   11.110179] Intel machine check architecture supported.
[   11.110179] Intel machine check reporting enabled on CPU#0.
[   11.110179] Compat vDSO mapped to ffffe000.
[   11.110179] Checking 'hlt' instruction... OK.
[   11.122451] SMP alternatives: switching to UP code
[   11.123862] Freeing SMP alternatives: 12k freed
[   11.125225] ACPI: Core revision 20060707
[   11.126170] CPU0: AMD Athlon(tm) XP 2000+ stepping 00
[   11.126228] Total of 1 processors activated (3191.31 BogoMIPS).
[   11.126293] ENABLING IO-APIC IRQs
[   11.126425] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   11.302878] Brought up 1 CPUs
[   11.310829] migration_cost=0
[   11.359143] NET: Registered protocol family 16
[   11.390070] ACPI: bus type pci registered
[   11.394695] PCI: PCI BIOS revision 2.10 entry at 0xfd9a0, last bus=1
[   11.402407] PCI: Using configuration type 1
[   11.406416] Setting up standard PCI resources
[   11.474025] ACPI: Interpreter enabled
[   11.475222] ACPI: Using IOAPIC for interrupt routing
[   11.503065] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   11.623145] PCI quirk: region 1000-103f claimed by PIIX4 ACPI
[   11.630199] PCI quirk: region 1040-104f claimed by PIIX4 SMB
[   11.678607] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 14 15) *0, disabled.
[   11.690285] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 14 15)
[   11.702651] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 14 15)
[   11.711091] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 14 15)
[   11.826967] Linux Plug and Play Support v0.97 (c) Adam Belay
[   11.834204] pnp: PnP ACPI init
[   12.027054] pnp: PnP ACPI: found 12 devices
[   12.031188] PnPBIOS: Disabled by ACPI PNP
[   12.042509] PCI: Using ACPI for IRQ routing
[   12.046470] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   12.118989] PCI: Bridge: 0000:00:01.0
[   12.123080]   IO window: disabled.
[   12.126823]   MEM window: disabled.
[   12.130544]   PREFETCH window: disabled.
[   12.138335] NET: Registered protocol family 2
[   12.190378] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[   12.203158] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[   12.210776] TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
[   12.218048] TCP: Hash tables configured (established 4096 bind 2048)
[   12.222592] TCP reno registered
[   12.233719] Simple Boot Flag at 0x36 set to 0x1
[   12.242404] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[   12.246985] apm: overridden by ACPI.
[   12.270042] audit: initializing netlink socket (disabled)
[   12.274882] audit(1162321640.176:1): initialized
[   12.286293] Total HugeTLB memory allocated, 0
[   12.294479] VFS: Disk quotas dquot_6.5.1
[   12.298597] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   12.310316] Initializing Cryptographic API
[   12.314908] io scheduler noop registered
[   12.318937] io scheduler cfq registered (default)
[   12.325639] Limiting direct PCI/PCI transfers.
[   12.338473] isapnp: Scanning for PnP cards...
[   13.254137] isapnp: No Plug & Play device found
[   13.293282] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   13.309082] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   13.318046] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   13.330329] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   13.338823] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   13.354850] RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
[   13.374401] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOUS] at 0x60,0x64 irq 1,12
[   14.385959] serio: i8042 AUX port at 0x60,0x64 irq 12
[   14.390375] serio: i8042 KBD port at 0x60,0x64 irq 1
[   14.400698] mice: PS/2 mouse device common for all mice
[   14.417916] NET: Registered protocol family 1
[   14.424504] Using IPI No-Shortcut mode
[   14.428554] Time: tsc clocksource has been installed.
[   14.437586] ACPI: (supports S0 S1 S5)
[   14.473654] input: AT Translated Set 2 keyboard as /class/input/input0
[   14.497887] VFS: Cannot open root device "<NULL>" or unknown-block(3,2)
[   14.502422] Please append a correct "root=" boot option
[   14.508650] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(3,2)
[   14.516517]  

---2.6.18(.0), suse, jengelh, CONFIG_SMP=y---
Linux version 2.6.18-jen35-default (geeko@buildhost) (gcc version 4.1.0 (SUSE Linux)) #1 SMP Tue Oct 3 01:27:41 CEST 2006
    Enhanced Kernel by suser-jengelh
    linux-2.6.18-jen35
    See http://jengelh.hopto.org/p/jen_kernel/ for details.

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ef0000 (usable)
 BIOS-e820: 0000000007ef0000 - 0000000007efc000 (ACPI data)
 BIOS-e820: 0000000007efc000 - 0000000007f00000 (ACPI NVS)
 BIOS-e820: 0000000007f00000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
128MB LOWMEM available.
found SMP MP-table at 000f6ce0
DMI present.
Using APIC driver default
IO/L-APIC allowed because system is MP or new enough
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: 440BX        APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17
I/O APIC #1 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 10000000 (gap: 08000000:f6c00000)
Detected 1665.693 MHz processor.
Built 1 zonelists.  Total pages: 32768
Kernel command line: initrd=initrd time nosmp noapic acpi=off BOOT_IMAGE=vmlinuz console=ttyS0
[   23.960179] Enabling fast FPU save and restore... done.
[   23.960232] Enabling unmasked SIMD FPU exception support... done.
[   23.960302] Initializing CPU#0
[   23.962047] PID hash table entries: 1024 (order: 10, 4096 bytes)
[   23.962204] Console: colour VGA+ 80x25
[   23.981881] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[   23.981881] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[   23.981881] Memory: 117796k/131072k available (1905k kernel code, 12668k reserved, 648k data, 212k init, 0k highmem)
[   23.981881] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   24.123385] Calibrating delay using timer specific routine.. 3355.76 BogoMIPS (lpj=16778838)
[   24.125941] Security Framework v1.0.0 initialized
[   24.127360] Mount-cache hash table entries: 512
[   24.129002] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   24.131206] CPU: L2 Cache: 256K (64 bytes/line)
[   24.131795] Intel machine check architecture supported.
[   24.131795] Intel machine check reporting enabled on CPU#0.
[   24.131795] Compat vDSO mapped to ffffe000.
[   24.131796] Checking 'hlt' instruction... OK.
[   24.162214] SMP alternatives: switching to UP code
[   24.163840] Freeing SMP alternatives: 12k freed
[   24.165696] *<6>checking if image is initramfs... it is
[   24.167662] Freeing initrd memory: 8121k freed
[   24.169094] CPU0: AMD Athlon(tm) XP 2000+ stepping 00
[   24.170902] SMP mode deactivated, forcing use of dummy APIC emulation.
[   24.174195] Brought up 1 CPUs
[   24.175282] migration_cost=0
[   24.177370] NET: Registered protocol family 16
[   24.179978] PCI: PCI BIOS revision 2.10 entry at 0xfd9a0, last bus=1
[   24.181775] PCI: Using configuration type 1
[   24.181824] Setting up standard PCI resources
[   24.181876] ACPI: Interpreter disabled.
[   24.181921] Linux Plug and Play Support v0.97 (c) Adam Belay
[   24.181988] pnp: PnP ACPI: disabled
[   24.182029] PnPBIOS: Scanning system for PnP BIOS support...
[   24.182095] PnPBIOS: Found PnP BIOS installation structure at 0xb00f6ca0
[   24.182174] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9486, dseg 0x400
[   24.182255] PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
[   24.182335] PCI: Probing PCI hardware
[   24.182378] PCI quirk: region 1000-103f claimed by PIIX4 ACPI
[   24.182446] PCI quirk: region 1040-104f claimed by PIIX4 SMB
[   24.182512] PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
[   24.182589] pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
[   24.182661] pnp: 00:0b: ioport range 0x1000-0x103f has been reserved
[   24.182736] pnp: 00:0b: ioport range 0x1040-0x104f has been reserved
[   24.182810] PCI: Bridge: 0000:00:01.0
[   24.182854]   IO window: disabled.
[   24.182894]   MEM window: disabled.
[   24.182935]   PREFETCH window: disabled.
[   24.183694] NET: Registered protocol family 2
[   24.251973] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[   24.254095] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[   24.256262] TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
[   24.258374] TCP: Hash tables configured (established 4096 bind 2048)
[   24.260368] TCP reno registered
[   24.261722] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[   24.261797] audit: initializing netlink socket (disabled)
[   24.261860] audit(1162321703.250:1): initialized
[   24.261914] Total HugeTLB memory allocated, 0
[   24.261966] VFS: Disk quotas dquot_6.5.1
[   24.262012] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   24.262089] Initializing Cryptographic API
[   24.262137] io scheduler noop registered
[   24.262184] io scheduler cfq registered (default)
[   24.262242] Limiting direct PCI/PCI transfers.
[   24.262299] isapnp: Scanning for PnP cards...
[   25.122542] isapnp: No Plug & Play device found
[   25.153665] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   25.173955] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   25.183228] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   25.193676] 00:11: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   25.202771] 00:12: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   25.214400] RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
[   25.233874] PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
[   26.232425] serio: i8042 AUX port at 0x60,0x64 irq 12
[   26.234211] serio: i8042 KBD port at 0x60,0x64 irq 1
[   26.250923] mice: PS/2 mouse device common for all mice
[   26.263340] NET: Registered protocol family 1
[   26.271630] Using IPI No-Shortcut mode
[   26.280916] Time: tsc clocksource has been installed.
[   26.397684] Freeing unused kernel memory: 212k freed
[   26.410676] Write protecting the kernel read-only data: 281k
[   26.442480] input: AT Translated Set 2 keyboard as /class/input/input0
[   26.563104] input: AT Translated Set 2 keyboard as /class/input/input1
Starting udevd



	-`J'
-- 
