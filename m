Return-Path: <linux-kernel-owner+willy=40w.ods.org-S938048AbWLHLlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938048AbWLHLlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938050AbWLHLlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:41:36 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:39683 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938048AbWLHLle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:41:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=s8Iow3ClAsyxA5o4YaSAXORX1/6eu2WayxlyPs2/hvfwbRCcDR5qpRCN0EwlrFh7eKx/5BAuRaWUdUq47KKx9EBDuW9eZTzbwOGAe8XYsWj0KJomNWotsoyzvu+9mlaOGX+OabUJTQLI4b27T5OfssYVbOicT3L4erhzhVsOhrE=
Message-ID: <9a8748490612080341j4f0fa7b5l2f7272df0df55073@mail.gmail.com>
Date: Fri, 8 Dec 2006 12:41:33 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net
Subject: NFS related BUGs at shutdown - do_exit() + lock held at task exit time - 2.6.17.8
Cc: "Neil Brown" <neilb@suse.de>,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_30061_23356675.1165578093388"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_30061_23356675.1165578093388
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

I just got a kernel crash when shutting down a webserver. Nothing made
it to the logs, but I managed to get a photo of the dump on screen :
http://www.kernel.org/pub/linux/kernel/people/juhl/images/2.6.17.8-kernel-crash.jpg

The server is running 2.6.17.8

I've attached the .config

Here's dmesg output from a fresh boot :

Linux version 2.6.17.8-ws5 (jj@server) (gcc version 4.1.1 (Gentoo
4.1.1-r1)) #5 SMP Fri Dec 8 10:45:18 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d400 (usable)
 BIOS-e820: 000000000009d400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffdc180 (usable)
 BIOS-e820: 000000007ffdc180 - 000000007ffe0000 (ACPI data)
 BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 0009d540
On node 0 totalpages: 524252
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294876 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 IBM                                   ) @ 0x000fdfc0
ACPI: RSDT (v001 IBM    SERONYXP 0x00001000 IBM  0x45444f43) @ 0x7ffdff80
ACPI: FADT (v001 IBM    SERONYXP 0x00001000 IBM  0x45444f43) @ 0x7ffdff00
ACPI: MADT (v001 IBM    SERONYXP 0x00001000 IBM  0x45444f43) @ 0x7ffdfe80
ACPI: ASF! (v016 IBM    SERONYXP 0x00000001 IBM  0x45444f43) @ 0x7ffdfdc0
ACPI: DSDT (v001 IBM    SERTURQU 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x0e] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 14, version 17, address 0xfec00000, GSI 0-15
ACPI: IOAPIC (id[0x0d] address[0xfec01000] gsi_base[16])
IOAPIC[1]: apic_id 13, version 17, address 0xfec01000, GSI 16-31
ACPI: IOAPIC (id[0x0c] address[0xfec02000] gsi_base[32])
IOAPIC[2]: apic_id 12, version 17, address 0xfec02000, GSI 32-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ5 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Built 1 zonelists
Kernel command line: ro root=/dev/sda2 nmi_watchdog=1
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec01000)
mapped IOAPIC to ffffa000 (fec02000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c03fe000 soft=c03f6000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 3189.890 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2075264k/2097008k available (1862k kernel code, 20588k
reserved, 953k data, 172k init, 1179504k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6388.28 BogoMIPS (lpj=12776570)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080
00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 16k freed
CPU0: Intel(R) Xeon(TM) CPU 3.20GHz stepping 05
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c03ff000 soft=c03f7000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6379.20 BogoMIPS (lpj=12758409)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080
00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 3.20GHz stepping 05
Total of 2 processors activated (12767.48 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=60
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd80c, last bus=2
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:01.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Root Bridge [PCI1] (0000:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Root Bridge [PCI2] (0000:02)
PCI: Probing PCI hardware (bus 02)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
ACPI: PCI Interrupt Link [LP00] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP01] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP02] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP03] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP04] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP05] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP06] (IRQs *9)
ACPI: PCI Interrupt Link [LP07] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP08] (IRQs *3)
ACPI: PCI Interrupt Link [LP09] (IRQs *4)
ACPI: PCI Interrupt Link [LP0A] (IRQs *10)
ACPI: PCI Interrupt Link [LP0B] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP0C] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP0D] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP0E] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP0F] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP10] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP11] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP12] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP13] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP14] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP15] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP16] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP17] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP18] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP19] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP1A] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP1B] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP1C] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP1D] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP1E] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP1F] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LPUS] (IRQs *11)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Real Time Clock Driver v1.12ac
Software Watchdog Timer: 0.07 initialized. soft_noboot=0
soft_margin=60 sec (nowayout= 0)
ipmi message handler version 39.0
ipmi device interface
IPMI System Interface driver.
ipmi_si: Unable to find any System Interface(s)
IPMI Watchdog: driver initialized
tg3.c:v3.59 (June 8, 2006)
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 24 (level, low) -> IRQ 169
eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)]
(PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:09:6b:a3:c0:4e
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 25 (level, low) -> IRQ 177
eth1: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)]
(PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:09:6b:a3:c0:4f
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
Fusion MPT base driver 3.03.09
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.09
ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 22 (level, low) -> IRQ 185
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
scsi0 : ioc0: LSI53C1030, FwRev=01032821h, Ports=1, MaxQ=222, IRQ=185
  Vendor: LSILOGIC  Model: 1030 IM       IM  Rev: 1000
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 71020545 512-byte hdwr sectors (36363 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 08
SCSI device sda: drive cache: write through
SCSI device sda: 71020545 512-byte hdwr sectors (36363 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 08
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
  Vendor: IBM       Model: 25P3495a S320  1  Rev: 1
  Type:   Processor                          ANSI SCSI revision: 02
 target0:0:8: Beginning Domain Validation
 target0:0:8: Ending Domain Validation
 target0:0:8: asynchronous
 0:0:8:0: Attached scsi generic sg1 type 3
  Vendor: IBM-ESXS  Model: ST336607LC    FN  Rev: B25F
  Type:   Direct-Access                      ANSI SCSI revision: 03
mptbase: ioc0: RAID STATUS CHANGE for VolumeID 0
mptbase: ioc0:   volume is now optimal, enabled, quiesced
mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 0
mptbase: ioc0:   PhysDisk is now online, quiesced
mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 0
mptbase: ioc0:   PhysDisk is now online, quiesced
mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 1
mptbase: ioc0:   PhysDisk is now online, quiesced
 target0:1:0: Beginning Domain Validation
 target0:1:0: Ending Domain Validation
mptbase: ioc0: RAID STATUS CHANGE for VolumeID 0
mptbase: ioc0:   volume is now optimal, enabled
mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 0
mptbase: ioc0:   PhysDisk is now online
mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 1
mptbase: ioc0:   PhysDisk is now online
 target0:1:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI WRFLOW PCOMP
(6.25 ns, offset 63)
 0:1:0:0: Attached scsi generic sg2 type 0
  Vendor: IBM-ESXS  Model: ST336607LC    FN  Rev: B25F
  Type:   Direct-Access                      ANSI SCSI revision: 03
mptbase: ioc0: RAID STATUS CHANGE for VolumeID 0
mptbase: ioc0:   volume is now optimal, enabled, quiesced
mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 0
mptbase: ioc0:   PhysDisk is now online, quiesced
mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 1
mptbase: ioc0:   PhysDisk is now online, quiesced
 target0:1:1: Beginning Domain Validation
 target0:1:1: Ending Domain Validation
mptbase: ioc0: RAID STATUS CHANGE for VolumeID 0
mptbase: ioc0:   volume is now optimal, enabled
mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 0
mptbase: ioc0:   PhysDisk is now online
mptbase: ioc0: RAID STATUS CHANGE for PhysDisk 1
mptbase: ioc0:   PhysDisk is now online
 target0:1:1: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI WRFLOW PCOMP
(6.25 ns, offset 63)
 0:1:1:0: Attached scsi generic sg3 type 0
Fusion MPT misc device (ioctl) driver 3.03.09
mptctl: Registered with Fusion MPT base driver
mptctl: /dev/mptctl @ (major,minor=10,220)
USB Universal Host Controller Interface driver v3.0
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 200 bytes per conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Testing NMI watchdog ... OK.
Starting balanced_irq
Using IPI Shortcut mode
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k freed
Adding 2096472k swap on /dev/sda3.  Priority:-1 extents:1 across:2096472k
Adding 2096440k swap on /dev/sda5.  Priority:-2 extents:1 across:2096440k
Adding 2096440k swap on /dev/sda6.  Priority:-3 extents:1 across:2096440k
Adding 2096440k swap on /dev/sda7.  Priority:-4 extents:1 across:2096440k
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
PM: Writing back config space on device 0000:02:01.0 at offset b (was
164714e4, writing 26f1014)
PM: Writing back config space on device 0000:02:01.0 at offset 3 (was
4000, writing 4008)
PM: Writing back config space on device 0000:02:01.0 at offset 2 (was
2000000, writing 2000002)
PM: Writing back config space on device 0000:02:01.0 at offset 1 (was
2b00000, writing 2b00146)
PM: Writing back config space on device 0000:02:01.0 at offset 0 (was
164714e4, writing 16a714e4)
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
piix4_smbus 0000:00:0f.0: Found 0000:00:0f.0 device
piix4_smbus 0000:00:0f.0: Unusual config register value
piix4_smbus 0000:00:0f.0: Try using fix_hstcfg=1 if you experience problems
piix4_smbus 0000:00:0f.0: Illegal Interrupt configuration (or code out of date)!


lspci -vvx :

00:00.0 Host bridge: ServerWorks CNB20-HE Host Bridge (rev 33)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 66 11 14 00 00 00 00 00 33 00 00 06 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.1 Host bridge: ServerWorks CNB20-HE Host Bridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 66 11 14 00 00 00 00 00 00 00 00 06 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.2 Host bridge: ServerWorks CNB20-HE Host Bridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 66 11 14 00 00 00 00 00 00 00 00 06 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
27) (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 0240
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 2200 [size=256]
        Region 2: Memory at febff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 88000000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 52 47 87 00 90 02 27 00 00 03 08 40 00 00
10: 00 00 00 fd 01 22 00 00 00 f0 bf fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 40 02
30: 00 00 00 00 5c 00 00 00 00 00 00 00 0a 01 08 00

00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
        Subsystem: ServerWorks CSB5 South Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
00: 66 11 01 02 47 01 00 22 93 00 00 06 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 01 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
(prog-if 8a [Master SecP PriP])
        Subsystem: ServerWorks CSB5 IDE Controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 0700 [size=16]
00: 66 11 12 02 55 01 00 02 93 8a 01 01 08 40 80 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 01 07 00 00 00 00 00 00 00 00 00 00 66 11 12 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05)
(prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at febfe000 (32-bit, non-prefetchable) [size=4K]
00: 66 11 20 02 57 01 80 02 05 10 03 0c 08 40 80 00
10: 00 e0 bf fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 20 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 50

00:0f.3 ISA bridge: ServerWorks: Unknown device 0225
        Subsystem: ServerWorks: Unknown device 0230
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 66 11 25 02 44 01 00 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 30 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
00: 66 11 01 01 42 01 30 22 05 00 00 06 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00

00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
00: 66 11 01 01 42 01 30 22 05 00 00 06 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00

01:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
        Subsystem: IBM: Unknown device 026d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (4250ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 185
        Region 0: I/O ports at 2300 [size=256]
        Region 1: Memory at fbff0000 (64-bit, non-prefetchable) [size=64K]
        Region 3: Memory at fbfe0000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at 88100000 [disabled] [size=1M]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [68] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
00: 00 10 30 00 57 01 30 02 07 00 00 01 08 48 00 00
10: 01 23 00 00 04 00 ff fb 00 00 00 00 04 00 fe fb
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 6d 02
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 01 11 12

02:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X
Gigabit Ethernet (rev 02)
        Subsystem: IBM: Unknown device 026f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at f9ff0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=2 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
                Address: efcdfbf58aef7bf8  Data: bf9f
00: e4 14 a7 16 46 01 b0 02 02 00 00 02 08 40 00 00
10: 04 00 ff f9 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 6f 02
30: 00 00 00 00 40 00 00 00 00 00 00 00 03 01 40 00

02:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X
Gigabit Ethernet (rev 02)
        Subsystem: IBM: Unknown device 026f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at f9fe0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
                Address: efb777dffdf9d784  Data: 7758
00: e4 14 a7 16 46 01 b0 02 02 00 00 02 08 40 00 00
10: 04 00 fe f9 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 6f 02
30: 00 00 00 00 40 00 00 00 00 00 00 00 04 01 40 00


The webservers DocumentRoot is on a NFS filesystem mounted with these
options: rw,rsize=8192,wsize=8192,hard,intr

Any idea what caused this failure?
Any other info I can provide that may help?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_30061_23356675.1165578093388
Content-Type: application/octet-stream; name=.config
Content-Transfer-Encoding: base64
X-Attachment-Id: f_evgivd2k
Content-Disposition: attachment; filename=".config"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4xNy44CiMgRnJpIERlYyAgOCAxMDo0NTowNiAyMDA2CiMK
Q09ORklHX1g4Nl8zMj15CkNPTkZJR19TRU1BUEhPUkVfU0xFRVBFUlM9eQpDT05GSUdfWDg2PXkK
Q09ORklHX01NVT15CkNPTkZJR19HRU5FUklDX0lTQV9ETUE9eQpDT05GSUdfR0VORVJJQ19JT01B
UD15CkNPTkZJR19HRU5FUklDX0hXRUlHSFQ9eQpDT05GSUdfQVJDSF9NQVlfSEFWRV9QQ19GREM9
eQpDT05GSUdfRE1JPXkKCiMKIyBDb2RlIG1hdHVyaXR5IGxldmVsIG9wdGlvbnMKIwpDT05GSUdf
RVhQRVJJTUVOVEFMPXkKQ09ORklHX0xPQ0tfS0VSTkVMPXkKQ09ORklHX0lOSVRfRU5WX0FSR19M
SU1JVD0zMgoKIwojIEdlbmVyYWwgc2V0dXAKIwpDT05GSUdfTE9DQUxWRVJTSU9OPSItd3M1IgpD
T05GSUdfTE9DQUxWRVJTSU9OX0FVVE89eQpDT05GSUdfU1dBUD15CkNPTkZJR19TWVNWSVBDPXkK
IyBDT05GSUdfUE9TSVhfTVFVRVVFIGlzIG5vdCBzZXQKIyBDT05GSUdfQlNEX1BST0NFU1NfQUND
VCBpcyBub3Qgc2V0CkNPTkZJR19TWVNDVEw9eQojIENPTkZJR19BVURJVCBpcyBub3Qgc2V0CiMg
Q09ORklHX0lLQ09ORklHIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVU0VUUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1JFTEFZIGlzIG5vdCBzZXQKQ09ORklHX0lOSVRSQU1GU19TT1VSQ0U9IiIKIyBDT05G
SUdfVUlEMTYgaXMgbm90IHNldAojIENPTkZJR19WTTg2IGlzIG5vdCBzZXQKIyBDT05GSUdfQ0Nf
T1BUSU1JWkVfRk9SX1NJWkUgaXMgbm90IHNldApDT05GSUdfRU1CRURERUQ9eQpDT05GSUdfS0FM
TFNZTVM9eQojIENPTkZJR19LQUxMU1lNU19BTEwgaXMgbm90IHNldAojIENPTkZJR19LQUxMU1lN
U19FWFRSQV9QQVNTIGlzIG5vdCBzZXQKQ09ORklHX0hPVFBMVUc9eQpDT05GSUdfUFJJTlRLPXkK
Q09ORklHX0JVRz15CkNPTkZJR19FTEZfQ09SRT15CkNPTkZJR19CQVNFX0ZVTEw9eQpDT05GSUdf
RlVURVg9eQpDT05GSUdfRVBPTEw9eQpDT05GSUdfU0hNRU09eQpDT05GSUdfU0xBQj15CiMgQ09O
RklHX1RJTllfU0hNRU0gaXMgbm90IHNldApDT05GSUdfQkFTRV9TTUFMTD0wCiMgQ09ORklHX1NM
T0IgaXMgbm90IHNldAoKIwojIExvYWRhYmxlIG1vZHVsZSBzdXBwb3J0CiMKQ09ORklHX01PRFVM
RVM9eQpDT05GSUdfTU9EVUxFX1VOTE9BRD15CiMgQ09ORklHX01PRFVMRV9GT1JDRV9VTkxPQUQg
aXMgbm90IHNldAojIENPTkZJR19NT0RWRVJTSU9OUyBpcyBub3Qgc2V0CiMgQ09ORklHX01PRFVM
RV9TUkNWRVJTSU9OX0FMTCBpcyBub3Qgc2V0CkNPTkZJR19LTU9EPXkKQ09ORklHX1NUT1BfTUFD
SElORT15CgojCiMgQmxvY2sgbGF5ZXIKIwojIENPTkZJR19MQkQgaXMgbm90IHNldAojIENPTkZJ
R19CTEtfREVWX0lPX1RSQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfTFNGIGlzIG5vdCBzZXQKCiMK
IyBJTyBTY2hlZHVsZXJzCiMKQ09ORklHX0lPU0NIRURfTk9PUD15CkNPTkZJR19JT1NDSEVEX0FT
PXkKQ09ORklHX0lPU0NIRURfREVBRExJTkU9eQpDT05GSUdfSU9TQ0hFRF9DRlE9eQojIENPTkZJ
R19ERUZBVUxUX0FTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVGQVVMVF9ERUFETElORSBpcyBub3Qg
c2V0CkNPTkZJR19ERUZBVUxUX0NGUT15CiMgQ09ORklHX0RFRkFVTFRfTk9PUCBpcyBub3Qgc2V0
CkNPTkZJR19ERUZBVUxUX0lPU0NIRUQ9ImNmcSIKCiMKIyBQcm9jZXNzb3IgdHlwZSBhbmQgZmVh
dHVyZXMKIwpDT05GSUdfU01QPXkKQ09ORklHX1g4Nl9QQz15CiMgQ09ORklHX1g4Nl9FTEFOIGlz
IG5vdCBzZXQKIyBDT05GSUdfWDg2X1ZPWUFHRVIgaXMgbm90IHNldAojIENPTkZJR19YODZfTlVN
QVEgaXMgbm90IHNldAojIENPTkZJR19YODZfU1VNTUlUIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2
X0JJR1NNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9WSVNXUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1g4Nl9HRU5FUklDQVJDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9FUzcwMDAgaXMgbm90IHNl
dAojIENPTkZJR19NMzg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTTQ4NiBpcyBub3Qgc2V0CiMgQ09O
RklHX001ODYgaXMgbm90IHNldAojIENPTkZJR19NNTg2VFNDIGlzIG5vdCBzZXQKIyBDT05GSUdf
TTU4Nk1NWCBpcyBub3Qgc2V0CiMgQ09ORklHX002ODYgaXMgbm90IHNldAojIENPTkZJR19NUEVO
VElVTUlJIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBFTlRJVU1JSUkgaXMgbm90IHNldAojIENPTkZJ
R19NUEVOVElVTU0gaXMgbm90IHNldApDT05GSUdfTVBFTlRJVU00PXkKIyBDT05GSUdfTUs2IGlz
IG5vdCBzZXQKIyBDT05GSUdfTUs3IGlzIG5vdCBzZXQKIyBDT05GSUdfTUs4IGlzIG5vdCBzZXQK
IyBDT05GSUdfTUNSVVNPRSBpcyBub3Qgc2V0CiMgQ09ORklHX01FRkZJQ0VPTiBpcyBub3Qgc2V0
CiMgQ09ORklHX01XSU5DSElQQzYgaXMgbm90IHNldAojIENPTkZJR19NV0lOQ0hJUDIgaXMgbm90
IHNldAojIENPTkZJR19NV0lOQ0hJUDNEIGlzIG5vdCBzZXQKIyBDT05GSUdfTUdFT0RFR1gxIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUdFT0RFX0xYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUNZUklYSUlJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTVZJQUMzXzIgaXMgbm90IHNldAojIENPTkZJR19YODZfR0VO
RVJJQyBpcyBub3Qgc2V0CkNPTkZJR19YODZfQ01QWENIRz15CkNPTkZJR19YODZfWEFERD15CkNP
TkZJR19YODZfTDFfQ0FDSEVfU0hJRlQ9NwpDT05GSUdfUldTRU1fWENIR0FERF9BTEdPUklUSE09
eQpDT05GSUdfR0VORVJJQ19DQUxJQlJBVEVfREVMQVk9eQpDT05GSUdfWDg2X1dQX1dPUktTX09L
PXkKQ09ORklHX1g4Nl9JTlZMUEc9eQpDT05GSUdfWDg2X0JTV0FQPXkKQ09ORklHX1g4Nl9QT1BB
RF9PSz15CkNPTkZJR19YODZfQ01QWENIRzY0PXkKQ09ORklHX1g4Nl9HT09EX0FQSUM9eQpDT05G
SUdfWDg2X0lOVEVMX1VTRVJDT1BZPXkKQ09ORklHX1g4Nl9VU0VfUFBST19DSEVDS1NVTT15CkNP
TkZJR19YODZfVFNDPXkKIyBDT05GSUdfSFBFVF9USU1FUiBpcyBub3Qgc2V0CkNPTkZJR19OUl9D
UFVTPTgKQ09ORklHX1NDSEVEX1NNVD15CiMgQ09ORklHX1NDSEVEX01DIGlzIG5vdCBzZXQKQ09O
RklHX1BSRUVNUFRfTk9ORT15CiMgQ09ORklHX1BSRUVNUFRfVk9MVU5UQVJZIGlzIG5vdCBzZXQK
IyBDT05GSUdfUFJFRU1QVCBpcyBub3Qgc2V0CkNPTkZJR19QUkVFTVBUX0JLTD15CkNPTkZJR19Y
ODZfTE9DQUxfQVBJQz15CkNPTkZJR19YODZfSU9fQVBJQz15CkNPTkZJR19YODZfTUNFPXkKQ09O
RklHX1g4Nl9NQ0VfTk9ORkFUQUw9eQpDT05GSUdfWDg2X01DRV9QNFRIRVJNQUw9eQojIENPTkZJ
R19UT1NISUJBIGlzIG5vdCBzZXQKIyBDT05GSUdfSThLIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2
X1JFQk9PVEZJWFVQUyBpcyBub3Qgc2V0CkNPTkZJR19NSUNST0NPREU9bQpDT05GSUdfWDg2X01T
Uj1tCkNPTkZJR19YODZfQ1BVSUQ9bQoKIwojIEZpcm13YXJlIERyaXZlcnMKIwojIENPTkZJR19F
REQgaXMgbm90IHNldAojIENPTkZJR19ERUxMX1JCVSBpcyBub3Qgc2V0CiMgQ09ORklHX0RDREJB
UyBpcyBub3Qgc2V0CiMgQ09ORklHX05PSElHSE1FTSBpcyBub3Qgc2V0CkNPTkZJR19ISUdITUVN
NEc9eQojIENPTkZJR19ISUdITUVNNjRHIGlzIG5vdCBzZXQKQ09ORklHX1ZNU1BMSVRfM0c9eQoj
IENPTkZJR19WTVNQTElUXzNHX09QVCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZNU1BMSVRfMkcgaXMg
bm90IHNldAojIENPTkZJR19WTVNQTElUXzFHIGlzIG5vdCBzZXQKQ09ORklHX1BBR0VfT0ZGU0VU
PTB4QzAwMDAwMDAKQ09ORklHX0hJR0hNRU09eQpDT05GSUdfQVJDSF9GTEFUTUVNX0VOQUJMRT15
CkNPTkZJR19BUkNIX1NQQVJTRU1FTV9FTkFCTEU9eQpDT05GSUdfQVJDSF9TRUxFQ1RfTUVNT1JZ
X01PREVMPXkKQ09ORklHX1NFTEVDVF9NRU1PUllfTU9ERUw9eQpDT05GSUdfRkxBVE1FTV9NQU5V
QUw9eQojIENPTkZJR19ESVNDT05USUdNRU1fTUFOVUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BB
UlNFTUVNX01BTlVBTCBpcyBub3Qgc2V0CkNPTkZJR19GTEFUTUVNPXkKQ09ORklHX0ZMQVRfTk9E
RV9NRU1fTUFQPXkKQ09ORklHX1NQQVJTRU1FTV9TVEFUSUM9eQpDT05GSUdfU1BMSVRfUFRMT0NL
X0NQVVM9NAojIENPTkZJR19ISUdIUFRFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFUSF9FTVVMQVRJ
T04gaXMgbm90IHNldApDT05GSUdfTVRSUj15CiMgQ09ORklHX0VGSSBpcyBub3Qgc2V0CkNPTkZJ
R19JUlFCQUxBTkNFPXkKQ09ORklHX1JFR1BBUk09eQojIENPTkZJR19TRUNDT01QIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSFpfMTAwIGlzIG5vdCBzZXQKQ09ORklHX0haXzI1MD15CiMgQ09ORklHX0ha
XzEwMDAgaXMgbm90IHNldApDT05GSUdfSFo9MjUwCiMgQ09ORklHX0tFWEVDIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JBU0hfRFVNUCBpcyBub3Qgc2V0CkNPTkZJR19QSFlTSUNBTF9TVEFSVD0weDEw
MDAwMAojIENPTkZJR19IT1RQTFVHX0NQVSBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0VOQUJMRV9N
RU1PUllfSE9UUExVRz15CgojCiMgUG93ZXIgbWFuYWdlbWVudCBvcHRpb25zIChBQ1BJLCBBUE0p
CiMKQ09ORklHX1BNPXkKIyBDT05GSUdfUE1fTEVHQUNZIGlzIG5vdCBzZXQKIyBDT05GSUdfUE1f
REVCVUcgaXMgbm90IHNldAoKIwojIEFDUEkgKEFkdmFuY2VkIENvbmZpZ3VyYXRpb24gYW5kIFBv
d2VyIEludGVyZmFjZSkgU3VwcG9ydAojCkNPTkZJR19BQ1BJPXkKIyBDT05GSUdfQUNQSV9BQyBp
cyBub3Qgc2V0CiMgQ09ORklHX0FDUElfQkFUVEVSWSBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX0JV
VFRPTj1tCkNPTkZJR19BQ1BJX1ZJREVPPW0KIyBDT05GSUdfQUNQSV9IT1RLRVkgaXMgbm90IHNl
dAojIENPTkZJR19BQ1BJX0ZBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUElfUFJPQ0VTU09SIGlz
IG5vdCBzZXQKIyBDT05GSUdfQUNQSV9BU1VTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQSV9JQk0g
aXMgbm90IHNldAojIENPTkZJR19BQ1BJX1RPU0hJQkEgaXMgbm90IHNldApDT05GSUdfQUNQSV9C
TEFDS0xJU1RfWUVBUj0wCiMgQ09ORklHX0FDUElfREVCVUcgaXMgbm90IHNldApDT05GSUdfQUNQ
SV9FQz15CkNPTkZJR19BQ1BJX1BPV0VSPXkKQ09ORklHX0FDUElfU1lTVEVNPXkKIyBDT05GSUdf
WDg2X1BNX1RJTUVSIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQSV9DT05UQUlORVIgaXMgbm90IHNl
dAoKIwojIEFQTSAoQWR2YW5jZWQgUG93ZXIgTWFuYWdlbWVudCkgQklPUyBTdXBwb3J0CiMKIyBD
T05GSUdfQVBNIGlzIG5vdCBzZXQKCiMKIyBDUFUgRnJlcXVlbmN5IHNjYWxpbmcKIwojIENPTkZJ
R19DUFVfRlJFUSBpcyBub3Qgc2V0CgojCiMgQnVzIG9wdGlvbnMgKFBDSSwgUENNQ0lBLCBFSVNB
LCBNQ0EsIElTQSkKIwpDT05GSUdfUENJPXkKIyBDT05GSUdfUENJX0dPQklPUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1BDSV9HT01NQ09ORklHIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX0dPRElSRUNU
IGlzIG5vdCBzZXQKQ09ORklHX1BDSV9HT0FOWT15CkNPTkZJR19QQ0lfQklPUz15CkNPTkZJR19Q
Q0lfRElSRUNUPXkKQ09ORklHX1BDSV9NTUNPTkZJRz15CkNPTkZJR19QQ0lFUE9SVEJVUz15CkNP
TkZJR19QQ0lfTVNJPXkKIyBDT05GSUdfUENJX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX0lTQV9E
TUFfQVBJPXkKIyBDT05GSUdfSVNBIGlzIG5vdCBzZXQKIyBDT05GSUdfTUNBIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0N4MjAwIGlzIG5vdCBzZXQKCiMKIyBQQ0NBUkQgKFBDTUNJQS9DYXJkQnVzKSBz
dXBwb3J0CiMKIyBDT05GSUdfUENDQVJEIGlzIG5vdCBzZXQKCiMKIyBQQ0kgSG90cGx1ZyBTdXBw
b3J0CiMKIyBDT05GSUdfSE9UUExVR19QQ0kgaXMgbm90IHNldAoKIwojIEV4ZWN1dGFibGUgZmls
ZSBmb3JtYXRzCiMKQ09ORklHX0JJTkZNVF9FTEY9eQojIENPTkZJR19CSU5GTVRfQU9VVCBpcyBu
b3Qgc2V0CkNPTkZJR19CSU5GTVRfTUlTQz1tCgojCiMgTmV0d29ya2luZwojCkNPTkZJR19ORVQ9
eQoKIwojIE5ldHdvcmtpbmcgb3B0aW9ucwojCiMgQ09ORklHX05FVERFQlVHIGlzIG5vdCBzZXQK
Q09ORklHX1BBQ0tFVD15CkNPTkZJR19QQUNLRVRfTU1BUD15CkNPTkZJR19VTklYPXkKIyBDT05G
SUdfTkVUX0tFWSBpcyBub3Qgc2V0CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQX01VTFRJQ0FTVD15
CkNPTkZJR19JUF9BRFZBTkNFRF9ST1VURVI9eQpDT05GSUdfQVNLX0lQX0ZJQl9IQVNIPXkKIyBD
T05GSUdfSVBfRklCX1RSSUUgaXMgbm90IHNldApDT05GSUdfSVBfRklCX0hBU0g9eQojIENPTkZJ
R19JUF9NVUxUSVBMRV9UQUJMRVMgaXMgbm90IHNldApDT05GSUdfSVBfUk9VVEVfTVVMVElQQVRI
PXkKIyBDT05GSUdfSVBfUk9VVEVfTVVMVElQQVRIX0NBQ0hFRCBpcyBub3Qgc2V0CkNPTkZJR19J
UF9ST1VURV9WRVJCT1NFPXkKIyBDT05GSUdfSVBfUE5QIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X0lQSVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfSVBHUkUgaXMgbm90IHNldAojIENPTkZJR19J
UF9NUk9VVEUgaXMgbm90IHNldAojIENPTkZJR19BUlBEIGlzIG5vdCBzZXQKQ09ORklHX1NZTl9D
T09LSUVTPXkKIyBDT05GSUdfSU5FVF9BSCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfRVNQIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5FVF9JUENPTVAgaXMgbm90IHNldAojIENPTkZJR19JTkVUX1hG
Uk1fVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9UVU5ORUwgaXMgbm90IHNldApDT05G
SUdfSU5FVF9ESUFHPXkKQ09ORklHX0lORVRfVENQX0RJQUc9eQojIENPTkZJR19UQ1BfQ09OR19B
RFZBTkNFRCBpcyBub3Qgc2V0CkNPTkZJR19UQ1BfQ09OR19CSUM9eQoKIwojIElQOiBWaXJ0dWFs
IFNlcnZlciBDb25maWd1cmF0aW9uCiMKIyBDT05GSUdfSVBfVlMgaXMgbm90IHNldAojIENPTkZJ
R19JUFY2IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVDZfWEZSTV9UVU5ORUwgaXMgbm90IHNldAoj
IENPTkZJR19JTkVUNl9UVU5ORUwgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSPXkKIyBDT05G
SUdfTkVURklMVEVSX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBDb3JlIE5ldGZpbHRlciBDb25maWd1
cmF0aW9uCiMKQ09ORklHX05FVEZJTFRFUl9ORVRMSU5LPW0KIyBDT05GSUdfTkVURklMVEVSX05F
VExJTktfUVVFVUUgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX05FVExJTktfTE9HPW0KQ09O
RklHX05FVEZJTFRFUl9YVEFCTEVTPXkKQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfQ0xBU1NJ
Rlk9bQpDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9NQVJLPW0KQ09ORklHX05FVEZJTFRFUl9Y
VF9UQVJHRVRfTkZRVUVVRT1tCkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfQ09NTUVOVD1tCkNP
TkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfQ09OTlRSQUNLPW0KQ09ORklHX05FVEZJTFRFUl9YVF9N
QVRDSF9EQ0NQPW0KQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9FU1A9bQpDT05GSUdfTkVURklM
VEVSX1hUX01BVENIX0hFTFBFUj1tCkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfTEVOR1RIPW0K
Q09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9MSU1JVD1tCkNPTkZJR19ORVRGSUxURVJfWFRfTUFU
Q0hfTUFDPW0KQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9NQVJLPW0KQ09ORklHX05FVEZJTFRF
Ul9YVF9NQVRDSF9NVUxUSVBPUlQ9bQpDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1BLVFRZUEU9
bQpDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1JFQUxNPW0KQ09ORklHX05FVEZJTFRFUl9YVF9N
QVRDSF9TQ1RQPW0KQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9TVEFURT15CiMgQ09ORklHX05F
VEZJTFRFUl9YVF9NQVRDSF9TVFJJTkcgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX1hUX01B
VENIX1RDUE1TUz1tCgojCiMgSVA6IE5ldGZpbHRlciBDb25maWd1cmF0aW9uCiMKQ09ORklHX0lQ
X05GX0NPTk5UUkFDSz15CiMgQ09ORklHX0lQX05GX0NUX0FDQ1QgaXMgbm90IHNldAojIENPTkZJ
R19JUF9ORl9DT05OVFJBQ0tfTUFSSyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX0NPTk5UUkFD
S19FVkVOVFMgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9DVF9QUk9UT19TQ1RQIGlzIG5vdCBz
ZXQKQ09ORklHX0lQX05GX0ZUUD15CiMgQ09ORklHX0lQX05GX0lSQyBpcyBub3Qgc2V0CiMgQ09O
RklHX0lQX05GX05FVEJJT1NfTlMgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9URlRQIGlzIG5v
dCBzZXQKIyBDT05GSUdfSVBfTkZfQU1BTkRBIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfTkZfUFBU
UCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX0gzMjMgaXMgbm90IHNldAojIENPTkZJR19JUF9O
Rl9RVUVVRSBpcyBub3Qgc2V0CkNPTkZJR19JUF9ORl9JUFRBQkxFUz15CkNPTkZJR19JUF9ORl9N
QVRDSF9JUFJBTkdFPW0KQ09ORklHX0lQX05GX01BVENIX1RPUz1tCkNPTkZJR19JUF9ORl9NQVRD
SF9SRUNFTlQ9bQpDT05GSUdfSVBfTkZfTUFUQ0hfRUNOPW0KQ09ORklHX0lQX05GX01BVENIX0RT
Q1A9bQpDT05GSUdfSVBfTkZfTUFUQ0hfQUg9bQpDT05GSUdfSVBfTkZfTUFUQ0hfVFRMPW0KQ09O
RklHX0lQX05GX01BVENIX09XTkVSPW0KQ09ORklHX0lQX05GX01BVENIX0FERFJUWVBFPW0KQ09O
RklHX0lQX05GX01BVENIX0hBU0hMSU1JVD1tCkNPTkZJR19JUF9ORl9GSUxURVI9eQpDT05GSUdf
SVBfTkZfVEFSR0VUX1JFSkVDVD15CiMgQ09ORklHX0lQX05GX1RBUkdFVF9MT0cgaXMgbm90IHNl
dApDT05GSUdfSVBfTkZfVEFSR0VUX1VMT0c9eQojIENPTkZJR19JUF9ORl9UQVJHRVRfVENQTVNT
IGlzIG5vdCBzZXQKQ09ORklHX0lQX05GX05BVD15CkNPTkZJR19JUF9ORl9OQVRfTkVFREVEPXkK
IyBDT05GSUdfSVBfTkZfVEFSR0VUX01BU1FVRVJBREUgaXMgbm90IHNldApDT05GSUdfSVBfTkZf
VEFSR0VUX1JFRElSRUNUPXkKIyBDT05GSUdfSVBfTkZfVEFSR0VUX05FVE1BUCBpcyBub3Qgc2V0
CiMgQ09ORklHX0lQX05GX1RBUkdFVF9TQU1FIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfTkZfTkFU
X1NOTVBfQkFTSUMgaXMgbm90IHNldApDT05GSUdfSVBfTkZfTkFUX0ZUUD15CiMgQ09ORklHX0lQ
X05GX01BTkdMRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX1JBVyBpcyBub3Qgc2V0CiMgQ09O
RklHX0lQX05GX0FSUFRBQkxFUyBpcyBub3Qgc2V0CkNPTkZJR19JUF9ORl9NQVRDSF9DT05OTElN
SVQ9bQoKIwojIERDQ1AgQ29uZmlndXJhdGlvbiAoRVhQRVJJTUVOVEFMKQojCiMgQ09ORklHX0lQ
X0RDQ1AgaXMgbm90IHNldAoKIwojIFNDVFAgQ29uZmlndXJhdGlvbiAoRVhQRVJJTUVOVEFMKQoj
CiMgQ09ORklHX0lQX1NDVFAgaXMgbm90IHNldAoKIwojIFRJUEMgQ29uZmlndXJhdGlvbiAoRVhQ
RVJJTUVOVEFMKQojCiMgQ09ORklHX1RJUEMgaXMgbm90IHNldAojIENPTkZJR19BVE0gaXMgbm90
IHNldAojIENPTkZJR19CUklER0UgaXMgbm90IHNldApDT05GSUdfVkxBTl84MDIxUT15CiMgQ09O
RklHX0RFQ05FVCBpcyBub3Qgc2V0CiMgQ09ORklHX0xMQzIgaXMgbm90IHNldAojIENPTkZJR19J
UFggaXMgbm90IHNldAojIENPTkZJR19BVEFMSyBpcyBub3Qgc2V0CiMgQ09ORklHX1gyNSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xBUEIgaXMgbm90IHNldAojIENPTkZJR19ORVRfRElWRVJUIGlzIG5v
dCBzZXQKIyBDT05GSUdfRUNPTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfV0FOX1JPVVRFUiBpcyBu
b3Qgc2V0CgojCiMgUW9TIGFuZC9vciBmYWlyIHF1ZXVlaW5nCiMKIyBDT05GSUdfTkVUX1NDSEVE
IGlzIG5vdCBzZXQKQ09ORklHX05FVF9DTFNfUk9VVEU9eQoKIwojIE5ldHdvcmsgdGVzdGluZwoj
CiMgQ09ORklHX05FVF9QS1RHRU4gaXMgbm90IHNldAojIENPTkZJR19IQU1SQURJTyBpcyBub3Qg
c2V0CiMgQ09ORklHX0lSREEgaXMgbm90IHNldAojIENPTkZJR19CVCBpcyBub3Qgc2V0CiMgQ09O
RklHX0lFRUU4MDIxMSBpcyBub3Qgc2V0CgojCiMgRGV2aWNlIERyaXZlcnMKIwoKIwojIEdlbmVy
aWMgRHJpdmVyIE9wdGlvbnMKIwpDT05GSUdfU1RBTkRBTE9ORT15CkNPTkZJR19QUkVWRU5UX0ZJ
Uk1XQVJFX0JVSUxEPXkKQ09ORklHX0ZXX0xPQURFUj1tCiMgQ09ORklHX0RFQlVHX0RSSVZFUiBp
cyBub3Qgc2V0CgojCiMgQ29ubmVjdG9yIC0gdW5pZmllZCB1c2Vyc3BhY2UgPC0+IGtlcm5lbHNw
YWNlIGxpbmtlcgojCkNPTkZJR19DT05ORUNUT1I9bQoKIwojIE1lbW9yeSBUZWNobm9sb2d5IERl
dmljZXMgKE1URCkKIwojIENPTkZJR19NVEQgaXMgbm90IHNldAoKIwojIFBhcmFsbGVsIHBvcnQg
c3VwcG9ydAojCiMgQ09ORklHX1BBUlBPUlQgaXMgbm90IHNldAoKIwojIFBsdWcgYW5kIFBsYXkg
c3VwcG9ydAojCiMgQ09ORklHX1BOUCBpcyBub3Qgc2V0CgojCiMgQmxvY2sgZGV2aWNlcwojCkNP
TkZJR19CTEtfREVWX0ZEPW0KIyBDT05GSUdfQkxLX0NQUV9EQSBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19DUFFfQ0lTU19EQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfREFDOTYwIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkxLX0RFVl9VTUVNIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9D
T1dfQ09NTU9OIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfTE9PUD1tCiMgQ09ORklHX0JMS19E
RVZfQ1JZUFRPTE9PUCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfTkJEIGlzIG5vdCBzZXQK
IyBDT05GSUdfQkxLX0RFVl9TWDggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1VCIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkxLX0RFVl9SQU0gaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lO
SVRSRCBpcyBub3Qgc2V0CiMgQ09ORklHX0NEUk9NX1BLVENEVkQgaXMgbm90IHNldAojIENPTkZJ
R19BVEFfT1ZFUl9FVEggaXMgbm90IHNldAoKIwojIEFUQS9BVEFQSS9NRk0vUkxMIHN1cHBvcnQK
IwpDT05GSUdfSURFPW0KQ09ORklHX0JMS19ERVZfSURFPW0KCiMKIyBQbGVhc2Ugc2VlIERvY3Vt
ZW50YXRpb24vaWRlLnR4dCBmb3IgaGVscC9pbmZvIG9uIElERSBkcml2ZXMKIwojIENPTkZJR19C
TEtfREVWX0lERV9TQVRBIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9IRF9JREUgaXMgbm90
IHNldApDT05GSUdfQkxLX0RFVl9JREVESVNLPW0KQ09ORklHX0lERURJU0tfTVVMVElfTU9ERT15
CkNPTkZJR19CTEtfREVWX0lERUNEPW0KIyBDT05GSUdfQkxLX0RFVl9JREVUQVBFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkxLX0RFVl9JREVGTE9QUFkgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVW
X0lERVNDU0kgaXMgbm90IHNldApDT05GSUdfSURFX1RBU0tfSU9DVEw9eQoKIwojIElERSBjaGlw
c2V0IHN1cHBvcnQvYnVnZml4ZXMKIwojIENPTkZJR19JREVfR0VORVJJQyBpcyBub3Qgc2V0CiMg
Q09ORklHX0JMS19ERVZfQ01ENjQwIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURFUENJPXkK
Q09ORklHX0lERVBDSV9TSEFSRV9JUlE9eQojIENPTkZJR19CTEtfREVWX09GRkJPQVJEIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkxLX0RFVl9HRU5FUklDIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RF
Vl9PUFRJNjIxIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9SWjEwMDAgaXMgbm90IHNldApD
T05GSUdfQkxLX0RFVl9JREVETUFfUENJPXkKIyBDT05GSUdfQkxLX0RFVl9JREVETUFfRk9SQ0VE
IGlzIG5vdCBzZXQKQ09ORklHX0lERURNQV9QQ0lfQVVUTz15CiMgQ09ORklHX0lERURNQV9PTkxZ
RElTSyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQUVDNjJYWCBpcyBub3Qgc2V0CiMgQ09O
RklHX0JMS19ERVZfQUxJMTVYMyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQU1ENzRYWCBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQVRJSVhQIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxL
X0RFVl9DTUQ2NFggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1RSSUZMRVggaXMgbm90IHNl
dAojIENPTkZJR19CTEtfREVWX0NZODJDNjkzIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9D
UzU1MjAgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0NTNTUzMCBpcyBub3Qgc2V0CiMgQ09O
RklHX0JMS19ERVZfQ1M1NTM1IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9IUFQzNFggaXMg
bm90IHNldAojIENPTkZJR19CTEtfREVWX0hQVDM2NiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfU0MxMjAwIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfUElJWD1tCiMgQ09ORklHX0JMS19E
RVZfSVQ4MjFYIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9OUzg3NDE1IGlzIG5vdCBzZXQK
IyBDT05GSUdfQkxLX0RFVl9QREMyMDJYWF9PTEQgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVW
X1BEQzIwMlhYX05FVyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfU1ZXS1MgaXMgbm90IHNl
dAojIENPTkZJR19CTEtfREVWX1NJSU1BR0UgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1NJ
UzU1MTMgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1NMQzkwRTY2IGlzIG5vdCBzZXQKIyBD
T05GSUdfQkxLX0RFVl9UUk0yOTAgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1ZJQTgyQ1hY
WCBpcyBub3Qgc2V0CiMgQ09ORklHX0lERV9BUk0gaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9J
REVETUE9eQojIENPTkZJR19JREVETUFfSVZCIGlzIG5vdCBzZXQKQ09ORklHX0lERURNQV9BVVRP
PXkKIyBDT05GSUdfQkxLX0RFVl9IRCBpcyBub3Qgc2V0CgojCiMgU0NTSSBkZXZpY2Ugc3VwcG9y
dAojCkNPTkZJR19SQUlEX0FUVFJTPW0KQ09ORklHX1NDU0k9eQpDT05GSUdfU0NTSV9QUk9DX0ZT
PXkKCiMKIyBTQ1NJIHN1cHBvcnQgdHlwZSAoZGlzaywgdGFwZSwgQ0QtUk9NKQojCkNPTkZJR19C
TEtfREVWX1NEPXkKIyBDT05GSUdfQ0hSX0RFVl9TVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NIUl9E
RVZfT1NTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfU1IgaXMgbm90IHNldApDT05GSUdf
Q0hSX0RFVl9TRz15CiMgQ09ORklHX0NIUl9ERVZfU0NIIGlzIG5vdCBzZXQKCiMKIyBTb21lIFND
U0kgZGV2aWNlcyAoZS5nLiBDRCBqdWtlYm94KSBzdXBwb3J0IG11bHRpcGxlIExVTnMKIwojIENP
TkZJR19TQ1NJX01VTFRJX0xVTiBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX0NPTlNUQU5UUz15CiMg
Q09ORklHX1NDU0lfTE9HR0lORyBpcyBub3Qgc2V0CgojCiMgU0NTSSBUcmFuc3BvcnQgQXR0cmli
dXRlcwojCkNPTkZJR19TQ1NJX1NQSV9BVFRSUz15CiMgQ09ORklHX1NDU0lfRkNfQVRUUlMgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0lTQ1NJX0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9TQVNfQVRUUlMgaXMgbm90IHNldAoKIwojIFNDU0kgbG93LWxldmVsIGRyaXZlcnMKIwojIENP
TkZJR19JU0NTSV9UQ1AgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWXzNXX1hYWFhfUkFJRCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfM1dfOVhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
QUNBUkQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FBQ1JBSUQgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX0FJQzdYWFggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FJQzdYWFhfT0xEIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9BSUM3OVhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9EUFRf
STJPIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BRFZBTlNZUyBpcyBub3Qgc2V0CiMgQ09ORklH
X01FR0FSQUlEX05FV0dFTiBpcyBub3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX0xFR0FDWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX1NBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FU
QSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQlVTTE9HSUMgaXMgbm90IHNldAojIENPTkZJR19T
Q1NJX0RNWDMxOTFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9FQVRBIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9GVVRVUkVfRE9NQUlOIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9HRFRIIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JUFMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lOSVRJ
TyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSU5JQTEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfU1lNNTNDOFhYXzIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lQUiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfUUxPR0lDXzEyODAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMQV9GQyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTFBGQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfREMz
OTV4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9EQzM5MFQgaXMgbm90IHNldAojIENPTkZJR19T
Q1NJX05TUDMyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ERUJVRyBpcyBub3Qgc2V0CgojCiMg
TXVsdGktZGV2aWNlIHN1cHBvcnQgKFJBSUQgYW5kIExWTSkKIwojIENPTkZJR19NRCBpcyBub3Qg
c2V0CgojCiMgRnVzaW9uIE1QVCBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19GVVNJT049eQpDT05G
SUdfRlVTSU9OX1NQST15CiMgQ09ORklHX0ZVU0lPTl9GQyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZV
U0lPTl9TQVMgaXMgbm90IHNldApDT05GSUdfRlVTSU9OX01BWF9TR0U9MTI4CkNPTkZJR19GVVNJ
T05fQ1RMPXkKCiMKIyBJRUVFIDEzOTQgKEZpcmVXaXJlKSBzdXBwb3J0CiMKIyBDT05GSUdfSUVF
RTEzOTQgaXMgbm90IHNldAoKIwojIEkyTyBkZXZpY2Ugc3VwcG9ydAojCiMgQ09ORklHX0kyTyBp
cyBub3Qgc2V0CgojCiMgTmV0d29yayBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19ORVRERVZJQ0VT
PXkKIyBDT05GSUdfRFVNTVkgaXMgbm90IHNldAojIENPTkZJR19CT05ESU5HIGlzIG5vdCBzZXQK
IyBDT05GSUdfRVFVQUxJWkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfVFVOIGlzIG5vdCBzZXQKCiMK
IyBBUkNuZXQgZGV2aWNlcwojCiMgQ09ORklHX0FSQ05FVCBpcyBub3Qgc2V0CgojCiMgUEhZIGRl
dmljZSBzdXBwb3J0CiMKCiMKIyBFdGhlcm5ldCAoMTAgb3IgMTAwTWJpdCkKIwojIENPTkZJR19O
RVRfRVRIRVJORVQgaXMgbm90IHNldAoKIwojIEV0aGVybmV0ICgxMDAwIE1iaXQpCiMKIyBDT05G
SUdfQUNFTklDIGlzIG5vdCBzZXQKIyBDT05GSUdfREwySyBpcyBub3Qgc2V0CiMgQ09ORklHX0Ux
MDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfTlM4MzgyMCBpcyBub3Qgc2V0CiMgQ09ORklHX0hBTUFD
SEkgaXMgbm90IHNldAojIENPTkZJR19ZRUxMT1dGSU4gaXMgbm90IHNldAojIENPTkZJR19SODE2
OSBpcyBub3Qgc2V0CiMgQ09ORklHX1NJUzE5MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NLR0UgaXMg
bm90IHNldAojIENPTkZJR19TS1kyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0s5OExJTiBpcyBub3Qg
c2V0CkNPTkZJR19USUdPTjM9eQojIENPTkZJR19CTlgyIGlzIG5vdCBzZXQKCiMKIyBFdGhlcm5l
dCAoMTAwMDAgTWJpdCkKIwojIENPTkZJR19DSEVMU0lPX1QxIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVhHQiBpcyBub3Qgc2V0CiMgQ09ORklHX1MySU8gaXMgbm90IHNldAoKIwojIFRva2VuIFJpbmcg
ZGV2aWNlcwojCiMgQ09ORklHX1RSIGlzIG5vdCBzZXQKCiMKIyBXaXJlbGVzcyBMQU4gKG5vbi1o
YW1yYWRpbykKIwojIENPTkZJR19ORVRfUkFESU8gaXMgbm90IHNldAoKIwojIFdhbiBpbnRlcmZh
Y2VzCiMKIyBDT05GSUdfV0FOIGlzIG5vdCBzZXQKIyBDT05GSUdfRkRESSBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJUFBJIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBQIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0xJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9GQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NIQVBF
UiBpcyBub3Qgc2V0CkNPTkZJR19ORVRDT05TT0xFPW0KQ09ORklHX05FVFBPTEw9eQojIENPTkZJ
R19ORVRQT0xMX1JYIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUUE9MTF9UUkFQIGlzIG5vdCBzZXQK
Q09ORklHX05FVF9QT0xMX0NPTlRST0xMRVI9eQoKIwojIElTRE4gc3Vic3lzdGVtCiMKIyBDT05G
SUdfSVNETiBpcyBub3Qgc2V0CgojCiMgVGVsZXBob255IFN1cHBvcnQKIwojIENPTkZJR19QSE9O
RSBpcyBub3Qgc2V0CgojCiMgSW5wdXQgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdfSU5QVVQ9eQoK
IwojIFVzZXJsYW5kIGludGVyZmFjZXMKIwojIENPTkZJR19JTlBVVF9NT1VTRURFViBpcyBub3Qg
c2V0CiMgQ09ORklHX0lOUFVUX0pPWURFViBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1RTREVW
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfRVZERVYgaXMgbm90IHNldAojIENPTkZJR19JTlBV
VF9FVkJVRyBpcyBub3Qgc2V0CgojCiMgSW5wdXQgRGV2aWNlIERyaXZlcnMKIwpDT05GSUdfSU5Q
VVRfS0VZQk9BUkQ9eQpDT05GSUdfS0VZQk9BUkRfQVRLQkQ9eQojIENPTkZJR19LRVlCT0FSRF9T
VU5LQkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9MS0tCRCBpcyBub3Qgc2V0CiMgQ09O
RklHX0tFWUJPQVJEX1hUS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfTkVXVE9OIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfTU9VU0UgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9K
T1lTVElDSyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1RPVUNIU0NSRUVOIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5QVVRfTUlTQyBpcyBub3Qgc2V0CgojCiMgSGFyZHdhcmUgSS9PIHBvcnRzCiMK
Q09ORklHX1NFUklPPXkKQ09ORklHX1NFUklPX0k4MDQyPXkKIyBDT05GSUdfU0VSSU9fU0VSUE9S
VCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX0NUODJDNzEwIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VSSU9fUENJUFMyIGlzIG5vdCBzZXQKQ09ORklHX1NFUklPX0xJQlBTMj15CkNPTkZJR19TRVJJ
T19SQVc9bQojIENPTkZJR19HQU1FUE9SVCBpcyBub3Qgc2V0CgojCiMgQ2hhcmFjdGVyIGRldmlj
ZXMKIwpDT05GSUdfVlQ9eQpDT05GSUdfVlRfQ09OU09MRT15CkNPTkZJR19IV19DT05TT0xFPXkK
IyBDT05GSUdfU0VSSUFMX05PTlNUQU5EQVJEIGlzIG5vdCBzZXQKCiMKIyBTZXJpYWwgZHJpdmVy
cwojCkNPTkZJR19TRVJJQUxfODI1MD1tCkNPTkZJR19TRVJJQUxfODI1MF9QQ0k9bQpDT05GSUdf
U0VSSUFMXzgyNTBfTlJfVUFSVFM9NApDT05GSUdfU0VSSUFMXzgyNTBfUlVOVElNRV9VQVJUUz00
CiMgQ09ORklHX1NFUklBTF84MjUwX0VYVEVOREVEIGlzIG5vdCBzZXQKCiMKIyBOb24tODI1MCBz
ZXJpYWwgcG9ydCBzdXBwb3J0CiMKQ09ORklHX1NFUklBTF9DT1JFPW0KIyBDT05GSUdfU0VSSUFM
X0pTTSBpcyBub3Qgc2V0CkNPTkZJR19VTklYOThfUFRZUz15CiMgQ09ORklHX0xFR0FDWV9QVFlT
IGlzIG5vdCBzZXQKCiMKIyBJUE1JCiMKQ09ORklHX0lQTUlfSEFORExFUj15CkNPTkZJR19JUE1J
X1BBTklDX0VWRU5UPXkKIyBDT05GSUdfSVBNSV9QQU5JQ19TVFJJTkcgaXMgbm90IHNldApDT05G
SUdfSVBNSV9ERVZJQ0VfSU5URVJGQUNFPXkKQ09ORklHX0lQTUlfU0k9eQpDT05GSUdfSVBNSV9X
QVRDSERPRz15CkNPTkZJR19JUE1JX1BPV0VST0ZGPW0KCiMKIyBXYXRjaGRvZyBDYXJkcwojCkNP
TkZJR19XQVRDSERPRz15CiMgQ09ORklHX1dBVENIRE9HX05PV0FZT1VUIGlzIG5vdCBzZXQKCiMK
IyBXYXRjaGRvZyBEZXZpY2UgRHJpdmVycwojCkNPTkZJR19TT0ZUX1dBVENIRE9HPXkKIyBDT05G
SUdfQUNRVUlSRV9XRFQgaXMgbm90IHNldAojIENPTkZJR19BRFZBTlRFQ0hfV0RUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQUxJTTE1MzVfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxJTTcxMDFfV0RU
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0M1MjBfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfRVVST1RF
Q0hfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfSUI3MDBfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdf
SUJNQVNSIGlzIG5vdCBzZXQKIyBDT05GSUdfV0FGRVJfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdf
STYzMDBFU0JfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfSThYWF9UQ08gaXMgbm90IHNldAojIENP
TkZJR19TQzEyMDBfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfNjBYWF9XRFQgaXMgbm90IHNldAoj
IENPTkZJR19TQkM4MzYwX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVTVfV0RUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVzgzNjI3SEZfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfVzgzODc3Rl9XRFQg
aXMgbm90IHNldAojIENPTkZJR19XODM5NzdGX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ0ha
X1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NCQ19FUFhfQzNfV0FUQ0hET0cgaXMgbm90IHNldAoK
IwojIFBDSS1iYXNlZCBXYXRjaGRvZyBDYXJkcwojCiMgQ09ORklHX1BDSVBDV0FUQ0hET0cgaXMg
bm90IHNldAojIENPTkZJR19XRFRQQ0kgaXMgbm90IHNldAoKIwojIFVTQi1iYXNlZCBXYXRjaGRv
ZyBDYXJkcwojCiMgQ09ORklHX1VTQlBDV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19IV19S
QU5ET00gaXMgbm90IHNldApDT05GSUdfTlZSQU09bQpDT05GSUdfUlRDPXkKIyBDT05GSUdfRFRM
SyBpcyBub3Qgc2V0CiMgQ09ORklHX1IzOTY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQTElDT00g
aXMgbm90IHNldAojIENPTkZJR19TT05ZUEkgaXMgbm90IHNldAoKIwojIEZ0YXBlLCB0aGUgZmxv
cHB5IHRhcGUgZGV2aWNlIGRyaXZlcgojCiMgQ09ORklHX0FHUCBpcyBub3Qgc2V0CiMgQ09ORklH
X0RSTSBpcyBub3Qgc2V0CiMgQ09ORklHX01XQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1M1NTM1
X0dQSU8gaXMgbm90IHNldAojIENPTkZJR19SQVdfRFJJVkVSIGlzIG5vdCBzZXQKIyBDT05GSUdf
SFBFVCBpcyBub3Qgc2V0CiMgQ09ORklHX0hBTkdDSEVDS19USU1FUiBpcyBub3Qgc2V0CgojCiMg
VFBNIGRldmljZXMKIwojIENPTkZJR19UQ0dfVFBNIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVMQ0xP
Q0sgaXMgbm90IHNldAoKIwojIEkyQyBzdXBwb3J0CiMKQ09ORklHX0kyQz15CkNPTkZJR19JMkNf
Q0hBUkRFVj1tCgojCiMgSTJDIEFsZ29yaXRobXMKIwpDT05GSUdfSTJDX0FMR09CSVQ9bQojIENP
TkZJR19JMkNfQUxHT1BDRiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEdPUENBIGlzIG5vdCBz
ZXQKCiMKIyBJMkMgSGFyZHdhcmUgQnVzIHN1cHBvcnQKIwojIENPTkZJR19JMkNfQUxJMTUzNSBp
cyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEkxNTYzIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FM
STE1WDMgaXMgbm90IHNldAojIENPTkZJR19JMkNfQU1ENzU2IGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX0FNRDgxMTEgaXMgbm90IHNldAojIENPTkZJR19JMkNfSTgwMSBpcyBub3Qgc2V0CiMgQ09O
RklHX0kyQ19JODEwIGlzIG5vdCBzZXQKQ09ORklHX0kyQ19QSUlYND1tCiMgQ09ORklHX0kyQ19O
Rk9SQ0UyIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1BBUlBPUlRfTElHSFQgaXMgbm90IHNldAoj
IENPTkZJR19JMkNfUFJPU0FWQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NBVkFHRTQgaXMg
bm90IHNldAojIENPTkZJR19TQ3gyMDBfQUNCIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJUzU1
OTUgaXMgbm90IHNldAojIENPTkZJR19JMkNfU0lTNjMwIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJD
X1NJUzk2WCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TVFVCIGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19WSUFQUk8gaXMgbm90IHNldAojIENPTkZJ
R19JMkNfVk9PRE9PMyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19QQ0FfSVNBIGlzIG5vdCBzZXQK
CiMKIyBNaXNjZWxsYW5lb3VzIEkyQyBDaGlwIHN1cHBvcnQKIwojIENPTkZJR19TRU5TT1JTX0RT
MTMzNyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRFMxMzc0IGlzIG5vdCBzZXQKQ09ORklH
X1NFTlNPUlNfRUVQUk9NPW0KIyBDT05GSUdfU0VOU09SU19QQ0Y4NTc0IGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19QQ0E5NTM5IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QQ0Y4NTkx
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19NQVg2ODc1IGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX0RFQlVHX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdfQUxHTyBpcyBub3Qg
c2V0CiMgQ09ORklHX0kyQ19ERUJVR19CVVMgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdf
Q0hJUCBpcyBub3Qgc2V0CgojCiMgU1BJIHN1cHBvcnQKIwojIENPTkZJR19TUEkgaXMgbm90IHNl
dAojIENPTkZJR19TUElfTUFTVEVSIGlzIG5vdCBzZXQKCiMKIyBEYWxsYXMncyAxLXdpcmUgYnVz
CiMKIyBDT05GSUdfVzEgaXMgbm90IHNldAoKIwojIEhhcmR3YXJlIE1vbml0b3Jpbmcgc3VwcG9y
dAojCkNPTkZJR19IV01PTj15CiMgQ09ORklHX0hXTU9OX1ZJRCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfQURNMTAyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTAyNSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTAyNiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfQURNMTAzMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNOTI0MCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfQVNCMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BVFhQ
MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRFMxNjIxIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19GNzE4MDVGIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19GU0NIRVIgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0ZTQ1BPUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
R0w1MThTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfR0w1MjBTTSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfSVQ4NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE02MyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE03NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
TE03NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE03OCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfTE04MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE04MyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfTE04NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE04NyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfTE05MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYMTYxOSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfUEM4NzM2MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0lTNTU5
NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU01TQzQ3TTEgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX1NNU0M0N0IzOTcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1ZJQTY4NkEg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1ZUODIzMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfVzgzNzgxRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzNzkyRCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzTDc4NVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19XODM2MjdIRiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzNjI3RUhGIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19IREFQUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hXTU9OX0RFQlVH
X0NISVAgaXMgbm90IHNldAoKIwojIE1pc2MgZGV2aWNlcwojCiMgQ09ORklHX0lCTV9BU00gaXMg
bm90IHNldAoKIwojIE11bHRpbWVkaWEgZGV2aWNlcwojCiMgQ09ORklHX1ZJREVPX0RFViBpcyBu
b3Qgc2V0CkNPTkZJR19WSURFT19WNEwyPXkKCiMKIyBEaWdpdGFsIFZpZGVvIEJyb2FkY2FzdGlu
ZyBEZXZpY2VzCiMKIyBDT05GSUdfRFZCIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0RBQlVTQiBp
cyBub3Qgc2V0CgojCiMgR3JhcGhpY3Mgc3VwcG9ydAojCiMgQ09ORklHX0ZCIGlzIG5vdCBzZXQK
IyBDT05GSUdfVklERU9fU0VMRUNUIGlzIG5vdCBzZXQKCiMKIyBDb25zb2xlIGRpc3BsYXkgZHJp
dmVyIHN1cHBvcnQKIwpDT05GSUdfVkdBX0NPTlNPTEU9eQojIENPTkZJR19WR0FDT05fU09GVF9T
Q1JPTExCQUNLIGlzIG5vdCBzZXQKQ09ORklHX0RVTU1ZX0NPTlNPTEU9eQoKIwojIFNvdW5kCiMK
IyBDT05GSUdfU09VTkQgaXMgbm90IHNldAoKIwojIFVTQiBzdXBwb3J0CiMKQ09ORklHX1VTQl9B
UkNIX0hBU19IQ0Q9eQpDT05GSUdfVVNCX0FSQ0hfSEFTX09IQ0k9eQpDT05GSUdfVVNCX0FSQ0hf
SEFTX0VIQ0k9eQpDT05GSUdfVVNCPXkKIyBDT05GSUdfVVNCX0RFQlVHIGlzIG5vdCBzZXQKCiMK
IyBNaXNjZWxsYW5lb3VzIFVTQiBvcHRpb25zCiMKQ09ORklHX1VTQl9ERVZJQ0VGUz15CiMgQ09O
RklHX1VTQl9CQU5EV0lEVEggaXMgbm90IHNldAojIENPTkZJR19VU0JfRFlOQU1JQ19NSU5PUlMg
aXMgbm90IHNldAojIENPTkZJR19VU0JfU1VTUEVORCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9P
VEcgaXMgbm90IHNldAoKIwojIFVTQiBIb3N0IENvbnRyb2xsZXIgRHJpdmVycwojCkNPTkZJR19V
U0JfRUhDSV9IQ0Q9eQojIENPTkZJR19VU0JfRUhDSV9TUExJVF9JU08gaXMgbm90IHNldAojIENP
TkZJR19VU0JfRUhDSV9ST09UX0hVQl9UVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9JU1AxMTZY
X0hDRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PSENJX0hDRCBpcyBub3Qgc2V0CkNPTkZJR19V
U0JfVUhDSV9IQ0Q9eQojIENPTkZJR19VU0JfU0w4MTFfSENEIGlzIG5vdCBzZXQKCiMKIyBVU0Ig
RGV2aWNlIENsYXNzIGRyaXZlcnMKIwojIENPTkZJR19VU0JfQUNNIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1BSSU5URVIgaXMgbm90IHNldAoKIwojIE5PVEU6IFVTQl9TVE9SQUdFIGVuYWJsZXMg
U0NTSSwgYW5kICdTQ1NJIGRpc2sgc3VwcG9ydCcKIwoKIwojIG1heSBhbHNvIGJlIG5lZWRlZDsg
c2VlIFVTQl9TVE9SQUdFIEhlbHAgZm9yIG1vcmUgaW5mb3JtYXRpb24KIwpDT05GSUdfVVNCX1NU
T1JBR0U9bQojIENPTkZJR19VU0JfU1RPUkFHRV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TVE9SQUdFX0RBVEFGQUIgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9GUkVFQ09N
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfSVNEMjAwIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NUT1JBR0VfRFBDTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1VTQkFU
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfU0REUjA5IGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NUT1JBR0VfU0REUjU1IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfSlVN
UFNIT1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9BTEFVREEgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfTElCVVNVQUwgaXMgbm90IHNldAoKIwojIFVTQiBJbnB1dCBEZXZpY2VzCiMK
Q09ORklHX1VTQl9ISUQ9eQpDT05GSUdfVVNCX0hJRElOUFVUPXkKIyBDT05GSUdfVVNCX0hJRElO
UFVUX1BPV0VSQk9PSyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9GRiBpcyBub3Qgc2V0CkNPTkZJ
R19VU0JfSElEREVWPXkKIyBDT05GSUdfVVNCX0FJUFRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9XQUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BQ0VDQUQgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfS0JUQUIgaXMgbm90IHNldAojIENPTkZJR19VU0JfUE9XRVJNQVRFIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1RPVUNIU0NSRUVOIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1lFQUxJTksg
aXMgbm90IHNldAojIENPTkZJR19VU0JfWFBBRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BVElf
UkVNT1RFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0FUSV9SRU1PVEUyIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX0tFWVNQQU5fUkVNT1RFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0FQUExFVE9V
Q0ggaXMgbm90IHNldAoKIwojIFVTQiBJbWFnaW5nIGRldmljZXMKIwojIENPTkZJR19VU0JfTURD
ODAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX01JQ1JPVEVLIGlzIG5vdCBzZXQKCiMKIyBVU0Ig
TmV0d29yayBBZGFwdGVycwojCiMgQ09ORklHX1VTQl9DQVRDIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0tBV0VUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9QRUdBU1VTIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX1JUTDgxNTAgaXMgbm90IHNldAojIENPTkZJR19VU0JfVVNCTkVUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX01PTiBpcyBub3Qgc2V0CgojCiMgVVNCIHBvcnQgZHJpdmVycwojCgoj
CiMgVVNCIFNlcmlhbCBDb252ZXJ0ZXIgc3VwcG9ydAojCkNPTkZJR19VU0JfU0VSSUFMPW0KQ09O
RklHX1VTQl9TRVJJQUxfR0VORVJJQz15CiMgQ09ORklHX1VTQl9TRVJJQUxfQUlSUFJJTUUgaXMg
bm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0FOWURBVEEgaXMgbm90IHNldAojIENPTkZJR19V
U0JfU0VSSUFMX0FSSzMxMTYgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0JFTEtJTiBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfV0hJVEVIRUFUIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NFUklBTF9ESUdJX0FDQ0VMRVBPUlQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VS
SUFMX0NQMjEwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfQ1lQUkVTU19NOCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfRU1QRUcgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U0VSSUFMX0ZURElfU0lPIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9GVU5TT0ZUIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9WSVNPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TRVJJQUxfSVBBUSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfSVIgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX0VER0VQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NF
UklBTF9FREdFUE9SVF9USSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfR0FSTUlOIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9JUFcgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U0VSSUFMX0tFWVNQQU5fUERBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFO
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LTFNJIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9LT0JJTF9TQ1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX01DVF9V
MjMyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9OQVZNQU4gaXMgbm90IHNldApDT05G
SUdfVVNCX1NFUklBTF9QTDIzMDM9bQojIENPTkZJR19VU0JfU0VSSUFMX0hQNFggaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX1NBRkUgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFM
X1RJIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9DWUJFUkpBQ0sgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfU0VSSUFMX1hJUkNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxf
T01OSU5FVCBpcyBub3Qgc2V0CgojCiMgVVNCIE1pc2NlbGxhbmVvdXMgZHJpdmVycwojCiMgQ09O
RklHX1VTQl9FTUk2MiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9FTUkyNiBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9BVUVSU1dBTEQgaXMgbm90IHNldAojIENPTkZJR19VU0JfUklPNTAwIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX0xFR09UT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MQ0Qg
aXMgbm90IHNldAojIENPTkZJR19VU0JfTEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0NZVEhF
Uk0gaXMgbm90IHNldAojIENPTkZJR19VU0JfUEhJREdFVEtJVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9QSElER0VUU0VSVk8gaXMgbm90IHNldAojIENPTkZJR19VU0JfSURNT1VTRSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TSVNVU0JWR0EgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEQgaXMg
bm90IHNldAojIENPTkZJR19VU0JfVEVTVCBpcyBub3Qgc2V0CgojCiMgVVNCIERTTCBtb2RlbSBz
dXBwb3J0CiMKCiMKIyBVU0IgR2FkZ2V0IFN1cHBvcnQKIwojIENPTkZJR19VU0JfR0FER0VUIGlz
IG5vdCBzZXQKCiMKIyBNTUMvU0QgQ2FyZCBzdXBwb3J0CiMKIyBDT05GSUdfTU1DIGlzIG5vdCBz
ZXQKCiMKIyBMRUQgZGV2aWNlcwojCiMgQ09ORklHX05FV19MRURTIGlzIG5vdCBzZXQKCiMKIyBM
RUQgZHJpdmVycwojCgojCiMgTEVEIFRyaWdnZXJzCiMKCiMKIyBJbmZpbmlCYW5kIHN1cHBvcnQK
IwojIENPTkZJR19JTkZJTklCQU5EIGlzIG5vdCBzZXQKCiMKIyBFREFDIC0gZXJyb3IgZGV0ZWN0
aW9uIGFuZCByZXBvcnRpbmcgKFJBUykgKEVYUEVSSU1FTlRBTCkKIwojIENPTkZJR19FREFDIGlz
IG5vdCBzZXQKCiMKIyBSZWFsIFRpbWUgQ2xvY2sKIwojIENPTkZJR19SVENfQ0xBU1MgaXMgbm90
IHNldAoKIwojIEZpbGUgc3lzdGVtcwojCkNPTkZJR19FWFQyX0ZTPW0KIyBDT05GSUdfRVhUMl9G
U19YQVRUUiBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVDJfRlNfWElQIGlzIG5vdCBzZXQKQ09ORklH
X0VYVDNfRlM9eQojIENPTkZJR19FWFQzX0ZTX1hBVFRSIGlzIG5vdCBzZXQKQ09ORklHX0pCRD15
CiMgQ09ORklHX0pCRF9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFSVNFUkZTX0ZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfSkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRlNfUE9TSVhfQUNMIGlz
IG5vdCBzZXQKIyBDT05GSUdfWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfT0NGUzJfRlMgaXMg
bm90IHNldAojIENPTkZJR19NSU5JWF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JPTUZTX0ZTIGlz
IG5vdCBzZXQKQ09ORklHX0lOT1RJRlk9eQojIENPTkZJR19RVU9UQSBpcyBub3Qgc2V0CiMgQ09O
RklHX0ROT1RJRlkgaXMgbm90IHNldAojIENPTkZJR19BVVRPRlNfRlMgaXMgbm90IHNldAojIENP
TkZJR19BVVRPRlM0X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVTRV9GUyBpcyBub3Qgc2V0Cgoj
CiMgQ0QtUk9NL0RWRCBGaWxlc3lzdGVtcwojCkNPTkZJR19JU085NjYwX0ZTPW0KQ09ORklHX0pP
TElFVD15CiMgQ09ORklHX1pJU09GUyBpcyBub3Qgc2V0CkNPTkZJR19VREZfRlM9bQpDT05GSUdf
VURGX05MUz15CgojCiMgRE9TL0ZBVC9OVCBGaWxlc3lzdGVtcwojCkNPTkZJR19GQVRfRlM9bQpD
T05GSUdfTVNET1NfRlM9bQpDT05GSUdfVkZBVF9GUz1tCkNPTkZJR19GQVRfREVGQVVMVF9DT0RF
UEFHRT04NTAKQ09ORklHX0ZBVF9ERUZBVUxUX0lPQ0hBUlNFVD0iaXNvODg1OS0xNSIKIyBDT05G
SUdfTlRGU19GUyBpcyBub3Qgc2V0CgojCiMgUHNldWRvIGZpbGVzeXN0ZW1zCiMKQ09ORklHX1BS
T0NfRlM9eQpDT05GSUdfUFJPQ19LQ09SRT15CkNPTkZJR19TWVNGUz15CkNPTkZJR19UTVBGUz15
CiMgQ09ORklHX0hVR0VUTEJGUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hVR0VUTEJfUEFHRSBpcyBu
b3Qgc2V0CkNPTkZJR19SQU1GUz15CkNPTkZJR19DT05GSUdGU19GUz1tCgojCiMgTWlzY2VsbGFu
ZW91cyBmaWxlc3lzdGVtcwojCiMgQ09ORklHX0FERlNfRlMgaXMgbm90IHNldAojIENPTkZJR19B
RkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSEZT
UExVU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JFRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19C
RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19FRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19DUkFN
RlMgaXMgbm90IHNldAojIENPTkZJR19WWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFBGU19G
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1FOWDRGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU1Zf
RlMgaXMgbm90IHNldAojIENPTkZJR19VRlNfRlMgaXMgbm90IHNldAoKIwojIE5ldHdvcmsgRmls
ZSBTeXN0ZW1zCiMKQ09ORklHX05GU19GUz15CkNPTkZJR19ORlNfVjM9eQojIENPTkZJR19ORlNf
VjNfQUNMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTX1Y0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZT
X0RJUkVDVElPIGlzIG5vdCBzZXQKQ09ORklHX05GU0Q9bQpDT05GSUdfTkZTRF9WMz15CiMgQ09O
RklHX05GU0RfVjNfQUNMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTRF9WNCBpcyBub3Qgc2V0CiMg
Q09ORklHX05GU0RfVENQIGlzIG5vdCBzZXQKQ09ORklHX0xPQ0tEPXkKQ09ORklHX0xPQ0tEX1Y0
PXkKQ09ORklHX0VYUE9SVEZTPW0KQ09ORklHX05GU19DT01NT049eQpDT05GSUdfU1VOUlBDPXkK
IyBDT05GSUdfUlBDU0VDX0dTU19LUkI1IGlzIG5vdCBzZXQKIyBDT05GSUdfUlBDU0VDX0dTU19T
UEtNMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NNQl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NJRlMg
aXMgbm90IHNldAojIENPTkZJR19OQ1BfRlMgaXMgbm90IHNldAojIENPTkZJR19DT0RBX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfQUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfOVBfRlMgaXMgbm90
IHNldAoKIwojIFBhcnRpdGlvbiBUeXBlcwojCiMgQ09ORklHX1BBUlRJVElPTl9BRFZBTkNFRCBp
cyBub3Qgc2V0CkNPTkZJR19NU0RPU19QQVJUSVRJT049eQoKIwojIE5hdGl2ZSBMYW5ndWFnZSBT
dXBwb3J0CiMKQ09ORklHX05MUz1tCkNPTkZJR19OTFNfREVGQVVMVD0iaXNvODg1OS0xNSIKQ09O
RklHX05MU19DT0RFUEFHRV80Mzc9bQojIENPTkZJR19OTFNfQ09ERVBBR0VfNzM3IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzc3NSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQ09ERVBB
R0VfODUwPW0KIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MiBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19DT0RFUEFHRV84NTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODU3IGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19D
T0RFUEFHRV84NjEgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV84NjQgaXMgbm90IHNldApDT05GSUdfTkxTX0NPREVQQUdFXzg2NT1tCiMgQ09ORklHX05M
U19DT0RFUEFHRV84NjYgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY5IGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzkzNiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19D
T0RFUEFHRV85NTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTMyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzk0OSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV84NzQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV84IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzEyNTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0Vf
MTI1MSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQVNDSUk9bQpDT05GSUdfTkxTX0lTTzg4NTlfMT1t
CiMgQ09ORklHX05MU19JU084ODU5XzIgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8z
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNCBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19JU084ODU5XzUgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV82IGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0lTTzg4NTlfNyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5Xzkg
aXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xMyBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19JU084ODU5XzE0IGlzIG5vdCBzZXQKQ09ORklHX05MU19JU084ODU5XzE1PW0KIyBDT05GSUdf
TkxTX0tPSThfUiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19LT0k4X1UgaXMgbm90IHNldApDT05G
SUdfTkxTX1VURjg9bQoKIwojIEluc3RydW1lbnRhdGlvbiBTdXBwb3J0CiMKIyBDT05GSUdfUFJP
RklMSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfS1BST0JFUyBpcyBub3Qgc2V0CgojCiMgS2VybmVs
IGhhY2tpbmcKIwojIENPTkZJR19QUklOVEtfVElNRSBpcyBub3Qgc2V0CkNPTkZJR19NQUdJQ19T
WVNSUT15CkNPTkZJR19ERUJVR19LRVJORUw9eQpDT05GSUdfTE9HX0JVRl9TSElGVD0xNQpDT05G
SUdfREVURUNUX1NPRlRMT0NLVVA9eQojIENPTkZJR19TQ0hFRFNUQVRTIGlzIG5vdCBzZXQKIyBD
T05GSUdfREVCVUdfU0xBQiBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19NVVRFWEVTPXkKIyBDT05G
SUdfREVCVUdfU1BJTkxPQ0sgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19TUElOTE9DS19TTEVF
UCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0tPQkpFQ1QgaXMgbm90IHNldAojIENPTkZJR19E
RUJVR19ISUdITUVNIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0JVR1ZFUkJPU0U9eQojIENPTkZJ
R19ERUJVR19JTkZPIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfRlMgaXMgbm90IHNldAojIENP
TkZJR19ERUJVR19WTSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZSQU1FX1BPSU5URVIgaXMgbm90IHNl
dApDT05GSUdfVU5XSU5EX0lORk89eQpDT05GSUdfRk9SQ0VEX0lOTElOSU5HPXkKIyBDT05GSUdf
UkNVX1RPUlRVUkVfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0VBUkxZX1BSSU5USyBpcyBub3Qg
c2V0CiMgQ09ORklHX0RFQlVHX1NUQUNLT1ZFUkZMT1cgaXMgbm90IHNldAojIENPTkZJR19ERUJV
R19TVEFDS19VU0FHRSBpcyBub3Qgc2V0CkNPTkZJR19TVEFDS19CQUNLVFJBQ0VfQ09MUz0yCiMg
Q09ORklHX0RFQlVHX1BBR0VBTExPQyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1JPREFUQSBp
cyBub3Qgc2V0CkNPTkZJR180S1NUQUNLUz15CkNPTkZJR19YODZfRklORF9TTVBfQ09ORklHPXkK
Q09ORklHX1g4Nl9NUFBBUlNFPXkKQ09ORklHX0RPVUJMRUZBVUxUPXkKCiMKIyBTZWN1cml0eSBv
cHRpb25zCiMKIyBDT05GSUdfS0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZIGlzIG5v
dCBzZXQKCiMKIyBDcnlwdG9ncmFwaGljIG9wdGlvbnMKIwojIENPTkZJR19DUllQVE8gaXMgbm90
IHNldAoKIwojIEhhcmR3YXJlIGNyeXB0byBkZXZpY2VzCiMKCiMKIyBMaWJyYXJ5IHJvdXRpbmVz
CiMKIyBDT05GSUdfQ1JDX0NDSVRUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDMTYgaXMgbm90IHNl
dAojIENPTkZJR19DUkMzMiBpcyBub3Qgc2V0CiMgQ09ORklHX0xJQkNSQzMyQyBpcyBub3Qgc2V0
CkNPTkZJR19HRU5FUklDX0hBUkRJUlFTPXkKQ09ORklHX0dFTkVSSUNfSVJRX1BST0JFPXkKQ09O
RklHX0dFTkVSSUNfUEVORElOR19JUlE9eQpDT05GSUdfWDg2X1NNUD15CkNPTkZJR19YODZfSFQ9
eQpDT05GSUdfWDg2X0JJT1NfUkVCT09UPXkKQ09ORklHX1g4Nl9UUkFNUE9MSU5FPXkKQ09ORklH
X0tUSU1FX1NDQUxBUj15Cg==
------=_Part_30061_23356675.1165578093388--
