Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbSI2VRg>; Sun, 29 Sep 2002 17:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbSI2VRg>; Sun, 29 Sep 2002 17:17:36 -0400
Received: from signup.localnet.com ([207.251.201.46]:52610 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S261806AbSI2VRf> convert rfc822-to-8bit;
	Sun, 29 Sep 2002 17:17:35 -0400
To: linux-kernel@vger.kernel.org
Subject: ide-scsi, 1394-sbp2 and usb-storage scsi host ids
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 29 Sep 2002 17:22:56 -0400
Message-ID: <m3ofagpk27.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In all 2.4 versions I've tested, (the most recent of which are
2.4.20-pre4-ac1 and 2.4.20-pre8), ide-scsi, sbp2 and usb-storage all
use scsi host id 0.  Eg (w/ just ide-scsi and sbp2):

:; cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Maxtor   Model: 1394 storage     Rev: v1.2
  Type:   Direct-Access                    ANSI SCSI revision: 06
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SONY     Model: CD-RW  CRX810E   Rev: 1.4c
  Type:   CD-ROM                           ANSI SCSI revision: 02

This causes problems at lest for sg:

:; cdrecord --scanbus
Cdrecord 1.11a05 (i686-suse-linux) Copyright (C) 1995-2001 Jörg Schilling
Linux sg driver version: 3.1.24
Using libscg version 'schily-0.5'
scsibus0:
        0,0,0     0) 'Maxtor  ' '1394 storage    ' 'v1.2' Disk
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

I can't test 2.5 on this box, as /home, /opt, /tmp, /usr, /var and
swap are all in LVM1.

What does it take to get the host/channel/id/lun tuples to increment
the host value each time a releted module is inserted?

-JimC

