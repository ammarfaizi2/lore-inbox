Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTAEQqI>; Sun, 5 Jan 2003 11:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbTAEQqI>; Sun, 5 Jan 2003 11:46:08 -0500
Received: from ulima.unil.ch ([130.223.144.143]:14521 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S264938AbTAEQqG>;
	Sun, 5 Jan 2003 11:46:06 -0500
Date: Sun, 5 Jan 2003 17:54:41 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.54 problem with IDE ICH4 and aic7xxx
Message-ID: <20030105165441.GA8215@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have put whole dmesg, .config, lspci, ver_linux, /proc/interrupts,
/proc/ide/piix, /proc/partitions, /proc/scsi/aic7xxx/0,
/proc/scsi/aic7xxx/1, /proc/scsi/scsi under

http://ulima.unil.ch/greg/linux/2.5.54/

One could also find patch-2.5.45-mouse that I used such that my mouse
work (wireless one, reverse patch), and other patch I have applied are
the ones from linux-dvb :

cvs -d :pserver:anonymous@linuxtv.org:/cvs/linuxtv co dvb-kernel

But I get the same result without those patches ;-)

I got an MSI Max2-BLR which has an onboard IDE Raid that isn't acticated
in the BIOS (if I turn it on, it doesn't change anything at all...

Under 2.4.20 it boots perfectly...
What I found really strange is the time my IDE take to boot. More than
five minutes for thoses lines :

Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L120AVVA07-0, ATA DISK drive
hda: bad special flag: 0x03
hda: tagged command queueing enabled, command queue depth 8
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY DVD RW DRU-500A, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
hdc: ATAPI 16X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
hdd: 244766kB, 489532 blocks, 512 sector size
hdd: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
hdd: The disk reports a capacity of 250640384 bytes, but the drive only handles 250
609664
hdd: The disk reports a capacity of 250640384 bytes, but the drive only handles 250
609664
 /dev/ide/host0/bus1/target1/lun0: unknown partition table
 /dev/ide/host0/bus1/target1/lun0: unknown partition table

Which is imediatly followed by:

aic7xxx: PCI Device 3:3:0 failed memory mapped test.  Using PIO.
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.25
        <Adaptec 29160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
(scsi1:A:1:0): refuses WIDE negotiation.  Using 8bit transfers
(scsi0:A:15): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM       Model: DDRS-39130D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: SEAGATE   Model: ST336706LW        Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:15:0: Tagged Queuing enabled.  Depth 253
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.25
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs

(scsi1:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
(scsi1:A:2): 10.000MB/s transfers (10.000MHz, offset 8)
(scsi1:A:3): 10.000MB/s transfers (10.000MHz, offset 8)
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R04
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: drive cache: write through
SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: drive cache: write back
SCSI device sdb: 71687370 512-byte hdwr sectors (36704 MB)
 /dev/scsi/host0/bus0/target15/lun0: p1 p2
Attached scsi disk sdb at scsi0, channel 0, id 15, lun 0
sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 1, lun 0
sr1: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 2, lun 0
sr2: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr2 at scsi1, channel 0, id 3, lun 0
device class 'input': registering

Should I do something different?

Thank you very much and have a great day ;-)

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
