Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbTEOWTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 18:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTEOWTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 18:19:24 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:18150 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264261AbTEOWTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 18:19:18 -0400
Subject: Re: 2.5.69-mm5: pccard oops while booting: resolved
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       David Jones <davej@suse.de>
In-Reply-To: <20030515144439.A31491@flint.arm.linux.org.uk>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
	 <20030514191735.6fe0998c.akpm@digeo.com>
	 <1052998601.726.1.camel@teapot.felipe-alfaro.com>
	 <20030515130019.B30619@flint.arm.linux.org.uk>
	 <1053004615.586.2.camel@teapot.felipe-alfaro.com>
	 <20030515144439.A31491@flint.arm.linux.org.uk>
Content-Type: multipart/mixed; boundary="=-rDWmeAcWWZ/YgQeWHkfc"
Message-Id: <1053037915.569.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 16 May 2003 00:31:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rDWmeAcWWZ/YgQeWHkfc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-05-15 at 15:44, Russell King wrote:
> On Thu, May 15, 2003 at 03:16:55PM +0200, Felipe Alfaro Solana wrote:
> > OK, attached to this message:
> > 
> > "dmesg" contains the kernel messages when booting up 2.5.69-mm5 at tun
> > level 1 with the patch applied.
> > 
> > "config" contains options used to configure the kernel. Mostly, the
> > cardbus stuff is built-in, so no modules were loaded when booting into
> > single-user mode.
> > 
> > Hope this helps!
> 
> Indeed it does.  This patch should solve the problem.
> 
> --- orig/drivers/char/agp/intel-agp.c	Sun Apr 20 16:31:48 2003
> +++ linux/drivers/char/agp/intel-agp.c	Thu May 15 14:41:45 2003
> @@ -1635,7 +1635,7 @@
>  
>  MODULE_DEVICE_TABLE(pci, agp_intel_pci_table);
>  
> -static struct __initdata pci_driver agp_intel_pci_driver = {
> +static struct pci_driver agp_intel_pci_driver = {
>  	.name		= "agpgart-intel",
>  	.id_table	= agp_intel_pci_table,
>  	.probe		= agp_intel_probe,
> 

I've applied this patch, but "pccard" keeps oopsing. The test kernel is
a 2.5.69-mm5 with the "i8259-shutdown.patch" reverted, plus the above
patch and your previous "verbose" patch. Attached to this message is the
new "dmesg" from this patched kernel.

As I told Andrew, reverting "make-KOBJ_NAME-match-BUS_ID_SIZE.patch"
solves the oops.

--=-rDWmeAcWWZ/YgQeWHkfc
Content-Disposition: attachment; filename=dmesg
Content-Type: application/octet-stream; name=dmesg
Content-Transfer-Encoding: 8bit

Linux version 2.5.69-mm5b (root@glass.felipe-alfaro.com) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-4)) #3 Fri May 16 00:25:57 CEST 2003
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
Kernel command line: ro root=/dev/hda3 1
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 697.080 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1376.25 BogoMIPS
Memory: 256048k/262080k available (1739k kernel code, 5304k reserved, 682k data, 104k init, 0k highmem)
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
Initializing RT netlink socket
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
pci_bus_match: pci_drv = c03270a0 (0xc03270a0)
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 256M @ 0xe0000000
pci_bus_match: pci_drv = c03270a0 (0xc03270a0)
pci_bus_match: pci_drv = c03270a0 (0xc03270a0)
pci_bus_match: pci_drv = c03270a0 (0xc03270a0)
pci_bus_match: pci_drv = c03270a0 (0xc03270a0)
pci_bus_match: pci_drv = c03270a0 (0xc03270a0)
pci_bus_match: pci_drv = c03270a0 (0xc03270a0)
pci_bus_match: pci_drv = c03270a0 (0xc03270a0)
pci_bus_match: pci_drv = c03270a0 (0xc03270a0)
pci_bus_match: pci_drv = c03270a0 (0xc03270a0)
pci_bus_match: pci_drv = c03270a0 (0xc03270a0)
pci_bus_match: pci_drv = c03270a0 (0xc03270a0)
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
pci_bus_match: pci_drv = c03293e0 (0xc03293e0)
pci_bus_match: pci_drv = c03293e0 (0xc03293e0)
pci_bus_match: pci_drv = c03293e0 (0xc03293e0)
pci_bus_match: pci_drv = c03293e0 (0xc03293e0)
pci_bus_match: pci_drv = c03293e0 (0xc03293e0)
pci_bus_match: pci_drv = c03293e0 (0xc03293e0)
pci_bus_match: pci_drv = c03293e0 (0xc03293e0)
pci_bus_match: pci_drv = c03293e0 (0xc03293e0)
pci_bus_match: pci_drv = c03293e0 (0xc03293e0)
pci_bus_match: pci_drv = c03293e0 (0xc03293e0)
pci_bus_match: pci_drv = c03293e0 (0xc03293e0)
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
pci_bus_match: pci_drv = c032a440 (0xc032a440)
pci_bus_match: pci_drv = c032a440 (0xc032a440)
pci_bus_match: pci_drv = c032a440 (0xc032a440)
pci_bus_match: pci_drv = c032a440 (0xc032a440)
pci_bus_match: pci_drv = c032a440 (0xc032a440)
pci_bus_match: pci_drv = c032a440 (0xc032a440)
yenta 00:0c.0: Preassigned resource 3 busy, reconfiguring...
Yenta IRQ list 08d8, PCI irq10
Socket status: 30000068
pci_bus_match: pci_drv = c032a440 (0xc032a440)
yenta 00:0c.1: Preassigned resource 2 busy, reconfiguring...
yenta 00:0c.1: Preassigned resource 3 busy, reconfiguring...
Yenta IRQ list 08d8, PCI irq5
Socket status: 30000006
pci_bus_match: pci_drv = c032a440 (0xc032a440)
pci_bus_match: pci_drv = c032a440 (0xc032a440)
pci_bus_match: pci_drv = c032a440 (0xc032a440)
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
pci_bus_match: pci_drv = c032b0c0 (0xc032b0c0)
pci_bus_match: pci_drv = c032b0c0 (0xc032b0c0)
pci_bus_match: pci_drv = c032b0c0 (0xc032b0c0)
uhci-hcd 00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 
uhci-hcd 00:07.2: irq 9, io base 0000ef80
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
pci_bus_match: pci_drv = c032b0c0 (0xc032b0c0)
pci_bus_match: pci_drv = c032b0c0 (0xc032b0c0)
pci_bus_match: pci_drv = c032b0c0 (0xc032b0c0)
pci_bus_match: pci_drv = c032b0c0 (0xc032b0c0)
pci_bus_match: pci_drv = c032b0c0 (0xc032b0c0)
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 13:31:57 2003 UTC).
pci_bus_match: pci_drv = c032dee0 (0xc032dee0)
pci_bus_match: pci_drv = c032dee0 (0xc032dee0)
pci_bus_match: pci_drv = c032dee0 (0xc032dee0)
pci_bus_match: pci_drv = c032dee0 (0xc032dee0)
pci_bus_match: pci_drv = c032dee0 (0xc032dee0)
pci_bus_match: pci_drv = c032dee0 (0xc032dee0)
pci_bus_match: pci_drv = c032dee0 (0xc032dee0)
ALSA device list:
  #0: Yamaha DS-XG PCI (YMF754) at 0xd0851000, irq 5
NET4: Linux TCP/IP 1.0 for NET4.0
pci_bus_match: pci_drv = c03270a0 (0xc03270a0)
pci_bus_match: pci_drv = c03293e0 (0xc03293e0)
pci_bus_match: pci_drv = c032a440 (0xc032a440)
pci_bus_match: pci_drv = c032b0c0 (0xc032b0c0)
pci_bus_match: pci_drv = c032dee0 (0xc032dee0)
pci_bus_match: pci_drv = cff47c68 (0xcff47c68)
pci_bus_match: pci_drv = c02ddbf4 (0xc02ddbf4)
Unable to handle kernel paging request at virtual address 25007367
 printing eip:
c01924b9
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01924b9>]    Not tainted VLI
EFLAGS: 00010202
EIP is at pci_bus_match+0x49/0xe0
eax: 00000000   ebx: c02ddbf4   ecx: c02f2890   edx: 00000282
esi: 25007367   edi: c13c1000   ebp: cff3944c   esp: cfde7ec0
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 10, threadinfo=cfde6000 task=c1390060)
Stack: c02ca16b c02ddbf4 c02ddc1c c13c104c ffffffed c01d056f c13c104c c02ddc1c 
       c02ddc4c c13c104c c03208bc c01d060f c13c104c c02ddc1c c13c104c c0320860 
       c13c1084 c01d07c4 c13c104c c02c3703 c0327180 c13c104c 00000000 c13c1084 
Call Trace:
 [<c01d056f>] bus_match+0x2f/0x80
 [<c01d060f>] device_attach+0x4f/0x90
 [<c01d07c4>] bus_add_device+0x64/0xb0
 [<c01cf994>] device_add+0xd4/0x110
 [<c018eb4e>] pci_bus_add_devices+0xae/0xe0
 [<c02034bb>] cb_alloc+0xab/0xf0
 [<c02002f9>] socket_insert+0x69/0x80
 [<c01ff8aa>] get_socket_status+0x1a/0x20
 [<c020053d>] pccardd+0x13d/0x1f0
 [<c0115e80>] default_wake_function+0x0/0x20
 [<c0109272>] ret_from_fork+0x6/0x14
 [<c0115e80>] default_wake_function+0x0/0x20
 [<c0200400>] pccardd+0x0/0x1f0
 [<c010722d>] kernel_thread_helper+0x5/0x18

Code: d6 6c 2c c0 e8 19 77 f8 ff 89 5c 24 04 c7 04 24 09 b4 2c c0 e8 59 ce f9 ff c7 04 24 6b a1 2c c0 e8 fd 76 f8 ff 31 c0 85 f6 74 2f <8b> 16 85 d2 74 79 90 83 fa ff 74 2b 0f b7 47 24 39 c2 74 23 83 
 <6>hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 104k freed
hub 1-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-00:07.2-1
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 3
hub 1-2:0: USB hub found
hub 1-2:0: 2 ports detected
Adding 257032k swap on /dev/hda2.  Priority:-1 extents:1
blk: queue c038d3dc, I/O limit 4095Mb (mask 0xffffffff)
end_request: I/O error, dev hdc, sector 0
end_request: I/O error, dev hdc, sector 0
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04Aborted Command 

--=-rDWmeAcWWZ/YgQeWHkfc--

