Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbUCGWM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 17:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbUCGWM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 17:12:27 -0500
Received: from law10-f80.law10.hotmail.com ([64.4.15.80]:38407 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262343AbUCGWMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 17:12:13 -0500
X-Originating-IP: [67.22.169.122]
X-Originating-Email: [jpiszcz@hotmail.com]
From: "Justin Piszcz" <jpiszcz@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.3 / cdrdao 1.1.8 only recognizes devices on one IDE channel
Date: Sun, 07 Mar 2004 22:12:12 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F80H4WdMCARe600008525@hotmail.com>
X-OriginalArrivalTime: 07 Mar 2004 22:12:12.0482 (UTC) FILETIME=[3DAE5220:01C40491]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is cdrdao only see's the devices on the second IDE BUS (IDE1) 
and does not see anything on IDE0.

$ uname -r
2.6.3

$ cdrdao 2>&1 | grep -i version
Cdrdao version 1.1.8 - (C) Andreas Mueller <andreas@daneb.de>

    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA

hda=plextor 12/10/32a
hdc=plextor 12/10/32a
hdd=toshiba 16x dvdrom

hda: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
hdc: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
hdd: TOSHIBA DVD-ROM SD-M1712, ATAPI CD/DVD-ROM drive

ATAPI:0,0,0: PLEXTOR CD-R   PX-W1210A   Rev: 1.10
ATAPI:0,0,1:    Rev:
ATAPI:0,0,2:    Rev:
ATAPI:0,0,3:    Rev:
ATAPI:0,0,4:    Rev:
ATAPI:0,0,5:    Rev:
ATAPI:0,0,6:    Rev:
ATAPI:0,0,7:    Rev:
ATAPI:0,1,0: TOSHIBA DVD-ROM SD-M1712   Rev: 1004
ATAPI:0,1,1:    Rev:
ATAPI:0,1,2:    Rev:
ATAPI:0,1,3:    Rev:
ATAPI:0,1,4:    Rev:
ATAPI:0,1,5:    Rev:
ATAPI:0,1,6:    Rev:
ATAPI:0,1,7:    Rev:
ATAPI:0,2,0:    Rev:
ATAPI:0,2,1:    Rev:
ATAPI:0,2,2:    Rev:
ATAPI:0,2,3:    Rev:
ATAPI:0,2,4:    Rev:
ATAPI:0,2,5:    Rev:
ATAPI:0,2,6:    Rev:
ATAPI:0,2,7:    Rev:
ATAPI:0,3,0:    Rev:
ATAPI:0,3,1:    Rev:
ATAPI:0,3,2:    Rev:
ATAPI:0,3,3:    Rev:
ATAPI:0,3,4:    Rev:
...  (all empty)
ATAPI:9,9,9:    Rev:

Also, how does cdrecord work when not using ide-scsi?
$ cdrecord --scanbus
Cdrecord 2.00.3 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
Linux sg driver version: 3.5.30
Using libscg version 'schily-0.7'
scsibus0:
        0,0,0     0) *
        0,1,0     1) *
        0,2,0     2) 'IOMEGA  ' 'ZIP 100         ' 'J.03' Removable Disk
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *
$ cdrecord dev=/dev/hda

$ cdrecord dev=/dev/hda --scanbus
Cdrecord 2.00.3 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
scsidev: '/dev/hda'
devname: '/dev/hda'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
scsibus0:
        0,0,0     0) 'PLEXTOR ' 'CD-R   PX-W1210A' '1.10' Removable CD-ROM
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *
$

_________________________________________________________________
Get business advice and resources to improve your work life, from bCentral. 
http://special.msn.com/bcentral/loudclear.armx

