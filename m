Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbULFXRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbULFXRD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbULFXRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:17:02 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:46806 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261695AbULFXLB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:11:01 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 06 Dec 2004 23:10:45 +0000
Message-Id: <1102374645.13483.3.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: 2.6.10-rc3 - no interrupt 10 after swsusp unless pci=routeirq used
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.10-rc3, I get no network activity after swsusp resume. USB
devices also fail to work. On checking /proc/interrupts, interrupt 10
(which they share) is no longer being incremented. Adding pci=routeirq
to the boot flags makes it work.

/proc/interrupts
           CPU0       
  0:     629930          XT-PIC  timer
  1:        160          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:          0          XT-PIC  parport0
  8:          2          XT-PIC  rtc
  9:         11          XT-PIC  acpi
 10:        202          XT-PIC  uhci_hcd, uhci_hcd, ehci_hcd, eth0
 11:          3          XT-PIC  VIA8233
 12:        169          XT-PIC  i8042
 14:       4133          XT-PIC  ide0
 15:       5024          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

lspci:
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8623 [Apollo CLE266]
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266
AGP]
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel 537
[AC97 Modem] (rev 80)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102
[Rhine-II] (rev 74)
0000:01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8623
[Apollo CLE266] integrated CastleRock graphics (rev 03)

dmesg:

Linux version 2.6.10-rc3-1-386 (mjg59@nonsense) (gcc version 3.3.3
(Debian)) #21 Mon Dec 6 22:39:47 GMT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d6000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000dff0000 (usable)
 BIOS-e820: 000000000dff0000 - 000000000dff8000 (ACPI data)
 BIOS-e820: 000000000dff8000 - 000000000e000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
223MB LOWMEM available.
On node 0 totalpages: 57328
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 53232 pages, LIFO batch:12
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa2d0
ACPI: RSDT (v001 AMIINT VIA_P6   0x00000010 MSFT 0x00000097) @
0x0dff0000
ACPI: FADT (v001 AMIINT VIA_P6   0x00000011 MSFT 0x00000097) @
0x0dff0030
ACPI: DSDT (v001    VIA APOLLO-P 0x00001000 MSFT 0x0100000d) @
0x00000000
ACPI: PM-Timer IO Port: 0x808
Built 1 zonelists
Kernel command line: root=/dev/hda1 resume=/dev/hda2 ro pci=routeirq
quiet splash
No local APIC present or hardware disabled
mapped APIC to ffffd000 (011c3000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1000.759 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 219504k/229312k available (1377k kernel code, 9300k reserved,
729k data, 220k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 1974.27 BogoMIPS (lpj=987136)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0381b13f 00000000 00000000 00000000
CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 64K (32 bytes/line)
CPU: After all inits, caps:        0381b13f 00000000 00000000 00000000
CPU: Centaur VIA Nehemiah stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
ACPI: Looking for DSDT in initrd... not found!
ACPI: setting ELCR to 0200 (from 0c00)
checking if image is initramfs...it isn't (bad gzip magic numbers);
looks like an initrd
Freeing initrd memory: 4728k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: Embedded Controller [EC] (gpe 20)
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *10)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PnPBIOS: Disabled by ACPI
PCI: Using ACPI for IRQ routing
** Routing PCI interrupts for all devices because "pci=routeirq"
** was specified.  If this was required to make a driver work,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:10.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:10.3[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:11.6[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
inotify device minor=63
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 54 ports, IRQ sharing
enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
input: AT Translated Set 2 keyboard on isa0060/serio0
EISA: Probing bus 0 at eisa0
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices: 
PCI0 USB1 USB2 EHCI  AC9  MC9 ILAN 
ACPI: (supports S0 S1 S3 S4 S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4728KiB [1 disk] into ram disk... |/-\|/-
\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
\done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 220k freed
ACPI: Processor [CPU1] (supports 16 throttling states)
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N020ATMR04-0, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: 39070080 sectors (20003 MB) w/1740KiB Cache, CHS=16383/255/63,
UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Probing IDE interface ide1...
hdc: Slimtype COMBO LSC-24082K, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
Stopping tasks: ==|
Freeing memory...  -\|/done (429 pages freed)
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
Adding 979956k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
Synaptics Touchpad, model: 1
 Firmware: 5.0
 Sensor: 15
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
mice: PS/2 mouse device common for all mice
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ts: Compaq touchscreen protocol output
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
Capability LSM initialized
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
cdrom: open failed.
Real Time Clock Driver v1.12
input: PC Speaker
inserting floppy driver for 2.6.10-rc3-1-386
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA CLE266 chipset
agpgart: Maximum main memory to use for agp memory: 176M
agpgart: AGP aperture is 64M @ 0xe0000000
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Evaluate _OSC Set fails. Status = 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller
uhci_hcd 0000:00:10.0: irq 10, io base 0xe800
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.1[B] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (#2)
uhci_hcd 0000:00:10.1: irq 10, io base 0xec00
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.3[D] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.3: irq 10, pci mem 0xdfffff00
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 26 Oct
2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
irda_init()
NET: Registered protocol family 23
via_ircc_init(): error rc = 0, returning  -ENODEV...
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:11.5 to 64
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: VIA Rhine II at 0xdc00, 00:11:5b:1d:05:52, IRQ 10.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link
0021.
eth0: link up, 10Mbps, half-duplex, lpa 0x0021
NET: Registered protocol family 17
NET: Registered protocol family 10
Disabled Privacy Extensions on device c02dcba0(lo)
IPv6 over IPv4 tunneling driver
ACPI: Battery Slot [BAT0] (battery present)
ACPI: AC Adapter [ADP0] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
eth0: no IPv6 routers present
Stopping tasks: ============================|
Freeing memory...  -\|/-\|/-\|/-\|/-\|/-\|/-
\|/-\|/-\|/-\done (11812 pages freed)
usb usb3: no poweroff yet, suspending instead
usb usb2: no poweroff yet, suspending instead
usb usb1: no poweroff yet, suspending instead
....................swsusp: Need to copy 9833 pages
.<6>ehci_hcd 0000:00:10.3: USB 2.0 restarted, EHCI 1.00, driver 26 Oct
2004
ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 11 (level, low) -> IRQ 11
scheduling while atomic: hibernate.sh/0x00000001/7068
 [<c025753e>] schedule+0x4c/0x452
 [<c011ba50>] __mod_timer+0xe6/0x13d
 [<c0257d7a>] schedule_timeout+0x7e/0x9c
 [<c011c2db>] process_timeout+0x0/0x9
 [<c01de821>] __bus_for_each_dev+0x77/0x7f
 [<c011c639>] msleep+0x2e/0x35
 [<cea4d312>] ehci_hub_resume+0xde/0x18f [ehci_hcd]
 [<cea15bf1>] hcd_hub_resume+0x14/0x19 [usbcore]
 [<cea13508>] usb_resume_device+0x38/0xa6 [usbcore]
 [<c01e0ee3>] resume_device+0x1b/0x20
 [<c01e0f4f>] dpm_resume+0x67/0x98
 [<c01e0f91>] device_resume+0x11/0x1e
 [<c012b356>] finish+0x5/0x2d
 [<c012b45b>] pm_suspend_disk+0x5f/0x63
 [<c0129a3b>] enter_state+0x27/0x5c
 [<c0129b55>] state_store+0x84/0x99
 [<c0176375>] subsys_attr_store+0x1f/0x27
 [<c0176553>] flush_write_buffer+0x25/0x2a
 [<c0176591>] sysfs_write_file+0x39/0x58
 [<c0145298>] vfs_write+0xb2/0xfa
 [<c014537e>] sys_write+0x3b/0x63
 [<c010300b>] syscall_call+0x7/0xb
Restarting tasks... done
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: VIA Rhine II at 0xdc00, 00:11:5b:1d:05:52, IRQ 10.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link
0021.
eth0: link up, 10Mbps, half-duplex, lpa 0x0021
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
eth0: no IPv6 routers present


-- 
Matthew Garrett | mjg59@srcf.ucam.org

