Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262782AbULQKqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbULQKqr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 05:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbULQKqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 05:46:47 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:50346 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262782AbULQKqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 05:46:22 -0500
Message-ID: <22192287.1103280348090.JavaMail.tomcat@pne-ps1-sn1>
Date: Fri, 17 Dec 2004 11:45:48 +0100 (MET)
From: Voluspa <lista4@comhem.se>
Reply-To: lista4@comhem.se
To: akpm@osdl.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Cc: nickpiggin@yahoo.com.au, mr@ramendik.ru, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_103_9149080.1103280348080"
X-Mailer: CP Presentation Server
X-clientstamp: [213.64.150.229]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_103_9149080.1103280348080
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Sorry about the delay.

On 2004-12-17 0:41:30 Andrew Morton wrote:

> Can you identify the kernel release which caused the problem to start?

My next mail did just that. Sort of. Somewhere between, and including, 2.6.9-
rc1 and 2.6.9-rc1-bk4. The latter being the first functional kernel I can 
test due to oopses and loss of keyboard in X starting from -rc1.

>> with a default of nice 19 and sucks up every free CPU cycle.
>
> What sucks up all the CPU?  The application?  kswapd?

The folding client uses all unused CPU, as it should. What kswapd does is 
beyond my knowledge.

> How much RAM, how much swap?

256 megabyte ram, about 1 gigabyte swap. You'll find more info in the next 
section.

On 2004-12-16 8:14:44 Nick Piggin wrote:

> So please, do the sysrq+m traces with a 2.6.10-rc3 kernel. Thanks.

Ok, done. I can do the same with last uneffected 2.6.8.1-bk2 upon request (didn't 
want to spam unless told to). Log from dmesg attached. Don't want to "inline" 
it since my ISP has changed the webmail program to some POS java where I 
have no control over the linebreaks.

Testing explanation: Cold boot. Started the folding client and waited 15 
minutes for it to write the first checkpoint (wanted full stability). Started 
X. Started Blender. Loaded a scene where I only use the "Sequence Editor" 
mode.

In this mode there's a 'preview' window where you can Alt-a, for animate, and 
watch your work in an almost real time. Overhead prevents a real, real time. 
Here I let the animation loop until the testing is over.

What happens during animation is that my 500 1.2 meg pictures (ie 20 seconds) is 
read from /dev/hdb - a slightly better and modern disk, fills up memory 
and then starts using the swap partition on /dev/hda. The read from /dev/hdb 
seems to be done only once since neither memory nor swap is released until 
I close the scene.

The machine CPU usage, as monitored by Gkrellm, is highest during the initial 
phase of swapping, about 50 percent (not counting the niced folding client 
usage) and then falls to about 15 percent when all swapping is done. How 
high it reaches during the screen freezes I don't know.

The sysrq+m snapshots were taken thusly: 1) Some seconds after the beginning of 
swap usage. 2) When the first screen freeze began. 3) In another screen 
freeze. 4) In the last minute of swapping, also during a screen freeze.

Total wall clock was about 3 minutes from beginning of animation to when all 
swapping had been done and the animation was "stable".

Mvh
Mats Johannesson

------=_Part_103_9149080.1103280348080
Content-Type: text/plain; name=dmesg-2.6.10-rc3.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg-2.6.10-rc3.txt

Linux version 2.6.10-rc3-sysrq (root@loke) (gcc version 3.4.3) #1 Thu Dec 16 10:38:55 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Built 1 zonelists
Kernel command line: root=/dev/hda2 pci=usepirqmask elevator=cfq apic=verbose lapic=lapic
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0348000 soft=c0347000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1075.368 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256548k/262080k available (1564k kernel code, 4968k reserved, 405k data, 336k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2121.72 BogoMIPS (lpj=1060864)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps:        0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1074.0766 MHz.
..... host bus clock speed is 134.0345 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb550, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf10
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf40, dseg 0xf0000
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
PCI: Found IRQ 12 for device 0000:00:1f.3
PCI: Sharing IRQ 12 with 0000:02:01.0
pnp: 00:0c: ioport range 0x3f0-0x3f1 has been reserved
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
ub: sizeof ub_scsi_cmd 64 ub_dev 2472
usbcore: registered new driver ub
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 1
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IC35L080AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
hdd: DVD-ROM DDU220E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 59772900 sectors (30603 MB) w/1916KiB Cache, CHS=59298/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
hdb: max request size: 128KiB
hdb: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 hdb4
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI DVD-ROM drive, 512kB Cache, DMA
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:1f.2
PCI: Sharing IRQ 11 with 0000:02:03.0
uhci_hcd 0000:00:1f.2: Intel Corp. 82801BA/BAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 11, io base 0xd000
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: setting IRQ 5 as level-triggered
PCI: Assigned IRQ 5 for device 0000:00:1f.4
uhci_hcd 0000:00:1f.4: Intel Corp. 82801BA/BAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: irq 5, io base 0xd400
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new low speed USB device using uhci_hcd and address 2
input: USB HID v1.10 Mouse [Logitech USB Trackball] on usb-0000:00:1f.2-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PC Speaker
i2c /dev entries driver
u32 classifier
    OLD policer on 
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 336k freed
Adding 979924k swap on /dev/hda7.  Priority:1 extents:1
PCI: Found IRQ 12 for device 0000:02:01.0
PCI: Sharing IRQ 12 with 0000:00:1f.3
nvidia: module license 'NVIDIA' taints kernel.
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6629  Wed Nov  3 13:12:51 PST 2004
8139too Fast Ethernet driver 0.9.27
PCI: Found IRQ 11 for device 0000:02:03.0
PCI: Sharing IRQ 11 with 0000:00:1f.2
eth0: RealTek RTL8139 at 0xd097e000, 00:48:54:66:c8:84, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139B'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 28, high 84, batch 14
cpu 0 cold: low 0, high 28, batch 14
HighMem per-cpu: empty

Free pages:        2528kB (0kB HighMem)
Active:40862 inactive:16601 dirty:0 writeback:0 unstable:0 free:632 slab:1392 mapped:49585 pagetables:206
DMA free:152kB min:124kB low:152kB high:184kB active:8636kB inactive:4992kB present:16384kB pages_scanned:36 all_unreclaimable? no
protections[]: 0 0 0
Normal free:2376kB min:1916kB low:2392kB high:2872kB active:154812kB inactive:61412kB present:245696kB pages_scanned:99 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 0*4kB 1*8kB 1*16kB 2*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 152kB
Normal: 4*4kB 1*8kB 1*16kB 1*32kB 10*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 2376kB
HighMem: empty
Swap cache: add 12914, delete 12031, find 8/36, race 0+0
Free swap:       929164kB
65520 pages of RAM
0 pages of HIGHMEM
4391 reserved pages
7013 pages shared
883 pages swap cached
SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 28, high 84, batch 14
cpu 0 cold: low 0, high 28, batch 14
HighMem per-cpu: empty

Free pages:        2928kB (0kB HighMem)
Active:38048 inactive:19285 dirty:0 writeback:1403 unstable:0 free:732 slab:1373 mapped:53240 pagetables:255
DMA free:216kB min:124kB low:152kB high:184kB active:5868kB inactive:7620kB present:16384kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
Normal free:2712kB min:1916kB low:2392kB high:2872kB active:146324kB inactive:69520kB present:245696kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 24*4kB 1*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 216kB
Normal: 0*4kB 9*8kB 15*16kB 15*32kB 2*64kB 2*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 2712kB
HighMem: empty
Swap cache: add 59988, delete 57469, find 384/488, race 0+0
Free swap:       743204kB
65520 pages of RAM
0 pages of HIGHMEM
4391 reserved pages
5303 pages shared
2519 pages swap cached
SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 28, high 84, batch 14
cpu 0 cold: low 0, high 28, batch 14
HighMem per-cpu: empty

Free pages:        2760kB (0kB HighMem)
Active:53024 inactive:4421 dirty:0 writeback:0 unstable:0 free:690 slab:1331 mapped:56992 pagetables:255
DMA free:272kB min:124kB low:152kB high:184kB active:11704kB inactive:1736kB present:16384kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
Normal free:2488kB min:1916kB low:2392kB high:2872kB active:200392kB inactive:15948kB present:245696kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 28*4kB 2*8kB 3*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 272kB
Normal: 0*4kB 21*8kB 1*16kB 0*32kB 0*64kB 2*128kB 2*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 2488kB
HighMem: empty
Swap cache: add 102121, delete 82743, find 19904/23544, race 0+0
Free swap:       684360kB
65520 pages of RAM
0 pages of HIGHMEM
4391 reserved pages
4895 pages shared
19378 pages swap cached
SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 28, high 84, batch 14
cpu 0 cold: low 0, high 28, batch 14
HighMem per-cpu: empty

Free pages:        2768kB (0kB HighMem)
Active:37234 inactive:20167 dirty:0 writeback:0 unstable:0 free:692 slab:1340 mapped:55097 pagetables:255
DMA free:280kB min:124kB low:152kB high:184kB active:8132kB inactive:5268kB present:16384kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
Normal free:2488kB min:1916kB low:2392kB high:2872kB active:140804kB inactive:75400kB present:245696kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 32*4kB 1*8kB 3*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 280kB
Normal: 0*4kB 1*8kB 7*16kB 0*32kB 3*64kB 1*128kB 2*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 2488kB
HighMem: empty
Swap cache: add 142576, delete 111546, find 38489/46005, race 0+0
Free swap:       635524kB
65520 pages of RAM
0 pages of HIGHMEM
4391 reserved pages
4945 pages shared
31030 pages swap cached

------=_Part_103_9149080.1103280348080--

