Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268276AbUIKSvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268276AbUIKSvt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 14:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268281AbUIKSvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 14:51:49 -0400
Received: from scrye.com ([216.17.180.1]:47019 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S268276AbUIKSvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:51:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Sep 2004 12:50:57 -0600
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: FYI: my current bigdiff
In-Reply-To: <200409101646.01558.bjorn.helgaas@hp.com>
References: <20040909134421.GA12204@elf.ucw.cz>
	<20040910041320.DF700E7504@voldemort.scrye.com>
	<200409101646.01558.bjorn.helgaas@hp.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Message-Id: <20040911185104.D0D2A72050@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Bjorn" == Bjorn Helgaas <bjorn.helgaas@hp.com> writes:

Bjorn> On Thursday 09 September 2004 10:13 pm, Kevin Fenzi wrote:
>> First suspend worked.  First resume came back, but all kinds of
>> problems with my network, with my usb, and with sound.  ...  After
>> booting with the pci=routeirq as suggested wireless and usb played
>> nice on suspend resume again.

Bjorn> Yes, I've had a couple other reports of this, but haven't made
Bjorn> any progress on tracking it down yet.  (The other reports were
Bjorn> from vanilla -mm kernels, so I don't think it's related to
Bjorn> Pavel's patch.)

Yeah, sounds like. 

Bjorn> I'm completely ignorant about how swsusp works; I guess this is
Bjorn> my chance to learn.  "pci=routeirq" just causes us to do all
Bjorn> the PCI ACPI IRQ routing at boot-time, before the drivers start
Bjorn> up.  This happens in pci_acpi_init(), which is a
Bjorn> subsys_initcall that is run at initial boot-time, but (I
Bjorn> assume) not during a resume.

Bjorn> 	- Can you confirm that your USB and prism drivers were loaded
Bjorn> and working fine before the suspend?

Yes. I use the prism54 driver as my main connection on my laptop. 
I use usb for a digital camera, it's also working as expected. 

Bjorn> 	- Could you post the whole dmesg log, including the part from
Bjorn> boot to suspend, and also the part after resume?  I'd like to
Bjorn> see these both with and without "pci=routeirq" to see if
Bjorn> there's some meaningful difference.

Ok. Attached. 

Bjorn> 	- Can you capture the contents of /proc/interrupts before the
Bjorn> suspend?

Yes. Attached. 

First is the dmesgs from boot without pci=routeirq. 
Then the /proc/intterrupts from that boot. 
Then a suspend. 
Then any new dmesg messages
then the /proc/interrupts from that. 

Next is the same cycle with the pci=routeirq passed. 

Bjorn> Thanks for the problem report.

No problem, hope it helps. 

kevin
- --
Linux version 2.6.9-rc1-mm4 (root@brand.scrye.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #2 Fri Sep 10 10:41:56 MDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffd0000 (usable)
 BIOS-e820: 000000003ffd0000 - 000000003fff0c00 (reserved)
 BIOS-e820: 000000003fff0c00 - 000000003fffc000 (ACPI NVS)
 BIOS-e820: 000000003fffc000 - 0000000040000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262096
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32720 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000f9970
ACPI: RSDT (v001 COMPAQ CPQ004A  0x31050220 CPQ  0x00000001) @ 0x3fff0c84
ACPI: FADT (v002 COMPAQ CPQ004A  0x00000002 CPQ  0x00000001) @ 0x3fff0c00
ACPI: SSDT (v001 COMPAQ  CPQGysr 0x00001001 MSFT 0x0100000d) @ 0x3fff64c3
ACPI: SSDT (v001 COMPAQ   CPQMag 0x00001001 MSFT 0x0100000d) @ 0x3fff65d1
ACPI: DSDT (v001 COMPAQ  EVON800 0x00010000 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
No local APIC present or hardware disabled
Initializing CPU#0
Kernel command line: ro root=/dev/hda3 resume=/dev/hda2 
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1794.680 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035124k/1048384k available (1991k kernel code, 12548k reserved, 811k data, 272k init, 130880k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3538.94 BogoMIPS (lpj=1769472)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 3febf9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  3febf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        3febf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 110k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C03C] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.C03C._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C03D._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C04E._PRT]
ACPI: Embedded Controller [C0D0] (gpe 29)
ACPI: Power Resource [C140] (off)
ACPI: Power Resource [C154] (off)
ACPI: Power Resource [C158] (off)
ACPI: Power Resource [C15B] (off)
ACPI: Power Resource [C164] (on)
ACPI: PCI Interrupt Link [C0B6] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0B7] (IRQs *5 10 11)
ACPI: PCI Interrupt Link [C0B8] (IRQs 5 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C0B9] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0BA] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [C0BB] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [C0BC] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [C0BD] (IRQs) *0, disabled.
ACPI: Power Resource [C0CF] (on)
ACPI: Power Resource [C1D0] (off)
ACPI: Power Resource [C1D1] (off)
ACPI: Power Resource [C1D2] (off)
ACPI: Power Resource [C1D3] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
toshiba: not a supported Toshiba laptop
i8k: not running on a Dell system
i8k: vendor=Compaq, model=P2800N P180U540W825EC, version=68P
i8k: unable to get SMM Dell signature
i8k: unable to get SMM BIOS version
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1094905964.4294965768:0): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
i8042: ACPI  [C161] at I/O 0x60, 0x64, irq 1
i8042: ACPI  [C162] at irq 12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [C0B8] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x4440-0x4447, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4448-0x444f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HTS548080M9AT00, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SD-R2102, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: (supports S0 S3 S4 S4bios S5)
ACPI wakeup devices: 
C04E C0A0 C0A6 C0A9 C161 C162 C177 C11E 
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 272k freed
ACPI: AC Adapter [C11A] (on-line)
ACPI: Battery Slot [C11C] (battery present)
ACPI: Battery Slot [C11B] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C11E]
ACPI: Lid Switch [C11D]
ACPI: Fan [C1D4] (off)
ACPI: Fan [C1D5] (off)
ACPI: Fan [C1D6] (off)
ACPI: Fan [C1D7] (off)
ACPI: Processor [C000] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [TZ1] (51 C)
ACPI: Thermal Zone [TZ2] (46 C)
ACPI: Thermal Zone [TZ3] (16 C)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [C0BA] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:02:0e.0: NEC Corporation USB
ohci_hcd 0000:02:0e.0: irq 10, pci mem 0x40180000
ohci_hcd 0000:02:0e.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:02:0e.1[B] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:02:0e.1: NEC Corporation USB (#2)
ohci_hcd 0000:02:0e.1: irq 10, pci mem 0x40200000
ohci_hcd 0000:02:0e.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Adding 4192956k swap on /dev/hda2.  Priority:-1 extents:1
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: No suitable data for CPU0
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8190 buckets, 65520 max) - 364 bytes per conntrack
e100: Intel(R) PRO/100 Network Driver, 3.0.27-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 10 (level, low) -> IRQ 10
divert: allocating divert_blk for eth0
e100: eth0: e100_probe: addr 0x40100000, irq 10, MAC addr 00:08:02:62:81:9D
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [C0B9] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:06.0 [0e11:004a]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:06.0, mfunc 0x012c1202, devctl 0x64
Yenta: ISA IRQ mask 0x00d8, PCI irq 11
Socket status: 30000020
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3e8-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Loaded prism54 driver, version 1.2
PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 11 (level, low) -> IRQ 11
divert: allocating divert_blk for eth1
eth1: resetting device...
eth1: uploading firmware...
eth1: firmware upload complete
eth1: interface reset complete
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
divert: not allocating divert_blk for non-ethernet device tun0
eth1: no IPv6 routers present
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 256M @ 0x60000000
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 51
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
ts: Compaq touchscreen protocol output
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
           CPU0       
  0:     111883          XT-PIC  timer
  1:        237          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:         23          XT-PIC  acpi
 10:          0          XT-PIC  ohci_hcd, ohci_hcd
 11:        117          XT-PIC  yenta, eth1, radeon@PCI:1:0:0
 12:        585          XT-PIC  i8042
 14:       9452          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
eth1: islpci_close ()
ohci_hcd 0000:02:0e.0: remove, state 1
usb usb1: USB disconnect, address 1
ohci_hcd 0000:02:0e.0: USB bus 1 deregistered
ohci_hcd 0000:02:0e.1: remove, state 1
usb usb2: USB disconnect, address 1
ohci_hcd 0000:02:0e.1: USB bus 2 deregistered
usbcore: deregistering driver usbfs
usbcore: deregistering driver hub
eth1: removing device
divert: freeing divert_blk for eth1
Unloaded prism54 driver
Stopping tasks: ====================================|
Freeing memory...  -\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|done (41511 pages freed)
.................................swsusp: Need to copy 13254 pages
swsusp: Restoring Highmem
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:0e.1[B] -> GSI 10 (level, low) -> IRQ 10
Restarting tasks... done
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:02:0e.0: NEC Corporation USB
irq 10: nobody cared!
 [<c01086fb>] __report_bad_irq+0x2a/0x8b
 [<c0108973>] note_interrupt+0x84/0x103
 [<c0108c9b>] do_IRQ+0x13e/0x16a
 [<c0106964>] common_interrupt+0x18/0x20
 [<c0121f9f>] __do_softirq+0x2f/0x87
 [<c012201d>] do_softirq+0x26/0x28
 [<c0108c70>] do_IRQ+0x113/0x16a
 [<c0106964>] common_interrupt+0x18/0x20
 [<c01091c6>] setup_irq+0x7c/0xeb
 [<f88b8d1e>] usb_hcd_irq+0x0/0x67 [usbcore]
 [<c0108d7d>] request_irq+0x83/0xc5
 [<f88bcd83>] usb_hcd_pci_probe+0x1f5/0x4dc [usbcore]
 [<f88b8d1e>] usb_hcd_irq+0x0/0x67 [usbcore]
 [<c01f3941>] pci_device_probe_static+0x52/0x61
 [<c01f398b>] __pci_device_probe+0x3b/0x4e
 [<c01f39ca>] pci_device_probe+0x2c/0x4a
 [<c023b7b5>] bus_match+0x3f/0x6a
 [<c023b8c7>] driver_attach+0x56/0x80
 [<c023bd1a>] bus_add_driver+0x91/0xaf
 [<c023c235>] driver_register+0x2f/0x33
 [<c01f3c09>] pci_register_driver+0x5c/0x84
 [<f8890037>] ohci_hcd_pci_init+0x37/0x44 [ohci_hcd]
 [<c0134dcc>] sys_init_module+0x183/0x22f
 [<c0105fa5>] sysenter_past_esp+0x52/0x71
handlers:
[<f88b8d1e>] (usb_hcd_irq+0x0/0x67 [usbcore])
Disabling IRQ #10
ohci_hcd 0000:02:0e.0: irq 10, pci mem 0x40180000
ohci_hcd 0000:02:0e.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:02:0e.1[B] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:02:0e.1: NEC Corporation USB (#2)
ohci_hcd 0000:02:0e.1: irq 10, pci mem 0x40200000
ohci_hcd 0000:02:0e.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Loaded prism54 driver, version 1.2
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 11 (level, low) -> IRQ 11
divert: allocating divert_blk for eth1
eth1: resetting device...
eth1: uploading firmware...
eth1: firmware upload complete
eth1: reset problem: no 'reset complete' IRQ seen
eth1: timeout waiting for mgmt response 1000, triggering device
eth1: timeout waiting for mgmt response
eth1: mgt_commit_list: failure. oid=ff020008 err=-110
eth1: timeout waiting for mgmt response 1000, triggering device
eth1: timeout waiting for mgmt response
eth1: mgt_commit_list: failure. oid=ff020003 err=-110
eth1: timeout waiting for mgmt response 1000, triggering device
eth1: timeout waiting for mgmt response
eth1: mgt_commit_list: failure. oid=10000000 err=-110
eth1: timeout waiting for mgmt response 1000, triggering device
eth1: timeout waiting for mgmt response
eth1: mgt_commit_list: failure. oid=17000007 err=-110
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=19000001 err=-12
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=10000002 err=-12
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=19000004 err=-12
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=12000000 err=-12
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=12000001 err=-12
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=12000002 err=-12
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=12000004 err=-12
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=12000005 err=-12
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=12000006 err=-12
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=12000007 err=-12
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=12000003 err=-12
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=150007e0 err=-12
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=ff02000c err=-12
eth1: mgmt tx queue is still full
eth1: mgt_commit_list: failure. oid=ff020003 err=-12
eth1: mgmt tx queue is still full
eth1: mgt_update_addr: failure
eth1: mgt_commit: failure
eth1: interface reset complete
eth1: mgmt tx queue is still full
eth1: no IPv6 routers present
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3e8-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
           CPU0       
  0:     184600          XT-PIC  timer
  1:        399          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          3          XT-PIC  rtc
  9:         23          XT-PIC  acpi
 10:     100000          XT-PIC  ohci_hcd, ohci_hcd
 11:        137          XT-PIC  yenta, radeon@PCI:1:0:0, eth1
 12:        679          XT-PIC  i8042
 14:      10444          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

Next is the same cycle with pci=noirq:

Linux version 2.6.9-rc1-mm4 (root@brand.scrye.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #2 Fri Sep 10 10:41:56 MDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffd0000 (usable)
 BIOS-e820: 000000003ffd0000 - 000000003fff0c00 (reserved)
 BIOS-e820: 000000003fff0c00 - 000000003fffc000 (ACPI NVS)
 BIOS-e820: 000000003fffc000 - 0000000040000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262096
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32720 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000f9970
ACPI: RSDT (v001 COMPAQ CPQ004A  0x31050220 CPQ  0x00000001) @ 0x3fff0c84
ACPI: FADT (v002 COMPAQ CPQ004A  0x00000002 CPQ  0x00000001) @ 0x3fff0c00
ACPI: SSDT (v001 COMPAQ  CPQGysr 0x00001001 MSFT 0x0100000d) @ 0x3fff64c3
ACPI: SSDT (v001 COMPAQ   CPQMag 0x00001001 MSFT 0x0100000d) @ 0x3fff65d1
ACPI: DSDT (v001 COMPAQ  EVON800 0x00010000 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
No local APIC present or hardware disabled
Initializing CPU#0
Kernel command line: ro root=/dev/hda3 resume=/dev/hda2 pci=routeirq
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1794.716 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035124k/1048384k available (1991k kernel code, 12548k reserved, 811k data, 272k init, 130880k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3538.94 BogoMIPS (lpj=1769472)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 3febf9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  3febf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        3febf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 110k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C03C] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.C03C._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C03D._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C04E._PRT]
ACPI: Embedded Controller [C0D0] (gpe 29)
ACPI: Power Resource [C140] (off)
ACPI: Power Resource [C154] (off)
ACPI: Power Resource [C158] (off)
ACPI: Power Resource [C15B] (off)
ACPI: Power Resource [C164] (on)
ACPI: PCI Interrupt Link [C0B6] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0B7] (IRQs *5 10 11)
ACPI: PCI Interrupt Link [C0B8] (IRQs 5 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C0B9] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0BA] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [C0BB] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [C0BC] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [C0BD] (IRQs) *0, disabled.
ACPI: Power Resource [C0CF] (on)
ACPI: Power Resource [C1D0] (off)
ACPI: Power Resource [C1D1] (off)
ACPI: Power Resource [C1D2] (off)
ACPI: Power Resource [C1D3] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
toshiba: not a supported Toshiba laptop
i8k: not running on a Dell system
i8k: vendor=Compaq, model=P2800N P180U540W825EC, version=68P
i8k: unable to get SMM Dell signature
i8k: unable to get SMM BIOS version
PCI: Using ACPI for IRQ routing
** Routing PCI interrupts for all devices because "pci=routeirq"
** was specified.  If this was required to make a driver work,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
ACPI: PCI Interrupt Link [C0B8] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [C0B7] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [C0B6] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [C0B9] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [C0BA] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:0e.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:0e.2[C] -> GSI 10 (level, low) -> IRQ 10
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1094906321.780:0): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
i8042: ACPI  [C161] at I/O 0x60, 0x64, irq 1
i8042: ACPI  [C162] at irq 12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x4440-0x4447, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4448-0x444f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HTS548080M9AT00, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SD-R2102, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: (supports S0 S3 S4 S4bios S5)
ACPI wakeup devices: 
C04E C0A0 C0A6 C0A9 C161 C162 C177 C11E 
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 272k freed
ACPI: AC Adapter [C11A] (on-line)
ACPI: Battery Slot [C11C] (battery present)
ACPI: Battery Slot [C11B] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C11E]
ACPI: Lid Switch [C11D]
ACPI: Fan [C1D4] (off)
ACPI: Fan [C1D5] (off)
ACPI: Fan [C1D6] (off)
ACPI: Fan [C1D7] (off)
ACPI: Processor [C000] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [TZ1] (50 C)
ACPI: Thermal Zone [TZ2] (45 C)
ACPI: Thermal Zone [TZ3] (16 C)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:02:0e.0: NEC Corporation USB
ohci_hcd 0000:02:0e.0: irq 10, pci mem 0x40180000
ohci_hcd 0000:02:0e.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:02:0e.1[B] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:02:0e.1: NEC Corporation USB (#2)
ohci_hcd 0000:02:0e.1: irq 10, pci mem 0x40200000
ohci_hcd 0000:02:0e.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Adding 4192956k swap on /dev/hda2.  Priority:-1 extents:1
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: No suitable data for CPU0
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8190 buckets, 65520 max) - 364 bytes per conntrack
e100: Intel(R) PRO/100 Network Driver, 3.0.27-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 10 (level, low) -> IRQ 10
divert: allocating divert_blk for eth0
e100: eth0: e100_probe: addr 0x40100000, irq 10, MAC addr 00:08:02:62:81:9D
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:06.0 [0e11:004a]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:06.0, mfunc 0x012c1202, devctl 0x64
Yenta: ISA IRQ mask 0x00d8, PCI irq 11
Socket status: 30000020
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3e8-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Loaded prism54 driver, version 1.2
PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 11 (level, low) -> IRQ 11
divert: allocating divert_blk for eth1
eth1: resetting device...
eth1: uploading firmware...
eth1: firmware upload complete
eth1: interface reset complete
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
divert: not allocating divert_blk for non-ethernet device tun0
eth1: no IPv6 routers present
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 256M @ 0x60000000
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 51
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
ts: Compaq touchscreen protocol output
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49964 usecs
intel8x0: clocking to 48000
           CPU0       
  0:     536228          XT-PIC  timer
  1:       3462          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:         43          XT-PIC  Intel 82801CA-ICH3
  8:          1          XT-PIC  rtc
  9:        940          XT-PIC  acpi
 10:          0          XT-PIC  ohci_hcd, ohci_hcd
 11:      35120          XT-PIC  yenta, eth1, radeon@PCI:1:0:0
 12:      16161          XT-PIC  i8042
 14:      20551          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
eth1: islpci_close ()
ohci_hcd 0000:02:0e.0: remove, state 1
usb usb1: USB disconnect, address 1
ohci_hcd 0000:02:0e.0: USB bus 1 deregistered
ohci_hcd 0000:02:0e.1: remove, state 1
usb usb2: USB disconnect, address 1
ohci_hcd 0000:02:0e.1: USB bus 2 deregistered
usbcore: deregistering driver usbfs
usbcore: deregistering driver hub
eth1: removing device
divert: freeing divert_blk for eth1
Unloaded prism54 driver
Stopping tasks: ========================================================================================|
Freeing memory...  -\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|done (75903 pages freed)
.................................swsusp: Need to copy 41588 pages
swsusp: Restoring Highmem
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:0e.1[B] -> GSI 10 (level, low) -> IRQ 10
Restarting tasks... done
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:02:0e.0: NEC Corporation USB
ohci_hcd 0000:02:0e.0: irq 10, pci mem 0x40180000
ohci_hcd 0000:02:0e.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:02:0e.1[B] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:02:0e.1: NEC Corporation USB (#2)
ohci_hcd 0000:02:0e.1: irq 10, pci mem 0x40200000
ohci_hcd 0000:02:0e.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Loaded prism54 driver, version 1.2
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 11 (level, low) -> IRQ 11
divert: allocating divert_blk for eth1
eth1: resetting device...
eth1: uploading firmware...
eth1: firmware upload complete
eth1: interface reset complete
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3e8-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
eth1: no IPv6 routers present
           CPU0       
  0:     601383          XT-PIC  timer
  1:       3636          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:         43          XT-PIC  Intel 82801CA-ICH3
  8:          3          XT-PIC  rtc
  9:        996          XT-PIC  acpi
 10:          0          XT-PIC  ohci_hcd, ohci_hcd
 11:      39001          XT-PIC  yenta, radeon@PCI:1:0:0, eth1
 12:      16255          XT-PIC  i8042
 14:      22617          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBQ0kX3imCezTjY0ERAkh+AJ47Zdih9BqCUa20NtSnDWdRGwimFQCff+2j
dNFuvLoFpoohGwh9933tbDg=
=WKLe
-----END PGP SIGNATURE-----
