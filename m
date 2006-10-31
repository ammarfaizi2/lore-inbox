Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422793AbWJaGcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422793AbWJaGcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 01:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422796AbWJaGcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 01:32:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:26264 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422793AbWJaGcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 01:32:13 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.19-rc3-mm1] BUG at arch/i386/mm/pageattr.c:165
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: andrew.j.wade@gmail.com, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20061030211046.1c3d62b9.akpm@osdl.org>
References: <20061029160002.29bb2ea1.akpm@osdl.org>
	 <200610302203.37570.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	 <20061030191340.1c7f8620.akpm@osdl.org>
	 <200610302258.31613.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	 <20061030211046.1c3d62b9.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 07:31:39 +0100
Message-Id: <1162276299.5959.12.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 21:10 -0800, Andrew Morton wrote:
> On Mon, 30 Oct 2006 22:58:11 -0500
> Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> 
> > > 
> > > hm.  Please send the .config
> > > 
> > Sure.
> > 
> > I've just found out that unsetting CONFIG_SYSFS_DEPRECATED makes the
> > crash go away. I can hack around the resulting udev incompatibility.
> > 
> > #
> > # Automatically generated make config: don't edit
> > # Linux kernel version: 2.6.19-rc3-mm1
> > # Mon Oct 30 19:31:03 2006
> 
> Well I tried to reproduce this, but I got such a psychedelic cornucopia of
> oopses at various bisection points amongst those sysfs patches that I think
> I'll just give up.
> 
> Greg, Kay: it's quite ugly.  I'll drop all those patches for now, and I
> suggest you do so too.  Have a play with the .config which Andrew sent..

I can reproduce, and confirm that nuking CONFIG_SYSFS_DEPRECATED does
cure it.  Without that, my box boots fine.

('course being SuSE, the sysfs symlink changes makes my network init
scripts unable to find config for network devices, but that's known)

Linux version 2.6.19-rc3-mm1-smp (root@Homer) (gcc version 4.1.2 20060920 (prerelease) (SUSE Linux)) #10 SMP PREEMPT Tue Oct 31 06:42:45 CET 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000003fef0000 end: 000000003fff0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000003fff0000 size: 0000000000003000 end: 000000003fff3000 type: 4
copy_e820_map() start: 000000003fff3000 size: 000000000000d000 end: 0000000040000000 type: 3
copy_e820_map() start: 00000000fec00000 size: 0000000001400000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5320
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   262128
early_node_map[1] active PFN ranges
    0:        0 ->   262128
DMI 2.3 present.
ACPI: RSDP @ 0x000f6cc0/0x0014 (v000 IntelR)
ACPI: RSDT @ 0x3fff3000/0x002C (v001 IntelR AWRDACPI 0x42302E31 AWRD 0x00000000)
ACPI: FACP @ 0x3fff3040/0x0074 (v001 IntelR AWRDACPI 0x42302E31 AWRD 0x00000000)
ACPI: DSDT @ 0x3fff30c0/0x4139 (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000E)
ACPI: FACS @ 0x3fff0000/0x0040
ACPI: APIC @ 0x3fff7200/0x0068 (v001 IntelR AWRDACPI 0x42302E31 AWRD 0x00000000)
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Detected 2992.575 MHz processor.
Built 1 zonelists.  Total pages: 260081
Kernel command line: root=/dev/hdc3 vga=0x314 resume=/dev/hdc2 console=ttyS0,115200n8 console=tty profile=1
kernel profiling enabled (shift: 1)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Clock event device pit configured with caps set: 07
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1021228k/1048512k available (4012k kernel code, 26564k reserved, 1327k data, 224k init, 131008k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9d000 - 0xfffff000   ( 392 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc06d2000 - 0xc070a000   ( 224 kB)
      .data : 0xc04eb234 - 0xc0636f1c   (1327 kB)
      .text : 0xc0100000 - 0xc04eb234   (4012 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5987.35 BogoMIPS (lpj=2993678)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20061011
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5984.16 BogoMIPS (lpj=2992081)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
Total of 2 processors activated (11971.51 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Clock event device pit new caps set: 01
Clock event device lapic configured with caps set: 06
checking TSC synchronization across 2 CPUs: passed.
Clock event device pit new caps set: 01
Clock event device lapic configured with caps set: 06
Brought up 2 CPUs
migration_cost=83
Unpacking initramfs... done
Freeing initrd memory: 2693k freed
NET: Registered protocol family 16
Unable to create device for dummy device; errno = -17
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb980, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
intel_rng: FWH not detected
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
FS-Cache: Loaded
CacheFiles: Loaded
pnp: 00:0b: ioport range 0x400-0x4bf could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: a000-afff
  MEM window: e8000000-e9ffffff
  PREFETCH window: d8000000-e7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: b000-bfff
  MEM window: ea000000-ea0fffff
  PREFETCH window: ea100000-ea1fffff
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1162278006.581:1): initialized
Failed to register kevent miscdev: err=-17.
KEVENT: Added callbacks for type 2.
KEVENT: Added callbacks for type 3.
Kevent poll()/select() subsystem has been initialized.
KEVENT: Added callbacks for type 0.
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
FS-Cache: netfs 'nfs' registered for caching
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/W].
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xd8000000, mapped to 0xf8880000, using 1875k, total 16384k
vesafb: mode is 800x600x16, linelength=1600, pages=16
vesafb: protected mode interface info at c000:b544
vesafb: pmi: set display start = c00cb5d2, set palette = c00cb612
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Unable to create device for frame buffer device; errno = -17
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
Using specific hotkey driver
ACPI: Thermal Zone [THRM] (40 C)
nvram: can't misc_register on minor=144
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: unable to get minor: 175
agpgart: agp_frontend_initialize() failed.
------------[ cut here ]------------
kernel BUG at arch/i386/mm/pageattr.c:165!
invalid opcode: 0000 [#1]
PREEMPT SMP 
last sysfs file: 
Modules linked in:
CPU:    0
EIP:    0060:[<c011b2ed>]    Not tainted VLI
EFLAGS: 00010082   (2.6.19-rc3-mm1-smp #10)
EIP is at change_page_attr+0x2a8/0x2ac
eax: c070af7c   ebx: dffbe380   ecx: 00000163   edx: c1000000
esi: f8a80000   edi: c16fa000   ebp: dfd01e30   esp: dfd01df8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, ti=dfd00000 task=c20eea90 task.ti=dfd00000)
Stack: 00000041 c16fa800 00000040 00000202 c100e140 f7d40000 c070af7c 00000163 
       00000163 00000001 00000000 dffbe380 f8a80000 c16fa000 dfd01e4c c011adfd 
       000000b4 00000000 00040000 dffb78c0 dffb78c0 dfd01e64 c034b9a6 00000006 
Call Trace:
 [<c011adfd>] iounmap+0xcd/0xd8
 [<c034b9a6>] agp_generic_free_gatt_table+0x34/0xce
 [<c034a4d5>] agp_backend_cleanup+0x20/0x55
 [<c034a931>] agp_add_bridge+0x32a/0x3c9
 [<c034e8db>] agp_intel_probe+0x17c/0x65c
 [<c02e25ae>] pci_device_probe+0x44/0x5f
 [<c0363274>] driver_probe_device+0x6c/0x132
 [<c0363442>] __driver_attach+0x84/0x86
 [<c0362853>] bus_for_each_dev+0x40/0x5e
 [<c0363130>] driver_attach+0x19/0x1b
 [<c0362b7a>] bus_add_driver+0x6a/0x185
 [<c0363699>] driver_register+0x54/0x84
 [<c02e272a>] __pci_register_driver+0x5f/0x90
 [<c06eacf7>] agp_intel_init+0x20/0x22
 [<c01004b6>] init+0x10d/0x310
 [<c0103db7>] kernel_thread_helper+0x7/0x10
 =======================
Code: d4 b8 00 72 5b c0 e8 1b ef 3c 00 89 d8 83 c4 2c 5b 5e 5f 5d c3 bb ea ff ff ff eb e2 0f 0b eb fe bb f4 ff ff ff eb d7 0f 0b eb fe <0f> 0b eb fe 55 89 e5 53 89 c3 85 c0 74 4d a1 8c 57 63 c0 a9 00 
EIP: [<c011b2ed>] change_page_attr+0x2a8/0x2ac SS:ESP 0068:dfd01df8
 <0>Kernel panic - not syncing: Attempted to kill init!
 WARNING at arch/i386/kernel/smp.c:549 smp_call_function()
 [<c0104282>] dump_trace+0x1b7/0x1e6
 [<c01042cb>] show_trace_log_lvl+0x1a/0x30
 [<c010495f>] show_trace+0x12/0x14
 [<c01049e6>] dump_stack+0x16/0x18
 [<c0112bb9>] smp_call_function+0x115/0x11a
 [<c0112bdc>] smp_send_stop+0x1e/0x27
 [<c0123594>] panic+0x5f/0x12b
 [<c0126d3d>] do_exit+0x81b/0x938
 [<c010487f>] do_trap+0x0/0x9d
 [<c01048f2>] do_trap+0x73/0x9d
 [<c0105189>] do_invalid_op+0x97/0xa1
 [<c04ea3ec>] error_code+0x7c/0x84
 [<c011b2ed>] change_page_attr+0x2a8/0x2ac
 [<c011adfd>] iounmap+0xcd/0xd8
 [<c034b9a6>] agp_generic_free_gatt_table+0x34/0xce
 [<c034a4d5>] agp_backend_cleanup+0x20/0x55
 [<c034a931>] agp_add_bridge+0x32a/0x3c9
 [<c034e8db>] agp_intel_probe+0x17c/0x65c
 [<c02e25ae>] pci_device_probe+0x44/0x5f
 [<c0363274>] driver_probe_device+0x6c/0x132
 [<c0363442>] __driver_attach+0x84/0x86
 [<c0362853>] bus_for_each_dev+0x40/0x5e
 [<c0363130>] driver_attach+0x19/0x1b
 [<c0362b7a>] bus_add_driver+0x6a/0x185
 [<c0363699>] driver_register+0x54/0x84
 [<c02e272a>] __pci_register_driver+0x5f/0x90
 [<c06eacf7>] agp_intel_init+0x20/0x22
 [<c01004b6>] init+0x10d/0x310
 [<c0103db7>] kernel_thread_helper+0x7/0x10
 =======================



