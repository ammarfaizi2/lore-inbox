Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318726AbSICUkc>; Tue, 3 Sep 2002 16:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318914AbSICUkb>; Tue, 3 Sep 2002 16:40:31 -0400
Received: from host194.steeleye.com ([216.33.1.194]:26896 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S318726AbSICUka>; Tue, 3 Sep 2002 16:40:30 -0400
Message-Id: <200209032044.g83KiqJ08551@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Alex Adriaanse" <alex_a@caltech.edu>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: SCSI disk error
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Sep 2002 15:44:51 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alex Adriaanse" <alex_a@caltech.edu> said:
> I got the following error message last night on one of my SCSI disks:
> SCSI disk error : host 0 channel 0 id 6 lun 0 return code = 100ff
>  I/O error: dev 08:11, sector 38584

That error is a DID_NO_CONNECT.  For the symbios driver that means a selection 
timeout, I think.

> Is there any way to look up what the return code means?  By the way,
> badblocks doesn't seem to return any bad blocks, and I can still
> access the disk (including the first partition) just fine.  I found
> documentation for my hard drive at h

They go in 8 bits from LSB to MSB: status byte, message byte, host byte, 
driver byte.  The first two (status and message) are the SCSI return codes 
from the device.  The latter two are set by the driver (that's where the 
DID_NO_CONNECT is).  See drivers/scsi/scsi.h

James Bottomley


