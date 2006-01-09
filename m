Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965354AbWAIADg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965354AbWAIADg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965364AbWAIADf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:03:35 -0500
Received: from [202.67.154.148] ([202.67.154.148]:25487 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S965354AbWAIADe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:03:34 -0500
Message-ID: <43C1A858.8060307@ns666.com>
Date: Mon, 09 Jan 2006 01:03:36 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Night Owl 3.12V
X-Accept-Language: en-us
MIME-Version: 1.0
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14.x and weird things with interrupts on smp machines
References: <200601081931.31686.arekm@pld-linux.org>
In-Reply-To: <200601081931.31686.arekm@pld-linux.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Miskiewicz wrote:
> I've recently noticed that something weird is happening on my SMP machines. 
> Both machines are 2 x Xeon CPU with HT enabled. /proc/interrupts shows that 
> only CPU#0 is used which is very weird (and CPU#1 on one of the machines). I'm 
> running userspace irqbalance, too. I'm unable to alter affinity settings for 
> irqs - these are always the same as below.
> 
> Has anyone noticed such problems?
> 
> First one:
> 00:00.0 Host bridge: Intel Corporation E7501 Memory Controller Hub (rev 01)
> 00:00.1 Class ff00: Intel Corporation E7500/E7501 Host RASUM Controller (rev 
> 01)
> 00:02.0 PCI bridge: Intel Corporation E7500/E7501 Hub Interface B PCI-to-PCI 
> Bridge (rev 01)
> 00:02.1 Class ff00: Intel Corporation E7500/E7501 Hub Interface B RASUM 
> Controller (rev 01)
> 00:1d.0 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #1) (rev 02)
> 00:1d.1 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #2) (rev 02)
> 00:1d.2 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #3) (rev 02)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 42)
> 00:1f.0 ISA bridge: Intel Corporation 82801CA LPC Interface Controller (rev 
> 02)
> 00:1f.1 IDE interface: Intel Corporation 82801CA Ultra ATA Storage Controller 
> (rev 02)
> 00:1f.3 SMBus: Intel Corporation 82801CA/CAM SMBus Controller (rev 02)
> 01:1c.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
> 01:1d.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev 04)
> 01:1e.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
> 01:1f.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev 04)
> 03:01.0 Fibre Channel: QLogic Corp. QLA2312 Fibre Channel Adapter (rev 02)
> 04:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 04:04.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] 
> (rev 0d)
> 04:05.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet 
> Controller (rev 02)
> 
> # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>   0:      74712         51          0          0    IO-APIC-edge  timer
>   4:        974          0          0          0    IO-APIC-edge  serial
>   8:          1          0          0          0    IO-APIC-edge  rtc
>   9:          0          0          0          0   IO-APIC-level  acpi
> 169:      72699         45          0          0   IO-APIC-level  qla2300
> 177:     549413        229          0          0   IO-APIC-level  eth0
> 185:     280407         80          0          0   IO-APIC-level  eth1
> NMI:      73803      73785      73781      73782
> LOC:      74586      74649      74755      74780
> ERR:          0
> MIS:          0
> 
> # for a in /proc/irq/*; do echo -n "$a :"; cat $a/smp_affinity; done
> /proc/irq/0 :0001
> /proc/irq/1 :0001
> /proc/irq/10 :0001
> /proc/irq/11 :0001
> /proc/irq/12 :0001
> /proc/irq/13 :0001
> /proc/irq/14 :0001
> /proc/irq/15 :0001
> /proc/irq/169 :000f
> /proc/irq/177 :000f
> /proc/irq/185 :000f
> /proc/irq/2 :ffff
> /proc/irq/3 :0001
> /proc/irq/4 :0001
> /proc/irq/5 :0001
> /proc/irq/6 :0001
> /proc/irq/7 :0001
> /proc/irq/8 :0001
> /proc/irq/9 :0001
> 
> # cat /proc/cmdline
> auto BOOT_IMAGE=pld-2.6.14.3-t ro root=802 console=tty0 console=ttyS0,9600n81 
> panic=60 nmi_watchdog=1 selinux=0
> 
> Linux version 2.6.14.3-1smp (builder@olimp) (gcc version 3.3.6 (PLD Linux)) #1 
> SMP Fri Nov 25 02:41:46 CET 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009a000 (usable)
>  BIOS-e820: 000000000009a000 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000f7ef0000 (usable)
>  BIOS-e820: 00000000f7ef0000 - 00000000f7efc000 (ACPI data)
>  BIOS-e820: 00000000f7efc000 - 00000000f7f00000 (ACPI NVS)
>  BIOS-e820: 00000000f7f00000 - 00000000f7f80000 (usable)
>  BIOS-e820: 00000000f7f80000 - 00000000f8000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
>  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
>  BIOS-e820: 0000000100000000 - 0000000188000000 (usable)
> 5376MB HIGHMEM available.
> 896MB LOWMEM available.
> found SMP MP-table at 000f64d0
> On node 0 totalpages: 1605632
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 225280 pages, LIFO batch:31
>   HighMem zone: 1376256 pages, LIFO batch:31
> DMI present.
> ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6500
> ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0xf7ef8658
> ACPI: FADT (v001 Intel  SE7501CW 0x06040000 PTL  0x00000008) @ 0xf7efbe78
> ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @ 
> 0xf7efbeec
> ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0xf7efbf88
> ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 0xf7efbfb0
> ACPI: DSDT (v001  INTEL   PLUMAS 0x06040000 MSFT 0x0100000e) @ 0x00000000
> ACPI: PM-Timer IO Port: 0x1008
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 15:2 APIC version 20
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
> Processor #6 15:2 APIC version 20
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> Processor #1 15:2 APIC version 20
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
> Processor #7 15:2 APIC version 20
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> ACPI: IOAPIC (id[0x03] address[0xfec80000] gsi_base[24])
> IOAPIC[1]: apic_id 3, version 32, address 0xfec80000, GSI 24-47
> ACPI: IOAPIC (id[0x04] address[0xfec80400] gsi_base[48])
> IOAPIC[2]: apic_id 4, version 32, address 0xfec80400, GSI 48-71
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Enabling APIC mode:  Flat.  Using 3 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at f8800000 (gap: f8000000:06c00000)
> Built 1 zonelists
> Kernel command line: auto BOOT_IMAGE=pld-2.6.14.3-t ro root=802 console=tty0 
> console=ttyS0,9600n81 panic=60 nmi_watchdog=1
> selinux=0
> mapped APIC to ffffd000 (fee00000)
> mapped IOAPIC to ffffc000 (fec00000)
> mapped IOAPIC to ffffb000 (fec80000)
> mapped IOAPIC to ffffa000 (fec80400)
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 65536 bytes)
> Detected 2790.744 MHz processor.
> Using pmtmr for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 6233888k/6422528k available (1939k kernel code, 55740k reserved, 633k 
> data, 244k init, 5373376k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay using timer specific routine.. 5586.10 BogoMIPS 
> (lpj=27930541)
> Security Framework v1.0.0 initialized
> SELinux:  Disabled at boot.
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
> 00004400 00000000 00000000
> CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 
> 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 
> 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
> mtrr: v2.0 (20020519)
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> ACPI: Looking for DSDT in initrd... not found.
> CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 05
> Booting processor 1/1 eip 2000
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 5581.36 BogoMIPS 
> (lpj=27906820)
> CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
> 00004400 00000000 00000000
> CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 
> 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 
> 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#1.
> CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 05
> Booting processor 2/6 eip 2000
> Initializing CPU#2
> Calibrating delay using timer specific routine.. 5581.73 BogoMIPS 
> (lpj=27908671)
> CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
> 00004400 00000000 00000000
> CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 
> 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 3
> CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 
> 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#2.
> CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 05
> Booting processor 3/7 eip 2000
> Initializing CPU#3
> Calibrating delay using timer specific routine.. 5581.83 BogoMIPS 
> (lpj=27909174)
> CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
> 00004400 00000000 00000000
> CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 
> 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 3
> CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 
> 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#3.
> CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 05
> Total of 4 processors activated (22331.04 BogoMIPS).
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 pin1=2 pin2=-1
> checking TSC synchronization across 4 CPUs: passed.
> Brought up 4 CPUs
> checking if image is initramfs...it isn't (no cpio magic); looks like an 
> initrd
> Freeing initrd memory: 638k freed
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: PCI BIOS revision 2.10 entry at 0xfd905, last bus=4
> PCI: Using configuration type 1
> ACPI: Subsystem revision 20050902
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
> PCI quirk: region 1180-11bf claimed by ICH4 GPIO
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> Boot video device is 0000:04:03.0
> PCI: Transparent bridge - 0000:00:1e.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *10 11 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11 14 15)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *12
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 *11 14 15)
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 *11 14 15)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.ICH3._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HLB_.Z000._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HLB_.Z001._PRT]
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 12 devices
> PnPBIOS: Disabled by ACPI PNP
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> PCI: Bridge: 0000:01:1d.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:01:1f.0
>   IO window: 7000-7fff
>   MEM window: fc200000-fc2fffff
>   PREFETCH window: f8800000-f88fffff
> PCI: Bridge: 0000:00:02.0
>   IO window: 7000-7fff
>   MEM window: fc100000-fc2fffff
>   PREFETCH window: f8800000-f88fffff
> PCI: Bridge: 0000:00:1e.0
>   IO window: 8000-8fff
>   MEM window: fc300000-fdffffff
>   PREFETCH window: f8900000-f89fffff
> PCI: Setting latency timer of device 0000:00:1e.0 to 64
> Simple Boot Flag at 0x35 set to 0x1
> Machine check exception polling timer started.
> audit: initializing netlink socket (disabled)
> audit(1136747193.950:1): initialized
> highmem bounce pool size: 64 pages
> Total HugeTLB memory allocated, 0
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> Initializing Cryptographic API
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Real Time Clock Driver v1.12
> PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
> PNP: PS/2 controller doesn't have AUX irq; using default 12
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> mice: PS/2 mouse device common for all mice
> NET: Registered protocol family 2
> IP route cache hash table entries: 262144 (order: 8, 1048576 bytes)
> TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
> TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
> TCP: Hash tables configured (established 524288 bind 65536)
> TCP reno registered
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Testing NMI watchdog ... OK.
> Starting balanced_irq
> Using IPI Shortcut mode
> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (romfs filesystem) readonly.
> SCSI subsystem initialized
> QLogic Fibre Channel HBA Driver
> ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 48 (level, low) -> IRQ 169
> qla2300 0000:03:01.0: Found an ISP2312, irq 169, iobase 0xf8810000
> qla2300 0000:03:01.0: Configuring PCI space...
> qla2300 0000:03:01.0: Configure NVRAM parameters...
> qla2300 0000:03:01.0: Verifying loaded RISC code...
> qla2300 0000:03:01.0: LIP reset occured (f7f7).
> qla2300 0000:03:01.0: Waiting for LIP to complete...
> qla2300 0000:03:01.0: LOOP UP detected (2 Gbps).
> qla2300 0000:03:01.0: Topology - (F_Port), Host Loop address 0xffff
> scsi0 : qla2xxx
> qla2300 0000:03:01.0:
>  QLogic Fibre Channel HBA Driver: 8.01.00-k
>   QLogic QLA2340 -
>   ISP2312: PCI (66 MHz) @ 0000:03:01.0 hdma+, host#=0, fw=3.03.15 IPX
> scsi: unknown device type 12
>   Vendor: COMPAQ    Model: MSA1000           Rev: 4.96
>   Type:   RAID                               ANSI SCSI revision: 04
>   Vendor: COMPAQ    Model: MSA1000 VOLUME    Rev: 4.96
>   Type:   Direct-Access                      ANSI SCSI revision: 04
>   Vendor: COMPAQ    Model: MSA1000 VOLUME    Rev: 4.96
>   Type:   Direct-Access                      ANSI SCSI revision: 04
> SCSI device sda: 775939500 512-byte hdwr sectors (397281 MB)
> SCSI device sda: drive cache: write back
> SCSI device sda: 775939500 512-byte hdwr sectors (397281 MB)
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 sda3
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 1
> SCSI device sdb: 1381590 512-byte hdwr sectors (707 MB)
> SCSI device sdb: drive cache: write back
> SCSI device sdb: 1381590 512-byte hdwr sectors (707 MB)
> SCSI device sdb: drive cache: write back
>  sdb: sdb1 sdb2
> Attached scsi disk sdb at scsi0, channel 0, id 0, lun 4
> SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
> GI XFS Quota Management subsystem
> XFS mounting filesystem sda2
> Ending clean XFS mount for filesystem: sda2
> VFS: Mounted root (xfs filesystem) readonly.
> Trying to move old root to /initrd ... okay
> Freeing unused kernel memory: 244k freed
> Adding 6000236k swap on /dev/sda1.  Priority:-1 extents:1 across:6000236k
> Netfilter messages via NETLINK v0.30.
> ip_conntrack version 2.3 (8192 buckets, 65536 max) - 248 bytes per conntrack
> device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
> XFS mounting filesystem dm-1
> Ending clean XFS mount for filesystem: dm-1
> XFS mounting filesystem dm-2
> Ending clean XFS mount for filesystem: dm-2
> XFS mounting filesystem dm-0
> Ending clean XFS mount for filesystem: dm-0
> 
> 
> The other machine:
> 00:00.0 Host bridge: Intel Corporation E7500 Memory Controller Hub (rev 03)
> 00:02.0 PCI bridge: Intel Corporation E7500/E7501 Hub Interface B PCI-to-PCI 
> Bridge (rev 03)
> 00:1d.0 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #1) (rev 02)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 42)
> 00:1f.0 ISA bridge: Intel Corporation 82801CA LPC Interface Controller (rev 
> 02)
> 00:1f.1 IDE interface: Intel Corporation 82801CA Ultra ATA Storage Controller 
> (rev 02)
> 00:1f.3 SMBus: Intel Corporation 82801CA/CAM SMBus Controller (rev 02)
> 01:01.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] 
> (rev 10)
> 01:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 02:1c.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 03)
> 02:1d.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev 03)
> 02:1e.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 03)
> 02:1f.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev 03)
> 03:03.0 Fibre Channel: QLogic Corp. QLA2312 Fibre Channel Adapter (rev 02)
> 04:01.0 Ethernet controller: Intel Corporation 82545EM Gigabit Ethernet 
> Controller (Copper) (rev 01)
> 
> # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>   0:  354490746          0          0          0    IO-APIC-edge  timer
>   2:          0          0          0          0          XT-PIC  cascade
>   4:     447316          0          0          0    IO-APIC-edge  serial
>   8:          2          0          0          0    IO-APIC-edge  rtc
> 145:          0          0          0          0   IO-APIC-level  
> uhci_hcd:usb1
> 153:  387875616          0          0          0   IO-APIC-level  eth0
> 169:   49346270          0          0          0   IO-APIC-level  qla2300
> 177: 2764054244          0          0          0   IO-APIC-level  eth1
> NMI:  354490780  354490764  354490762  354490760
> LOC:  354506771  354506924  354506917  354506900
> ERR:          0
> MIS:          0
> 
> # for a in /proc/irq/*; do echo -n "$a :"; cat $a/smp_affinity; done
> /proc/irq/0 :0001
> /proc/irq/1 :0001
> /proc/irq/10 :0001
> /proc/irq/11 :ffff
> /proc/irq/12 :0001
> /proc/irq/13 :0001
> /proc/irq/14 :0001
> /proc/irq/145 :ffff
> /proc/irq/15 :0001
> /proc/irq/153 :ffff
> /proc/irq/161 :ffff
> /proc/irq/169 :ffff
> /proc/irq/177 :ffff
> /proc/irq/2 :ffff
> /proc/irq/3 :0001
> /proc/irq/4 :0001
> /proc/irq/5 :ffff
> /proc/irq/6 :0001
> /proc/irq/7 :0001
> /proc/irq/8 :0001
> /proc/irq/9 :ffff
> 
> CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000 
> 00000000 00000000 00000000
> CPU: After vendor identify, caps: 3febfbff 00000000 00000000 00000000 00000000 
> 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> CPU: After all inits, caps: 3febfbff 00000000 00000000 00000080 00000000 
> 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
> mtrr: v2.0 (20020519)
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> CPU0: Intel(R) XEON(TM) CPU 1.80GHz stepping 04
> Booting processor 1/1 eip 2000
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 3599.64 BogoMIPS 
> (lpj=17998208)
> CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000 
> 00000000 00000000 00000000
> CPU: After vendor identify, caps: 3febfbff 00000000 00000000 00000000 00000000 
> 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> CPU: After all inits, caps: 3febfbff 00000000 00000000 00000080 00000000 
> 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#1.
> CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU1: Intel(R) XEON(TM) CPU 1.80GHz stepping 04
> Booting processor 2/6 eip 2000
> Initializing CPU#2
> Calibrating delay using timer specific routine.. 3599.77 BogoMIPS 
> (lpj=17998879)
> CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000 
> 00000000 00000000 00000000
> CPU: After vendor identify, caps: 3febfbff 00000000 00000000 00000000 00000000 
> 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 3
> CPU: After all inits, caps: 3febfbff 00000000 00000000 00000080 00000000 
> 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#2.
> CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU2: Intel(R) XEON(TM) CPU 1.80GHz stepping 04
> Booting processor 3/7 eip 2000
> Initializing CPU#3
> Calibrating delay using timer specific routine.. 3599.78 BogoMIPS 
> (lpj=17998926)
> CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000 
> 00000000 00000000 00000000
> CPU: After vendor identify, caps: 3febfbff 00000000 00000000 00000000 00000000 
> 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 3
> CPU: After all inits, caps: 3febfbff 00000000 00000000 00000080 00000000 
> 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#3.
> CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU3: Intel(R) XEON(TM) CPU 1.80GHz stepping 04
> Total of 4 processors activated (14404.04 BogoMIPS).
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 pin1=2 pin2=0
> checking TSC synchronization across 4 CPUs: passed.
> Brought up 4 CPUs
> 

I had the same problem, after disabling MSI in the kernel it started to
work. (i use also the daemon irqbalance )


