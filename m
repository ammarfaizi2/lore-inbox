Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVCVH4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVCVH4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVCVH4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:56:40 -0500
Received: from dd2032.kasserver.com ([81.209.148.136]:17643 "EHLO
	dd2032.kasserver.com") by vger.kernel.org with ESMTP
	id S262516AbVCVHzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:55:03 -0500
Message-ID: <423FCF5F.80505@zogi.de>
Date: Mon, 21 Mar 2005 23:55:11 -0800
From: kernel@zogi.de
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: kernel@zogi.de
Subject: 2.6.11.4: ACPI, IRQ 11 disabled, Ethernet/USB stops working 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have a brand new Toshiba M45 S331 notebook and am experiencing (like 
some other guys who are trying to get Linux (with kernel 2.6.11.4) 
running on this machine) some problems...

Here the probably kernel related part:

Symptoms:
First, if I boot with the option "acpi=off" USB/Ethernet is fine - 
except that I am missing ACPI functionality ;-(

If I activate ACPI I get the following message during boot:
# Mar 17 07:42:57 linux kernel: irq 11: nobody cared!
# Mar 17 07:42:57 linux kernel:  [<c010868c>] __report_bad_irq+0x1c/0x70
# Mar 17 07:42:57 linux kernel:  [<c010875b>] note_interrupt+0x5b/0x80
# <zip> whole boot.msg attached at the end...
# Mar 17 07:42:57 linux kernel: Disabling IRQ #11

As consequence the ethernet chip is not working and USB stops working 
after some random time, with no error message. Unplugging and replugging 
my USB mouse resulted in the following kernel messages:

# Mar 21 13:47:04 thetis kernel: usb 1-2: khubd timed out on ep0in
# Mar 21 13:47:10 thetis kernel: usb 1-2: khubd timed out on ep0out
# Mar 21 13:47:15 thetis kernel: usb 1-2: khubd timed out on ep0out
# Mar 21 13:47:15 thetis kernel: usb 1-2: device not accepting address 
4, error -110
# Mar 21 13:47:16 thetis kernel: usb 1-2: khubd timed out on ep0in
# Mar 21 13:47:21 thetis kernel: usb 1-2: khubd timed out on ep0out
# Mar 21 13:47:24 thetis kernel:      osl-0958 [38] os_wait_semaphore :
Failed to acquire semaphore[df7dd560|1|0], AE_TIME
# Mar 21 13:47:24 thetis kernel:      osl-0958 [38] os_wait_semaphore :
Failed to acquire semaphore[df7dd560|1|4095], AE_TIME
# Mar 21 13:47:24 thetis kernel:  exmutex-0250: *** Error: Cannot 
release Mutex [MUT1], not acquired
# Mar 21 13:47:24 thetis kernel:  psparse-1138: *** Error: Method 
execution failed [\_SB_.RDEC] (Node c146a8a8), AE_AML_MUTEX_NOT_ACQUIRED
# Mar 21 13:47:24 thetis kernel:  psparse-1138: *** Error: Method 
execution failed [\_TZ_.TZCR._TMP] (Node df682c28), 
AE_AML_MUTEX_NOT_ACQUIRED
# Mar 21 13:47:27 thetis kernel: usb 1-2: khubd timed out on ep0out
# Mar 21 13:47:27 thetis kernel: usb 1-2: device not accepting address 5,
error -110

I played with several boot options "noapic", "acpi_irq_nobalance", 
"pci=usepirqmask", etc., without success.

Only "acpi=noirq" didn't result in the IRQ 11 disabled message, thus the 
ethernet card worked. However, after 15+-15 minutes the USB system does 
no longer work with the same error messages as stated above.


So what might be wrong? Under windows and with acpi=off USB/ethernet are 
working acceptably.
I am open for all suggestions!

Thanks in advance,
Andreas




My boot.msg:

Inspecting /boot/System.map-2.6.11.4
Loaded 24026 symbols from /boot/System.map-2.6.11.4.
Symbols match kernel version 2.6.11.
No module symbols loaded - kernel modules not enabled.

klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.6.11.4 (root@thetis) (gcc version 3.3.4 (pre 3.3.5 
20040809)) #3 Mon Mar 21 17:49:18 PST 2005
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000001f7dfffc (usable)
<4> BIOS-e820: 000000001f7dfffc - 000000001f7fffc0 (ACPI data)
<4> BIOS-e820: 000000001f7fffc0 - 000000001f800000 (ACPI NVS)
<4> BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
<5>0MB HIGHMEM available.
<5>503MB LOWMEM available.
<7>On node 0 totalpages: 128991
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 124895 pages, LIFO batch:16
<7>  HighMem zone: 0 pages, LIFO batch:1
<6>DMI 2.3 present.
<7>ACPI: RSDP (v000 INSYDE                                ) @ 0x000e5010
<7>ACPI: RSDT (v001 INSYDE RSDT_000 0x00000100 ABCD 0x00010200) @ 0x1f7f8769
<7>ACPI: FADT (v001 INSYDE FACP_000 0x00000100 0000 0x00010200) @ 0x1f7ffb30
<7>ACPI: MCFG (v001 INSYDE MCFG_000 0x30303030 0000 0x30303030) @ 0x1f7ffbc0
<7>ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20030522) @ 0x1f7f8975
<7>ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20030522) @ 0x1f7f879d
<7>ACPI: DSDT (v001 TOSINV SONOMA   0x00001004 INTL 0x02002036) @ 0x00000000
<6>ACPI: PM-Timer IO Port: 0x1008
<4>Allocating PCI resources starting at 1f800000 (gap: 1f800000:e0700000)
<4>Built 1 zonelists
<4>Kernel command line: root=/dev/sda7 vga=791 selinux=0 
resume=/dev/sda6 desktop elevator=as splash=silent
<4>Local APIC disabled by BIOS -- you can enable it with "lapic"
<7>mapped APIC to ffffd000 (013f2000)
<6>Initializing CPU#0
<4>PID hash table entries: 2048 (order: 11, 32768 bytes)
<4>Detected 1596.252 MHz processor.
<6>Using pmtmr for high-res timesource
<4>Console: colour dummy device 80x25
<4>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
<4>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
<6>Memory: 506128k/515964k available (2177k kernel code, 9280k reserved, 
743k data, 232k init, 0k highmem)
<4>Checking if this processor honours the WP bit even in supervisor 
mode... Ok.
<7>Calibrating delay loop... 3153.92 BogoMIPS (lpj=1576960)
<6>Security Framework v1.0.0 initialized
<6>SELinux:  Disabled at boot.
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<7>CPU: After generic identify, caps: afe9f9ff 00000000 00000000 
00000000 00000180 00000000 00000000
<7>CPU: After vendor identify, caps: afe9f9ff 00000000 00000000 00000000 
00000180 00000000 00000000
<6>CPU: L1 I cache: 32K, L1 D cache: 32K
<6>CPU: L2 cache: 2048K
<7>CPU: After all inits, caps: afe9f9ff 00000000 00000000 00000040 
00000180 00000000 00000000
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<4>CPU: Intel(R) Pentium(R) M processor 1.60GHz stepping 08
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4> tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully 
acquired
<4>Parsing all Control 
Methods:...................................................................................................................................................................................................................................................
<4>Table [DSDT](id F006) - 889 Objects with 69 Devices 243 Methods 29 
Regions
<4>Parsing all Control Methods:...
<4>Table [SSDT](id F003) - 5 Objects with 0 Devices 3 Methods 0 Regions
<4>Parsing all Control Methods:.
<4>Table [SSDT](id F004) - 1 Objects with 0 Devices 1 Methods 0 Regions
<4>ACPI Namespace successfully loaded at root c0454d00
<4>ACPI: setting ELCR to 0200 (from 0c20)
<4>evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode 
successful
<6>checking if image is initramfs...it isn't (no cpio magic); looks like 
an initrd
<6>Freeing initrd memory: 1270k freed
<6>NET: Registered protocol family 16
<6>PCI: PCI BIOS revision 2.10 entry at 0xea7e4, last bus=5
<6>PCI: Using MMCONFIG
<6>mtrr: v2.0 (20020519)
<6>ACPI: Subsystem revision 20050211
<4> exutils-0216 [21] ex_acquire_global_lock: Could not acquire Global 
Lock, AE_NO_GLOBAL_LOCK
<4> exutils-0216 [21] ex_acquire_global_lock: Could not acquire Global 
Lock, AE_NO_GLOBAL_LOCK
<4> exutils-0216 [21] ex_acquire_global_lock: Could not acquire Global 
Lock, AE_NO_GLOBAL_LOCK
<4> exutils-0216 [21] ex_acquire_global_lock: Could not acquire Global 
Lock, AE_NO_GLOBAL_LOCK
<4> exutils-0216 [21] ex_acquire_global_lock: Could not acquire Global 
Lock, AE_NO_GLOBAL_LOCK
<4>evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs 
on int 0x9
<4>evgpeblk-0987 [06] ev_create_gpe_block   : Found 8 Wake, Enabled 4 
Runtime GPEs in this block
<4>Completing Region/Field/Buffer/Package 
initialization:.........................................................................................
<4>Initialized 28/29 Regions 0/0 Fields 39/39 Buffers 22/34 Packages 
(904 nodes)
<4>Executing all Device _STA and_INI 
methods:...........................................................................
<4>75 Devices found containing: 75 _STA, 1 _INI methods
<6>ACPI: Interpreter enabled
<6>ACPI: Using PIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<6>PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
<6>PCI: Transparent bridge - 0000:00:1e.0
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *11)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 5 *11)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs *5 11)
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 5 10) *0, disabled.
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 6) *11
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs 5 10) *11
<6>ACPI: Embedded Controller [EC0] (gpe 16)
<6>ACPI: Power Resource [PFA1] (off)
<6>Linux Plug and Play Support v0.97 (c) Adam Belay
<6>pnp: PnP ACPI init
<6>pnp: PnP ACPI: found 9 devices
<6>PCI: Using ACPI for IRQ routing
<6>** PCI interrupts are no longer routed automatically.  If this
<6>** causes a device to stop working, it is probably because the
<6>** driver failed to call pci_enable_device().  As a temporary
<6>** workaround, the "pci=routeirq" argument restores the old
<6>** behavior.  If this argument makes the device work again,
<6>** please email the output of "lspci" to bjorn.helgaas@hp.com
<6>** so I can fix the driver.
<3>PCI: Cannot allocate resource region 0 of device 0000:05:06.0
<4>TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
<6>apm: BIOS not found.
<6>audit: initializing netlink socket (disabled)
<3>audit(1111435622.241:0): initialized
<4>Total HugeTLB memory allocated, 0
<5>VFS: Disk quotas dquot_6.5.1
<4>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>Initializing Cryptographic API
<4>ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
<4>PCI: setting IRQ 10 as level-triggered
<6>ACPI: PCI interrupt 0000:00:1c.0[A] -> GSI 10 (level, low) -> IRQ 10
<7>PCI: Setting latency timer of device 0000:00:1c.0 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[pcie00]
<7>Allocate Port Service[pcie02]
<7>Allocate Port Service[pcie03]
<4>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
<4>PCI: setting IRQ 11 as level-triggered
<6>ACPI: PCI interrupt 0000:00:1c.1[B] -> GSI 11 (level, low) -> IRQ 11
<7>PCI: Setting latency timer of device 0000:00:1c.1 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[pcie00]
<7>Allocate Port Service[pcie02]
<7>Allocate Port Service[pcie03]
<6>vesafb: framebuffer at 0xa0000000, mapped to 0xe0080000, using 3072k, 
total 7872k
<6>vesafb: mode is 1024x768x16, linelength=2048, pages=4
<6>vesafb: protected mode interface info at 00ff:44f0
<6>vesafb: scrolling: redraw
<6>vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
<4>Console: switching to colour frame buffer device 128x48
<6>fb0: VESA VGA frame buffer device
<6>isapnp: Scanning for PnP cards...
<6>isapnp: No Plug & Play device found
<6>Real Time Clock Driver v1.12
<6>i8042.c: Detected active multiplexing controller, rev 1.1.
<6>serio: i8042 AUX0 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX1 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX2 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX3 port at 0x60,0x64 irq 12
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
<4>ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
<4>PCI: setting IRQ 5 as level-triggered
<6>ACPI: PCI interrupt 0000:00:1e.3[B] -> GSI 5 (level, low) -> IRQ 5
<6>io scheduler noop registered
<6>io scheduler anticipatory registered
<6>io scheduler deadline registered
<6>io scheduler cfq registered
<4>floppy0: no floppy controllers found
<4>RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
<6>loop: loaded (max 8 devices)
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
<3>ide0: I/O resource 0x1F0-0x1F7 not free.
<3>ide0: ports already in use, skipping probe
<7>Probing IDE interface ide1...
<4>hdc: MATSHITADVD-RAM UJ-830S, ATAPI CD/DVD-ROM drive
<7>Probing IDE interface ide2...
<7>Probing IDE interface ide3...
<7>Probing IDE interface ide4...
<7>Probing IDE interface ide5...
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>ide-floppy driver 0.99.newide
<6>mice: PS/2 mouse device common for all mice
<6>input: AT Translated Set 2 keyboard on isa0060/serio0
<6>Synaptics Touchpad, model: 1
<6> Firmware: 5.9
<6> 180 degree mounted touchpad
<6> Sensor: 37
<6> new absolute packet format
<6> Touchpad has extended capability bits
<6> -> multifinger detection
<6> -> palm detection
<6>input: SynPS/2 Synaptics TouchPad on isa0060/serio1
<6>input: PC Speaker
<6>md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>NET: Registered protocol family 2
<6>IP: routing cache hash table of 4096 buckets, 32Kbytes
<4>TCP established hash table entries: 16384 (order: 5, 131072 bytes)
<4>TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
<6>TCP: Hash tables configured (established 16384 bind 16384)
<6>NET: Registered protocol family 1
<6>NET: Registered protocol family 8
<6>NET: Registered protocol family 20
<7>PM: Reading swsusp image.
<7>swsusp: Resume From Partition: /dev/sda6
<7>swsusp: Error -6 resuming
<7>PM: Resume from disk failed.
<4>ACPI wakeup devices:
<4>LID0 RP01 RP02 RP03 RP04 USB1 USB2 USB3 USB4 USB7 MODM PS2K
<6>ACPI: (supports S0 S3 S4 S5)
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<5>RAMDISK: Compressed image found at block 0
<4>VFS: Mounted root (ext2 filesystem).
<5>SCSI subsystem initialized
<7>libata version 1.10 loaded.
<7>ata_piix version 1.03
<4>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
<6>ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 11 (level, low) -> IRQ 11
<4>ata: 0x170 IDE port busy
<7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
<6>ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1100 irq 14
<7>ata1: dev 0 cfg 49:2b00 82:346b 83:5b29 84:4003 85:3468 86:1a09 
87:4003 88:203f
<6>ata1: dev 0 ATA, max UDMA/100, 156301488 sectors:
<6>ata1: dev 0 configured for UDMA/100
<6>scsi0 : ata_piix
<5>  Vendor: ATA       Model: FUJITSU MHT2080A  Rev: 0022
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
<5>SCSI device sda: drive cache: write back
<5>SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
<5>SCSI device sda: drive cache: write back
<6> sda: sda1 sda2 < sda5 sda6 sda7 > sda4
<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<5>ReiserFS: sda7: found reiserfs format "3.6" with standard journal
<5>ReiserFS: sda7: using ordered data mode
<5>ReiserFS: sda7: journal params: device sda7, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
<5>ReiserFS: sda7: checking transaction log (sda7)
<5>ReiserFS: sda7: Using r5 hash to sort names
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<5>Trying to move old root to /initrd ... failed
<5>Unmounting old root
<5>Trying to free ramdisk memory ... failed
<6>Freeing unused kernel memory: 232k freed
<6>usbcore: registered new driver usbfs
<6>usbcore: registered new driver hub
<6>ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
<4>sk98lin: Network Device Driver v8.14.2.2 (beta)
<4>(C)Copyright 1999-2005 Marvell(R).
<6>ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
<7>PCI: Setting latency timer of device 0000:01:00.0 to 64
<4>eth0: Marvell Yukon 88E8036 Fast Ethernet Controller
<4>      PrefPort:A  RlmtMode:Check Link State
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
<6>USB Universal Host Controller Interface driver v2.2
<6>Linux agpgart interface v0.100 (c) Dave Jones
<6>agpgart: Detected an Intel 915GM Chipset.
<6>agpgart: Maximum main memory to use for agp memory: 431M
<6>agpgart: Detected 7932K stolen memory.
<6>agpgart: AGP aperture is 256M @ 0xa0000000
<4>ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
<6>ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
<6>uhci_hcd 0000:00:1d.0: UHCI Host Controller
<7>PCI: Setting latency timer of device 0000:00:1d.0 to 64
<6>uhci_hcd 0000:00:1d.0: irq 10, io base 0x1200
<6>uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
<6>hub 1-0:1.0: USB hub found
<6>hub 1-0:1.0: 2 ports detected
<6>ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
<6>uhci_hcd 0000:00:1d.1: UHCI Host Controller
<7>PCI: Setting latency timer of device 0000:00:1d.1 to 64
<6>uhci_hcd 0000:00:1d.1: irq 11, io base 0x1220
<6>uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
<6>hub 2-0:1.0: USB hub found
<6>hub 2-0:1.0: 2 ports detected
<4>ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
<6>ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
<6>uhci_hcd 0000:00:1d.2: UHCI Host Controller
<7>PCI: Setting latency timer of device 0000:00:1d.2 to 64
<6>uhci_hcd 0000:00:1d.2: irq 11, io base 0x1240
<6>uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
<6>hub 3-0:1.0: USB hub found
<6>hub 3-0:1.0: 2 ports detected
<6>ACPI: PCI interrupt 0000:00:1d.3[D] -> GSI 11 (level, low) -> IRQ 11
<6>uhci_hcd 0000:00:1d.3: UHCI Host Controller
<7>PCI: Setting latency timer of device 0000:00:1d.3 to 64
<6>uhci_hcd 0000:00:1d.3: irq 11, io base 0x1260
<6>uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
<6>hub 4-0:1.0: USB hub found
<6>hub 4-0:1.0: 2 ports detected
<6>NTFS driver 2.1.22 [Flags: R/O MODULE].
<6>NTFS volume version 3.1.
<7>ieee1394: Initialized config rom entry `ip1394'
<4>PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
<6>ACPI: PCI interrupt 0000:00:1d.7[A] -> GSI 10 (level, low) -> IRQ 10
<6>ehci_hcd 0000:00:1d.7: EHCI Host Controller
<7>PCI: Setting latency timer of device 0000:00:1d.7 to 64
<6>ehci_hcd 0000:00:1d.7: irq 10, pci mem 0xf4000000
<6>ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
<7>PCI: cache line size of 32 is not supported by device 0000:00:1d.7
<6>ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
<6>hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
<6>Uniform CD-ROM driver Revision: 3.20
<6>hub 5-0:1.0: USB hub found
<6>hub 5-0:1.0: 8 ports detected
<6>ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
<4>ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 6
<4>PCI: setting IRQ 6 as level-triggered
<6>ACPI: PCI interrupt 0000:05:06.2[C] -> GSI 6 (level, low) -> IRQ 6
<6>ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[6] 
MMIO=[b8000000-b80007ff]  Max Packet=[2048]
<7>ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00080da0d1bca851]
<3>irq 11: nobody cared!
<4> [__report_bad_irq+36/144] __report_bad_irq+0x24/0x90
<4> [note_interrupt+123/160] note_interrupt+0x7b/0xa0
<4> [__do_IRQ+251/272] __do_IRQ+0xfb/0x110
<4> [do_IRQ+54/112] do_IRQ+0x36/0x70
<4> [pg0+532459610/1069093888] ata_qc_complete+0x2a/0xb0 [libata]
<4> [common_interrupt+26/32] common_interrupt+0x1a/0x20
<4> [handle_IRQ_event+41/112] handle_IRQ_event+0x29/0x70
<4> [__do_IRQ+167/272] __do_IRQ+0xa7/0x110
<4> [do_IRQ+54/112] do_IRQ+0x36/0x70
<4> [common_interrupt+26/32] common_interrupt+0x1a/0x20
<3>handlers:
<3>[pg0+536005584/1069093888] (SkY2Isr+0x0/0x1b0 [sk98lin])
<3>[pg0+537072800/1069093888] (usb_hcd_irq+0x0/0x70 [usbcore])
<3>[pg0+537072800/1069093888] (usb_hcd_irq+0x0/0x70 [usbcore])
<3>[pg0+537072800/1069093888] (usb_hcd_irq+0x0/0x70 [usbcore])
<0>Disabling IRQ #11
<4>hdc: irq timeout: status=0xc0 { Busy }
<4>ide: failed opcode was: unknown
<4>hdc: ATAPI reset complete
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.





