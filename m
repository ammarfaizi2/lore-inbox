Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTJKSGh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 14:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTJKSGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 14:06:37 -0400
Received: from marathon.simons-rock.edu ([64.209.120.71]:58524 "EHLO
	marathon.simons-rock.edu") by vger.kernel.org with ESMTP
	id S263364AbTJKSGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 14:06:06 -0400
Date: Sat, 11 Oct 2003 14:06:04 -0400 (EDT)
From: Marshal Newrock <marshal@simons-rock.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test7: suspend to disk: no mouse or sound after suspend
Message-ID: <Pine.LNX.4.58.0310111304410.14916@minerva.simons-rock.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please cc: me on all replies)

Using Gentoo (stable) with kernel 2.6.0-test7.  I had tried Software
Suspend, but 'echo 4 > /proc/acpi/sleep' did not put the computer to
sleep, so I am using Suspend-to-Disk.  The computer goes through the
shutdown, but hits an oops.  On rebooting, the state of the computer is
restored, but my USB optical mouse remains unpowered.

My mouse is the only USB device I have, so while I assume it affects the
entire USB bus, I do not know for sure.  I also do not have any other
hot-pluggable devices.

Other systems tested:
Sound (ALSA, es1371 built-in), no output after suspend.
PC Speaker (module) works.
Networking (rtl8139 built-in) works.
IDE CD-ROM (module) works.
SCSI (sym53c8xx module) works.

Suggestions and questions welcome.  Thank you.


kernel command line:
root=/dev/hda3 ro vga=307 pci=noacpi

kernel messages:
tasks: =============================|
memory: ......|
start_power_step(step: 0)
completing PM request, suspend
start_power_step(step: 0)
start_power_step(step: 1)
complete_power_step(step: 1, stat: 50, err: 0)
completing PM request, suspend
start_power_step(step: 0)
start_power_step(step: 1)
complete_power_step(step: 1, stat: 50, err: 0)
completing PM request, suspend
scheduling while atomic!
Trace:
schedule+0x586/0x590
pci_read+0x3d/0x50
schedule_timeout+0x63/0xc0
process_timeout+0x0/0x10
pci_set_power_state+0xeb/0x190
rtl8139_suspend+0x7d/0xc0
pci_device_suspend+0x2e/0x30
suspend_device+0xc2/0xd0
device_suspend+0x57/0x80
prepare+0x39/0xb0
pm_suspend_disk+0xc/0xc0
enter_state+0xa5/0xb0
acpi_suspend+0x35/0x3b
acpi_system_write_sleep+0xa1/0xc4
vfs_write+0xbe/0x130
sys_write+0x42/0x70
syscall_call+0x7/0xb

Attempting to suspend to disk.
snapshotting memory.
Image restored successfully.
scheduling while atomic!
Trace:
schedule+0x586/0x590
pci_read+0x3d/0x50
schedule_timeout+0x63/0xc0
process_timeout+0x0/0x10
pci_set_power_state+0xeb/0x190
rtl8139_resume+0x4f/0xc0
pci_device_resume+0x26/0x30
resume_device+0x29/0x30
dpm_resume+0x34/0x60
device_resume+0x19/0x30
finish+0x8/0x40
pmdisk_free+0x5/0x10
pm_suspend_disk+0x7e/0xc0
enter_state+0xa5/0xb0
acpi_suspend+0x35/0x3b
acpi_system_write_sleep+0xa1/0xc4
vfs_write+0xbe/0x130
sys_write+0x42/0x70
syscall_call+0x7/0xb

link up, 100Mbps, full-duplex, lpa 0x41E1
Wakeup request inited, waiting for !BSY...
start_power_step(step: 1000)
queue c139ba00, I/O limit 4095Mb (mask 0xffffffff)
completing PM request, resume
Wakeup request inited, waiting for !BSY...
start_power_step(step: 1000)
queue c139b600, I/O limit 4095Mb (mask 0xffffffff)
completing PM request, resume
Wakeup request inited, waiting for !BSY...
start_power_step(step: 1000)
completing PM request, resume
tasks...<3>bad: scheduling while atomic!
Trace:
schedule+0x586/0x590
wake_up_process+0x26/0x30
thaw_processes+0xb8/0x100
acpi_pm_finish+0x14/0x38
finish+0x16/0x40
pm_suspend_disk+0x7e/0xc0
enter_state+0xa5/0xb0
acpi_suspend+0x35/0x3b
acpi_system_write_sleep+0xa1/0xc4
vfs_write+0xbe/0x130
sys_write+0x42/0x70
syscall_call+0x7/0xb


scheduling while atomic!
Trace:
schedule+0x586/0x590
sys_write+0x42/0x70
work_resched+0x5/0x16

to handle kernel paging request at virtual address 400f24a8
eip:

= 0e4a7067
= 00000000
0004 [#1]
   0
   0073:[<400f24a8>]    Not tainted
00010246
is at 0x400f24a8
00000002   ebx: 00000001   ecx: 40015000   edx: 00000002
00000002   edi: 40015000   ebp: bffffb78   esp: bffffb48
007b   es: 007b   ss: 007b
bash (pid: 3553, threadinfo=ce516000 task=ce5be1c0)
bash[3553] exited with preempt_count 1

(on boot:)
version 2.6.0-test7 (crywolf@draco) (gcc version 3.2.3 20030422 (Gentoo
Linux 1.4 3.2.3-r2, propolice)) #2 Sat Oct 11 12:46:54 EDT 2003
mode to be used for restore is 133
physical RAM map:
0000000000000000 - 00000000000a0000 (usable)
00000000000f0000 - 0000000000100000 (reserved)
0000000000100000 - 000000000fff0000 (usable)
000000000fff0000 - 000000000fff3000 (ACPI NVS)
000000000fff3000 - 0000000010000000 (ACPI data)
00000000fec00000 - 00000000fec01000 (reserved)
00000000fee00000 - 00000000fee01000 (reserved)
00000000ffff0000 - 0000000100000000 (reserved)
LOWMEM available.
SMP MP-table at 000f56a0
page 000f5000 reserved twice.
page 000f6000 reserved twice.
page 000f1000 reserved twice.
page 000f2000 reserved twice.
node 0 totalpages: 65520
zone: 4096 pages, LIFO batch:1
zone: 61424 pages, LIFO batch:14
zone: 0 pages, LIFO batch:1
2.2 present.
RSDP (v000 VIA694                                    ) @ 0x000f7080
RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
MADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff6b00
DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Local APIC address 0xfee00000
LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
#0 6:6 APIC version 16
ACPI for processor (LAPIC) configuration information
MultiProcessor Specification v1.4
Wire compatibility mode.
ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
APIC #2 Version 17 at 0xFEC00000.
APIC mode:  Flat.  Using 1 I/O APICs
1
zonelist for node : 0
command line: root=/dev/hda3 ro vga=307 pci=noacpi
CPU#0
hash table entries: 1024 (order 10: 8192 bytes)
1400.618 MHz processor.
colour VGA+ 132x44
255628k/262080k available (2040k kernel code, 5732k reserved, 771k data,
136k init, 0k highmem)
delay loop... 2760.70 BogoMIPS
cache hash table entries: 32768 (order: 5, 131072 bytes)
hash table entries: 16384 (order: 4, 65536 bytes)
hash table entries: 512 (order: 0, 4096 bytes)
    After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
    After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
L2 Cache: 256K (64 bytes/line)
    After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
machine check architecture supported.
machine check reporting enabled on CPU#0.
AMD Athlon(tm) XP 1600+ stepping 02
fast FPU save and restore... done.
unmasked SIMD FPU exception support... done.
'hlt' instruction... OK.
conformance testing by UNIFIX
ExtINT on CPU#0
value before enabling vector: 00000000
value after enabling vector: 00000000
local APIC timer interrupts.
APIC timer ...
CPU clock speed is 1400.0390 MHz.
host bus clock speed is 266.0741 MHz.
Registered protocol family 16
8259A interrupt: IRQ7.
PCI BIOS revision 2.10 entry at 0xfb4d0, last bus=1
Using configuration type 1
v2.0 (20020519)
Subsystem revision 20030918
Interpreter enabled
Using PIC for interrupt routing
PCI Root Bridge [PCI0] (00:00)
Probing PCI hardware (bus 00)
PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
PCI Interrupt Link [ALKA] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
PCI Interrupt Link [ALKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
PCI Interrupt Link [ALKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
PCI Interrupt Link [ALKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
registered new driver usbfs
registered new driver hub
Probing PCI hardware
Using IRQ router default [1106/3099] at 0000:00:00.0
0.7 with /proc/config*
v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
boot_options: 0x1
Cryptographic API
Fan [FAN] (on)
Processor [CPU0] (supports C1, 2 throttling states)
Thermal Zone [THRM] (54 C)
256 Unix98 ptys configured
Time Clock Driver v1.12
agpgart interface v0.100 (c) Dave Jones
Detected VIA KT266/KY266x/KT333 chipset
Maximum main memory to use for agp memory: 203M
AGP aperture is 64M @ 0xe8000000
Initialized radeon 1.9.0 20020828 on minor 0
8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
at I/O 0x3f8 (irq = 4) is a 16550A
at I/O 0x2f8 (irq = 3) is a 16550A
loaded (max 8 devices)
Fast Ethernet driver 0.9.26
RealTek RTL8139 at 0xd081d000, 00:60:67:72:66:fd, IRQ 12
 Identified 8139 chip type 'RTL-8139A'
Multi-Platform E-IDE driver Revision: 7.00alpha2
Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
IDE controller at PCI slot 0000:00:11.1
chipset revision 6
not 100% native mode: will probe irqs later
Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:DMA
BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:pio
WDC WD200BB-00DEA0, ATA DISK drive
WDC WD400BB-32CLB0, ATA DISK drive
anticipatory io scheduler
at 0x1f0-0x1f7,0x3f6 on irq 14
Pioneer DVD-ROM ATAPIModel DVD-115 0114, ATAPI CD/DVD-ROM drive
at 0x170-0x177,0x376 on irq 15
max request size: 128KiB
39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
p1 p2 p3 p4 < p5 p6 >
max request size: 128KiB
78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
p1
USB Universal Host Controller Interface driver v2.1
0000:00:11.2: UHCI Host Controller
0000:00:11.2: irq 11, io base 0000e000
0000:00:11.2: new USB bus registered, assigned bus number 1
1-0:1.0: USB hub found
1-0:1.0: 2 ports detected
registered new driver hid
v2.0:USB HID core driver
PS/2 mouse device common for all mice
i8042 AUX port at 0x60,0x64 irq 12
AT Translated Set 2 keyboard on isa0060/serio0
i8042 KBD port at 0x60,0x64 irq 1
Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003
UTC).
failed /sbin/modprobe -- snd-card-0. error = -16
device list:
Ensoniq AudioPCI ENS1371 at 0xd000, irq 11
Registered protocol family 2
routing cache hash table of 2048 buckets, 16Kbytes
Hash tables configured (established 16384 bind 32768)
Registered protocol family 1
Registered protocol family 17
Registered protocol family 15
Reading pmdisk image.
Resume from disk failed.
(supports S0 S1 S4 S5)
starting.  Commit interval 5 seconds
mounted filesystem with ordered data mode.
Mounted root (ext3 filesystem) readonly.
devfs on /dev
unused kernel memory: 136k freed
1-0:1.0: new USB device on port 2, assigned address 2
USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on
usb-0000:00:11.2-2
498004k swap on /dev/hda2.  Priority:-1 extents:1
FS on hda3, internal journal
subsystem initialized
ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
CD-ROM driver Revision: 3.12
PC Speaker
warning: mounting unchecked fs, running e2fsck is recommended
starting.  Commit interval 5 seconds
warning: maximal mount count reached, running e2fsck is recommended
FS on hdb1, internal journal
mounted filesystem with ordered data mode.
starting.  Commit interval 5 seconds
warning: maximal mount count reached, running e2fsck is recommended
FS on hda6, internal journal
mounted filesystem with ordered data mode.
link up, 100Mbps, full-duplex, lpa 0x41E1
Found an AGP 2.0 compliant device at 0000:00:00.0.
Putting AGP V2 device at 0000:00:00.0 into 4x mode
Putting AGP V2 device at 0000:01:00.0 into 4x mode

power management kernel options:
#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
CONFIG_PM_DISK=y
CONFIG_PM_DISK_PARTITION="/dev/hda2"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

-- 
Caution: Product will be hot after heating

