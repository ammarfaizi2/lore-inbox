Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265023AbTGBO1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 10:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265021AbTGBO1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 10:27:53 -0400
Received: from 200-204-171-188.insite.com.br ([200.204.171.188]:58375 "HELO
	proxy.inteliweb.com.br") by vger.kernel.org with SMTP
	id S265002AbTGBO1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 10:27:44 -0400
Message-ID: <00d901c340a8$810556c0$3300a8c0@Slepetys>
From: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>
To: <linux-kernel@vger.kernel.org>
Cc: "Slepetys" <slepetys@homeworks.com.br>
Subject: Probably 2.4 kernel or AIC7xxx module trouble
Date: Wed, 2 Jul 2003 11:44:55 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi linuxers,

I am having a strange halt troubles in my linux box after I installed the
2.4.20 kernel that didn't happen when I was running the 2.2 kernel.

The system works fine for hours or days, and then it halts. The keybord
halts, the remote acess halts, but I still can ping it !

I found some messages in this newsgroup with the same caracteristics, but it
was unsolved.

The system halts easily if I do a large I/O, like reindexing a database,
giving me some messages like: (scsi0:A:1:0): Locking max tag count at 128...

I have a Red Hat 9 distribution instaled in a Intel STL2 server board, with
2 Pentium III 933 Mhz and 512 Mb RAM, 2 scsi disks (18 Mb) and 2 IDE disks
(40 Mb), running in multiple RAID 1 and RAID 0 configurations.

The dmesg gives me the following data about the SCSI:

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue c24fd618, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: FUJITSU   Model: MAJ3182MC         Rev: 0114
  Type:   Direct-Access                      ANSI SCSI revision: 04
blk: queue c24fd418, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: IBM       Model: DDYS-T18350M      Rev: SA2A
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue c24fd218, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: ESG-SHV   Model: SCA HSBP M14      Rev: 0.03
  Type:   Processor                          ANSI SCSI revision: 02
blk: queue dfc58e18, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
  Vendor: NEC       Model: CD-ROM DRIVE:466  Rev: 1.26
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue dfc58a18, I/O limit 4095Mb (mask 0xffffffff)
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
SCSI device sda: 35694904 512-byte hdwr sectors (18276 MB)
 sda: sda1 sda2 sda3
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 >
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
Journalled Block Device driver loaded
md: Autodetecting RAID arrays.

The /proc/scsi/aic7xxx/0 gives me:

Adaptec AIC7xxx driver version: 6.2.8
aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

Serial EEPROM:
0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a
0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a
0x58e4 0x5c5e 0x2807 0x0010 0xffff 0xffff 0xffff 0xffff
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x0250 0x133f

Channel A Target 0 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
        Channel A Target 0 Lun 0 Settings
                Commands Queued 488876
                Commands Active 0
                Command Openings 125
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 1 Lun 0 Settings
                Commands Queued 465642
                Commands Active 0
                Command Openings 128
                Max Tagged Openings 128
                Device Queue Frozen Count 0
Channel A Target 2 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 3 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 4 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 5 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 6 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 3.300MB/s transfers
        Curr: 3.300MB/s transfers
        Channel A Target 6 Lun 0 Settings
                Commands Queued 1
                Commands Active 0
                Command Openings 1

                Max Tagged Openings 0
                Device Queue Frozen Count 0
Channel A Target 7 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 9 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)

And /proc/scsi/aic7xxx/1 is:

daptec AIC7xxx driver version: 6.2.8
aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

Serial EEPROM:
0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a
0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a
0x58e4 0x5c5e 0x2807 0x0010 0xffff 0xffff 0xffff 0xffff
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x0250 0x133f

Channel A Target 0 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 2 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 3 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 4 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 5 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 20.000MB/s transfers (20.000MHz, offset 16)
        Curr: 20.000MB/s transfers (20.000MHz, offset 16)
        Channel A Target 5 Lun 0 Settings
                Commands Queued 193
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Channel A Target 6 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 7 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 9 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)

How I could know if this is a hardware problem or a kernel + module problem
?

Thanks
Slepetys


