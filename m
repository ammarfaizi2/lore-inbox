Return-Path: <linux-kernel-owner+w=401wt.eu-S1751212AbXALO50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbXALO50 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 09:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbXALO50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 09:57:26 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:30310 "EHLO
	noname.neutralserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbXALO5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 09:57:24 -0500
Date: Fri, 12 Jan 2007 16:57:10 +0200
From: Dan Aloni <da-x@monatomic.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: kexec + USB storage in 2.6.19
Message-ID: <20070112145710.GA29884@localdomain>
References: <20070112122444.GA28597@localdomain> <m1mz4oe3xm.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1mz4oe3xm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-PopBeforeSMTPSenders: da-x@monatomic.org
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 07:05:09AM -0700, Eric W. Biederman wrote:
> Dan Aloni <da-x@monatomic.org> writes:
> 
> > Hello,
> >
> > After upgrading from 2.6.18.3 to 2.6.19.2 on an x86_64 machine I noticed 
> > that the EHCI USB host is unable to work properly after a kexec invocation. 
> > This makes it impossible to mount the rootfs in the configuration I'm using.
> >
> > According to the prints, the irq changes from 23 to 10.
> >
> > NOTE: Since the device is already connected at boot, I've added a patch 
> > that disables the scanning delay for the first detected device, in order 
> > to shorten the time it takes for the boot process. It worked on 2.6.18.3, 
> > so I wonder what has changed...
> 
> At first glance it looks like acpi didn't come on in the kexec'd kernel.
> Do you see anything like the line below.
> > [ 78.139976] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ
> 
> Could your provide the full bootlogs instead of these partial ones?
> There is enough context missing I don't think anyone can do more than 
> agree you are seeing a problem.

Looks like you were right about the ACPI being disabled during boot.

I'm attaching the full logs.

Note that there are a few additions to the kernel, some are known to
everyone (kdb), and the others are self-bred facilities for tracing,
logging across kexec-invocations, and specialized memory pools 
(respectively, dandalf, permamem, prebb), but these are not related 
to the problem that we see here.

Just for the record, I also used a modified version of gcc 4.1.1 that
adds a switch (see the 'Re: [PATCH] add -foverride-comp-dir' thread 
on gcc-devel) - it should also be completely disconnected from this 
problem as well.

This kernel was also patched for retrying to mount the root dev with
a timeout, also to reduce execution time. 

Sorry that I can't test with the vanilla kernel - it's a specialized 
environment. All changes are available under GPL on request.


[ 8655.114721] Starting new kernel
[    0.000000] Linux version 2.6.19.2-xiv-34-x86_64-misc (dan@pro135) (gcc version 4.1.1 (xiv)) #4 SMP Fri Jan 12 14:03:34 IST 2007
[    0.000000] Command line: ro root=/dev/sda1 rootdelay=10 init=/xiv/system/xinit console=ttyS0,115200
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000100 - 000000000009b800 (usable)
[    0.000000]  BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cff70000 (usable)
[    0.000000]  BIOS-e820: 00000000cff70000 - 00000000cff78000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cff78000 - 00000000cff80000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cff80000 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
[    0.000000] end_pfn_map = 1245184
[    0.000000] DMI present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             1 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1245184
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        1 ->      155
[    0.000000]     0:      256 ->   851824
[    0.000000]     0:  1048576 ->  1245184
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
[    0.000000] Processor #6
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] WARNING: NR_CPUS limit of 2 reached. Processor ignored.
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
[    0.000000] Processor #7
[    0.000000] WARNING: NR_CPUS limit of 2 reached. Processor ignored.
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x03] address[0xfec80000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 3, address 0xfec80000, GSI 24-47
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec80400] gsi_base[48])
[    0.000000] IOAPIC[2]: apic_id 4, address 0xfec80400, GSI 48-71
[    0.000000] ACPI: IOAPIC (id[0x05] address[0xfec84000] gsi_base[72])
[    0.000000] IOAPIC[3]: apic_id 5, address 0xfec84000, GSI 72-95
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec84400] gsi_base[96])
[    0.000000] IOAPIC[4]: apic_id 8, address 0xfec84400, GSI 96-119
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009b000 - 000000000009c000
[    0.000000] Nosave address range: 000000000009c000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 0000000000100000
[    0.000000] Nosave address range: 00000000cff70000 - 00000000cff78000
[    0.000000] Nosave address range: 00000000cff78000 - 00000000cff80000
[    0.000000] Nosave address range: 00000000cff80000 - 00000000d0000000
[    0.000000] Nosave address range: 00000000d0000000 - 00000000e0000000
[    0.000000] Nosave address range: 00000000e0000000 - 00000000f0000000
[    0.000000] Nosave address range: 00000000f0000000 - 00000000fec00000
[    0.000000] Nosave address range: 00000000fec00000 - 00000000fec10000
[    0.000000] Nosave address range: 00000000fec10000 - 00000000fee00000
[    0.000000] Nosave address range: 00000000fee00000 - 00000000fee01000
[    0.000000] Nosave address range: 00000000fee01000 - 00000000ff800000
[    0.000000] Nosave address range: 00000000ff800000 - 00000000ffc00000
[    0.000000] Nosave address range: 00000000ffc00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at d1000000 (gap: d0000000:10000000)
[    0.000000] PERCPU: Allocating 34176 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 1029907
[    0.000000] Kernel command line: ro root=/dev/sda1 rootdelay=10 init=/xiv/system/xinit console=ttyS0,115200
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[ 8655.473910] Console: colour VGA+ 80x25
[ 8655.911117] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[ 8655.921834] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[ 8655.929466] Checking aperture...
[ 8655.932837] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[ 8655.978621] Placing software IO TLB between 0x5900000 - 0x9900000
[ 8655.984713] permamem: initializing
[ 8655.988113] permamem: allocating dandalf at 0000000020000000 with 48 MBs, virt ffff810020000000, page ffff810001700000
[ 8656.000350] prebb: allocation for objsize 1048576 (2 objects) succeeded
[ 8656.013001] prebb: allocation for objsize 8192 (1280 objects) succeeded
[ 8656.019631] prebb: activated with 2 prebb pools
[ 8656.062066] Memory: 3985264k/4980736k available (2867k kernel code, 207768k reserved, 1839k data, 264k init)
[ 8656.149100] Calibrating delay using timer specific routine.. 5604.62 BogoMIPS (lpj=11209254)
[ 8656.178702] kdb version 4.4 by Keith Owens, Scott Lurndal. Copyright SGI, All Rights Reserved
kdb_cmd[0]: defcmd archkdb "" "First line arch debugging"
kdb_cmd[7]: defcmd archkdbcpu "" "archkdb with only tasks on cpus"
kdb_cmd[14]: defcmd archkdbshort "" "archkdb with less detailed backtrace"
kdb_cmd[21]: defcmd archkdbcommon "" "Common arch debugging"
[ 8656.210293] dandalf: partition entries size 15442 KB
[ 8656.215252] dandalf: partition vardata size 3676 KB
[ 8656.220121] dandalf: partition logptrs size 2451 KB
[ 8656.224990] dandalf: partition modentries size 490 KB
[ 8656.230032] dandalf: partition modvardata size 2451 KB
[ 8656.235340] dandalf: initialization succeeded
[ 8656.239746] Mount-cache hash table entries: 256
[ 8656.244416] CPU: Trace cache: 12K uops, L1 D cache: 16K
[ 8656.249656] CPU: L2 cache: 2048K
[ 8656.252876] using mwait in idle threads.
[ 8656.256791] CPU: Physical Processor ID: 0
[ 8656.260794] CPU: Processor Core ID: 0
[ 8656.264477] Freeing SMP alternatives: 24k freed
[ 8656.269024] ACPI: Core revision 20060707
[ 8656.272980] ACPI Error (tbxfroot-0512): Could not map memory at 0000040E for length 2 [20060707]
[ 8656.281789] ACPI Exception (tbxfroot-0400): AE_NO_MEMORY, RSDP structure not found - Flags=8 [20060707]
[ 8656.291201] ACPI: System description tables not found
[ 8656.296239] ACPI Exception (tbxface-0076): AE_NOT_FOUND, Could not get the RSDP [20060707]
[ 8656.304521] ACPI Exception (tbxface-0120): AE_NOT_FOUND, Could not load tables [20060707]
[ 8656.312711] ACPI: Unable to load the System Description Tables
[ 8656.359049] Using local APIC timer interrupts.
[ 8656.399123] result 12500612
[ 8656.401912] Detected 12.500 MHz APIC timer.
[ 8656.408772] Booting processor 1/2 APIC 0x6
[ 8656.423423] Initializing CPU#1
[ 8656.500442] Calibrating delay using timer specific routine.. 5600.74 BogoMIPS (lpj=11201480)
[ 8656.500456] CPU: Trace cache: 12K uops, L1 D cache: 16K
[ 8656.500460] CPU: L2 cache: 2048K
[ 8656.500464] CPU: Physical Processor ID: 3
[ 8656.500466] CPU: Processor Core ID: 0
[ 8656.500478] CPU1: Thermal monitoring enabled (TM1)
[ 8656.500907]                   Intel(R) Xeon(TM) CPU 2.80GHz stepping 03
[ 8656.504479] Brought up 2 CPUs
[ 8656.546386] testing NMI watchdog ... OK.
[ 8656.590251] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[ 8656.596421] time.c: Detected 2800.161 MHz processor.
[ 8656.977181] migration_cost=1789
[ 8656.980875] NET: Registered protocol family 16
[ 8656.989756] PCI: Using MMCONFIG at e0000000
[ 8656.994212] PCI: No mmconfig possible on device 08:01
[ 8657.000006] ACPI: Interpreter disabled.
[ 8657.003847] Linux Plug and Play Support v0.97 (c) Adam Belay
[ 8657.009501] pnp: PnP ACPI: disabled
[ 8657.018700] SCSI subsystem initialized
[ 8657.022518] usbcore: registered new interface driver usbfs
[ 8657.028018] usbcore: registered new interface driver hub
[ 8657.033352] usbcore: registered new device driver usb
[ 8657.038431] PCI: Probing PCI hardware
[ 8657.042503] PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
[ 8657.048928] PCI quirk: region 1180-11bf claimed by ICH4 GPIO
[ 8657.054601] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
[ 8657.060578] PCI: PXH quirk detected, disabling MSI for SHPC device
[ 8657.066784] PCI: PXH quirk detected, disabling MSI for SHPC device
[ 8657.073305] PCI: PXH quirk detected, disabling MSI for SHPC device
[ 8657.079518] PCI: PXH quirk detected, disabling MSI for SHPC device
[ 8657.086047] PCI: Transparent bridge - 0000:00:1e.0
[ 8657.091757] PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
[ 8657.098423] PCI-GART: No AMD northbridge found.
[ 8657.103100] PCI: Bridge: 0000:01:00.0
[ 8657.106754]   IO window: 2000-2fff
[ 8657.110155]   MEM window: dc200000-dc2fffff
[ 8657.114330]   PREFETCH window: d1800000-d18fffff
[ 8657.118941] PCI: Bridge: 0000:01:00.2
[ 8657.122597]   IO window: 3000-3fff
[ 8657.126000]   MEM window: dc300000-dc3fffff
[ 8657.130175]   PREFETCH window: disabled.
[ 8657.134095] PCI: Bridge: 0000:00:02.0
[ 8657.137752]   IO window: 2000-3fff
[ 8657.141156]   MEM window: dc100000-dc3fffff
[ 8657.145331]   PREFETCH window: d1800000-d18fffff
[ 8657.149943] PCI: Bridge: 0000:00:04.0
[ 8657.153597]   IO window: disabled.
[ 8657.156992]   MEM window: disabled.
[ 8657.160476]   PREFETCH window: disabled.
[ 8657.164398] PCI: Bridge: 0000:05:00.0
[ 8657.168052]   IO window: 4000-4fff
[ 8657.171454]   MEM window: dc500000-dcbfffff
[ 8657.175629]   PREFETCH window: d1000000-d13fffff
[ 8657.180240] PCI: Bridge: 0000:05:00.2
[ 8657.183897]   IO window: 5000-5fff
[ 8657.187299]   MEM window: dcc00000-dd0fffff
[ 8657.191477]   PREFETCH window: d1400000-d17fffff
[ 8657.196086] PCI: Bridge: 0000:00:06.0
[ 8657.199743]   IO window: 4000-5fff
[ 8657.203145]   MEM window: dc400000-dd0fffff
[ 8657.207320]   PREFETCH window: d1000000-d17fffff
[ 8657.211935] PCI: Bridge: 0000:00:1e.0
[ 8657.215589]   IO window: 6000-6fff
[ 8657.218988]   MEM window: dd100000-deffffff
[ 8657.223169]   PREFETCH window: d1900000-d19fffff
[ 8657.227903] NET: Registered protocol family 2
[ 8657.267053] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[ 8657.274895] TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
[ 8657.284596] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
[ 8657.292489] TCP: Hash tables configured (established 131072 bind 65536)
[ 8657.299102] TCP reno registered
[ 8657.302360] Simple Boot Flag at 0x39 set to 0x80
[ 8657.307636] JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
[ 8657.313794] SGI XFS with large block/inode numbers, no debug enabled
[ 8657.320360] io scheduler noop registered
[ 8657.324297] io scheduler anticipatory registered (default)
[ 8657.329806] io scheduler deadline registered
[ 8657.334104] io scheduler cfq registered
[ 8657.354521] Real Time Clock Driver v1.12ac
[ 8657.358616] Linux agpgart interface v0.101 (c) Dave Jones
[ 8657.364003] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[ 8657.371908] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[ 8657.378011] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[ 8657.384307] Floppy drive(s): fd0 is 1.44M
[ 8657.408129] FDC 0 is a National Semiconductor PC87306
[ 8657.414492] RAMDISK driver initialized: 16 RAM disks of 80000K size 1024 blocksize
[ 8657.422224] loop: loaded (max 8 devices)
[ 8657.426252] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[ 8657.432595] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[ 8657.440617] ICH5-SATA: IDE controller at PCI slot 0000:00:1f.2
[ 8657.446452] ICH5-SATA: chipset revision 2
[ 8657.450454] ICH5-SATA: not 100% native mode: will probe irqs later
[ 8657.456625]     ide0: BM-DMA at 0x14b0-0x14b7, BIOS settings: hda:DMA, hdb:pio
[ 8657.463883]     ide1: BM-DMA at 0x14b8-0x14bf, BIOS settings: hdc:pio, hdd:pio
[ 8657.762190] hda: HDS725050KLA360, ATA DISK drive
[ 8658.440928] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[ 8659.586567] hda: max request size: 1024KiB
[ 8659.596977] hda: 976773168 sectors (500107 MB) w/15607KiB Cache, CHS=60801/255/63, UDMA(33)
[ 8659.605577] hda: cache flushes supported
[ 8659.609553]  hda: hda1
[ 8659.617253] block2mtd: version $Revision: 1.30 $
[ 8659.621859] usbmon: debugfs is not available
[ 8659.626919] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[ 8659.632208] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[ 8659.639615] ehci_hcd 0000:00:1d.7: debug port 1
[ 8659.644155] ehci_hcd 0000:00:1d.7: irq 10, io mem 0xdc001000
[ 8659.653678] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[ 8659.661254] usb usb1: configuration #1 chosen from 1 choice
[ 8659.666838] hub 1-0:1.0: USB hub found
[ 8659.670587] hub 1-0:1.0: 8 ports detected
[ 8659.782260] Initializing USB Mass Storage driver...
[ 8659.787138] usbcore: registered new interface driver usb-storage
[ 8659.793137] USB Mass Storage support registered.
[ 8659.797792] PNP: No PS/2 controller found. Probing ports directly.
[ 8659.806486] serio: i8042 KBD port at 0x60,0x64 irq 1
[ 8659.811448] serio: i8042 AUX port at 0x60,0x64 irq 12
[ 8659.816506] mice: PS/2 mouse device common for all mice
[ 8659.821727] EDAC MC: Ver: 2.0.1 Jan 12 2007
[ 8659.826054] EDAC e752x: tolm = d0000, remapbase = 100000, remaplimit = 12c000
[ 8659.833227] EDAC MC0: Giving out device to e752x_edac E7520: DEV 0000:00:00.0
[ 8659.840385] EDAC e752x: Non-Fatal Error PCI Express B
[ 8659.845431] EDAC e752x: Non-Fatal Error PCI Express B
[ 8659.845443] TCP cubic registered
[ 8659.853688] NET: Registered protocol family 1
[ 8659.858043] NET: Registered protocol family 17
[ 8659.862480] 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
[ 8659.869253] All bugs added by David S. Miller <davem@redhat.com>
[ 8659.981933] VFS: retrying root mount
[ 8660.033685] usb 1-1: new high speed USB device using ehci_hcd and address 2
[ 8660.484933] VFS: retrying root mount
[ 8660.987963] VFS: retrying root mount
[ 8661.039752] ehci_hcd 0000:00:1d.7: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.
[ 8661.487010] VFS: retrying root mount
[ 8661.990045] VFS: retrying root mount
[ 8662.493080] VFS: retrying root mount
[ 8662.996115] VFS: retrying root mount
[ 8663.499152] VFS: retrying root mount
[ 8664.002186] VFS: retrying root mount
[ 8664.505221] VFS: retrying root mount
[ 8665.008258] VFS: retrying root mount
[ 8665.511294] VFS: retrying root mount
[ 8666.014330] VFS: retrying root mount
[ 8666.517366] VFS: retrying root mount
[ 8667.020401] VFS: retrying root mount
[ 8667.523439] VFS: retrying root mount
[ 8668.026473] VFS: retrying root mount
[ 8668.529508] VFS: retrying root mount
[ 8669.032544] VFS: retrying root mount
[ 8669.535580] VFS: retrying root mount
[ 8670.038617] VFS: Cannot open root device "sda1" or unknown-block(0,0)
[ 8670.045045] Please append a correct "root=" boot option
[ 8670.050259] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[ 8670.058502]  
Entering kdb (current=0xffff81012fcca7a0, pid 1) on processor 1 due to KDB_ENTER()
[1]kdb> 

----------------

A normal boot log:

[    0.000000] Linux version 2.6.19.2-xiv-34-x86_64-misc (dan@pro135) (gcc version 4.1.1 (xiv)) #4 SMP Fri Jan 12 14:03:34 IST 2007
[    0.000000] Command line: ro root=/dev/sda1 rootdelay=10 init=/xiv/system/xinit console=ttyS0,115200
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
[    0.000000]  BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cff70000 (usable)
[    0.000000]  BIOS-e820: 00000000cff70000 - 00000000cff78000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cff78000 - 00000000cff80000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cff80000 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
[    0.000000] end_pfn_map = 1245184
[    0.000000] DMI present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1245184
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      155
[    0.000000]     0:      256 ->   851824
[    0.000000]     0:  1048576 ->  1245184
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
[    0.000000] Processor #6
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] WARNING: NR_CPUS limit of 2 reached. Processor ignored.
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
[    0.000000] Processor #7
[    0.000000] WARNING: NR_CPUS limit of 2 reached. Processor ignored.
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x03] address[0xfec80000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 3, address 0xfec80000, GSI 24-47
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec80400] gsi_base[48])
[    0.000000] IOAPIC[2]: apic_id 4, address 0xfec80400, GSI 48-71
[    0.000000] ACPI: IOAPIC (id[0x05] address[0xfec84000] gsi_base[72])
[    0.000000] IOAPIC[3]: apic_id 5, address 0xfec84000, GSI 72-95
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec84400] gsi_base[96])
[    0.000000] IOAPIC[4]: apic_id 8, address 0xfec84400, GSI 96-119
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009b000 - 000000000009c000
[    0.000000] Nosave address range: 000000000009c000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e4000
[    0.000000] Nosave address range: 00000000000e4000 - 0000000000100000
[    0.000000] Nosave address range: 00000000cff70000 - 00000000cff78000
[    0.000000] Nosave address range: 00000000cff78000 - 00000000cff80000
[    0.000000] Nosave address range: 00000000cff80000 - 00000000d0000000
[    0.000000] Nosave address range: 00000000d0000000 - 00000000e0000000
[    0.000000] Nosave address range: 00000000e0000000 - 00000000f0000000
[    0.000000] Nosave address range: 00000000f0000000 - 00000000fec00000
[    0.000000] Nosave address range: 00000000fec00000 - 00000000fec10000
[    0.000000] Nosave address range: 00000000fec10000 - 00000000fee00000
[    0.000000] Nosave address range: 00000000fee00000 - 00000000fee01000
[    0.000000] Nosave address range: 00000000fee01000 - 00000000ff800000
[    0.000000] Nosave address range: 00000000ff800000 - 00000000ffc00000
[    0.000000] Nosave address range: 00000000ffc00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at d1000000 (gap: d0000000:10000000)
[    0.000000] PERCPU: Allocating 34176 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 1029907
[    0.000000] Kernel command line: ro root=/dev/sda1 rootdelay=10 init=/xiv/system/xinit console=ttyS0,115200
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   87.927578] Console: colour VGA+ 80x25
[   88.378396] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[   88.389160] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   88.396798] Checking aperture...
[   88.400165] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   88.446650] Placing software IO TLB between 0x5900000 - 0x9900000
[   88.452744] permamem: initializing
[   88.456142] permamem: allocating dandalf at 0000000020000000 with 48 MBs, virt ffff810020000000, page ffff810001700000
[   88.468414] prebb: allocation for objsize 1048576 (2 objects) succeeded
[   88.481074] prebb: allocation for objsize 8192 (1280 objects) succeeded
[   88.487706] prebb: activated with 2 prebb pools
[   88.530267] Memory: 3985264k/4980736k available (2867k kernel code, 207772k reserved, 1839k data, 264k init)
[   88.618737] Calibrating delay using timer specific routine.. 5604.65 BogoMIPS (lpj=11209307)
[   88.649777] kdb version 4.4 by Keith Owens, Scott Lurndal. Copyright SGI, All Rights Reserved
kdb_cmd[0]: defcmd archkdb "" "First line arch debugging"
kdb_cmd[7]: defcmd archkdbcpu "" "archkdb with only tasks on cpus"
kdb_cmd[14]: defcmd archkdbshort "" "archkdb with less detailed backtrace"
kdb_cmd[21]: defcmd archkdbcommon "" "Common arch debugging"
[   88.681922] dandalf: partition entries size 15442 KB
[   88.686882] dandalf: partition vardata size 3676 KB
[   88.692494] dandalf: partition logptrs size 2451 KB
[   88.697363] dandalf: partition modentries size 490 KB
[   88.702405] dandalf: partition modvardata size 2451 KB
[   88.707715] dandalf: initialization succeeded
[   88.712123] Mount-cache hash table entries: 256
[   88.716798] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   88.722032] CPU: L2 cache: 2048K
[   88.725256] using mwait in idle threads.
[   88.729172] CPU: Physical Processor ID: 0
[   88.733175] CPU: Processor Core ID: 0
[   88.736844] CPU0: Thermal monitoring enabled (TM1)
[   88.741637] Freeing SMP alternatives: 24k freed
[   88.746175] ACPI: Core revision 20060707
[   88.794449] Using local APIC timer interrupts.
[   88.834526] result 12500652
[   88.837310] Detected 12.500 MHz APIC timer.
[   88.842473] Booting processor 1/2 APIC 0x6
[   88.857137] Initializing CPU#1
[   88.934146] Calibrating delay using timer specific routine.. 5600.65 BogoMIPS (lpj=11201313)
[   88.934160] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   88.934164] CPU: L2 cache: 2048K
[   88.934168] CPU: Physical Processor ID: 3
[   88.934170] CPU: Processor Core ID: 0
[   88.934182] CPU1: Thermal monitoring enabled (TM1)
[   88.934593]                   Intel(R) Xeon(TM) CPU 2.80GHz stepping 03
[   88.938180] Brought up 2 CPUs
[   88.980735] testing NMI watchdog ... OK.
[   89.024608] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[   89.030776] time.c: Detected 2800.166 MHz processor.
[   89.376365] migration_cost=1743
[   89.380050] NET: Registered protocol family 16
[   89.384546] ACPI: bus type pci registered
[   89.392937] PCI: Using MMCONFIG at e0000000
[   89.397396] PCI: No mmconfig possible on device 08:01
[   89.406174] ACPI: Interpreter enabled
[   89.409838] ACPI: Using IOAPIC for interrupt routing
[   89.415085] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   89.422404] PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
[   89.428831] PCI quirk: region 1180-11bf claimed by ICH4 GPIO
[   89.434507] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
[   89.440483] PCI: PXH quirk detected, disabling MSI for SHPC device
[   89.446688] PCI: PXH quirk detected, disabling MSI for SHPC device
[   89.453210] PCI: PXH quirk detected, disabling MSI for SHPC device
[   89.459417] PCI: PXH quirk detected, disabling MSI for SHPC device
[   89.466711] PCI: Transparent bridge - 0000:00:1e.0
[   89.479098] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 14 15)
[   89.486286] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
[   89.493461] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 11 14 15)
[   89.500635] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 14 15)
[   89.507809] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
[   89.516137] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 10 11 14 15) *0, disabled.
[   89.524276] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
[   89.532604] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 *10 11 14 15)
[   89.539559] ACPI: Device [PRT] status [0000000c]: functional but not present; setting present
[   89.549542] Linux Plug and Play Support v0.97 (c) Adam Belay
[   89.555203] pnp: PnP ACPI init
[   89.561717] pnp: PnP ACPI: found 12 devices
[   89.571619] SCSI subsystem initialized
[   89.575446] usbcore: registered new interface driver usbfs
[   89.580948] usbcore: registered new interface driver hub
[   89.586279] usbcore: registered new device driver usb
[   89.591366] PCI: Using ACPI for IRQ routing
[   89.595544] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   89.603921] PCI-GART: No AMD northbridge found.
[   89.608786] PCI: Bridge: 0000:01:00.0
[   89.612443]   IO window: 2000-2fff
[   89.615843]   MEM window: dc200000-dc2fffff
[   89.620018]   PREFETCH window: d1800000-d18fffff
[   89.624630] PCI: Bridge: 0000:01:00.2
[   89.628285]   IO window: 3000-3fff
[   89.631686]   MEM window: dc300000-dc3fffff
[   89.635862]   PREFETCH window: disabled.
[   89.639780] PCI: Bridge: 0000:00:02.0
[   89.643436]   IO window: 2000-3fff
[   89.646838]   MEM window: dc100000-dc3fffff
[   89.651014]   PREFETCH window: d1800000-d18fffff
[   89.655623] PCI: Bridge: 0000:00:04.0
[   89.659280]   IO window: disabled.
[   89.662681]   MEM window: disabled.
[   89.666164]   PREFETCH window: disabled.
[   89.670088] PCI: Bridge: 0000:05:00.0
[   89.673741]   IO window: 4000-4fff
[   89.677143]   MEM window: dc500000-dcbfffff
[   89.681319]   PREFETCH window: d1000000-d13fffff
[   89.685930] PCI: Bridge: 0000:05:00.2
[   89.689585]   IO window: 5000-5fff
[   89.692986]   MEM window: dcc00000-dd0fffff
[   89.697161]   PREFETCH window: d1400000-d17fffff
[   89.701772] PCI: Bridge: 0000:00:06.0
[   89.705429]   IO window: 4000-5fff
[   89.708830]   MEM window: dc400000-dd0fffff
[   89.713005]   PREFETCH window: d1000000-d17fffff
[   89.717617] PCI: Bridge: 0000:00:1e.0
[   89.721272]   IO window: 6000-6fff
[   89.725392]   MEM window: dd100000-deffffff
[   89.729567]   PREFETCH window: d1900000-d19fffff
[   89.734192] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[   89.741630] ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
[   89.749044] ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
[   89.756514] NET: Registered protocol family 2
[   89.796569] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   89.804412] TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
[   89.814087] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
[   89.821987] TCP: Hash tables configured (established 131072 bind 65536)
[   89.828596] TCP reno registered
[   89.831856] Simple Boot Flag at 0x39 set to 0x80
[   89.837134] JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
[   89.843285] SGI XFS with large block/inode numbers, no debug enabled
[   89.849848] io scheduler noop registered
[   89.853786] io scheduler anticipatory registered (default)
[   89.859287] io scheduler deadline registered
[   89.863583] io scheduler cfq registered
[   89.869471] ACPI: Power Button (FF) [PWRF]
[   89.873599] ACPI: Power Button (CM) [PWRB]
[   89.877792] Using specific hotkey driver
[   89.882065] ACPI: Getting cpuindex for acpiid 0x2
[   89.886771] ACPI: Getting cpuindex for acpiid 0x3
[   89.906793] Real Time Clock Driver v1.12ac
[   89.910887] Linux agpgart interface v0.101 (c) Dave Jones
[   89.916274] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   89.924184] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   89.930290] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   89.936703] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   89.942418] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   89.948155] Floppy drive(s): fd0 is 1.44M
[   89.971375] FDC 0 is a National Semiconductor PC87306
[   89.977728] RAMDISK driver initialized: 16 RAM disks of 80000K size 1024 blocksize
[   89.985465] loop: loaded (max 8 devices)
[   89.989489] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   89.995829] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   90.003849] ICH5-SATA: IDE controller at PCI slot 0000:00:1f.2
[   90.009684] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
[   90.017090] ICH5-SATA: chipset revision 2
[   90.021088] ICH5-SATA: not 100% native mode: will probe irqs later
[   90.027262]     ide0: BM-DMA at 0x14b0-0x14b7, BIOS settings: hda:pio, hdb:pio
[   90.034522]     ide1: BM-DMA at 0x14b8-0x14bf, BIOS settings: hdc:pio, hdd:pio
[   90.331630] hda: HDS725050KLA360, ATA DISK drive
[   91.010375] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   92.156005] hda: max request size: 1024KiB
[   92.171581] hda: 976773168 sectors (500107 MB) w/15607KiB Cache, CHS=60801/255/63, UDMA(33)
[   92.180178] hda: cache flushes supported
[   92.184147]  hda: hda1
[   92.189483] block2mtd: version $Revision: 1.30 $
[   92.194093] usbmon: debugfs is not available
[   92.198399] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
[   92.206572] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   92.211860] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   92.219272] ehci_hcd 0000:00:1d.7: debug port 1
[   92.223809] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xdc001000
[   92.233343] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   92.240924] usb usb1: configuration #1 chosen from 1 choice
[   92.246515] hub 1-0:1.0: USB hub found
[   92.250264] hub 1-0:1.0: 8 ports detected
[   92.359690] Initializing USB Mass Storage driver...
[   92.599138] usb 1-1: new high speed USB device using ehci_hcd and address 2
[   92.744533] usb 1-1: configuration #1 chosen from 1 choice
[   92.994378] usb 1-2: new high speed USB device using ehci_hcd and address 3
[   93.139812] usb 1-2: configuration #1 chosen from 1 choice
[   93.145732] scsi0 : SCSI emulation for USB Mass Storage devices
[   93.151756] scsi1 : SCSI emulation for USB Mass Storage devices
[   93.157745] usbcore: registered new interface driver usb-storage
[   93.162086] scsi 0:0:0:0: Direct-Access     OTi      Flash Disk       2.00 PQ: 0 ANSI: 2
[   93.171825] USB Mass Storage support registered.
[   93.176503] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[   93.184381] SCSI device sda: 2037760 512-byte hdwr sectors (1043 MB)
[   93.191394] sda: Write Protect is off
[   93.191886] serio: i8042 KBD port at 0x60,0x64 irq 1
[   93.191894] serio: i8042 AUX port at 0x60,0x64 irq 12
[   93.191916] mice: PS/2 mouse device common for all mice
[   93.191927] EDAC MC: Ver: 2.0.1 Jan 12 2007
[   93.214415] sda: assuming drive cache: write through
[   93.219475] EDAC e752x: tolm = d0000, remapbase = 100000, remaplimit = 12c000
[   93.226645] EDAC MC0: Giving out device to e752x_edac E7520: DEV 0000:00:00.0
[   93.233832] TCP cubic registered
[   93.237066] NET: Registered protocol family 1
[   93.241421] NET: Registered protocol family 17
[   93.245858] 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
[   93.252639] All bugs added by David S. Miller <davem@redhat.com>
[   93.260363] SCSI device sda: 2037760 512-byte hdwr sectors (1043 MB)
[   93.267221] sda: Write Protect is off
[   93.270885] sda: assuming drive cache: write through
[   93.275846]  sda: sda1 sda2 sda3
[   93.279962] sd 0:0:0:0: Attached scsi removable disk sda
[   93.371900] VFS: Mounted root (ext2 filesystem) readonly.
[   93.377313] xiv: board Supermicro X6DH8-XG2
[   93.381538] Freeing unused kernel memory: 264k freed

  - Dan
