Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264523AbTKNSgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 13:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbTKNSgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 13:36:46 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:32428 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264523AbTKNSgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 13:36:43 -0500
Date: Fri, 14 Nov 2003 11:01:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: office@produktivit.com
Subject: [Bug 1542] New: Badness in as_completed_request at	drivers/block/as-iosched.c:919 
Message-ID: <94990000.1068836516@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1542

           Summary: Badness in as_completed_request at drivers/block/as-
                    iosched.c:919
    Kernel Version: 2.6.0-test9
            Status: NEW
          Severity: low
             Owner: axboe@suse.de
         Submitter: office@produktivit.com


Distribution: Debian  
Hardware Environment: x86 SMP in UMP mode 
Software Environment: Debian unstable (current) 
Problem Description: strange  
 
Steps to reproduce:  
In normal operation, dmesg gives this: 
 
Badness in as_completed_request at drivers/block/as-iosched.c:919 
Call Trace: 
 [<c01e19fe>] as_completed_request+0x1ae/0x1dc 
 [<c01db343>] elv_completed_request+0x13/0x18 
 [<c01dd352>] __blk_put_request+0x26/0x80 
 [<c01de15b>] end_that_request_last+0x3f/0x74 
 [<c883481e>] scsi_end_request+0x8e/0xbc [scsi_mod] 
 [<c8834b89>] scsi_io_completion+0x1cd/0x434 [scsi_mod] 
 [<c88cba48>] sd_rw_intr+0x84/0x2d0 [sd_mod] 
 [<c8830768>] scsi_done+0xc/0x5c [scsi_mod] 
 [<c8830a4c>] scsi_finish_command+0x7c/0xc4 [scsi_mod] 
 [<c8830892>] scsi_softirq+0xda/0x1f0 [scsi_mod] 
 [<c0120a43>] do_softirq+0x8b/0x90 
 [<c010cc39>] do_IRQ+0xf1/0x124 
 [<c010b6e4>] common_interrupt+0x18/0x20 
 
Badness in as_completed_request at drivers/block/as-iosched.c:919 
Call Trace: 
 [<c01e19fe>] as_completed_request+0x1ae/0x1dc 
 [<c01db343>] elv_completed_request+0x13/0x18 
 [<c01dd352>] __blk_put_request+0x26/0x80 
 [<c01de15b>] end_that_request_last+0x3f/0x74 
 [<c883481e>] scsi_end_request+0x8e/0xbc [scsi_mod] 
 [<c8834b89>] scsi_io_completion+0x1cd/0x434 [scsi_mod] 
 [<c023b95e>] arp_process+0xaa/0x510 
 [<c88cba48>] sd_rw_intr+0x84/0x2d0 [sd_mod] 
 [<c8830768>] scsi_done+0xc/0x5c [scsi_mod] 
 [<c8830a4c>] scsi_finish_command+0x7c/0xc4 [scsi_mod] 
 [<c8830892>] scsi_softirq+0xda/0x1f0 [scsi_mod] 
 [<c0120a43>] do_softirq+0x8b/0x90 
 [<c010cc39>] do_IRQ+0xf1/0x124 
 [<c010b6e4>] common_interrupt+0x18/0x20 
 
# lsmod 
Module                  Size  Used by 
[...] 
md5                     3968  1 
osst                   49304  0 
sd_mod                 15776  26 
ide_scsi               13952  0 
ide_mod               137260  1 ide_scsi 
unix                   26928  198 
cfbcopyarea             4096  0 
cfbimgblt               3456  0 
cfbfillrect             3968  0 
raid1                  14720  1 
raid5                  19584  3 
md                     45888  6 raid1,raid5 
xor                    15112  1 raid5 
ext3                  107688  4 
jbd                    56728  1 ext3 
aic7xxx               189416  26 
scsi_mod              110136  4 osst,sd_mod,ide_scsi,aic7xxx 
 
It does not appear to affect normal operations, however.  
 
Salut 
 
Mark


