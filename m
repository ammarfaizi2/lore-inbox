Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264649AbSKRU3F>; Mon, 18 Nov 2002 15:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSKRU3F>; Mon, 18 Nov 2002 15:29:05 -0500
Received: from ulima.unil.ch ([130.223.144.143]:49305 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S264649AbSKRU3D>;
	Mon, 18 Nov 2002 15:29:03 -0500
Date: Mon, 18 Nov 2002 21:36:05 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.48 and SCSI ?
Message-ID: <20021118203605.GC8357@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have applied the patch sent today, but the kernel don't find my root
(aic7xxx), what I got is:

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 29160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
  Vendor: IBM       Model: DDRS-39130D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:A:15): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
(scsi0:A:15): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST336706LW        Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs

(scsi1:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R04
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi1:A:2): 10.000MB/s transfers (10.000MHz, offset 8)
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi1:A:3): 10.000MB/s transfers (10.000MHz, offset 8)
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi1:A:4): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: PIONEER   Model: CD-ROM DR-U06S    Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
SCSI device sda: drive cache: write through
SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
scsi0:A:15:0: Tagged Queuing enabled.  Depth 253
SCSI device sdb: drive cache: write back
SCSI device sdb: 71687370 512-byte hdwr sectors (36704 MB)
 /dev/scsi/host0/bus0/target15/lun0: p1 p2
Attached scsi disk sdb at scsi0, channel 0, id 15, lun 0
sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
sr2: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
sr3: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray

While the diff against 2.4.45:

1,2c1,2
< SCSI device : drive cache: write through
< SCSI device : 17850000 512-byte hdwr sectors (9139 MB)
---
> SCSI device sda: drive cache: write through
> SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
5,6c5,6
< SCSI device : drive cache: write back
< SCSI device : 71687370 512-byte hdwr sectors (36704 MB)
---
> SCSI device sdb: drive cache: write back
> SCSI device sdb: 71687370 512-byte hdwr sectors (36704 MB)
11d10
< Attached scsi CD-ROM sr0 at scsi1, channel 0, id 1, lun 0
13d11
< Attached scsi CD-ROM sr1 at scsi1, channel 0, id 2, lun 0
15d12
< Attached scsi CD-ROM sr2 at scsi1, channel 0, id 3, lun 0
17d13
< Attached scsi CD-ROM sr3 at scsi1, channel 0, id 4, lun 0

Should I try without the patch?

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
