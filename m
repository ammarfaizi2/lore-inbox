Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290295AbSAXVBB>; Thu, 24 Jan 2002 16:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290297AbSAXVAw>; Thu, 24 Jan 2002 16:00:52 -0500
Received: from beasley.gator.com ([63.197.87.202]:10502 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S290295AbSAXVAh>; Thu, 24 Jan 2002 16:00:37 -0500
From: "George Bonser" <george@gator.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: 2.4.18-pre7 cant find scsi disks
Date: Thu, 24 Jan 2002 13:00:34 -0800
Message-ID: <CHEKKPICCNOGICGMDODJGENGGBAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.21.0201231953410.4134-100000@freak.distro.conectiva>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't boot pre7 but pre6 works every time.  AIC7XXX controller with
a single drive.
It looks like it gets some kind of error when it is looking for disks.

Hard to get the message it prints out because it looks like it is
trying every possible LUN. The original message scrolls off and I cant
page back because new lines put me back to the current line.

pre7 is not a good thing.  A pre6 dmesg reports the following on a
good boot:

SCSI subsystem driver Revision: 1.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

 Vendor: SEAGATE    Model: ST31840LW         Rev: 0006
 Type:   Direct-Access                       ANSI SCSI revision: 03
(scsi0:A:0) 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Partition check:
 sda: sda1 sda2 sda3


On the failed boot I get  scsi0:0:0:0: Attempting to queue ABORT
message right after it posts the scsi0 and scsi1 controller info and
it looks like it just starts going from scsi0:0:0:0 to 0:0:1:0,
0:0:2:0, 0:0:3:0, etc looking for a disk.

