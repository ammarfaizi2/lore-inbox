Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132313AbRCaGZh>; Sat, 31 Mar 2001 01:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbRCaGZ2>; Sat, 31 Mar 2001 01:25:28 -0500
Received: from [206.221.198.4] ([206.221.198.4]:51719 "HELO deimos.sonique.com")
	by vger.kernel.org with SMTP id <S132313AbRCaGZW>;
	Sat, 31 Mar 2001 01:25:22 -0500
Date: Fri, 30 Mar 2001 15:27:39 -0800 (PST)
From: Nicholas Vinen <hb@sonique.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with 2.4 kernels (including latest; 2.4.3-pre8) related to
 hard drives/file systems
Message-ID: <Pine.LNX.4.21.0103301509560.31003-100000@deimos.space.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Hi,
      I am not subscribed to this list. Please email me with any
questions.

      I've been trying unsuccessfully to use 2.4 kernels for a while
now. I wanted to use DRI and it seems I need a 2.4 kernel for it to work
but I have the following problem:

description:
   when I go to pretty much any directory, but for example, /usr/src 
(/usr is mounted as /dev/hdc5) and do an "ls", the list starts but it
freezes at a certain entry and as far as I can tell never resumes. I can
press control-c and it aborts just fine and my computer keeps running
normally - I can do pretty much anything - but if I try to list the file
(the one it stopped at) or many others, the same thing happens again. I
can't think of anything remarkable about /dev/hd5 - it is an ext2
partition, on an IBM Ultra33 drive (see below), on the motherboard
controller. Perhaps it is because I have an Intel 840 chipset
motherboard? Oh, DMA is on, block transfer is on and 32 bit transfer is on
for this drive. Here is my hardware:

Intel 840 chipset (SuperMicro P3DME) with two 850MHz Pentium 3 chips
(100MHz bus, slot1), 512MB PC100RAM (2x256MB buffered ECC; ECC disabled).
Voodoo3 3500 AGP TV, Promise Ultra66, SoundBlaster Live! MP3+, Adaptec
AIC-7850 SCSI card with Plextor 8x CD burner and Pioneer 10x DVD drive,
Znyx ZX348Q (two DEC Tulip chips with a PCI bus controller).
The motherboard has onboard LAN (EtherExpressPro 100) and sound (don't
know what; it's disabled).
Hard drives are layed out as follows:

hda: LS-120 VER5 00 UHD Floppy, ATAPI FLOPPY drive
hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdc: IBM-DJNA-352500, ATA DISK drive
hde: IBM-DPTA-353750, ATA DISK drive
hdg: IBM-DPTA-353750, ATA DISK drive

hde and hdg are on the Promise Ultra66 controller and are part of a stripe
set using normal kernel RAID support. However I have this problem on
drives not associated with this stripe set.

here is how hdc is partitioned:

Disk /dev/hdc: 16 heads, 63 sectors, 49585 cylinders
Units = cylinders of 1008 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdc1             1        66     33232+  83  Linux
/dev/hdc2            67       587    262584   82  Linux swap
/dev/hdc3   *       588      4749   2097648   83  Linux
/dev/hdc4          4750     49585  22597344    5  Extended
/dev/hdc5          4750     10991   3145936+  83  Linux
/dev/hdc6         10992     49585  19451344+  83  Linux

and how they are mounted:

/dev/hdc2      swap    swap            defaults          0 0
/dev/hde5      swap    swap            defaults          0 0
/dev/hdg5      swap    swap            defaults          0 0
/dev/hdc3      /       ext2   defaults,nocheck,noatime   1 1
/dev/hdc5      /usr    ext2   defaults,nocheck,noatime   1 2
/dev/hdc6      /home   ext2   defaults,nocheck,noatime   1 3
/dev/hdc1      /boot   ext2   defaults,nocheck,noatime   1 4
/dev/md0       /raid   ext2   defaults,nocheck,noatime   1 2

here are my SCSI drives incase it helps:

scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7850 SCSI host adapter>
scsi : 1 host.
(scsi0:0:3:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
(scsi0:0:4:0) Synchronous at 10.0 Mbyte/sec, offset 8.
  Vendor: IMATION   Model: CD-RW IMW080220   Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
scsi : detected 2 SCSI generics 2 SCSI cdroms total.
sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.11
sr1: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray

   I don't think I have anything strange in my kernel config but if you
want I can send it to you - or anything else you need to fix this - even
access to my machine in this state if you want.

   I hope this helps.

       Nicholas


