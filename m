Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbRF3KUL>; Sat, 30 Jun 2001 06:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265726AbRF3KUC>; Sat, 30 Jun 2001 06:20:02 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:41296 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S265721AbRF3KTy> convert rfc822-to-8bit; Sat, 30 Jun 2001 06:19:54 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: onboard promise + dvd/cdrom no ultra dma
Date: Sat, 30 Jun 2001 12:19:25 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01063012192501.02426@einstein.p-netz>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I attached a Toshiba DVD-ROM at the ASUS A7V133 Promise controller.
The highest transfer mode I can use is Multiword DMA 2, though I activated 
the DMA-Option in the IDE-kernel configuration.

>hdparm -i /dev/hde

 /dev/hde:
 Model=TOSHIBA DVD-ROM SD-M1502, FwRev=1008, SerialNo=2100807146
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=128kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 udma0 udma1 udma2
 AdvancedPM=no
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 3 : ATA-2 ATA-3 ATA-4 ATA-5

If I try 

>hdparm -d 1 /dev/hde

 /dev/hde:
 setting using_dma to 1 (on)
 using_dma    =  1 (on)

to active the UDMA-Modes the drive is not accessible. Mount and file access 
fail, but 

> hdparm -i /dev/hde

 /dev/hde:
 Model=TOSHIBA DVD-ROM SD-M1502, FwRev=1008, SerialNo=2100807146
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=128kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 udma0 udma1 udma2
 AdvancedPM=no
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 3 : ATA-2 ATA-3 ATA-4 ATA-5

shows no difference.
after I tried to access to drive dmesg shows:

ISO 9660 Extensions: Microsoft Joliet Level 3
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: tray open
end_request: I/O error, dev 21:00 (hde), sector 112
ISOFS: unable to read i-node block
ISOFS: changing to secondary root
hde: tray open
end_request: I/O error, dev 21:00 (hde), sector 336
ISOFS: unable to read i-node block
VFS: Disk change detected on device ide2(33,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: tray open
end_request: I/O error, dev 21:00 (hde), sector 120

But I did not opened the tray.

After setting back with hdparm -d 0 the drive is functional again.

If I use the VIA-Controller with the same drive I am able to activate udma2 
successfully.

Any ideas?

Thanks

my configuration:

hda=Maxtor 5T020H2 (VIA)
hdc=Maxtor 52049H3  (VIA)
hde=TOSHIBA DVD-ROM SD-M1502 (Promise PDC20265)
hdg=SONY CD-RW CRX140E with SCSI-Emulation

Kernel 2.4.5-ac21. But similar with older Kernels.
Mandrake 8.0

>lsmod

Module                  Size  Used by
NVdriver              658480  15
parport_pc             24144   1  (autoclean)
lp                      6256   0  (autoclean)
parport                27008   1  (autoclean) [parport_pc lp]
es1370                 26432   1
soundcore               4176   4  [es1370]
3c59x                  25440   1  (autoclean)
usbmouse                2016   0  (unused)
mousedev                4096   1
input                   3584   0  [usbmouse mousedev]
usb-uhci               21360   0  (unused)
usbcore                49152   1  [usbmouse usb-uhci]
ide-scsi                7952   0
scsi_mod               54720   1  [ide-scsi]
ntfs                   49072   1  (autoclean)
nls_iso8859-1           2880   3  (autoclean)
nls_cp850               3616   2  (autoclean)

>lspci

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 
30)
00:11.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown 
device 0d30 (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev a1)
