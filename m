Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbUKHMd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbUKHMd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 07:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbUKHMd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 07:33:29 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:25939 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261826AbUKHMc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 07:32:56 -0500
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm3
Date: Mon, 8 Nov 2004 13:34:18 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Kf2jBe24bWJcf9j"
Message-Id: <200411081334.18751.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Kf2jBe24bWJcf9j
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

This bug is triggered by logging on to bash (runlevel 3),
typing "cat /proc/acpi", then <TAB> gives the correct "/" to complete,
the 2nd <TAB> has no visual effect, the 3rd <TAB> generates this oops:

Unable to handle kernel paging request at virtual address f89e7b00
 printing eip:
c0187452
*pde = 37ff1067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: binfmt_misc video ohci1394 ieee1394 uhci_hcd intel_agp agpgart i2c_i801 i2c_core snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore ext3 jbd ata_piix libata sd_mod scsi_mod
CPU:    0
EIP:    0060:[<c0187452>]    Not tainted VLI
EFLAGS: 00010286   (2.6.10-rc1-mm3)
EIP is at proc_get_inode+0xa0/0x184
eax: 00000000   ebx: f89e7b00   ecx: 00000001   edx: f7ee7000
esi: f62964bc   edi: f66d6380   ebp: f7ee7de8   esp: f7ee7dc8
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 5322, threadinfo=f7ee7000 task=f5d8c550)
Stack: f62964bc f0000337 f7ee7de4 c02f3259 00000001 f66d6380 f4db2313 f66d63cf
       f7ee7e1c c018a0e6 f7f75200 f0000337 f66d6380 00000003 00000001 dead4ead
       ffffffea 00000000 fffffff4 f4db22a0 f5ea34bc f7ee7e3c c0169637 f5ea34bc
Call Trace:
 [<c0106e74>] show_stack+0x80/0x96
 [<c010700b>] show_registers+0x161/0x1da
 [<c0107221>] die+0x107/0x190
 [<c01198b9>] do_page_fault+0x495/0x6cb
 [<c0106b03>] error_code+0x2b/0x30
 [<c018a0e6>] proc_lookup+0x7c/0xc4
 [<c0169637>] real_lookup+0xab/0xc9
 [<c01698df>] do_lookup+0x7d/0x88
 [<c016a028>] link_path_walk+0x73e/0xef1
 [<c016aab9>] path_lookup+0x9a/0x163
 [<c016ad10>] __user_walk+0x2b/0x48
 [<c01657c8>] vfs_stat+0x1a/0x55
 [<c0165e20>] sys_stat64+0x19/0x38
 [<c0106031>] sysenter_past_esp+0x52/0x71
Code: b7 47 0e 66 85 c0 74 06 0f b7 c0 89 46 2c 8b 5f 28 c7 45 f0 01 00 00 00 85 db 74 46 b8 01 00 00 00 e8 6a 54 f9 ff e8 9e 06 04 00 <83> 3b 02 0f 84 cf 00 00 00 c1 e0 07 01 d8 ff 80 00 01 00 00 b8
 <6>note: bash[5322] exited with preempt_count 1


"cat /proc" and then <TAB> works, so it is something about acpi?
attached the complete dmesg output for reference.

thanks,
Karsten

--Boundary-00=_Kf2jBe24bWJcf9j
Content-Type: text/plain;
  charset="us-ascii";
  name="2.6.10-rc1-mm3_cat_proc_acpi_TAB"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.10-rc1-mm3_cat_proc_acpi_TAB"

Linux version 2.6.10-rc1-mm3 (root@p4.localdomain) (gcc-Version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #2 SMP Mon Nov 8 12:46:27 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fe88c00 (usable)
 BIOS-e820: 000000003fe88c00 - 000000003fe8ac00 (ACPI NVS)
 BIOS-e820: 000000003fe8ac00 - 000000003fe8cc00 (ACPI data)
 BIOS-e820: 000000003fe8cc00 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fec00
ACPI: RSDT (v001 DELL    4700    0x00000007 ASL  0x00000061) @ 0x000fcc10
ACPI: FADT (v001 DELL    4700    0x00000007 ASL  0x00000061) @ 0x000fcc50
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffc58e5
ACPI: MADT (v001 DELL    4700    0x00000007 ASL  0x00000061) @ 0x000fccc4
ACPI: BOOT (v001 DELL    4700    0x00000007 ASL  0x00000061) @ 0x000fcd36
ACPI: ASF! (v016 DELL    4700    0x00000007 ASL  0x00000061) @ 0x000fcd5e
ACPI: MCFG (v001 DELL    4700    0x00000007 ASL  0x00000061) @ 0x000fcdc5
ACPI: HPET (v001 DELL    4700    0x00000007 ASL  0x00000061) @ 0x000fce03
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=LABEL=/ rhgb quiet 3
CPU 0 irqstacks, hard=c042f000 soft=c042d000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 904752k/917504k available (2002k kernel code, 12072k reserved, 1023k data, 200k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Using HPET for base-timer
Using HPET for gettimeofday
Detected 3192.287 MHz processor.
Using hpet for high-res timesource
Calibrating delay loop... 6324.22 BogoMIPS (lpj=3162112)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
per-CPU timeslice cutoff: 2925.53 usecs.
task migration cache decay timeout: 3 msecs.
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c0430000 soft=c042e000
Initializing CPU#1
Calibrating delay loop... 6373.37 BogoMIPS (lpj=3186688)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Total of 2 processors activated (12697.60 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1:
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
checking if image is initramfs... it is
Freeing initrd memory: 463k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb2cc, last bus=3
PCI: Using MMCONFIG
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041015
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11 12 15)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag value 0x87 read from CMOS RAM was invalid
Simple Boot Flag at 0x7a set to 0x1
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Initializing Cryptographic API
vesafb: probe of vesafb0 failed with error -6
ACPI: Power Button (FF) [PWRF]
Real Time Clock Driver v1.12
[drm] Initialized drm 1.0.0 20040925
ACPI: PS/2 Keyboard Controller [KBD] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [MOU] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:03:08.0[A] -> GSI 20 (level, low) -> IRQ 20
e100: eth0: e100_probe: addr 0xdfcfb000, irq 20, MAC addr 00:11:11:65:15:D7
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: Philips DVD+RW DVD8601, ATAPI CD/DVD-ROM drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices: 
VBTN PCI0 PCI1 PCI2 PCI3 PCI4  KBD USB0 USB1 USB2 USB3 
Freeing unused kernel memory: 200k freed
SCSI subsystem initialized
libata version 1.02 loaded.
ata_piix version 1.02
ACPI: PCI interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 20
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 20
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3e01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ATA: abnormal status 0xFF on port 0xFE27
ata2: disabling port
scsi1 : ata_piix
  Vendor: ATA       Model: ST3160023AS       Rev: 8.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 > sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 16 (level, low) -> IRQ 16
hw_random: RNG not detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 915G Chipset.
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 256M @ 0x0
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:1d.0: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 21, io base 0xff80
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 22
uhci_hcd 0000:00:1d.1: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 22, io base 0xff60
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0xff40
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.3: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 23, io base 0xff20
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:03:00.2[B] -> GSI 17 (level, low) -> IRQ 17
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[17]  MMIO=[dfcfa800-dfcfafff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c041107fa77]
ibm_acpi: ec object not found
EXT3 FS on sda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1020088k swap on /dev/sda6.  Priority:-1 extents:1
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
Unable to handle kernel paging request at virtual address f89e7b00
 printing eip:
c0187452
*pde = 37ff1067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: binfmt_misc video ohci1394 ieee1394 uhci_hcd intel_agp agpgart i2c_i801 i2c_core snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore ext3 jbd ata_piix libata sd_mod scsi_mod
CPU:    0
EIP:    0060:[<c0187452>]    Not tainted VLI
EFLAGS: 00010286   (2.6.10-rc1-mm3) 
EIP is at proc_get_inode+0xa0/0x184
eax: 00000000   ebx: f89e7b00   ecx: 00000001   edx: f7ee7000
esi: f62964bc   edi: f66d6380   ebp: f7ee7de8   esp: f7ee7dc8
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 5322, threadinfo=f7ee7000 task=f5d8c550)
Stack: f62964bc f0000337 f7ee7de4 c02f3259 00000001 f66d6380 f4db2313 f66d63cf 
       f7ee7e1c c018a0e6 f7f75200 f0000337 f66d6380 00000003 00000001 dead4ead 
       ffffffea 00000000 fffffff4 f4db22a0 f5ea34bc f7ee7e3c c0169637 f5ea34bc 
Call Trace:
 [<c0106e74>] show_stack+0x80/0x96
 [<c010700b>] show_registers+0x161/0x1da
 [<c0107221>] die+0x107/0x190
 [<c01198b9>] do_page_fault+0x495/0x6cb
 [<c0106b03>] error_code+0x2b/0x30
 [<c018a0e6>] proc_lookup+0x7c/0xc4
 [<c0169637>] real_lookup+0xab/0xc9
 [<c01698df>] do_lookup+0x7d/0x88
 [<c016a028>] link_path_walk+0x73e/0xef1
 [<c016aab9>] path_lookup+0x9a/0x163
 [<c016ad10>] __user_walk+0x2b/0x48
 [<c01657c8>] vfs_stat+0x1a/0x55
 [<c0165e20>] sys_stat64+0x19/0x38
 [<c0106031>] sysenter_past_esp+0x52/0x71
Code: b7 47 0e 66 85 c0 74 06 0f b7 c0 89 46 2c 8b 5f 28 c7 45 f0 01 00 00 00 85 db 74 46 b8 01 00 00 00 e8 6a 54 f9 ff e8 9e 06 04 00 <83> 3b 02 0f 84 cf 00 00 00 c1 e0 07 01 d8 ff 80 00 01 00 00 b8 
 <6>note: bash[5322] exited with preempt_count 1

--Boundary-00=_Kf2jBe24bWJcf9j--
