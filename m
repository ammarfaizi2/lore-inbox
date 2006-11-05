Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753710AbWKESfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbWKESfe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 13:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbWKESfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 13:35:34 -0500
Received: from smtpa2.netcabo.pt ([212.113.174.17]:9072 "EHLO
	exch01smtp01.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1753710AbWKESfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 13:35:33 -0500
Message-ID: <454E2FC1.4040700@rncbc.org>
Date: Sun, 05 Nov 2006 18:38:57 +0000
From: Rui Nuno Capela <rncbc@rncbc.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
       Karsten Wiese <fzu@wemgehoertderstaat.de>, Ingo Molnar <mingo@elte.hu>
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
References: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org>	 <200611031230.24983.fzu@wemgehoertderstaat.de> <454BC8D1.1020001@rncbc.org>	 <454BF608.20803@rncbc.org> <454C714B.8030403@rncbc.org>	 <454E0976.8030303@rncbc.org>  <454E15B0.2050008@rncbc.org> <1162742535.2750.23.camel@localhost.localdomain>
In-Reply-To: <1162742535.2750.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Nov 2006 18:35:28.0132 (UTC) FILETIME=[2A6ABC40:01C70109]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Sun, 2006-11-05 at 16:47 +0000, Rui Nuno Capela wrote:
>> Rui Nuno Capela wrote:
>>> After a suggestion from Mike Galbraith, I now turned to pure and
>>> original 2.6.18-rt7 and configured with:
>>>
>>> CONFIG_FRAME_POINTER=y
>>> CONFIG_UNWIND_INFO=y
>>> CONFIG_STACK_UNWIND=y
>>>
>>> Nasty things still do happen, as the following capture can tell as evidence:
>>>
>> Some more evidence, just happening:
>>
>> ...
>> Oops: 0002 [#1]
>>  [<c0106455>] show_trace_log_lvl+0x185/0x1a0
>>  [<c0106ae2>] show_trace+0x12/0x20
>>  [<c0106c49>] dump_stack+0x19/0x20
>>  [<c02f8d2f>] __schedule+0x63f/0xea0
>>  [<c02f9700>] schedule+0x30/0x100
>>  [<c02fa5db>] rt_spin_lock_slowlock+0x9b/0x1b0
>>  [<c02fadb2>] rt_spin_lock+0x22/0x30
>>  [<c02fd8b1>] kprobe_flush_task+0x11/0x50
>>  [<c02f91fa>] __schedule+0xb0a/0xea0
>>  [<c0103b61>] cpu_idle+0xb1/0x120
>>  [<c011760f>] start_secondary+0x43f/0x500
> 
> Is there more above this log? It looks like your cutting off some stuff
> above this.
> 
> Daniel

Yes there is. However I didn't find it relevant. Here it goes now (full
captured serial-console log):

--
Linux version 2.6.18-rt7.0-smp (root@gamma-suse1) (gcc version 4.1.0
(SUSE Linux)) #1 SMP PREEMPT Sat Nov 4 15:20:54 WET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
 BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
 BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
DMI 2.3 present.
Using APIC driver default
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
Allocating PCI resources starting at 50000000 (gap: 40000000:bfb80000)
Detected 3361.206 MHz processor.
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 1 zonelists.  Total pages: 261936
Kernel command line: root=/dev/hda1 vga=0x31a resume=/dev/hda3
splash=silent console=tty0 console=ttyS0,115200n8
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
WARNING: experimental RCU implementation.
Clock event device pit configured with caps set: 07
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1030912k/1047744k available (2041k kernel code, 16444k reserved,
879k data, 224k init, 130240k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6723.96 BogoMIPS
(lpj=3361980)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6720.93 BogoMIPS
(lpj=3360466)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (13444.89 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Clock event device pit new caps set: 01
Clock event device lapic configured with caps set: 06
checking TSC synchronization across 2 CPUs: passed.
Clock event device pit new caps set: 01
Clock event device lapic configured with caps set: 06
Brought up 2 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 2512k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
pnp: 00:09: ioport range 0x680-0x6ff has been reserved
pnp: 00:09: ioport range 0x290-0x297 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fc700000-fe7fffff
  PREFETCH window: bff00000-dfefffff
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fe800000-feafffff
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 65536 (order: 9, 2621440 bytes)
TCP bind hash table entries: 32768 (order: 8, 1179648 bytes)
TCP: Hash tables configured (established 65536 bind 32768)
TCP reno registered
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1162723638.770:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 5120k,
total 262144k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:e780
vesafb: pmi: set display start = c00ce7b6, set palette = c00ce820
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce
3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 1
Starting balanced_irq
Using IPI No-Shortcut mode
ACPI: (supports<6>Time: tsc clocksource has been installed.
 S0 S1 S3 S4 S5)
Freeing unused kernel memory: 224k freed
Write protecting the kernel read-only data: 324k
Trying manual resume from /dev/hda3
Starting udevd
Creating devices
logips2pp: Detected unknown logitech mouse model 0
input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
Loading ide-core
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Loading ide-disk
Loading piix
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6L250R0, ATA DISK drive
hdb: Maxtor 6L250R0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 512KiB
hda: 490234752 sectors (251000 MB) w/16384KiB Cache, CHS=30515/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
hdb: max request size: 512KiB
hdb: 490234752 sectors (251000 MB) w/16384KiB Cache, CHS=30515/255/63,
UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 >
hdc: ASUS DRW-1608P2S, ATAPI CD/DVD-ROM drive
hdd: TOSHIBA CD/DVDW SDR5372V, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Loading processor
Loading thermal
Loading fan
Loading reiserfs
Loading jbd
Loading ext3
Attempting manual resume
Waiting for device /dev/hda1 to appear:  ok
rootfs: major=3 minor=1 devn=769
fsck 1.38 (30-Jun-2005)
[/bin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/hda1
/dev/hda1: clean, 109695/1954560 files, 948946/3907803 blocks
fsck succeeded. Mounting root device read-write.kjournald starting.
Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

Mounting root /dev/hda1
INIT: version 2.86 booting
System Boot Control: Running /etc/init.d/boot
Mounting procfs at /procdone
Mounting sysfs at /sysdone
Mounting debugfs at /sys/kernel/debugdone
Initializing /devdone
Mounting devpts at /dev/ptsdone
Configuring serial ports...
/dev/ttyS0 at 0x03f8 (irq = 4) is a 16550A
Configured serial ports
doneshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
done
Starting udevd ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 20 (level,
low) -> IRQ 17
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[17]
MMIO=[feaff800-feafffff]  Max Packet=[2048]  IR/IT contexts=[4/8]
Linux agpgart interface v0.101 (c) Dave Jones
hdc: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2000kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
agpgart: Detected an Intel 865 Chipset.
hdd: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
agpgart: AGP aperture is 256M @ 0xe0000000
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 18
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 19, io base 0x0000ef00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 20, io base 0x0000ef20
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 16, io base 0x0000ef40
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-2: configuration #1 chosen from 1 choice
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 21
i8xx TCO timer: initialized (0x0860). heartbeat=30 sec (nowayout=0)
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: PCI Interrupt 0000:02:0d.0[A] -> GSI 21 (level, low) -> IRQ 22
ALSA sound/pci/cs46xx/cs46xx_lib.c:3825: Crystal EAPD support forced on.
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
usb 2-1: new low speed USB device using uhci_hcd and address 2
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfebff800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usb 1-2: USB disconnect, address 2
usb 4-2: new high speed USB device using ehci_hcd and address 2
usb 4-2: configuration #1 chosen from 1 choice
usb 2-1: new low speed USB device using uhci_hcd and address 3
usb 2-1: configuration #1 chosen from 1 choice
input: Wacom Graphire2 4x5 as /class/input/input3
usbcore: registered new driver wacom
drivers/usb/input/wacom.c: v1.45:USB Wacom Graphire and Wacom Intuos
tablet driver
gameport: CS46xx Gameport is pci0000:02:0d.0/gameport0, speed 1420kHz
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 18
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
udevd-event[2030]: run_program: exec of program '/usr/sbin/alsactl' failed
intel8x0_measure_ac97_clock: measured 51247 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 21
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
udevd-event[2117]: run_program: exec of program '/usr/sbin/alsactl' failed
Intel 82802 RNG detected
udevd-event[2144]: run_program: exec of program '/usr/sbin/alsactl' failed
done
Activating device mapper...
Loading required kernel modules
donedevice-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised:
dm-devel@redhat.com
done
Starting MD Raid done
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Checking file systems...
fsck 1.38 (30-Jun-2005)
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /usr] fsck.ext3 -a /dev/hda5
/dev/hda5: clean, 326314/3908128 files, 1705254/7813606 blocks
[/sbin/fsck.ext3 (1) -- /home] fsck.ext3 -a /dev/hda7
/dev/hda7 has been mounted 24 times without being checked, check forced.
/dev/hda7: 26544/7815168 files (3.3% non-contiguous), 3774544/15627220
blocks
donedone
Mounting local file systems...
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
debugfs on /sys/kernel/debug type debugfs (rw)
udev on /dev type tmpfs (rw)
loop: loaded (max 8 devices)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
kjournald starting.  Commit interval 5 seconds
/dev/hda5 on /usEXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
r type ext3 (rw,noatime,noacl)
kjournald starting.  Commit interval 5 seconds
/dev/hda7 on /hoEXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
me type ext3 (rw,noatime,noacl)
doneSetting up the hardware clockdone
Retry device configurationdone
Setting up hostname 'gamma-suse1'done
Setting up loopback interface     lo
    lo        IP address: 127.0.0.1/8
done
Creating /var/log/boot.msg
doneshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Adding 1959920k swap on /dev/hda3.  Priority:-1 extents:1 across:1959920k
Adding 1959920k swap on /dev/hdb3.  Priority:-2 extents:1 across:1959920k
Activating remaining swap-devices in /etc/fstab...
doneSetting current sysctl status from /etc/sysctl.conf
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.conf.all.rp_filter = 1
done
Enabling syn flood protectiondone
Disabling IP forwardingdone
done
done
System Boot Control: The system has been set up
System Boot Control: Running /etc/init.d/boot.local
net.core.netdev_max_backlog = 5
doneINIT: Entering runlevel: 5
blogd: Warning: the ioctl TIOCGDEV is not known by the kernel
Boot logging started on /dev/ttyS0(/dev/console) at Sun Nov  5 10:48:50 2006
Master Resource Control: previous runlevel: N, switching to runlevel: 5
Starting D-BUS daemondone
acpid: loading ACPI modules ( Starting resource managerdone
Initializing random number generatordone
ac Starting syslog servicesdone
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
microcode: CPU1 updated from revision 0x11 to 0x2e, date = 08112004
microcode: CPU0 updated from revision 0x11 to 0x2e, date = 08112004
Checking/updating CPU microcode done
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
w83627hf 9191-0290: Reading VID from GPIO5
Starting up sensors: done
battery button ) done
Starting acpid done
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
Starting HAL daemondone
Setting up network interfaces:
Loading keymap i386/qwerty/pt-latin1.map.gz
doneLoading compose table winkeys shiftctrl latin1.adddone
Start Unicode mode
doneLoading console font lat9w-16.psfu  -m trivial G0:loadable
doneRequested buffer size 2048, fragment size 1024
ALSA pcm 'default' set buffer size 7524, period size 3760 bytes
TiMidity starting in ALSA server mode
Opening sequencer port: 128:0 128:1 128:2 128:3
    lo
    lo        IP address: 127.0.0.1/8
done    eth0      device: 3Com Corporation 3c940 10/100/1000Base-T
[Marvell] (rev 12)
    eth0      configuration: eth-id-00:0c:6e:b3:48:ab
    eth0      IP address: 192.168.1.5/24
doneSetting up service network  .  .  .  .  .  .  .  .  .  .  .  .  .  .
 .  .done
Starting SSH daemondone
Starting CRON daemondone
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
drivers/usb/input/wacom.c: wacom_graphire_irq - usb_submit_urb failed
with result -1
ADDRCONF(NETDEV_UP): eth0: link is not ready
IPv6 over IPv4 tunneling driver
rtirq: start [rtc] irq=8 pid=364 prio=90: OK.
rtirq: start [snd] irq=18 pid=1993 prio=80: OK.
rtirq: start [snd] irq=22 pid=1831 prio=79: OK.
rtirq: start [snd] irq=21 pid=1766 prio=78: OK.
rtirq: start [uhci_hcd] irq=16 pid=1708 prio=70: OK.
rtirq: start [uhci_hcd] irq=19 pid=1619 prio=69: OK.
rtirq: start [uhci_hcd] irq=20 pid=1655 prio=68: OK.
rtirq: start [ehci_hcd] irq=23 pid=1832 prio=70: OK.
rtirq: start [i8042] irq=1 pid=411 prio=60: OK.
rtirq: start [i8042] irq=12 pid=401 prio=59: OK.
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  disabled
    tx-checksum:     disabled
    rx-checksum:     disabled
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Starting service kdmdone
Starting service kdmdone
Master Resource Control: runlevel 5 has been reached
Skipped services in runlevel 5: splash
Oops: 0002 [#1]
 [<c0106455>] show_trace_log_lvl+0x185/0x1a0
 [<c0106ae2>] show_trace+0x12/0x20
 [<c0106c49>] dump_stack+0x19/0x20
 [<c02f8d2f>] __schedule+0x63f/0xea0
 [<c02f9700>] schedule+0x30/0x100
 [<c02fa5db>] rt_spin_lock_slowlock+0x9b/0x1b0
 [<c02fadb2>] rt_spin_lock+0x22/0x30
 [<c02fd8b1>] kprobe_flush_task+0x11/0x50
 [<c02f91fa>] __schedule+0xb0a/0xea0
 [<c0103b61>] cpu_idle+0xb1/0x120
 [<c011760f>] start_secondary+0x43f/0x500
BUG: scheduling from the idle thread!
 [<c0106455>] show_trace_log_lvl+0x185/0x1a0
 [<c0106ae2>] show_trace+0x12/0x20
 [<c0106c49>] dump_stack+0x19/0x20
 [<c02f8dba>] __schedule+0x6ca/0xea0
 [<c02f9700>] schedule+0x30/0x100
PREEMPT SMP
Modules linked in: appletalk ax25 ipx p8023 ipv6 snd_seq_dummy
snd_pcm_oss edd snd_mixer_oss snd_seq_midi snd_seq_midi_event snd_seq
w83627hf hwmon_vid button hwmon battery i2c_isa ac loop dm_mod intel_rng
usbhid wacom shpchp snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda
snd_cs8427 pci_hotplug snd_intel8x0 snd_i2c i8xx_tco snd_cs46xx
snd_mpu401_uart gameport snd_rawmidi snd_ac97_codec snd_ac97_bus sk98lin
snd_seq_device snd_pcm snd_timer snd ehci_hcd snd_page_alloc uhci_hcd
soundcore usbcore i2c_i801 i2c_core intel_agp ide_cd agpgart cdrom
ohci1394 ieee1394 ext3 jbd reiserfs fan thermal processor piix ide_disk
ide_core
CPU:    0
EIP:    0060:[<c011f4cb>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18-rt7.0-smp #1)
EIP is at enqueue_task+0x2b/0x90
eax: c188f28c   ebx: c188ee10   ecx: 00000000   edx: dfd490d8
esi: dfd490b0   edi: c188edc0   ebp: c042be34   esp: c042be2c
ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Process swapper (pid: 0, ti=c042a000 task=c0352840 task.ti=c042a000)
Stack: c188edc0 dfd490b0 c042be44 c011f551 00000001 dfd490b0 c042bea8
c01218c1
       00000401 00000100 00000000 00000000 0000001f c042a000 00000001
00000000
       00000004 c180edc0 dfd485b0 c042be88 c011f551 00000001 a1fdbacf
c042bea4
Call Trace:
 [<c011f551>] __activate_task+0x21/0x40
 [<c01218c1>] try_to_wake_up+0x321/0x450
 [<c0121a69>] wake_up_process_mutex+0x19/0x20
 [<c0144ab7>] wakeup_next_waiter+0xd7/0x1b0
 [<c02fa46c>] rt_spin_lock_slowunlock+0x4c/0x70
 [<c02fad88>] rt_spin_unlock+0x38/0x40
 [<c02fd8da>] kprobe_flush_task+0x3a/0x50
 [<c02f91fa>] __schedule+0xb0a/0xea0
 [<c0103b61>] cpu_idle+0xb1/0x120
 [<c01006d3>] rest_init+0x43/0x50
 [<c042f890>] start_kernel+0x360/0x440
Code: 55 89 e5 56 89 c6 53 89 d3 f6 40 0c 08 74 09 a1 60 60 35 c0 85 c0
75 4b 8b 46 1c 8d 56 28 8d 44 c3 1c 8b 48 04 89 46 28 89 50 04 <89> 11
89 4a 04 8b 46 1c 83 43 04 01 0f ab 43 08 83 7e 1c 63 89
EIP: [<c011f4cb>] enqueue_task+0x2b/0x90 SS:ESP 0068:c042be2c
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 [<c0106455>] show_trace_log_lvl+0x185/0x1a0
 [<c0106ae2>] show_trace+0x12/0x20
 [<c0106c49>] dump_stack+0x19/0x20
 [<c0128081>] panic+0x51/0x110
 [<c012bcd6>] do_exit+0x6e6/0xaa0
 [<c0106a88>] die+0x2f8/0x300
 [<c02fc9a1>] do_page_fault+0x1f1/0x5e0
 [<c0105e45>] error_code+0x39/0x40
 [<c011f4cb>] enqueue_task+0x2b/0x90
 [<c011f551>] __activate_task+0x21/0x40
 [<c01218c1>] try_to_wake_up+0x321/0x450
 [<c0121a69>] wake_up_process_mutex+0x19/0x20
 [<c0144ab7>] wakeup_next_waiter+0xd7/0x1b0
 [<c02fa46c>] rt_spin_lock_slowunlock+0x4c/0x70
 [<c02fad88>] rt_spin_unlock+0x38/0x40
 [<c02fd8da>] kprobe_flush_task+0x3a/0x50
 [<c02f91fa>] __schedule+0xb0a/0xea0
 [<c0103b61>] cpu_idle+0xb1/0x120
 [<c01006d3>] rest_init+0x43/0x50
 [<c042f890>] start_kernel+0x360/0x440
 swapper/0[CPU#0]: BUG in smp_call_function at arch/i386/kernel/smp.c:557
 [<c0106455>] show_trace_log_lvl+0x185/0x1a0
 [<c0106ae2>] show_trace+0x12/0x20
 [<c0106c49>] dump_stack+0x19/0x20
 [<c01292e3>] __WARN_ON+0x63/0x80
 [<c0115fbc>] smp_call_function+0xbc/0xd0
 [<c0115fee>] smp_send_stop+0x1e/0x30
 [<c0128094>] panic+0x64/0x110
 [<c012bcd6>] do_exit+0x6e6/0xaa0
 [<c0106a88>] die+0x2f8/0x300
 [<c02fc9a1>] do_page_fault+0x1f1/0x5e0
 [<c0105e45>] error_code+0x39/0x40
 [<c011f4cb>] enqueue_task+0x2b/0x90
 [<c011f551>] __activate_task+0x21/0x40
 [<c01218c1>] try_to_wake_up+0x321/0x450
 [<c0121a69>] wake_up_process_mutex+0x19/0x20
 [<c0144ab7>] wakeup_next_waiter+0xd7/0x1b0
 [<c02fa46c>] rt_spin_lock_slowunlock+0x4c/0x70
 [<c02fad88>] rt_spin_unlock+0x38/0x40
 [<c02fd8da>] kprobe_flush_task+0x3a/0x50
 [<c02f91fa>] __schedule+0xb0a/0xea0
 [<c0103b61>] cpu_idle+0xb1/0x120
 [<c01006d3>] rest_init+0x43/0x50
 [<c042f890>] start_kernel+0x360/0x440
--

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
