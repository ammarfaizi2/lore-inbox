Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317904AbSFSPJb>; Wed, 19 Jun 2002 11:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317905AbSFSPJa>; Wed, 19 Jun 2002 11:09:30 -0400
Received: from mtvwca1-smrly1.gtei.net ([128.11.176.196]:28573 "HELO
	mtvwca1-smrly1.gtei.net") by vger.kernel.org with SMTP
	id <S317904AbSFSPJ1>; Wed, 19 Jun 2002 11:09:27 -0400
To: linux-kernel@vger.kernel.org
Cc: gibbs@scsiguy.com
Subject: AIC7XXX + v2.4.18 problems?
From: Nick Papadonis <nick@coelacanth.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Date: Wed, 19 Jun 2002 11:09:13 -0400
Message-Id: <m3k7ov2tly.fsf@noop.bombay>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.1 (Cuyahoga Valley,
 i686-pc-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone else having problems with the AIC7XXX driver using a AHA-29160
controller?  I believe my kernel is going into a unrecoverable spin-lock 
when there is high SCSI load.  I'm assuming this because the keyboard 
lights still function and network still replies to pings.

In addition the 'st' driver returns with unrecoverable errors when 
trying to tar to tape.  This usually occurs after a few hundred 
megabytes have been pushed through a device.

My setup is :
   - AHA-29160N controller
   - Internal 50 PIN / SCSI-2 port in use
   - See below for connected drives

I tested the following kernels and they display similar behavior:
   - v2.4.9
   - v2.4.18
   - v2.4.18 with updated 7XXX driver
   - v2.4.19-pre10

Any insight is appreciated.

- Nick




DETAILS:
Jun 19 01:25:15 bombay kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
Jun 19 01:25:15 bombay kernel:         <Adaptec 29160 Ultra160 SCSI adapter>
Jun 19 01:25:15 bombay kernel:         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Jun 19 01:25:15 bombay kernel: 
Jun 19 01:25:15 bombay kernel:   Vendor: IBM       Model: DNES-318350       Rev: SAH0
Jun 19 01:25:15 bombay kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jun 19 01:25:15 bombay kernel:   Vendor: IBM       Model: DCAS-34330        Rev: S65A
Jun 19 01:25:15 bombay kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun 19 01:25:15 bombay kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W124TS  Rev: 1.07
Jun 19 01:25:15 bombay kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jun 19 01:25:15 bombay kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Jun 19 01:25:15 bombay kernel: scsi0:A:2:0: Tagged Queuing enabled.  Depth 253
Jun 19 01:25:15 bombay kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Jun 19 01:25:15 bombay kernel: Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
Jun 19 01:25:15 bombay kernel: (scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 31)
Jun 19 01:25:15 bombay kernel: SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Jun 19 01:25:15 bombay kernel:  sda: sda1 sda2 sda3
Jun 19 01:25:15 bombay kernel: (scsi0:A:2): 20.000MB/s transfers (20.000MHz, offset 15)
Jun 19 01:25:15 bombay kernel: SCSI device sdb: 8467200 512-byte hdwr sectors (4335 MB)
Jun 19 01:25:15 bombay kernel:  sdb: unknown partition table


[root@bombay root]# more /proc/scsi/aic7xxx/0 
Adaptec AIC7xxx driver version: 6.2.8
aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

Serial EEPROM:
0x439b 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 
0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 
0xb8f4 0x7c5d 0x2807 0x0010 0x0300 0xffff 0xffff 0xffff 
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x0250 0x16b0 

Channel A Target 0 Negotiation Settings
        User: 40.000MB/s transfers (40.000MHz DT, offset 255)
        Goal: 20.000MB/s transfers (20.000MHz, offset 31)
        Curr: 20.000MB/s transfers (20.000MHz, offset 31)
        Channel A Target 0 Lun 0 Settings
                Commands Queued 245659
                Commands Active 0
                Command Openings 64
                Max Tagged Openings 64
                Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 2 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 20.000MB/s transfers (20.000MHz, offset 15)
        Curr: 20.000MB/s transfers (20.000MHz, offset 15)
        Channel A Target 2 Lun 0 Settings
                Commands Queued 5
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 3 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 40.000MB/s transfers (40.000MHz, offset 127)
        Curr: 3.300MB/s transfers
        Channel A Target 3 Lun 0 Settings
                Commands Queued 1
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Channel A Target 4 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 5 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
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


