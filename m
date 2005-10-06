Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVJFPGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVJFPGh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVJFPGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:06:37 -0400
Received: from math.ut.ee ([193.40.36.2]:24786 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751071AbVJFPGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:06:36 -0400
Date: Thu, 6 Oct 2005 18:05:56 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Found a new way to hang my IDE CD
Message-ID: <Pine.SOC.4.61.0510061757580.25809@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm back with my old IDE CD problem - the one that got DMA broken in 2.4 
(see http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/0480.html). I 
again stumped upon a problem that hangs IDE CD access with Sony CDU5211 
on ICH2. Running 2.6.14-rc3 + yesterdays git.

I tried "blktool /dev/hdc id" and it hangs in D state in blk_execute_rq. 
Dmesg tells

hdc: CDU5211, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
[...]
hdc: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
[...]

hdc: DMA interrupt recovery
hdc: lost interrupt
hdc: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdc: DMA disabled
hdc: drive not ready for command
hdc: ATAPI reset complete
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_QUIET
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
hdc: lost interrupt
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED REQ_QUIET
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
hdc: lost interrupt
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED REQ_QUIET
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)

and so on every now and then.

-- 
Meelis Roos (mroos@linux.ee)
