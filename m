Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131448AbRCKSBj>; Sun, 11 Mar 2001 13:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131449AbRCKSB3>; Sun, 11 Mar 2001 13:01:29 -0500
Received: from alpha.gxsnmp.org ([130.205.120.5]:50702 "EHLO alpha.gxsnmp.org")
	by vger.kernel.org with ESMTP id <S131448AbRCKSBU>;
	Sun, 11 Mar 2001 13:01:20 -0500
Date: Sun, 11 Mar 2001 12:56:24 -0500 (EST)
From: Gregory McLean <gregm@alpha.gxsnmp.org>
To: <linux-kernel@vger.kernel.org>
Subject: Bug in 2.4.2
Message-ID: <Pine.LNX.4.30.0103111243170.13398-100000@alpha.gxsnmp.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not sure exactly what happened to the machine as I was at work at the
time when it died I had just sshed in to read my daily spam box ;)

Here is the decoded captured oops (klogd provided):

Mar 11 09:36:33 tweetie kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000004
Mar 11 09:36:33 tweetie kernel:  printing eip:
Mar 11 09:36:33 tweetie kernel: c0132551
Mar 11 09:36:33 tweetie kernel: *pde = 00000000
Mar 11 09:36:33 tweetie kernel: Oops: 0002
Mar 11 09:36:33 tweetie kernel: CPU:    0
Mar 11 09:36:33 tweetie kernel: EIP:    0010:[__remove_inode_queue+17/32]
Mar 11 09:36:33 tweetie kernel: EFLAGS: 00010286
Mar 11 09:36:33 tweetie kernel: eax: 00000000   ebx: c1656c20   ecx:
00000000   edx: 00000000
Mar 11 09:36:33 tweetie kernel: esi: c1656c20   edi: c1656c20   ebp:
00000000   esp: c147bf64
Mar 11 09:36:33 tweetie kernel: ds: 0018   es: 0018   ss: 0018
Mar 11 09:36:33 tweetie kernel: Process bdflush (pid: 5,
stackpage=c147b000)
Mar 11 09:36:33 tweetie kernel: Stack: c0134a39 c1656c20 00000003 00000207
c10c6180 0000019b c012b5d3 00000000
Mar 11 09:36:33 tweetie kernel:        c130c074 00000000 00000007 c012af77
c130c074 00000000 00000000 00000004
Mar 11 09:36:33 tweetie kernel:        00000000 000000f1 00006492 00000000
c147a000 00000000 00000007 00000000
Mar 11 09:36:33 tweetie kernel: Call Trace: [try_to_free_buffers+105/368]
[free_shortage+35/208] [page_launder+871/2208] [bdflush+155/224]
[empty_bad_page+0/4096] [empty_bad_page+0/4096] [kernel_thread+38/48]
Mar 11 09:36:33 tweetie kernel:        [bdflush+0/224]
Mar 11 09:36:33 tweetie kernel:
Mar 11 09:36:33 tweetie kernel: Code: 89 50 04 89 02 c3 89 f6 8d bc 27 00
00 00 00 8b 54 24 04 31
Mar 11 09:36:34 tweetie kernel: kernel BUG at exit.c:458!
Mar 11 09:36:34 tweetie kernel: invalid operand: 0000
Mar 11 09:36:34 tweetie kernel: CPU:    0
Mar 11 09:36:34 tweetie kernel: EIP:    0010:[do_exit+518/528]
Mar 11 09:36:34 tweetie kernel: EFLAGS: 00010286
Mar 11 09:36:34 tweetie kernel: eax: 0000001a   ebx: 00000000   ecx:
ffffffff   edx: 00000000
Mar 11 09:36:34 tweetie kernel: esi: c147a000   edi: 0000000b   ebp:
c0132551   esp: c147be50
Mar 11 09:36:34 tweetie kernel: ds: 0018   es: 0018   ss: 0018
Mar 11 09:36:34 tweetie kernel: Process bdflush (pid: 5,
stackpage=c147b000)
Mar 11 09:36:34 tweetie kernel: Stack: c025c385 c025c49c 000001ca c0132551
c010942a c02544c1 c025460d c147bf30
Mar 11 09:36:34 tweetie kernel:        00000002 00000004 c0112c47 0000000b
c147bf30 00000002 00000001 c147a000


>From here the machine was unresponsive, powercycle fixed it up.

modules in use:
lsmod
Module                  Size  Used by
tuner                   4192   1  (autoclean)
tvaudio                 8208   0  (autoclean) (unused)
bttv                   58512   0  (autoclean)
i2c-algo-bit            7232   1  (autoclean) [bttv]
i2c-core               13232   0  (autoclean) [tuner tvaudio bttv
i2c-algo-bit]
tun                     3152   2  (autoclean)
3c509                   6992   1  (autoclean)
reiserfs              156464   5  (autoclean)
opl3                   11728   0  (unused)
sb                      7456   0
sb_lib                 34128   0  [sb]
uart401                 6384   0  [sb_lib]
sound                  57728   0  [opl3 sb_lib uart401]
lvm-mod                39392   5  (autoclean)
mousedev                4096   1
hid                    11664   0  (unused)
input                   3392   0  [mousedev hid]
usb-uhci               21856   0  (unused)

Hardware installed:
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:10.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
00:10.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
00:11.0 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 04)
00:12.0 SCSI storage controller: Adaptec AIC-7860 (rev 01)
00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 01)
00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 01)
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 11)

And two ISA cards:

Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative ViBRA16X PnP detected
sb: ISAPnP reports 'Creative ViBRA16X PnP' at i/o 0x220, irq 7, dma 1, 3
SB 4.16 detected OK (220)

eth0: 3c509 at 0x330, 10baseT port, address  00 20 af 6d e6 2f, IRQ 3.
3c509.c:1.16 (2.2) 2/3/98 becker@cesdis.gsfc.nasa.gov.
eth0: Setting Rx mode to 1 addresses.

Installed drives (since it appears bdflush triggered this)
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
HPT366: IDE controller on PCI bus 00 dev 98
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:pio, hdf:pio
HPT366: IDE controller on PCI bus 00 dev 99
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide3: BM-DMA at 0xe400-0xe407, BIOS settings: hdg:pio, hdh:pio
hda: Maxtor 53073H6, ATA DISK drive
hdb: Maxtor 92048U8, ATA DISK drive
hdc: SAMSUNG WU33205A (3.2GB), ATA DISK drive
hdd: 10X8X32, ATAPI CD/DVD-ROM drive
hde: Maxtor 5T040H4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xefa8-0xefaf,0xefe2 on irq 9
hda: 4124736 sectors (2112 MB) w/2048KiB Cache, CHS=1024/255/63, UDMA(33)
hdb: 4124736 sectors (2112 MB) w/2048KiB Cache, CHS=4092/16/63, UDMA(33)
hdc: 6330240 sectors (3241 MB) w/109KiB Cache, CHS=6280/16/63, UDMA(33)
hde: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=79408/16/63,
UDMA(66)
Partition check:
 hda: hda1 hda2 hda3
 hdb: [PTBL] [1023/64/63] hdb1
 hdc: hdc1
 hde: hde1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7860 Ultra SCSI host adapter> found at PCI 0/18/0
(scsi0) Narrow Channel, SCSI ID=7, 3/255 SCBs
(scsi0) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7860 Ultra SCSI host adapter>
(scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: SEAGATE   Model: ST12400N ST32430  Rev: 0456
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:1:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: SEAGATE   Model: ST15150N          Rev: 0022
  Type:   Direct-Access                      ANSI SCSI revision: 02

More info provided on request.

Greg



