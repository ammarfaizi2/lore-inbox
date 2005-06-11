Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVFKRGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVFKRGx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVFKRGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:06:53 -0400
Received: from nef2.ens.fr ([129.199.96.40]:22533 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S261740AbVFKRG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:06:26 -0400
To: pavel@ucw.cz (Pavel Machek)
Cc: linux-kernel@vger.kernel.org
Reply-To: Eric.Brunet@lps.ens.fr
Subject: Re: ipw2100: firmware problem
In-Reply-To: <20050608142310.GA2339@elf.ucw.cz>
References: <20050608142310.GA2339@elf.ucw.cz>
Date: Sat, 11 Jun 2005 19:06:23 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <20050611170623.E72B513365@quatramaran.ens.fr>
From: ebrunet@quatramaran.ens.fr ( =?ISO-8859-1?Q?=C9ric?= Brunet)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sat, 11 Jun 2005 19:06:24 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ens.mailing-lists.linux-kernel, you wrote:
>
> I'm fighting with firmware problem: if ipw2100 is compiled into
> kernel, it is loaded while kernel boots and firmware loader is not yet
> available. That leads to uninitialized (=> useless) adapter.

By the way, can you get an ipw2100 working with suspend to ram ?

I have an ASUS s5200n with such a card. It is loaded with fedora core 2 
(stock kernel: kernel-2.6.10-1.12_FC2) + ipw2100 module and firmware
downloaded from atrpms.net (respectively
ipw2100-kmdl-2.6.10-1.12_FC2-1.0.0-27.1.rhfc2.at and
ipw2100-firmware-1.3-5.at).

Suspending to ram and resuming works very nicely, except that the wifi
card is dead till the next reboot. I tried to rmmod and modprobe the
ipw2100 module (either after the suspend/resume cycle, either rmmod before
suspend and modprobe after resume), but to no avail.

Looking at kernel messages to diagnose the problem, I also noticed a
couple of warnings.

Here are the messages happening during suspend/resume (cpufreq is
enabled):

##############################################################################
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
Stopping tasks: =================================================<6>Floppy drive(s): fd0 is 1.44M
==|
Back to C!
Warning: CPU frequency is 1400000, cpufreq assumed 600000 kHz.
Debug: sleeping function called from invalid context at mm/slab.c:2061
in_atomic():0, irqs_disabled():1
 [<c01188bb>] __might_sleep+0x80/0x8a
 [<c01488d9>] __kmalloc+0x40/0x76
 [<c01f20a5>] acpi_os_allocate+0xa/0xb
 [<c0205744>] acpi_ut_callocate+0x36/0x82
 [<c0205678>] acpi_ut_initialize_buffer+0x46/0x85
 [<c020263a>] acpi_rs_create_byte_stream+0x23/0x39
 [<c02039a6>] acpi_rs_set_srs_method_data+0x1b/0x9d
 [<c0116e26>] recalc_task_prio+0x128/0x133
 [<c020ae49>] acpi_pci_link_set+0xde/0x155
 [<c020b1cf>] irqrouter_resume+0x1c/0x30
 [<c0241bb7>] sysdev_resume+0x3e/0xc7
 [<c0244dea>] device_power_up+0x5/0xa
 [<c01398a2>] suspend_enter+0x25/0x2d
 [<c0139908>] enter_state+0x37/0x53
 [<c02084c2>] acpi_suspend+0x25/0x33
 [<c0208595>] acpi_system_write_sleep+0x5d/0x6e
 [<c0161bea>] vfs_write+0xb8/0xe4
 [<c0161cb4>] sys_write+0x3c/0x62
 [<c0103473>] syscall_call+0x7/0xb
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.5 to 64
floppy0: no floppy controllers found
eth0: link down
ipw2100: eth1: ipw2100_verify failed: -5
ipw2100: eth1: Failed to power on the adapter.
ipw2100: eth1: Failed to start the firmware.
Restarting tasks... done
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 3 (level, low) -> IRQ 3
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 3, pci mem 0xfebff800
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
#####################################################################

Then, I did a  rmmod ipw2100

#####################################################################
divert: freeing divert_blk for eth1
#####################################################################

and I type ``ifup eth1'' to load it again:

#####################################################################
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 1.0.0
ipw2100: Copyright(c) 2003-2004 Intel Corporation
PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:01:05.0 to 64
ipw2100Device not found via register read.
#####################################################################


For info, here are the boot messages:
#####################################################################
Linux version 2.6.10-1.12_FC2 (bhcompile@bugs.build.redhat.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Wed Feb 2 01:13:49 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f740000 (usable)
 BIOS-e820: 000000000f740000 - 000000000f750000 (ACPI data)
 BIOS-e820: 000000000f750000 - 000000000f800000 (ACPI NVS)
0MB HIGHMEM available.
247MB LOWMEM available.
On node 0 totalpages: 63296
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 59200 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f4ff0
ACPI: RSDT (v001 A M I  OEMRSDT  0x02000427 MSFT 0x00000097) @ 0x0f740000
ACPI: FADT (v002 A M I  OEMFACP  0x02000427 MSFT 0x00000097) @ 0x0f740200
ACPI: MADT (v001 A M I  OEMAPIC  0x02000427 MSFT 0x00000097) @ 0x0f740300
ACPI: OEMB (v001 A M I  OEMBIOS  0x02000427 MSFT 0x00000097) @ 0x0f750040
ACPI: DSDT (v001  0ABBD 0ABBD001 0x00000001 MSFT 0x02000001) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Built 1 zonelists
Kernel command line: ro root=LABEL=/ acpi_sleep=s3_bios
Initializing CPU#0
CPU 0 irqstacks, hard=c03e0000 soft=c03df000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 600.231 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 246728k/253184k available (2064k kernel code, 5776k reserved, 684k data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1187.84 BogoMIPS (lpj=593920)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: After vendor identify, caps:  a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        a7e9f3bf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 00b8)
    ACPI-0077: *** Warning: Invalid FADT value PM_TM_LEN=3 at offset 5B FADT=cf73a840
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 201k freed
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 12)
ACPI: Power Resource [GFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
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
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1118513415.834:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 5C55E14F33E392D
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FN00] (off)
ACPI: Processor [CPU1] (supports C1 C2 C3)
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (30 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Maximum main memory to use for agp memory: 196M
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xf0000000
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 7 (level, low) -> IRQ 7
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 7
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 7 (level, low) -> IRQ 7
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC25N040ATMR04-0, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda4 < hda5 hda6 >
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 17
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 4681)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
P0P1 LAN0 CBS0 CBS1 P394 MPCI MODM USB1 USB2 USB3 EHCI SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 164k freed
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
ACPI: AC Adapter [AC0] (off-line)
Asus Laptop ACPI Extras version 0.29
  S5N model detected, supported
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ibm_acpi: ec object not found
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 3 (level, low) -> IRQ 3
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 3, pci mem 0xfebff800
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 5, io base 0xd480
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 4 (level, low) -> IRQ 4
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 4, io base 0xd800
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 7 (level, low) -> IRQ 7
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 7, io base 0xd880
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
EXT3 FS on hda6, internal journal
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
Adding 755012k swap on /dev/hda5.  Priority:-1 extents:1
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (1978 buckets, 15824 max) - 360 bytes per conntrack
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:01:04.0[A] -> GSI 5 (level, low) -> IRQ 5
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 at 0xc800, 00:0e:a6:b4:4a:cc, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8101'
eth0: link down
ieee80211_crypt: registered algorithm 'NULL'
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 1.0.0
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 7 (level, low) -> IRQ 7
ipw2100: Detected Intel PRO/Wireless 2100 Network Connection
divert: allocating divert_blk for eth1
ipw2100: eth1: Firmware 'ipw2100-1.3.fw' not available or load failed.
ipw2100: eth1: ipw2100_get_firmware failed: -2
ipw2100: eth1: Failed to power on the adapter.
ipw2100: eth1: Failed to start the firmware.
divert: freeing divert_blk for eth1
ipw2100Error calling regiser_netdev.
ipw2100: probe of 0000:01:05.0 failed with error -5
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 7 (level, low) -> IRQ 7
Yenta: CardBus bridge found at 0000:01:03.0 [1043:1824]
Yenta: ISA IRQ mask 0x0400, PCI irq 7
Socket status: 30000006
ACPI: PCI interrupt 0000:01:03.1[B] -> GSI 7 (level, low) -> IRQ 7
Yenta: CardBus bridge found at 0000:01:03.1 [1043:1824]
Yenta: ISA IRQ mask 0x0400, PCI irq 7
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
lp: driver loaded but no devices found
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0375960(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 1.0.0
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 7 (level, low) -> IRQ 7
ipw2100: Detected Intel PRO/Wireless 2100 Network Connection
divert: allocating divert_blk for eth1
eth0: no IPv6 routers present
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 5 (level, low) -> IRQ 5
[drm] Initialized i830 1.3.2 20021108 on minor 0: 
[drm] Initialized i830 1.3.2 20021108 on minor 1: 
mtrr: base(0xf0020000) is not aligned on a size(0x300000) boundary
PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49451 usecs
intel8x0: clocking to 48000
eth0: link down
eth0: no IPv6 routers present
###########################################################################

Don't hesitate to ask for any further information.
Maybe upgrading to the forthcoming FC4 will help.

Éric Brunet
