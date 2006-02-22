Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWBVNVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWBVNVv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 08:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWBVNVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 08:21:51 -0500
Received: from lappc-f057.in2p3.fr ([134.158.97.63]:62188 "EHLO
	lappc-f057.in2p3.fr") by vger.kernel.org with ESMTP
	id S1751242AbWBVNVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 08:21:50 -0500
Subject: isolcpus weirdness
From: Emmanuel Pacaud <emmanuel.pacaud@univ-poitiers.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 22 Feb 2006 14:21:27 +0100
Message-Id: <1140614487.13155.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When specifying isolcpus kernel parameters, isolated cpu is always the
same, not the one I asked for.

I'm working with a dual xeon machine, with linux kernel 2.6.15
(unpatched, from kernel.org), hyperthreading desactivated (number of cpu
= 2). I've tried to isolate cpu1, using isolcpus, but I always end with
cpu0 isolated, even with isolcpus=1. With invalid isolcpus argument
(cpuid > 1), no cpu is isolated, which is ok.

You'll find below content of /proc/version, /proc/cpuinfo, the output of
dmesg, and a snapshot of top when running 3 cpuburn processes.

What's wrong ?

Regards,

	Emmanuel.

----

cat /proc/version
Linux version 2.6.15 (pacaud@xxxx.fr) (gcc version 3.4.4 20050721 (Red
Hat 3.4.4-2)) #3 SMP Wed Feb 22 11:04:15 CET 2006

cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3192.629
cache size      : 2048 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm
pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6439.83

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3192.629
cache size      : 2048 KB
physical id     : 3
siblings        : 1
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm
pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6384.67

----

7:(14:15) ~> dmesg
Linux version 2.6.15 (pacaud@lappc-r093.in2p3.fr) (gcc version 3.4.4
20050721 (Red Hat 3.4.4-2)) #3 SMP Wed Feb 22 11:04:15 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
 BIOS-e820: 000000003ffc0000 - 000000003ffcfc00 (ACPI data)
 BIOS-e820: 000000003ffcfc00 - 000000003ffff000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: PE 0183      APIC at: 0xFEE00000
Processor #0 15:4 APIC version 20
Processor #6 15:4 APIC version 20
I/O APIC #8 Version 32 at 0xFEC00000.
I/O APIC #9 Version 32 at 0xFEC80000.
I/O APIC #10 Version 32 at 0xFEC80800.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Processors: 2
Allocating PCI resources starting at 40000000 (gap: 3ffff000:a0001000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/ rhgb noirqbalance isolcpus=1
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec80000)
mapped IOAPIC to ffffa000 (fec80800)
Initializing CPU#0
CPU 0 irqstacks, hard=c046b000 soft=c044b000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3192.629 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 900868k/917504k available (2282k kernel code, 16044k reserved,
888k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay using timer specific routine.. 6439.83 BogoMIPS
(lpj=12879668)Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000
0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000
0000641d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000080 0000641d
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 3.20GHz stepping 03
Booting processor 1/6 eip 2000
CPU 1 irqstacks, hard=c046c000 soft=c044c000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6384.67 BogoMIPS
(lpj=12769340)CPU: After generic identify, caps: bfebfbff 20100000
00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000
0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000080 0000641d
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 3.20GHz stepping 03
Total of 2 processors activated (12824.50 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 329k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc0be, last bus=6
PCI: Using configuration type 1
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:06:05.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI->APIC IRQ transform: 0000:00:02.0[A] -> IRQ 129
PCI->APIC IRQ transform: 0000:00:04.0[A] -> IRQ 129
PCI->APIC IRQ transform: 0000:00:06.0[A] -> IRQ 129
PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 129
PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 153
PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 145
PCI->APIC IRQ transform: 0000:00:1d.7[D] -> IRQ 185
PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 145
PCI->APIC IRQ transform: 0000:00:1f.2[A] -> IRQ 145
PCI->APIC IRQ transform: 0000:03:07.0[A] -> IRQ 106
PCI->APIC IRQ transform: 0000:06:05.0[A] -> IRQ 137
PCI: Bridge: 0000:01:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.2
  IO window: e000-efff
  MEM window: fe900000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: e000-efff
  MEM window: fe700000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fe500000-fe6fffff
  PREFETCH window: f0000000-f7ffffff
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:01:00.0 to 64
PCI: Setting latency timer of device 0000:01:00.2 to 64
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Intel E7520/7320/7525 detected.<6>lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
[drm] Initialized radeon 1.19.0 20050911 on minor 0:
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
Probing IDE interface ide0...
hda: GCR-8483B, ATAPI CD/DVD-ROM drive
Probing IDE interface ide1...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 185, io mem 0xfeb00000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.3
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 129, io base 0x0000cce0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 153, io base 0x0000ccc0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 145, io base 0x0000cca0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
oprofile: using NMI interrupt.
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2621440 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Using IPI Shortcut mode
Freeing unused kernel memory: 176k freed
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
ICH5: port 0x01f0 already claimed by ide0
ICH5: neither IDE port enabled (BIOS)
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xCC98 ctl 0xCC92 bmdma 0xCC60 irq 145
ata2: SATA max UDMA/133 cmd 0xCC80 ctl 0xCC7A bmdma 0xCC68 irq 145
logips2pp: Detected unknown logitech mouse model 1
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3c21 87:4663
88:207f
ata1: dev 0 ATA-7, max UDMA/133, 312500000 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6L160M0    Rev: BACE
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312500000 512-byte hdwr sectors (160000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312500000 512-byte hdwr sectors (160000 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
input: PS/2 Logitech Mouse as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2096472k swap on /dev/sda3.  Priority:-1 extents:1
across:2096472k
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex



1:(14:15) ~> top

top - 14:16:09 up  2:49,  2 users,  load average: 1.54, 0.41, 0.13
Tasks:  71 total,   4 running,  67 sleeping,   0 stopped,   0 zombie
Cpu0  :  0.0% us,  0.0% sy,  0.0% ni, 99.8% id,  0.0% wa,  0.2% hi,  0.0% si
Cpu1  : 97.7% us,  1.9% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.4% si
Mem:    901584k total,   169848k used,   731736k free,    14764k buffers
Swap:  2096472k total,        0k used,  2096472k free,   108476k cached
 Unknown command - try 'h' for help
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 2826 pacaud    25   0    92   12    4 R 31.5  0.0   0:11.60 burnP6
 2827 pacaud    25   0    92    8    4 R 31.5  0.0   0:12.30 burnP6
 2828 pacaud    25   0    96   12    4 R 30.9  0.0   0:12.30 burnP6
 2742 pacaud    15   0  7268 1824 1240 S  3.4  0.2   0:00.48 sshd
 2769 pacaud    15   0 34068  12m 8148 S  2.7  1.4   0:01.00 gnome-terminal
    1 root      16   0  1688  576  492 S  0.0  0.1   0:00.23 init
    2 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 migration/0



