Return-Path: <linux-kernel-owner+w=401wt.eu-S1760793AbWLHSEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760793AbWLHSEG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760794AbWLHSEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:04:06 -0500
Received: from pat.uio.no ([129.240.10.15]:49203 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760793AbWLHSEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:04:01 -0500
Subject: Re: NFS related BUGs at shutdown - do_exit() + lock held at task
	exit time - 2.6.17.8
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net, Neil Brown <neilb@suse.de>
In-Reply-To: <9a8748490612080341j4f0fa7b5l2f7272df0df55073@mail.gmail.com>
References: <9a8748490612080341j4f0fa7b5l2f7272df0df55073@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 13:03:42 -0500
Message-Id: <1165601022.5676.22.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.646, required 12,
	autolearn=disabled, AWL 1.35, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 12:41 +0100, Jesper Juhl wrote:
> Greetings,
> 
> I just got a kernel crash when shutting down a webserver. Nothing made
> it to the logs, but I managed to get a photo of the dump on screen :
> http://www.kernel.org/pub/linux/kernel/people/juhl/images/2.6.17.8-kernel-crash.jpg

It is hard to see what is going on there. AFAICS, the more interesting
stuff to do with the Oops itself has scrolled off the screen. Any chance
it may have been syslogged?

Cheers
  Trond

> The server is running 2.6.17.8
> 
> I've attached the .config
> 
> Here's dmesg output from a fresh boot :
> 
> Linux version 2.6.17.8-ws5 (jj@server) (gcc version 4.1.1 (Gentoo
> 4.1.1-r1)) #5 SMP Fri Dec 8 10:45:18 CET 2006
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009d400 (usable)
>  BIOS-e820: 000000000009d400 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000007ffdc180 (usable)
>  BIOS-e820: 000000007ffdc180 - 000000007ffe0000 (ACPI data)
>  BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
> 1151MB HIGHMEM available.
> 896MB LOWMEM available.
> found SMP MP-table at 0009d540
> On node 0 totalpages: 524252
>   DMA zone: 4096 pages, LIFO batch:0
>   Normal zone: 225280 pages, LIFO batch:31
>   HighMem zone: 294876 pages, LIFO batch:31
> DMI 2.3 present.
> ACPI: RSDP (v000 IBM                                   ) @ 0x000fdfc0
> ACPI: RSDT (v001 IBM    SERONYXP 0x00001000 IBM  0x45444f43) @ 0x7ffdff80
> ACPI: FADT (v001 IBM    SERONYXP 0x00001000 IBM  0x45444f43) @ 0x7ffdff00
> ACPI: MADT (v001 IBM    SERONYXP 0x00001000 IBM  0x45444f43) @ 0x7ffdfe80
> ACPI: ASF! (v016 IBM    SERONYXP 0x00000001 IBM  0x45444f43) @ 0x7ffdfdc0
> ACPI: DSDT (v001 IBM    SERTURQU 0x00001000 MSFT 0x0100000b) @ 0x00000000
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 15:2 APIC version 20
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Processor #1 15:2 APIC version 20
> ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
> ACPI: IOAPIC (id[0x0e] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 14, version 17, address 0xfec00000, GSI 0-15
> ACPI: IOAPIC (id[0x0d] address[0xfec01000] gsi_base[16])
> IOAPIC[1]: apic_id 13, version 17, address 0xfec01000, GSI 16-31
> ACPI: IOAPIC (id[0x0c] address[0xfec02000] gsi_base[32])
> IOAPIC[2]: apic_id 12, version 17, address 0xfec02000, GSI 32-47
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ5 used by override.
> Enabling APIC mode:  Flat.  Using 3 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
> Built 1 zonelists
> Kernel command line: ro root=/dev/sda2 nmi_watchdog=1
> mapped APIC to ffffd000 (fee00000)
> mapped IOAPIC to ffffc000 (fec00000)
> mapped IOAPIC to ffffb000 (fec01000)
> mapped IOAPIC to ffffa000 (fec02000)
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Initializing CPU#0
> CPU 0 irqstacks, hard=c03fe000 soft=c03f6000
> PID hash table entries: 4096 (order: 12, 16384 bytes)
> Detected 3189.890 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 2075264k/2097008k available (1862k kernel code, 20588k
> reserved, 953k data, 172k init, 1179504k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay using timer specific routine.. 6388.28 BogoMIPS (lpj=12776570)
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
> 00004400 00000000 00000000
> CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
> 00004400 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: L3 cache: 1024K
> CPU: Physical Processor ID: 0
> CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080
> 00004400 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU0: Thermal monitoring enabled
> Checking 'hlt' instruction... OK.
> Freeing SMP alternatives: 16k freed
> CPU0: Intel(R) Xeon(TM) CPU 3.20GHz stepping 05
> Booting processor 1/1 eip 2000
> CPU 1 irqstacks, hard=c03ff000 soft=c03f7000
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 6379.20 BogoMIPS (lpj=12758409)
> CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
> 00004400 00000000 00000000
> CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
> 00004400 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: L3 cache: 1024K
> CPU: Physical Processor ID: 0
> CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080
> 00004400 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#1.
> CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU1: Thermal monitoring enabled
> CPU1: Intel(R) Xeon(TM) CPU 3.20GHz stepping 05
> Total of 2 processors activated (12767.48 BogoMIPS).
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> checking TSC synchronization across 2 CPUs: passed.
> Brought up 2 CPUs
> migration_cost=60
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: PCI BIOS revision 2.10 entry at 0xfd80c, last bus=2
> Setting up standard PCI resources
> ACPI: Subsystem revision 20060127
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> Boot video device is 0000:00:01.0
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Root Bridge [PCI1] (0000:01)
> PCI: Probing PCI hardware (bus 01)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
> ACPI: PCI Root Bridge [PCI2] (0000:02)
> PCI: Probing PCI hardware (bus 02)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
> ACPI: PCI Interrupt Link [LP00] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP01] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP02] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP03] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP04] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP05] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP06] (IRQs *9)
> ACPI: PCI Interrupt Link [LP07] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP08] (IRQs *3)
> ACPI: PCI Interrupt Link [LP09] (IRQs *4)
> ACPI: PCI Interrupt Link [LP0A] (IRQs *10)
> ACPI: PCI Interrupt Link [LP0B] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP0C] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP0D] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP0E] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP0F] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP10] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP11] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP12] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP13] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP14] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP15] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP16] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP17] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP18] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP19] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP1A] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP1B] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP1C] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP1D] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP1E] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LP1F] (IRQs) *0, disabled.
> ACPI: PCI Interrupt Link [LPUS] (IRQs *11)
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> NET: Registered protocol family 2
> IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
> TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
> TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
> TCP: Hash tables configured (established 262144 bind 65536)
> TCP reno registered
> Machine check exception polling timer started.
> highmem bounce pool size: 64 pages
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> Real Time Clock Driver v1.12ac
> Software Watchdog Timer: 0.07 initialized. soft_noboot=0
> soft_margin=60 sec (nowayout= 0)
> ipmi message handler version 39.0
> ipmi device interface
> IPMI System Interface driver.
> ipmi_si: Unable to find any System Interface(s)
> IPMI Watchdog: driver initialized
> tg3.c:v3.59 (June 8, 2006)
> ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 24 (level, low) -> IRQ 169
> eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)]
> (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:09:6b:a3:c0:4e
> eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
> eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
> ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 25 (level, low) -> IRQ 177
> eth1: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)]
> (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:09:6b:a3:c0:4f
> eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
> eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
> Fusion MPT base driver 3.03.09
> Copyright (c) 1999-2005 LSI Logic Corporation
> Fusion MPT SPI Host driver 3.03.09
> ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 22 (level, low) -> IRQ 185
> mptbase: Initiating ioc0 bringup
> ioc0: 53C1030: Capabilities={Initiator}
> scsi0 : ioc0: LSI53C1030, FwRev=01032821h, Ports=1, MaxQ=222, IRQ=185
>   Vendor: LSILOGIC  Model: 1030 IM       IM  Rev: 1000
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> SCSI device sda: 71020545 512-byte hdwr sectors (36363 MB)
> sda: Write Protect is off
> sda: Mode Sense: 03 00 00 08
> SCSI device sda: drive cache: write through
> SCSI device sda: 71020545 512-byte hdwr sectors (36363 MB)
> sda: Write Protect is off
> sda: Mode Sense: 03 00 00 08
> SCSI device sda: drive cache: write through
>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
> sd 0:0:0:0: Attached scsi disk sda
> sd 0:0:0:0: Attached scsi generic sg0 type 0
>   Vendor: IBM       Model: 25P3495a S320  1  Rev: 1
>   Type:   Processor                          ANSI SCSI revision: 02
>  target0:0:8: Beginning Domain Validation
>  target0:0:8: Ending Domain Validation
>  target0:0:8: asynchronous
>  0:0:8:0: Attached scsi generic sg1 type 3
>   Vendor: IBM-ESXS  Model: ST336607LC    FN  Rev: B25F
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> mptbase: ioc0: RAID STATUS CHANGE for VolumeID 0
> mptbase: ioc0:   volume is now optimal, enabled, quiesced
> mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 0
> mptbase: ioc0:   PhysDisk is now online, quiesced
> mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 0
> mptbase: ioc0:   PhysDisk is now online, quiesced
> mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 1
> mptbase: ioc0:   PhysDisk is now online, quiesced
>  target0:1:0: Beginning Domain Validation
>  target0:1:0: Ending Domain Validation
> mptbase: ioc0: RAID STATUS CHANGE for VolumeID 0
> mptbase: ioc0:   volume is now optimal, enabled
> mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 0
> mptbase: ioc0:   PhysDisk is now online
> mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 1
> mptbase: ioc0:   PhysDisk is now online
>  target0:1:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI WRFLOW PCOMP
> (6.25 ns, offset 63)
>  0:1:0:0: Attached scsi generic sg2 type 0
>   Vendor: IBM-ESXS  Model: ST336607LC    FN  Rev: B25F
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> mptbase: ioc0: RAID STATUS CHANGE for VolumeID 0
> mptbase: ioc0:   volume is now optimal, enabled, quiesced
> mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 0
> mptbase: ioc0:   PhysDisk is now online, quiesced
> mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 1
> mptbase: ioc0:   PhysDisk is now online, quiesced
>  target0:1:1: Beginning Domain Validation
>  target0:1:1: Ending Domain Validation
> mptbase: ioc0: RAID STATUS CHANGE for VolumeID 0
> mptbase: ioc0:   volume is now optimal, enabled
> mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 0
> mptbase: ioc0:   PhysDisk is now online
> mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 1
> mptbase: ioc0:   PhysDisk is now online
>  target0:1:1: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI WRFLOW PCOMP
> (6.25 ns, offset 63)
>  0:1:1:0: Attached scsi generic sg3 type 0
> Fusion MPT misc device (ioctl) driver 3.03.09
> mptctl: Registered with Fusion MPT base driver
> mptctl: /dev/mptctl @ (major,minor=10,220)
> USB Universal Host Controller Interface driver v3.0
> usbcore: registered new driver hiddev
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> ip_conntrack version 2.4 (8192 buckets, 65536 max) - 200 bytes per conntrack
> ip_tables: (C) 2000-2006 Netfilter Core Team
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
> All bugs added by David S. Miller <davem@redhat.com>
> Testing NMI watchdog ... OK.
> Starting balanced_irq
> Using IPI Shortcut mode
> EXT3-fs: INFO: recovery required on readonly filesystem.
> EXT3-fs: write access will be enabled during recovery.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 172k freed
> Adding 2096472k swap on /dev/sda3.  Priority:-1 extents:1 across:2096472k
> Adding 2096440k swap on /dev/sda5.  Priority:-2 extents:1 across:2096440k
> Adding 2096440k swap on /dev/sda6.  Priority:-3 extents:1 across:2096440k
> Adding 2096440k swap on /dev/sda7.  Priority:-4 extents:1 across:2096440k
> EXT3 FS on sda2, internal journal
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda1, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
> PM: Writing back config space on device 0000:02:01.0 at offset b (was
> 164714e4, writing 26f1014)
> PM: Writing back config space on device 0000:02:01.0 at offset 3 (was
> 4000, writing 4008)
> PM: Writing back config space on device 0000:02:01.0 at offset 2 (was
> 2000000, writing 2000002)
> PM: Writing back config space on device 0000:02:01.0 at offset 1 (was
> 2b00000, writing 2b00146)
> PM: Writing back config space on device 0000:02:01.0 at offset 0 (was
> 164714e4, writing 16a714e4)
> tg3: eth0: Link is up at 100 Mbps, full duplex.
> tg3: eth0: Flow control is off for TX and off for RX.
> piix4_smbus 0000:00:0f.0: Found 0000:00:0f.0 device
> piix4_smbus 0000:00:0f.0: Unusual config register value
> piix4_smbus 0000:00:0f.0: Try using fix_hstcfg=1 if you experience problems
> piix4_smbus 0000:00:0f.0: Illegal Interrupt configuration (or code out of date)!
> 
> 
> lspci -vvx :
> 
> 00:00.0 Host bridge: ServerWorks CNB20-HE Host Bridge (rev 33)
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 00: 66 11 14 00 00 00 00 00 33 00 00 06 10 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:00.1 Host bridge: ServerWorks CNB20-HE Host Bridge
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 00: 66 11 14 00 00 00 00 00 00 00 00 06 10 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:00.2 Host bridge: ServerWorks CNB20-HE Host Bridge
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 00: 66 11 14 00 00 00 00 00 00 00 00 06 10 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
> 27) (prog-if 00 [VGA])
>         Subsystem: IBM: Unknown device 0240
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (2000ns min), cache line size 08
>         Interrupt: pin A routed to IRQ 10
>         Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
>         Region 1: I/O ports at 2200 [size=256]
>         Region 2: Memory at febff000 (32-bit, non-prefetchable) [size=4K]
>         Expansion ROM at 88000000 [disabled] [size=128K]
>         Capabilities: [5c] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: 02 10 52 47 87 00 90 02 27 00 00 03 08 40 00 00
> 10: 00 00 00 fd 01 22 00 00 00 f0 bf fe 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 40 02
> 30: 00 00 00 00 5c 00 00 00 00 00 00 00 0a 01 08 00
> 
> 00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
>         Subsystem: ServerWorks CSB5 South Bridge
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 64
> 00: 66 11 01 02 47 01 00 22 93 00 00 06 00 40 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 01 02
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
> (prog-if 8a [Master SecP PriP])
>         Subsystem: ServerWorks CSB5 IDE Controller
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64, cache line size 08
>         Region 0: I/O ports at <ignored>
>         Region 1: I/O ports at <ignored>
>         Region 2: I/O ports at <ignored>
>         Region 3: I/O ports at <ignored>
>         Region 4: I/O ports at 0700 [size=16]
> 00: 66 11 12 02 55 01 00 02 93 8a 01 01 08 40 80 00
> 10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
> 20: 01 07 00 00 00 00 00 00 00 00 00 00 66 11 12 02
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05)
> (prog-if 10 [OHCI])
>         Subsystem: ServerWorks OSB4/CSB5 USB Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (20000ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at febfe000 (32-bit, non-prefetchable) [size=4K]
> 00: 66 11 20 02 57 01 80 02 05 10 03 0c 08 40 80 00
> 10: 00 e0 bf fe 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 20 02
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 50
> 
> 00:0f.3 ISA bridge: ServerWorks: Unknown device 0225
>         Subsystem: ServerWorks: Unknown device 0230
>         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
> 00: 66 11 25 02 44 01 00 02 00 00 01 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 30 02
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>         Capabilities: [60] PCI-X non-bridge device.
>                 Command: DPERE- ERO- RBC=0 OST=4
>                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
> 00: 66 11 01 01 42 01 30 22 05 00 00 06 00 40 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>         Capabilities: [60] PCI-X non-bridge device.
>                 Command: DPERE- ERO- RBC=0 OST=4
>                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
> 00: 66 11 01 01 42 01 30 22 05 00 00 06 00 40 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
> 
> 01:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
>         Subsystem: IBM: Unknown device 026d
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 72 (4250ns min, 4500ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 185
>         Region 0: I/O ports at 2300 [size=256]
>         Region 1: Memory at fbff0000 (64-bit, non-prefetchable) [size=64K]
>         Region 3: Memory at fbfe0000 (64-bit, non-prefetchable) [size=64K]
>         Expansion ROM at 88100000 [disabled] [size=1M]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [58] Message Signalled Interrupts: 64bit+
> Queue=0/0 Enable-
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [68] PCI-X non-bridge device.
>                 Command: DPERE- ERO- RBC=0 OST=0
>                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
> 00: 00 10 30 00 57 01 30 02 07 00 00 01 08 48 00 00
> 10: 01 23 00 00 04 00 ff fb 00 00 00 00 04 00 fe fb
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 6d 02
> 30: 00 00 00 00 50 00 00 00 00 00 00 00 09 01 11 12
> 
> 02:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X
> Gigabit Ethernet (rev 02)
>         Subsystem: IBM: Unknown device 026f
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (16000ns min), cache line size 08
>         Interrupt: pin A routed to IRQ 169
>         Region 0: Memory at f9ff0000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [40] PCI-X non-bridge device.
>                 Command: DPERE- ERO- RBC=2 OST=0
>                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
>         Capabilities: [48] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [50] Vital Product Data
>         Capabilities: [58] Message Signalled Interrupts: 64bit+
> Queue=0/3 Enable-
>                 Address: efcdfbf58aef7bf8  Data: bf9f
> 00: e4 14 a7 16 46 01 b0 02 02 00 00 02 08 40 00 00
> 10: 04 00 ff f9 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 6f 02
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 03 01 40 00
> 
> 02:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X
> Gigabit Ethernet (rev 02)
>         Subsystem: IBM: Unknown device 026f
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (16000ns min), cache line size 08
>         Interrupt: pin A routed to IRQ 177
>         Region 0: Memory at f9fe0000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [40] PCI-X non-bridge device.
>                 Command: DPERE- ERO+ RBC=0 OST=0
>                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
>         Capabilities: [48] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [50] Vital Product Data
>         Capabilities: [58] Message Signalled Interrupts: 64bit+
> Queue=0/3 Enable-
>                 Address: efb777dffdf9d784  Data: 7758
> 00: e4 14 a7 16 46 01 b0 02 02 00 00 02 08 40 00 00
> 10: 04 00 fe f9 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 6f 02
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 04 01 40 00
> 
> 
> The webservers DocumentRoot is on a NFS filesystem mounted with these
> options: rw,rsize=8192,wsize=8192,hard,intr
> 
> Any idea what caused this failure?
> Any other info I can provide that may help?
> 

