Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbVKPTgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbVKPTgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbVKPTgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:36:14 -0500
Received: from mgrava.tizianodinca.com ([195.47.199.19]:13491 "EHLO
	mail2.rhx.it") by vger.kernel.org with ESMTP id S1030454AbVKPTgN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:36:13 -0500
Date: Wed, 16 Nov 2005 20:36:08 +0100
From: Michele Baldessari <michele-lists@pupazzo.org>
To: linux-kernel@vger.kernel.org
Subject: OOPS - 2.6.14.2 | 2.6.15-rc1-git4 - qla2xxx
Message-ID: <20051116193608.GA8500@michele.pupazzo.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Operating-System: GNU/Linux (i686)
X-URL: http://michele.pupazzo.org
X-GPG-Keynumber: 240B4C3D
X-GPG-Fingerprint: E4B4 4826 0E0C BF0D 3935  ED35 A1F6 EE94 240B 4C3D
X-Uptime: 19:13:08 up 2 min,  3 users,  load average: 1.25, 0.50, 0.18
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

As per subject I get an OOPS on bootup with qla2xx cards using 2.6.14.2
or 2.6.15-rc1-git4. Description follows:

I have an IBM xseries server (x346) which connects to a fiber-channel HG80 Compaq 
Storage system using QLA2312 cards. 
The only kernel I ever got to work on this setup is an ancient 
2.4.21-20.EL (on a Red Hat Enterprise Linux system). All other kernels (that didn't oops)
are only able to see the partition on the storage as a generic scsi (sg*) 
and not as a scsi disk.

So I tried to switch one of these machines over to a recent vanilla kernel (2.6.14.2)
and I reproduceably get the following oops on bootup (full dmesg is below). 2.6.13.4 
doesn't oops, but as any other version, excluding the above-mentioned 2.4.21-20.EL, it isn't 
able to see the disk partitions)

<snip>
qla2300 0000:03:03.0: Topology - (F_Port), Host Loop address 0xffff
BUG: soft lockup detected on CPU#1!

Pid: 1233, comm:             modprobe
EIP: 0060:[<c0110c84>] CPU: 1
EIP is at delay_pmtmr+0x14/0x20
 EFLAGS: 00000283    Not tainted  (2.6.14.2)
EAX: e29847d0 EBX: 00007c06 ECX: e297cd50 EDX: 00000027
ESI: 00000000 EDI: f7a34278 EBP: f8a5c000 DS: 007b ES: 007b
CR0: 8005003b CR2: b7e81000 CR3: 1fead000 CR4: 000006d0
 [<c01b60b2>] __delay+0x12/0x20
 [<f8b3296c>] qla2x00_mailbox_command+0x1dc/0x540 [qla2xxx]
 [<f8b33362>] qla2x00_issue_iocb+0x72/0xb0 [qla2xxx]
 [<f8b33f65>] qla2x00_login_fabric+0xd5/0x160 [qla2xxx]
 [<f8b30003>] qla2x00_configure_local_loop+0x163/0x340 [qla2xxx]
 [<f8b37fa4>] qla2x00_rff_id+0xc4/0x110 [qla2xxx]
 [<f8b30859>] qla2x00_configure_fabric+0x349/0x390 [qla2xxx]
 [<c011d5e7>] printk+0x17/0x20
 [<f8b2fdf0>] qla2x00_configure_loop+0xf0/0x1a0 [qla2xxx]
 [<f8b2d676>] qla2x00_initialize_adapter+0x1a6/0x290 [qla2xxx]
 [<f8b2bbb8>] qla2x00_probe_one+0x448/0xb00 [qla2xxx]
 [<c0118bc0>] default_wake_function+0x0/0x20
 [<c012e2a2>] queue_work+0x52/0x70
 [<c012e090>] __call_usermodehelper+0x0/0x70
 [<c012e1ce>] call_usermodehelper_keys+0xce/0xe0
 [<c012e090>] __call_usermodehelper+0x0/0x70
 [<c01bf3e9>] pci_call_probe+0x19/0x20
 [<c01bf455>] __pci_device_probe+0x65/0x80
 [<c01bf49f>] pci_device_probe+0x2f/0x50
 [<c02141fb>] driver_probe_device+0x3b/0xb0
 [<c02142f0>] __driver_attach+0x0/0x60
 [<c0214340>] __driver_attach+0x50/0x60
 [<c0213749>] bus_for_each_dev+0x69/0x80
 [<c0214375>] driver_attach+0x25/0x30
 [<c02142f0>] __driver_attach+0x0/0x60
 [<c0213c9d>] bus_add_driver+0x8d/0xe0
 [<c01bf76b>] pci_register_driver+0x7b/0xa0
 [<f898900f>] qla2300_init+0xf/0x11 [qla2300]
 [<c013a6b4>] sys_init_module+0x144/0x1e0
 [<c0102fa9>] syscall_call+0x7/0xb

I saw some fixes to qla2xxx went in 2.6.15-rc1, so tried that one as well, but the trace is
pretty much the same:

qla2300 0000:03:03.0: Found an ISP2312, irq 217, iobase 0xf8a56000
qla2300 0000:03:03.0: Configuring PCI space...
qla2300 0000:03:03.0: Configure NVRAM parameters...
qla2300 0000:03:03.0: Verifying loaded RISC code...
qla2300 0000:03:03.0: Waiting for LIP to complete...
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
qla2300 0000:03:03.0: LIP reset occured (0).
qla2300 0000:03:03.0: LOOP UP detected (1 Gbps).
qla2300 0000:03:03.0: Topology - (F_Port), Host Loop address 0xffff
BUG: soft lockup detected on CPU#0!

Pid: 1235, comm:             modprobe
EIP: 0060:[<c010f417>] CPU: 0
EIP is at delay_pmtmr+0xb/0x15
 EFLAGS: 00000287    Not tainted  (2.6.15-rc1-git4)
EAX: 00000118 EBX: 00007c31 ECX: 989312a0 EDX: 00000027
ESI: 00000020 EDI: 00000020 EBP: f79a62a8 DS: 007b ES: 007b
CR0: 8005003b CR2: b7ddd000 CR3: 37a56000 CR4: 000006d0
 [<c01b87be>] __delay+0x12/0x16
 [<f8b06557>] qla2x00_mailbox_command+0x1c9/0x540 [qla2xxx]
 [<f8b06ef9>] qla2x00_issue_iocb+0x6f/0xa7 [qla2xxx]
 [<f8b04cf3>] qla2x00_device_resync+0x116/0x27e [qla2xxx]
 [<f8b0b581>] qla2x00_rff_id+0xc1/0x103 [qla2xxx]
 [<f8b044bd>] qla2x00_configure_fabric+0x33e/0x37c [qla2xxx]
 [<c011b494>] printk+0x17/0x1b
 [<f8b08a77>] qla2x00_marker+0x5c/0x72 [qla2xxx]
 [<f8b03af3>] qla2x00_configure_loop+0xec/0x179 [qla2xxx]
 [<f8b013d4>] qla2x00_initialize_adapter+0x1a4/0x279 [qla2xxx]
 [<f8affa1b>] qla2x00_probe_one+0x41b/0xa67 [qla2xxx]
 [<c0116eac>] default_wake_function+0x0/0x12
 [<c0116eac>] default_wake_function+0x0/0x12
 [<c012ac4d>] queue_work+0x4d/0x5f
 [<c012ab8b>] call_usermodehelper_keys+0xba/0xc3
 [<c012aa6c>] __call_usermodehelper+0x0/0x65
 [<c01c1140>] pci_call_probe+0x19/0x1d
 [<c01c11a3>] __pci_device_probe+0x5f/0x6d
 [<c01c11e0>] pci_device_probe+0x2f/0x4d
 [<c02126d0>] driver_probe_device+0x3b/0xb1
 [<c02127b7>] __driver_attach+0x0/0x4b
 [<c0212800>] __driver_attach+0x49/0x4b
 [<c0211d85>] bus_for_each_dev+0x62/0x78
 [<c0212828>] driver_attach+0x26/0x2a
 [<c02127b7>] __driver_attach+0x0/0x4b
 [<c0212219>] bus_add_driver+0x83/0xd8
 [<c01c1452>] __pci_register_driver+0x78/0xa0
 [<f8a51017>] qla2300_init+0x17/0x1b [qla2300]
 [<c0136116>] sys_init_module+0x14c/0x1e2
 [<c0102ced>] syscall_call+0x7/0xb
scsi2 : qla2xxx
qla2300 0000:03:03.0:
 QLogic Fibre Channel HBA Driver: 8.01.03-k
  QLogic QLA2340 - 133MHz PCI-X to 2Gb FC, Single Channel
  ISP2312: PCI-X (133 MHz) @ 0000:03:03.0 hdma-, host#=2, fw=3.03.18 IPX
scsi: unknown device type 31
  Vendor: DEC       Model: HSG<6>md: md0 stopped.
80             Rev: V86F
  Type:   Unknown                            ANSI SCSI revision: 02
md: bind<sdb2>
  Vendor: DEC       Model: HSG80             Rev: V86F
  Type:   Direct-Access                      ANSI SCSI 


Here's lspci output (for 2.6.14.2):

0000:00:00.0 Host bridge: Intel Corp. Server Memory Controller Hub (rev 0c)
0000:00:00.1 ff00: Intel Corp. Memory Controller Hub Error Reporting Register (rev 0c)
0000:00:02.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port A0 (rev 0c)
0000:00:04.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port B0 (rev 0c)
0000:00:05.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port B1 (rev 0c)
0000:00:06.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port C0 (rev 0c)
0000:00:08.0 System peripheral: Intel Corp. Memory Controller Hub Extended Configuration Registers (rev 0c)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
0000:01:06.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
0000:02:00.0 PCI bridge: Intel Corp. PCI Bridge Hub A (rev 09)
0000:02:00.2 PCI bridge: Intel Corp. PCI Bridge Hub B (rev 09)
0000:03:03.0 Fibre Channel: QLogic Corp. QLA2312 Fibre Channel Adapter (rev 02)
0000:04:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)
0000:05:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 11)
0000:06:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 11)
0000:07:00.0 PCI bridge: Intel Corp. 80332 [Dobson] I/O processor (rev 07)
0000:07:00.2 PCI bridge: Intel Corp. 80332 [Dobson] I/O processor (rev 07)
0000:08:07.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
0000:08:07.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)


And here's the full dmesg:

Linux version 2.6.14.2 (root@samba1) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 SMP Wed Nov 16 17:44:32 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cffcca00 (usable)
 BIOS-e820: 00000000cffcca00 - 00000000cffd0000 (ACPI data)
 BIOS-e820: 00000000cffd0000 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
Warning only 4GB will be used.
Use a PAE enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 0009dd40
On node 0 totalpages: 1048576
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 819200 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000fdfb0
ACPI: XSDT (v001 IBM    SERONYXP 0x00001001 IBM  0x45444f43) @ 0xcffcff00
ACPI: FADT (v002 IBM    SERONYXP 0x00001001 IBM  0x45444f43) @ 0xcffcfe40
ACPI: MADT (v001 IBM    SERONYXP 0x00001001 IBM  0x45444f43) @ 0xcffcfd80
ACPI: MCFG (v001 IBM    SERONYXP 0x00001001 IBM  0x45444f43) @ 0xcffcfd40
ACPI: SSDT (v002 IBM    YETA0    0x00001000 INTL 0x20041203) @ 0xcffcfa40
ACPI: DSDT (v002 IBM    SERTURQU 0x00001000 INTL 0x20041203) @ 0x00000000
ACPI: PM-Timer IO Port: 0x588
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x0e] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 14, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x0d] address[0xfec84000] gsi_base[24])
IOAPIC[1]: apic_id 13, version 32, address 0xfec84000, GSI 24-47
ACPI: IOAPIC (id[0x0c] address[0xfec84400] gsi_base[48])
IOAPIC[2]: apic_id 12, version 32, address 0xfec84400, GSI 48-71
ACPI: IOAPIC (id[0x0b] address[0xfec80000] gsi_base[72])
IOAPIC[3]: apic_id 11, version 32, address 0xfec80000, GSI 72-95
ACPI: IOAPIC (id[0x0a] address[0xfec80400] gsi_base[96])
IOAPIC[4]: apic_id 10, version 32, address 0xfec80400, GSI 96-119
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 5 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at d4000000 (gap: d0000000:2ec00000)
Built 1 zonelists
Kernel command line: root=/dev/md0 ro noacpi emergency
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec84000)
mapped IOAPIC to ffffa000 (fec84400)
mapped IOAPIC to ffff9000 (fec80000)
mapped IOAPIC to ffff8000 (fec80400)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3200.699 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3364260k/4194304k available (1694k kernel code, 41960k reserved, 544k data, 200k init, 2490160k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6409.79 BogoMIPS (lpj=12819592)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 3.20GHz stepping 01
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6401.06 BogoMIPS (lpj=12802138)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 3.20GHz stepping 01
Booting processor 2/6 eip 2000
Initializing CPU#2
Calibrating delay using timer specific routine.. 6400.88 BogoMIPS (lpj=12801764)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (24) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 3.20GHz stepping 01
Booting processor 3/7 eip 2000
Initializing CPU#3
Calibrating delay using timer specific routine.. 6400.84 BogoMIPS (lpj=12801684)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (24) available
CPU3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 3.20GHz stepping 01
Total of 4 processors activated (25612.58 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 4 CPUs: passed.
softlockup thread 0 started up.
softlockup thread 1 started up.
softlockup thread 2 started up.
Brought up 4 CPUs
softlockup thread 3 started up.
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 5332k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd6fe, last bus=9
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0580-05ff claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0400-043f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:01:06.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.PCI8._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.PCI9._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI5.PCI6._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI5.PCI7._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIS._PRT]
ACPI: PCI Interrupt Link [LP00] (IRQs *3)
ACPI: PCI Interrupt Link [LP01] (IRQs *11)
ACPI: PCI Interrupt Link [LP02] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP03] (IRQs *5)
ACPI: PCI Interrupt Link [LP04] (IRQs *11)
ACPI: PCI Interrupt Link [LP05] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP06] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP07] (IRQs *7)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 1 of device 0000:00:00.0
pnp: 00:00: ioport range 0x520-0x53f has been reserved
pnp: 00:00: ioport range 0x540-0x547 has been reserved
pnp: 00:0c: ioport range 0x400-0x43f has been reserved
PCI: Bridge: 0000:02:00.0
  IO window: 4000-4fff
  MEM window: dd000000-deffffff
  PREFETCH window: d4000000-d40fffff
PCI: Bridge: 0000:02:00.2
  IO window: 5000-5fff
  MEM window: db000000-dcffffff
  PREFETCH window: d4100000-d41fffff
PCI: Bridge: 0000:00:02.0
  IO window: 4000-5fff
  MEM window: db000000-deffffff
  PREFETCH window: d4000000-d41fffff
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: d9000000-daffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: d7000000-d8ffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:07:00.0
  IO window: 6000-6fff
  MEM window: d5000000-d6ffffff
  PREFETCH window: d4200000-d42fffff
PCI: Bridge: 0000:07:00.2
  IO window: 7000-ffff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: 6000-ffff
  MEM window: d5000000-d6ffffff
  PREFETCH window: d4200000-d42fffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: f8000000-f8ffffff
  PREFETCH window: f0000000-f7ffffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:02:00.0 to 64
PCI: Setting latency timer of device 0000:02:00.2 to 64
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:04.0 to 64
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:05.0 to 64
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:07:00.0 to 64
PCI: Setting latency timer of device 0000:07:00.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x64,0x60 irq 1,12
PNP: PS/2 controller has invalid data port 0x64; using default 0x60
PNP: PS/2 controller has invalid command port 0x60; using default 0x64
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
input: AT Translated Set 2 keyboard on isa0060/serio0
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 8
NET: Registered protocol family 20
Using IPI Shortcut mode
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 5332KiB [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 200k freed
NET: Registered protocol family 1
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.39
md: raid1 personality registered as nr 3
SCSI subsystem initialized
ACPI: PCI Interrupt 0000:08:07.0[A] -> GSI 27 (level, low) -> IRQ 177
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs

ACPI: PCI Interrupt 0000:08:07.1[B] -> GSI 24 (level, low) -> IRQ 185
scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs

 target1:0:0: asynchronous.
  Vendor: IBM-ESXS  Model: PYH073C3-ETS10FN  Rev: RXQE
  Type:   Direct-Access                      ANSI SCSI revision: 04
scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
 target1:0:0: Beginning Domain Validation
 target1:0:0: wide asynchronous.
 target1:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU RDSTRM RTI WRFLOW PCOMP (6.25 ns, offset 80)
 target1:0:0: Ending Domain Validation
 target1:0:1: asynchronous.
  Vendor: IBM-ESXS  Model: PYH073C3-ETS10FN  Rev: RXQE
  Type:   Direct-Access                      ANSI SCSI revision: 04
scsi1:A:1:0: Tagged Queuing enabled.  Depth 32
 target1:0:1: Beginning Domain Validation
 target1:0:1: wide asynchronous.
 target1:0:1: FAST-160 WIDE SCSI 320.0 MB/s DT IU RDSTRM RTI WRFLOW PCOMP (6.25 ns, offset 80)
 target1:0:1: Ending Domain Validation
  Vendor: IBM       Model: 25R5170a S320  0  Rev: 1   
  Type:   Processor                          ANSI SCSI revision: 02
 target1:0:8: asynchronous.
 target1:0:8: Beginning Domain Validation
 target1:0:8: Ending Domain Validation
ACPI: CPU3 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
ACPI: CPU2 (power states: C1[C1])
ACPI: CPU0 (power states: C1[C1])
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 169, io base 0x00002200
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 193, io base 0x00002600
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:1d.7: irq 201, io mem 0xf9000000
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
usbcore: registered new driver usbkbd
drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
Console: switching to colour frame buffer device 80x30
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 143374000 512-byte hdwr sectors (73407 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 143374000 512-byte hdwr sectors (73407 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 96 (level, low) -> IRQ 209
e100: eth0: e100_probe: addr 0xdcfff000, irq 209, MAC addr 00:0E:0C:74:22:B7
tg3.c:v3.42 (Oct 3, 2005)
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:05:00.0 to 64
eth1: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:0d:60:6f:3e:3a
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[1] 
eth1: dma_rwctrl[76180000]
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:06:00.0 to 64
eth2: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:0d:60:6f:3e:3b
eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[1] 
eth2: dma_rwctrl[76180000]
md: raid0 personality registered as nr 2
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  5118.000 MB/sec
raid5: using function: pIII_sse (5118.000 MB/sec)
md: raid5 personality registered as nr 4
Generic RTC Driver v1.07
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
hw_random hardware driver 1.0.0 loaded
input: PC Speaker
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
QLogic Fibre Channel HBA Driver
PCI: Enabling device 0000:03:03.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 72 (level, low) -> IRQ 217
qla2300 0000:03:03.0: Found an ISP2312, irq 217, iobase 0xf8a5c000
qla2300 0000:03:03.0: Configuring PCI space...
qla2300 0000:03:03.0: Configure NVRAM parameters...
qla2300 0000:03:03.0: Verifying loaded RISC code...
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
qla2300 0000:03:03.0: Waiting for LIP to complete...
qla2300 0000:03:03.0: LIP reset occured (84e4).
qla2300 0000:03:03.0: LOOP UP detected (1 Gbps).
qla2300 0000:03:03.0: Topology - (F_Port), Host Loop address 0xffff
BUG: soft lockup detected on CPU#1!

Pid: 1233, comm:             modprobe
EIP: 0060:[<c0110c84>] CPU: 1
EIP is at delay_pmtmr+0x14/0x20
 EFLAGS: 00000283    Not tainted  (2.6.14.2)
EAX: e29847d0 EBX: 00007c06 ECX: e297cd50 EDX: 00000027
ESI: 00000000 EDI: f7a34278 EBP: f8a5c000 DS: 007b ES: 007b
CR0: 8005003b CR2: b7e81000 CR3: 1fead000 CR4: 000006d0
 [<c01b60b2>] __delay+0x12/0x20
 [<f8b3296c>] qla2x00_mailbox_command+0x1dc/0x540 [qla2xxx]
 [<f8b33362>] qla2x00_issue_iocb+0x72/0xb0 [qla2xxx]
 [<f8b33f65>] qla2x00_login_fabric+0xd5/0x160 [qla2xxx]
 [<f8b30003>] qla2x00_configure_local_loop+0x163/0x340 [qla2xxx]
 [<f8b37fa4>] qla2x00_rff_id+0xc4/0x110 [qla2xxx]
 [<f8b30859>] qla2x00_configure_fabric+0x349/0x390 [qla2xxx]
 [<c011d5e7>] printk+0x17/0x20
 [<f8b2fdf0>] qla2x00_configure_loop+0xf0/0x1a0 [qla2xxx]
 [<f8b2d676>] qla2x00_initialize_adapter+0x1a6/0x290 [qla2xxx]
 [<f8b2bbb8>] qla2x00_probe_one+0x448/0xb00 [qla2xxx]
 [<c0118bc0>] default_wake_function+0x0/0x20
 [<c012e2a2>] queue_work+0x52/0x70
 [<c012e090>] __call_usermodehelper+0x0/0x70
 [<c012e1ce>] call_usermodehelper_keys+0xce/0xe0
 [<c012e090>] __call_usermodehelper+0x0/0x70
 [<c01bf3e9>] pci_call_probe+0x19/0x20
 [<c01bf455>] __pci_device_probe+0x65/0x80
 [<c01bf49f>] pci_device_probe+0x2f/0x50
 [<c02141fb>] driver_probe_device+0x3b/0xb0
 [<c02142f0>] __driver_attach+0x0/0x60
 [<c0214340>] __driver_attach+0x50/0x60
 [<c0213749>] bus_for_each_dev+0x69/0x80
 [<c0214375>] driver_attach+0x25/0x30
 [<c02142f0>] __driver_attach+0x0/0x60
 [<c0213c9d>] bus_add_driver+0x8d/0xe0
 [<c01bf76b>] pci_register_driver+0x7b/0xa0
 [<f898900f>] qla2300_init+0xf/0x11 [qla2300]
 [<c013a6b4>] sys_init_module+0x144/0x1e0
 [<c0102fa9>] syscall_call+0x7/0xb
scsi2 : qla2xxx
qla2300 0000:03:03.0: 
 QLogic Fibre Channel HBA Driver: 8.01.00-k
  QLogic QLA2340 - 133MHz PCI-X to 2Gb FC, Single Channel
  ISP2312: PCI-X (133 MHz) @ 0000:03:03.0 hdma-, host#=2, fw=3.03.15 IPX
scsi: unknown device type 31
  Vendor: DEC       Model: HSG80             Rev: V86F
  Type:   Unknown                            ANSI SCSI revision: 02
  Vendor: DEC       Model: HSG80             Rev: V86F
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdc: 284389029 512-byte hdwr sectors (145607 MB)
SCSI device sdc: drive cache: write through
md: md0 stopped.
SCSI device sdc: 284389029 512-byte hdwr sectors (145607 MB)
SCSI device sdc: drive cache: write through
 sdc: sdc3
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 9
md: bind<sdb2>
md: bind<sda2>
raid1: raid set md0 active with 2 out of 2 mirrors
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
EXT3 FS on md0, internal journal

Here are the .config files I used (not attaching it since it's 16k):

http://michele.pupazzo.org/files/config-2.6.14.2.gz
http://michele.pupazzo.org/files/config-2.6.15-rc1-git4.gz

My loaded module list:
ipv6                  270560  16
generic                 5764  0 [permanent]
piix                   11780  0 [permanent]
ide_generic             2432  0 [permanent]
ext3                  145672  4
jbd                    61204  1 ext3
mbcache                11012  1 ext3
qla2300               125824  0
qla2xxx               130396  1 qla2300
firmware_class         11648  1 qla2xxx
scsi_transport_fc      30208  1 qla2xxx
dm_mod                 60056  0
i2c_i801                9996  0
i2c_core               22656  1 i2c_i801
pcspkr                  3332  0
aic7xxx               184020  0
hw_random               6676  0
shpchp                 49632  0
pci_hotplug            30396  1 shpchp
tsdev                   8896  0
mousedev               13092  0
evdev                  10880  0
psmouse                39428  0
genrtc                 11008  0
raid5                  28672  0
xor                    16008  1 raid5
raid0                   9728  0
tg3                   105988  0
e100                   39424  0
mii                     7040  1 e100
sd_mod                 20736  11
ide_cd                 44164  0
cdrom                  41504  1 ide_cd
ide_disk               19712  0
floppy                 63332  0
usb_storage            67776  0
ide_core              128976  6 generic,piix,ide_generic,ide_cd,ide_disk,usb_storage
fbcon                  42528  71
tileblit                3712  1 fbcon
font                    9344  1 fbcon
bitblit                 7168  1 fbcon
softcursor              3328  1 bitblit
vga16fb                14472  1
cfbcopyarea             4992  1 vga16fb
vgastate               11264  1 vga16fb
cfbimgblt               4224  1 vga16fb
cfbfillrect             4992  1 vga16fb
usbserial              32104  0
usbhid                 39520  0
usbkbd                  8448  0
ehci_hcd               35976  0
uhci_hcd               34704  0
usbcore               132228  7 usb_storage,usbserial,usbhid,usbkbd,ehci_hcd,uhci_hcd
thermal                14856  0
processor              25512  1 thermal
fan                     5764  0
aic79xx               287832  9
scsi_transport_spi     22272  2 aic7xxx,aic79xx
scsi_mod              145672  7 qla2xxx,scsi_transport_fc,aic7xxx,sd_mod,usb_storage,aic79xx,scsi_transport_spi
raid1                  22528  3
md_mod                 74452  6 raid5,raid0,raid1
unix                   30352  10


Hope this helps tracking down the oops.

--
Michele
