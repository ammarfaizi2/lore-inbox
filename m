Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWJEVW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWJEVW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWJEVW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:22:27 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:19265 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751398AbWJEVWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:22:24 -0400
Date: Thu, 5 Oct 2006 23:22:16 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
Message-ID: <20061005212216.GA10912@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

My x366 no longer boots with 2.6.19-rc1. The boot either hangs in
uhci_hcd_init or dies with 'do_IRQ: cannot handle IRQ -1". Bisection
says this one is bad:

[PATCH] genirq: x86_64 irq: make vector_irq per cpu
author	Eric W. Biederman <ebiederm@xmission.com>
committer    Linus Torvalds <torvalds@g5.osdl.org>
commit	     550f2299ac8ffaba943cf211380d3a8d3fa75301
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=550f2299ac8ffaba943cf211380d3a8d3fa75301

and this one is fine:

[PATCH] genirq: x86_64 irq: Make the external irq handlers report their vector, not ...
author	      Eric W. Biederman <ebiederm@xmission.com>
committer     Linus Torvalds <torvalds@g5.osdl.org>
commit	      e500f57436b9056a245216c53113613928155eba
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e500f57436b9056a245216c53113613928155eba

Boot logs, lspci -vvv and .config attached.

Boot log with hang in uhci_hcd_init:

kernel (hd0,1)/boot/calgary/bzImage root=/dev/sda2 console=tty0 console=ttyS1,1 9200
   [Linux-bzImage, setup=0x1c00, size=0x2e3ad8]
initrd (hd0,1)/boot/calgary/aic94xxfw.initramfs.gz
   [Linux-initrd @ 0x37e3f000, 0x1b01e2 bytes]
savedefault
                                                                                
[    0.000000] Linux version 2.6.18mx (muli@rhun) (gcc version 3.4.1) #147 SMP Thu Oct 5 21:36:48 IST 2006
[    0.000000] Command line: root=/dev/sda2 console=tty0 console=ttyS1,19200
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 0000000000099000 (usable)
[    0.000000]  BIOS-e820: 0000000000099000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000e7f9c640 (usable)
[    0.000000]  BIOS-e820: 00000000e7f9c640 - 00000000e7fa6a40 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e7fa6a40 - 00000000e8000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000198000000 (usable)
[    0.000000] end_pfn_map = 1671168
[    0.000000] DMI 2.3 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1671168
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      153
[    0.000000]     0:      256 ->   950172
[    0.000000]     0:  1048576 ->  1671168
[    0.000000] ACPI: PM-Timer IO Port: 0x9c
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
[    0.000000] Processor #C_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x0f] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 15, address 0xfec00000, GSI 0-35
[    0.000000] ACPI: IOAPIC (id[0x0e] address[0xfec01000] gsi_base[35])
[    0.000000] IOAPIC[1]: apic_id)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 0000000000099000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e0000
[    0.000000] Nosave address range: 00000000000e0000 - 0000000000100000
[    0.000000] Nosave address range: 00000000e7f9c000 - 00000000e7f9d000
[    0.000000] Nosave address range: 00000000e7f9d000 - 00000000e7fa6000
[    0.000000] Nosave address range: 00000000e7fa6000 - 00000000e7fa7000
[    0.000000] Nosave address range: 00000000e7fa7000 - 00000000e8000000
[    0.000000] Nosave address range: 00000000e8000000 - 00000000fec00000
[    0.000000] Nosave address range: 00000000fec00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at ea000000 (gap: e8000000:16c00000)
[    0.000000] PERCPU: Allocating 34304 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 1534048
[    0.000000] Kernel command line: root=/dev/sda2 console=tty0 console=ttyS1,19200
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 5705] ... MAX_LOCKDEP_KEYS:        2048
[  168.121904] ... CLASSHASH_SIZE:           1024
[  168.148620] ... MAX_LOCKDEP_ENTRIES:     8192
[  168.174819] ... MAX_LOCKDEP_CHAINS:      8192
[  168.201018] ... CHAINHASH_SIZE:          4096
[  168.227212]  memory used by lock dependency info: 1328 kB
[  168.259653]  per task-struct memory footprint: 1680 bytes
[  168.299288] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[  168.354233] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)[  168.400617] Checking aperture...
[  168.442967] PCI-DMA: Calgary IOMMU detected.
[  168.468663] PCI-DMA: Calgary TCE table spec is 7, CONFIG_IOMMU_DEBUG is enabled.
[  168.631217] Memory: 6096428k/6684672k available (3788k kernel code, 193716k reserved, 2726k data, 276k init)
[  168.769306] Calibrating delay using timer specific routine.. 6346.46 BogoMIPS (lpj=12692924)
[  168.820297] Mount-cache hash table entries: 256
[  168.849151] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  168.880653] CPU: L2 cache: 1024K
[  168.900049] using mwait in idle threads.
[  168.923651] CPU: Physical Processor ID: 0
[  16[  169.171779] Using local APIC timer interrupts.
[  169.230014] result 10425811
[  169.246796] Detected 10.425 MHz APIC timer.
[  169.274318] lockdep: not fixing up alternatives.
[  169.302624] Booting processor 1/4 APIC 0x1
[  169.337672] Initializing CPU#1
[  169.417131] Calibrating delay using timer specific routine.. 6339.06 BogoMIPS (lpj=12678127)
[  169.417148] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  169.417151] CPU: L2 cache: 1024K
[  169.417155] CPU: Physical Processor ID: 0
[  169.417157] CPU: Processor Core ID: 0
[  169.417170] CPU1: Thermal monitoring enabled (TM1)
[  169.417449]                Intel(R) Xeon(TM) MP CPU 3.16GHz stepping 01
[  169.421461] lockdep: not fixing up alternatives.
[  169.683506] Booting processor 2/4 APIC 0x6
[  169.718522] Initializing CPU#2
[  169.797034] Calibrating delay using timer specific routine.. 6339.24 BogoMIPS (lpj=12677306]               Intel(R) Pentium(R) 4 CPU 3.16GHz stepping 09
[  169.801358] lockdep: not fixing up alternatives.
[  170.063376] Booting processor 3/4 APIC 0x7
[  170.098394] Initializing CPU#3
[  170.176937] Calibrating delay using timer specific routine.. 6339.33 BogoMIPS (lpj=12678668)
[  170.176953] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  170.176956] CPU: L2 cache: 1024K
[  170.176959] CPU: Physical Processor ID: 3
[  170.176961] CPU: Processor Core ID: 0
[  170.176971] CPU3: Thermal monitoring enabled (TM1)
[  170.177211]               Intel(R) Pentium(R) 4 CPU 3.16GHz stepping 09
[  170.180968] Brought up 4 CPUs
[  170.433147] testing NMI watchdog ... OK.
[  170.496859] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[  170.533946] time.c: Detected 3169.444 MHz processor.
[  170.732881] migration_cost=1,683
[  170.753371] checking if image is initramfs... it is
[  170.945317] Freeing initrd memory: 1728k freed
[  170.975037] NET: Registered protocol family 16
[  171.012196] ACPI: bus type pci registered
[  171.036300] PCI: Using configuration type 1
[  171.190476] ACPI: Interpreter enabled
[  171.212520] ACPI: Using IOAPIC for interrupt routing
[  171.249022] ACPI: PCI Root Bridge [VP00] (0000:00)
[  171.281222] PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
[  171.337334] ACPI: PCI Root Bridge [VP01] (0000:01)
[  171.373147] ACPI: PCI Root Bridge [VP02] (0000:02)
[  171.411105] ACPI: PCI Root Bridge [VP03] (0000:04)
[  171.448703] ACPI: PCI Root Bridge [VP04] (0000:06)
[  171.486345] ACPI: PCI Root Bridge [VP05] (0000:08)
[  171.524153] ACPI: PCI Root Bridge [VP06] (0000:0a)
[  171.561037] ACPI: PCI Root Bridge [VP07] (0000:0c)
[  171.598952] SCSI subsystem initialized
[  171.621709] usbcore: registered new interface driver usbfs
[  171.654797] usbcore: registered new interface driver hub
[  171.686886] usbcore: registered new device driver usb
[  171.717651] PCI: Using ACPI for IRQ routing
[  171.742820] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[  171.792715] PCI-DMA: Using Calgary IOMMU
[  172.171973] Calgary: enabling translation on PHB 0
[  172.200751] Calgary: errant DMAs will now be prevented on this bus.
[  172.593458] Calgary: enabling translation on PHB 1
[  172.622214] Calgary: errant DMAs will now be prevented on this bus.
[  173.015214] Calgary: enabling translation on PHB 2
[  173.043975] Calgary: errant DMAs will now be prevented on this bus.
[  173.081667] PCI-GART: No AMD northbridge found.
[  173.118125] NET: Registered protocol family 2
[  173.200415 tables configured (established 65536 bind 32768)
[  173.381286] TCP reno registered
[  173.422487] Total HugeTLB memory allocated, 0
[  173.450396] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  173.489481] io scheduler noop registered
[  173.513181] io scheduler anticipatory registered (default)
[  173.546334] io scheduler deadline registered
[  173.572153] io scheduler cfq registered
[  173.602544] GSI 16 sharing vector 0xA9 and IRQ 16
[  173.630881] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[  173.675669] radeonfb: Found Intel x86 BIOS ROM Image
[  173.720028] radeonfb: Retrieved PLL infos from BIOS
[  173.749346] radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=143.00 Mhz, System=143.00 MHz
[  173.798982] radeonfb: PLL min 12000 max 35000
[  173.929494] i2c_adapter i2c-1: unable to read EDID block.
[  174.121356] i2c_adapter i2c-1: unable to read EDID block.
[  174.313307] i2c_adapter i2c-1: unable to read EDID block.
[  174.777182] i2c_adapter i2c-2: unable to read EDID block.
[  174.969129] i2c_adapter i2c-2: unable to read EDID block.
[  175.161078] i2c_adapter i2c-2: unable to read EDID block.
[  175.315579] radeonfb: Monitor 1 type DFP found
[  175.342278] radeonfb: EDID probed
[  175.362230] radeonfb: Monitor 2 type CRT found
[  176.420926] Console: switching to colour frame buffer device 128x48
[  177.132991] radeonfb (0000:00:01.0): ATI Radeon QY
[  177.164714] tridentfb: Trident framebuffer 0.7.8-NEWAPI initializing
[  177.204778] hgafb: HGA card not detected.
[  177.229089] hgafb: probe of hgafb.0 failed with error -22
[  177.265581] vga16fb: mapped to 0xffff8100000a0000
[  177.294281] fb1: VGA16 VGA frame buffer device
[  177.323286] fb2: Virtual frame buffer device, using 1024K of video memory
[  177.364610] ACPI: Power Button (FF) [PWRF]
[  177.390051] ibm_acpi: ec object not found
[  177.799265] Linux agpgart interface v0.101 (c) Dave Jones
[  177.832901] ipmi message handler version 39.0
[  177.859197] ipmi device interface
[  177.879561] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[  177.933667] Hangcheck[  178.096225] RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
[  178.146934] loop: loaded (max 8 devices)
[  178.170967] ibmasm: IBM ASM Service Processor Driver version 1.0 loaded
[  178.211074] GSI 17 sharing vector 0xB1 and IRQ 17
[  178.239566] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 17
[  178.284872] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[  178.284885] 0000:02:01.0: 3Com PCI 3c905C Tornado at ffffc20000042000.
[  178.311834] tg3.c:v3.66 (September 23, 2006)
[  178.311869] GSI 18 sharing vector 0xB9 and IRQ 18
[  178.311879] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 24 (level, low) -> IRQ 18
[  178.452374] eth1: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:22
[  178.452390] eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0]
[  178.452438] eth1: dma_rwctrl[769f0000] dma_mask[64-bit]
[  178.453100] GSI 19 sharing vector 0xC1 and IRQ 19
[  178.453115] ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 28 (level, low) -> IRQ 19
[  178.619694] eth2: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:23
[  178.619705] eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
[  178.619709] eth2: dma_rwctrl[769f0000] dma_mask[64-bit]
[  178.620480] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[  178.620487] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[  178.620586] SvrWks CSB6: IDE controller at PCI slot 0000:00:0f.1
[  178.620612] SvrWks CSB6: chipset revision 160
[  178.620615] SvrWks CSB6: not 100% native mode: will probe irqs later
[  178.620640]     ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
[  178.620661] SvrWks CSB6: simplex device: DMA disabled
[  178.620664] ide1: SvrWks CSB6 Bus-Master DMA disabled (BIOS)
[  179.370943] hda: HL-DT-STDVD-ROM GDR8082N, ATAPI CD/DVD-ROM drive
[  179.715251] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[  180.285934] hda: ATAPI 24X DVD-ROM drive, 256kB Cache
[  180.306029] Uniform CD-ROM driver Revision: 3.20
[  180.434132] usbmon: debugfs is not available
[  180.502630] GSI 20 sharing vector 0xC9 and IRQ 20
[  180.572766] ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
[  180.660206] ohci_hcd 0000:00:03.0: OHCI Host Controller
[  180.735266] ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
[  180.822372] ohci_hcd 0000:00:03.0: irq 20, io mem 0xf2c10000
[  180.988387] usb usb1: Product: OHCI Host Controller
[  181.060155] usb usb1: Manufacturer: Linux 2.6.18mx ohci_hcd
[  181.136015] usb usb1: SerialNumber: 0000:00:03.0
[  181.138365] usb usb1: configuration #1 chosen from 1 choice
[  181.139014] hub 1-0:1.0: USB hub found
[  181.139358] hub 1-0:1.0: 2 ports detected
[  181.259512] ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 20 (level, low) -> IRQ 20
[  181.414004] ohci_hcd 0000:00:03.1: OHCI Host Controller
[  181.415193] ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
[  181.415233] ohci_hcd 0000:00:03.1: irq 20, io mem 0xf2c11000
[  181.5092] usb usb2: Product: OHCI Host Controller
[  181.504194] usb usb2: Manufacturer: Linux 2.6.18mx ohci_hcd
[  181.504196] usb usb2: SerialNumber: 0000:00:03.1
[  181.504232] usb usb2: uevent
[  181.505151] usb usb2: usb_probe_device
[  181.505960] usb usb2: configuration #1 chosen from 1 choice
[  181.505980] usb usb2: adding 2-0:1.0 (config #1, interface 0)
[  181.506026] usb 2-0:1.0: uevent
[  181.506261] hub 2-0:1.0: usb_probe_interface
[  181.506267] hub 2-0:1.0: usb_probe_interface - got id
[  181.506271] hub 2-0:1.0: USB hub found
[  181.506300] hub 2-0:1.0: 2 ports detected
[  181.506304] hub 2-0:1.0: standalone hub
[  181.506307] hub 2-0:1.0: no power switching (usb 1.0)
[  181.506310] hub 2-0:1.0: global over-current protection
[  181.506314] hub 2-0:1.0: power on to power good time: 30ms
[  181.506333] hub 2-0:1.0: local power source is good
[  181.506337] hub 2-0:1.0: no over-current condition exists
[  181.506342] hub 2-0:1.0: trying to enable port power on non-switchable hub
[  181.613892] hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  181.618715] USB Universal Host Controller Interface driver v3.0

Boot log with do_IRQ: cannot handle IRQ -1:

kernel (hd0,1)/boot/calgary/bzImage root=/dev/sda2 console=tty0 console=ttyS1,1
9200
   [Linux-bzImage, setup=0x1c00, size=0x2e3ad8] initrd (hd0,1)/boot/calgary/aic94xxfw.initramfs.gz
   [Linux-initrd @ 0x37e3f000, 0x1b01da bytes]
savedefault
                                                                                
[    0.000000] Linux version 2.6.18mx (muli@rhun) (gcc version 3.4.1) #149 SMP Thu Oct 5 22:52:09 IST 2006
[    0.000000] Command line: root=/dev/sda2 console=tty0 console=ttyS1,19200
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 0000000000099000 (usable) [    0.000000]  BIOS-e820: 0000000000099000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000e7f9c640 (usable)
[    0.000000]  BIOS-e820: 00000000e7f9c640 - 00000000e7fa6a40 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e7fa6a40 - 00000000e8000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000198000000 (usable)
[    0.000000] end_pfn_map = 1671168
[    0.000000] DMI 2.3 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1671168
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      153
[    0.000000]     0:      256 ->   950172
[    0.000000]     0:  1048576 ->  1671168
[    0.000000] ACPI: PM-Timer IO Port: 0x9c
[    0.000000] ACPI: LAPIC (acpirocessor #6
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
[    0.000000] Processor #7
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x0f] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 15, address 0xfec00000, GSI 0-35
[    0.000000] ACPI: IOAPIC (id[0x0e] address[0xfec01000] gsi_base[35])
[    0.000000] IOAPIC[1]: apic_id 14, address 0xfec01000, GSI 35-70
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 8 low edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 low edge)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 0000000000099000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e0000
[    0.000000] Nosave address range: 00000000000e0000 - 0000000000100000
[    0.000000] Nosave address range: 00000000e7f9c000 - 00000000e7f9d000
[    0.000000] Nosave address range: 00000000e7f9d000 - 00000000e7fa6000
[    0.000000] Nosave address range: 00000000e7fa6000 - 00000000e7fa7000
[    0.000000] Nosave address range: 00000000e7fa7000 - 00000000e8000000
[    0.000000] No4 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 1534048
[    0.000000] Kernel command line: root=/dev/sda2 console=tty0 console=ttyS1,19200
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[  162.254679] Console: colour VGA+ 80x25
[  164.190495] Lock dependency validator:752] ... MAX_LOCKDEP_ENTRIES:     8192
[  164.366947] ... MAX_LOCKDEP_CHAINS:      8192
[  164.393142] ... CHAINHASH_SIZE:          4096
[  164.419339]  memory used by lock dependency info: 1328 kB
[  164.451778]  per task-struct memory footprint: 1680 bytes
[  164.491419] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[  164.546385] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)[  164.592804] Checking aperture...
[  164.635185] PCI-DMA: Calgary IOMMU detected.
[  164.660858] PCI-DMA: Calgary TCE table spec is 7, CONFIG_IOMMU_DEBUG is enabled.
[  164.823121] Memory: 6096428k/6684672k available (3788k kernel code, 193716k reserved, 2726k data, 276k init)
[  164.961480] Calibrating delay using timer specific routine.. 6346.50 BogoMIPS (lpj=12693003)
[  165.012500] Mount-cache hash table entries: 256
[  165.041360] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  165.072858] CPU: L2 cache: 1024K
[  165.092254] using mwait in idle threads.
[  165.115856] CPU: Physical Processor ID: 0
[  165.139973] CPU: Processor Core ID: 0
[  165.162031] CPU0: Thermal monitoring enabled (TM1)
[  165.190818] Freeing SMP alternatives: 32k freed
[  165.218068] ACPI: Core revision 20060707
[  165.288939] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[  165.363991] Using local APIC timer interrupts.
[  165.422216] result 10425729
[  165.439044] Detected 10.425 MHz APIC timer.
[  165.466518] lockdep: not fixing up alternatives.
[  165.494795] Booting processor 1/4 APIC 0x1
[  165.529811] Initializing CPU#1
[  165.609305] Calibrating delay using timer specific routine.. 6339.08 BogoMIPS (lpj=12678178)
[  165.609322] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  165.609325] CPU: L2 cache: 1024K
[  165.609329] CPU: Physical Processor ID: 0
[  165.609331] CPU: Processor Core ID: 0
[  165.609344] CPU1: Thermal monitoring enabled (TM1)
[  165.609624]                Intel(R) Xeon(TM) MP CPU 3.16GHz stepping 01
[  165.613632] lockdep: not fixing up alternatives.
[  165.875688] Booting processor 2/4 APIC 0x6
[  165.910707] Initializing CPU#2
[  165.989208] Calibrating delay using timer specific routine.. 6339.23 BogoMIPS (lpj=12678478)
[  165.989221] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  165.989224] CPU: L2 cache: 1024K
[  165.989227] CPU: Physical Processor ID: 3
[  165.989229] CP[  166.290617] Initializing CPU#3
[  166.369111] Calibrating delay using timer specific routine.. 6339.30 BogoMIPS (lpj=12678612)
[  166.369125] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  166.369128] CPU: L2 cache: 1024K
[  166.369132] CPU: Physical Processor ID: 3
[  166.369133] CPU: Processor Core ID: 0
[  166.369144] CPU3: Thermal monitoring enabled (TM1)
[  166.369384]               Intel(R) Pentium(R) 4 CPU 3.16GHz stepping 09
[  166.373137] Brought up 4 CPUs
[  166.625258] testing NMI watchdog ... OK.
[  166.688965] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[  166.726055] time.c: Detected 3169.440 MHz processor.
[  167.084243] migration_cost=73,703
[  167.105254] checking if image is initramfs... it is
[  167.296623] Freeing initrd memory: 1728k freed
[  167.326347] NET: Registered protocol family 16
[  167.363464] ACPI: bus type pci registered
[  167.387553] PCI: Using configuration type 1
[  167.542434] ACPI: Interpreter enabled
[  167.564437] ACPI: Using IOAPIC for interrupt routing
[  167.600989] ACPI: PCI Root Bridge [VP00] (0000:00)
[  167.633174] PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
[  167.688862] ACPI: PCI Root Bridge [VP01] (0000:01)
[  167.723077] ACPI: PCI Root Bridge [VP02] (0000:02)
[  167.762081] ACPI: PCI Root Bridge [VP03] (0000:04)
[  167.799356] ACPI: PCI Root Bridge [VP04] (0000:06)
[  167.838090] ACPI: PCI Root Bridge [VP05] (0000:08)
[  167.877162] ACPI: PCI Root Bridge [VP06] (0000:0a)
[  167.915790] ACPI: PCI Root Bridge [VP07] (0000:0c)
[  167.954746] SCSI subsystem initialized
[  167.977515] usb, try "pci=routeirq".  If it helps, post a report
[  168.148438] PCI-DMA: Using Calgary IOMMU
[  168.527814] Calgary: enabling translation on PHB 0
[  168.556590] Calgary: errant DMAs will now be prevented on this bus.
[  168.949497] Calgary: enabling translation on PHB 1
[  168.978270] Calgary: errant DMAs will now be prevented on this bus.
[  169.371449] Calgary: enabling translation on PHB 2
[  169.400237] Calgary: errant DMAs will now be prevented on this bus.
[  169.437927] PCI-GART: No AMD northbridge found.
[  169.475527] NET: Registered protocol family 2
[  169.556442] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[  169.602331] TCP established hash table entries: 65536 (order: 9, 3670016 bytes)
[  169.654323] TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
[  169.697894] TCP: Hash tables configured (established 65536 bind 32768)
[  169.737140] TCP reno registered
[  169.778387] Total HugeTLB memory allocated, 0
[  169.806340] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  169.845456] io scheduler noop registered
[  169.869143] io scheduler anticip16
[  170.031922] radeonfb: Found Intel x86 BIOS ROM Image
[  170.076069] radeonfb: Retrieved PLL infos from BIOS
[  170.105379] radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=143.00 Mhz, System=143.00 MHz
[  170.155008] radeonfb: PLL min 12000 max 35000
[  170.289514] i2c_adapter i2c-1: unable to read EDID block.
[  170.481376] i2c_adapter i2c-1: unable to read EDID block.
[  170.673320] i2c_adapter i2c-1: unable to read EDID block.
[  171.137184] i2c_adapter i2c-2: unable to read EDID block.
[  171.329128] i2c_adapter i2c-2: unable to read EDID block.
[  171.521072] i2c_adapter i2c-2: unable to read EDID block.
[  171.675567] radeonfb: Monitor 1 type DFP found
[  171.702256] radeonfb: EDID probed
[  171.722209] radeonfb: Monitor 2 type CRT found
[  172.780899] Console: switching to colour frame buffer device 128x48
[  173.493268] radeonfb (0000:00:01.0): ATI Radeon QY
[  173.526192] tridentfb: Trident framebuffer 0.7.8-NEWAPI initializing
[  173.566008] hgafb: HGA card not detected.
[  173.590340] hgafb: probe of hgafb.0 failed with error -22
[  173.625574] vga16fb: mapped to 0xffff8100000a0000
[  173.654233] fb1: VGA16 VGA frame buffer device
[  173.682430] fb2: Virtual frame buffer device, using 1024K of video memory
[  173.723852] ACPI: Power Button (FF) [PWRF]
[  173.749277] ibm_acpi: ec object not found
[  174.153281] Linux agpgart interface v0.101 (c) Dave Jones
[  174.186181] ipmi message handler version 39.0
[  174.212487] ipmi device interface
[  174.212704] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[  174.212708] Hangcheck: Using monotonic_clock().
[  174.212714] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[  174.215329] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[  174.232727] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[  174.248340] RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
[  174.253979] loop: loaded (max 8 devices)
[  174.254880] ibmasm: IBM ASM Service Processor Driver version 1.0 loaded
[  174.255602] GSI 17 sharing vector 0xB1 and IRQ 17
[  174.255614] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 17
[  174.434473] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[  174.434486] 0000:02:01.0: 3Com PCI 3c905C Tornado at ffffc20000042000.
[  174.458336] tg3.c:v3.66 (September 23, 2006)
[  174.458371] GSI 18 sharing vector 0xB9 and IRQ 18
[  174.458382] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 24 (level, low) -> IRQ 18
[  174.651645] eth1: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:22
[  174.651657] eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0]
[  174.651661] eth1: dma_rwctrl[769f0000] dma_mask[64-bit]
[  174.651742] GSI 19 sharing vector 0xC1 and IRQ 19
[  174.651751] ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 28 (level, low) -> IRQ 19
[  174.947630] eth2: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:23
[  174.947641] eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
[  174.947645] eth2: dma_rwctrl[769f0000] dma_mask[64-bit]
[  174.948361] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[  174.948368] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[  174.948462] SvrWks CSB6: IDE controller at PCI slot 0000:00:0f.1
[  174.948490] SvrWks CSB6: chipset revision 160
[  174.948492] SvrWks CSB6: not 100% native mode: will probe irqs later
[  174.948521]     ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
[  174.948547] SvrWks CSB6: simplex device: DMA disabled
[  174.948549] ide1: SvrWks CSB6 Bus-Master DMA disabled (BIOS)
[  175.686861] hda: HL-DT-STDVD-ROM GDR8082N, ATAPI CD/DVD-ROM drive
[  176.027298] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[  176.598782] hda: ATAPI 24X DVD-ROM drive, 256kB Cache
[  176.614367] Uniform CD-ROM driver Revision: 3.20
[  176.742904] usbmon: debugfs is not available
[  176.810874] GSI 20 sharing vector 0xC9 and IRQ 20
[  176.880745] ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
[  176.967527] ohci_hcd 0000:00:03.0: OHCI Host Controller
[  177.042503] ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
[  177.129180] ohci_hcd 0000:00:03.0: irq 20, io mem 0xf2c10000
[  177.292284] usb usb1: Product: OHCI Host Controller
[  177.363518] usb usb1: Manufacturer: Linux 2.6.18mx ohci_hcd
[  177.438777] usb usb1: SerialNumber: 0000:00:03.0
[  177.508765] usb usb1: configuration #1 chosen from 1 choice
[  177.584638] hub 1-0:1.0: USB hub found
[  177.648464] hub 1-0:1.0: 2 ports detected
[  177.819436] ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 20 (level, low) -> IRQ 20
[  177.905381] ohci_hcd 0000:00:03.1: OHCI Host Controller
[  177.977460] ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
[  178.062963] ohci_hcd 0000:00:03.1: irq 20, io mem 0xf2c11000
[  178.223789] usb usb2: Product: OHCI Host Controller
[  178.292928] usb usb2: Manufacturer: Linux 2.6.18mx ohci_hcd
[  178.366239] usb usb2: SerialNumber: 0000:00:03.1
[  178.367676] usb usb2: configuration #1 chosen from 1 choice
[  178.368738] hub 2-0:1.0: USB hub found
[  178.368756] hub 2-0:1.0: 2 ports detected
[  178.7147] USB Universal Host Controller Interface driver v3.0
[  178.639733] serio: i8042 KBD port at 0x60,0x64 irq 1
[  178.639821] serio: i8042 AUX port at 0x60,0x64 irq 12
[  178.685603] mice: PS/2 mouse device common for all mice
[  178.705241] input: PC Speaker as /class/input/input0
[  178.716390] input: AT Translated Set 2 keyboard as /class/input/input1
[  178.725625] i2c /dev entries driver
[  178.738285] i2c-parport: adapter type unspecified
[  178.943983] i2c_adapter i2c-9191: Driver w83781d-isa failed to attach adapter, unregistering
[  178.953019] i2c_adapter i2c-9191: Driver lm78-isa failed to attach adapter, unregistering
[  178.959829] md: linear personality registered for level -1
[  178.959836] md: raid0 personality registered for level 0
[  178.959842] md: raid1 personality registered for level 1
[  178.959847] md: multipath personality registered for level -4
[  179.008855] IBM TrackPoint firmware: 0x0b, buttons: 3/3
[  179.024974] input: TPPS/2 IBM TrackPoint as /class/input/input2
[  179.789256] device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
[  179.874553] device-mapper: multipath: version 1.0.5 loaded
[  179.941863] device-mapper: multipath round-robin: version 1.0.0 loaded
[  180.014917] device-mapper: multipath emc: version 0.0.3 loaded
[  180.083798] EDAC MC: Ver: 2.0.1 Oct  5 2006
[  180.143574] pktgen v2.68: Packet Generator for packet performance testing.
[  180.219216] u32 classifier
[  180.269850]     OLD policer on
[  180.323042] IPv4 over IPv4 tunneling driver
[  180.382659] GRE over IPv4 tunneling driver
[  180.441335] TCP cubic registered
[  180.494834] Initializing XFRM netlink socket
[  180.554246] NET: Registered protocol family 1
[  180.554260] NET: Registered protocol family 17
[  180.554309] NET: Registered protocol family 15
[  180.730291] 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
[  180.802601] All bugs added by David S. Miller <davem@redhat.com>
[  180.905733] SCTP: Hash tables configured (established 37449 bind 37449)
[  180.978800] Freeing unused kernel memory: 276k freed
 running (1:0) /[  181.050177] do_IRQ: cannot handle IRQ -1
[  181.105984] ----------- [cut here ] --------- [please bite here ] ---------
[  181.180286] Kernel BUG at ...uli/w/iommu/calgary/linux/arch/x86_64/kernel/irq.c:118
[  181.258051] invalid opcode: 0000 [1] SMP
[  181.279092] CPU 1
[  181.279094] Modules linked in:
[  181.279098] Pid: 0, comm: swapper Not tainted 2.6.18mx #149
[  181.279101] RIP: 0010:[<ffffffff8020c792>]

lspci:

0000:00:00.0 Host bridge: IBM: Unknown device 02a1 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 240
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=1
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
0000:00:01.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 02c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 240 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 1800 [size=256]
	Region 2: Memory at f2c00000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:03.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 240 (250ns min, 10500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at f2c10000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:03.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 240 (250ns min, 10500ns max), cache line size 10
	Interrupt: pin B routed to IRQ 20
	Region 0: Memory at f2c11000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:03.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
	Subsystem: NEC Corporation USB 2.0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 240 (4000ns min, 8500ns max), cache line size 20
	Interrupt: pin C routed to IRQ 20
	Region 0: Memory at f2c12000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.0 Host bridge: ServerWorks CSB6 South Bridge (rev a0)
	Subsystem: ServerWorks: Unknown device 0201
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 240

0000:00:0f.1 IDE interface: ServerWorks CSB6 RAID/IDE Controller (rev a0) (prog-if 82 [Master PriP])
	Subsystem: ServerWorks: Unknown device 0212
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at 0700 [size=16]

0000:00:0f.3 ISA bridge: ServerWorks GCLE-2 Host Bridge
	Subsystem: ServerWorks: Unknown device 0230
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:01:00.0 Host bridge: IBM: Unknown device 02a1 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 240
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=1
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
0000:01:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 10)
	Subsystem: IBM: Unknown device 02e7
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 240 (16000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at f2dc0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] 	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 8e9e3fb7523479b4  Data: b19f

0000:01:01.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 10)
	Subsystem: IBM: Unknown device 02e7
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 240 (16000ns min), cache line size 10
	Interrupt: pin B routed to IRQ 28
	Region 0: Memory at f2dd0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] 	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: cffdfff793f7fddc  Data: d6f7

0000:01:02.0 SCSI storage controller: Adaptec: Unknown device 041e (rev 08)
	Subsystem: IBM: Unknown device 02e7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 240 (32000ns min, 26750ns max), cache line size 10
	Interrupt: pin A routed to IRQ 25
	Region 0: Memory at f2d80000 (64-bit, non-prefetchable) [size=256K]
	Region 2: Memory at f1400000 (64-bit, prefetchable) [size=128K]
	Region 4: I/O ports at 2000 [size=256]
	Capabilities: [40] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=3 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [58] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [e0] Message Signalled Interrupts: 64bit+ Queue=0/2 Enable-
		Address: 0000000000000000  Data: 0000

0000:02:00.0 Host bridge: IBM: Unknown device 02a1 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 240
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=1
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
0000:02:01.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 6c)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 240 (2500ns min, 2500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 2800 [size=128]
	Region 1: Memory at f2e20000 (32-bit, non-prefetchable) [size=128]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:04:00.0 Host bridge: IBM: Unknown device 02a1 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 240
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=1
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
0000:06:00.0 Host bridge: IBM: Unknown device 02a1 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 240
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=1
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
0000:08:00.0 Host bridge: IBM: Unknown device 02a1 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 240
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=1
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
0000:0a:00.0 Host bridge: IBM: Unknown device 02a1 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 240
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=1
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
0000:0c:00.0 Host bridge: IBM: Unknown device 02a1 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 240
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=1
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-


Cheers,
Muli

--a8Wt8u1KmwUX3Y2C
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
Ycxv6kOl9rXUztDikfDff/wf5a8ZhmB+AAA=

--a8Wt8u1KmwUX3Y2C--
