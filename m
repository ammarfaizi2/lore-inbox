Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132474AbRCaRz7>; Sat, 31 Mar 2001 12:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132472AbRCaRzt>; Sat, 31 Mar 2001 12:55:49 -0500
Received: from gear.torque.net ([204.138.244.1]:6672 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S132471AbRCaRzk>;
	Sat, 31 Mar 2001 12:55:40 -0500
Message-ID: <3AC5F115.B1B69883@torque.net>
Date: Sat, 31 Mar 2001 10:00:37 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org, Armin Obersteiner <armin@xos.net>
Subject: Re: add-single-device won't work in 2.4.3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Armin,
It works for me:

$ uname -a
Linux frig 2.4.3 #1 Fri Mar 30 16:33:45 EST 2001 i586 unknown

$ cat /proc/scsi/scsi
Attached devices: 
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 05 Lun: 00
  Vendor: UMAX     Model: Astra 1220S      Rev: V1.2
  Type:   Scanner                          ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 06 Lun: 00
  Vendor: YAMAHA   Model: CRW4416S         Rev: 1.0g
  Type:   CD-ROM                           ANSI SCSI revision: 02

$ echo "scsi remove-single-device 2 0 5 0" > /proc/scsi/scsi
$ cat /proc/scsi/scsi 
Attached devices: 
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 06 Lun: 00
  Vendor: YAMAHA   Model: CRW4416S         Rev: 1.0g
  Type:   CD-ROM                           ANSI SCSI revision: 02

$ echo "scsi add-single-device 2 0 5 0" > /proc/scsi/scsi
$ cat /proc/scsi/scsi
Attached devices: 
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 06 Lun: 00
  Vendor: YAMAHA   Model: CRW4416S         Rev: 1.0g
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 05 Lun: 00
  Vendor: UMAX     Model: Astra 1220S      Rev: V1.2
  Type:   Scanner                          ANSI SCSI revision: 02

$ sg_scan -i
/dev/sg0: scsi1 channel=0 id=1 lun=0  type=0
    IBM       DNES-309170W      SA30 [wide=1 sync=1 cmdq=1 sftre=0 pq=0x0]  
/dev/sg1: scsi2 channel=0 id=6 lun=0  type=5
    YAMAHA    CRW4416S          1.0g [wide=0 sync=1 cmdq=0 sftre=0 pq=0x0] 
/dev/sg2: scsi2 channel=0 id=5 lun=0  type=6
    UMAX      Astra 1220S       V1.2 [wide=0 sync=0 cmdq=0 sftre=0 pq=0x0]

This last command is from sg_utils and it sends actual
INQUIRY commands rather than relying on data held in
the midlayer. This demonstrates the devices are responding.


Run on a AMD K6-2 500MHz machine with 2 advansys adapters.
Could you retest. If it continues to fail then it may be
a problem with the new aic7xxx driver. You also have the
option of building with the "old" (i.e. former) aic7xxx
driver.

Doug Gilbert

