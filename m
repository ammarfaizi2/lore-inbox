Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276793AbRJPWYA>; Tue, 16 Oct 2001 18:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276786AbRJPWXu>; Tue, 16 Oct 2001 18:23:50 -0400
Received: from adsl-216-102-163-254.dsl.snfc21.pacbell.net ([216.102.163.254]:8398
	"EHLO windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S276782AbRJPWXi>; Tue, 16 Oct 2001 18:23:38 -0400
Date: Tue, 16 Oct 2001 15:20:27 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: <linux-kernel@vger.kernel.org>
Subject: aic7xxx conflicting reports of bus speed
Message-ID: <Pine.LNX.4.33.0110161510050.32663-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have two SCSI host adapters in a system:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7892 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/255 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/255 SCBs

scsi0 runs Adaptec BIOS version 3.00, scsi1 uses 3.10.  When scsi1
reports, it shows itself running at 40MHz instead of the desired 80MHz:

(scsi1:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST336705LC        Rev: 5063
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi1:A:1): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST336705LC        Rev: 0105
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi1:A:2): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST336705LC        Rev: 0105
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi1:A:3): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST336705LC        Rev: 0105
  Type:   Direct-Access                      ANSI SCSI revision: 03

Later though, the bus speed is shown as 80MHz:

(scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdc: 71687370 512-byte hdwr sectors (36704 MB)
 /dev/scsi/host1/bus0/target0/lun0: p1
(scsi1:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdd: 71687370 512-byte hdwr sectors (36704 MB)
 /dev/scsi/host1/bus0/target1/lun0: p1
(scsi1:A:2): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sde: 71687370 512-byte hdwr sectors (36704 MB)
 /dev/scsi/host1/bus0/target2/lun0: p1
(scsi1:A:3): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdf: 71687370 512-byte hdwr sectors (36704 MB)
 /dev/scsi/host1/bus0/target3/lun0: p1

There is a mismatch here.  I believe the first report is false.  Further,
the reporting of the tag queue depth is conflicting.  At boot time, I see
this:

scsi1:0:0:0: Tagged Queuing enabled.  Depth 8
scsi1:0:1:0: Tagged Queuing enabled.  Depth 8
scsi1:0:2:0: Tagged Queuing enabled.  Depth 8
scsi1:0:3:0: Tagged Queuing enabled.  Depth 8

But /proc/scsi/aic7xxx/1 shows this:

Channel A Target 0 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 0 Lun 0 Settings
                Commands Queued 320416
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0

So it looks like the depth is 253.

I think the report from /proc is probably correct.  It would be nice if
the various reports were in agreement.

-jwb


