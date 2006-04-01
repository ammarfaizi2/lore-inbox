Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWDAOtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWDAOtA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 09:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbWDAOtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 09:49:00 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:38725 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1751536AbWDAOs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 09:48:59 -0500
Date: Sat, 1 Apr 2006 17:50:06 +0300
From: Dan Aloni <da-x@monatomic.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Mark Lord <lkml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       sander@humilis.net, dror@xiv.co.il
Subject: Spradic device disconnections
Message-ID: <20060401145006.GA6504@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There's a weird behavior we are experiencing with the Marvell
6081 controller, which I though you might have also experienced
or might find interesting.

Basically, the problem involves sporadic device disconnection 
during driver load time and sometimes during continuous use. It
was seen both with sata_mv and the driver provided by Marvell 
(version 3.6.1), so I have a reason to believe it's an hardware 
problem (to which we can find good software-based workarounds, 
hopefully).

The system seen below has 2 Marvell 6081 controllers harboring
a total of 14 hard-drives.

Once in every a few hundreds-or-so insmods of sata_mv the 
controller "misses" one of the drives, as seen below:

Mar 31 10:41:10 14.10.240.6 kernel: ata10: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48  
Mar 31 10:41:10 14.10.240.6 kernel: ata10: dev 0 configured for UDMA/133 
Mar 31 10:41:10 14.10.240.6 kernel: scsi9 : sata_mv 
Mar 31 10:41:11 14.10.240.6 kernel: ata11: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48  
Mar 31 10:41:11 14.10.240.6 kernel: ata11: dev 0 configured for UDMA/133 
Mar 31 10:41:11 14.10.240.6 kernel: scsi10 : sata_mv 
Mar 31 10:41:12 14.10.240.6 kernel: ata12: no device found (phy stat 00000000) 
Mar 31 10:41:12 14.10.240.6 kernel: ata12: no device found (phy stat 00000101) 
Mar 31 10:41:12 14.10.240.6 kernel: ATA: abnormal status 0x7F on port 0xFFFFC200106A811C 
Mar 31 10:41:12 14.10.240.6 kernel: ata12: dev 0 failed to IDENTIFY (I/O error) 
Mar 31 10:41:12 14.10.240.6 kernel: ATA: abnormal status 0x7F on port 0xFFFFC200106A811C 
Mar 31 10:41:12 14.10.240.6 kernel: ata12: dev 0 failed to IDENTIFY (I/O error) 
Mar 31 10:41:12 14.10.240.6 kernel: ATA: abnormal status 0x7F on port 0xFFFFC200106A811C 
Mar 31 10:41:12 14.10.240.6 kernel: ata12: dev 0 failed to IDENTIFY (I/O error) 
Mar 31 10:41:12 14.10.240.6 kernel: scsi11 : sata_mv 
Mar 31 10:41:13 14.10.240.6 kernel: ata13: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48  
Mar 31 10:41:13 14.10.240.6 kernel: ata13: dev 0 configured for UDMA/133 
Mar 31 10:41:13 14.10.240.6 kernel: scsi12 : sata_mv 
Mar 31 10:41:14 14.10.240.6 kernel: ata14: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48  
Mar 31 10:41:14 14.10.240.6 kernel: ata14: dev 0 configured for UDMA/133 
Mar 31 10:41:14 14.10.240.6 kernel: scsi13 : sata_mv 

Rest assured that drive is there, we haven't pulled it out. 

On Linux 2.4.27 with the Marvell driver (3.6.1), using the 
add-single-device command on the (now depricated) /proc/scsi/scsi 
interface, we managed to bring the drive back to life...

The drives are the 500GB from Maxtor. This problem has occured 
with drives from a different manufacturer.

Mar 31 10:41:09 14.10.240.6 kernel:   Vendor: ATA       Model: Maxtor 7H500F0    Rev: HA43 
Mar 31 10:41:09 14.10.240.6 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05 

-- 
Dan Aloni, Linux specialist
XIV LTD, http://www.xivstorage.com
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
