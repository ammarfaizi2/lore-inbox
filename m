Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTKITQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 14:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTKITQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 14:16:04 -0500
Received: from pc4.fpw.ch ([194.209.117.3]:3091 "EHLO server4.fpw.ch")
	by vger.kernel.org with ESMTP id S262765AbTKITPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 14:15:41 -0500
Subject: testing 2.6.0-test9-mm2
From: Alexey Goldin <ab_goldin@swissmail.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-k91oC2L5WC+oJ9rwFW9i"
Message-Id: <1068405354.15805.33.camel@hobbit>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 09 Nov 2003 11:15:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k91oC2L5WC+oJ9rwFW9i
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Please cc: replies to may email, unfortunately I do not have time to go
through the whole mailing list. Thanks!

The following problems were present in all 2.6.0 kernels since -test7,
vanilla or -mm tree, Asus M3N laptop with 1G of memory. I have not
tetsted 2.5 or 2.6.0-test before those.

0) Not very important: the following message dominates
/var/log/messages, about 99% by volume:

Nov  8 07:38:41 hobbit kernel:      osl-0885 [1457959]
os_wait_semaphore     : Failed to acquire semaphore[f7ffe5a0|1|0],
AE_TIME


The same problem happens in latest 2.4 series with latest ACPI patches.

1) I have to add option mem=1008M, otherwise the system is very slow,
apparently because last 16 Mb are not cached:

 cat /proc/mtrr:
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x20000000 ( 512MB), size= 256MB: write-back, count=1
reg02: base=0x30000000 ( 768MB), size= 128MB: write-back, count=1
reg03: base=0x38000000 ( 896MB), size=  64MB: write-back, count=1
reg04: base=0x3c000000 ( 960MB), size=  32MB: write-back, count=1
reg05: base=0x3e000000 ( 992MB), size=  16MB: write-back, count=1
reg06: base=0xf0000000 (3840MB), size= 128MB: write-combining, count=1




2) PCMCIA does not work. Error messages --- see in snippet from
/var/log/messages. Works fine in 2.4 series

3) Sound does not work, neither ALSA nor i810_audio. See
/var/log/messages. 2.4 version is Ok. 

4) usb_storage is broken with Sony-F505V, the problem similar to one
described in 
http://www.ussg.iu.edu/hypermail/linux/kernel/0302.2/0162.html

It worked in 2.4 series.

Here are messages:

Nov  9 10:36:17 hobbit kernel: hub 1-0:1.0: new USB device on port 2,
assigned address 3
Nov  9 10:36:17 hobbit kernel: scsi1 : SCSI emulation for USB Mass
Storage devices
Nov  9 10:36:17 hobbit kernel:   Vendor: Sony      Model: Sony
DSC          Rev: 2.10
Nov  9 10:36:17 hobbit kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 02
Nov  9 10:36:17 hobbit kernel: Attached scsi generic sg1 at scsi1,
channel 0, id 0, lun 0,  type 0
Nov  9 10:36:17 hobbit scsi.agent[15256]: disk at
/devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0/host1/1:0:0:0
Nov  9 10:36:17 hobbit kernel: SCSI device sda: 126848 512-byte hdwr
sectors (65 MB)
Nov  9 10:36:17 hobbit kernel: sda: Write Protect is off
Nov  9 10:36:17 hobbit kernel: SCSI device (ioctl) reports ILLEGAL
REQUEST.
Nov  9 10:36:17 hobbit kernel: SCSI device sda: 126848 512-byte hdwr
sectors (65 MB)
Nov  9 10:36:17 hobbit kernel: sda: Write Protect is off
Nov  9 10:36:17 hobbit kernel: SCSI device sda: 126848 512-byte hdwr
sectors (65 MB)
Nov  9 10:36:17 hobbit kernel: sda: Write Protect is off
Nov  9 10:36:17 hobbit kernel:  sda:<3>Buffer I/O error on device sda,
logical block 0
Nov  9 10:36:17 hobbit kernel:  unable to read partition table
Nov  9 10:36:17 hobbit kernel:  sda:<3>Buffer I/O error on device sda,
logical block 0
Nov  9 10:36:17 hobbit kernel:  unable to read partition table
and later:
Nov  9 10:36:52 hobbit kernel: usb 1-2: USB disconnect, address 3
Nov  9 10:36:52 hobbit kernel: Badness in atomic_dec_and_test at
include/asm/atomic.h:150
Nov  9 10:36:52 hobbit kernel: Call Trace:
Nov  9 10:36:52 hobbit kernel:  [kobject_put+126/128]
kobject_put+0x7e/0x80
Nov  9 10:36:52 hobbit kernel:  [scsi_remove_host+92/121]
scsi_remove_host+0x5c/0x79
Nov  9 10:36:52 hobbit kernel:  [__crc_pm_idle+3948745/5541136]
storage_disconnect+0x44/0x54 [usb_storage]
Nov  9 10:36:52 hobbit kernel:  [__crc_pm_idle+721554/5541136]
usb_unbind_interface+0x78/0x7a [usbcore]
Nov  9 10:36:52 hobbit kernel:  [device_release_driver+100/102]
device_release_driver+0x64/0x66
Nov  9 10:36:52 hobbit kernel:  [bus_remove_device+85/150]
bus_remove_device+0x55/0x96
Nov  9 10:36:52 hobbit kernel:  [device_del+93/155] device_del+0x5d/0x9b
Nov  9 10:36:52 hobbit kernel:  [__crc_pm_idle+746717/5541136]
usb_disable_device+0x71/0xac [usbcore]
Nov  9 10:36:52 hobbit kernel:  [__crc_pm_idle+724272/5541136]
usb_disconnect+0x9b/0xe8 [usbcore]
Nov  9 10:36:52 hobbit kernel:  [__crc_pm_idle+734033/5541136]
hub_port_connect_change+0x318/0x31d [usbcore]
Nov  9 10:36:52 hobbit kernel:  [__crc_pm_idle+732313/5541136]
hub_port_status+0x3c/0xa7 [usbcore]
Nov  9 10:36:52 hobbit kernel:  [__crc_pm_idle+734761/5541136]
hub_events+0x2d3/0x346 [usbcore]
Nov  9 10:36:52 hobbit kernel:  [__crc_pm_idle+734921/5541136]
hub_thread+0x2d/0xe4 [usbcore]
Nov  9 10:36:52 hobbit kernel:  [ret_from_fork+6/20]
ret_from_fork+0x6/0x14
Nov  9 10:36:52 hobbit kernel:  [default_wake_function+0/46]
default_wake_function+0x0/0x2e
Nov  9 10:36:52 hobbit kernel:  [__crc_pm_idle+734876/5541136]
hub_thread+0x0/0xe4 [usbcore]
Nov  9 10:36:52 hobbit kernel:  [kernel_thread_helper+5/11]
kernel_thread_helper+0x5/0xb
Nov  9 10:36:52 hobbit kernel: 




/proc/config.gz is attached.



here is the  startup part of /var/log/messages:

 Nov  8 12:27:23 hobbit syslogd 1.4.1#13: restart.
Nov  8 12:27:23 hobbit kernel: klogd 1.4.1#13, log source = /proc/kmsg
started.
Nov  8 12:27:23 hobbit kernel: Inspecting
/boot/System.map-2.6.0-test9-mm2
Nov  8 12:27:24 hobbit kernel: Loaded 32766 symbols from
/boot/System.map-2.6.0-test9-mm2.
Nov  8 12:27:24 hobbit kernel: Symbols match kernel version 2.6.0.
Nov  8 12:27:24 hobbit kernel: No module symbols loaded - kernel modules
not enabled. 
Nov  8 12:27:24 hobbit kernel: Linux version 2.6.0-test9-mm2
(root@hobbit) (gcc version 3.3.2 (Debian)) #1 Thu Nov 6 14:42:00 PST
2003
Nov  8 12:27:24 hobbit kernel: BIOS-provided physical RAM map:
Nov  8 12:27:24 hobbit kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Nov  8 12:27:24 hobbit kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Nov  8 12:27:24 hobbit kernel:  BIOS-e820: 00000000000e0000 -
0000000000100000 (reserved)
Nov  8 12:27:24 hobbit kernel:  BIOS-e820: 0000000000100000 -
000000003f740000 (usable)
Nov  8 12:27:24 hobbit kernel:  BIOS-e820: 000000003f740000 -
000000003f750000 (ACPI data)
Nov  8 12:27:24 hobbit kernel:  BIOS-e820: 000000003f750000 -
000000003f800000 (ACPI NVS)
Nov  8 12:27:24 hobbit kernel: user-defined physical RAM map:
Nov  8 12:27:24 hobbit kernel:  user: 0000000000000000 -
000000000009fc00 (usable)
Nov  8 12:27:24 hobbit kernel:  user: 000000000009fc00 -
00000000000a0000 (reserved)
Nov  8 12:27:24 hobbit kernel:  user: 00000000000e0000 -
0000000000100000 (reserved)
Nov  8 12:27:24 hobbit kernel:  user: 0000000000100000 -
000000003f000000 (usable)
Nov  8 12:27:24 hobbit kernel: Warning only 896MB will be used.
Nov  8 12:27:24 hobbit kernel: Use a HIGHMEM enabled kernel.
Nov  8 12:27:24 hobbit kernel: 896MB LOWMEM available.
Nov  8 12:27:24 hobbit kernel: On node 0 totalpages: 229376
Nov  8 12:27:24 hobbit kernel:   DMA zone: 4096 pages, LIFO batch:1
Nov  8 12:27:24 hobbit kernel:   Normal zone: 225280 pages, LIFO
batch:16
Nov  8 12:27:24 hobbit kernel:   HighMem zone: 0 pages, LIFO batch:1
Nov  8 12:27:24 hobbit kernel: DMI 2.3 present.
Nov  8 12:27:24 hobbit kernel: ACPI: RSDP (v000
ACPIAM                                    ) @ 0x000f4b70
Nov  8 12:27:24 hobbit kernel: ACPI: RSDT (v001 A M I  OEMRSDT 
0x05000314 MSFT 0x00000097) @ 0x3f740000
Nov  8 12:27:24 hobbit kernel: ACPI: FADT (v002 A M I  OEMFACP 
0x05000314 MSFT 0x00000097) @ 0x3f740200
Nov  8 12:27:24 hobbit kernel: ACPI: OEMB (v001 A M I  OEMBIOS 
0x05000314 MSFT 0x00000097) @ 0x3f750040
Nov  8 12:27:24 hobbit kernel: ACPI: DSDT (v001  0ABBD 0ABBD001
0x00000001 MSFT 0x0100000d) @ 0x00000000
Nov  8 12:27:24 hobbit kernel: Building zonelist for node : 0
Nov  8 12:27:24 hobbit kernel: Kernel command line: root=/dev/hda2
rootfs=ext3  mem=1008M  resume=/dev/hda1  
Nov  8 12:27:24 hobbit kernel: current: c03f5a60
Nov  8 12:27:24 hobbit kernel: current->thread_info: c047a000
Nov  8 12:27:24 hobbit kernel: Initializing CPU#0
Nov  8 12:27:24 hobbit kernel: PID hash table entries: 4096 (order 12:
32768 bytes)
Nov  8 12:27:24 hobbit kernel: Detected 600.276 MHz processor.
Nov  8 12:27:24 hobbit kernel: Using tsc for high-res timesource
Nov  8 12:27:24 hobbit kernel: Console: colour VGA+ 80x25
Nov  8 12:27:24 hobbit kernel: Memory: 903456k/917504k available (2529k
kernel code, 13264k reserved, 1029k data, 220k init, 0k highmem)
Nov  8 12:27:24 hobbit kernel: zapping low mappings.
Nov  8 12:27:24 hobbit kernel: Calibrating delay loop... 1183.74
BogoMIPS
Nov  8 12:27:24 hobbit kernel: Dentry cache hash table entries: 131072
(order: 7, 524288 bytes)
Nov  8 12:27:24 hobbit kernel: Inode-cache hash table entries: 65536
(order: 6, 262144 bytes)
Nov  8 12:27:24 hobbit kernel: Mount-cache hash table entries: 512
(order: 0, 4096 bytes)
Nov  8 12:27:24 hobbit kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Nov  8 12:27:24 hobbit kernel: CPU: L2 cache: 1024K
Nov  8 12:27:24 hobbit kernel: Intel machine check architecture
supported.
Nov  8 12:27:24 hobbit kernel: Intel machine check reporting enabled on
CPU#0.
Nov  8 12:27:24 hobbit kernel: CPU: Intel(R) Pentium(R) M processor
1400MHz stepping 05
Nov  8 12:27:24 hobbit kernel: Enabling fast FPU save and restore...
done.
Nov  8 12:27:24 hobbit kernel: Enabling unmasked SIMD FPU exception
support... done.
Nov  8 12:27:24 hobbit kernel: Checking 'hlt' instruction... OK.
Nov  8 12:27:24 hobbit kernel: POSIX conformance testing by UNIFIX
Nov  8 12:27:24 hobbit kernel: NET: Registered protocol family 16
Nov  8 12:27:24 hobbit kernel: EISA bus registered
Nov  8 12:27:24 hobbit kernel: PCI: Using configuration type 1
Nov  8 12:27:24 hobbit kernel: mtrr: v2.0 (20020519)
Nov  8 12:27:24 hobbit kernel: ACPI: Subsystem revision 20031002
Nov  8 12:27:24 hobbit kernel:  tbxface-0117 [03] acpi_load_tables     
: ACPI Tables successfully acquired
Nov  8 12:27:24 hobbit kernel: Parsing all Control
Methods:............................................................................................................................................................................................................................................................................................................................................
Nov  8 12:27:24 hobbit kernel: Table [DSDT](id F004) - 1064 Objects with
55 Devices 332 Methods 29 Regions
Nov  8 12:27:24 hobbit kernel: ACPI Namespace successfully loaded at
root c04e983c
Nov  8 12:27:24 hobbit kernel: ACPI: IRQ 9 was Edge Triggered, setting
to Level Triggerd
Nov  8 12:27:24 hobbit kernel: evxfevnt-0093 [04] acpi_enable          
: Transition to ACPI mode successful
Nov  8 12:27:24 hobbit kernel: evgpeblk-0748 [06] ev_create_gpe_block  
: GPE 00 to 31 [_GPE] 4 regs at 000000000000E428 on int 9
Nov  8 12:27:24 hobbit kernel: Completing Region/Field/Buffer/Package
initialization:....................................................................................................................................
Nov  8 12:27:24 hobbit kernel: Initialized 29/29 Regions 30/30 Fields
42/42 Buffers 31/31 Packages (1072 nodes)
Nov  8 12:27:24 hobbit kernel: Executing all Device _STA and_INI
methods:........................................................
Nov  8 12:27:24 hobbit kernel: 56 Devices found containing: 56 _STA, 5
_INI methods
Nov  8 12:27:24 hobbit kernel: ACPI: Interpreter enabled
Nov  8 12:27:24 hobbit kernel: ACPI: Using PIC for interrupt routing
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Nov  8 12:27:24 hobbit kernel: PCI: Probing PCI hardware (bus 00)
Nov  8 12:27:24 hobbit kernel: PCI: Ignoring BAR0-3 of IDE controller
0000:00:1f.1
Nov  8 12:27:24 hobbit kernel: Transparent bridge - 0000:00:1e.0
Nov  8 12:27:24 hobbit kernel: ACPI: Embedded Controller [EC0] (gpe 28)
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4
5 6 7 *11 12)
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4
5 6 7 11 12)
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *4
12)
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *5
6)
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 6
*11)
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3
7)
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 4
7)
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs *4
6 12)
Nov  8 12:27:24 hobbit kernel: ACPI: Power Resource [GFAN] (off)
Nov  8 12:27:24 hobbit kernel: Linux Plug and Play Support v0.97 (c)
Adam Belay
Nov  8 12:27:24 hobbit kernel: PnPBIOS: Scanning system for PnP BIOS
support...
Nov  8 12:27:24 hobbit kernel: PnPBIOS: Found PnP BIOS installation
structure at 0xc00f2e00
Nov  8 12:27:24 hobbit kernel: PnPBIOS: PnP BIOS version 1.0, entry
0xf0000:0x39da, dseg 0xf0000
Nov  8 12:27:24 hobbit kernel: PnPBIOS: 14 nodes reported by PnP BIOS;
14 recorded by driver
Nov  8 12:27:24 hobbit kernel: SCSI subsystem initialized
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKA] enabled
at IRQ 11
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKD] enabled
at IRQ 5
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKC] enabled
at IRQ 4
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKH] enabled
at IRQ 4
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKB] enabled
at IRQ 5
Nov  8 12:27:24 hobbit kernel: ACPI: PCI Interrupt Link [LNKE] enabled
at IRQ 11
Nov  8 12:27:24 hobbit kernel: PCI: Using ACPI for IRQ routing
Nov  8 12:27:24 hobbit kernel: PCI: if you experience problems, try
using option 'pci=noacpi' or even 'acpi=off'
Nov  8 12:27:24 hobbit kernel: Machine check exception polling timer
started.
Nov  8 12:27:24 hobbit kernel: ikconfig 0.7 with /proc/config*
Nov  8 12:27:24 hobbit kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Nov  8 12:27:24 hobbit kernel: udf: registering filesystem
Nov  8 12:27:24 hobbit kernel: Initializing Cryptographic API
Nov  8 12:27:24 hobbit kernel: pty: 256 Unix98 ptys configured
Nov  8 12:27:24 hobbit kernel: lp: driver loaded but no devices found
Nov  8 12:27:24 hobbit kernel: Real Time Clock Driver v1.12
Nov  8 12:27:24 hobbit kernel: Linux agpgart interface v0.100 (c) Dave
Jones
Nov  8 12:27:24 hobbit kernel: agpgart: Detected an Intel 855 Chipset.
Nov  8 12:27:24 hobbit kernel: agpgart: Maximum main memory to use for
agp memory: 816M
Nov  8 12:27:24 hobbit kernel: agpgart: Detected 8060K stolen memory.
Nov  8 12:27:24 hobbit kernel: agpgart: AGP aperture is 128M @
0xf0000000
Nov  8 12:27:24 hobbit kernel: Hangcheck: starting hangcheck timer 0.5.0
(tick is 180 seconds, margin is 60 seconds).
Nov  8 12:27:24 hobbit kernel: parport0: PC-style at 0x378 (0x778)
[PCSPP(,...)]
Nov  8 12:27:24 hobbit kernel: parport0: irq 7 detected
Nov  8 12:27:24 hobbit kernel: lp0: using parport0 (polling).
Nov  8 12:27:24 hobbit kernel: Using anticipatory io scheduler
Nov  8 12:27:24 hobbit kernel: floppy0: no floppy controllers found
Nov  8 12:27:24 hobbit kernel: RAMDISK driver initialized: 16 RAM disks
of 4096K size 1024 blocksize
Nov  8 12:27:24 hobbit kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Nov  8 12:27:24 hobbit kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Nov  8 12:27:24 hobbit kernel: ICH4: IDE controller at PCI slot
0000:00:1f.1
Nov  8 12:27:24 hobbit kernel: PCI: Enabling device 0000:00:1f.1 (0005
-> 0007)
Nov  8 12:27:24 hobbit kernel: ICH4: chipset revision 3
Nov  8 12:27:24 hobbit kernel: ICH4: not 100%% native mode: will probe
irqs later
Nov  8 12:27:24 hobbit kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS
settings: hda:DMA, hdb:pio
Nov  8 12:27:24 hobbit kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS
settings: hdc:DMA, hdd:pio
Nov  8 12:27:24 hobbit kernel: hda: IC25N080ATMR04-0, ATA DISK drive
Nov  8 12:27:24 hobbit kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov  8 12:27:24 hobbit kernel: hdc: QSI CD-RW/DVD-ROM SBW-242, ATAPI
CD/DVD-ROM drive
Nov  8 12:27:24 hobbit kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov  8 12:27:24 hobbit kernel: hda: max request size: 1024KiB
Nov  8 12:27:24 hobbit kernel: hda: 156301488 sectors (80026 MB)
w/7884KiB Cache, CHS=16383/255/63
Nov  8 12:27:24 hobbit kernel:  hda: hda1 hda2 hda3
Nov  8 12:27:24 hobbit kernel: mice: PS/2 mouse device common for all
mice
Nov  8 12:27:24 hobbit kernel: input: PC Speaker
Nov  8 12:27:24 hobbit kernel: i8042.c: Detected active multiplexing
controller, rev 1.1.
Nov  8 12:27:24 hobbit kernel: serio: i8042 AUX0 port at 0x60,0x64 irq
12
Nov  8 12:27:24 hobbit kernel: serio: i8042 AUX1 port at 0x60,0x64 irq
12
Nov  8 12:27:24 hobbit kernel: serio: i8042 AUX2 port at 0x60,0x64 irq
12
Nov  8 12:27:24 hobbit kernel: Synaptics Touchpad, model: 1
Nov  8 12:27:24 hobbit kernel:  Firmware: 5.9
Nov  8 12:27:24 hobbit kernel:  180 degree mounted touchpad
Nov  8 12:27:24 hobbit kernel:  Sensor: 18
Nov  8 12:27:24 hobbit kernel:  new absolute packet format
Nov  8 12:27:24 hobbit kernel:  Touchpad has extended capability bits
Nov  8 12:27:24 hobbit kernel:  -> four buttons
Nov  8 12:27:24 hobbit kernel:  -> palm detection
Nov  8 12:27:24 hobbit kernel: input: SynPS/2 Synaptics TouchPad on
isa0060/serio4
Nov  8 12:27:24 hobbit kernel: serio: i8042 AUX3 port at 0x60,0x64 irq
12
Nov  8 12:27:24 hobbit kernel: input: AT Translated Set 2 keyboard on
isa0060/serio0
Nov  8 12:27:24 hobbit kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov  8 12:27:24 hobbit kernel: NET: Registered protocol family 2
Nov  8 12:27:24 hobbit kernel: IP: routing cache hash table of 8192
buckets, 64Kbytes
Nov  8 12:27:24 hobbit kernel: TCP: Hash tables configured (established
262144 bind 65536)
Nov  8 12:27:24 hobbit kernel: NET: Registered protocol family 1
Nov  8 12:27:24 hobbit kernel: NET: Registered protocol family 17
Nov  8 12:27:24 hobbit kernel: NET: Registered protocol family 5
Nov  8 12:27:24 hobbit kernel: Resume Machine: resuming from /dev/hda1
Nov  8 12:27:24 hobbit kernel: Resuming from device hda1
Nov  8 12:27:24 hobbit kernel: ACPI: (supports S0 S1 S3 S4 S5)
Nov  8 12:27:24 hobbit kernel: kjournald starting.  Commit interval 5
seconds
Nov  8 12:27:24 hobbit kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Nov  8 12:27:24 hobbit kernel: VFS: Mounted root (ext3 filesystem)
readonly.
Nov  8 12:27:24 hobbit kernel: Freeing unused kernel memory: 220k freed
Nov  8 12:27:24 hobbit kernel: Adding 1959888k swap on /dev/hda1. 
Priority:-1 extents:1
Nov  8 12:27:24 hobbit kernel: EXT3 FS on hda2, internal journal
Nov  8 12:27:24 hobbit kernel: drivers/usb/core/usb.c: registered new
driver usbfs
Nov  8 12:27:24 hobbit kernel: drivers/usb/core/usb.c: registered new
driver hub
Nov  8 12:27:24 hobbit kernel: drivers/usb/core/usb.c: registered new
driver hid
Nov  8 12:27:24 hobbit kernel: drivers/usb/input/hid-core.c: v2.0:USB
HID core driver
Nov  8 12:27:24 hobbit kernel: scsi0 : SCSI host adapter emulation for
IDE ATAPI devices
Nov  8 12:27:24 hobbit kernel:   Vendor: QSI       Model: CDRW/DVD
SBW-242  Rev: UX02
Nov  8 12:27:24 hobbit kernel:   Type:  
CD-ROM                             ANSI SCSI revision: 02
Nov  8 12:27:24 hobbit kernel: sr0: scsi3-mmc drive: 4x/24x writer cd/rw
xa/form2 cdda tray
Nov  8 12:27:24 hobbit kernel: Uniform CD-ROM driver Revision: 3.12
Nov  8 12:27:24 hobbit kernel: Attached scsi generic sg0 at scsi0,
channel 0, id 0, lun 0,  type 5
Nov  8 12:27:24 hobbit kernel: Intel(R) PRO/100 Network Driver - version
2.3.30-k1
Nov  8 12:27:24 hobbit kernel: Copyright (c) 2003 Intel Corporation
Nov  8 12:27:24 hobbit kernel: 
Nov  8 12:27:24 hobbit kernel: e100: eth0: Intel(R) PRO/100 Network
Connection
Nov  8 12:27:24 hobbit kernel:   Hardware receive checksums enabled
Nov  8 12:27:24 hobbit kernel: 
Nov  8 12:27:24 hobbit kernel: warning: process `update' used the
obsolete bdflush system call
Nov  8 12:27:24 hobbit kernel: Fix your initscripts?
Nov  8 12:27:24 hobbit kernel: Intel 810 + AC97 Audio, version 0.24,
14:46:44 Nov  6 2003
Nov  8 12:27:24 hobbit kernel: PCI: Enabling device 0000:00:1f.5 (0005
-> 0007)
Nov  8 12:27:24 hobbit kernel: i810: Intel ICH4 found at IO 0xe100 and
0xe000, MEM 0x3f000400 and 0x3f000600, IRQ 5
Nov  8 12:27:24 hobbit kernel: i810: Intel ICH4 mmio at 0xf89bc400 and
0xf89be600
Nov  8 12:27:24 hobbit kernel: i810_audio: Primary codec has ID 0
Nov  8 12:27:24 hobbit kernel: i810_audio: Audio Controller supports 6
channels.
Nov  8 12:27:24 hobbit kernel: i810_audio: Defaulting to base 2 channel
mode.
Nov  8 12:27:24 hobbit kernel: i810_audio: Resetting connection 0
Nov  8 12:27:24 hobbit kernel: i810_audio: Connection 0 with codec id 0
Nov  8 12:27:24 hobbit kernel: ac97_codec: AC97  codec, id:
0xcccc:0x8ccc (Unknown)
Nov  8 12:27:24 hobbit kernel: drivers/usb/host/uhci-hcd.c: USB
Universal Host Controller Interface driver v2.1
Nov  8 12:27:24 hobbit kernel: uhci_hcd 0000:00:1d.0: UHCI Host
Controller
Nov  8 12:27:24 hobbit kernel: uhci_hcd 0000:00:1d.0: irq 11, io base
0000d480
Nov  8 12:27:24 hobbit kernel: uhci_hcd 0000:00:1d.0: new USB bus
registered, assigned bus number 1
Nov  8 12:27:24 hobbit kernel: hub 1-0:1.0: USB hub found
Nov  8 12:27:24 hobbit kernel: hub 1-0:1.0: 2 ports detected
Nov  8 12:27:24 hobbit kernel: uhci_hcd 0000:00:1d.1: UHCI Host
Controller
Nov  8 12:27:24 hobbit kernel: uhci_hcd 0000:00:1d.1: irq 5, io base
0000d800
Nov  8 12:27:24 hobbit kernel: uhci_hcd 0000:00:1d.1: new USB bus
registered, assigned bus number 2
Nov  8 12:27:24 hobbit kernel: hub 2-0:1.0: USB hub found
Nov  8 12:27:24 hobbit kernel: hub 2-0:1.0: 2 ports detected
Nov  8 12:27:24 hobbit kernel: uhci_hcd 0000:00:1d.2: UHCI Host
Controller
Nov  8 12:27:24 hobbit kernel: uhci_hcd 0000:00:1d.2: irq 4, io base
0000d880
Nov  8 12:27:24 hobbit kernel: uhci_hcd 0000:00:1d.2: new USB bus
registered, assigned bus number 3
Nov  8 12:27:24 hobbit kernel: hub 3-0:1.0: USB hub found
Nov  8 12:27:24 hobbit kernel: hub 3-0:1.0: 2 ports detected
Nov  8 12:27:24 hobbit kernel: hub 1-0:1.0: new USB device on port 2,
assigned address 2
Nov  8 12:27:24 hobbit kernel: loop: loaded (max 8 devices)
Nov  8 12:27:24 hobbit kernel: ACPI: Processor [CPU1] (supports C1 C2
C3, 8 throttling states)
Nov  8 12:27:24 hobbit kernel: input: USB HID v1.00 Mouse [Cypress Sem
PS2/USB Browser Combo Mouse] on usb-0000:00:1d.0-2
Nov  8 12:27:24 hobbit kernel: ACPI: Thermal Zone [THRM] (51 C)
Nov  8 12:27:24 hobbit kernel: drivers/usb/core/usb.c: registered new
driver usbmouse
Nov  8 12:27:24 hobbit kernel: drivers/usb/input/usbmouse.c: v1.6:USB
HID Boot Protocol mouse driver
Nov  8 12:27:24 hobbit kernel: ACPI: Battery Slot [BAT0] (battery
present)
Nov  8 12:27:24 hobbit kernel: ACPI: Battery Slot [BAT1] (battery
absent)
Nov  8 12:27:24 hobbit kernel: ACPI: Fan [FN00] (off)
Nov  8 12:27:24 hobbit kernel: ACPI: AC Adapter [AC0] (on-line)
Nov  8 12:27:24 hobbit kernel: device-mapper: 1.0.6-ioctl (2002-10-15)
initialised: dm@uk.sistina.com
Nov  8 12:27:24 hobbit kernel: device-mapper: ioctl interface mismatch:
kernel(1.0.6), user(4.0.0), cmd(0)
Nov  8 12:27:24 hobbit kernel: found reiserfs format "3.6" with standard
journal
Nov  8 12:27:24 hobbit kernel: Reiserfs journal params: device dm-0,
size 8192, journal first block 18, max trans len 1024, max batch 900,
max commit age 30, max trans age 30
Nov  8 12:27:24 hobbit kernel: reiserfs: checking transaction log (dm-0)
for (dm-0)
Nov  8 12:27:24 hobbit kernel: Using r5 hash to sort names
Nov  8 12:27:24 hobbit kernel: found reiserfs format "3.6" with standard
journal
Nov  8 12:27:24 hobbit kernel: Reiserfs journal params: device dm-1,
size 8192, journal first block 18, max trans len 1024, max batch 900,
max commit age 30, max trans age 30
Nov  8 12:27:24 hobbit kernel: reiserfs: checking transaction log (dm-1)
for (dm-1)
Nov  8 12:27:24 hobbit kernel: Using r5 hash to sort names
Nov  8 12:27:24 hobbit kernel: ip_tables: (C) 2000-2002 Netfilter core
team
Nov  8 12:27:24 hobbit kernel: ip_conntrack version 2.1 (7168 buckets,
57344 max) - 300 bytes per conntrack
Nov  8 12:27:24 hobbit kernel: Linux Kernel Card Services
Nov  8 12:27:24 hobbit kernel:   options:  [pci] [cardbus] [pm]
Nov  8 12:27:24 hobbit kernel: Intel PCIC probe: not found.
Nov  8 12:27:24 hobbit kernel: Yenta: CardBus bridge found at
0000:01:05.0 [1043:1744]
Nov  8 12:27:24 hobbit kernel: Yenta: ISA IRQ list 0000, PCI irq5
Nov  8 12:27:24 hobbit kernel: Socket status: 1fcccccc
Nov  8 12:27:29 hobbit kernel: AC'97 warm reset still in progress?
[0xccccecc7]
Nov  8 12:27:29 hobbit kernel: Intel ICH: probe of 0000:00:1f.5 failed
with error -5

-- 
Alexey Goldin <ab_goldin@swissmail.org>

--=-k91oC2L5WC+oJ9rwFW9i
Content-Disposition: attachment; filename=config.gz
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64

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

--=-k91oC2L5WC+oJ9rwFW9i--

