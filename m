Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTEZQ1X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 12:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTEZQ1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 12:27:23 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:54744 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S261783AbTEZQ1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 12:27:16 -0400
Subject: APIC on Dell Laptops - WAS: Re: [RFC] Fix NMI watchdog
	documentation
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200305260921.h4Q9LcNr022536@harpo.it.uu.se>
References: <200305260921.h4Q9LcNr022536@harpo.it.uu.se>
Content-Type: multipart/mixed; boundary="=-TJFYoPhL9zBofFqlfj+d"
Organization: 
Message-Id: <1053967225.5948.12.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 12:40:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TJFYoPhL9zBofFqlfj+d
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!

And now /proc/cpuinfo and cpuid both show APIC support.

Removed/replaced power, triggered lid-switch/battery-status/etc with no
issues.  (The only thing that caused trouble was Fn-F10, the "eject cd"
button.  Never tried it under Linux before, and the cd isn't in it at
the moment anyway, so I'm betting thats unrelated. But it did cause a
lockup that even sysrq couldn't recover.)

Not 100% clear on what the APIC does, but I'm not sure its doing it ;) 

PCI: Using ACPI for IRQ routing <-- shouldn't this be missing if the
APIC is in use?

(Full dmesg attached, for those who are curious - the unknown-scancode
is for the various laptop buttons - bright/dim, vol, media, battery,
etc.  Except for the volume buttons the only ones that work are the ones
that directly hit the hardware, ala bright/dim.)

Also, for others with an I8500 who might read the dmesg log, don't get
excited; thats not the wireless card they sell (Broadcom 802.11g) its
the older one (Orinoco 802.11b).  They'll sell you one for about $70,
goes right in in place of the unsupported one.

>From single-user:
# cat /proc/interrupts
           CPU0
  0:       8716          XT-PIC  timer
  1:        572          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:         20          XT-PIC  usb-uhci, usb-uhci, usb-uhci, ehci-hcd,
eth0
 14:       2610          XT-PIC  ide0
NMI:          0
LOC:       8649
ERR:          0
MIS:          0


After booting, building/installing alsa-modules, getting into X, etc etc
etc..
           CPU0
  0:     121238          XT-PIC  timer
  1:       6472          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
  9:          9          XT-PIC  acpi
 11:     125522          XT-PIC  usb-uhci, usb-uhci, usb-uhci, ehci-hcd,
eth0, PCI device 104c:ac44 (Texas Instruments), Texas Instruments
PCI1410 PC card Cardbus Controller, orinoco_cs, Intel 82801DB-ICH4
 12:      20693          XT-PIC  PS/2 Mouse
 14:      28381          XT-PIC  ide0
NMI:          0
LOC:     121201
ERR:          0
MIS:          0



On Mon, 2003-05-26 at 05:21, mikpe@csd.uu.se wrote:
> On 26 May 2003 01:31:41 -0400, Disconnect <lkml@sigkill.net> wrote:
> >> OK, I put together a kernel that had the Latitude blacklist commented out,
> >> and it comes up with:
> >> 
> >> No local APIC present or hardware disabled
> >> Initializing CPU#0
> >> 
> >> So add the Latitude C840 to the "known b0rken" list.
> >
> >Ditto the Inspiron 8500 - no apic at all (which is different from
> >known-broken, since nothing bad happened.)  
> ...
> >Perhaps just a comment above those entries:
> >/* Latitude C840 and Inspiron 8500 have no APIC support in hardware */
> 
> If these machines are P4-based, then I bet they do have local APICs.
> However, if the BIOS boots the kernel with the local APIC disabled
> on a P4, we (apic.c) don't try to enable it. The logic behind that
> is that "modern" BIOSen _should_ boot with it enabled, unless they're
> horribly broken.
> 
> So apply the patch below and try the "can we get the machine to hang"
> checklist again.
> 
> /Mikael
> 
> --- linux-2.5.69/arch/i386/kernel/apic.c.~1~	2003-04-20 13:08:15.000000000 +0200
> +++ linux-2.5.69/arch/i386/kernel/apic.c	2003-05-26 11:11:19.000000000 +0200
> @@ -617,7 +617,7 @@
>  		goto no_apic;
>  	case X86_VENDOR_INTEL:
>  		if (boot_cpu_data.x86 == 6 ||
> -		    (boot_cpu_data.x86 == 15 && cpu_has_apic) ||
> +		    (boot_cpu_data.x86 == 15) ||
>  		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
>  			break;
>  		goto no_apic;
-- 
Disconnect <lkml@sigkill.net>

--=-TJFYoPhL9zBofFqlfj+d
Content-Description: 
Content-Disposition: inline; filename=APIC.msg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.4.21-rc3-dis2-apic (dis@slappy) (gcc version 3.2.3) #4 Mon May 26 11:54:32 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffb0800 (usable)
 BIOS-e820: 000000001ffb0800 - 0000000020000000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 130992
zone(0): 4096 pages.
zone(1): 126896 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 DELL                       ) @ 0x000fdf00
ACPI: RSDT (v001 DELL    CPi R   10195.01053) @ 0x1fff0000
ACPI: FADT (v001 DELL    CPi R   10195.01053) @ 0x1fff0400
ACPI: DSDT (v001 INT430 SYSFexxx 00000.04097) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: root=/dev/hda4 ro resume=/dev/hda3 speedstep_default=2 single
cpufreq: Default forced: performanceLocal APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1994.170 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3971.48 BogoMIPS
Memory: 515768k/523968k available (1300k kernel code, 7812k reserved, 477k data, 96k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
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
..... CPU clock speed is 1994.1762 MHz.
..... host bus clock speed is 99.7086 MHz.
cpu: 0, clocks: 997086, slice: 498543
CPU0<T0:997072,T1:498528,D:1,S:498543,C:997086>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030509
PCI: PCI BIOS revision 2.10 entry at 0xfc97e, last bus=2
PCI: Using configuration type 1
    ACPI-0292: *** Info: Table [DSDT] replaced by host OS
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 (bios) S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Starting kswapd
Journalled Block Device driver loaded
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Processor [CPU0] (supports C1 C2 C3, 6 performance states, 8 throttling states)
ACPI: Thermal Zone [THM] (52 C)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10e
pktcdvd: v0.0.2p 03/03/2002 Jens Axboe (axboe@suse.de)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xf0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI_DK23EA-30, ATA DISK drive
blk: queue c030e5a0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 58605120 sectors (30006 MB) w/2048KiB Cache, CHS=3648/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4093 buckets, 32744 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Resume Machine:   This is normal swap space
Swsusp beta 19:   kswsuspd starting
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 96k freed
Adding Swap: 996020k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,4), internal journal
Broadcom 4401 Ethernet Driver bcm4400 ver. 2.0.0 (03/25/03)
eth0: Broadcom BCM4401 100Base-T found at mem faffe000, IRQ 11, node addr 000bdb1b893c
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 14:00:36 May 25 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xbf80, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xbf40, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xbf20, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver usbkbd
usbkbd.c: :USB HID Boot Protocol keyboard driver
i8k: unable to get SMM Dell signature
i8k: unable to get SMM BIOS version
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz@debian.org)
usb.c: registered new driver usbnet
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
hub.c: new USB device 00:1d.2-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x54c/0x2c) is not claimed by any active driver.
PCI: Setting latency timer of device 00:1d.7 to 64
ehci-hcd 00:1d.7: Intel Corp. 82801DB USB EHCI Controller
ehci-hcd 00:1d.7: irq 11, pci mem e0917c00
usb.c: new USB bus registered, assigned bus number 4
ehci-hcd 00:1d.7: enabled 64bit PCI DMA
PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:1d.7 PCI cache line size corrected to 128.
ehci-hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
usb.c: USB disconnect on device 00:1d.2-1 address 2
hub.c: USB hub found
hub.c: 6 ports detected
hub.c: new USB device 00:1d.2-1, assigned address 3
usb.c: USB device 3 (vend/prod 0x54c/0x2c) is not claimed by any active driver.
bcm4400: eth0 NIC Link is Down
keyboard: unknown scancode e0 07
keyboard: unknown scancode e0 07
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: SONY      Model: USB-FDU           Rev: 5.01
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3
USB Mass Storage support registered.
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 02:01.0 (0000 -> 0002)
Yenta IRQ list 00f8, PCI irq11
Socket status: 30000086
Yenta IRQ list 0000, PCI irq11
Socket status: 30000010
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xe0000-0xfffff
hermes.c: 4 Dec 2002 David Gibson <hermes@gibson.dropbear.id.au>
orinoco.c 0.13b (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13b (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0001:0008:000a
eth1: Looks like a Lucent/Agere firmware version 8.10
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:7C:3C:3F
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 3.3, irq 11, io 0x0100-0x013f
keyboard: unknown scancode e0 08
hermes.c: 4 Dec 2002 David Gibson <hermes@gibson.dropbear.id.au>
orinoco.c 0.13b (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13b (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0001:0008:000a
eth1: Looks like a Lucent/Agere firmware version 8.10
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:7C:3C:3F
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 3.3, irq 11, io 0x0100-0x013f
eth1: New link status: Connected (0001)
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 48000

--=-TJFYoPhL9zBofFqlfj+d--

