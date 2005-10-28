Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbVJ1B63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbVJ1B63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 21:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVJ1B63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 21:58:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:45761 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965052AbVJ1B62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 21:58:28 -0400
Date: Thu, 27 Oct 2005 18:59:00 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Michael Madore <michael.madore@gmail.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: high address but no IOMMU
Message-ID: <20051028015900.GB4141@us.ibm.com>
References: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com> <p73slum38rw.fsf@verdi.suse.de> <d4b6d3ea0510271539t782582ddpb13d1a9e13a84f9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b6d3ea0510271539t782582ddpb13d1a9e13a84f9c@mail.gmail.com>
X-Operating-System: Linux 2.6.14-rc5 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.2005 [15:39:20 -0700], Michael Madore wrote:
> On 28 Oct 2005 00:16:51 +0200, Andi Kleen <ak@suse.de> wro> >
> > > Checking aperture...
> > > CPU 0: aperture @ 8000000 size 32 MB
> > > Aperture from northbridge cpu 0 too small (32 MB)
> > > No AGP bridge found
> > > Your BIOS doesn't leave a aperture memory hole
> > > Please enable the IOMMU option in the BIOS setup
> > > This costs you 64 MB of RAM
> > > Mapping aperture over 65536 KB of RAM @ 8000000
> > >
> > > ...
> > >
> > > PCI-DMA: Disabling AGP.
> > > PCI-DMA: aperture base @ 8000000 size 65536 KB
> > > PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
> >
> > Can you post the full boot log?
> >
> 
> Hi Andy,
> 
> Here is the full boot log from 2.6.14-rc5.

Just as another datapoint, here is mine (ignore the inode issues, they
are due to a power failure yesterday):

[    0.000000] Bootdata ok (command line is root=/dev/sda1 ro sbp2.serialize_io=0 )
[    0.000000] Linux version 2.6.14-rc5 (nacc@arkanoid) (gcc version 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)) #1 SMP PREEMPT Mon Oct 24 12:22:41 PDT 2005
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
[    0.000000]  BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7670
[    0.000000] ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff3040
[    0.000000] ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff30c0
[    0.000000] ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000007fff9580
[    0.000000] ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x000000007fff9740
[    0.000000] ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff9880
[    0.000000] ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff9480
[    0.000000] ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
[    0.000000] SRAT: PXM 0 -> APIC 0 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 1 -> Node 1
[    0.000000] SRAT: Node 0 PXM 0 0-9ffff
[    0.000000] SRAT: Node 0 PXM 0 0-3fffffff
[    0.000000] SRAT: Node 1 PXM 1 40000000-7fffffff
[    0.000000] Using 20 for the hash shift. Max adder is 7ffeffff 
[    0.000000] Bootmem setup node 0 0000000000000000-000000003fffffff
[    0.000000] Bootmem setup node 1 0000000040000000-000000007ffeffff
[    0.000000] On node 0 totalpages: 262046
[    0.000000]   DMA zone: 3999 pages, LIFO batch:1
[    0.000000]   Normal zone: 258047 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages, LIFO batch:1
[    0.000000] On node 1 totalpages: 262127
[    0.000000]   DMA zone: 0 pages, LIFO batch:1
[    0.000000]   Normal zone: 262127 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages, LIFO batch:1
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:5 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:5 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: BIOS IRQ0 pin2 override ignored.
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
[    0.000000] Checking aperture...
[    0.000000] CPU 0: aperture @ a5f8000000 size 32 MB
[    0.000000] Aperture from northbridge cpu 0 too small (32 MB)
[    0.000000] No AGP bridge found
[    0.000000] Your BIOS doesn't leave a aperture memory hole
[    0.000000] Please enable the IOMMU option in the BIOS setup
[    0.000000] This costs you 64 MB of RAM
[    0.000000] Mapping aperture over 65536 KB of RAM @ 4000000
[    0.000000] Built 2 zonelists
[    0.000000] Kernel command line: root=/dev/sda1 ro sbp2.serialize_io=0 
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[    0.000000] time.c: Using 3.579545 MHz PM timer.
[    0.000000] time.c: Detected 1809.292 MHz processor.
[   48.403492] Console: colour VGA+ 80x25
[   48.407197] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[   48.412567] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   48.439277] Memory: 1988852k/2097088k available (3748k kernel code, 107848k reserved, 2507k data, 256k init)
[   48.498671] Calibrating delay using timer specific routine.. 3621.13 BogoMIPS (lpj=1810568)
[   48.498794] Mount-cache hash table entries: 256
[   48.498958] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   48.498968] CPU: L2 Cache: 1024K (64 bytes/line)
[   48.498978] CPU 0(1) -> Node 0 -> Core 0
[   48.498993] mtrr: v2.0 (20020519)
[   48.533350] Using local APIC timer interrupts.
[   48.588634] Detected 12.564 MHz APIC timer.
[   48.588709] softlockup thread 0 started up.
[   48.588795] Booting processor 1/2 APIC 0x1
[   48.599123] Initializing CPU#1
[   48.659650] Calibrating delay using timer specific routine.. 3618.10 BogoMIPS (lpj=1809050)
[   48.659661] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   48.659663] CPU: L2 Cache: 1024K (64 bytes/line)
[   48.659667] CPU 1(1) -> Node 1 -> Core 0
[   48.659825] AMD Opteron(tm) Processor 244 stepping 0a
[   48.659837] CPU 1: Syncing TSC to CPU 0.
[   48.660073] CPU 1: synchronized TSC with CPU 0 (last diff 41 cycles, maxerr 811 cycles)
[   48.660079] Brought up 2 CPUs
[   48.660095] softlockup thread 1 started up.
[   48.660186] Disabling vsyscall due to use of PM timer
[   48.660195] time.c: Using PM based timekeeping.
[   48.660203] testing NMI watchdog ... OK.
[   48.670771] NET: Registered protocol family 16
[   48.670811] ACPI: bus type pci registered
[   48.671057] PCI: Using configuration type 1
[   48.675549] PCI: Using MMCONFIG at e0000000
[   48.676451] ACPI: Subsystem revision 20050902
[   48.688238] ACPI: Interpreter enabled
[   48.688247] ACPI: Using IOAPIC for interrupt routing
[   48.688957] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   48.688968] PCI: Probing PCI hardware (bus 00)
[   48.695785] PCI: Transparent bridge - 0000:00:09.0
[   48.696007] Boot video device is 0000:04:00.0
[   48.696096] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   48.761163] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[   48.764024] ACPI: PCI Interrupt Link [LNK1] (IRQs 5 *7 9 10 11 14 15)
[   48.764452] ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 *11 14 15)
[   48.764877] ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 *11 14 15)
[   48.765299] ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[   48.765734] ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[   48.766169] ACPI: PCI Interrupt Link [LUBA] (IRQs *5 7 9 10 11 14 15)
[   48.766594] ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[   48.767045] ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[   48.767480] ACPI: PCI Interrupt Link [LACI] (IRQs *5 7 9 10 11 14 15)
[   48.767906] ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[   48.768338] ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 10 *11 14 15)
[   48.768763] ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 *11 14 15)
[   48.769188] ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[   48.769639] ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 *11 14 15)
[   48.770079] ACPI: PCI Interrupt Link [LFID] (IRQs *5 7 9 10 11 14 15)
[   48.770514] ACPI: PCI Interrupt Link [LPCA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[   48.771009] ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
[   48.771468] ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
[   48.771932] ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
[   48.772395] ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
[   48.772757] ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
[   48.773246] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
[   48.773751] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
[   48.774239] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
[   48.774728] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
[   48.775220] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
[   48.775705] ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
[   48.776185] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
[   48.776671] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
[   48.777164] ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
[   48.777657] ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
[   48.778152] ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
[   48.782381] SCSI subsystem initialized
[   48.782440] usbcore: registered new driver usbfs
[   48.782492] usbcore: registered new driver hub
[   48.782597] PCI: Using ACPI for IRQ routing
[   48.782607] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   48.782712] PCI-DMA: Disabling AGP.
[   48.782722] PCI-DMA: More than 4GB of RAM and no IOMMU
[   48.782723] PCI-DMA: 32bit PCI IO may malfunction.<6>PCI-DMA: Disabling IOMMU.
[   48.783393] PCI: Bridge: 0000:00:09.0
[   48.783403]   IO window: 9000-afff
[   48.783412]   MEM window: fde00000-fdefffff
[   48.783422]   PREFETCH window: fdf00000-fdffffff
[   48.783431] PCI: Bridge: 0000:00:0c.0
[   48.783439]   IO window: 8000-8fff
[   48.783448]   MEM window: fdd00000-fddfffff
[   48.783457]   PREFETCH window: fdc00000-fdcfffff
[   48.783466] PCI: Bridge: 0000:00:0d.0
[   48.783475]   IO window: 7000-7fff
[   48.783484]   MEM window: fdb00000-fdbfffff
[   48.783493]   PREFETCH window: fda00000-fdafffff
[   48.783503] PCI: Bridge: 0000:00:0e.0
[   48.783511]   IO window: 6000-6fff
[   48.783521]   MEM window: fd900000-fd9fffff
[   48.783530]   PREFETCH window: d8000000-dfffffff
[   48.783544] PCI: Setting latency timer of device 0000:00:09.0 to 64
[   48.783551] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   48.783556] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   48.783561] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   48.783913] IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
[   48.785926] Total HugeTLB memory allocated, 0
[   48.786361] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   48.786606] fuse init (API version 7.2)
[   48.786727] Initializing Cryptographic API
[   48.786857] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   48.786861] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
[   48.786884] assign_interrupt_mode Found MSI capability
[   48.786922] Allocate Port Service[pcie00]
[   48.786964] Allocate Port Service[pcie03]
[   48.787005] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   48.787008] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
[   48.787030] assign_interrupt_mode Found MSI capability
[   48.787054] Allocate Port Service[pcie00]
[   48.787085] Allocate Port Service[pcie03]
[   48.787125] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   48.787128] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
[   48.787150] assign_interrupt_mode Found MSI capability
[   48.787173] Allocate Port Service[pcie00]
[   48.787203] Allocate Port Service[pcie03]
[   48.787614] ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
[   48.787632] ACPI: PCI Interrupt 0000:04:00.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 209
[   48.787721] radeonfb: Found Intel x86 BIOS ROM Image
[   48.787731] radeonfb: Retreived PLL infos from BIOS
[   48.787741] radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=325.00 Mhz, System=200.00 MHz
[   48.787754] radeonfb: PLL min 20000 max 40000
[   49.585669] radeonfb: Monitor 1 type CRT found
[   49.585678] radeonfb: EDID probed
[   49.585686] radeonfb: Monitor 2 type no found
[   49.586525] radeonfb (0000:04:00.0): ATI Radeon [` 
[   49.586598] ACPI: Power Button (FF) [PWRF]
[   49.587207] ACPI: Power Button (CM) [PWRB]
[   49.587354] Using specific hotkey driver
[   49.587534] ACPI: CPU0 (power states: C1[C1])
[   49.587558] ACPI: CPU1 (power states: C1[C1])
[   49.607416] Real Time Clock Driver v1.12
[   49.607499] Non-volatile memory driver v1.2
[   49.607518] Linux agpgart interface v0.101 (c) Dave Jones
[   49.607533] [drm] Initialized drm 1.0.0 20040925
[   49.607559] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[   49.607572] Hangcheck: Using monotonic_clock().
[   49.609539] serio: i8042 AUX port at 0x60,0x64 irq 12
[   49.609664] serio: i8042 KBD port at 0x60,0x64 irq 1
[   49.609680] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   49.609798] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   49.610235] parport0: PC-style at 0x378 [PCSPP(,...)]
[   49.610333] io scheduler noop registered
[   49.610376] io scheduler anticipatory registered
[   49.610398] io scheduler deadline registered
[   49.610446] io scheduler cfq registered
[   49.610501] Floppy drive(s): fd0 is 1.44M
[   49.626516] FDC 0 is a post-1991 82077
[   49.628614] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[   49.628983] loop: loaded (max 8 devices)
[   49.629042] pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
[   49.629102] tg3.c:v3.42 (Oct 3, 2005)
[   49.629529] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
[   49.629544] ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 217
[   49.629573] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   49.635190] eth0: Tigon3 [partno(BCM95751) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:13:d4:04:42:47
[   49.635232] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[   49.635245] eth0: dma_rwctrl[76180000]
[   49.635312] netconsole: not configured, aborting
[   49.635322] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   49.635332] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   49.635384] NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
[   49.635411] NFORCE-CK804: chipset revision 242
[   49.635420] NFORCE-CK804: not 100% native mode: will probe irqs later
[   49.635430] NFORCE-CK804: BIOS didn't set cable bits correctly. Enabling workaround.
[   49.635445] NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
[   49.635459]     ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:DMA
[   49.635484]     ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:DMA, hdd:DMA
[   49.635507] Probing IDE interface ide0...
[   50.306755] hda: SONY DVD RW DW-Q28A, ATAPI CD/DVD-ROM drive
[   50.919197] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   50.919293] Probing IDE interface ide1...
[   51.437822] Probing IDE interface ide1...
[   51.957966] hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
[   51.958020] Uniform CD-ROM driver Revision: 3.20
[   51.960269] libata version 1.12 loaded.
[   51.960331] sata_sil version 0.9
[   51.960733] ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
[   51.960750] ACPI: PCI Interrupt 0000:01:09.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 225
[   51.961226] ata1: SATA max UDMA/100 cmd 0xFFFFC20000004080 ctl 0xFFFFC2000000408A bmdma 0xFFFFC20000004000 irq 225
[   51.961279] ata2: SATA max UDMA/100 cmd 0xFFFFC200000040C0 ctl 0xFFFFC200000040CA bmdma 0xFFFFC20000004008 irq 225
[   51.961337] ata3: SATA max UDMA/100 cmd 0xFFFFC20000004280 ctl 0xFFFFC2000000428A bmdma 0xFFFFC20000004200 irq 225
[   51.961377] ata4: SATA max UDMA/100 cmd 0xFFFFC200000042C0 ctl 0xFFFFC200000042CA bmdma 0xFFFFC20000004208 irq 225
[   52.162722] ata1: no device found (phy stat 00000000)
[   52.162731] scsi0 : sata_sil
[   52.363725] ata2: no device found (phy stat 00000000)
[   52.363734] scsi1 : sata_sil
[   52.564729] ata3: no device found (phy stat 00000000)
[   52.564738] scsi2 : sata_sil
[   52.765734] ata4: no device found (phy stat 00000000)
[   52.765742] scsi3 : sata_sil
[   52.768501] sata_nv version 0.8
[   52.769170] ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
[   52.769186] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 233
[   52.769508] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   52.769630] ata5: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD400 irq 233
[   52.769681] ata6: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD408 irq 233
[   52.970738] ata5: no device found (phy stat 00000000)
[   52.970747] scsi4 : sata_nv
[   53.171741] ata6: no device found (phy stat 00000000)
[   53.171750] scsi5 : sata_nv
[   53.173771] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
[   53.173787] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 (level, low) -> IRQ 50
[   53.174071] PCI: Setting latency timer of device 0000:00:08.0 to 64
[   53.174203] ata7: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC000 irq 50
[   53.174249] ata8: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC008 irq 50
[   53.529840] ata7: dev 0 cfg 49:2f00 82:706b 83:7e01 84:4023 85:7069 86:3c01 87:4023 88:407f
[   53.529844] ata7: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
[   53.529958] ata7: dev 0 configured for UDMA/133
[   53.529962] nv_sata: Primary device added
[   53.529971] nv_sata: Primary device removed
[   53.529973] nv_sata: Secondary device added
[   53.529975] nv_sata: Secondary device removed
[   53.529998] scsi6 : sata_nv
[   53.884844] ata8: dev 0 cfg 49:2f00 82:706b 83:7e01 84:4023 85:7069 86:3c01 87:4023 88:407f
[   53.884848] ata8: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
[   53.884946] nv_sata: Primary device added
[   53.884949] ata8: dev 0 configured for UDMA/133
[   53.884954] scsi7 : sata_nv
[   53.884986] nv_sata: Primary device removed
[   53.884997] nv_sata: Secondary device added
[   53.885008] nv_sata: Secondary device removed
[   53.885143]   Vendor: ATA       Model: WDC WD2500KS-00M  Rev: 02.0
[   53.885254]   Type:   Direct-Access                      ANSI SCSI revision: 05
[   53.886052]   Vendor: ATA       Model: WDC WD2500KS-00M  Rev: 02.0
[   53.886163]   Type:   Direct-Access                      ANSI SCSI revision: 05
[   53.886991] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[   53.887015] SCSI device sda: drive cache: write back
[   53.887098] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[   53.887119] SCSI device sda: drive cache: write back
[   53.887131]  sda: sda1 sda2
[   53.893978] Attached scsi disk sda at scsi6, channel 0, id 0, lun 0
[   53.894083] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[   53.894119] SCSI device sdb: drive cache: write back
[   53.894214] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[   53.894240] SCSI device sdb: drive cache: write back
[   53.894255]  sdb:
[   53.904265] Attached scsi disk sdb at scsi7, channel 0, id 0, lun 0
[   53.904408] ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
[   53.904434] ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 217
[   53.954733] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[217]  MMIO=[fdeff000-fdeff7ff]  Max Packet=[2048]
[   53.954848] ieee1394: raw1394: /dev/raw1394 device initialized
[   53.954894] sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
[   53.955491] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
[   53.955505] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 21 (level, low) -> IRQ 58
[   53.955941] PCI: Setting latency timer of device 0000:00:02.1 to 64
[   53.955949] ehci_hcd 0000:00:02.1: EHCI Host Controller
[   53.955967] ehci_hcd 0000:00:02.1: debug port 1
[   53.956188] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
[   53.956212] ehci_hcd 0000:00:02.1: irq 58, io mem 0xfeb00000
[   53.956250] PCI: cache line size of 64 is not supported by device 0000:00:02.1
[   53.956254] ehci_hcd 0000:00:02.1: park 0
[   53.956265] ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[   55.164290] hub 1-0:1.0: USB hub found
[   55.164305] hub 1-0:1.0: 10 ports detected
[   55.265891] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[   55.266469] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
[   55.266486] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 20 (level, low) -> IRQ 66
[   55.266763] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   55.266770] ohci_hcd 0000:00:02.0: OHCI Host Controller
[   55.279997] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
[   55.280021] ohci_hcd 0000:00:02.0: irq 66, io mem 0xfe02f000
[   55.333951] hub 2-0:1.0: USB hub found
[   55.333969] hub 2-0:1.0: 10 ports detected
[   55.420093] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d8000030641c]
[   55.435873] USB Universal Host Controller Interface driver v2.3
[   55.651987] usb 2-1: new low speed USB device using ohci_hcd and address 2
[   55.802049] usbcore: registered new driver usblp
[   55.802060] /home/nacc/linux/views/2.6.14-rc5/drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
[   55.802072] Initializing USB Mass Storage driver...
[   55.802126] usbcore: registered new driver usb-storage
[   55.802134] USB Mass Storage support registered.
[   55.811884] input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:02.0-1
[   55.828896] input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:02.0-1
[   55.828927] usbcore: registered new driver usbhid
[   55.828941] /home/nacc/linux/views/2.6.14-rc5/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   55.829078] mice: PS/2 mouse device common for all mice
[   55.829528] input: PC Speaker
[   55.829539] i2c /dev entries driver
[   55.829936] i2c_adapter i2c-4: nForce2 SMBus adapter at 0x1c00
[   55.830047] i2c_adapter i2c-5: nForce2 SMBus adapter at 0x1c40
[   57.728863] Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12 08:13:09 2005 UTC).
[   57.729804] ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 23
[   57.729816] ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 23 (level, low) -> IRQ 233
[   57.730200] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   58.041846] intel8x0_measure_ac97_clock: measured 50788 usecs
[   58.041862] intel8x0: clocking to 46881
[   58.042968] ACPI: PCI Interrupt 0000:01:06.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 209
[   58.056490] ALSA device list:
[   58.056504]   #0: NVidia CK804 with ALC850 at 0xfe02d000, irq 233
[   58.057093]   #1: SBLive 5.1 [SB0060] (rev.7, serial:0x80611102) at 0xac00, irq 209
[   58.057140] oprofile: using NMI interrupt.
[   58.057279] NET: Registered protocol family 2
[   58.067916] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   58.068874] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[   58.072347] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   58.073313] TCP: Hash tables configured (established 262144 bind 65536)
[   58.073323] TCP reno registered
[   58.073382] TCP bic registered
[   58.073390] Initializing IPsec netlink socket
[   58.073431] NET: Registered protocol family 1
[   58.073444] NET: Registered protocol family 17
[   58.073456] NET: Registered protocol family 15
[   58.073613] powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.3)
[   58.073704] powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2 (1500 mV)
[   58.073716] powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
[   58.073730] cpu_init done, current fid 0xa, vid 0x2
[   58.073867] powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2 (1500 mV)
[   58.073882] powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
[   58.073901] cpu_init done, current fid 0xa, vid 0x2
[   58.074085] BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
[   58.074921] EXT3-fs: INFO: recovery required on readonly filesystem.
[   58.074936] EXT3-fs: write access will be enabled during recovery.
[   60.266079] kjournald starting.  Commit interval 5 seconds
[   60.266099] EXT3-fs: sda1: orphan cleanup on readonly fs
[   60.266129] ext3_orphan_cleanup: deleting unreferenced inode 788564
[   60.284162] ext3_orphan_cleanup: deleting unreferenced inode 1142513
[   60.293045] ext3_orphan_cleanup: deleting unreferenced inode 1142509
[   60.293058] ext3_orphan_cleanup: deleting unreferenced inode 1142511
[   60.303372] ext3_orphan_cleanup: deleting unreferenced inode 1142510
[   60.303550] ext3_orphan_cleanup: deleting unreferenced inode 1142508
[   60.303713] ext3_orphan_cleanup: deleting unreferenced inode 1142507
[   60.303904] ext3_orphan_cleanup: deleting unreferenced inode 1142506
[   60.304075] ext3_orphan_cleanup: deleting unreferenced inode 1142505
[   60.304242] ext3_orphan_cleanup: deleting unreferenced inode 1142504
[   60.304405] ext3_orphan_cleanup: deleting unreferenced inode 1142503
[   60.304425] ext3_orphan_cleanup: deleting unreferenced inode 1142502
[   60.307807] ext3_orphan_cleanup: deleting unreferenced inode 1142481
[   60.307820] ext3_orphan_cleanup: deleting unreferenced inode 1142480
[   60.307831] ext3_orphan_cleanup: deleting unreferenced inode 1142479
[   60.307985] ext3_orphan_cleanup: deleting unreferenced inode 1142457
[   60.307999] ext3_orphan_cleanup: deleting unreferenced inode 1142456
[   60.308011] ext3_orphan_cleanup: deleting unreferenced inode 1142455
[   60.308023] ext3_orphan_cleanup: deleting unreferenced inode 1142454
[   60.308034] ext3_orphan_cleanup: deleting unreferenced inode 1142452
[   60.308046] ext3_orphan_cleanup: deleting unreferenced inode 1142451
[   60.308207] ext3_orphan_cleanup: deleting unreferenced inode 1142450
[   60.313737] ext3_orphan_cleanup: deleting unreferenced inode 1142449
[   60.313744] EXT3-fs: sda1: 23 orphan inodes deleted
[   60.313757] EXT3-fs: recovery complete.
[   60.328823] EXT3-fs: mounted filesystem with ordered data mode.
[   60.328880] VFS: Mounted root (ext3 filesystem) readonly.
[   60.329119] Freeing unused kernel memory: 256k freed
[   63.757896] EXT3 FS on sda1, internal journal
[   66.526960] cdrom: open failed.
[   67.966531] kjournald starting.  Commit interval 5 seconds
[   67.966830] EXT3 FS on sda2, internal journal
[   67.966860] EXT3-fs: mounted filesystem with ordered data mode.
[   74.637810] tg3: eth0: Link is up at 100 Mbps, full duplex.
[   74.637835] tg3: eth0: Flow control is off for TX and off for RX.
[  327.112535] can't create port
