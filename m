Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbTAESny>; Sun, 5 Jan 2003 13:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbTAESny>; Sun, 5 Jan 2003 13:43:54 -0500
Received: from ulima.unil.ch ([130.223.144.143]:31673 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S264954AbTAESnw>;
	Sun, 5 Jan 2003 13:43:52 -0500
Date: Sun, 5 Jan 2003 19:52:27 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 problem with IDE ICH4 and aic7xxx
Message-ID: <20030105185227.GA9906@ulima.unil.ch>
References: <20030105165441.GA8215@ulima.unil.ch> <486950000.1041788147@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <486950000.1041788147@aslan.scsiguy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 10:35:47AM -0700, Justin T. Gibbs wrote:

> Does the problem persist if you disable domain
> validation via SCSI-Select on your 29160?

Well, I put in http://ulima.unil.ch/greg/linux/2.5.54/dmesg-2.5.54-2
the new result: it's really worse:

aic7xxx: PCI Device 3:3:0 failed memory mapped test.  Using PIO.
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.25
        <Adaptec 29160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
(scsi1:A:1:0): refuses WIDE negotiation.  Using 8bit transfers
(scsi1:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
(scsi1:A:2): 10.000MB/s transfers (10.000MHz, offset 8)
(scsi1:A:3): 10.000MB/s transfers (10.000MHz, offset 8)
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

scsi1:A:10:0: DV failed to configure device.  Please file a bug report against this
 driver.
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
register interface 'mouse' with class 'input'

I still have the :

aic7xxx: PCI Device 3:3:0 failed memory mapped test.  Using PIO.

But now I have the:

scsi1:A:10:0: DV failed to configure device.  Please file a bug report against this driver.

But I don't know what that mean...

cat /proc/scsi/scsi gives me:

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDRS-39130D      Rev: DC1B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: SEAGATE  Model: ST336706LW       Rev: 0108
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: TOSHIBA  Model: DVD-ROM SD-M1201 Rev: 1R04
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-R820T  Rev: 1.08
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-R820T  Rev: 1.08
  Type:   CD-ROM                           ANSI SCSI revision: 02

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
