Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbUJYUKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbUJYUKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbUJYUJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:09:31 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:34574 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S261227AbUJYT4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:56:18 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: Serious stability issues with 2.6.10-rc1 - more info
In-Reply-To: <E1CM2ZE-0000ND-Be@rhn.tartu-labor>
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.10-rc1 (i686))
Message-Id: <E1CMAwy-00017Z-3Y@rhn.tartu-labor>
Date: Mon, 25 Oct 2004 22:56:16 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MR> x86 PC, duron 1.3, via kt133 mainboard, 384M RAM, Matrox g400 graphics,
MR> realtek 8139 NIC, ide hdd on via onboard ide, ext3, 2 X users with KDE,
MR> some bittorrents running.

... and es1371 audio with alsa driver and bt878 that were forgotten.

I happened again but this time I got more information.

First strange thing was quitting tvtime. The tvtime window closed
normally but command prompt never returned.

After that it went downhill fast. Tryin ps on another pty showed some
processes and then hung - looks like it tried to show the tvtime process
but waited for a lock.

Then I tried SysRq-T to capture the task list. dmesg in yet another
terminal was the last command that worked before the complete hang where
only sysrq-b worked. But I got the sysrq-t ouput to disk, maybe it is of
some help (tvtime and ps are the last ones but here is the full dmesg).

This shows that the first thing that happened was an oops in
dma_free_coherent:


klogd 1.4.1#15, log source = /proc/kmsg started.
Inspecting /boot/System.map-2.6.10-rc1
Loaded 28013 symbols from /boot/System.map-2.6.10-rc1.
Symbols match kernel version 2.6.10.
No module symbols loaded - kernel modules not enabled. 
Linux version 2.6.10-rc1 (mroos@vaarikas) (gcc version 3.3.5 (Debian 1:3.3.5-1)) #68 Sun Oct 24 17:57:10 EEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
 BIOS-e820: 0000000017ff0000 - 0000000017ff3000 (ACPI NVS)
 BIOS-e820: 0000000017ff3000 - 0000000018000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98288
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 94192 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 VIA694                                ) @ 0x000f80c0
ACPI: RSDT (v001 VIA694 MSI ACPI 0x42302e31 AWRD 0x00000000) @ 0x17ff3000
ACPI: FADT (v001 VIA694 MSI ACPI 0x42302e31 AWRD 0x00000000) @ 0x17ff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro nmi_watchdog=1 lapic ide2=noprobe ide3=noprobe ide4=noprobe ide5=noprobe
ide_setup: ide2=noprobe
ide_setup: ide3=noprobe
ide_setup: ide4=noprobe
ide_setup: ide5=noprobe
Initializing CPU#0
CPU 0 irqstacks, hard=c03c1000 soft=c03c0000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1299.326 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 385988k/393152k available (1633k kernel code, 6620k reserved, 1004k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2572.28 BogoMIPS (lpj=1286144)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) processor stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ11 SCI: Level Trigger.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb590, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 02): [55] 89 & 1f -> 09
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc060
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc090, dseg 0xf0000
spurious 8259A interrupt: IRQ7.
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:07.5[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:0d.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
Machine check exception polling timer started.
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
vesafb: probe of vesafb0 failed with error -6
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: AGP aperture is 64M @ 0xd0000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
divert: not allocating divert_blk for non-ethernet device lo
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SP1614N, ATA DISK drive
hdb: ST340014A, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST GCE-8400B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdb: max request size: 1024KiB
hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
SLPB PCI0 USB0 USB1 MODM UAR1 UAR2 LPT1 
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
Adding 1028152k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 11 (level, low) -> IRQ 11
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 at 0xd880e000, 00:40:95:30:0b:b0, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
divert: allocating divert_blk for eth1
eth1: RealTek RTL8139 at 0xd8814000, 00:c0:df:04:7f:9b, IRQ 10
eth1:  Identified 8139 chip type 'RTL-8139B'
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
bttv0: Bt878 (rev 2) at 0000:00:0d.0, irq: 11, latency: 32, mmio: 0xd9002000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=37284, tuner=Philips FM1216 (5), radio=yes
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp3400: Ignoring new-style parameters in presence of obsolete ones
msp34xx: init: chip=MSP3410D-B4 +nicam +simple
msp3410: daemon started
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: Ignoring new-style parameters in presence of obsolete ones
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
tvaudio: found tda9840 @ 0x84
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner: Ignoring new-style parameters in presence of obsolete ones
tuner: chip found at addr 0xc2 i2c-bus bt878 #0 [sw]
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by bt878 #0 [sw]
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
inserting floppy driver for 2.6.10-rc1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
[drm] Initialized mga 3.1.0 20021029 on minor 0: Matrox Graphics, Inc. MGA G400 AGP
SCSI subsystem initialized
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:07.5[C] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:07.5 to 64
parport0: PC-style at 0x378 [PCSPP,EPP]
parport_pc: Via 686A parallel port: io=0x378
lp0: using parport0 (polling).
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
PCI: Via IRQ fixup for 0000:00:07.2, from 9 to 10
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:07.2: irq 10, io base 0xc400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 (level, low) -> IRQ 10
PCI: Via IRQ fixup for 0000:00:07.3, from 9 to 10
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:07.3: irq 10, io base 0xc800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:0d.1[A] -> GSI 11 (level, low) -> IRQ 11
usb 2-1: new full speed USB device using uhci_hcd and address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x03F0 pid 0x7204
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
Disabled Privacy Extensions on device c032b1e0(lo)
eth1: link up, 100Mbps, full-duplex, lpa 0x41E1
eth1: no IPv6 routers present
divert: not allocating divert_blk for non-ethernet device tun6to4
Disabled Privacy Extensions on device d6cfdc00(tun6to4)
u32 classifier
    OLD policer on 
eth0: link down
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (3071 buckets, 24568 max) - 336 bytes per conntrack
eth0: no IPv6 routers present
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
divert: no divert_blk to free, tun6to4 not ethernet
divert: not allocating divert_blk for non-ethernet device tun6to4
Disabled Privacy Extensions on device d6cfdc00(tun6to4)
Unable to handle kernel paging request at virtual address 08e1c5a0
 printing eip:
c0109ba9
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: binfmt_misc ipt_MASQUERADE iptable_nat ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables cls_u32 sch_sfq sch_cbq usb_storage usblp snd_bt87x uhci_hcd usbcore md dm_mod md5 ipv6 eeprom via686a i2c_sensor i2c_isa i2c_viapro parport_pc lp parport snd_via82xx snd_mpu401_uart snd_ens1371 snd_rawmidi snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_ac97_codec snd soundcore sd_mod scsi_mod mga ide_cd cdrom floppy tuner tvaudio msp3400 bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc i2c_core videodev analog gameport joydev 8139too mii
CPU:    0
EIP:    0060:[dma_free_coherent+41/96]    Not tainted VLI
EFLAGS: 00210206   (2.6.10-rc1) 
EIP is at dma_free_coherent+0x29/0x60
eax: 00000000   ebx: cdfe0000   ecx: cdfe0000   edx: 00000000
esi: 08e1c5a0   edi: c2ec2654   ebp: c3daaf60   esp: d1b31f20
ds: 007b   es: 007b   ss: 0068
Process tvtime (pid: 5895, threadinfo=d1b31000 task=c0b58040)
Stack: 00000000 cdfe0000 d88c2037 0dfe0000 d88e25de c2ec25c4 c2ec25a0 d4aa29c0 
       d68c1b40 d8917d05 00000000 d6f4f7e0 d21abba0 d88e39fb c724de40 b77e7000 
       d21abba0 d6dd65fc c448a2e0 c448a2e0 d21abba0 d21abba0 c013d9ea 00000000 
Call Trace:
 [pg0+407638071/1069536256] btcx_riscmem_free+0x37/0x80 [btcx_risc]
 [pg0+407770590/1069536256] videobuf_dma_pci_unmap+0x2e/0x80 [video_buf]
 [pg0+407989509/1069536256] bttv_dma_free+0x55/0x80 [bttv]
 [pg0+407775739/1069536256] videobuf_vm_close+0x8b/0xc0 [video_buf]
 [remove_vm_struct+90/96] remove_vm_struct+0x5a/0x60
 [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
 [do_munmap+246/320] do_munmap+0xf6/0x140
 [sys_munmap+64/112] sys_munmap+0x40/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Code: 00 00 56 31 f6 85 c0 53 89 cb 74 06 8b b0 b8 00 00 00 8d 42 ff ba ff ff ff ff c1 e8 0b 90 8d 74 26 00 42 d1 e8 75 fb 85 f6 74 13 <8b> 0e 39 cb 72 0d 8b 46 08 c1 e0 0c 8d 04 08 39 c3 72 09 89 d8 
 <6>SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S 00000007     0     1      0     2               (NOTLB)
c136feb8 00000086 c0133b4d 00000007 c136fed8 d6fcbaf4 c136fed8 00000001 
       00000000 c148cfc0 000f45ed c1370a00 c1370b5c 003dcb8f c136fecc 0000000b 
       0000000b c0296f60 d7c162e0 c0133cdf 00000000 d174d88c c03e8640 003dcb8f 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
ksoftirqd/0   S 00000000     0     2      1             3       (L-TLB)
d7fc2fc0 00000046 c1370510 00000000 c0104790 00000000 118e01c0 000f44d2 
       00000000 7af171c0 000f45e9 c1370510 c137066c 00000000 d7fc2000 00000000 
       c011cc30 c011ccb0 d7fc2000 c136ff90 c0129304 fffffffc ffffffff ffffffff 
Call Trace:
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [ksoftirqd+0/160] ksoftirqd+0x0/0xa0
 [ksoftirqd+128/160] ksoftirqd+0x80/0xa0
 [kthread+148/160] kthread+0x94/0xa0
 [kthread+0/160] kthread+0x0/0xa0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
events/0      R running     0     3      1     4     111     2 (L-TLB)
khelper       S C0115F37     0     4      3            16       (L-TLB)
d7fc8f54 00000046 d7fc8f40 c0115f37 c137b7f8 00000001 00000003 00000000 
       00000000 d23cd0c0 000f4524 d7fc7a20 d7fc7b7c 00000296 c137b7e0 c137b7f0 
       d7fc8fa0 c0125ec5 00000000 c011564a c03c67a0 c137b7f8 c0125ab0 d7fc8000 
Call Trace:
 [__wake_up_common+55/96] __wake_up_common+0x37/0x60
 [worker_thread+469/512] worker_thread+0x1d5/0x200
 [activate_task+90/112] activate_task+0x5a/0x70
 [__call_usermodehelper+0/80] __call_usermodehelper+0x0/0x50
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [__wake_up_common+55/96] __wake_up_common+0x37/0x60
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [worker_thread+0/512] worker_thread+0x0/0x200
 [kthread+148/160] kthread+0x94/0xa0
 [kthread+0/160] kthread+0x0/0xa0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
kacpid        S D6CC4300     0    16      3            86     4 (L-TLB)
d7fc9f54 00000046 00000000 d6cc4300 d7fc9f3c 00010000 00010000 d7fc7530 
       00000000 d7b124c0 000f41fa d7fc7530 d7fc768c d7fc9000 d7fd6de0 d7fd6df0 
       d7fc9fa0 c0125ec5 d7fc9f74 c011564a c03c67a0 00000000 c1370020 d7fc9000 
Call Trace:
 [worker_thread+469/512] worker_thread+0x1d5/0x200
 [activate_task+90/112] activate_task+0x5a/0x70
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [__wake_up_common+55/96] __wake_up_common+0x37/0x60
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [worker_thread+0/512] worker_thread+0x0/0x200
 [kthread+148/160] kthread+0x94/0xa0
 [kthread+0/160] kthread+0x0/0xa0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
kblockd/0     S D7F2A460     0    86      3           109    16 (L-TLB)
d7f22f54 00000046 c03f2ea0 d7f2a460 d7eb64f8 00000001 7244afab 000f45ee 
       00000000 724f6a40 000f45ee d7fc7040 d7fc719c 00000282 d7eb64e0 d7eb64f0 
       d7f22fa0 c0125ec5 00000000 c011564a c03c67a0 d7eb64f8 c0210d60 d7f22000 
Call Trace:
 [worker_thread+469/512] worker_thread+0x1d5/0x200
 [activate_task+90/112] activate_task+0x5a/0x70
 [blk_unplug_work+0/16] blk_unplug_work+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [__wake_up_common+55/96] __wake_up_common+0x37/0x60
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [worker_thread+0/512] worker_thread+0x0/0x200
 [kthread+148/160] kthread+0x94/0xa0
 [kthread+0/160] kthread+0x0/0xa0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
pdflush       S C011564A     0   109      3           110    86 (L-TLB)
d7ec6f94 00000046 d7ec6f74 c011564a c03c67a0 00000000 c1370020 c03c67a0 
       00000000 e08371c0 000f41fa d7ec5a40 d7ec5b9c d7ec6fbc d7ec6fb0 d7ec6000 
       c0135520 c013542e d7ec6000 d7ec6000 c136ff84 00000000 c013553a d7ec5a40 
Call Trace:
 [activate_task+90/112] activate_task+0x5a/0x70
 [pdflush+0/32] pdflush+0x0/0x20
 [__pdflush+110/352] __pdflush+0x6e/0x160
 [pdflush+26/32] pdflush+0x1a/0x20
 [pdflush+0/32] pdflush+0x0/0x20
 [kthread+148/160] kthread+0x94/0xa0
 [kthread+0/160] kthread+0x0/0xa0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
pdflush       S 00000000     0   110      3           112   109 (L-TLB)
d7ecdf94 00000046 00000000 00000000 00000000 00000000 00000000 00000005 
       00000000 a9ebdd80 000f45ee d7ec5550 d7ec56ac d7ecdfbc d7ecdfb0 d7ecd000 
       c0135520 c013542e d7ecd000 d7ecd000 c136ff84 00000000 c013553a d7ec5550 
Call Trace:
 [pdflush+0/32] pdflush+0x0/0x20
 [__pdflush+110/352] __pdflush+0x6e/0x160
 [pdflush+26/32] pdflush+0x1a/0x20
 [pdflush+0/32] pdflush+0x0/0x20
 [kthread+148/160] kthread+0x94/0xa0
 [kthread+0/160] kthread+0x0/0xa0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
aio/0         S 00000000     0   112      3                 110 (L-TLB)
d7ed3f54 00000046 00000000 00000000 00000000 00010000 e08371c0 000f41fa 
       00000000 e08371c0 000f41fa d7ed2a60 d7ed2bbc d7ed3000 d7ec87e0 d7ec87f0 
       d7ed3fa0 c0125ec5 d7ed3f74 c011564a c03c67a0 00000000 c1370020 d7ed3000 
Call Trace:
 [worker_thread+469/512] worker_thread+0x1d5/0x200
 [activate_task+90/112] activate_task+0x5a/0x70
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [__wake_up_common+55/96] __wake_up_common+0x37/0x60
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [worker_thread+0/512] worker_thread+0x0/0x200
 [kthread+148/160] kthread+0x94/0xa0
 [kthread+0/160] kthread+0x0/0xa0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
kswapd0       S 00000001     0   111      1           193     3 (L-TLB)
d7ecff8c 00000046 0000000c 00000001 00000000 00000020 00000020 00000020 
       00000000 72126140 000f45ee d7ec5060 d7ec51bc d7ecf000 c02e667c d7ecffc0 
       c02e62c0 c013a3ec c02ad7e6 00000000 00000000 00000000 d7ec5060 c01296a0 
Call Trace:
 [kswapd+172/208] kswapd+0xac/0xd0
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [kswapd+0/208] kswapd+0x0/0xd0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
kseriod       S 00000000     0   193      1           254   111 (L-TLB)
d7ee1f90 00000046 d7ee1fcc 00000000 c02e58c0 c012090b d7ee1000 d7ee1000 
       00000000 f5da1740 000f41fa d7ed2080 d7ed21dc d7ee1fc0 fffff000 d7ee1000 
       d7ee1fcc c0203022 c02b97db d7ee1000 00000000 d7ed2080 c01296a0 d7ee1fcc 
Call Trace:
 [switch_uid+59/112] switch_uid+0x3b/0x70
 [serio_thread+194/288] serio_thread+0xc2/0x120
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [serio_thread+0/288] serio_thread+0x0/0x120
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
kjournald     S D6878B0C     0   254      1           329   193 (L-TLB)
d7c5af68 00000046 d6878b0c d6878b0c d7c128c4 00000001 00000003 00000000 
       00000000 b01ec780 000f45ee d7efea80 d7efebdc d7c12880 00000000 00000001 
       d7c128d4 c0191f7f 00000000 00000005 d7c128c4 00000046 00000000 d7efea80 
Call Trace:
 [kjournald+479/496] kjournald+0x1df/0x1f0
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [commit_timeout+0/16] commit_timeout+0x0/0x10
 [kjournald+0/496] kjournald+0x0/0x1f0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
udevd         S 00000000     0   329      1          1036   254 (NOTLB)
d6fffeb8 00000086 c0133b4d 00000000 000004d0 c014b159 d71f729c 00000001 
       00000000 0befd280 000f4526 d6ffeaa0 d6ffebfc 00000000 7fffffff 00000006 
       00000006 c0296fb1 d7c160a0 c0133cdf 00000000 c015956f d6e49800 00000246 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [invalidate_inode_buffers+9/64] invalidate_inode_buffers+0x9/0x40
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [datagram_poll+18/176] datagram_poll+0x12/0xb0
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
msp3410 [auto S 00000002     0  1036      1          1070   329 (L-TLB)
d683df70 00000046 00010040 00000002 d683df2a d6e52154 0d691180 000f45d5 
       000493e0 0d691180 000f45d5 d68355f0 d683574c d6e52000 d6e52154 ffffffff 
       d683df9c d88db0ed ffffffff 00000000 d68355f0 c0115ef0 00000000 00000000 
Call Trace:
 [pg0+407740653/1069536256] msp34xx_sleep+0xcd/0xd0 [msp3400]
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [pg0+407742330/1069536256] msp3410d_thread+0x4a/0x520 [msp3400]
 [pg0+407742256/1069536256] msp3410d_thread+0x0/0x520 [msp3400]
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
tda9840       S C03C67A0     0  1070      1          2261  1036 (L-TLB)
d6818f88 00000046 00000097 c03c67a0 c02e58c0 c012090b d6818000 d6818000 
       00000000 bc9138c0 000f4348 d681cac0 d681cc1c d6e52200 d6818000 d6e52390 
       d6818fc0 d88f1566 d88f2dac d6e522e0 d6e522e0 d88f52c0 00000000 d681cac0 
Call Trace:
 [switch_uid+59/112] switch_uid+0x3b/0x70
 [pg0+407831910/1069536256] chip_thread+0x166/0x190 [tvaudio]
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [pg0+407831552/1069536256] chip_thread+0x0/0x190 [tvaudio]
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
kjournald     S C3340660     0  2261      1          2498  1070 (L-TLB)
d719af68 00000046 c0db9a3c c3340660 d7f9f4e4 00000001 00000003 00000000 
       00000000 1ecdda00 000f45ee d681c5d0 d681c72c d7f9f4a0 00000000 00000001 
       d7f9f4f4 c0191f7f 00000000 00000005 d7f9f4e4 00000000 00000000 d681c5d0 
Call Trace:
 [kjournald+479/496] kjournald+0x1df/0x1f0
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [__fput+158/256] __fput+0x9e/0x100
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [commit_timeout+0/16] commit_timeout+0x0/0x10
 [kjournald+0/496] kjournald+0x0/0x1f0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
khubd         S D6AFC620     0  2498      1          3507  2261 (L-TLB)
d702df90 00000046 d5ee2e00 d6afc620 d8b00b04 00000003 d702d000 d702d000 
       00000000 75d534c0 000f4200 d68ab0c0 d68ab21c d702dfc0 fffff000 d702d000 
       d702dfcc d8b00e82 d8b0b4b4 d702d000 00000000 d68ab0c0 c01296a0 d702dfcc 
Call Trace:
 [pg0+409991940/1069536256] hub_events+0x64/0x320 [usbcore]
 [pg0+409992834/1069536256] hub_thread+0xc2/0x110 [usbcore]
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [pg0+409992640/1069536256] hub_thread+0x0/0x110 [usbcore]
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
dhclient3     S D68D0A00     0  3507      1          3583  2498 (NOTLB)
d66a2eb8 00000082 c0133b4d d68d0a00 c01296a0 d66a2e8c d66a2ed0 00000001 
       00000000 67268740 000f45e7 d68d0a00 d68d0b5c 005c1714 d66a2ecc 00000006 
       00000006 c0296f60 d6ed1e38 c0133cdf 00000000 c03e8a10 c03e8a10 005c1714 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
portmap       S 00000010     0  3583      1          3781  3507 (NOTLB)
d6969f24 00000082 d6998550 00000010 c02e662c 00000000 000000d0 00000001 
       00000000 af241980 000f422d d6998550 d69986ac 00000000 7fffffff 7fffffff 
       d6969000 c0296fb1 c0330200 d71d8f10 d6e14240 00000001 c023b1f2 00000145 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [sock_poll+18/32] sock_poll+0x12/0x20
 [do_pollfd+82/144] do_pollfd+0x52/0x90
 [do_poll+148/192] do_poll+0x94/0xc0
 [sys_poll+303/512] sys_poll+0x12f/0x200
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [filp_close+79/128] filp_close+0x4f/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
syslogd       S D68ABAA0     0  3781      1          3788  3583 (NOTLB)
d673aeb8 00000082 c0133b4d d68abaa0 c0115ef0 c032432c 7552ea56 000f45ed 
       00000000 75685f80 000f45ed d68abaa0 d68abbfc 00000000 7fffffff 00000001 
       00000001 c0296fb1 d7fd3198 c0133cdf 00000000 c015956f d6e49b00 00000246 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [datagram_poll+18/176] datagram_poll+0x12/0xb0
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [do_setitimer+417/464] do_setitimer+0x1a1/0x1d0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
klogd         R running     0  3788      1          3918  3781 (NOTLB)
named         S C012329F     0  3918      1          3919  3788 (NOTLB)
d6294fa4 00000082 d6294000 c012329f d7390920 d738da60 d6294fbc c02969e2 
       00000000 ab5e97c0 000f4206 d738da60 d738dbbc d6294000 bffffcf0 00000000 
       d6294000 c01030cd 00004003 00000000 00000000 00000000 bffffcf0 c0103d59 
Call Trace:
 [sys_rt_sigaction+111/160] sys_rt_sigaction+0x6f/0xa0
 [schedule+674/1184] schedule+0x2a2/0x4a0
 [sys_rt_sigsuspend+141/176] sys_rt_sigsuspend+0x8d/0xb0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
named         S 2000BF60     0  3919      1          3920  3918 (NOTLB)
d5cebe98 00000082 c029e4c0 2000bf60 ffffffff 30383230 fcd45780 000f45ed 
       00000000 fcd45780 000f45ed d738d570 d738d6cc 08092abc 7fffffff fffffff5 
       d5cebef0 c0296fb1 d5cebf04 c0129c12 c01154fb 00000000 00000065 35b42b40 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [get_futex_key+66/288] get_futex_key+0x42/0x120
 [recalc_task_prio+139/384] recalc_task_prio+0x8b/0x180
 [queue_me+53/96] queue_me+0x35/0x60
 [futex_wait+290/400] futex_wait+0x122/0x190
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [invalidate_inode_buffers+9/64] invalidate_inode_buffers+0x9/0x40
 [do_futex+53/128] do_futex+0x35/0x80
 [sys_futex+224/240] sys_futex+0xe0/0xf0
 [copy_to_user+50/80] copy_to_user+0x32/0x50
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
named         S D7C2CC40     0  3920      1          3921  3919 (NOTLB)
d5c7de98 00000082 d76da1c8 d7c2cc40 c12b0500 c0130e8c fcd45780 000f45ed 
       00000000 fcd45780 000f45ed d6c0d0a0 d6c0d1fc 003e3124 d5c7deac fffffff5 
       d5c7def0 c0296f60 d5c7df04 c0129c12 c01154fb d19124ec d01394ec 003e3124 
Call Trace:
 [filemap_nopage+364/688] filemap_nopage+0x16c/0x2b0
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [get_futex_key+66/288] get_futex_key+0x42/0x120
 [recalc_task_prio+139/384] recalc_task_prio+0x8b/0x180
 [process_timeout+0/16] process_timeout+0x0/0x10
 [futex_wait+290/400] futex_wait+0x122/0x190
 [get_futex_key+66/288] get_futex_key+0x42/0x120
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [do_futex+53/128] do_futex+0x35/0x80
 [copy_from_user+52/128] copy_from_user+0x34/0x80
 [sys_futex+224/240] sys_futex+0xe0/0xf0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
named         S D5886B98     0  3921      1          3947  3920 (NOTLB)
d60d5eb8 00000082 c0133b4d d5886b98 d60d5ebc c02e6280 d76da1c8 00000001 
       00000000 b7782080 000f4206 d6c0d590 d6c0d6ec 00000000 7fffffff 0000001c 
       0000001c c0296fb1 d75a9ce0 c0133cdf d8ad6160 00000246 d8ad6160 d59e3a80 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [tcp_poll+26/320] tcp_poll+0x1a/0x140
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [pipe_read+32/48] pipe_read+0x20/0x30
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
acpid         S 00000000     0  3947      1          3975  3921 (NOTLB)
d58fef24 00000082 00000001 00000000 d6c0da80 00000010 c02e662c 00000000 
       00000000 c59875c0 000f4206 d6c0da80 d6c0dbdc 00000000 7fffffff 7fffffff 
       d58fe000 c0296fb1 d670e3f0 c0293792 c0331c60 d670e3f0 c023b1f2 00000145 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [unix_poll+18/144] unix_poll+0x12/0x90
 [sock_poll+18/32] sock_poll+0x12/0x20
 [do_pollfd+82/144] do_pollfd+0x52/0x90
 [do_poll+148/192] do_poll+0x94/0xc0
 [sys_poll+303/512] sys_poll+0x12f/0x200
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
cupsd         S D5254638     0  3975      1          4059  3947 (NOTLB)
d5980eb8 00000082 00000000 d5254638 d5980ef0 00000001 00000000 d738d080 
       00000000 6208c480 000f45ec d738d080 d738d1dc 003e1632 d5980ecc 00000004 
       00000004 c0296f60 00000000 c015956f c0330200 d2fe2b6c c601d36c 003e1632 
Call Trace:
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_time+22/80] sys_time+0x16/0x50
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
dbus-daemon-1 S 00000010     0  4059      1          4063  3975 (NOTLB)
d6790f24 00000082 d5528080 00000010 c02e662c 00000000 000000d0 00000000 
       000f4240 c8661f40 000f4207 d5528080 d55281dc 00000000 7fffffff 7fffffff 
       d6790000 c0296fb1 d5679850 c0293792 c0331c60 d5679850 c023b1f2 00000145 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [unix_poll+18/144] unix_poll+0x12/0x90
 [sock_poll+18/32] sock_poll+0x12/0x20
 [do_pollfd+82/144] do_pollfd+0x52/0x90
 [do_poll+148/192] do_poll+0x94/0xc0
 [sys_poll+303/512] sys_poll+0x12f/0x200
 [copy_to_user+50/80] copy_to_user+0x32/0x50
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
dhcpd3        S D5528570     0  4063      1          4190  4059 (NOTLB)
d6199eb8 00000086 c0133b4d d5528570 c01296a0 d6199e8c d6199ed0 00000001 
       00000000 560ebfc0 000f45ee d5528570 d55286cc 00000000 7fffffff 00000008 
       00000008 c0296fb1 d6e2ee58 c0133cdf 00000000 c015956f d7fd4a40 00000246 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [datagram_poll+18/176] datagram_poll+0x12/0xb0
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
exim4         S 00000000     0  4190      1          4195  4063 (NOTLB)
d5463eb8 00000086 d6efa018 00000000 d7fe716c 00000001 00000000 d5528a60 
       00000000 f0b7c1c0 000f454e d5528a60 d5528bbc 00000000 7fffffff 00000002 
       00000002 c0296fb1 00000000 c015956f c0330200 00000246 c0330200 d703f800 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [tcp_poll+26/320] tcp_poll+0x1a/0x140
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_rt_sigaction+141/160] sys_rt_sigaction+0x8d/0xa0
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
famd          S 00000000     0  4195      1          4200  4190 (NOTLB)
d5690eb8 00000082 d5690e94 00000000 00000001 00000001 d1bcbc80 000f45ee 
       000186a0 d1bcbc80 000f45ee d567da20 d567db7c 003dd883 d5690ecc 000000ee 
       0000000e c0296f60 00000000 c015956f c0330200 c03e86a8 c02e3898 003dd883 
Call Trace:
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
gpm           S 00000001     0  4200      1          4206  4195 (NOTLB)
d552ceb8 00000082 00000000 00000001 c0133b4d c03c1ff8 54d2586b 01c9c13c 
       00000000 55942e00 000f45ed d55cf550 d55cf6ac 05640cf8 d552cecc 00000003 
       00000003 c0296f60 d6c327e0 d552cf4c c03f72dc c03e8bf0 d55cfb78 05640cf8 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [pipe_write+32/48] pipe_write+0x20/0x30
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
inetd         S C012329F     0  4206      1          4217  4200 (NOTLB)
d594cfa4 00000086 d594c000 c012329f 00000296 00000000 d6dd7da0 d6cd3b4c 
       000f4240 9420a9c0 000f4208 d681c0e0 d681c23c d594c000 0804d660 bffffdb0 
       d594c000 c01030cd 00012001 00000000 00000000 00000000 0804d660 c0103d59 
Call Trace:
 [sys_rt_sigaction+111/160] sys_rt_sigaction+0x6f/0xa0
 [sys_rt_sigsuspend+141/176] sys_rt_sigsuspend+0x8d/0xb0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
mldonkey_serv S D5525FC4     0  4217      1  4220    4248  4206 (NOTLB)
d5525f3c 00000082 b8000530 d5525fc4 c02ab5c8 00000007 0000000e 0000000b 
       00000000 a14cdb00 000f4208 d55cfa40 d55cfb9c fffffe00 00000004 d55cfae4 
       d55cfa40 c011b7ec bffffb70 00000282 d5525f64 d55cfae4 00000000 00000001 
Call Trace:
 [do_wait+380/1040] do_wait+0x17c/0x410
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [sys_alarm+48/96] sys_alarm+0x30/0x60
 [sys_wait4+49/64] sys_wait4+0x31/0x40
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
mlnet         S 00000000     0  4220   4217          4222       (NOTLB)
d5526f24 00000086 c02e662c 00000000 000000d0 00000000 000000d0 c7859c40 
       00000000 d1bcbc80 000f45ee d55cf060 d55cf1bc 003dca00 d5526f38 0000001e 
       d5526000 c0296f60 c0330200 c2ec57a0 c601b1a0 c03e7de8 c03e7de8 003dca00 
Call Trace:
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_poll+148/192] do_poll+0x94/0xc0
 [sys_poll+303/512] sys_poll+0x12f/0x200
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
mlnet         S 00000000     0  4363   4217          4502  4224 (NOTLB)
d727be98 00000086 00000000 00000000 d727bef0 cdd00880 d54e25f0 c01296a0 
       00000000 d859f680 000f45ed d54e25f0 d54e274c 003de09d d727beac fffffff5 
       d727bef0 c0296f60 d727bf04 c0129c12 c023a523 c03e86e8 c032db88 003de09d 
Call Trace:
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [get_futex_key+66/288] get_futex_key+0x42/0x120
 [move_addr_to_user+99/112] move_addr_to_user+0x63/0x70
 [process_timeout+0/16] process_timeout+0x0/0x10
 [futex_wait+290/400] futex_wait+0x122/0x190
 [get_futex_key+66/288] get_futex_key+0x42/0x120
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [invalidate_inode_buffers+9/64] invalidate_inode_buffers+0x9/0x40
 [do_futex+53/128] do_futex+0x35/0x80
 [copy_from_user+52/128] copy_from_user+0x34/0x80
 [sys_futex+224/240] sys_futex+0xe0/0xf0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
mlnet         S 00000046     0  4502   4217                4363 (NOTLB)
d201be98 00000086 00000000 00000046 c03c1ff8 00000001 279f4f00 000f4572 
       00000000 54173580 000f45ee d27a4040 d27a419c 003de8b9 d201beac fffffff5 
       d201bef0 c0296f60 d201bf04 c0129c12 0000007b c03e8728 d190e20c 003de8b9 
Call Trace:
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [get_futex_key+66/288] get_futex_key+0x42/0x120
 [process_timeout+0/16] process_timeout+0x0/0x10
 [futex_wait+290/400] futex_wait+0x122/0x190
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [get_futex_key+66/288] get_futex_key+0x42/0x120
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [recalc_task_prio+139/384] recalc_task_prio+0x8b/0x180
 [do_futex+53/128] do_futex+0x35/0x80
 [copy_from_user+52/128] copy_from_user+0x34/0x80
 [sys_futex+224/240] sys_futex+0xe0/0xf0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
logger        S 00000054     0  4222   4217          4224  4220 (NOTLB)
d567fee4 00000086 00000000 00000054 00000000 00000000 d567fea8 00000001 
       00000000 66c53940 000f4209 d6ffe5b0 d6ffe70c d55c7a98 d55c7a30 d567ff0c 
       00000000 c0153539 00000000 d6ffe5b0 c01296a0 d567ff18 d567ff18 d7ed1e00 
Call Trace:
 [pipe_wait+121/160] pipe_wait+0x79/0xa0
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [pipe_readv+388/640] pipe_readv+0x184/0x280
 [pipe_read+32/48] pipe_read+0x20/0x30
 [vfs_read+205/288] vfs_read+0xcd/0x120
 [sys_read+71/128] sys_read+0x47/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
logger        S 00000000     0  4224   4217          4363  4222 (NOTLB)
d6d6cee4 00000086 c1297180 00000000 00000000 d6b1ad60 00000001 b7f63f50 
       00000000 a14cdb00 000f4208 d567d040 d567d19c d55c7bb4 d55c7b4c d6d6cf0c 
       00000000 c0153539 00000000 d567d040 c01296a0 d6d6cf18 d6d6cf18 00000000 
Call Trace:
 [pipe_wait+121/160] pipe_wait+0x79/0xa0
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [vma_merge+187/400] vma_merge+0xbb/0x190
 [pipe_readv+388/640] pipe_readv+0x184/0x280
 [pipe_read+32/48] pipe_read+0x20/0x30
 [vfs_read+205/288] vfs_read+0xcd/0x120
 [sys_read+71/128] sys_read+0x47/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
sshd          S D3ED8358     0  4248      1          4253  4217 (NOTLB)
d546deb8 00000086 00000000 d3ed8358 d546def0 00000001 00000000 d567b510 
       000f4240 12127c00 000f4209 d567b510 d567b66c 00000000 7fffffff 00000004 
       00000004 c0296fb1 00000000 c015956f d8ad6160 00000246 d8ad6160 d59e24a0 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [tcp_poll+26/320] tcp_poll+0x1a/0x140
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
vsftpd        S 00000000     0  4253      1          4313  4248 (NOTLB)
d552be04 00000086 00000000 00000000 00000000 00000000 00000000 00000000 
       002dc6c0 23b71600 000f4209 d567b020 d567b17c d567b020 7fffffff d552b000 
       7fffffff c0296fb1 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [wait_for_connect+238/256] wait_for_connect+0xee/0x100
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [tcp_accept+101/256] tcp_accept+0x65/0x100
 [inet_accept+39/176] inet_accept+0x27/0xb0
 [alloc_inode+217/384] alloc_inode+0xd9/0x180
 [sys_accept+128/288] sys_accept+0x80/0x120
 [tcp_v4_hash+196/272] tcp_v4_hash+0xc4/0x110
 [tcp_listen_start+285/384] tcp_listen_start+0x11d/0x180
 [__sock_create+159/400] __sock_create+0x9f/0x190
 [inet_listen+49/128] inet_listen+0x31/0x80
 [sys_socketcall+197/592] sys_socketcall+0xc5/0x250
 [sigprocmask+76/176] sigprocmask+0x4c/0xb0
 [sys_rt_sigprocmask+83/176] sys_rt_sigprocmask+0x53/0xb0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
bash          S C01140BB     0  4313      1  4314    4364  4253 (NOTLB)
d5673f28 00000086 d54e2ae0 c01140bb 00000001 000010dc ab040f6e 000f4209 
       00000000 ab6f5940 000f4209 d54e2ae0 d54e2c3c fffffe00 00000004 d54e2b84 
       d54e2ae0 c011b7ec 00030002 00000000 d6998060 d54e2b84 00000000 00000001 
Call Trace:
 [do_page_fault+379/1434] do_page_fault+0x17b/0x59a
 [do_wait+380/1040] do_wait+0x17c/0x410
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [sys_wait4+49/64] sys_wait4+0x31/0x40
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
bash          S C01140BB     0  4314   4313  4315    4316       (NOTLB)
d2e49f28 00000086 d7ed2570 c01140bb 00000001 c0103c25 00000001 080ef058 
       00000000 abbba480 000f4209 d7ed2570 d7ed26cc fffffe00 00000004 d7ed2614 
       d7ed2570 c011b7ec 00030002 00000000 00000000 d7ed2614 00000000 00000001 
Call Trace:
 [do_page_fault+379/1434] do_page_fault+0x17b/0x59a
 [do_signal+181/272] do_signal+0xb5/0x110
 [do_wait+380/1040] do_wait+0x17c/0x410
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [sys_wait4+49/64] sys_wait4+0x31/0x40
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Xprt          S D38A66A8     0  4315   4314                     (NOTLB)
d2e68eb8 00000086 c0133b4d d38a66a8 d2e68ebc c02e6280 00f7b4d6 00000001 
       00000000 b60b2d40 000f45db d68d0020 d68d017c 0045b10d d2e68ecc 00000001 
       00000001 c0296f60 d3a38bb8 c0133cdf 00000000 c03e8898 c03e8898 0045b10d 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [__copy_to_user_ll+58/96] __copy_to_user_ll+0x3a/0x60
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
bash          S 00000000     0  4316   4313                4314 (NOTLB)
d3a00ee4 00000082 c01140bb 00000000 00000000 d6d80940 00000001 080a48b0 
       00000000 aad6c2c0 000f4209 d6998060 d69981bc d55c797c d55c7914 d3a00f0c 
       00000000 c0153539 00000000 d6998060 c01296a0 d3a00f18 d3a00f18 00000000 
Call Trace:
 [do_page_fault+379/1434] do_page_fault+0x17b/0x59a
 [pipe_wait+121/160] pipe_wait+0x79/0xa0
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [recalc_task_prio+139/384] recalc_task_prio+0x8b/0x180
 [pipe_readv+388/640] pipe_readv+0x184/0x280
 [pipe_read+32/48] pipe_read+0x20/0x30
 [vfs_read+205/288] vfs_read+0xcd/0x120
 [vfs_llseek+59/80] vfs_llseek+0x3b/0x50
 [sys_read+71/128] sys_read+0x47/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
sensord       S 00000000     0  4364      1          4369  4313 (NOTLB)
d5582f5c 00000086 00010092 00000000 00001000 00000090 317cea96 000f45ea 
       00000000 31925fc0 000f45ea d6835100 d683525c 003e66b2 d5582f70 000f41a7 
       0000003c c0296f60 00000000 00000000 b7f87d54 c03e89b0 d5d6decc 003e66b2 
Call Trace:
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [sys_nanosleep+206/336] sys_nanosleep+0xce/0x150
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
chronyd       S D2579638     0  4369      1          4372  4364 (NOTLB)
d2d7eeb8 00000086 c0133b4d d2579638 d2d7eef0 0001e386 00000000 00000001 
       000186a0 81fec2c0 000f45d4 d54e2100 d54e225c 003ff873 d2d7eecc 00000006 
       00000006 c0296f60 d3a386b8 c0133cdf 00000000 cbc1634c c03e89e0 003ff873 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+90/112] sys_gettimeofday+0x5a/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
atd           S 00000000     0  4372      1          4375  4369 (NOTLB)
d54b8f5c 00000082 00001000 00000000 00001000 00000008 4c85a6ec 000f4550 
       00000000 4cb09140 000f4550 d567ba00 d567bb5c 006a5702 d54b8f70 000f41a7 
       00000e10 c0296f60 00000000 00000000 b7fcdd54 c03e8a18 d014f8d8 006a5702 
Call Trace:
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [sys_nanosleep+206/336] sys_nanosleep+0xce/0x150
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
cron          S 00000000     0  4375      1          4379  4372 (NOTLB)
d593af5c 00000086 000001e8 00000000 00001000 00000008 00000000 417d420d 
       00000000 6f307800 000f45e3 d7efe590 d7efe6ec 003df54b d593af70 000f41a7 
       0000003c c0296f60 00000000 00000000 b7fc4d54 c03e8790 c03e8790 003df54b 
Call Trace:
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [sys_nanosleep+206/336] sys_nanosleep+0xce/0x150
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdm           S 00000000     0  4379      1  4482    4386  4375 (NOTLB)
d54b7eb8 00000082 c0133b4d 00000000 000004d0 00000000 d5ffc540 00000001 
       00000000 efa01d00 000f4229 d68ab5b0 d68ab70c 00000000 7fffffff 00000012 
       00000012 c0296fb1 d39aa8a0 c0133cdf 00000000 c015956f d39aa720 00000246 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [pipe_poll+50/144] pipe_poll+0x32/0x90
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [pipe_read+32/48] pipe_read+0x20/0x30
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
getty         S 00000010     0  4386      1          4387  4379 (NOTLB)
d6c0ee78 00000086 00000010 00000010 00000000 00000000 00000000 00000001 
       00000000 63ac4400 000f420a d7efe0a0 d7efe1fc d75ad000 7fffffff d6c0ef10 
       d6c0e000 c0296fb1 d25a0dc8 d75d76a8 d6c0eebc 00006280 c130e0a0 00000000 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [read_chan+1463/1744] read_chan+0x5b7/0x6d0
 [write_chan+347/528] write_chan+0x15b/0x210
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [tty_write+479/576] tty_write+0x1df/0x240
 [tty_read+215/240] tty_read+0xd7/0xf0
 [write_chan+0/528] write_chan+0x0/0x210
 [vfs_read+205/288] vfs_read+0xcd/0x120
 [sys_read+71/128] sys_read+0x47/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
getty         S 00000010     0  4387      1          4388  4386 (NOTLB)
d2e20e78 00000082 00000010 00000010 00000000 00000000 6be5fa80 000f420a 
       00000000 6be5fa80 000f420a d6998a40 d6998b9c d25a6000 7fffffff d2e20f10 
       d2e20000 c0296fb1 d25a05a8 d75d76a8 d2e20ebc 00006280 d25d9200 00000000 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [read_chan+1463/1744] read_chan+0x5b7/0x6d0
 [write_chan+347/528] write_chan+0x15b/0x210
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [tty_write+479/576] tty_write+0x1df/0x240
 [tty_read+215/240] tty_read+0xd7/0xf0
 [write_chan+0/528] write_chan+0x0/0x210
 [vfs_read+205/288] vfs_read+0xcd/0x120
 [sys_read+71/128] sys_read+0x47/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
getty         S 00000010     0  4388      1          4389  4387 (NOTLB)
d54bae78 00000082 00000010 00000010 00000000 00000000 00000000 00000001 
       00000000 6c418800 000f420a d567d530 d567d68c d26c2000 7fffffff d54baf10 
       d54ba000 c0296fb1 d26a1be8 d75d76a8 d54baebc 00006280 d26d4200 00000000 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [read_chan+1463/1744] read_chan+0x5b7/0x6d0
 [write_chan+347/528] write_chan+0x15b/0x210
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [tty_write+479/576] tty_write+0x1df/0x240
 [tty_read+215/240] tty_read+0xd7/0xf0
 [write_chan+0/528] write_chan+0x0/0x210
 [vfs_read+205/288] vfs_read+0xcd/0x120
 [sys_read+71/128] sys_read+0x47/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
getty         S 00000010     0  4389      1          4390  4388 (NOTLB)
d2813e78 00000086 00000010 00000010 00000000 00000000 00000000 00000001 
       00000000 6c50ca40 000f420a d6835ae0 d6835c3c d27bb000 7fffffff d2813f10 
       d2813000 c0296fb1 d274e288 d75d76a8 d2813ebc 00006280 d27cf200 00000000 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [read_chan+1463/1744] read_chan+0x5b7/0x6d0
 [write_chan+347/528] write_chan+0x15b/0x210
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [tty_write+479/576] tty_write+0x1df/0x240
 [tty_read+215/240] tty_read+0xd7/0xf0
 [write_chan+0/528] write_chan+0x0/0x210
 [vfs_read+205/288] vfs_read+0xcd/0x120
 [sys_read+71/128] sys_read+0x47/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
getty         S 00000010     0  4390      1          4391  4389 (NOTLB)
d24ece78 00000086 00000010 00000010 00000000 00000000 00000000 00000001 
       00000000 6be5fa80 000f420a d6ffe0c0 d6ffe21c d2622000 7fffffff d24ecf10 
       d24ec000 c0296fb1 d69b06e8 d75d76a8 d24ecebc 00006280 d2626200 00000000 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [read_chan+1463/1744] read_chan+0x5b7/0x6d0
 [write_chan+347/528] write_chan+0x15b/0x210
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [tty_write+479/576] tty_write+0x1df/0x240
 [tty_read+215/240] tty_read+0xd7/0xf0
 [write_chan+0/528] write_chan+0x0/0x210
 [vfs_read+205/288] vfs_read+0xcd/0x120
 [sys_read+71/128] sys_read+0x47/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
getty         S 00000010     0  4391      1          4600  4390 (NOTLB)
d29e6e78 00000086 00000010 00000010 00000000 00000000 00000000 00000001 
       00000000 63ac4400 000f420a d2ea7590 d2ea76ec d39c0000 7fffffff d29e6f10 
       d29e6000 c0296fb1 d25a0fa8 d75d76a8 d29e6ebc 00006280 d5ec5200 00000000 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [read_chan+1463/1744] read_chan+0x5b7/0x6d0
 [write_chan+347/528] write_chan+0x15b/0x210
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [tty_write+479/576] tty_write+0x1df/0x240
 [tty_read+215/240] tty_read+0xd7/0xf0
 [write_chan+0/528] write_chan+0x0/0x210
 [vfs_read+205/288] vfs_read+0xcd/0x120
 [sys_read+71/128] sys_read+0x47/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
XFree86       S C032432C     0  4482   4379          4483       (NOTLB)
d27a5eb8 00003086 c0133b4d c032432c 00000001 00000003 00000000 00003082 
       00000000 d2278c40 000f45ee d25ce5b0 d25ce70c 003dc9f5 d27a5ecc 0000001a 
       0000001a c0296f60 d27d0000 d274e9c0 c01ee17d c03e8590 c03e8590 003dc9f5 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [tty_poll+141/176] tty_poll+0x8d/0xb0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [convert_fxsr_from_user+21/224] convert_fxsr_from_user+0x15/0xe0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdm           S C01140BB     0  4483   4379  4512          4482 (NOTLB)
d25daf28 00000082 d2ea7a80 c01140bb 00000001 000011a0 00000001 08064ca0 
       00000000 ea5214c0 000f4229 d2ea7a80 d2ea7bdc fffffe00 00000004 d2ea7b24 
       d2ea7a80 c011b7ec 00030002 00000000 d27a4a20 d2ea7b24 00000000 00000001 
Call Trace:
 [do_page_fault+379/1434] do_page_fault+0x17b/0x59a
 [do_wait+380/1040] do_wait+0x17c/0x410
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [sys_wait4+49/64] sys_wait4+0x31/0x40
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
startkde      S C01140BB     0  4512   4483  4576               (NOTLB)
d276ef28 00000082 d27a4a20 c01140bb 00000001 00001208 00000001 08117e08 
       00000000 0d9cc800 000f422d d27a4a20 d27a4b7c fffffe00 00000004 d27a4ac4 
       d27a4a20 c011b7ec 00030002 00000000 d25ceaa0 d27a4ac4 00000000 00000001 
Call Trace:
 [do_page_fault+379/1434] do_page_fault+0x17b/0x59a
 [do_wait+380/1040] do_wait+0x17c/0x410
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [sys_wait4+49/64] sys_wait4+0x31/0x40
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
ssh-agent     S 00000000     0  4576   4512          4616       (NOTLB)
c4141eb8 00000086 c0133b4d 00000000 00000001 d27a4530 bffff9a0 00000001 
       00000000 8ba46680 000f45ee d27a4530 d27a468c 00000000 7fffffff 00000004 
       00000004 c0296fb1 d013a838 c0133cdf 00000000 c015956f d20a1c40 00000246 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [unix_poll+18/144] unix_poll+0x12/0x90
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [convert_fxsr_from_user+21/224] convert_fxsr_from_user+0x15/0xe0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdeinit       S 00000000     0  4597      1  4602    4618  4615 (NOTLB)
cb2cceb8 00200082 c0133b4d 00000000 000004d0 c41dc0a0 db837dec 000f4235 
       00000000 dbae6840 000f4235 c41dc0a0 c41dc1fc 00000000 7fffffff 0000000a 
       0000000a c0296fb1 d10e2620 c0133cdf 00000000 c015956f c3c90360 00200246 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [unix_poll+18/144] unix_poll+0x12/0x90
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdeinit       S C01296F0     0  4600      1          4605  4391 (NOTLB)
cb241eb8 00200086 c0133b4d c01296f0 0000064a 00000000 000000c5 00000001 
       00000000 6a123580 000f45e7 c635baa0 c635bbfc 00000000 7fffffff 00000015 
       00000015 c0296fb1 d10e2420 c0133cdf 00000000 c015956f c0b85c80 00200246 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [wake_bit_function+0/96] wake_bit_function+0x0/0x60
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [unix_poll+18/144] unix_poll+0x12/0x90
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdeinit       S C0106011     0  4602   4597          4609       (NOTLB)
cb1d9eb8 00200082 c0133b4d c0106011 00000001 c1016400 6db47f00 00000001 
       00000000 6a153400 000f45ed d2ea70a0 d2ea71fc 003dd960 cb1d9ecc 0000002b 
       0000000b c0296f60 d013a0b8 c0133cdf 00000000 c032f3e4 c03e86b0 003dd960 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [do_IRQ+81/112] do_IRQ+0x51/0x70
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdeinit       S C032432C     0  4605      1          4615  4600 (NOTLB)
c6310eb8 00200086 c0133b4d c032432c 00000001 00000003 cd25cf40 000f45ee 
       00000000 cd25cf40 000f45ee c635b5b0 c635b70c 003dc9f9 c6310ecc 0000000f 
       0000000f c0296f60 c632b000 c2dace20 c01ee17d c03e85b0 c03e85b0 003dc9f9 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [tty_poll+141/176] tty_poll+0x8d/0xb0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
artsd         S 00000000     0  4609   4597          4619  4602 (NOTLB)
c414eeb8 00000086 c0133b4d 00000000 c01afe6a c41dca80 c7022780 00000001 
       00000000 d1ea8340 000f45ee c41dca80 c41dcbdc 003dc9f6 c414eecc 00000009 
       00000009 c0296f60 c3cc20a0 c0133cdf 00000000 c03e8598 c03e8598 003dc9f6 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [__copy_to_user_ll+58/96] __copy_to_user_ll+0x3a/0x60
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [convert_fxsr_from_user+21/224] convert_fxsr_from_user+0x15/0xe0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdeinit       S C02E6390     0  4615      1          4597  4605 (NOTLB)
c1c5feb8 00000086 c0133b4d c02e6390 00000001 003d54ae d1bcbc80 000f45ee 
       00000000 d1bcbc80 000f45ee c635b0c0 c635b21c 003dca12 c1c5fecc 0000000e 
       0000000e c0296f60 d3a38cf8 c0133cdf 00000000 c03e7e78 ce1c52a8 003dca12 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kwrapper      S CB240000     0  4616   4512                4576 (NOTLB)
cb240f5c 00000082 0804c008 cb240000 c012198b cb240000 00000001 c0122c34 
       00000000 ae273d40 000f45ee d25ceaa0 d25cebfc 003dcb77 cb240f70 000f41a7 
       00000001 c0296f60 00000000 00000000 b7fcdd54 c090eecc d174d88c 003dcb77 
Call Trace:
 [kill_proc_info+43/64] kill_proc_info+0x2b/0x40
 [sys_kill+84/112] sys_kill+0x54/0x70
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [sys_nanosleep+206/336] sys_nanosleep+0xce/0x150
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdeinit       S C02E6390     0  4618      1          4621  4597 (NOTLB)
c2170eb8 00200082 c0133b4d c02e6390 00000001 00000040 6a93ab97 000f45e7 
       0001b207 6ac95080 000f45e7 c1c4cac0 c1c4cc1c 00000000 7fffffff 00000013 
       00000013 c0296fb1 c2415eb8 c0133cdf 00000000 c015956f c08f11e0 00200246 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [unix_poll+18/144] unix_poll+0x12/0x90
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdeinit       S C350F818     0  4619   4597          4625  4609 (NOTLB)
c635ceb8 00200086 c0133b4d c350f818 c635cebc 00000040 d142aa80 000f45ee 
       00000000 d142aa80 000f45ee c41dc590 c41dc6ec 00000000 7fffffff 0000000b 
       0000000b c0296fb1 c2415878 c0133cdf 00000000 c015956f c1fa1840 00200246 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [unix_poll+18/144] unix_poll+0x12/0x90
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdeinit       S C02E6390     0  4621      1          4623  4618 (NOTLB)
c2bc9eb8 00200082 c0133b4d c02e6390 c0106011 00000040 d0fae6eb 000f45ee 
       00000000 d105a180 000f45ee c1c4c0e0 c1c4c23c 00000000 7fffffff 00000009 
       00000009 c0296fb1 c1fa2cd8 c0133cdf 00000000 c015956f c21666a0 00200246 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [do_IRQ+81/112] do_IRQ+0x51/0x70
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [pipe_poll+50/144] pipe_poll+0x32/0x90
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [__copy_to_user_ll+62/96] __copy_to_user_ll+0x3e/0x60
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdeinit       S C1C4DECC     0  4623      1          4626  4621 (NOTLB)
c1c4deb8 00200082 c0133b4d c1c4decc 00200282 00000040 d0fae6eb 000f45ee 
       00000000 d105a180 000f45ee c1c4c5d0 c1c4c72c 003dd173 c1c4decc 0000000d 
       0000000d c0296f60 c1fa2418 c0133cdf 00000000 c03e8670 c03e8670 003dd173 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdeinit       S C013CB57     0  4625   4597          4648  4619 (NOTLB)
c71ddeb8 00200082 c0133b4d c013cb57 d75b2040 b6825000 fe146fc0 000f4257 
       00000000 fe146fc0 000f4257 c1b535f0 c1b5374c 00000000 7fffffff 00000004 
       00000004 c0296fb1 c1aec438 c0133cdf 00000000 c015956f c050f640 00200246 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [do_anonymous_page+247/288] do_anonymous_page+0xf7/0x120
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [__pollwait+127/192] __pollwait+0x7f/0xc0
 [unix_poll+18/144] unix_poll+0x12/0x90
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdeinit       S 00000000     0  4626      1          4628  4623 (NOTLB)
c1bdceb8 00200086 c0133b4d 00000000 c112b780 00000040 00000020 00000001 
       00000000 d105a180 000f45ee c1b53100 c1b5325c 003dcaab c1bdcecc 00000009 
       00000009 c0296f60 c1fa2058 c0133cdf 00000000 c03e8340 c03e8340 003dcaab 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdeinit       S C02E6390     0  4628      1          4631  4626 (NOTLB)
c0c0aeb8 00200086 c0133b4d c02e6390 00000001 00000040 b30a75c0 000f45ee 
       00000000 b30a75c0 000f45ee c0913a00 c0913b5c 003dcafb c0c0aecc 00000009 
       00000009 c0296f60 c1aec1b8 c0133cdf 00000000 c03e8638 d2d44a8c 003dcafb 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
knetload      S 00000246     0  4631      1          4674  4628 (NOTLB)
c090eeb8 00000082 c0133b4d 00000246 00030002 c0106011 000003b0 00000001 
       00000000 b18cfd80 000f45ee c0b58a20 c0b58b7c 003dcba9 c090eecc 00000009 
       00000009 c0296f60 c0cbb098 c0133cdf 00000000 ce1c528c cb240f70 003dcba9 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [do_IRQ+81/112] do_IRQ+0x51/0x70
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kdeinit       S C032432C     0  4648   4597  4654    4649  4625 (NOTLB)
cb245eb8 00200082 c0133b4d c032432c 00000001 00000003 d142aa80 000f45ee 
       00000000 d142aa80 000f45ee c0913510 c091366c 003ddba8 cb245ecc 00000016 
       00000016 c0296f60 d2a71000 d6fbe600 c01ee17d c03e86c0 c03e86c0 003ddba8 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [tty_poll+141/176] tty_poll+0x8d/0xb0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
mozilla-bin   S 00000010     0  4649   4597          4672  4648 (NOTLB)
c0b94f24 00200082 c1b53ae0 00000010 c02e662c 00000000 000000d0 00000400 
       00000000 d2555300 000f45ee c1b53ae0 c1b53c3c 003dc9f3 c0b94f38 00000007 
       c0b94000 c0296f60 d26276a8 c0293792 c0331c60 c03e8580 c03e8580 003dc9f3 
Call Trace:
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [unix_poll+18/144] unix_poll+0x12/0x90
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_poll+148/192] do_poll+0x94/0xc0
 [sys_poll+303/512] sys_poll+0x12f/0x200
 [copy_to_user+50/80] copy_to_user+0x32/0x50
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
mozilla-bin   S 00000010     0  4672   4597          4721  4649 (NOTLB)
d195bf24 00200082 d3b030a0 00000010 c02e662c 00000000 000000d0 00000001 
       0001b207 4a6f4900 000f45ee d3b030a0 d3b031fc 00000000 7fffffff 7fffffff 
       d195b000 c0296fb1 d195bfa0 c0153bc2 00000145 cef98368 d356d9c0 00000000 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [pipe_poll+50/144] pipe_poll+0x32/0x90
 [do_pollfd+82/144] do_pollfd+0x52/0x90
 [do_poll+148/192] do_poll+0x94/0xc0
 [sys_poll+303/512] sys_poll+0x12f/0x200
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [filp_close+79/128] filp_close+0x4f/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
mozilla-bin   S 003D5AE6     0  4721   4597          6012  4672 (NOTLB)
cf584e98 00200082 c01047b2 003d5ae6 c02dfb00 c09726e0 cb0fc080 000f45ee 
       00000000 cfc53240 000f45ee c61cc0e0 c61cc23c 003dca1c cf584eac fffffff5 
       cf584ef0 c0296f60 cf584f04 c0129c12 c09726e0 c03e7ec8 c03e7ec8 003dca1c 
Call Trace:
 [apic_timer_interrupt+26/32] apic_timer_interrupt+0x1a/0x20
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [get_futex_key+66/288] get_futex_key+0x42/0x120
 [process_timeout+0/16] process_timeout+0x0/0x10
 [futex_wait+290/400] futex_wait+0x122/0x190
 [get_futex_key+66/288] get_futex_key+0x42/0x120
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [do_futex+53/128] do_futex+0x35/0x80
 [copy_from_user+52/128] copy_from_user+0x34/0x80
 [sys_futex+224/240] sys_futex+0xe0/0xf0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
mozilla-bin   S 00000000     0  6012   4597          6013  4721 (NOTLB)
d344be98 00200082 00000000 00000000 d344bef0 cdd00880 585e5940 000f45e7 
       00000000 585e5940 000f45e7 d53e3a40 d53e3b9c 003e36e8 d344beac fffffff5 
       d344bef0 c0296f60 d344bf04 c0129c12 c01154fb c1b94eac c03f98c0 003e36e8 
Call Trace:
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [get_futex_key+66/288] get_futex_key+0x42/0x120
 [recalc_task_prio+139/384] recalc_task_prio+0x8b/0x180
 [process_timeout+0/16] process_timeout+0x0/0x10
 [futex_wait+290/400] futex_wait+0x122/0x190
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [invalidate_inode_buffers+9/64] invalidate_inode_buffers+0x9/0x40
 [do_futex+53/128] do_futex+0x35/0x80
 [copy_from_user+52/128] copy_from_user+0x34/0x80
 [sys_futex+224/240] sys_futex+0xe0/0xf0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
mozilla-bin   S 00000000     0  6013   4597                6012 (NOTLB)
c1b94e98 00200082 00000000 00000000 ffffffff c1b94ea8 67dda240 000f45e7 
       00000000 67dda240 000f45e7 d53e3550 d53e36ac 003e37ec c1b94eac fffffff5 
       c1b94ef0 c0296f60 c1b94f04 c0129c12 c01154fb d174d5cc d344beac 003e37ec 
Call Trace:
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [get_futex_key+66/288] get_futex_key+0x42/0x120
 [recalc_task_prio+139/384] recalc_task_prio+0x8b/0x180
 [process_timeout+0/16] process_timeout+0x0/0x10
 [futex_wait+290/400] futex_wait+0x122/0x190
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [recalc_task_prio+139/384] recalc_task_prio+0x8b/0x180
 [do_futex+53/128] do_futex+0x35/0x80
 [copy_from_user+52/128] copy_from_user+0x34/0x80
 [sys_futex+224/240] sys_futex+0xe0/0xf0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
bash          S C01140BB     0  4654   4648  5469    4655       (NOTLB)
c2165f28 00200086 d25ce0c0 c01140bb 00000001 0000155d d37e40d6 000f4236 
       000f4240 d393b600 000f4236 d25ce0c0 d25ce21c fffffe00 00000006 d25ce164 
       d25ce0c0 c011b7ec 00030002 00000000 c0b58530 d25ce164 00000000 00000001 
Call Trace:
 [do_page_fault+379/1434] do_page_fault+0x17b/0x59a
 [do_wait+380/1040] do_wait+0x17c/0x410
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [sys_wait4+49/64] sys_wait4+0x31/0x40
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
bash          S C01140BB     0  4655   4648  5895    4656  4654 (NOTLB)
d3b6bf28 00200086 d53e3060 c01140bb 00000001 00001707 00000001 080ecf88 
       00000000 1b74b700 000f4348 d53e3060 d53e31bc fffffe00 00000006 d53e3104 
       d53e3060 c011b7ec 00030002 00000000 c0b58040 d53e3104 00000000 00000001 
Call Trace:
 [do_page_fault+379/1434] do_page_fault+0x17b/0x59a
 [do_wait+380/1040] do_wait+0x17c/0x410
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [sys_wait4+49/64] sys_wait4+0x31/0x40
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
bash          S C01140BB     0  4656   4648  5476    4657  4655 (NOTLB)
d3b2cf28 00200086 d3b2da60 c01140bb 00000001 00001564 fa9eed80 000f4256 
       00000000 fa9eed80 000f4256 d3b2da60 d3b2dbbc fffffe00 00000006 d3b2db04 
       d3b2da60 c011b7ec 00030002 00000000 d3b03590 d3b2db04 00000000 00000001 
Call Trace:
 [do_page_fault+379/1434] do_page_fault+0x17b/0x59a
 [do_wait+380/1040] do_wait+0x17c/0x410
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [sys_wait4+49/64] sys_wait4+0x31/0x40
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
bash          S C01140BB     0  4657   4648  6010    4658  4656 (NOTLB)
c5ff2f28 00200086 c0913020 c01140bb 00000001 0000177a 00000001 080ecf88 
       00000000 57843c00 000f45de c0913020 c091317c fffffe00 00000006 c09130c4 
       c0913020 c011b7ec 00030002 00000000 c61cc5d0 c09130c4 00000000 00000001 
Call Trace:
 [do_page_fault+379/1434] do_page_fault+0x17b/0x59a
 [do_wait+380/1040] do_wait+0x17c/0x410
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [sys_wait4+49/64] sys_wait4+0x31/0x40
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
bash          S 00000010     0  4658   4648          4659  4657 (NOTLB)
d2c34e78 00200082 c0133b4d 00000010 00000000 00000000 5704ecab 000f45e9 
       00000000 570fa740 000f45e9 d3b2d570 d3b2d6cc d2d23000 7fffffff d2c34f10 
       d2c34000 c0296fb1 d6fbe508 00000001 d3b23000 00000001 d2c34eb3 c01f29ed 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [pty_write+93/112] pty_write+0x5d/0x70
 [read_chan+1463/1744] read_chan+0x5b7/0x6d0
 [opost+144/400] opost+0x90/0x190
 [write_chan+347/528] write_chan+0x15b/0x210
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [tty_write+479/576] tty_write+0x1df/0x240
 [tty_read+215/240] tty_read+0xd7/0xf0
 [write_chan+0/528] write_chan+0x0/0x210
 [vfs_read+205/288] vfs_read+0xcd/0x120
 [sys_read+71/128] sys_read+0x47/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
bash          S 00000010     0  4659   4648                4658 (NOTLB)
d3295e78 00200086 c0133b4d 00000010 00000000 00000000 00000000 00000001 
       00000000 5683c700 000f4230 d3b2d080 d3b2d1dc d3229000 7fffffff d3295f10 
       d3295000 c0296fb1 d339db48 d7c42158 d3295ebc c02e6280 d3b3936c d7c42158 
Call Trace:
 [__alloc_pages+445/816] __alloc_pages+0x1bd/0x330
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [do_no_page+334/496] do_no_page+0x14e/0x1f0
 [pty_write+93/112] pty_write+0x5d/0x70
 [read_chan+1463/1744] read_chan+0x5b7/0x6d0
 [handle_mm_fault+223/336] handle_mm_fault+0xdf/0x150
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [tty_write+479/576] tty_write+0x1df/0x240
 [tty_read+215/240] tty_read+0xd7/0xf0
 [recalc_task_prio+139/384] recalc_task_prio+0x8b/0x180
 [vfs_read+205/288] vfs_read+0xcd/0x120
 [sys_read+71/128] sys_read+0x47/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
gconfd-2      S 00000010     0  4674      1                4631 (NOTLB)
d3b04f24 00200082 d3b03a80 00000010 c02e662c 00000000 000000d0 000f45e6 
       00000000 db366280 000f45ed d3b03a80 d3b03bdc 003e2eeb d3b04f38 00007531 
       d3b04000 c0296f60 d4ddac08 c0293792 c0331c60 d01394ec c832de4c 003e2eeb 
Call Trace:
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [unix_poll+18/144] unix_poll+0x12/0x90
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_poll+148/192] do_poll+0x94/0xc0
 [sys_poll+303/512] sys_poll+0x12f/0x200
 [copy_to_user+50/80] copy_to_user+0x32/0x50
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
ssh           S C032432C     0  5469   4654                     (NOTLB)
d5d6deb8 00200086 00000040 c032432c 00000001 00000003 8b08d180 000f45e8 
       00000000 8b08d180 000f45e8 c0b58530 c0b5868c 003e4af6 d5d6decc 00000005 
       00000005 c0296f60 c66a4000 c23824c0 c01ee17d d5582f70 d077708c 003e4af6 
Call Trace:
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [tty_poll+141/176] tty_poll+0x8d/0xb0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+365/672] do_select+0x16d/0x2a0
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_select+686/1184] sys_select+0x2ae/0x4a0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
btdownloadgui S 00000010     0  5476   4656          5477       (NOTLB)
d21a7f24 00200086 d3b03590 00000010 c02e662c 00000000 bde38f40 000f45ee 
       00000000 bde38f40 000f45ee d3b03590 d3b036ec 00000000 7fffffff 7fffffff 
       d21a7000 c0296fb1 d21a7fa0 c0153bc2 00000145 d6f4f270 d3097380 00000001 
Call Trace:
 [schedule_timeout+177/192] schedule_timeout+0xb1/0xc0
 [pipe_poll+50/144] pipe_poll+0x32/0x90
 [do_pollfd+82/144] do_pollfd+0x52/0x90
 [do_poll+148/192] do_poll+0x94/0xc0
 [sys_poll+303/512] sys_poll+0x12f/0x200
 [sys_ioctl+157/544] sys_ioctl+0x9d/0x220
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
btdownloadgui S 00000000     0  5477   4656                5476 (NOTLB)
ceeb7f24 00200086 c02e662c 00000000 000000d0 00000000 d2555300 000f45ee 
       000186a0 d2555300 000f45ee c61ccac0 c61ccc1c 003dca85 ceeb7f38 00000099 
       ceeb7000 c0296f60 c0330200 d010c1b8 d4aa2a60 c03e8210 c03e8210 003dca85 
Call Trace:
 [schedule_timeout+96/192] schedule_timeout+0x60/0xc0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_poll+148/192] do_poll+0x94/0xc0
 [sys_poll+303/512] sys_poll+0x12f/0x200
 [copy_to_user+50/80] copy_to_user+0x32/0x50
 [__pollwait+0/192] __pollwait+0x0/0xc0
 [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
tvtime        D C02E482C     0  5895   4655                     (NOTLB)
d1b31d80 00200082 00000000 c02e482c d1b31d84 c01296bb 7ac8f240 000f45d5 
       0001b207 7ac8f240 000f45d5 c0b58040 c0b5819c d68c1b6c d1b31d90 c0b58040 
       0000000b c02972f5 00200082 d68c1b70 cee95ed4 d68c1b70 c0b58040 00000001 
Call Trace:
 [autoremove_wake_function+27/80] autoremove_wake_function+0x1b/0x50
 [rwsem_down_read_failed+117/352] rwsem_down_read_failed+0x75/0x160
 [.text.lock.exit+107/261] .text.lock.exit+0x6b/0x105
 [printk+23/32] printk+0x17/0x20
 [die+317/320] die+0x13d/0x140
 [do_page_fault+0/1434] do_page_fault+0x0/0x59a
 [do_page_fault+0/1434] do_page_fault+0x0/0x59a
 [do_page_fault+682/1434] do_page_fault+0x2aa/0x59a
 [mark_page_accessed+40/48] mark_page_accessed+0x28/0x30
 [filemap_nopage+364/688] filemap_nopage+0x16c/0x2b0
 [do_no_page+334/496] do_no_page+0x14e/0x1f0
 [zap_pte_range+314/560] zap_pte_range+0x13a/0x230
 [do_page_fault+0/1434] do_page_fault+0x0/0x59a
 [error_code+45/56] error_code+0x2d/0x38
 [dma_free_coherent+41/96] dma_free_coherent+0x29/0x60
 [pg0+407638071/1069536256] btcx_riscmem_free+0x37/0x80 [btcx_risc]
 [pg0+407770590/1069536256] videobuf_dma_pci_unmap+0x2e/0x80 [video_buf]
 [pg0+407989509/1069536256] bttv_dma_free+0x55/0x80 [bttv]
 [pg0+407775739/1069536256] videobuf_vm_close+0x8b/0xc0 [video_buf]
 [remove_vm_struct+90/96] remove_vm_struct+0x5a/0x60
 [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
 [do_munmap+246/320] do_munmap+0xf6/0x140
 [sys_munmap+64/112] sys_munmap+0x40/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
ps            D C02E8740     0  6010   4657                     (NOTLB)
cee95ec4 00200086 cdd81878 c02e8740 fffffff4 cdd818e0 5d6adac0 000f45de 
       00000000 5d6adac0 000f45de c61cc5d0 c61cc72c d68c1b6c cee95ed4 c61cc5d0 
       cdd82000 c02972f5 00000000 d68c1b70 d68c1b70 d1b31d90 c61cc5d0 00000001 
Call Trace:
 [rwsem_down_read_failed+117/352] rwsem_down_read_failed+0x75/0x160
 [.text.lock.ptrace+7/79] .text.lock.ptrace+0x7/0x4f
 [proc_pid_cmdline+96/256] proc_pid_cmdline+0x60/0x100
 [proc_info_read+81/144] proc_info_read+0x51/0x90
 [vfs_read+205/288] vfs_read+0xcd/0x120
 [sys_read+71/128] sys_read+0x47/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71

-- 
Meelis Roos
