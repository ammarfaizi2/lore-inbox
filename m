Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266980AbSKWOa3>; Sat, 23 Nov 2002 09:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbSKWOa3>; Sat, 23 Nov 2002 09:30:29 -0500
Received: from steve.prima.de ([62.72.84.2]:55272 "HELO steve.prima.de")
	by vger.kernel.org with SMTP id <S266980AbSKWOa1>;
	Sat, 23 Nov 2002 09:30:27 -0500
Date: Sat, 23 Nov 2002 15:37:00 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: AIC7xxx error messages with linux 2.5 BK-CURRENT
Message-ID: <20021123143700.GA17472@oscar.homelinux.net>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo everyone,

using the current BK snapshot of linux 2.5, I see many of the following
messages in my syslog:


Nov 23 14:58:29 tony kernel: Saw underflow (1012 of 1024 bytes). Treated
as error


The message are apparently caused by the AIC7xxx driver accessing
my harddrives. There is no negative effect though. All filesystem
operations appear to be OK.

As you can see below, I have four U160 IBM disks connected
to an Adaptec 3960D Ultra160 SCSI adapter. The Tag Queue Depth
is limited to 16. Both channels share IRQ 9.

The data was collected after boot, logged on into an X session.

Do I have to worry about that ?

Thanks,
Patrick


Here's some relevant hardware info:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM       Model: IC35L036UCD210-0  Rev: S5BA
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM       Model: IC35L036UCD210-0  Rev: S5BA
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

(scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM       Model: IC35L036UWD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi1:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM       Model: IC35L036UWD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 16
SCSI device sda: drive cache: write back
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
 sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
scsi0:A:1:0: Tagged Queuing enabled.  Depth 16
SCSI device sdb: drive cache: write back
SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
 sdb: sdb1 sdb2 sdb3 sdb4
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
scsi1:A:0:0: Tagged Queuing enabled.  Depth 16
SCSI device sdc: drive cache: write back
SCSI device sdc: 71687340 512-byte hdwr sectors (36704 MB)
 sdc: sdc1 sdc2 sdc3 sdc4
Attached scsi disk sdc at scsi1, channel 0, id 0, lun 0
scsi1:A:1:0: Tagged Queuing enabled.  Depth 16
SCSI device sdd: drive cache: write back
SCSI device sdd: 71687340 512-byte hdwr sectors (36704 MB)
 sdd: sdd1 sdd2 sdd3 sdd4
Attached scsi disk sdd at scsi1, channel 0, id 1, lun 0

[root@tony] cat /proc/scsi/aic7xxx/0
Adaptec AIC7xxx driver version: 6.2.4
aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Channel A Target 0 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 0 Lun 0 Settings
                Commands Queued 1026
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 1 Lun 0 Settings
                Commands Queued 993
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0

[root@tony] cat /proc/scsi/aic7xxx/1
Adaptec AIC7xxx driver version: 6.2.4
aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
Channel A Target 0 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 0 Lun 0 Settings
                Commands Queued 3079
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 1 Lun 0 Settings
                Commands Queued 1410
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0


[root@tony] cat /proc/interrupts
           CPU0
  0:    1953494          XT-PIC  timer
  1:       3372          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:       6689          XT-PIC  aic7xxx, aic7xxx

