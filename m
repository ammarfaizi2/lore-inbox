Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131141AbQKADMW>; Tue, 31 Oct 2000 22:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131161AbQKADMM>; Tue, 31 Oct 2000 22:12:12 -0500
Received: from fw.SuSE.com ([202.58.118.35]:64500 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S131141AbQKADMD>;
	Tue, 31 Oct 2000 22:12:03 -0500
Date: Tue, 31 Oct 2000 20:17:57 -0800
From: Jens Axboe <axboe@suse.de>
To: Packet Writing <packet-writing@suse.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: release: packet-0.0.2d
Message-ID: <20001031201757.D11727@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've just uploaded a new release of the packet writing patch, this time
against the 2.4.0-test10 kernel. The bugs fixes that I've actually
cared/remembered to write down are:

- (scsi) use implicit segment recounting for all hba's
- fix speed setting, was consistenly off on most drives
- only print capacity when opening for write
- fix off-by-two error in getting/setting write+read speed (affected
  reporting as well as actual speed used)
- possible to enable write caching on drive
- do ioctl marshalling on sparc64 from Ben Collins <bcollins@debian.org>
- avoid unaligned access on flags, should have been unsigned long of course
- fixed missed wakeup in kpacketd
- b_dev error (two places)
- fix buffer head b_count bugs
- fix hole merge bug, where tail could be added twice
- fsync and invalidate buffers on close
- check hash table for buffers first before using our own
- add read-ahead
- fixed several list races
- fix proc reporting for more than one device
- change to O_CREAT for creating devices
- added media_change hook
- added free buffers config option
- pkt_lock_tray fails on failed open (and oopses), remove it. unlock
  is done explicitly in pkt_remove dev anyway.
- added proper elevator insertion (should probably be part of elevator.c)
- moved kernel thread info to private device, spawn one for each writer
- added separate buffer list for dirty packet buffers
- fixed nasty data corruption bug
- remember to account request even when we don't gather data for it
- add ioctl to force wakeup of kernel thread (for debug)
- fixed packet size setting bug on zero detected
- changed a lot of the proc reporting to be more readable to "humans"
- set full speed for read-only opens

People wanting to give it a go, should also remember to update their
UDF cvs tree (CDRW branch) and install new cdrwtool and pktsetup
binaries.

Interoperability with DirectCD has been tested, and that seems to work.

Bugs / success stories (yeah right) should be repoted to the
packet-writing list.

*.kernel.org/pub/linux/kernel/people/axboe/packet/packet-0.0.2d.diff.bz2

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
