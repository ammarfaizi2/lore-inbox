Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTIJNEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 09:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbTIJNEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 09:04:46 -0400
Received: from adsl-14-226.38-151.net24.it ([151.38.226.14]:30476 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S262784AbTIJNEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 09:04:36 -0400
Date: Wed, 10 Sep 2003 15:04:32 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Power Management Update
Message-ID: <20030910130431.GC915@picchio.gall.it>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0309091726050.695-100000@cherise>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309091726050.695-100000@cherise>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.22
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2003 at 05:38:53PM -0700, Patrick Mochel wrote:
> 
> A patch against 2.6.0-test5 can be found at 
> 
> 	http://developer.osdl.org/~mochel/patches/test5-pm1/test5-pm1.diff.bz2
> 

I tried your patch on a Asus L3D, and here are the results:

echo -n standby > /sys/power/state
----------------------------------
Works fine, but on resume I get this message:
APIC error on CPU0: 00(00)
The resume continues and completes, but then it switches to init 0 and
halts.
So this is what happens:
- standby
- resume (with the above message)
- init 0 (this I have still to understand...)
If not for the init 0 part, that's ok.

echo -n mem > /sys/power/state
------------------------------
Suspend seems to go well, but on resume the screen stays black, I hear
the fan turning up, then nothing else. The machine doesn't respond
to pings or sysrq, hard reset required.
Removing the ehci module, I get something more strange, the resume seems
to go well, but the screen remains turned off (I'm not using framebuffer
or X). After some disk activity, the power led goes off. I think it is
againg going in init 0 just after resume.
Reading logs confirms this idea, it is going in init 0 just after
resuming completes.

Couldn't try disk suspend for time constraints, perhaps next days...

Someone has a clue on why it is switching to init 0 ?

Attached you find dmesg and tipical suspend->resume messages

-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.6.0-test5 (venza@tabr) (gcc version 3.3.1 20030626 (Debian prerelease)) #4 Wed Sep 10 12:59:26 CEST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001dfea000 (usable)
 BIOS-e820: 000000001dfea000 - 000000001dfef000 (ACPI data)
 BIOS-e820: 000000001dfef000 - 000000001dfff000 (reserved)
 BIOS-e820: 000000001dfff000 - 000000001e000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
479MB LOWMEM available.
On node 0 totalpages: 122858
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 118762 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6e10
ACPI: RSDT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1dfea000
ACPI: FADT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1dfea080
ACPI: BOOT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1dfea040
ACPI: DSDT (v001   ASUS L3000D   0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: root=/dev/hda3
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1674.442 MHz processor.
Console: colour VGA+ 80x25
Memory: 482772k/491432k available (1889k kernel code, 7868k reserved, 782k data, 136k init, 0k highmem)
Calibrating delay loop... 3309.56 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) XP-M 2000+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1673.0401 MHz.
..... host bus clock speed is 267.0744 MHz.
NET: Registered protocol family 16
spurious 8259A interrupt: IRQ7.
PCI: PCI BIOS revision 2.10 entry at 0xf1050, last bus=1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
   tbget-0292: *** Info: Table [DSDT] replaced by host OS
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:....................................................................................................................................................................................................
Table [DSDT](id F004) - 558 Objects with 54 Devices 196 Methods 22 Regions
ACPI Namespace successfully loaded at root c03d069c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000E430 on int 9
Completing Region/Field/Buffer/Package initialization:....................................................................
Initialized 22/22 Regions 0/0 Fields 21/21 Buffers 25/25 Packages (566 nodes)
Executing all Device _STA and_INI methods:.......................................................
55 Devices found containing: 55 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 11 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FN0] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf10
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf40, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
powernow: AMD K7 CPU detected.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00f0320
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 1 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:0 (@c00f0330)
powernow:  cpuid: 0x781	fsb: 133	maxFID: 0x3	startvid: 0xb
powernow:    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
powernow:    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
powernow:    FID: 0x8 (7.0x [931MHz])	VID: 0x13 (1.200V)
powernow:    FID: 0xc (9.0x [1197MHz])	VID: 0xe (1.300V)
powernow:    FID: 0x0 (11.0x [1463MHz])	VID: 0xc (1.400V)
powernow:    FID: 0x3 (12.5x [1662MHz])	VID: 0xb (1.450V)

powernow: Minimum speed 532 MHz. Maximum speed 1662 MHz.
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN0] (on)
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [THRM] (57 C)
Asus Laptop ACPI Extras version 0.24a
  L3D model detected, supported
  Notify Handler installed successfully
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 740 chipset
agpgart: Maximum main memory to use for agp memory: 409M
agpgart: AGP aperture is 64M @ 0xe8000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
Using anticipatory scheduling io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
sis900.c: v1.08.06 9/24/2002
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xa000, IRQ 11, 00:0c:6e:6c:29:6e.
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATMR04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R2312, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
pmdisk: Resume From Partition: /dev/hda2, Device: hda2
pmdisk: Invalid partition type.
Resume Machine: Error -22 resuming
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 136k freed
Adding 3654748k swap on /dev/hda7.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
intel8x0: clocking to 48000
i2c-sis96x version 1.0.0
EXT2-fs warning (device hda5): ext2_fill_super: mounting ext3 filesystem as ext2

EXT2-fs warning (device hda6): ext2_fill_super: mounting ext3 filesystem as ext2

NTFS driver 2.1.4 [Flags: R/O MODULE].
NTFS volume version 3.0.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:03.3: EHCI Host Controller
ehci_hcd 0000:00:03.3: irq 5, pci mem de9f7000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
ohci-hcd 0000:00:03.0: OHCI Host Controller
ohci-hcd 0000:00:03.0: irq 11, pci mem dea11000
ohci-hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
ohci-hcd 0000:00:03.1: OHCI Host Controller
ohci-hcd 0000:00:03.1: irq 5, pci mem dea26000
ohci-hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
ohci-hcd 0000:00:03.2: OHCI Host Controller
ohci-hcd 0000:00:03.2: irq 11, pci mem dea28000
ohci-hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
Disabled Privacy Extensions on device c036c0e0(lo)
eth0: Media Link On 10mbps half-duplex 
eth0: no IPv6 routers present

--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="susp.log"

Sep 10 14:03:55 tabr kernel: PM: Preparing system for suspend
Sep 10 14:03:55 tabr kernel: Stopping tasks: ====================================|
Sep 10 14:03:55 tabr kernel:      osl-0900 [56] os_wait_semaphore     : Failed to acquire semaphore[ddfe85a0|1|0], AE_TIME
Sep 10 14:03:55 tabr kernel: hdc: start_power_step(step: 0)
Sep 10 14:03:55 tabr kernel: hdc: completing PM request, suspend
Sep 10 14:03:55 tabr kernel: hda: start_power_step(step: 0)
Sep 10 14:03:55 tabr kernel: hda: start_power_step(step: 1)
Sep 10 14:03:55 tabr kernel: hda: complete_power_step(step: 1, stat: 50, err: 0)
Sep 10 14:03:55 tabr kernel: hda: completing PM request, suspend
Sep 10 14:03:55 tabr kernel: PM: Entering state.
Sep 10 14:03:55 tabr kernel:  hwsleep-0257 [25] acpi_enter_sleep_state: Entering sleep state [S3]
Sep 10 14:03:55 tabr kernel: Back to C!
Sep 10 14:03:55 tabr kernel: PM: Finishing up.
Sep 10 14:03:55 tabr kernel: hda: Wakeup request inited, waiting for !BSY...
Sep 10 14:03:55 tabr kernel: hda: start_power_step(step: 1000)
Sep 10 14:03:55 tabr kernel: blk: queue dddf6600, I/O limit 4095Mb (mask 0xffffffff)
Sep 10 14:03:55 tabr kernel: hda: completing PM request, resume
Sep 10 14:03:55 tabr kernel: hdc: Wakeup request inited, waiting for !BSY...
Sep 10 14:03:55 tabr kernel: hdc: start_power_step(step: 1000)
Sep 10 14:03:55 tabr kernel: hdc: completing PM request, resume
Sep 10 14:03:55 tabr kernel: Restarting tasks...atkbd.c: frame/parity error: 02
Sep 10 14:03:55 tabr kernel: atkbd.c: frame/parity error: 02
Sep 10 14:03:55 tabr kernel:  done
Sep 10 14:03:55 tabr kernel: Losing too many ticks!
Sep 10 14:03:55 tabr kernel: TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Sep 10 14:03:55 tabr kernel: Falling back to a sane timesource.
Sep 10 14:04:06 tabr kernel: ohci-hcd 0000:00:03.0: remove, state 85
Sep 10 14:04:06 tabr kernel: usb usb2: USB disconnect, address 1
Sep 10 14:04:06 tabr kernel: ohci-hcd 0000:00:03.0: USB bus 2 deregistered
Sep 10 14:04:06 tabr kernel: ohci-hcd 0000:00:03.1: remove, state 85
Sep 10 14:04:06 tabr kernel: usb usb3: USB disconnect, address 1
Sep 10 14:04:06 tabr kernel: ohci-hcd 0000:00:03.1: USB bus 3 deregistered
Sep 10 14:04:06 tabr kernel: ohci-hcd 0000:00:03.2: remove, state 85
Sep 10 14:04:06 tabr kernel: usb usb4: USB disconnect, address 1
Sep 10 14:04:06 tabr kernel: ohci-hcd 0000:00:03.2: USB bus 4 deregistered
Sep 10 14:04:06 tabr kernel: drivers/usb/core/usb.c: deregistering driver usbfs
Sep 10 14:04:06 tabr kernel: drivers/usb/core/usb.c: deregistering driver hub
Sep 10 14:04:06 tabr kernel: Kernel logging (proc) stopped.
Sep 10 14:04:06 tabr kernel: Kernel log daemon terminating.
Sep 10 14:04:57 tabr kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
Sep 10 14:04:57 tabr kernel: Inspecting /boot/System.map-2.6.0-test5


--/WwmFnJnmDyWGHa4--
