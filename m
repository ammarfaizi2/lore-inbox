Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSEFVm1>; Mon, 6 May 2002 17:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315212AbSEFVmY>; Mon, 6 May 2002 17:42:24 -0400
Received: from net128-007.mclink.it ([195.110.128.7]:48125 "EHLO
	mail.mclink.it") by vger.kernel.org with ESMTP id <S315204AbSEFVmT>;
	Mon, 6 May 2002 17:42:19 -0400
Message-ID: <3CD6F8B3.8030401@arpacoop.it>
Date: Mon, 06 May 2002 23:42:11 +0200
From: Carlo Scarfoglio <scarfoglio@arpacoop.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020427
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.14 IDE+TCQ+Reiserfs kernel bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just compiled and installed 2,5,14 with Tagged command queue, TCQ on 
by default enabled and Default queue depth = 32.
I have an ASUS A7V 333 (Promise 20276) with a IBM DTLA 307030 connected 
to the Promise controller (see boot.msg below).
The disks is reiserfs formatted. I use it for backups. I mounted it with 
kernel 2.5.14 and tied to copy a 100MB file to it. It stopped at 40% 
with the above message. It cannot be unmounted. I'll try to reboot to 
see what damage it has suffered.

This is an excerpt from /var/log/messages
May  6 23:19:43 carlocasa kernel: found reiserfs format "3.6" with 
standard journal
May  6 23:19:44 carlocasa kernel: reiserfs:warning: 
CONFIG_REISERFS_CHECK is set ON
May  6 23:19:44 carlocasa kernel: reiserfs:warning: - it is slow mode 
for debugging.
May  6 23:19:44 carlocasa kernel: sh-461: journal_init: wrong 
transaction max size (8192). Changed to 1024
May  6 23:19:44 carlocasa kernel: Reiserfs journal params: device 22:01, 
size 8192, journal first block 18, max trans len 1024, max batch 900, 
max commit age 900, max trans age 30
May  6 23:19:44 carlocasa kernel: reiserfs: checking transaction log 
(ide3(34,1)) for (ide3(34,1))
May  6 23:19:44 carlocasa kernel: journal-1153: found in header: 
first_unflushed_offset 441, last_flushed_trans_id 3099
May  6 23:19:44 carlocasa kernel: journal-1206: Starting replay from 
offset 441, trans_id 3100
May  6 23:19:44 carlocasa kernel: journal-1299: Setting newest_mount_id 
to 54
May  6 23:19:44 carlocasa kernel: Using r5 hash to sort names
May  6 23:21:15 carlocasa kernel: vs: 4020: is_reusable: bitmap block 
1867776(230) can't be freed or reused
May  6 23:21:15 carlocasa kernel: 0: reiserfs_get_block
May  6 23:21:15 carlocasa kernel: reiserfs[264]: assertion !( 
buffer_locked ((REISERFS_SB(s)->s_ap_bitmap)[i]) || is_reusable (s, 
search_start, 0) == 0 ) failed at bitmap.c:421:do_reiserfs_new_blocknrs: 
vs-4140: bitmap block is locked or bad block number found
May  6 23:21:15 carlocasa kernel: kernel BUG at prints.c:335!
May  6 23:21:15 carlocasa kernel: invalid operand: 0000
May  6 23:21:15 carlocasa kernel: CPU:    0
May  6 23:21:15 carlocasa kernel: EIP:    0010:[<c01a3969>]    Not tainted
May  6 23:21:15 carlocasa kernel: EFLAGS: 00010282
May  6 23:21:15 carlocasa kernel: eax: 000000e6   ebx: c030b6a0   ecx: 
fffffeb4   edx: df9b5200
May  6 23:21:15 carlocasa kernel: esi: 00000000   edi: de5e6800   ebp: 
00000000   esp: dd477cc8
May  6 23:21:15 carlocasa kernel: ds: 0018   es: 0018   ss: 0018
May  6 23:21:15 carlocasa kernel: Process mc (pid: 264, 
threadinfo=dd476000 task=dd4742c0)
May  6 23:21:15 carlocasa kernel: Stack: c03140f4 c03ed800 c030b6a0 
dd477cec 00000012 001c8000 c01909f2 00000000
May  6 23:21:15 carlocasa kernel:        c030b6a0 00000108 000001a5 
00137fff 00000000 dafbf3b0 00000007 dd476000
May  6 23:21:15 carlocasa kernel:        00000001 dd477de0 00000039 
00000000 c0190d82 dd477e14 dd477de0 001c8000
May  6 23:21:15 carlocasa kernel: Call Trace: [<c01909f2>] [<c0190d82>] 
[<c0198ff2>] [<c01ac4f4>] [<c013b5f0>]
May  6 23:21:15 carlocasa kernel:    [<c013a344>] [<c013abb2>] 
[<c0198c60>] [<c019b8c3>] [<c0198c60>] [<c012a4ff>]
May  6 23:21:15 carlocasa kernel:    [<c0128fe0>] [<c0137bd6>] [<c0106f5b>]
May  6 23:21:15 carlocasa kernel:
May  6 23:21:15 carlocasa kernel: Code: 0f 0b 4f 01 fa 40 31 c0 68 00 d8 
3e c0 b8 03 41 31 c0 8d 96
May  6 23:21:15 carlocasa kernel:  <3>error: mc[264] exited with 
preempt_count 1


This is /var/log/boot.msg

nspecting /boot/System.map
Symbol table has incorrect version number.

Cannot find map file.
No module symbols loaded.
klogd 1.3-3, log source = ksyslog started.
<4>Linux version 2.5.14 (root@carlocasa) (gcc version 2.95.3 20010315 
(release)) #8 Mon May 6 23:11:15 CEST 2002
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
<4> BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
<4> BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
<4> BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
<4> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<5>511MB LOWMEM available.
<4>On node 0 totalpages: 131068
<4>zone(0): 4096 pages.
<4>zone(1): 126972 pages.
<4>zone(2): 0 pages.
<4>Kernel command line: BOOT_IMAGE=linux2514 ro root=1607 aic7xxx=seltime:0
<4>Found and enabled local APIC!
<6>Initializing CPU#0
<4>Detected 1532.941 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 3060.53 BogoMIPS
<4>Memory: 516072k/524272k available (1973k kernel code, 7804k reserved, 
677k data, 252k init, 0k highmem)
<4>Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
<4>Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<7>CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 256K (64 bytes/line)
<7>CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<6>Machine check exception polling timer started.
<7>CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
<7>CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
<4>CPU: AMD Athlon(TM) XP 1800+ stepping 02
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 1532.9260 MHz.
<4>..... host bus clock speed is 266.5958 MHz.
<4>cpu: 0, clocks: 2665958, slice: 1332979
<4>CPU0<T0:2665952,T1:1332960,D:13,S:1332979,C:2665958>
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<6>PCI: PCI BIOS revision 2.10 entry at 0xf1aa0, last bus=1
<6>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<4>PCI: Probing PCI hardware (bus 00)
<3>Unknown bridge resource 0: assuming transparent
<6>PCI: Using IRQ router VIA [1106/3147] at 00:11.0
<6>usb.c: registered new driver usbfs
<6>usb.c: registered new driver hub
<6>SBF: Simple Boot Flag extension found and enabled.
<6>SBF: Setting boot flags 0x80
<4>Starting kswapd
<4>BIO: pool of 256 setup, 14Kb (56 bytes/bio)
<4>biovec: init pool 0, 1 entries, 12 bytes
<4>biovec: init pool 1, 4 entries, 48 bytes
<4>biovec: init pool 2, 16 entries, 192 bytes
<4>biovec: init pool 3, 64 entries, 768 bytes
<4>biovec: init pool 4, 128 entries, 1536 bytes
<4>biovec: init pool 5, 256 entries, 3072 bytes
<6>NTFS driver 2.0.6 [Flags: R/O]. Copyright (c) 2001,2002 Anton 
Altaparmakov.
<6>parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
<6>parport0: irq 7 detected
<7>parport0: Found 1 daisy-chained devices
<7>parport0: device reported incorrect length field (61, should be 62)
<6>parport0 (addr 0): SCSI adapter, IMG VP1
<4>i2c-core.o: i2c core module
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>ttyS01 at 0x02f8 (irq = 3) is a 16550A
<6>lp0: using parport0 (polling).
<6>Real Time Clock Driver v1.11
<4>block: 256 slots per queue, batch=32
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
<6>  http://www.scyld.com/network/ne2k-pci.html
<6>PCI: Found IRQ 10 for device 00:0e.0
<6>PCI: Sharing IRQ 10 with 00:05.0
<6>PCI: Sharing IRQ 10 with 00:07.0
<4>eth0: RealTek RTL-8029 found at 0xa400, IRQ 10, 00:20:18:39:CF:17.
<6>PPP generic driver version 2.4.2
<6>PPP Deflate Compression module registered
<6>PPP BSD Compression module registered
<6>Linux agpgart interface v0.99 (c) Jeff Hartmann
<6>agpgart: Maximum main memory to use for agp memory: 439M
<6>agpgart: Detected Via Apollo Pro KT266 chipset
<6>agpgart: AGP aperture is 64M @ 0xe0000000
<6>[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe0000000 64MB
<6>[drm] Initialized mga 3.0.2 20010321 on minor 0
<6>ATA/ATAPI driver v7.0.0
<6>ATA: system bus speed 33MHz
<6>ATA: interface: Promise Technology, Inc. 20276, on PCI slot 00:06.0
<6>PCI: Found IRQ 5 for device 00:06.0
<6>ATA: chipset rev.: 1
<6>ATA: non-legacy mode: IRQ probe delayed
<4>    ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
<4>    ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
<6>ATA: unknown interface: VIA Technologies, Inc. Bus Master IDE 
(1106:0571) on PCI slot 00:11.1
<4>PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try 
using pci=biosirq.
<6>ATA: chipset rev.: 6
<6>ATA: non-legacy mode: IRQ probe delayed
<4>    ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:pio
<4>hda: QUANTUM FIREBALL_TM2550A, ATA DISK drive
<4>hdc: IBM-DHEA-38451, ATA DISK drive
<4>hde: IBM-DPTA-372050, ATA DISK drive
<4>hdg: IBM-DTLA-307030, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>ide2 at 0xd400-0xd407,0xd002 on irq 5
<4>ide3 at 0xb800-0xb807,0xb402 on irq 5
<6>hda: 5008752 sectors w/76KiB Cache, CHS=4969/16/63, DMA
<6>hdc: 16514064 sectors w/472KiB Cache, CHS=16383/16/63, UDMA(33)
<4>hde: tagged command queueing enabled, command queue depth 32
<6>hde: 40088160 sectors w/1961KiB Cache, CHS=39770/16/63, UDMA(66)
<4>hdg: tagged command queueing enabled, command queue depth 32
<6>hdg: 60036480 sectors w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
<6>Partition check:
<6> hda: [PTBL] [621/128/63] hda1 hda2 < hda5 hda6 > hda3
<6> hdc: [PTBL] [1027/255/63] hdc1 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 >
<6> hde: hde1 hde2
<6> hdg: hdg1
<6>SCSI subsystem driver Revision: 1.00
<6>PCI: Found IRQ 11 for device 00:0d.0
<6>PCI: Sharing IRQ 11 with 01:00.0
<4>ahc_pci:0:13:0: Host Adapter Bios disabled.  Using default SCSI 
device parameters
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
<4>        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
<4>        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs
<4>
<4>(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 15)
<4>  Vendor: SCSI-CD   Model: ReWritable-2x2x6  Rev: 2.00
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>  Vendor: TEAC      Model: CD-ROM CD-532S    Rev: 1.0A
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>  Vendor: SCANNER   Model:                   Rev: 2.00
<4>  Type:   Scanner                            ANSI SCSI revision: 01 CCS
<4>Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
<4>Attached scsi CD-ROM sr1 at scsi0, channel 0, id 3, lun 0
<4>sr0: scsi3-mmc drive: 2x/6x writer cd/rw xa/form2 cdda tray
<6>Uniform CD-ROM driver Revision: 3.12
<4>(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
<4>sr1: scsi3-mmc drive: 2x/6x xa/form2 cdda tray
<5>Attached scsi generic sg2 at scsi0, channel 0, id 6, lun 0,  type 6
<6>Advanced Linux Sound Architecture Driver Version 0.9.0rc1 (Mon Apr 29 
06:46:09 2002 UTC).
<7>kmod: failed to exec /sbin/modprobe -s -k snd-card-0, errno = 2
<6>PCI: Found IRQ 10 for device 00:05.0
<6>PCI: Sharing IRQ 10 with 00:07.0
<6>PCI: Sharing IRQ 10 with 00:0e.0
<6>PCI: Found IRQ 12 for device 00:0f.0
<6>ALSA device list:
<6>  #0: C-Media PCI CMI8738-MC6 (model 55) at 0xd800, irq 10
<6>  #1: Ensoniq AudioPCI ES1371 at 0xa000, irq 12
<6>uhci.c: USB Universal Host Controller Interface driver v1.1
<6>PCI: Found IRQ 3 for device 00:11.2
<6>IRQ routing conflict for 00:11.2, have irq 9, want irq 3
<6>IRQ routing conflict for 00:11.3, have irq 9, want irq 3
<6>uhci.c: USB UHCI at I/O 0x9400, IRQ 9
<6>hcd.c: new USB bus registered, assigned bus number 1
<6>hub.c: USB hub found at /
<6>hub.c: 2 ports detected
<6>PCI: Found IRQ 3 for device 00:11.3
<6>IRQ routing conflict for 00:11.2, have irq 9, want irq 3
<6>IRQ routing conflict for 00:11.3, have irq 9, want irq 3
<6>uhci.c: USB UHCI at I/O 0x9000, IRQ 9
<6>hcd.c: new USB bus registered, assigned bus number 2
<6>hub.c: USB hub found at /
<6>hub.c: 2 ports detected
<6>usb.c: registered new driver usblp
<6>printer.c: v0.12: USB Printer Device Class driver
<6>Initializing USB Mass Storage driver...
<6>usb.c: registered new driver usb-storage
<6>USB Mass Storage support registered.
<6>usb.c: registered new driver hiddev
<6>usb.c: registered new driver hid
<6>hid-core.c: v1.31:USB HID core driver
<6>mice: PS/2 mouse device common for all mice
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<6>IP: routing cache hash table of 4096 buckets, 32Kbytes
<6>TCP: Hash tables configured (established 32768 bind 32768)
<4>ip_conntrack version 2.0 (4095 buckets, 32760 max) - 292 bytes per 
conntrack
<4>ip_tables: (C) 2000-2002 Netfilter core team
<4>arp_tables: (C) 2002 David S. Miller
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>VFS: Mounted root (ext2 filesystem) readonly.
<4>Freeing unused kernel memory: 252k freed
<4>spurious 8259A interrupt: IRQ7.
<6>hub.c: new USB device 00:11.2-1, assigned address 2
<4>hid-core.c: ctrl urb status -32 received
<6>input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse ® with 
IntelliEye] on usb-00:11.2-1
<6>hub.c: new USB device 00:11.2-2, assigned address 3
<4>usb.c: USB device 3 (vend/prod 0x5e3/0x502) is not claimed by any 
active driver.
<6>hub.c: new USB device 00:11.3-1, assigned address 2
<4>hid-core.c: ctrl urb status -32 received
<4>hid-core.c: ctrl urb status -32 received
<4>hid-core.c: ctrl urb status -32 received
<4>hid-core.c: ctrl urb status -32 received
<4>hid-core.c: ctrl urb status -32 received
<4>hid-core.c: ctrl urb status -32 received
<6>input,hiddev0: USB HID v1.01 Mouse [AIPTEK APT-6000U] on usb-00:11.3-1
<4>FAT: Using codepage cp437
<4>HPFS: filesystem error: improperly stopped; remounting read-only
<4>HPFS: filesystem error: improperly stopped; remounting read-only
<4>FAT: Using codepage cp437
<4>FAT: Using codepage cp437
<6>NTFS volume version 1.2.
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

