Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbTERT3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTERT3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 15:29:22 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:63379 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262171AbTERT3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 15:29:17 -0400
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0305171626410.2356-100000@montezuma.mastecende.com>
References: <20030514193300.58645206.akpm@digeo.com>
	 <Pine.LNX.4.44.0305141935440.9816-100000@cherise>
	 <20030514231414.42398dda.akpm@digeo.com>
	 <1053000426.605.4.camel@teapot.felipe-alfaro.com>
	 <Pine.LNX.4.50.0305171107090.2356-100000@montezuma.mastecende.com>
	 <1053200826.586.3.camel@teapot.felipe-alfaro.com>
	 <Pine.LNX.4.50.0305171626410.2356-100000@montezuma.mastecende.com>
Content-Type: multipart/mixed; boundary="=-Krrq5rfUfQbPHSYW5Ly5"
Message-Id: <1053286923.812.10.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 18 May 2003 21:42:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Krrq5rfUfQbPHSYW5Ly5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2003-05-17 at 22:35, Zwane Mwaikambo wrote:
> On Sat, 17 May 2003, Felipe Alfaro Solana wrote:
> 
> > The machine is a NEC (Packard Bell) Chrom@. Could an lspci be of
> > interest?
> 
> Hmm perhaps /var/log/dmesg, also can you try this ugly patch?
> 
> Index: linux-2.5.69-mm6/drivers/acpi/hardware/hwsleep.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.69/drivers/acpi/hardware/hwsleep.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 hwsleep.c
> --- linux-2.5.69-mm6/drivers/acpi/hardware/hwsleep.c	6 May 2003 12:20:11 -0000	1.1.1.1
> +++ linux-2.5.69-mm6/drivers/acpi/hardware/hwsleep.c	17 May 2003 20:33:20 -0000
> @@ -306,7 +306,7 @@ acpi_enter_sleep_state (
>  		 * still read the right value. Ideally, this entire block would go
>  		 * away entirely.
>  		 */
> -		acpi_os_stall (10000000);
> +		/* acpi_os_stall (10000000); */
>  
>  		status = acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1_CONTROL,
>  				 sleep_enable_reg_info->access_bit_mask);
> Index: linux-2.5.69-mm6/drivers/acpi/sleep/poweroff.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.69/drivers/acpi/sleep/poweroff.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 poweroff.c
> --- linux-2.5.69-mm6/drivers/acpi/sleep/poweroff.c	6 May 2003 12:20:12 -0000	1.1.1.1
> +++ linux-2.5.69-mm6/drivers/acpi/sleep/poweroff.c	17 May 2003 20:35:11 -0000
> @@ -15,6 +15,7 @@ acpi_power_off (void)
>  	printk("%s called\n",__FUNCTION__);
>  	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
>  	ACPI_DISABLE_IRQS();
> +	printk("%s:%d\n", __FUNCTION__, __LINE__);
>  	acpi_enter_sleep_state(ACPI_STATE_S5);
>  }
>  
With the previous patch applied, I can't make the kernel to printk
anything interesting after "Halting the computer". Now, I can't even see
the "acpi_power_off" message I was seen before.

Attached is "/var/log/dmesg" of a 2.5.69-mm6 kernel.
Thanks!


--=-Krrq5rfUfQbPHSYW5Ly5
Content-Disposition: attachment; filename=dmesg
Content-Type: application/octet-stream; name=dmesg
Content-Transfer-Encoding: 8bit

Linux version 2.5.69-mm6-test (root@glass.felipe-alfaro.com) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-118)) #2 Sun May 18 21:29:28 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 NEC                        ) @ 0x000fb550
ACPI: RSDT (v001    NEC ND000020 00000.00001) @ 0x0fff0000
ACPI: FADT (v001    NEC ND000020 00000.00001) @ 0x0fff0030
ACPI: BOOT (v001    NEC ND000020 00000.00001) @ 0x0fff00b0
ACPI: DSDT (v001    NEC ND000020 00000.00001) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda3 3
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 697.050 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1376.25 BogoMIPS
Memory: 256356k/262080k available (1570k kernel code, 4996k reserved, 543k data, 96k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000040
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030418
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [NRTH] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.NRTH._PRT]
ACPI: Embedded Controller [EC0] (gpe 9)
ACPI: Power Resource [PUSB] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 10, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 10, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 9, disabled)
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Enabling SEP on CPU 0
Limiting direct PCI/PCI transfers.
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Power Button (CM) [PRB1]
ACPI: Lid Switch [LID0]
ACPI: Fan [FANC] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (64 C)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 256M @ 0xe0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23BA-20, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8185, ATAPI CD/DVD-ROM drive
anticipatory scheduling elevator
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
yenta 00:0c.0: Preassigned resource 3 busy, reconfiguring...
Yenta IRQ list 08d8, PCI irq10
Socket status: 30000068
yenta 00:0c.1: Preassigned resource 2 busy, reconfiguring...
yenta 00:0c.1: Preassigned resource 3 busy, reconfiguring...
Yenta IRQ list 08d8, PCI irq5
Socket status: 30000006
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
uhci-hcd 00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 
uhci-hcd 00:07.2: irq 9, io base 0000ef80
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 13:31:57 2003 UTC).
ALSA device list:
  #0: Yamaha DS-XG PCI (YMF754) at 0xd0851000, irq 5
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 96k freed
hub 1-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-00:07.2-1
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 3
hub 1-2:0: USB hub found
hub 1-2:0: 2 ports detected
Adding 257032k swap on /dev/hda2.  Priority:-1 extents:1
blk: queue c033ff7c, I/O limit 4095Mb (mask 0xffffffff)
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04Aborted Command 

--=-Krrq5rfUfQbPHSYW5Ly5--

