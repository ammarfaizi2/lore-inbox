Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVERHYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVERHYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVERHYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:24:07 -0400
Received: from [213.170.72.194] ([213.170.72.194]:22733 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S262118AbVERHTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:19:04 -0400
Subject: Re: [OOPS] 2.6.12-rc4 oops
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-scsi@vger.kernel.org
In-Reply-To: <20050517180847.6fb0e204.akpm@osdl.org>
References: <1116345116.8079.12.camel@sauron.oktetlabs.ru>
	 <20050517180847.6fb0e204.akpm@osdl.org>
Content-Type: text/plain
Organization: MTD
Date: Wed, 18 May 2005 11:18:57 +0400
Message-Id: <1116400737.18728.7.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please describe the I/O setup.  Serial ATA?  Which driver, what type of
> hardware?
Yes SATA. I have also ATA CD/DVD-Reader, but it wasn't touched.
Driver is ata_piix. HDD is Seagate Barracude ST3120026AS, 120GB. I use
LVM.

[root@bifur root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 2399.058
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cidxtpr
bogomips        : 4751.36

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 2399.058
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cidxtpr
bogomips        : 4784.12

[root@bifur root]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3120026AS      Rev: 3.20
  Type:   Direct-Access                    ANSI SCSI revision: 05

[root@bifur /]# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0290-0297 : pnp 00:08
02f8-02ff : serial
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
0480-04bf : 0000:00:1f.0
0680-06ff : pnp 00:08
0800-087f : 0000:00:1f.0
  0800-0803 : PM1a_EVT_BLK
  0804-0805 : PM1a_CNT_BLK
  0808-080b : PM_TMR
  0828-082f : GPE0_BLK
0cf8-0cff : PCI conf1
d800-d8ff : 0000:02:05.0
  d800-d8ff : SysKonnect SK-98xx
e800-e8ff : 0000:00:1f.5
ee80-eebf : 0000:00:1f.5
ef00-ef1f : 0000:00:1d.0
  ef00-ef1f : uhci_hcd
ef20-ef3f : 0000:00:1d.1
  ef20-ef3f : uhci_hcd
ef40-ef5f : 0000:00:1d.2
  ef40-ef5f : uhci_hcd
ef60-ef6f : 0000:00:1f.2
  ef60-ef6f : libata
ef80-ef9f : 0000:00:1d.3
  ef80-ef9f : uhci_hcd
efa0-efa7 : 0000:00:1f.2
  efa0-efa7 : libata
efa8-efab : 0000:00:1f.2
  efa8-efab : libata
efac-efaf : 0000:00:1f.2
  efac-efaf : libata
efe0-efe7 : 0000:00:1f.2
  efe0-efe7 : libata
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1

[root@bifur /]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ff2ffff : System RAM
  00100000-00318ee3 : Kernel code
  00318ee4-003c7e7f : Kernel data
1ff30000-1ff3ffff : ACPI Tables
1ff40000-1ffeffff : ACPI Non-volatile Storage
1fff0000-1fffffff : reserved
20000000-200003ff : 0000:00:1f.1
f8000000-f9ffffff : 0000:02:09.0
fc000000-fdffffff : 0000:00:00.0
feaf8000-feafbfff : 0000:02:05.0
  feaf8000-feafbfff : SysKonnect SK-98xx
feaff000-feafffff : 0000:02:09.0
febff400-febff4ff : 0000:00:1f.5
febff800-febff9ff : 0000:00:1f.5
febffc00-febfffff : 0000:00:1d.7
  febffc00-febfffff : ehci_hcd
ffb80000-ffffffff : reserved

Everything which is possible was compiled as kernel module, so, this may
be helpful:

root@bifur root]# lsmod
Module                  Size  Used by
reiserfs              252404  1
loop                   14216  0
nfsd                  203424  9
exportfs                6144  1 nfsd
md5                     5120  1
ipv6                  236576  16
autofs4                17156  2
nfs                   193640  2
lockd                  59304  3 nfsd,nfs
sunrpc                124868  22 nfsd,nfs,lockd
sk98lin               160352  0
microcode               7648  0
uhci_hcd               29968  0
ehci_hcd               31112  0
video                  15108  0
button                  6160  0
battery                 8708  0
ac                      4612  0
sd_mod                 15744  4
sr_mod                 15396  0
ext3                  121864  2
jbd                    57368  1 ext3
dm_mod                 53128  3
ata_piix                7684  3
libata                 40708  1 ata_piix
scsi_mod              115272  3 sd_mod,sr_mod,libata

Here is the kernel boot output:
Linux version 2.6.12-rc4-smp-preempt (root@bifur.oktetlabs.ru) (gcc
version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #5 SMP Tue May 17 19:4
6:48 MSD 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
 BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
 BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
found SMP MP-table at 000ff780
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 20000000:dfb80000)
Built 1 zonelists
Kernel command line: ro root=/dev/sda1 console=ttyS0,115200
console=ttyS0,115200
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2400.068 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 511948k/523456k available (2167k kernel code, 10904k reserved,
712k data, 240k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Booting processor 1/1 eip 3000
Initializing CPU#1
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Total of 2 processors activated (9535.48 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 333k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
pnp: 00:08: ioport range 0x680-0x6ff has been reserved
pnp: 00:08: ioport range 0x290-0x297 has been reserved
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
audit: initializing netlink socket (disabled)
audit(1116414990.543:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: AGP aperture is 32M @ 0xfc000000
[drm] Initialized drm 1.0.0 20040925
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: ASUS DVD-ROM DVD-E616P 0104, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbmon: debugs is not available
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 7, 524288 bytes)
TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
ACPI wakeup devices:
P0P4 MC97 USB1 USB2 USB3 USB4 EUSB ILAN
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Red Hat nash version 3.5.22 starting
Mounted /proc filesystem
Mounting sysfs
Loading scsi_mod.ko module
SCSI subsystem initialized
Loading libata.ko module
Loading ata_piix.ko module
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
ata1: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF60 irq 18
ata2: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF68 irq 18
ata1: dev 0 ATA, max UDMA/100, 234441648 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
  Vendor: ATA       Model: ST3120026AS       Rev: 3.20
  Type:   Direct-Access                      ANSI SCSI revision: 05
Loading dm-mod.ko module
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Loading jbd.ko module
Loading ext3.ko module
Loading sr_mod.ko module
Loading sd_mod.ko module
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Creating block devices
Creating root deEXT3-fs: INFO: recovery required on readonly filesystem.
vice
Mounting rEXT3-fs: write access will be enabled during recovery.
oot filesystem
EXT3-fs: recovery complete.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 240k freed
INIT: version 2.85 booting
                Welcome to Fedora Core
                Press 'I' to enter interactive startup.
Configuring kernel parameters:  [  OK  ]
....

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

