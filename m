Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274839AbTHPQAA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 12:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274859AbTHPP77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:59:59 -0400
Received: from web40008.mail.yahoo.com ([66.218.78.26]:14885 "HELO
	web40008.mail.yahoo.com") by vger.kernel.org with SMTP
	id S274839AbTHPP6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:58:32 -0400
Message-ID: <20030816155831.40207.qmail@web40008.mail.yahoo.com>
Date: Sat, 16 Aug 2003 08:58:31 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Strange interrupt problem on 2.6.0-test3 (may be USB or core-related)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone!

I've recently encountered a very strange problem with 2.6.0-test3 that
I believe is USB-related. Whenever I boot my Red Hat 9-based laptop into
runlevel 5 and log into X, the system goes haywire, with CPU utilization at
100% and no mouse pointer responsiveness. Switching to vt1 shows the following
message scrolling away at top speed:

unexpected IRQ trap at vector d0

Checking the syslog file I was able to save showed this message being repeated
over 14000 times, with no Oopses appearing at any point. I believe the problem
is USB-related when the message did not appear after logging into vt1 without
GPM running, since I use a Logitech MX700. Using Alt-SysRQ saved my
filesystems, but Alt-SysRQ-B hardlocked the system, forcing a full reset.

I can't easily follow the 2.6.0-testX development, so I haven't checked to see
what USB or other core-related patches have gone in lately, since I can say
that this did not happen around the 2.5.7[0-5] stage, IIRC. The system runs
fine with 2.4.21-ac4+nfpom (some Netfilter patch-o-matic patches).

Kernel dmesg:

Linux version 2.6.0-test3 (bhchapm@Ganymede.finelyhouse.info) (gcc version
3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Thu Aug 14 22:01:13 EDT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001feff000 (ACPI data)
 BIOS-e820: 000000001feff000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 000000001ff80000 (usable)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130944
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126848 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6a40
ACPI: RSDT (v001 GATEWA 600      08194.02326) @ 0x1fef85e9
ACPI: FADT (v001 GATEWA 600      08194.02326) @ 0x1fefef64
ACPI: BOOT (v001 GATEWA 600      08194.02326) @ 0x1fefefd8
ACPI: DSDT (v001 GATEWA 600      08194.02326) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda6 single
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1994.380 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3932.16 BogoMIPS
Memory: 514268k/523776k available (2395k kernel code, 8700k reserved, 768k
data, 140k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1993.0334 MHz.
..... host bus clock speed is 99.0666 MHz.
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd999, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 10, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 10, disabled)
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Journalled Block Device driver loaded
udf: registering filesystem
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (30 C)
Real Time Clock Driver v1.11
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xec000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N030ATCS04-0, ATA DISK drive
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Yenta: CardBus bridge found at 0000:02:02.0 [107b:0600]
Yenta IRQ list 08d8, PCI irq10
Socket status: 30000006
Yenta: CardBus bridge found at 0000:02:02.1 [107b:0600]
Yenta IRQ list 08d8, PCI irq10
Socket status: 30000006
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 1024 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 9362)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
EXT3 FS on hda6, internal journal
Adding 674688k swap on /dev/hda12.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1023 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8207000-e82077ff]  Max
Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0b8060000db10]

The syslog file I saved when the interrupt error was appearing:

Aug 14 22:17:18 Ganymede syslogd 1.4.1: restart.
Aug 14 22:17:19 Ganymede syslog: syslogd startup succeeded
Aug 14 22:17:19 Ganymede kernel: klogd 1.4.1, log source = /proc/kmsg started.
Aug 14 22:17:19 Ganymede kernel: Linux version 2.6.0-test3
(bhchapm@Ganymede.finelyhouse.info) (gcc version 3.2.2 20030222 (Red Hat Linux
3.2.2-5)) #1 Thu Aug 14 22:01:13 EDT 2003
Aug 14 22:17:19 Ganymede kernel: Video mode to be used for restore is ffff
Aug 14 22:17:19 Ganymede kernel: BIOS-provided physical RAM map:
Aug 14 22:17:19 Ganymede kernel:  BIOS-e820: 0000000000000000 -
000000000009e800 (usable)
Aug 14 22:17:19 Ganymede kernel:  BIOS-e820: 000000000009e800 -
00000000000a0000 (reserved)
Aug 14 22:17:19 Ganymede kernel:  BIOS-e820: 00000000000e0000 -
0000000000100000 (reserved)
Aug 14 22:17:19 Ganymede kernel:  BIOS-e820: 0000000000100000 -
000000001fef0000 (usable)
Aug 14 22:17:19 Ganymede kernel:  BIOS-e820: 000000001fef0000 -
000000001feff000 (ACPI data)
Aug 14 22:17:19 Ganymede kernel:  BIOS-e820: 000000001feff000 -
000000001ff00000 (ACPI NVS)
Aug 14 22:17:19 Ganymede kernel:  BIOS-e820: 000000001ff00000 -
000000001ff80000 (usable)
Aug 14 22:17:19 Ganymede kernel:  BIOS-e820: 000000001ff80000 -
0000000020000000 (reserved)
Aug 14 22:17:19 Ganymede syslog: klogd startup succeeded
Aug 14 22:17:19 Ganymede kernel:  BIOS-e820: 00000000ffb80000 -
00000000ffc00000 (reserved)
Aug 14 22:17:19 Ganymede kernel:  BIOS-e820: 00000000fff00000 -
0000000100000000 (reserved)
Aug 14 22:17:19 Ganymede kernel: 511MB LOWMEM available.
Aug 14 22:17:19 Ganymede kernel: On node 0 totalpages: 130944
Aug 14 22:17:19 Ganymede kernel:   DMA zone: 4096 pages, LIFO batch:1
Aug 14 22:17:19 Ganymede portmap: portmap startup succeeded
Aug 14 22:17:19 Ganymede kernel:   Normal zone: 126848 pages, LIFO batch:16
Aug 14 22:17:19 Ganymede kernel:   HighMem zone: 0 pages, LIFO batch:1
Aug 14 22:17:19 Ganymede kernel: ACPI: RSDP (v000 PTLTD                      )
@ 0x000f6a40
Aug 14 22:17:20 Ganymede kernel: ACPI: RSDT (v001 GATEWA 600      08194.02326)
@ 0x1fef85e9
Aug 14 22:17:20 Ganymede smb: smbd startup succeeded
Aug 14 22:17:20 Ganymede kernel: ACPI: FADT (v001 GATEWA 600      08194.02326)
@ 0x1fefef64
Aug 14 22:17:20 Ganymede smb: nmbd startup succeeded
Aug 14 22:17:20 Ganymede nmbd[427]: [2003/08/14 22:17:20, 0]
nmbd/nmbd_subnetdb.c:create_subnets(239) 
Aug 14 22:17:20 Ganymede kernel: ACPI: BOOT (v001 GATEWA 600      08194.02326)
@ 0x1fefefd8
Aug 14 22:17:20 Ganymede nmbd[427]:   create_subnets: No local interfaces ! 
Aug 14 22:17:20 Ganymede keytable: Loading keymap: 
Aug 14 22:17:20 Ganymede kernel: ACPI: DSDT (v001 GATEWA 600      08194.02326)
@ 0x00000000
Aug 14 22:17:20 Ganymede nmbd[427]: [2003/08/14 22:17:20, 0]
nmbd/nmbd.c:main(873) 
Aug 14 22:17:20 Ganymede keytable: 
Aug 14 22:17:20 Ganymede kernel: ACPI: BIOS passes blacklist
Aug 14 22:17:20 Ganymede nmbd[427]:   ERROR: Failed when creating subnet lists.
Exiting. 
Aug 14 22:17:20 Ganymede keytable: Loading system font: 
Aug 14 22:17:20 Ganymede kernel: ACPI: MADT not present
Aug 14 22:17:20 Ganymede keytable: 
Aug 14 22:17:20 Ganymede kernel: Building zonelist for node : 0
Aug 14 22:17:20 Ganymede rc: Starting keytable:  succeeded
Aug 14 22:17:20 Ganymede kernel: Kernel command line: ro root=/dev/hda6 single
Aug 14 22:17:20 Ganymede kernel: Local APIC disabled by BIOS -- reenabling.
Aug 14 22:17:20 Ganymede random: Initializing random number generator: 
succeeded
Aug 14 22:17:20 Ganymede kernel: Found and enabled local APIC!
Aug 14 22:17:20 Ganymede kernel: Initializing CPU#0
Aug 14 22:17:21 Ganymede kernel: PID hash table entries: 2048 (order 11: 16384
bytes)
Aug 14 22:17:21 Ganymede kernel: Detected 1994.422 MHz processor.
Aug 14 22:17:21 Ganymede kernel: Console: colour VGA+ 80x25
Aug 14 22:17:21 Ganymede kernel: Calibrating delay loop... 3932.16 BogoMIPS
Aug 14 22:17:21 Ganymede kernel: Memory: 514268k/523776k available (2395k
kernel code, 8700k reserved, 768k data, 140k init, 0k highmem)
Aug 14 22:17:21 Ganymede netfs: Mounting other filesystems:  succeeded
Aug 14 22:17:21 Ganymede kernel: Dentry cache hash table entries: 65536 (order:
6, 262144 bytes)
Aug 14 22:17:18 Ganymede kudzu:  succeeded 
Aug 14 22:17:21 Ganymede kernel: Inode-cache hash table entries: 32768 (order:
5, 131072 bytes)
Aug 14 22:17:18 Ganymede kudzu: Updating /etc/fstab succeeded 
Aug 14 22:17:21 Ganymede kernel: Mount-cache hash table entries: 512 (order: 0,
4096 bytes)
Aug 14 22:17:18 Ganymede pcmcia: Starting PCMCIA services:  
Aug 14 22:17:21 Ganymede acpid: acpid startup succeeded
Aug 14 22:17:21 Ganymede kernel: -> /dev
Aug 14 22:17:18 Ganymede pcmcia: cardmgr[292]: watching 2 sockets 
Aug 14 22:17:21 Ganymede kernel: -> /dev/console
Aug 14 22:17:18 Ganymede cardmgr[292]: watching 2 sockets <30>Aug 14 22:17:18
cardmgr[292]: could not adjust resource: IO ports 0xc00-0xcff: Device or
resource busy
Aug 14 22:17:22 Ganymede kernel: -> /root
Aug 14 22:17:18 Ganymede cardmgr[293]: starting, version is 3.2.4 
Aug 14 22:17:22 Ganymede sshd:  succeeded
Aug 14 22:17:18 Ganymede pcmcia:  
Aug 14 22:17:18 Ganymede pcmcia: cardmgr[292]: could not adjust resource: IO
ports 0xc00-0xcff: Device or resource busy 
Aug 14 22:17:22 Ganymede kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Aug 14 22:17:18 Ganymede pcmcia: cardmgr[292]: could not adjust resource: IO
ports 0x100-0x4ff: Device or resource busy 
Aug 14 22:17:22 Ganymede kernel: CPU: L2 cache: 512K
Aug 14 22:17:18 Ganymede pcmcia: cardmgr[292]: could not adjust resource:
memory 0xc0000-0xfffff: Input/output error 
Aug 14 22:17:18 Ganymede pcmcia: cardmgr[292]: could not adjust resource:
memory 0x60000000-0x60ffffff: Input/output error 
Aug 14 22:17:18 Ganymede pcmcia: cardmgr[292]: could not adjust resource:
memory 0xa0000000-0xa0ffffff: Input/output error 
Aug 14 22:17:18 Ganymede pcmcia: cardmgr[292]: could not adjust resource: IO
ports 0xa00-0xaff: Device or resource busy 
Aug 14 22:17:18 Ganymede pcmcia: done. 
Aug 14 22:17:18 Ganymede rc: Starting pcmcia:  succeeded 
Aug 14 22:17:18 Ganymede sysctl: net.ipv4.ip_forward = 1 
Aug 14 22:17:18 Ganymede sysctl: net.ipv4.conf.default.rp_filter = 1 
Aug 14 22:17:18 Ganymede sysctl: kernel.sysrq = 1 
Aug 14 22:17:23 Ganymede kernel: Intel machine check architecture supported.
Aug 14 22:17:18 Ganymede sysctl: kernel.core_uses_pid = 1 
Aug 14 22:17:23 Ganymede kernel: Intel machine check reporting enabled on
CPU#0.
Aug 14 22:17:18 Ganymede sysctl: kernel.modprobe = /sbin/modprobe 
Aug 14 22:17:23 Ganymede kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs (12)
available
Aug 14 22:17:23 Ganymede kernel: CPU#0: Thermal monitoring enabled
Aug 14 22:17:18 Ganymede network: Setting network parameters:  succeeded 
Aug 14 22:17:23 Ganymede kernel: CPU: Intel Mobile Intel(R) Pentium(R) 4 - M
CPU 2.00GHz stepping 07
Aug 14 22:17:23 Ganymede kernel: Enabling fast FPU save and restore... done.
Aug 14 22:17:18 Ganymede network: Bringing up loopback interface:  succeeded 
Aug 14 22:17:23 Ganymede kernel: Enabling unmasked SIMD FPU exception
support... done.
Aug 14 22:17:23 Ganymede kernel: Checking 'hlt' instruction... OK.
Aug 14 22:17:23 Ganymede kernel: POSIX conformance testing by UNIFIX
Aug 14 22:17:23 Ganymede kernel: enabled ExtINT on CPU#0
Aug 14 22:17:23 Ganymede kernel: ESR value before enabling vector: 00000000
Aug 14 22:17:23 Ganymede kernel: ESR value after enabling vector: 00000000
Aug 14 22:17:23 Ganymede kernel: Using local APIC timer interrupts.
Aug 14 22:17:23 Ganymede kernel: calibrating APIC timer ...
Aug 14 22:17:23 Ganymede kernel: ..... CPU clock speed is 1993.0172 MHz.
Aug 14 22:17:23 Ganymede kernel: ..... host bus clock speed is 99.0658 MHz.
Aug 14 22:17:23 Ganymede kernel: Initializing RT netlink socket
Aug 14 22:17:23 Ganymede kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd999,
last bus=2
Aug 14 22:17:23 Ganymede kernel: PCI: Using configuration type 1
Aug 14 22:17:23 Ganymede kernel: mtrr: v2.0 (20020519)
Aug 14 22:17:23 Ganymede kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Aug 14 22:17:23 Ganymede kernel: biovec pool[0]:   1 bvecs: 256 entries (12
bytes)
Aug 14 22:17:23 Ganymede kernel: biovec pool[1]:   4 bvecs: 256 entries (48
bytes)
Aug 14 22:17:23 Ganymede kernel: biovec pool[2]:  16 bvecs: 256 entries (192
bytes)
Aug 14 22:17:23 Ganymede kernel: biovec pool[3]:  64 bvecs: 256 entries (768
bytes)
Aug 14 22:17:23 Ganymede kernel: biovec pool[4]: 128 bvecs: 256 entries (1536
bytes)
Aug 14 22:17:23 Ganymede kernel: biovec pool[5]: 256 bvecs: 256 entries (3072
bytes)
Aug 14 22:17:23 Ganymede kernel: ACPI: Subsystem revision 20030714
Aug 14 22:17:23 Ganymede kernel: ACPI: Interpreter enabled
Aug 14 22:17:23 Ganymede kernel: ACPI: Using PIC for interrupt routing
Aug 14 22:17:23 Ganymede kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 14 22:17:23 Ganymede kernel: PCI: Probing PCI hardware (bus 00)
Aug 14 22:17:23 Ganymede kernel: Transparent bridge - 0000:00:1e.0
Aug 14 22:17:23 Ganymede kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
Aug 14 22:17:23 Ganymede kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
Aug 14 22:17:23 Ganymede kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
Aug 14 22:17:23 Ganymede kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
Aug 14 22:17:23 Ganymede kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
Aug 14 22:17:23 Ganymede kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 10,
disabled)
Aug 14 22:17:23 Ganymede kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 10,
disabled)
Aug 14 22:17:23 Ganymede kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 10,
disabled)
Aug 14 22:17:23 Ganymede kernel: ACPI: Embedded Controller [EC0] (gpe 29)
Aug 14 22:17:23 Ganymede kernel: ACPI: Power Resource [PFN0] (off)
Aug 14 22:17:23 Ganymede kernel: ACPI: Power Resource [PFN1] (off)
Aug 14 22:17:23 Ganymede kernel: Linux Plug and Play Support v0.97 (c) Adam
Belay
Aug 14 22:17:23 Ganymede kernel: SCSI subsystem initialized
Aug 14 22:17:23 Ganymede kernel: Linux Kernel Card Services 3.1.22
Aug 14 22:17:23 Ganymede kernel:   options:  [pci] [cardbus] [pm]
Aug 14 22:17:23 Ganymede kernel: drivers/usb/core/usb.c: registered new driver
usbfs
Aug 14 22:17:23 Ganymede kernel: drivers/usb/core/usb.c: registered new driver
hub
Aug 14 22:17:23 Ganymede kernel: ACPI: PCI Interrupt Link [LNKF] enabled at IRQ
10
Aug 14 22:17:23 Ganymede kernel: ACPI: PCI Interrupt Link [LNKG] enabled at IRQ
10
Aug 14 22:17:24 Ganymede kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ
10
Aug 14 22:17:24 Ganymede kernel: PCI: Using ACPI for IRQ routing
Aug 14 22:17:24 Ganymede kernel: PCI: if you experience problems, try using
option 'pci=noacpi' or even 'acpi=off'
Aug 14 22:17:24 Ganymede kernel: pty: 256 Unix98 ptys configured
Aug 14 22:17:24 Ganymede kernel: SBF: Simple Boot Flag extension found and
enabled.
Aug 14 22:17:24 Ganymede kernel: SBF: Setting boot flags 0x1
Aug 14 22:17:24 Ganymede kernel: Machine check exception polling timer started.
Aug 14 22:17:24 Ganymede kernel: cpufreq: P4/Xeon(TM) CPU On-Demand Clock
Modulation available
Aug 14 22:17:24 Ganymede kernel: Journalled Block Device driver loaded
Aug 14 22:17:24 Ganymede kernel: udf: registering filesystem
Aug 14 22:17:24 Ganymede kernel: Initializing Cryptographic API
Aug 14 22:17:24 Ganymede kernel: ACPI: AC Adapter [ACAD] (on-line)
Aug 14 22:17:24 Ganymede kernel: ACPI: Battery Slot [BAT1] (battery present)
Aug 14 22:17:24 Ganymede kernel: ACPI: Battery Slot [BAT2] (battery present)
Aug 14 22:17:24 Ganymede kernel: ACPI: Power Button (FF) [PWRF]
Aug 14 22:17:24 Ganymede kernel: ACPI: Lid Switch [LID]
Aug 14 22:17:24 Ganymede kernel: ACPI: Sleep Button (CM) [SLPB]
Aug 14 22:17:24 Ganymede kernel: ACPI: Fan [FAN0] (off)
Aug 14 22:17:24 Ganymede kernel: ACPI: Fan [FAN1] (off)
Aug 14 22:17:24 Ganymede kernel: ACPI: Processor [CPU0] (supports C1 C2 C3, 8
throttling states)
Aug 14 22:17:24 Ganymede kernel: ACPI: Thermal Zone [THRM] (52 C)
Aug 14 22:17:24 Ganymede kernel: Real Time Clock Driver v1.11
Aug 14 22:17:24 Ganymede kernel: hw_random hardware driver 1.0.0 loaded
Aug 14 22:17:24 Ganymede kernel: Linux agpgart interface v0.100 (c) Dave Jones
Aug 14 22:17:24 Ganymede kernel: agpgart: Detected an Intel i845 Chipset.
Aug 14 22:17:24 Ganymede kernel: agpgart: Maximum main memory to use for agp
memory: 439M
Aug 14 22:17:24 Ganymede xinetd[504]: xinetd Version 2.3.10 started with
libwrap options compiled in.
Aug 14 22:17:24 Ganymede kernel: agpgart: AGP aperture is 64M @ 0xec000000
Aug 14 22:17:24 Ganymede kernel: [drm] Initialized radeon 1.9.0 20020828 on
minor 0
Aug 14 22:17:24 Ganymede kernel: loop: loaded (max 8 devices)
Aug 14 22:17:24 Ganymede xinetd[504]: Started working: 0 available services
Aug 14 22:17:24 Ganymede kernel: Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
Aug 14 22:17:24 Ganymede kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Aug 14 22:17:24 Ganymede kernel: ICH3M: IDE controller at PCI slot 0000:00:1f.1
Aug 14 22:17:24 Ganymede kernel: PCI: Enabling device 0000:00:1f.1 (0005 ->
0007)
Aug 14 22:17:24 Ganymede kernel: ICH3M: chipset revision 2
Aug 14 22:17:24 Ganymede kernel: ICH3M: not 100%% native mode: will probe irqs
later
Aug 14 22:17:24 Ganymede kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS
settings: hda:DMA, hdb:pio
Aug 14 22:17:24 Ganymede kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS
settings: hdc:DMA, hdd:pio
Aug 14 22:17:24 Ganymede kernel: hda: IC25N030ATCS04-0, ATA DISK drive
Aug 14 22:17:24 Ganymede kernel: Using anticipatory scheduling elevator
Aug 14 22:17:24 Ganymede kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 14 22:17:24 Ganymede kernel: hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI
CD/DVD-ROM drive
Aug 14 22:17:24 Ganymede kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 14 22:17:24 Ganymede kernel: hda: max request size: 128KiB
Aug 14 22:17:24 Ganymede kernel: hda: 58605120 sectors (30005 MB) w/1768KiB
Cache, CHS=58140/16/63, UDMA(100)
Aug 14 22:17:24 Ganymede kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9
hda10 hda11 hda12 >
Aug 14 22:17:24 Ganymede kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB
Cache, UDMA(33)
Aug 14 22:17:24 Ganymede kernel: Uniform CD-ROM driver Revision: 3.12
Aug 14 22:17:24 Ganymede kernel: Yenta: CardBus bridge found at 0000:02:02.0
[107b:0600]
Aug 14 22:17:24 Ganymede kernel: Yenta IRQ list 08d8, PCI irq10
Aug 14 22:17:24 Ganymede kernel: Socket status: 30000010
Aug 14 22:17:24 Ganymede kernel: Yenta: CardBus bridge found at 0000:02:02.1
[107b:0600]
Aug 14 22:17:24 Ganymede kernel: Yenta IRQ list 08d8, PCI irq10
Aug 14 22:17:24 Ganymede kernel: Socket status: 30000006
Aug 14 22:17:24 Ganymede kernel: drivers/usb/core/usb.c: registered new driver
hiddev
Aug 14 22:17:24 Ganymede kernel: drivers/usb/core/usb.c: registered new driver
hid
Aug 14 22:17:24 Ganymede kernel: drivers/usb/input/hid-core.c: v2.0:USB HID
core driver
Aug 14 22:17:24 Ganymede kernel: mice: PS/2 mouse device common for all mice
Aug 14 22:17:24 Ganymede kernel: i8042.c: Detected active multiplexing
controller, rev 1.1.
Aug 14 22:17:24 Ganymede kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Aug 14 22:17:24 Ganymede kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Aug 14 22:17:24 Ganymede kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Aug 14 22:17:24 Ganymede kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Aug 14 22:17:24 Ganymede kernel: input: AT Set 2 keyboard on isa0060/serio0
Aug 14 22:17:24 Ganymede kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 14 22:17:24 Ganymede kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Aug 14 22:17:24 Ganymede kernel: IP: routing cache hash table of 1024 buckets,
32Kbytes
Aug 14 22:17:24 Ganymede kernel: TCP: Hash tables configured (established 32768
bind 9362)
Aug 14 22:17:24 Ganymede kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Aug 14 22:17:24 Ganymede kernel: ACPI: (supports S0 S3 S4 S5)
Aug 14 22:17:24 Ganymede kernel: kjournald starting.  Commit interval 5 seconds
Aug 14 22:17:24 Ganymede kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Aug 14 22:17:24 Ganymede kernel: VFS: Mounted root (ext3 filesystem) readonly.
Aug 14 22:17:24 Ganymede kernel: Freeing unused kernel memory: 140k freed
Aug 14 22:17:24 Ganymede kernel: EXT3 FS on hda6, internal journal
Aug 14 22:17:24 Ganymede kernel: Adding 674688k swap on /dev/hda12. 
Priority:-1 extents:1
Aug 14 22:17:24 Ganymede kernel: kjournald starting.  Commit interval 5 seconds
Aug 14 22:17:24 Ganymede kernel: EXT3 FS on hda7, internal journal
Aug 14 22:17:24 Ganymede kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Aug 14 22:17:24 Ganymede kernel: kjournald starting.  Commit interval 5 seconds
Aug 14 22:17:24 Ganymede kernel: EXT3 FS on hda8, internal journal
Aug 14 22:17:24 Ganymede kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Aug 14 22:17:24 Ganymede kernel: kjournald starting.  Commit interval 5 seconds
Aug 14 22:17:24 Ganymede kernel: EXT3 FS on hda9, internal journal
Aug 14 22:17:24 Ganymede kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Aug 14 22:17:24 Ganymede kernel: kjournald starting.  Commit interval 5 seconds
Aug 14 22:17:24 Ganymede kernel: EXT3 FS on hda10, internal journal
Aug 14 22:17:24 Ganymede kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Aug 14 22:17:24 Ganymede kernel: kjournald starting.  Commit interval 5 seconds
Aug 14 22:17:24 Ganymede kernel: EXT3 FS on hda11, internal journal
Aug 14 22:17:24 Ganymede kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Aug 14 22:17:24 Ganymede kernel: ohci1394: $Rev: 1023 $ Ben Collins
<bcollins@debian.org>
Aug 14 22:17:24 Ganymede kernel: ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10] 
MMIO=[e8207000-e82077ff]  Max Packet=[2048]
Aug 14 22:17:24 Ganymede kernel: kudzu: numerical sysctl 1 23 is obsolete.
Aug 14 22:17:24 Ganymede kernel: parport0: PC-style at 0x378 (0x778)
[PCSPP,TRISTATE]
Aug 14 22:17:24 Ganymede kernel: parport0: irq 7 detected
Aug 14 22:17:24 Ganymede kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 14 22:17:24 Ganymede kernel: cs: IO port probe 0x0100-0x04ff: excluding
0x1c0-0x1cf 0x3c0-0x3df 0x4d0-0x4d7
Aug 14 22:17:24 Ganymede kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 14 22:17:24 Ganymede kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug 14 22:17:25 Ganymede xinetd: xinetd startup succeeded
Aug 14 22:17:27 Ganymede kernel: lp0: using parport0 (polling).
Aug 14 22:17:27 Ganymede kernel: lp0: console ready
Aug 14 22:17:27 Ganymede lpd: lpd startup succeeded
Aug 14 22:17:28 Ganymede gpm: gpm startup succeeded
Aug 14 22:17:28 Ganymede crond: crond startup succeeded
Aug 14 22:17:30 Ganymede xfs: xfs startup succeeded
Aug 14 22:17:30 Ganymede anacron: anacron startup succeeded
Aug 14 22:17:30 Ganymede atd: atd startup succeeded
Aug 14 22:17:30 Ganymede local: Starting CPU autospeedstep succeeded
Aug 14 22:17:30 Ganymede kernel: warning: process `update' used the obsolete
bdflush system call
Aug 14 22:17:30 Ganymede kernel: Fix your initscripts?
Aug 14 22:17:35 Ganymede kernel: warning: process `update' used the obsolete
bdflush system call
Aug 14 22:17:35 Ganymede kernel: Fix your initscripts?
Aug 14 22:17:36 Ganymede kernel: agpgart: Found an AGP 2.0 compliant device at
0000:00:00.0.
Aug 14 22:17:36 Ganymede kernel: agpgart: Putting AGP V2 device at 0000:00:00.0
into 2x mode
Aug 14 22:17:36 Ganymede kernel: agpgart: Putting AGP V2 device at 0000:01:00.0
into 2x mode
Aug 14 22:18:41 Ganymede gdm(pam_unix)[660]: session opened for user bhchapm by
(uid=0)
Aug 14 22:18:56 Ganymede kernel: maestro3: version 1.23 built at 22:04:38 Aug
14 2003
Aug 14 22:18:56 Ganymede kernel: maestro3: Configuring ESS Allegro found at IO
0x5000 IRQ 5
Aug 14 22:18:56 Ganymede kernel: maestro3:  subvendor id: 0x0600107b
Aug 14 22:18:57 Ganymede kernel: ac97_codec: AC97 Audio codec, id:
0x4583:0x8308 (ESS Allegro ES1988)
Aug 14 22:18:57 Ganymede modprobe: FATAL: Module ac97_codec already in kernel. 
Aug 14 22:19:12 Ganymede kernel: unexpected IRQ trap at vector d0
Aug 14 22:19:43 Ganymede last message repeated 14290 times
Aug 14 22:19:45 Ganymede last message repeated 2399 times
Aug 14 22:19:45 Ganymede kernel: SysRq : Emergency Sync
Aug 14 22:19:45 Ganymede kernel: unexpected IRQ trap at vector d0
Aug 14 22:19:45 Ganymede last message repeated 11 times
Aug 14 22:19:46 Ganymede kernel: at vector d0
Aug 14 22:19:46 Ganymede kernel: unexpected IRQ trap at vector d0
Aug 14 22:19:46 Ganymede last message repeated 452 times
Aug 14 22:19:46 Ganymede kernel: Emergency Sync complete
Aug 14 22:19:46 Ganymede kernel: unexpected IRQ trap at vector d0
Aug 14 22:19:48 Ganymede last message repeated 1387 times
Aug 14 22:19:48 Ganymede kernel: SysRq : Emergency Remount R/O
Aug 14 22:19:48 Ganymede kernel: unexpected IRQ trap at vector d0

lspci -vv:

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev
04)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [d104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x2

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev
04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 96
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: e8100000-e81fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if
00 [UHCI])
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog-if
00 [UHCI])
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at 1820 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00004000-00005fff
        Memory behind bridge: e8200000-e87fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a
[Master SecP PriP])
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 1860 [size=16]
        Region 5: Memory at e8000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1880 [size=32]

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02) (prog-if 00
[Generic])
        Subsystem: Askey Computer Corp.: Unknown device 1050
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 2000 [size=256]
        Region 1: I/O ports at 1c00 [size=128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW
[Radeon Mobility 7500] (prog-if 00 [VGA])
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR+ FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller
(rev 01)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 20
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

02:02.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller
(rev 01)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 20
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 20c00000-20fff000 (prefetchable)
        Memory window 1: 21000000-213ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

02:03.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 5000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000
Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e8207000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at e8200000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM)
Ethernet Controller (rev 42)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e8206000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 5400 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

.config:

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_ICH=y
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_P4_CLOCKMOD=y
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_YENTA=y
CONFIG_CARDBUS=y
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set

#
# Device Drivers
#

#
# Texas Instruments PCILynx requires I2C bit-banging
#
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
# CONFIG_IEEE1394_AMDTP is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
# CONFIG_IP_NF_MATCH_MARK is not set
CONFIG_IP_NF_MATCH_MULTIPORT=m
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_RECENT is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
CONFIG_IP_NF_MATCH_TTL=m
# CONFIG_IP_NF_MATCH_TCPMSS is not set
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
# CONFIG_IP_NF_TARGET_REDIRECT is not set
CONFIG_IP_NF_NAT_LOCAL=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_TOS is not set
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_DSCP is not set
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
CONFIG_IP_NF_ARPTABLES=m
# CONFIG_IP_NF_ARPFILTER is not set
# CONFIG_IP_NF_ARP_MANGLE is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
CONFIG_HERMES=m
# CONFIG_PLX_HERMES is not set
# CONFIG_TMD_HERMES is not set
CONFIG_PCI_HERMES=m

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
# CONFIG_PCMCIA_HERMES is not set
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_ATMEL is not set
# CONFIG_PCMCIA_WL3501 is not set
CONFIG_NET_WIRELESS=y

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_PCMCIA_PCNET=m
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_PCMCIA_AXNET is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_ACPI=y
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=m

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y

#
# Video Adapters
#
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_STRADIS is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_VIDEO_BTCX is not set

#
# File systems
#
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
CONFIG_SND_MAESTRO3=m
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
CONFIG_SOUND_MAESTRO3=m
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_AD1980 is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
# CONFIG_USB_STORAGE is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=m
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
CONFIG_USB_OV511=m
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI26 is not set
CONFIG_USB_TIGL=m
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

Modules loaded into memory during a bootup into runlevel 3 or runlevel 5:

Module                  Size  Used by
lp                     10404  0 
parport_pc             33672  1 
parport                42816  2 lp,parport_pc
ohci1394               41728  0 
ieee1394               77452  1 ohci1394
vfat                   16256  1 
fat                    47648  1 vfat

Any relevant programs which may have miscompiled 2.6.0-test3 or may have
hidden bugs exposed by 2.6.0-test3:

gcc: 			3.2.2 (problem?)
make:			3.79.1
binutils:		2.13.90.0.8 20030206 (problem?)
util-linux:		2.11y
module-init-tools:	0.9.11a from modutils-2.4.21-18
e2fsprogs:		1.32 20021109
pcmcia-cs:		3.2.4
procps:			2.0.12

The laptop in question is a Gateway 600S.

TIA

Brad Chapman

P.S: Please CC me directly; I follow the list at
www.ussg.iu.edu/hypermail/linux/kernel

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
