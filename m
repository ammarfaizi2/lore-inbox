Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbSBGHdS>; Thu, 7 Feb 2002 02:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285498AbSBGHdF>; Thu, 7 Feb 2002 02:33:05 -0500
Received: from racine.noos.net ([212.198.2.71]:27763 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S285273AbSBGHaq>;
	Thu, 7 Feb 2002 02:30:46 -0500
Message-ID: <001d01c1afa8$620d7460$0201a8c0@cybercable.fr>
From: "Benoit Garnier" <bunch@wanadoo.fr>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] - 2.5.4-pre1 - I/O error on CD-ROM
Date: Thu, 7 Feb 2002 08:23:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since I first tried the 2.5.x serie (with 2.5.3), I got errors when
reading from my CD-ROM :

Feb  7 00:20:44 fw kernel: end_request: I/O error, dev 16:40, sector 464
Feb  7 00:20:45 fw kernel: hdd: cdrom_read_intr: data underrun (4294967256
blocks)
Feb  7 00:20:45 fw kernel: end_request: I/O error, dev 16:40, sector 7948
Feb  7 00:20:45 fw kernel: hdd: cdrom_read_intr: data underrun (4294967160
blocks)
Feb  7 00:20:45 fw kernel: end_request: I/O error, dev 16:40, sector 8052
Feb  7 00:20:45 fw kernel: hdd: cdrom_read_intr: data underrun (4294967224
blocks)
Feb  7 00:20:45 fw kernel: end_request: I/O error, dev 16:40, sector 8116
Feb  7 00:20:45 fw kernel: hdd: cdrom_read_intr: data underrun (4294967288
blocks)
Feb  7 00:20:45 fw kernel: end_request: I/O error, dev 16:40, sector 8180
Feb  7 00:20:45 fw kernel: hdd: cdrom_read_intr: data underrun (4294967256
blocks)
Feb  7 00:20:45 fw kernel: end_request: I/O error, dev 16:40, sector 14916
Feb  7 00:20:45 fw kernel: hdd: cdrom_read_intr: data underrun (4294967160
blocks)
Feb  7 00:20:45 fw kernel: end_request: I/O error, dev 16:40, sector 15020

*** I didn't have these errors with 2.4.17 ***
My CD-ROM is a generic one (I don't have physical access to the
box now, but if requested I will tell you more).
When doing "cat /mnt/cdrom/* >/dev/null" I can see I/O errors
reported by cat but only on the 2.5.X serie.
The problem occurs on 2.5.3 and 2.5.4-pre1 (without any patch
applied). I didn't tried with versions between 2.5.0 and 2.5.3.

I can see this from the boot log (I compiled with the VIA VT82Cxxxx driver)
:

Feb  7 02:43:29 fw kernel: Uniform Multi-Platform E-IDE driver Revision:
6.32
Feb  7 02:43:29 fw kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Feb  7 02:43:29 fw kernel: VP_IDE: IDE controller on PCI slot 00:07.1
Feb  7 02:43:29 fw kernel: VP_IDE: chipset revision 6
Feb  7 02:43:29 fw kernel: VP_IDE: not 100%% native mode: will probe irqs
later
Feb  7 02:43:29 fw kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Feb  7 02:43:29 fw kernel: VP_IDE: VIA vt82c586a (rev 25) IDE UDMA33
controller on pci00:07.1
Feb  7 02:43:29 fw kernel:     ide0: BM-DMA at 0x6000-0x6007, BIOS settings:
hda:pio, hdb:pio
Feb  7 02:43:29 fw kernel:     ide1: BM-DMA at 0x6008-0x600f, BIOS settings:
hdc:pio, hdd:pio
Feb  7 02:43:29 fw kernel: hda: JTS Corporation CHAMPION MODEL C2000-2A, ATA
DISK drive
Feb  7 02:43:29 fw kernel: hdd: ATAPI 50X CDROM, ATAPI CD/DVD-ROM drive
Feb  7 02:43:29 fw kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  7 02:43:29 fw kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb  7 02:43:29 fw kernel: blk: queue c02e06a4, I/O limit 4095Mb (mask
0xffffffff)
Feb  7 02:43:29 fw kernel: hda: 3913056 sectors (2003 MB) w/256KiB Cache,
CHS=970/64/63
Feb  7 02:43:29 fw kernel: hdd: ATAPI 50X CD-ROM drive, 128kB Cache
Feb  7 02:43:29 fw kernel: Uniform CD-ROM driver Revision: 3.12

[root@fw /root]# hdparm /dev/hdd
/dev/hdd:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 HDIO_GET_NOWERR failed: Invalid argument
 readonly     =  1 (on)
 readahead    =  8 (on)
 HDIO_GETGEO_BIG failed: Invalid argument

What is funny is that if I switch DMA on, the errors are not reported
anymore on dmesg, but 'cat' continues to see IO errors (and eventually
the IO are locked).

Should I try the IDE patch?

Please CC me, I'm just read the list on archives...

----
Benoît GARNIER


