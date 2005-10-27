Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVJ0Uzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVJ0Uzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVJ0Uzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:55:36 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:63969 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S932221AbVJ0Uze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:55:34 -0400
Message-ID: <43613EC4.4080006@candelatech.com>
Date: Thu, 27 Oct 2005 13:55:32 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel BUG at mm/slab.c:1488!  (2.6.13.2)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was compiling with ext3 as a module, then changed to compiling static
and un-tarred the new kernel over the old (the old ext3 module was still
in existence.)  I re-ran the mkinitrd and rebooted.

It seems that something still tries to load the ext3 module, and I get the
BUG seen below.  If I remove the ext3 module and re-build the initrd,
the error goes away.

I was thinking that at the least, the ext3 module code should somehow detect
that it is already built-in and exit it's load attempt very early (before
triggering whatever bug it hit).


Oct 27 12:22:04 sb65g2 kernel: Linux version 2.6.13.2 (greear@xeon-dt) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #4 SMP Thu Oct 27 10:50:18 PDT 2005
Oct 27 12:22:04 sb65g2 kernel: BIOS-provided physical RAM map:
Oct 27 12:22:04 sb65g2 kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Oct 27 12:22:04 sb65g2 kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Oct 27 12:22:04 sb65g2 kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Oct 27 12:22:04 sb65g2 kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
Oct 27 12:22:04 sb65g2 kernel:  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
Oct 27 12:22:04 sb65g2 kernel:  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
Oct 27 12:22:04 sb65g2 kernel:  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Oct 27 12:22:04 sb65g2 kernel: 0MB HIGHMEM available.
Oct 27 12:22:04 sb65g2 irqbalance: irqbalance startup succeeded
Oct 27 12:22:04 sb65g2 kernel: 511MB LOWMEM available.
Oct 27 12:22:04 sb65g2 kernel: found SMP MP-table at 000f52c0
Oct 27 12:22:04 sb65g2 kernel: DMI 2.2 present.
Oct 27 12:22:04 sb65g2 portmap: portmap startup succeeded
Oct 27 12:22:05 sb65g2 rpc.statd[2375]: Version 1.0.6 Starting
Oct 27 12:22:05 sb65g2 kernel: ACPI: PM-Timer IO Port: 0x408
Oct 27 12:22:05 sb65g2 kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Oct 27 12:22:05 sb65g2 kernel: Processor #0 15:3 APIC version 20
Oct 27 12:22:05 sb65g2 kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Oct 27 12:22:05 sb65g2 nfslock: rpc.statd startup succeeded
Oct 27 12:22:05 sb65g2 kernel: Processor #1 15:3 APIC version 20
Oct 27 12:22:05 sb65g2 kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Oct 27 12:22:05 sb65g2 kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Oct 27 12:22:05 sb65g2 kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Oct 27 12:22:05 sb65g2 kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Oct 27 12:22:05 sb65g2 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Oct 27 12:22:05 sb65g2 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Oct 27 12:22:05 sb65g2 kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Oct 27 12:22:05 sb65g2 kernel: Using ACPI (MADT) for SMP configuration information
Oct 27 12:22:05 sb65g2 kernel: Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Oct 27 12:22:05 sb65g2 kernel: Built 1 zonelists
Oct 27 12:22:05 sb65g2 kernel: Kernel command line: ro root=LABEL=/ rhgb quiet console=ttyS0,38400 console=tty0
Oct 27 12:22:05 sb65g2 rpcidmapd: rpc.idmapd startup succeeded
Oct 27 12:22:05 sb65g2 kernel: Initializing CPU#0
Oct 27 12:22:05 sb65g2 kernel: PID hash table entries: 2048 (order: 11, 32768 bytes)
Oct 27 12:22:05 sb65g2 kernel: Detected 2806.704 MHz processor.
Oct 27 12:22:05 sb65g2 kernel: Using pmtmr for high-res timesource
Oct 27 12:22:05 sb65g2 kernel: Console: colour VGA+ 80x25
Oct 27 12:22:05 sb65g2 kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Oct 27 12:22:05 sb65g2 kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Oct 27 12:22:05 sb65g2 kernel: Memory: 513896k/524224k available (2340k kernel code, 9664k reserved, 1255k data, 220k init, 0k highmem)
Oct 27 12:22:05 sb65g2 kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Oct 27 12:22:05 sb65g2 kernel: Calibrating delay using timer specific routine.. 5616.38 BogoMIPS (lpj=2808192)
Oct 27 12:22:05 sb65g2 kernel: Security Framework v1.0.0 initialized
Oct 27 12:22:05 sb65g2 kernel: SELinux:  Initializing.
Oct 27 12:22:05 sb65g2 kernel: SELinux:  Starting in permissive mode
Oct 27 12:22:05 sb65g2 random: Initializing random number generator:  succeeded
Oct 27 12:22:05 sb65g2 kernel: selinux_register_security:  Registering secondary module capability
Oct 27 12:22:05 sb65g2 kernel: Capability LSM initialized as secondary
Oct 27 12:22:05 sb65g2 kernel: Mount-cache hash table entries: 512
Oct 27 12:22:05 sb65g2 kernel: monitor/mwait feature present.
Oct 27 12:22:05 sb65g2 kernel: using mwait in idle threads.
Oct 27 12:22:05 sb65g2 kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Oct 27 12:22:05 sb65g2 netfs: Mounting other filesystems:  succeeded
Oct 27 12:22:05 sb65g2 kernel: CPU: L2 cache: 1024K
Oct 27 12:22:05 sb65g2 kernel: CPU: Physical Processor ID: 0
Oct 27 12:22:05 sb65g2 kernel: Intel machine check architecture supported.
Oct 27 12:22:05 sb65g2 kernel: Intel machine check reporting enabled on CPU#0.
Oct 27 12:22:06 sb65g2 kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Oct 27 12:22:06 sb65g2 kernel: mtrr: v2.0 (20020519)
Oct 27 12:22:06 sb65g2 kernel: Enabling fast FPU save and restore... done.
Oct 27 12:22:06 sb65g2 kernel: Enabling unmasked SIMD FPU exception support... done.
Oct 27 12:22:06 sb65g2 kernel: Checking 'hlt' instruction... OK.
Oct 27 12:22:06 sb65g2 kernel: CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 03
Oct 27 12:22:06 sb65g2 kernel: Booting processor 1/1 eip 2000
Oct 27 12:22:06 sb65g2 autofs: automount startup succeeded
Oct 27 12:22:06 sb65g2 kernel: Initializing CPU#1
Oct 27 12:22:06 sb65g2 kernel: Calibrating delay using timer specific routine.. 5611.92 BogoMIPS (lpj=2805961)
Oct 27 12:22:06 sb65g2 kernel: monitor/mwait feature present.
Oct 27 12:22:06 sb65g2 smartd[2491]: smartd version 5.21 Copyright (C) 2002-3 Bruce Allen
Oct 27 12:22:06 sb65g2 kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Oct 27 12:22:06 sb65g2 smartd[2491]: Home page is http://smartmontools.sourceforge.net/
Oct 27 12:22:06 sb65g2 kernel: CPU: L2 cache: 1024K
Oct 27 12:22:06 sb65g2 smartd[2491]: Opened configuration file /etc/smartd.conf
Oct 27 12:22:06 sb65g2 kernel: CPU: Physical Processor ID: 0
Oct 27 12:22:06 sb65g2 smartd[2491]: Configuration file /etc/smartd.conf parsed.
Oct 27 12:22:06 sb65g2 smartd[2491]: Device: /dev/hda, opened
Oct 27 12:22:06 sb65g2 kernel: Intel machine check architecture supported.
Oct 27 12:22:06 sb65g2 kernel: Intel machine check reporting enabled on CPU#1.
Oct 27 12:22:06 sb65g2 kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
Oct 27 12:22:06 sb65g2 smartd[2491]: Device: /dev/hda, unable to read Device Identity Structure
Oct 27 12:22:06 sb65g2 kernel: CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 03
Oct 27 12:22:06 sb65g2 smartd[2491]: Unable to register ATA device /dev/hda at line 30 of file /etc/smartd.conf
Oct 27 12:22:06 sb65g2 kernel: Total of 2 processors activated (11228.30 BogoMIPS).
Oct 27 12:22:06 sb65g2 smartd[2491]: Unable to register device /dev/hda (no Directive -d removable). Exiting.
Oct 27 12:22:06 sb65g2 kernel: ENABLING IO-APIC IRQs
Oct 27 12:22:06 sb65g2 smartd: smartd startup failed
Oct 27 12:22:06 sb65g2 kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Oct 27 12:22:06 sb65g2 kernel: checking TSC synchronization across 2 CPUs: passed.
Oct 27 12:22:06 sb65g2 kernel: Brought up 2 CPUs
Oct 27 12:22:06 sb65g2 kernel: checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Oct 27 12:22:06 sb65g2 kernel: Freeing initrd memory: 267k freed
Oct 27 12:22:06 sb65g2 kernel: NET: Registered protocol family 16
Oct 27 12:22:06 sb65g2 acpid: acpid startup succeeded
Oct 27 12:22:06 sb65g2 kernel: ACPI: bus type pci registered
Oct 27 12:22:06 sb65g2 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb460, last bus=3
Oct 27 12:22:06 sb65g2 kernel: PCI: Using configuration type 1
Oct 27 12:21:50 sb65g2 rc.sysinit: -e
Oct 27 12:22:07 sb65g2 kernel: ACPI: Subsystem revision 20050408
Oct 27 12:21:50 sb65g2 sysctl: net.ipv4.ip_forward = 0
Oct 27 12:22:07 sb65g2 kernel: ACPI: Interpreter enabled
Oct 27 12:21:50 sb65g2 sysctl: net.ipv4.conf.default.rp_filter = 1
Oct 27 12:22:07 sb65g2 kernel: ACPI: Using IOAPIC for interrupt routing
Oct 27 12:21:50 sb65g2 sysctl: kernel.sysrq = 0
Oct 27 12:22:07 sb65g2 kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Oct 27 12:21:50 sb65g2 sysctl: kernel.core_uses_pid = 1
Oct 27 12:22:08 sb65g2 kernel: PCI: Probing PCI hardware (bus 00)
Oct 27 12:21:50 sb65g2 rc.sysinit: Configuring kernel parameters:  succeeded
Oct 27 12:22:08 sb65g2 kernel: ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Oct 27 12:21:50 sb65g2 date: Thu Oct 27 12:21:46 PDT 2005
Oct 27 12:22:08 sb65g2 kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Oct 27 12:21:50 sb65g2 rc.sysinit: Setting clock  (localtime): Thu Oct 27 12:21:46 PDT 2005 succeeded
Oct 27 12:21:50 sb65g2 rc.sysinit: Loading default keymap succeeded
Oct 27 12:22:08 sb65g2 kernel: PCI: Transparent bridge - 0000:00:1e.0
Oct 27 12:21:50 sb65g2 rc.sysinit: Setting hostname sb65g2:  succeeded
Oct 27 12:21:50 sb65g2 rc.sysinit: Initializing USB controller (ehci-hcd):  succeeded
Oct 27 12:21:50 sb65g2 rc.sysinit: Initializing USB controller (uhci-hcd):  succeeded
Oct 27 12:22:08 sb65g2 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
Oct 27 12:21:50 sb65g2 rc.sysinit: Mounting USB filesystem:  succeeded
Oct 27 12:22:08 sb65g2 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
Oct 27 12:21:50 sb65g2 fsck: /: clean, 224811/2562240 files, 1946810/5118710 blocks
Oct 27 12:22:08 sb65g2 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12 14 15)
Oct 27 12:21:50 sb65g2 rc.sysinit: Checking root filesystem succeeded
Oct 27 12:22:08 sb65g2 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 7 9 10 11 12 14 15)
Oct 27 12:21:50 sb65g2 rc.sysinit: Remounting root filesystem in read-write mode:  succeeded
Oct 27 12:22:08 sb65g2 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 7 9 10 11 12 14 15)
Oct 27 12:21:51 sb65g2 rc.sysinit: Activating swap partitions:  succeeded
Oct 27 12:22:08 sb65g2 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12 14 15)
Oct 27 12:21:51 sb65g2 devlabel: devlabel service started/restarted
Oct 27 12:22:08 sb65g2 kernel: ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 *9 10 11 12 14 15)
Oct 27 12:21:52 sb65g2 fsck: /boot: clean, 64/26104 files, 35161/104388 blocks
Oct 27 12:22:08 sb65g2 kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 7 9 10 11 12 14 15)
Oct 27 12:21:52 sb65g2 rc.sysinit: Checking filesystems succeeded
Oct 27 12:22:08 sb65g2 kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Oct 27 12:21:52 sb65g2 rc.sysinit: Mounting local filesystems:  succeeded
Oct 27 12:22:08 sb65g2 kernel: pnp: PnP ACPI init
Oct 27 12:21:52 sb65g2 rc.sysinit: Enabling local filesystem quotas:  succeeded
Oct 27 12:22:08 sb65g2 kernel: pnp: PnP ACPI: found 13 devices
Oct 27 12:21:52 sb65g2 rc.sysinit: Enabling swap space:  succeeded
Oct 27 12:22:08 sb65g2 kernel: usbcore: registered new driver usbfs
Oct 27 12:21:53 sb65g2 init: Entering runlevel: 3
Oct 27 12:22:08 sb65g2 kernel: usbcore: registered new driver hub
Oct 27 12:21:53 sb65g2 microcode_ctl: microcode_ctl startup succeeded
Oct 27 12:22:08 sb65g2 kernel: PCI: Using ACPI for IRQ routing
Oct 27 12:22:00 sb65g2 ieee1394.agent[1854]: ... no drivers for IEEE1394 product 0x/0x/0x
Oct 27 12:22:08 sb65g2 kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Oct 27 12:22:01 sb65g2 kudzu:  succeeded
Oct 27 12:22:08 sb65g2 kernel: pnp: 00:0a: ioport range 0x400-0x4bf could not be reserved
Oct 27 12:22:01 sb65g2 kudzu: Updating /etc/fstab succeeded
Oct 27 12:22:08 sb65g2 kernel: PCI: Bridge: 0000:00:01.0
Oct 27 12:22:01 sb65g2 sysctl: net.ipv4.ip_forward = 0
Oct 27 12:22:08 sb65g2 kernel:   IO window: disabled.
Oct 27 12:22:01 sb65g2 sysctl: net.ipv4.conf.default.rp_filter = 1
Oct 27 12:22:08 sb65g2 kernel:   MEM window: f4000000-f5ffffff
Oct 27 12:22:01 sb65g2 sysctl: kernel.sysrq = 0
Oct 27 12:22:08 sb65g2 kernel:   PREFETCH window: e8000000-efffffff
Oct 27 12:22:01 sb65g2 sysctl: kernel.core_uses_pid = 1
Oct 27 12:22:08 sb65g2 kernel: PCI: Bridge: 0000:02:07.0
Oct 27 12:22:01 sb65g2 network: Setting network parameters:  succeeded
Oct 27 12:22:08 sb65g2 kernel:   IO window: 9000-9fff
Oct 27 12:22:02 sb65g2 network: Bringing up loopback interface:  succeeded
Oct 27 12:22:08 sb65g2 kernel:   MEM window: f6000000-f60fffff
Oct 27 12:22:04 sb65g2 network: Bringing up interface eth0:  succeeded
Oct 27 12:22:08 sb65g2 kernel:   PREFETCH window: disabled.
Oct 27 12:22:08 sb65g2 kernel: PCI: Bridge: 0000:00:1e.0
Oct 27 12:22:08 sb65g2 kernel:   IO window: 9000-afff
Oct 27 12:22:08 sb65g2 kernel:   MEM window: f6000000-f61fffff
Oct 27 12:22:08 sb65g2 kernel:   PREFETCH window: 20000000-200fffff
Oct 27 12:22:08 sb65g2 kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Oct 27 12:22:08 sb65g2 kernel: apm: disabled - APM is not SMP safe.
Oct 27 12:22:08 sb65g2 kernel: audit: initializing netlink socket (disabled)
Oct 27 12:22:08 sb65g2 kernel: audit(1130415700.433:1): initialized
Oct 27 12:22:08 sb65g2 kernel: Total HugeTLB memory allocated, 0
Oct 27 12:22:08 sb65g2 kernel: VFS: Disk quotas dquot_6.5.1
Oct 27 12:22:08 sb65g2 kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Oct 27 12:22:08 sb65g2 kernel: SELinux:  Registering netfilter hooks
Oct 27 12:22:08 sb65g2 kernel: Initializing Cryptographic API
Oct 27 12:22:08 sb65g2 kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Oct 27 12:22:08 sb65g2 kernel: ACPI: Fan [FAN] (on)
Oct 27 12:22:08 sb65g2 kernel: ACPI: CPU0 (power states: C1[C1])
Oct 27 12:22:08 sb65g2 kernel: ACPI: CPU1 (power states: C1[C1])
Oct 27 12:22:08 sb65g2 kernel: ACPI: Thermal Zone [THRM] (51 C)
Oct 27 12:22:09 sb65g2 kernel: isapnp: Scanning for PnP cards...
Oct 27 12:22:09 sb65g2 kernel: isapnp: No Plug & Play device found
Oct 27 12:22:09 sb65g2 kernel: Real Time Clock Driver v1.12
Oct 27 12:22:09 sb65g2 kernel: Linux agpgart interface v0.101 (c) Dave Jones
Oct 27 12:22:09 sb65g2 kernel: agpgart: Detected an Intel 865 Chipset.
Oct 27 12:22:09 sb65g2 kernel: agpgart: AGP aperture is 64M @ 0xf0000000
Oct 27 12:22:09 sb65g2 kernel: [drm] Initialized drm 1.0.0 20040925
Oct 27 12:22:09 sb65g2 kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Oct 27 12:22:09 sb65g2 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct 27 12:22:09 sb65g2 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 27 12:22:09 sb65g2 kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Oct 27 12:22:09 sb65g2 kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Oct 27 12:22:09 sb65g2 kernel: ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
Oct 27 12:22:09 sb65g2 kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Oct 27 12:22:09 sb65g2 kernel: io scheduler noop registered
Oct 27 12:22:09 sb65g2 kernel: io scheduler anticipatory registered
Oct 27 12:22:09 sb65g2 kernel: io scheduler deadline registered
Oct 27 12:22:09 sb65g2 kernel: io scheduler cfq registered
Oct 27 12:22:09 sb65g2 kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Oct 27 12:22:09 sb65g2 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Oct 27 12:22:09 sb65g2 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct 27 12:22:09 sb65g2 kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Oct 27 12:22:09 sb65g2 kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
Oct 27 12:22:09 sb65g2 kernel: ICH5: chipset revision 2
Oct 27 12:22:09 sb65g2 kernel: ICH5: not 100%% native mode: will probe irqs later
Oct 27 12:22:09 sb65g2 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
Oct 27 12:22:09 sb65g2 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Oct 27 12:22:09 sb65g2 kernel: hda: TSSTcorpCD-R/RW TS-H292A, ATAPI CD/DVD-ROM drive
Oct 27 12:22:09 sb65g2 kernel: hdb: ST380011A, ATA DISK drive
Oct 27 12:22:09 sb65g2 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct 27 12:22:09 sb65g2 kernel: hdb: max request size: 1024KiB
Oct 27 12:22:09 sb65g2 kernel: hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
Oct 27 12:22:09 sb65g2 kernel: hdb: cache flushes supported
Oct 27 12:22:09 sb65g2 kernel:  hdb: hdb1 hdb2 hdb3
Oct 27 12:22:09 sb65g2 kernel: hda: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Oct 27 12:22:09 sb65g2 kernel: Uniform CD-ROM driver Revision: 3.20
Oct 27 12:22:09 sb65g2 kernel: ide-floppy driver 0.99.newide
Oct 27 12:22:09 sb65g2 kernel: usbmon: debugfs is not available
Oct 27 12:22:09 sb65g2 kernel: usbcore: registered new driver hiddev
Oct 27 12:22:09 sb65g2 kernel: usbcore: registered new driver usbhid
Oct 27 12:22:09 sb65g2 kernel: drivers/usb/input/hid-core.c: v2.01:USB HID core driver
Oct 27 12:22:09 sb65g2 kernel: mice: PS/2 mouse device common for all mice
Oct 27 12:22:09 sb65g2 kernel: md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
Oct 27 12:22:09 sb65g2 cups: cupsd startup succeeded
Oct 27 12:22:09 sb65g2 kernel: md: bitmap version 3.38
Oct 27 12:22:09 sb65g2 kernel: NET: Registered protocol family 2
Oct 27 12:22:09 sb65g2 kernel: IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
Oct 27 12:22:09 sb65g2 kernel: TCP established hash table entries: 32768 (order: 7, 524288 bytes)
Oct 27 12:22:09 sb65g2 kernel: TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
Oct 27 12:22:09 sb65g2 kernel: TCP: Hash tables configured (established 32768 bind 32768)
Oct 27 12:22:09 sb65g2 kernel: TCP reno registered
Oct 27 12:22:09 sb65g2 kernel: TCP bic registered
Oct 27 12:22:09 sb65g2 kernel: Initializing IPsec netlink socket
Oct 27 12:22:09 sb65g2 kernel: NET: Registered protocol family 1
Oct 27 12:22:09 sb65g2 sshd:  succeeded
Oct 27 12:22:09 sb65g2 kernel: NET: Registered protocol family 17
Oct 27 12:22:09 sb65g2 kernel: Starting balanced_irq
Oct 27 12:22:09 sb65g2 xinetd: xinetd startup succeeded
Oct 27 12:22:09 sb65g2 kernel: Using IPI Shortcut mode
Oct 27 12:22:10 sb65g2 kernel: md: Autodetecting RAID arrays.
Oct 27 12:22:10 sb65g2 vsftpd: vsftpd vsftpd succeeded
Oct 27 12:22:10 sb65g2 kernel: md: autorun ...
Oct 27 12:22:10 sb65g2 kernel: md: ... autorun DONE.
Oct 27 12:22:10 sb65g2 kernel: RAMDISK: Compressed image found at block 0
Oct 27 12:22:10 sb65g2 kernel: VFS: Mounted root (ext2 filesystem).
Oct 27 12:22:10 sb65g2 kernel: SCSI subsystem initialized
Oct 27 12:22:10 sb65g2 kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
Oct 27 12:22:10 sb65g2 kernel: ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
Oct 27 12:22:10 sb65g2 kernel: ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
Oct 27 12:22:10 sb65g2 kernel: ata1: SATA port has no device.
Oct 27 12:22:10 sb65g2 kernel: scsi0 : ata_piix
Oct 27 12:22:10 sb65g2 kernel: ata2: SATA port has no device.
Oct 27 12:22:10 sb65g2 sendmail: sendmail startup succeeded
Oct 27 12:22:10 sb65g2 kernel: scsi1 : ata_piix
Oct 27 12:22:10 sb65g2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Oct 27 12:22:10 sb65g2 sendmail: sm-client startup succeeded
Oct 27 12:22:11 sb65g2 kernel: kmem_cache_create: duplicate cache ext3_xattr
Oct 27 12:22:11 sb65g2 kernel: ------------[ cut here ]------------
Oct 27 12:22:11 sb65g2 kernel: kernel BUG at mm/slab.c:1488!
Oct 27 12:22:11 sb65g2 kernel: invalid operand: 0000 [#1]
Oct 27 12:22:11 sb65g2 kernel: PREEMPT SMP
Oct 27 12:22:11 sb65g2 kernel: Modules linked in: ext3 ata_piix libata sd_mod scsi_mod
Oct 27 12:22:11 sb65g2 kernel: CPU:    0
Oct 27 12:22:11 sb65g2 gpm[2825]: *** info [startup.c(95)]:
Oct 27 12:22:11 sb65g2 kernel: EIP:    0060:[<c014d6d1>]    Not tainted VLI
Oct 27 12:22:11 sb65g2 kernel: EFLAGS: 00010202   (2.6.13.2)
Oct 27 12:22:11 sb65g2 kernel: EIP is at kmem_cache_create+0x4a1/0x600
Oct 27 12:22:11 sb65g2 kernel: eax: 00000031   ebx: dfc4dc18   ecx: c03a72cc   edx: 00000001
Oct 27 12:22:11 sb65g2 kernel: esi: c036849f   edi: e08b210a   ebp: dfcf0a80   esp: c1699f18
Oct 27 12:22:11 sb65g2 kernel: ds: 007b   es: 007b   ss: 0068
Oct 27 12:22:11 sb65g2 kernel: Process insmod (pid: 362, threadinfo=c1698000 task=c15df020)
Oct 27 12:22:11 sb65g2 kernel: Stack: c0366a00 e08b20ff dfcf0ad8 00000051 c0000000 fffffffc 00000004 e08b20ff
Oct 27 12:22:11 sb65g2 kernel:        00000014 00000001 dead4ead 00000000 000000d0 00000040 df86f8c0 00000001
Oct 27 12:22:11 sb65g2 kernel:        00000040 c019208a 00020000 00000000 00000000 00000200 00000030 00000000
Oct 27 12:22:11 sb65g2 kernel: Call Trace:
Oct 27 12:22:11 sb65g2 kernel:  [<c019208a>] mb_cache_create+0x15a/0x1d0
Oct 27 12:22:11 sb65g2 kernel:  [<e081a074>] init_ext3_xattr+0x24/0x3e [ext3]
Oct 27 12:22:11 sb65g2 kernel:  [<e081a006>] init_ext3_fs+0x6/0x50 [ext3]
Oct 27 12:22:11 sb65g2 kernel:  [<c013c802>] sys_init_module+0x182/0x250
Oct 27 12:22:11 sb65g2 kernel:  [<c0163203>] filp_close+0x43/0x70
Oct 27 12:22:11 sb65g2 kernel:  [<c0102fbb>] sysenter_past_esp+0x54/0x75
Oct 27 12:22:11 sb65g2 gpm[2825]: Started gpm successfully. Entered daemon mode.
Oct 27 12:22:11 sb65g2 kernel: Code: 01 00 00 8d b4 26 00 00 00 00 c7 04 24 00 6a 36 c0 8b 4c 24 1c 89 4c 24 04 e8 bc 3b fd ff f0 ff 05 6c 18 4f c0 0f 8e 6a 18 00 00 <0f> 0b d0 05 92 61 36 c0 e9 62 ff ff ff 89 f6 8b 41 50 c7 04 24
Oct 27 12:22:11 sb65g2 kernel:  <6>kjournald starting.  Commit interval 5 seconds
Oct 27 12:22:11 sb65g2 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 27 12:22:11 sb65g2 kernel: Freeing unused kernel memory: 220k freed
Oct 27 12:22:11 sb65g2 kernel: SELinux:  Disabled at runtime.
Oct 27 12:22:11 sb65g2 kernel: SELinux:  Unregistering netfilter hooks
Oct 27 12:22:11 sb65g2 kernel: input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
Oct 27 12:22:11 sb65g2 kernel: ACPI: Power Button (FF) [PWRF]
Oct 27 12:22:11 sb65g2 kernel: ACPI: Power Button (CM) [PWRB]
Oct 27 12:22:11 sb65g2 kernel: ibm_acpi: ec object not found
Oct 27 12:22:11 sb65g2 kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 17
Oct 27 12:22:11 sb65g2 kernel: ehci_hcd 0000:00:1d.7: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
Oct 27 12:22:11 sb65g2 kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Oct 27 12:22:11 sb65g2 kernel: ehci_hcd 0000:00:1d.7: irq 17, io mem 0xf6200000
Oct 27 12:22:11 sb65g2 kernel: ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
Oct 27 12:22:11 sb65g2 kernel: hub 1-0:1.0: USB hub found
Oct 27 12:22:11 sb65g2 gpm[2825]: *** info [mice.c(1766)]:
Oct 27 12:22:11 sb65g2 kernel: hub 1-0:1.0: 8 ports detected
Oct 27 12:22:11 sb65g2 gpm[2825]: imps2: Auto-detected intellimouse PS/2
Oct 27 12:22:11 sb65g2 kernel: USB Universal Host Controller Interface driver v2.3
Oct 27 12:22:11 sb65g2 kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 18
Oct 27 12:22:11 sb65g2 kernel: uhci_hcd 0000:00:1d.0: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1
Oct 27 12:22:11 sb65g2 kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Oct 27 12:22:11 sb65g2 kernel: uhci_hcd 0000:00:1d.0: irq 18, io base 0x0000bc00
Oct 27 12:22:11 sb65g2 kernel: hub 2-0:1.0: USB hub found
Oct 27 12:22:11 sb65g2 kernel: hub 2-0:1.0: 2 ports detected
Oct 27 12:22:11 sb65g2 kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
Oct 27 12:22:11 sb65g2 kernel: uhci_hcd 0000:00:1d.1: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2
Oct 27 12:22:11 sb65g2 kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Oct 27 12:22:11 sb65g2 kernel: uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000b000
Oct 27 12:22:11 sb65g2 kernel: hub 3-0:1.0: USB hub found
Oct 27 12:22:11 sb65g2 kernel: hub 3-0:1.0: 2 ports detected
Oct 27 12:22:11 sb65g2 kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 16
Oct 27 12:22:11 sb65g2 kernel: uhci_hcd 0000:00:1d.2: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI #3
Oct 27 12:22:11 sb65g2 kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Oct 27 12:22:11 sb65g2 kernel: uhci_hcd 0000:00:1d.2: irq 16, io base 0x0000b400
Oct 27 12:22:11 sb65g2 kernel: hub 4-0:1.0: USB hub found
Oct 27 12:22:11 sb65g2 kernel: hub 4-0:1.0: 2 ports detected
Oct 27 12:22:11 sb65g2 kernel: ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 18
Oct 27 12:22:11 sb65g2 kernel: uhci_hcd 0000:00:1d.3: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4
Oct 27 12:22:11 sb65g2 kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Oct 27 12:22:11 sb65g2 gpm: gpm startup succeeded
Oct 27 12:22:11 sb65g2 kernel: uhci_hcd 0000:00:1d.3: irq 18, io base 0x0000b800
Oct 27 12:22:11 sb65g2 kernel: hub 5-0:1.0: USB hub found
Oct 27 12:22:11 sb65g2 kernel: hub 5-0:1.0: 2 ports detected
Oct 27 12:22:11 sb65g2 kernel: usb 5-2: new full speed USB device using uhci_hcd and address 2
Oct 27 12:22:11 sb65g2 kernel: EXT3 FS on hdb2, internal journal
Oct 27 12:22:11 sb65g2 kernel: device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Oct 27 12:22:11 sb65g2 kernel: cdrom: open failed.
Oct 27 12:22:11 sb65g2 crond: crond startup succeeded
Oct 27 12:22:11 sb65g2 kernel: Adding 1044216k swap on /dev/hdb3.  Priority:-1 extents:1
Oct 27 12:22:11 sb65g2 kernel: kjournald starting.  Commit interval 5 seconds
Oct 27 12:22:11 sb65g2 kernel: EXT3 FS on hdb1, internal journal
Oct 27 12:22:11 sb65g2 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 27 12:22:11 sb65g2 kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Oct 27 12:22:11 sb65g2 kernel: microcode: CPU1 updated from revision 0x0 to 0xb, date = 05122004
Oct 27 12:22:12 sb65g2 kernel: microcode: CPU0 updated from revision 0x0 to 0xb, date = 05122004
Oct 27 12:22:12 sb65g2 xfs: xfs startup succeeded
Oct 27 12:22:12 sb65g2 kernel: parport: PnPBIOS parport detected.
Oct 27 12:22:12 sb65g2 xinetd[2770]: xinetd Version 2.3.13 started with libwrap loadavg options compiled in.
Oct 27 12:22:12 sb65g2 kernel: parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Oct 27 12:22:12 sb65g2 anacron: anacron startup succeeded
Oct 27 12:22:12 sb65g2 xinetd[2770]: Started working: 1 available service
Oct 27 12:22:12 sb65g2 kernel: pnp: Device 00:07 disabled.
Oct 27 12:22:12 sb65g2 kernel: Floppy drive(s): fd0 is 1.44M
Oct 27 12:22:12 sb65g2 atd: atd startup succeeded
Oct 27 12:22:12 sb65g2 kernel: FDC 0 is a post-1991 82077
Oct 27 12:22:12 sb65g2 kernel: ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
Oct 27 12:22:12 sb65g2 kernel: ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 20
Oct 27 12:22:12 sb65g2 messagebus: messagebus startup succeeded
Oct 27 12:22:12 sb65g2 kernel: PCI: Via IRQ fixup for 0000:02:08.0, from 5 to 4
Oct 27 12:22:12 sb65g2 kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[20]  MMIO=[f6111000-f61117ff]  Max Packet=[2048]
Oct 27 12:22:12 sb65g2 kernel: 8139too Fast Ethernet driver 0.9.27
Oct 27 12:22:12 sb65g2 kernel: ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 16
Oct 27 12:22:12 sb65g2 kernel: eth0: RealTek RTL8139 at 0xe087c000, 00:30:1b:b3:30:1e, IRQ 16
Oct 27 12:22:12 sb65g2 kernel: via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
Oct 27 12:22:12 sb65g2 rc: Starting lanforge:  succeeded
Oct 27 12:22:12 sb65g2 kernel: ACPI: PCI Interrupt 0000:03:08.0[A] -> GSI 19 (level, low) -> IRQ 19
Oct 27 12:22:12 sb65g2 kernel: eth1: VIA Rhine III (Management Adapter) at 0xf6000000, 00:0c:42:02:2e:6c, IRQ 19.
Oct 27 12:22:12 sb65g2 kernel: eth1: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
Oct 27 12:22:12 sb65g2 kernel: ACPI: PCI Interrupt 0000:03:09.0[A] -> GSI 20 (level, low) -> IRQ 20
Oct 27 12:22:12 sb65g2 kernel: PCI: Via IRQ fixup for 0000:03:09.0, from 5 to 4
Oct 27 12:22:12 sb65g2 kernel: eth2: VIA Rhine III (Management Adapter) at 0xf6001000, 00:0c:42:02:2e:6d, IRQ 20.
Oct 27 12:22:12 sb65g2 kernel: eth2: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
Oct 27 12:22:12 sb65g2 kernel: ACPI: PCI Interrupt 0000:03:0a.0[A] -> GSI 21 (level, low) -> IRQ 21
Oct 27 12:22:12 sb65g2 kernel: PCI: Via IRQ fixup for 0000:03:0a.0, from 10 to 5
Oct 27 12:22:12 sb65g2 kernel: eth3: VIA Rhine III (Management Adapter) at 0xf6002000, 00:0c:42:02:2e:6e, IRQ 21.
Oct 27 12:22:12 sb65g2 kernel: eth3: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
Oct 27 12:22:12 sb65g2 kernel: ACPI: PCI Interrupt 0000:03:0b.0[A] -> GSI 22 (level, low) -> IRQ 22
Oct 27 12:22:12 sb65g2 kernel: PCI: Via IRQ fixup for 0000:03:0b.0, from 9 to 6
Oct 27 12:22:12 sb65g2 kernel: eth4: VIA Rhine III (Management Adapter) at 0xf6003000, 00:0c:42:02:2e:6f, IRQ 22.
Oct 27 12:22:12 sb65g2 kernel: eth4: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
Oct 27 12:22:12 sb65g2 kernel: ACPI: PCI interrupt for device 0000:02:06.0 disabled
Oct 27 12:22:13 sb65g2 kernel: ACPI: PCI interrupt for device 0000:03:0b.0 disabled
Oct 27 12:22:13 sb65g2 kernel: ACPI: PCI interrupt for device 0000:03:0a.0 disabled
Oct 27 12:22:13 sb65g2 kernel: ACPI: PCI interrupt for device 0000:03:09.0 disabled
Oct 27 12:22:13 sb65g2 kernel: ACPI: PCI interrupt for device 0000:03:08.0 disabled
Oct 27 12:22:13 sb65g2 kernel: ip_tables: (C) 2000-2002 Netfilter core team
-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

