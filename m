Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSLLLEv>; Thu, 12 Dec 2002 06:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSLLLEv>; Thu, 12 Dec 2002 06:04:51 -0500
Received: from mxintern.kundenserver.de ([212.227.126.204]:60919 "EHLO
	mxintern.kundenserver.de") by vger.kernel.org with ESMTP
	id <S262425AbSLLLEu>; Thu, 12 Dec 2002 06:04:50 -0500
Date: Thu, 12 Dec 2002 12:12:37 +0100
From: Anders Henke <anders.henke@sysiphus.de>
To: linux-kernel@vger.kernel.org
Subject: using 2 TB  in real life
Message-ID: <20021212111237.GA12143@schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Schlund + Partner AG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just added a 1.9 TB array to one of my servers (running 2.4.20,
the device is an 12bay-IFT IDE-to-Fibre-RAID connected via a 
Qlogic 2300 HBA):

Disk /dev/sdb: 255 heads, 63 sectors, 247422 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sdb1             1    247422 1987417183+  83  Linux
[...]
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
SCSI device sdb: -320126976 512-byte hdwr sectors (-163904 MB)
 sdb: sdb1


Another array (1.2 TB) gives almost the same effect:
Disk /dev/sdb: 255 heads, 63 sectors, 157450 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sdb1             1    157450 1264717093+  83  Linux
[...]
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
SCSI device sdb: -1765523456 512-byte hdwr sectors (195564 MB)
 sdb: sdb1

These issues arise when using arrays larger than around 0.5 T;
nevertheless, these devices do work fine with both xfs or ext3, 
it's "just" a cosmetical issue. However, this negative
values make one feel like Linux isn't truely capable of using up to
2 TB of disk devices and so this should be resolved.
To me it seems that sd.c doesn't know how to calculate the
correct values for such beasts - any ideas?


Regards

Anders
-- 
http://sysiphus.de/
