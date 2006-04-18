Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWDRFHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWDRFHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 01:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWDRFHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 01:07:23 -0400
Received: from web52614.mail.yahoo.com ([206.190.48.217]:29315 "HELO
	web52614.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932234AbWDRFHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 01:07:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=I/m/hBfhJBJRdUBKavfueuWwEblhw9mApBSN8U1wnbb/+CFJktJxLI7HrPai2kL/84/73jegdIZl1Jfk/y6N5hv3aecAyOEHAaxZeKA8q6OJxUuKSkren1cEh7DDWBwg67ChR1Q8UN6w0bTqTiBDowEjryVmo4j43a+S+y8ZRv0=  ;
Message-ID: <20060418050721.89784.qmail@web52614.mail.yahoo.com>
Date: Tue, 18 Apr 2006 15:07:21 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: 2.6.16.1 & D state processes
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060417210308.1fadc766.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> Srihari Vijayaraghavan
> <sriharivijayaraghavan@yahoo.com.au> wrote:
> [...] 
> Your I/O system has lost some I/O requests: we sent
> write requests down,
> and no completion ever came back.
> 
> It could be a broken device driver - please describe
> the I/O stack.

Here's the lspci:
00:00.0 Host bridge: Intel Corporation
82845G/GL[Brookdale-G]/GE/PE DRAM Controller/Host-Hub
Interface (rev 01)
00:02.0 VGA compatible controller: Intel Corporation
82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics
Device (rev 01)
00:1d.0 USB Controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #3 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM
(ICH4/ICH4-M) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge
(rev 81)
00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL
(ICH4/ICH4-L) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801DB
(ICH4) IDE Controller (rev 01)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
00:1f.5 Multimedia audio controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio
Controller (rev 01)
02:08.0 Ethernet controller: Intel Corporation 82801DB
PRO/100 VE (LOM) Ethernet Controller (rev 81)

Here's the complete dmesg (with HDD & CD drives info
too):
Linux version 2.6.16.7 (*******@*********) (gcc
version 4.1.0 20060304 (Red Hat 4.1.0-3)) #1 Fri Apr
14 21:44:33 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800
(usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 000000001f6f0000
(usable)
 BIOS-e820: 000000001f6f0000 - 000000001f6fb000 (ACPI
data)
 BIOS-e820: 000000001f6fb000 - 000000001f700000 (ACPI
NVS)
 BIOS-e820: 000000001f700000 - 000000001f780000
(usable)
 BIOS-e820: 000000001f780000 - 0000000020000000
(reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000
(reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000
(reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000
(reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000
(reserved)
0MB HIGHMEM available.
503MB LOWMEM available.
found SMP MP-table at 000f62d0
On node 0 totalpages: 128896
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 124800 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI present.
ACPI: RSDP (v000 PTLTD                                
) @ 0x000f6360
ACPI: RSDT (v001 PTLTD    RSDT   0x060400d0  LTP
0x00000000) @ 0x1f6f73ec
ACPI: FADT (v001 IBM    NETVISTA 0x060400d0 PTL 
0x00000001) @ 0x1f6faee2
ACPI: TCPA (v001 IBM    NETVISTA 0x060400d0 PTL 
0x00000001) @ 0x1f6faf56
ACPI: MADT (v001 PTLTD  	 APIC   0x060400d0  LTP
0x00000000) @ 0x1f6faf88
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x060400d0  LTP
0x00000001) @ 0x1f6fafd8
ACPI: DSDT (v001    IBM Yelotail 0x060400d0 MSFT
0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000]
gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000,
GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high
level)
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap:
20000000:dec00000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/ rhgb
console=ttyS0,115200 console=tty0
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c03c8000 soft=c03c7000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2392.564 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6,
262144 bytes)
Inode-cache hash table entries: 32768 (order: 5,
131072 bytes)
Memory: 506324k/515584k available (1874k kernel code,
8616k reserved, 766k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in
supervisor mode... Ok.
Calibrating delay using timer specific routine..
4792.76 BogoMIPS (lpj=9585538)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary
module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000
00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000
00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebfbff 00000000 00000000
00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
checking if image is initramfs... it is
Freeing initrd memory: 900k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd98d, last
bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH4
ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.SLOT._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11
12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11
12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11
12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *9 10 11
12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: c0100000-c01fffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to
64
Simple Boot Flag at 0x6c set to 0x1
IBM machine detected. Enabling interrupts during APM
calls.
apm: BIOS version 1.2 Flags 0x03 (Driver version
1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1145359155.056:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096
bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (49 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 845G Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0x88000000
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PSM] at
0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0d: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K
size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level,
low) -> IRQ 16
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings:
hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings:
hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: IC35L060AVV207-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST CD-ROM GCR-8482B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 78156288 sectors (40016 MB) w/1821KiB Cache,
CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9
hda10 hda11 >
hdc: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache,
UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as
/class/input/input0
IP route cache hash table entries: 4096 (order: 2,
16384 bytes)
TCP established hash table entries: 16384 (order: 6,
262144 bytes)
TCP bind hash table entries: 16384 (order: 6, 327680
bytes)
TCP: Hash tables configured (established 16384 bind
16384)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
USB1 USB2 USB3 USBE SLOT  KBC COMA COMB 
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 176k freed
Write protecting the kernel read-only data: 354k
input: PS/2 Generic Mouse as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 6 roles, 1164 types, 137 bools, 1
sens, 256 cats
security:  55 classes, 37899 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda9, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses
genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs),
uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses
transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs),
uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses
transition SIDs
SELinux: initialized (dev eventpollfs, type
eventpollfs), uses genfs_contexts
SELinux: initialized (dev inotifyfs, type inotifyfs),
uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses
genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses
task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses
task SIDs
SELinux: initialized (dev proc, type proc), uses
genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses
genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses
genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses
genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses
genfs_contexts
hw_random: RNG not detected
i810_smbus 0000:00:02.0: i810/i815 i2c device found.
audit(1145323161.860:2): avc:  denied  { search } for 
pid=534 comm="pam_console_app" name="var" dev=hda9
ino=31906
scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255
tcontext=system_u:object_r:file_t:s0 tclass=dir
[...]
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level,
low) -> IRQ 17
e100: eth0: e100_probe: addr 0xc0100000, irq 17, MAC
addr 00:0D:60:30:03:E2
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level,
low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.5 to
64
intel8x0_measure_ac97_clock: measured 53796 usecs
intel8x0: clocking to 48000
audit(1145323163.088:7): avc:  denied  { search } for 
pid=623 comm="pam_console_app" name="var" dev=hda9
ino=31906
scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255
tcontext=system_u:object_r:file_t:s0 tclass=dir
[...]
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level,
low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.0 to
64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered,
assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 19, io base 0x00001800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level,
low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.1 to
64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered,
assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 20, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
audit(1145323165.993:192): avc:  denied  { search }
for  pid=902 comm="pam_console_app" name="var"
dev=hda9 ino=31906
scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255
tcontext=system_u:object_r:file_t:s0 tclass=dir
[...]
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level,
low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.2 to
64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered,
assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 16, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
audit(1145323166.117:202): avc:  denied  { search }
for  pid=910 comm="pam_console_app" name="var"
dev=hda9 ino=31906
scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255
tcontext=system_u:object_r:file_t:s0 tclass=dir
[...]
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level,
low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.7 to
64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: cache line size of 128 is not supported by device
0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered,
assigned bus number 4
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xc0080000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00,
driver 10 Dec 2004
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
audit(1145323166.701:262): avc:  denied  { search }
for  pid=1007 comm="pam_console_app" name="var"
dev=hda9 ino=31906
scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255
tcontext=system_u:object_r:file_t:s0 tclass=dir
[...]
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
audit(1145323167.305:307): avc:  denied  { search }
for  pid=1106 comm="pam_console_app" name="var"
dev=hda9 ino=31906
scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255
tcontext=system_u:object_r:file_t:s0 tclass=dir
[...]
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7
[PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
audit(1145323167.549:312): avc:  denied  { search }
for  pid=1126 comm="pam_console_app" name="var"
dev=hda9 ino=31906
scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255
tcontext=system_u:object_r:file_t:s0 tclass=dir
[...]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
audit(1145323168.401:327): avc:  denied  { search }
for  pid=1163 comm="pam_console_app" name="var"
dev=hda9 ino=31906
scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255
tcontext=system_u:object_r:file_t:s0 tclass=dir
[...]
EXT3 FS on hda9, internal journal
audit(1145323169.865:337): avc:  denied  {
sys_resource } for  pid=1191 comm="mount"
capability=24 scontext=system_u:system_r:mount_t:s0
tcontext=system_u:system_r:mount_t:s0
tclass=capability
[...]
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda2, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda6, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda7, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda3, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda5, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda8, type ext3), uses xattr
audit(1145323170.461:339): avc:  denied  {
sys_resource } for  pid=1200 comm="mount"
capability=24 scontext=system_u:system_r:mount_t:s0
tcontext=system_u:system_r:mount_t:s0
tclass=capability
SELinux: initialized (dev ramfs, type ramfs), uses
genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
audit(1145323179.853:340): avc:  denied  {
sys_resource } for  pid=1292 comm="swapon"
capability=24 scontext=system_u:system_r:fsadm_t:s0
tcontext=system_u:system_r:fsadm_t:s0
tclass=capability
SELinux: initialized (dev binfmt_misc, type
binfmt_misc), uses genfs_contexts
ADDRCONF(NETDEV_UP): eth0: link is not ready
e100: eth0: e100_watchdog: link up, 100Mbps,
full-duplex
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
SELinux: initialized (dev rpc_pipefs, type
rpc_pipefs), uses genfs_contexts
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager
initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
SELinux: initialized (dev autofs, type autofs), uses
genfs_contexts
eth0: no IPv6 routers present
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level,
low) -> IRQ 19
[drm] Initialized i915 1.4.0 20060119 on minor 0

(If need more info such as hdparm etc. pls ask.)

> Or it could be lost interrupts - could be broken
> platform interrupt setup,
> or broken hardware.

Lost interrupts, surely: the clock was many hours
behind actual time (actually a few days after the last
long weekend). Broken hardware, highly unlikely. (I'll
try to reproduce it on another identical machine.)

With my minimal .config, all is well. With FC's
.config (perhaps with a few subsystems - production &
experimental, like Bluetooth, i2c etc.), however, the
problem is reproduceable. Naturally, FC's .config
loads many kernel drivers (538 symbols on my minimal
.config vs 1800+ on FC5's). Because there are way too
many symbols, I thought someone would be quick to
point out which one of those would be to blame :-) by
looking thro those processes.

And oh, eventually machine recovers (minutes
sometimes, hours other times), & it runs as if nothing
happend, as long as you're not quick to power button.
Sure, you can't login, or you can't execute commands,
if you managed to login etc. But patience does bring
the machine back every time :-).

(On request I'd gladly provide my minimal .config &
FC5's.)

I think I should remove those symbols one at a time to
narrow it down. That would take many days though. But
it'll be worth a try, if there's no other way.

Thanks


Send instant messages to your online friends http://au.messenger.yahoo.com 
