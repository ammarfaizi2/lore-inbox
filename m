Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSE3N0O>; Thu, 30 May 2002 09:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316635AbSE3N0N>; Thu, 30 May 2002 09:26:13 -0400
Received: from jalon.able.es ([212.97.163.2]:41627 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316623AbSE3N0L>;
	Thu, 30 May 2002 09:26:11 -0400
Date: Thu, 30 May 2002 15:25:01 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: aic-6.2.8 with U160 drives
Message-ID: <20020530132501.GA18235@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have noticed a problem with the recent update in 2.4.19-pre9.
I have an Adaptec 29160 card, and a couple scsi4 Fujitsu drives,
that with previous -pre version worked at 160, AFAIR.
With the recent update, they slow down to 40Mb/s. I will recheck
bios settings, but...

Info:

lspvi -v:
03:02.0 SCSI storage controller: Adaptec 7892A (rev 02)
        Subsystem: Adaptec: Unknown device e2a0
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 18
        BIST result: 00
        I/O ports at 9000 [disabled] [size=256]
        Memory at df031000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

dmesg:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: FUJITSU   Model: MAJ3364MP         Rev: 0115
  Type:   Direct-Access                      ANSI SCSI revision: 04
  Vendor: FUJITSU   Model: MAJ3364MP         Rev: 0115
  Type:   Direct-Access                      ANSI SCSI revision: 04
  Vendor: TOSHIBA   Model: CD-ROM XM-6201TA  Rev: 1030
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PHILIPS   Model: CDD3600 CD-R/RW   Rev: 2.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IOMEGA    Model: ZIP 100           Rev: E.08
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi removable disk sdc at scsi0, channel 0, id 4, lun 0
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 127, 16bit)  <======= ?????
SCSI device sda: 71390320 512-byte hdwr sectors (36552 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 >
(scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset 127, 16bit)  <======= ?????
SCSI device sdb: 71390320 512-byte hdwr sectors (36552 MB)
 sdb: sdb1
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 
0x00 0x00 0x00 0x00 0x00 0xff 0xfe 0x01 0x00 0x00 0x00 0x00 
sdc : block size assumed to be 512 bytes, disk size 1GB.  
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 3, lun 0
(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 16)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
sr1: scsi3-mmc drive: 2x/6x writer cd/rw xa/form2 cdda tray

/proc/scsi/aic7xxx/0:

Adaptec AIC7xxx driver version: 6.2.8
aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

Serial EEPROM:
0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 
0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 
0x08f6 0x7c59 0x2807 0x0010 0x0300 0xffff 0xffff 0xffff 
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x0250 0xe64d 

Channel A Target 0 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
        Curr: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
        Channel A Target 0 Lun 0 Settings
                Commands Queued 139953
                Commands Active 0
                Command Openings 128
                Max Tagged Openings 128
                Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
        Curr: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
        Channel A Target 1 Lun 0 Settings
                Commands Queued 25
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 2 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 10.000MB/s transfers (10.000MHz, offset 16)
        Curr: 10.000MB/s transfers (10.000MHz, offset 16)
        Channel A Target 2 Lun 0 Settings
                Commands Queued 14
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Channel A Target 3 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 10.000MB/s transfers (10.000MHz, offset 15)
        Curr: 10.000MB/s transfers (10.000MHz, offset 15)
        Channel A Target 3 Lun 0 Settings
                Commands Queued 14
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Channel A Target 4 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 3.300MB/s transfers
        Curr: 3.300MB/s transfers
        Channel A Target 4 Lun 0 Settings
                Commands Queued 6
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0


Any clues ?

TIA

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre9-jam1 #1 SMP mié may 29 02:20:48 CEST 2002 i686
