Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967538AbWK2SxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967538AbWK2SxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 13:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967539AbWK2SxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 13:53:11 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:63438 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S967537AbWK2SxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 13:53:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=ORmYFpOEWxB5l+54l+8HTU8pzZPpzLV+bqyFbJK7406nv7kACHDBNkWwvGOr5F+jQ/Uu4GtJgIO+dWn4ZX53m6grimOntOhYxsefjrQbw1ykMXhtsrcutbx2u08MVsZsnK9QI3hF95OtKm1YgoQBcCOr+6B1Jj99OrYcB3o/2jI=
Message-ID: <456DD70D.1050808@gmail.com>
Date: Wed, 29 Nov 2006 11:53:01 -0700
From: "Berck E. Nash" <flyboy@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061124)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: 2.6.18 - AHCI detection pauses excessively
References: <4557B7D2.2050004@gmail.com> <455B0BD7.20108@gmail.com> <455B5ADF.2040503@gmail.com> <20061127033550.GB11250@htj.dyndns.org> <456AA89C.909@gmail.com> <456D4B17.4080503@gmail.com>
In-Reply-To: <456D4B17.4080503@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------020601080507020601000301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020601080507020601000301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:

> Hmm... this is difficult.  The problem is that everything looks normal 
> until command is issued.  My primary suspect still is ahci powering down 
> phy during initialization.  Can you please test the attached patch again?

No significant difference that I can tell. I've attached the whole log 
from boot to power-down.  That's with both this patch and the previous 
patch.  If you want just one, I can do that as well...

> Then, a series of obsolete STANDBY failures.  Who's issuing these 
> commands?  It's not libata, libata uses STANDBY (0xe2).  Is it some kind 
> of gentoo thing?

Nope, Debian/Unstable.

Berck

--------------020601080507020601000301
Content-Type: text/plain;
 name="consolelog"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="consolelog"

[    0.000000] Linux version 2.6.19-rc6-mm1 (root@luna) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-20)) #4 SMP PREEMPT Wed Nov 29 09:40:25 MST 2006
[    0.000000] Command line: root=/dev/sdc1 ro console=tty0 console=ttyS0,115200n8 BOOT_IMAGE=vmlinuz
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ff80000 (usable)
[    0.000000]  BIOS-e820: 000000003ff80000 - 000000003ff8e000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003ff8e000 - 000000003ffe0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003ffe0000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.4 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   262016
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e4000
[    0.000000] Nosave address range: 00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:bfb00000)
[    0.000000] PERCPU: Allocating 32512 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 257375
[    0.000000] Kernel command line: root=/dev/sdc1 ro console=tty0 console=ttyS0,115200n8 BOOT_IMAGE=vmlinuz
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   57.051783] Console: colour VGA+ 80x25
[   57.314953] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   57.322333] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   57.329293] Checking aperture...
[   57.340073] Memory: 1027700k/1048064k available (2281k kernel code, 19860k reserved, 999k data, 196k init)
[   57.409313] Calibrating delay using timer specific routine.. 5800.15 BogoMIPS (lpj=2900076)
[   57.417779] Mount-cache hash table entries: 256
[   57.422423] CPU: L1 I cache: 32K, L1 D cache: 32K
[   57.427211] CPU: L2 cache: 2048K
[   57.430763] using mwait in idle threads.
[   57.434721] CPU: Physical Processor ID: 0
[   57.438764] CPU: Processor Core ID: 0
[   57.442465] CPU0: Thermal monitoring enabled (TM2)
[   57.447302] Freeing SMP alternatives: 24k freed
[   57.451874] ACPI: Core revision 20060707
[   57.480782] Using local APIC timer interrupts.
[   57.519735] result 25877174
[   57.522568] Detected 25.877 MHz APIC timer.
[   57.527253] Booting processor 1/2 APIC 0x1
[   57.541734] Initializing CPU#1
[   57.602132] Calibrating delay using timer specific routine.. 5796.48 BogoMIPS (lpj=2898240)
[   57.602137] CPU: L1 I cache: 32K, L1 D cache: 32K
[   57.602138] CPU: L2 cache: 2048K
[   57.602139] CPU: Physical Processor ID: 0
[   57.602140] CPU: Processor Core ID: 1
[   57.602144] CPU1: Thermal monitoring enabled (TM2)
[   57.602335] Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz stepping 06
[   57.603137] Brought up 2 CPUs
[   57.645024] testing NMI watchdog ... OK.
[   57.659029] time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
[   57.665585] time.c: Detected 2898.246 MHz processor.
[   57.783220] migration_cost=29
[   57.786529] NET: Registered protocol family 16
[   57.791012] wait_for_probes: waiting for 0 threads
[   57.795876] wait_for_probes: waiting for 0 threads
[   57.800706] ACPI: bus type pci registered
[   57.804751] PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
[   57.811226] PCI: Not using MMCONFIG.
[   57.814834] PCI: Using configuration type 1
[   57.819050] wait_for_probes: waiting for 0 threads
[   57.831652] ACPI: Interpreter enabled
[   57.835347] ACPI: Using IOAPIC for interrupt routing
[   57.841073] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   57.846380] PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
[   57.852852] PCI quirk: region 0480-04bf claimed by ICH6 GPIO
[   57.859013] PCI: Transparent bridge - 0000:00:1e.0
[   57.870873] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   57.878847] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[   57.886660] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
[   57.894433] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   57.902208] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   57.909984] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   57.917758] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   57.925533] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   57.933201] Linux Plug and Play Support v0.97 (c) Adam Belay
[   57.938896] pnp: PnP ACPI init
[   57.944754] pnp: PnP ACPI: found 15 devices
[   57.949002] intel_rng: FWH not detected
[   57.952961] SCSI subsystem initialized
[   57.956786] PCI: Using ACPI for IRQ routing
[   57.961004] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   57.969356] wait_for_probes: waiting for 0 threads
[   57.974185] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   57.979267] hpet0: 3 64-bit timers, 14318180 Hz
[   57.984835] PCI-GART: No AMD northbridge found.
[   57.989915] pnp: 00:07: ioport range 0x290-0x297 has been reserved
[   57.996305] PCI: Bridge: 0000:00:01.0
[   58.000003]   IO window: disabled.
[   58.003442]   MEM window: faa00000-feafffff
[   58.007658]   PREFETCH window: cff00000-efefffff
[   58.012307] PCI: Bridge: 0000:00:1c.0
[   58.016005]   IO window: disabled.
[   58.019441]   MEM window: disabled.
[   58.022966]   PREFETCH window: cfe00000-cfefffff
[   58.027618] PCI: Bridge: 0000:00:1c.3
[   58.031313]   IO window: c000-cfff
[   58.034752]   MEM window: fa900000-fa9fffff
[   58.038969]   PREFETCH window: disabled.
[   58.042926] PCI: Bridge: 0000:00:1e.0
[   58.046625]   IO window: b000-bfff
[   58.050061]   MEM window: fa700000-fa8fffff
[   58.054278]   PREFETCH window: 50000000-500fffff
[   58.058935] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   58.066426] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
[   58.073918] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   58.081418] NET: Registered protocol family 2
[   58.097867] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
[   58.105121] TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
[   58.113201] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   58.120434] TCP: Hash tables configured (established 131072 bind 65536)
[   58.127074] TCP reno registered
[   58.133898] wait_for_probes: waiting for 0 threads
[   58.139183] audit: initializing netlink socket (disabled)
[   58.144620] audit(1164794340.588:1): initialized
[   58.154651] Loading Reiser4. See www.namesys.com for a description of Reiser4.
[   58.161964] io scheduler noop registered
[   58.165971] io scheduler anticipatory registered (default)
[   58.171764] assign_interrupt_mode Found MSI capability
[   58.177008] assign_interrupt_mode Found MSI capability
[   58.182267] assign_interrupt_mode Found MSI capability
[   58.187624] input: Power Button (FF) as /class/input/input0
[   58.193229] ACPI: Power Button (FF) [PWRF]
[   58.197399] input: Power Button (CM) as /class/input/input1
[   58.203002] ACPI: Power Button (CM) [PWRB]
[   58.207441] ACPI: Processor [CPU1] (supports 8 throttling states)
[   58.213880] ACPI: Processor [CPU2] (supports 8 throttling states)
[   58.220091] ACPI: Getting cpuindex for acpiid 0x3
[   58.224832] ACPI: Getting cpuindex for acpiid 0x4
[   58.230921] Real Time Clock Driver v1.12ac
[   58.235124] Linux agpgart interface v0.101 (c) Dave Jones
[   58.240558] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   58.248508] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   58.254844] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   58.260556] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   58.266942] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   58.274999] ICH7: IDE controller at PCI slot 0000:00:1f.1
[   58.280435] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
[   58.287921] ICH7: chipset revision 1
[   58.291530] ICH7: not 100% native mode: will probe irqs later
[   58.297312]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
[   58.304673]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
[   58.983800] hda: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
[   59.703341] hdb: _NEC DVD_RW ND-3520AW, ATAPI CD/DVD-ROM drive
[   59.763054] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   60.286513] SiI680: IDE controller at PCI slot 0000:01:00.0
[   60.292127] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 21 (level, low) -> IRQ 21
[   60.299607] SiI680: chipset revision 2
[   60.303401] SiI680: BASE CLOCK == 133
[   60.307144] SiI680: 100% native mode on irq 21
[   60.311618]     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
[   60.317754]     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
[   60.589630] hde: SAMSUNG WN316025A (1.6 GB), ATA DISK drive
[   61.206447] ide2 at 0xffffc20000006c80-0xffffc20000006c87,0xffffc20000006c8a on irq 21
[   61.478377] hdg: MAXTOR 6L040J2, ATA DISK drive
[   62.094234] ide3 at 0xffffc20000006cc0-0xffffc20000006cc7,0xffffc20000006cca on irq 21
[   62.102331] hde: max request size: 64KiB
[   62.106288] hde: 3145968 sectors (1610 MB) w/109KiB Cache, CHS=3121/16/63, DMA
[   62.113752]  hde: hde1
[   62.130460] hdg: max request size: 64KiB
[   62.135458] hdg: 78198750 sectors (40037 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(133)
[   62.143920] hdg: cache flushes supported
[   62.147886]  hdg: hdg1
[   62.166751] hda: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   62.173727] Uniform CD-ROM driver Revision: 3.20
[   62.218007] hdb: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
[   62.239427] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 22 (level, low) -> IRQ 22
[   62.248581] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 23
[   62.256246] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[   62.262462] PNP: PS/2 controller doesn't have AUX irq; using default 12
[   62.271704] serio: i8042 KBD port at 0x60,0x64 irq 1
[   62.276717] serio: i8042 AUX port at 0x60,0x64 irq 12
[   62.281869] mice: PS/2 mouse device common for all mice
[   62.287138] EDAC MC: Ver: 2.0.1 Nov 25 2006
[   62.291460] TCP cubic registered
[   62.294723] Initializing XFRM netlink socket
[   62.299034] NET: Registered protocol family 1
[   62.303431] NET: Registered protocol family 17
[   62.307920] NET: Registered protocol family 15
[   62.312402] wait_for_probes: waiting for 3 threads
[   62.320615] input: AT Translated Set 2 keyboard as /class/input/input2
[   62.456583] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   62.456584]         <Adaptec 2940 Ultra2 SCSI adapter>
[   62.456585]         aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   62.456586] 
[   62.737004] scsi 0:0:1:0: Direct-Access     IBM-PCCO ST39102LC     !# B219 PQ: 0 ANSI: 2
[   62.745138] scsi0:A:1:0: Tagged Queuing enabled.  Depth 8
[   62.750622]  target0:0:1: Beginning Domain Validation
[   62.762123]  target0:0:1: wide asynchronous
[   62.771039]  target0:0:1: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)
[   62.782253]  target0:0:1: Domain Validation skipping write tests
[   62.788289]  target0:0:1: Ending Domain Validation
[   62.796097] scsi 0:0:2:0: Direct-Access     SGI      SEAGATE ST39102L 2702 PQ: 0 ANSI: 2
[   62.804226] scsi0:A:2:0: Tagged Queuing enabled.  Depth 8
[   62.809710]  target0:0:2: Beginning Domain Validation
[   62.820068]  target0:0:2: wide asynchronous
[   62.828148]  target0:0:2: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)
[   62.838546]  target0:0:2: Domain Validation skipping write tests
[   62.844580]  target0:0:2: Ending Domain Validation
[   63.256906] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[   63.265032] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
[   63.271894] ata1: SATA max UDMA/133 cmd 0xFFFFC2000000E900 ctl 0x0 bmdma 0x0 irq 316
[   63.279711] ata2: SATA max UDMA/133 cmd 0xFFFFC2000000E980 ctl 0x0 bmdma 0x0 irq 316
[   63.287529] ata3: SATA max UDMA/133 cmd 0xFFFFC2000000EA00 ctl 0x0 bmdma 0x0 irq 316
[   63.295348] ata4: SATA max UDMA/133 cmd 0xFFFFC2000000EA80 ctl 0x0 bmdma 0x0 irq 316
[   63.303134] scsi1 : ahci
[   63.607369] SATA PHY: stable DET=3
[   63.711788] SATA PHY: stable DET=3
[   63.816363] SATA PHY: stable DET=3
[   63.920860] SATA PHY: stable DET=3
[   64.024318] SATA PHY: stable DET=3
[   64.128893] SATA PHY: stable DET=3
[   64.233299] SATA PHY: stable DET=3
[   64.337874] SATA PHY: stable DET=3
[   64.442358] SATA PHY: stable DET=3
[   64.545829] SATA PHY: stable DET=3
[   64.650405] SATA PHY: stable DET=3
[   64.754810] SATA PHY: stable DET=3
[   64.859385] SATA PHY: stable DET=3
[   64.963830] SATA PHY: stable DET=3
[   65.067327] SATA PHY: stable DET=3
[   65.171915] SATA PHY: stable DET=3
[   65.276320] SATA PHY: stable DET=3
[   65.380895] SATA PHY: stable DET=3
[   65.485327] SATA PHY: stable DET=3
[   65.588851] SATA PHY: stable DET=3
[   65.592287] SATA PHY: debounced
[   65.750171] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   65.763279] ata1.00: ATA-6, max UDMA/133, 72303840 sectors: LBA48 
[   65.769497] ata1.00: ata1: dev 0 multi count 16
[   65.781925] ata1.00: configured for UDMA/133
[   65.786233] scsi2 : ahci
[   65.926221] SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
[   65.934661] sda: Write Protect is off
[   65.939927] SCSI device sda: write cache: enabled, read cache: enabled, supports DPO and FUA
[   65.949193] SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
[   65.957643] sda: Write Protect is off
[   65.962922] SCSI device sda: write cache: enabled, read cache: enabled, supports DPO and FUA
[   65.971395]  sda: sda1 sda2
[   65.981209] sd 0:0:1:0: Attached scsi disk sda
[   65.985718] sd 0:0:1:0: Attached scsi generic sg0 type 0
[   65.991862] SCSI device sdb: 17781520 512-byte hdwr sectors (9104 MB)
[   66.001710] sdb: Write Protect is off
[   66.009177] SCSI device sdb: write cache: enabled, read cache: enabled, supports DPO and FUA
[   66.018402] SCSI device sdb: 17781520 512-byte hdwr sectors (9104 MB)
[   66.028252] sdb: Write Protect is off
[   66.035720] SCSI device sdb: write cache: enabled, read cache: enabled, supports DPO and FUA
[   66.044200]  sdb: sdb1
[   66.057330] sd 0:0:2:0: Attached scsi disk sdb
[   66.061838] sd 0:0:2:0: Attached scsi generic sg1 type 0
[   66.091409] SATA PHY: stable DET=3
[   61.95984] SATA PHY: stable DET=3
[   66.300389] SATA PHY: stable DET=3
[   66.404964] SATA PHY: stable DET=3
[   66.509409] SATA PHY: stable DET=3
[   66.612919] SATA PHY: stable DET=3
[   66.717494] SATA PHY: stable DET=3
[   66.821899] SATA PHY: stable DET=3
[   66.926474] SATA PHY: stable DET=3
[   67.030906] SATA PHY: stable DET=3
[   67.134430] SATA PHY: stable DET=3
[   67.239005] SATA PHY: stable DET=3
[   67.343410] SATA PHY: stable DET=3
[   67.447985] SATA PHY: stable DET=3
[   67.552403] SATA PHY: stable DET=3
[   67.656952] SATA PHY: stable DET=3
[   67.761528] SATA PHY: stable DET=3
[   67.865933] SATA PHY: stable DET=3
[   67.970508] SATA PHY: stable DET=3
[   68.074926] SATA PHY: stable DET=3
[   68.083625] SATA PHY: debounced
[   68.242305] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   98.221334] ata2.00: qc timeout (cmd 0xec)
[   98.225467] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   99.035300] SATA PHY: stable DET=3
[   99.139875] SATA PHY: stable DET=3
[   99.244281] SATA PHY: stable DET=3
[   99.348855] SATA PHY: stable DET=3
[   99.453287] SATA PHY: stable DET=3
[   99.556811] SATA PHY: stable DET=3
[   99.661386] SATA PHY: stable DET=3
[   99.765791] SATA PHY: stable DET=3
[   99.870366] SATA PHY: stable DET=3
[   99.974785] SATA PHY: stable DET=3
[  100.079334] SATA PHY: stable DET=3
[  100.183909] SATA PHY: stable DET=3
[  100.288314] SATA PHY: stable DET=3
[  100.392889] SATA PHY: stable DET=3
[  100.497308] SATA PHY: stable DET=3
[  100.601856] SATA PHY: stable DET=3
[  100.706431] SATA PHY: stable DET=3
[  100.810837] SATA PHY: stable DET=3
[  100.915412] SATA PHY: stable DET=3
[  101.019830] SATA PHY: stable DET=3
[  101.023263] SATA PHY: debounced
[  108.063137] ata2: port is slow to respond, please be patient (Status 0x80)
[  131.003980] ata2: port failed to respond (30 secs, Status 0x80)
[  131.009930] ata2: COMRESET failed (device not ready)
[  131.014926] ata2: hardreset failed, retrying in 5 secs
[  136.320451] SATA PHY: stable DET=3
[  136.425026] SATA PHY: stable DET=3
[  136.529509] SATA PHY: stable DET=3
[  136.632981] SATA PHY: stable DET=3
[  136.737556] SATA PHY: stable DET=3
[  136.841962] SATA PHY: stable DET=3
[  136.946536] SATA PHY: stable DET=3
[  137.051007] SATA PHY: stable DET=3
[  137.154492] SATA PHY: stable DET=3
[  137.259067] SATA PHY: stable DET=3
[  137.363472] SATA PHY: stable DET=3
[  137.468047] SATA PHY: stable DET=3
[  137.572505] SATA PHY: stable DET=3
[  137.676002] SATA PHY: stable DET=3
[  137.780577] SATA PHY: stable DET=3
[  137.884983] SATA PHY: stable DET=3
[  137.989558] SATA PHY: stable DET=3
[  138.094002] SATA PHY: stable DET=3
[  138.197513] SATA PHY: stable DET=3
[  138.302088] SATA PHY: stable DET=3
[  138.305524] SATA PHY: debounced
[  138.308717] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  138.319554] ata2.00: ATA-6, max UDMA/133, 640 sectors: LBA 
[  138.325157] ata2.00: ata2: dev 0 multi count 1
[  138.334245] ata2.00: configured for UDMA/133
[  138.338553] scsi3 : ahci
[  138.642450] SATA PHY: stable DET=3
[  138.746999] SATA PHY: stable DET=3
[  138.851574] SATA PHY: stable DET=3
[  138.955979] SATA PHY: stable DET=3
[  139.060554] SATA PHY: stable DET=3
[  139.164972] SATA PHY: stable DET=3
[  139.269521] SATA PHY: stable DET=3
[  139.374096] SATA PHY: stable DET=3
[  139.478502] SATA PHY: stable DET=3
[  139.583077] SATA PHY: stable DET=3
[  139.687495] SATA PHY: stable DET=3
[  139.792044] SATA PHY: stable DET=3
[  139.896619] SATA PHY: stable DET=3
[  140.001025] SATA PHY: stable DET=3
[  140.105599] SATA PHY: stable DET=3
[  140.210018] SATA PHY: stable DET=3
[  140.314567] SATA PHY: stable DET=3
[  140.419142] SATA PHY: stable DET=3
[  140.523547] SATA PHY: stable DET=3
[  140.628122] SATA PHY: stable DET=3
[  140.631564] SATA PHY: debounced
[  140.789363] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  140.800879] ata3.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
[  140.808662] ata3.00: ata3: dev 0 multi count 16
[  140.818560] ata3.00: configured for UDMA/133
[  140.822867] scsi4 : ahci
[  141.126871] SATA PHY: stable DET=0
[  141.231446] SATA PHY: stable DET=0
[  141.335852] SATA PHY: stable DET=0
[  141.440427] SATA PHY: stable DET=0
[  141.544884] SATA PHY: stable DET=0
[  141.648369] SATA PHY: stable DET=0
[  141.752944] SATA PHY: stable DET=0
[  141.857349] SATA PHY: stable DET=0
[  141.961924] SATA PHY: stable DET=0
[  142.066356] SATA PHY: stable DET=0
[  142.169866] SATA PHY: stable DET=0
[  142.274428] SATA PHY: stable DET=0
[  142.378821] SATA PHY: stable DET=0
[  142.483396] SATA PHY: stable DET=0
[  142.587801] SATA PHY: stable DET=0
[  142.692376] SATA PHY: stable DET=0
[  142.796925] SATA PHY: stable DET=0
[  142.901331] SATA PHY: stable DET=0
[  143.005906] SATA PHY: stable DET=0
[  143.110311] SATA PHY: stable DET=0
[  143.113748] SATA PHY: debounced
[  143.116927] ata4: SATA link down (SStatus 0 SControl 300)
[  143.122397] scsi 1:0:0:0: Direct-Access     ATA      WDC WD360GD-00FL 31.0 PQ: 0 ANSI: 5
[  143.130569] SCSI device sdc: 72303840 512-byte hdwr sectors (37020 MB)
[  143.137134] sdc: Write Protect is off
[  143.140844] SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  143.149864] SCSI device sdc: 72303840 512-byte hdwr sectors (37020 MB)
[  143.156427] sdc: Write Protect is off
[  143.160136] SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  143.169136]  sdc: sdc1 sdc2
[  143.181697] sd 1:0:0:0: Attached scsi disk sdc
[  143.186205] sd 1:0:0:0: Attached scsi generic sg2 type 0
[  143.191590] scsi 2:0:0:0: Direct-Access     ATA      Config  Disk     RGL1 PQ: 0 ANSI: 5
[  143.199761] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[  143.205550] sdd: Write Protect is off
[  143.209257] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  143.218356] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[  143.224143] sdd: Write Protect is off
[  143.227847] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  143.236927]  sdd: unknown partition table
[  143.241194] sd 2:0:0:0: Attached scsi disk sdd
[  143.245707] sd 2:0:0:0: Attached scsi generic sg3 type 0
[  143.251093] scsi 3:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
[  143.259270] SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
[  143.266007] sde: Write Protect is off
[  143.269713] SCSI device sde: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  143.278723] SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
[  143.285461] sde: Write Protect is off
[  143.289172] SCSI device sde: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  143.298165]  sde: sde1 sde2
[  143.313019] sd 3:0:0:0: Attached scsi disk sde
[  143.317525] sd 3:0:0:0: Attached scsi generic sg4 type 0
[  143.322933] wait_for_probes: waiting for 0 threads
[  143.328340] reiser4: sdc1: found disk format 4.0.0.
[  144.520852] VFS: Mounted root (reiser4 filesystem) readonly.
[  144.526574] Freeing unused kernel memory: 196k freed
INIT: version 2.86 booting
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...[  146.809128] Floppy drive(s): fd0 is 1.44M
[  146.827575] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 19
[  146.834248] FDC 0 is a post-1991 82077
[  146.840305] sky2 v1.10 addr 0xfa9fc000 irq 19 Yukon-EC (0xb6) rev 2
[  146.846953] sky2 eth0: addr 00:18:f3:3d:1b:06
[  146.859086] usbcore: registered new interface driver usbfs
[  146.864786] usbcore: registered new interface driver hub
[  146.870281] usbcore: registered new device driver usb
[  146.917589] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 23 (level, low) -> IRQ 23
[  146.931833] USB Universal Host Controller Interface driver v3.0
[  146.937929] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
[  146.945573] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[  146.946166] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
[  146.946174] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[  146.946243] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 1
[  146.946271] uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000e800
[  146.978170] ACPI: PCI Interrupt 0000:00:1d.2[C] -> <6>uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[  146.983006] usb usb1: new device found, idVendor=0000, idProduct=0000
[  146.983007] usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
[  146.983009] usb usb1: Product: UHCI Host Controller
[  146.983010] usb usb1: Manufacturer: Linux 2.6.19-rc6-mm1 uhci_hcd
[  146.983011] usb usb1: SerialNumber: 0000:00:1d.1
[  146.983053] usb usb1: configuration #1 chosen from 1 choice
[  146.983067] hub 1-0:1.0: USB hub found
[  146.983071] hub 1-0:1.0: 2 ports detected
[  147.032637] uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000e480
[  147.034105] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
[  147.034116] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[  147.034135] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 3
[  147.034162] uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000ec00
[  147.034208] usb usb3: new device found, idVendor=0000, idProduct=0000
[  147.034210] usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.034211] usb usb3: Product: UHCI Host Controller
[  147.034212] usb usb3: Manufacturer: Linux 2.6.19-rc6-mm1 uhci_hcd
[  147.034213] usb usb3: SerialNumber: 0000:00:1d.3
[  147.034247] usb usb3: configuration #1 chosen from 1 choice
[  147.034260] hub 3-0:1.0: USB hub found
[  147.034264] hub 3-0:1.0: 2 ports detected
[  147.039065] GSI 18 (level, low) -> IRQ 18
[  147.039076] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[  147.039096] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[  147.039124] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e880
[  147.039172] usb usb4: new device found, idVendor=0000, idProduct=0000
[  147.039174] usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.039175] usb usb4: Product: UHCI Host Controller
[  147.039176] usb usb4: Manufacturer: Linux 2.6.19-rc6-mm1 uhci_hcd
[  147.039177] usb usb4: SerialNumber: 0000:00:1d.2
[  147.039213] usb usb4: configuration #1 chosen from 1 choice
[  147.039227] hub 4-0:1.0: USB hub found
[  147.039230] hub 4-0:1.0: 2 ports detected
[  147.179121] usb usb2: new device found, idVendor=0000, idProduct=0000
[  147.185797] usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.192816] usb usb2: Product: UHCI Host Controller
[  147.197824] usb usb2: Manufacturer: Linux 2.6.19-rc6-mm1 uhci_hcd
[  147.204089] usb usb2: SerialNumber: 0000:00:1d.0
[  147.208847] usb usb2: configuration #1 chosen from 1 choice
[  147.214630] hub 2-0:1.0: USB hub found
[  147.218518] hub 2-0:1.0: 2 ports detected
[  147.226187] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
[  147.233789] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[  147.239176] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[  147.246785] ehci_hcd 0000:00:1d.7: debug port 1
[  147.251424] ehci_hcd 0000:00:1d.7: irq 20, io mem 0xfebfbc00
[  147.261082] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[  147.268797] usb usb5: new device found, idVendor=0000, idProduct=0000
[  147.275356] usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.282364] usb usb5: Product: EHCI Host Controller
[  147.287359] usb usb5: Manufacturer: Linux 2.6.19-rc6-mm1 ehci_hcd
[  147.293599] usb usb5: SerialNumber: 0000:00:1d.7
[  147.298349] usb usb5: configuration #1 chosen from 1 choice
[  147.304096] hub 5-0:1.0: USB hub found
[  147.307971] hub 5-0:1.0: 8 ports detected
[  147.374295] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 19
done.
[  147.436111] hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
Setting parameters of disc: (none).
Activating swap:swapon on /dev/sdc2
[  148.355030] usb 5-7: new high speed USB device using ehci_hcd and address 5
[  148.360570] Adding 1959920k swap on /dev/sdc2.  Priority:-1 extents:1 across:1959920k
.
Will now check root file system:fsck 1.40-WIP (14-Nov-2006)
[/sbin/fsck.reiser4 (1) -- /] fsck.reiser4 -a /dev/sdc1 
fsck.reiser4 /dev/sdc1 
.
[  148.485883] usb 5-7: new device found, idVendor=05e3, idProduct=0606
[  148.492527] usb 5-7: new device strings: Mfr=0, Product=1, SerialNumber=0
[  148.499389] usb 5-7: Product: USB2.0 Hub
[  148.503427] usb 5-7: configuration #1 chosen from 1 choice
[  148.509256] hub 5-7:1.0: USB hub found
[  148.513483] hub 5-7:1.0: 4 ports detected
Setting the system clock again..
[  148.693760] usb 2-1: new low speed USB device using uhci_hcd and address 2
[  148.872577] usb 2-1: new device found, idVendor=045e, idProduct=001e
[  148.879404] usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
[  148.886640] usb 2-1: Product: Microsoft IntelliMouse® Explorer
[  148.892908] usb 2-1: Manufacturer: Microsoft
[  148.897554] usb 2-1: configuration #1 chosen from 1 choice
[  149.037455] usb 2-2: new low speed USB device using uhci_hcd and address 3
[  149.202295] usb 2-2: new device found, idVendor=0d3d, idProduct=0001
[  149.209122] usb 2-2: new device strings: Mfr=0, Product=2, SerialNumber=0
[  149.216141] usb 2-2: Product: USBPS2
[  149.220037] usb 2-2: configuration #1 chosen from 1 choice
[  149.381122] usb 4-1: new full speed USB device using uhci_hcd and address 2
System Clock set. Local time: Wed Nov 29 10:00:33 MST 2006.
Cleaning up ifupdown....
[  149.501470] usb 4-1: device descriptor read/64, error -71
Loading kernel module nvidia.
[  149.720180] usb 4-1: device descriptor read/64, error -71
[  149.928721] usb 4-1: new full speed USB device using uhci_hcd and address 3
[  150.049658] usb 4-1: device descriptor read/64, error -71
[  150.247906] nvidia: module license 'NVIDIA' taints kernel.
[  150.270965] usb 4-1: device descriptor read/64, error -71
[  150.479770] usb 4-1: new full speed USB device using uhci_hcd and address 4
[  150.518463] NVRM: The NVIDIA probe routine was not called for 1 device(s).
[  150.518480] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[  150.533044] NVRM: This can occur when a driver such as rivafb, nvidiafb or
[  150.533045] NVRM: rivatv was loaded and obtained ownership of the NVIDIA
[  150.533045] NVRM: device(s).
[  150.549869] NVRM: Try unloading the rivafb, nvidiafb or rivatv kernel module
[  150.549870] NVRM: (and/or reconfigure your kernel without rivafb/nvidiafb
[  150.549871] NVRM: support), then try loading the NVIDIA kernel module again.
[  150.571210] NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-9629  Wed Nov  1 19:27:33 PST 2006
Loading kernel module loop.
FATAL: Module loop not found.
Loading kernel module i2c-i801.
Loading kernel module i2c-isa.
Loading kernel module eeprom.
Loading kernel module w83627ehf.
Loading kernel module usb-storage.
[  150.664559] Initializing USB Mass Storage driver...
[  150.895018] usb 4-1: device not accepting address 4, error -71
[  151.003603] usb 4-1: new full speed USB device using uhci_hcd and address 5
[  151.419585] usb 4-1: device not accepting address 5, error -71
[  151.594459] usb 5-7.3: new high speed USB device using ehci_hcd and address 6
[  151.688505] usbcore: registered new interface driver hiddev
[  151.699581] usb 5-7.3: new device found, idVendor=0bda, idProduct=8187
[  151.706515] usb 5-7.3: new device strings: Mfr=1, Product=2, SerialNumber=3
[  151.713541] usb 5-7.3: Product: RTL8187_Wireless
[  151.718277] usb 5-7.3: Manufacturer: Manufacturer_Realtek_RTL8187_
[  151.718620] input: Microsoft Microsoft IntelliMouse® Explorer as /class/input/input3
[  151.718638] input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-0000:00:1d.0-1
[  151.742225] usb 5-7.3: SerialNumber: 0015AF05C9DE
[  151.747108] usb 5-7.3: configuration #1 chosen from 1 choice
[  151.753075] input: USBPS2 as /class/input/input4
[  151.757857] input: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:1d.0-2
[  151.786051] input: USBPS2 as /class/input/input5
[  151.790807] input: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:1d.0-2
[  151.797467] usbcore: registered new interface driver usbhid
[  151.800788] usbcore: registered new interface driver usb-storage
[  151.800790] USB Mass Storage support registered.
[  151.814017] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Loading kernel module snd-rtctimer.
Loading kernel module uhci-hcd.
Loading kernel module acpi-cpufreq.
FATAL: Error inserting acpi_cpufreq (/lib/modules/2.6.19-rc6-mm1/kernel/arch/x86_64/kernel/cpufreq/acpi-cpufreq.[  151.898367] usbcore: registered new interface driver cdc_acm
ko): No such dev[  151.905240] drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for USB modems and ISDN adapters
ice
Loading kernel module cdc-acm.
Loading device-mapper support.
Will now check all file systems.
fsck 1.40-WIP (14-Nov-2006)
Checking all file systems.
Done checking file systems. 
A log is being saved in /var/log/fsck/checkfs if that location is writable.
Setting kernel variables...done.
Will now mount local filesystems:[  152.069508] ReiserFS: sde1: found reiserfs format "3.6" with standard journal
[  152.076801] ReiserFS: sde1: using ordered data mode
[  152.085742] ReiserFS: sde1: journal params: device sde1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[  152.100843] ReiserFS: sde1: checking transaction log (sde1)
[  164.600198] ReiserFS: sde1: replayed 794 transactions in 12 seconds
[  164.669534] ReiserFS: sde1: Using r5 hash to sort names
[  164.738095] reiser4: sda1: found disk format 4.0.0.
.
Will now activate swapfile swap:done.
Cleaning /tmp...done.
Cleaning /var/run...done.
Cleaning /var/lock...done.
Setting up networking....
Configuring network interfaces...done.
Starting portmap daemon....
[  166.539376] sky2 eth0: enabling interface
Setting sensors limits: done.
Setting console screen modes and fonts.
Setting up ALSA...done.
Initializing random number generator...done.
Recovering nvi editor sessions...none found.
Setting up X server socket directory /tmp/.X11-unix....
Setting up ICE socket directory /tmp/.ICE-unix....
Recovering schroot sessions... done.
INIT: Entering runlevel: 2
Starting system log daemon....
Starting kernel log daemon....
Loading ACPI modules:
Starting Advanced Configuration and Power Interface daemon: acpid.
Starting Common Unix Printing System: cupsd[  168.987188] sky2 eth0: Link is up at 1000 Mbps, full duplex, flow control both
.
Starting system message bus: dbus.
Starting Hardware abstraction layer: hald.
Starting DirMngr: dirmngr.
Starting mouse interface server: gpm.
Starting internet superserver: inetd.
Starting Postfix Mail Transport Agent: postfix.
Starting Samba daemons: nmbd smbd.
Starting sensor daemon: sensord.
Starting OpenBSD Secure Shell server: sshd.
Setting up X font server socket directory /tmp/.font-unix...done.
Starting X font server: xfs.
Starting NFS common utilities: statd.
Starting NTP server: ntpd.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: crond.
Starting K Display Manager: kdm.
Running local boot scripts (/etc/rc.local).

Debian GNU/Linux 4.0 luna ttyS0

luna login: INStopping K Display Manager: kdm.
Stopping deferred execution scheduler: atd.
Stopping periodic command scheduler: crond.
Stopping Samba daemons: nmbd smbd.
Stopping Advanced Configuration and Power Interface daemon: acpid.
Stopping Common Unix Printing System: cupsd.
Stopping Hardware abstraction layer: hald.
Stopping system message bus: dbus.
Stopping DirMngr: dirmngr.
Stopping mouse interface server: gpm.
Stopping internet superserver: inetd.
Stopping Postfix Mail Transport Agent: postfix.
Stopping sensor daemon: sensord.
Stopping OpenBSD Secure Shell server: sshd.
Stopping X font server: xfs.
Stopping NTP server: ntpd.
Saving the system clock..
Hardware Clock updated to Wed Nov 29 10:18:57 MST 2006.
Shutting down ALSA...done.
Stopping NFS common utilities: statd.
Stopping kernel log daemon....
Stopping system log daemon....
Asking all remaining processes to terminate...done.
Killing all remaining processes...done.
Saving random seed...done.
Unmounting remote and non-toplevel virtual filesystems...done.
Stopping portmap daemon....
Deconfiguring network interfaces...[ 1256.730223] sky2 eth0: disabling interface
done.
Cleaning up ifupdown....
Will now unmount temporary filesystems:/dev umounted
.
Will now deactivate swap:swapoff on /dev/sdc2
.
Will now unmount local filesystems:/backup umounted
/home umounted
/tmp umounted
/dev/sde1 umounted
/dev/sda1 umounted
/dev/hde1 umounted
.
Mounting root filesystem read-only...done.
Will now halt.
[ 1263.282362] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1263.288935] ata2.00: (irq_stat 0x40000001)
[ 1263.293132] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 1263.293133]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 1263.317596] ata2.00: configured for UDMA/133
[ 1263.321960] ata2: EH complete
[ 1263.325033] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1263.331612] ata2.00: (irq_stat 0x40000001)
[ 1263.335793] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 1263.335794]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 1263.360185] ata2.00: configured for UDMA/133
[ 1263.364560] ata2: EH complete
[ 1263.367633] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1263.374188] ata2.00: (irq_stat 0x40000001)
[ 1263.378388] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 1263.378389]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 1263.402797] ata2.00: configured for UDMA/133
[ 1263.407169] ata2: EH complete
[ 1263.410243] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1263.416817] ata2.00: (irq_stat 0x40000001)
[ 1263.421006] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 1263.421007]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 1263.445412] ata2.00: configured for UDMA/133
[ 1263.449788] ata2: EH complete
[ 1263.452853] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1263.459427] ata2.00: (irq_stat 0x40000001)
[ 1263.463599] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 1263.463600]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 1263.488009] ata2.00: configured for UDMA/133
[ 1263.492381] ata2: EH complete
[ 1263.495444] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1263.502025] ata2.00: (irq_stat 0x40000001)
[ 1263.506218] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 1263.506219]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 1263.530601] ata2.00: configured for UDMA/133
[ 1263.534976] ata2: EH complete
[ 1263.538045] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1263.544629] ata2.00: (irq_stat 0x40000001)
[ 1263.548829] ata2.00: cmd 94/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 1263.548830]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 1263.573221] ata2.00: configured for UDMA/133
[ 1263.577602] ata2: EH complete
[ 1263.580665] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1263.587239] ata2.00: (irq_stat 0x40000001)
[ 1263.591438] ata2.00: cmd 94/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 1263.591439]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 1263.615862] ata2.00: configured for UDMA/133
[ 1263.620229] ata2: EH complete
[ 1263.623311] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1263.629868] ata2.00: (irq_stat 0x40000001)
[ 1263.634065] ata2.00: cmd 94/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 1263.634066]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 1263.658447] ata2.00: configured for UDMA/133
[ 1263.662833] ata2: EH complete
[ 1263.665895] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1263.672469] ata2.00: (irq_stat 0x40000001)
[ 1263.676667] ata2.00: cmd 94/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 1263.676668]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 1263.701069] ata2.00: configured for UDMA/133
[ 1263.705441] ata2: EH complete
[ 1263.708497] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1263.715071] ata2.00: (irq_stat 0x40000001)
[ 1263.719259] ata2.00: cmd 94/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 1263.719260]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 1263.743678] ata2.00: configured for UDMA/133
[ 1263.748061] ata2: EH complete
[ 1263.751134] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1263.757708] ata2.00: (irq_stat 0x40000001)
[ 1263.761887] ata2.00: cmd 94/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 1263.761888]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 1263.786297] ata2.00: configured for UDMA/133
[ 1263.790672] ata2: EH complete
[ 1263.793738] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[ 1263.795912] Synchronizing SCSI cache for disk sde: 
[ 1263.804598] sdd: Write Protect is off
[ 1263.808358] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1263.817575] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[ 1263.823445] sdd: Write Protect is off
[ 1263.827208] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1263.838496] Synchronizing SCSI cache for disk sdc: 
[ 1263.843632] Synchronizing SCSI cache for disk sdb: 
[ 1263.848871] Synchronizing SCSI cache for disk sda: 
[ 1264.345916] Shutdown: hdg
[ 1264.348810] Shutdown: hde
[ 1264.352044] Power down.
[ 1264.354633] acpi_power_off called

--------------020601080507020601000301--
