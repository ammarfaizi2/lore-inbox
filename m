Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129738AbQLISGu>; Sat, 9 Dec 2000 13:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129957AbQLISGk>; Sat, 9 Dec 2000 13:06:40 -0500
Received: from Cantor.suse.de ([194.112.123.193]:65036 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129738AbQLISGd>;
	Sat, 9 Dec 2000 13:06:33 -0500
Date: Sat, 9 Dec 2000 18:35:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: patch: blk-12
Message-ID: <20001209183556.G307@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've released what will probably be the last blk-xx patch for 2.4, at
least as far as features go. In fact, blk-12 is just minor tweaks and
fixes over the previous version. Highlight of changes:

o Merge elevator merge and insertion scan. This saves an entire linear
  queue scan when we can't merge a new buffer into the existing list.

o More fair merge accounting, actually take request size into account
  when merging.

o Cleanup leftover cruft from previous elevator (nr_segments etc)

o Request queue aging.

o Batch freeing of requests. Stock kernels have very bad behaviour
  under I/O load (load here meaning that the request list is empty,
  doesn't require much effort...), because as soon as a request is
  completed and put back on the freelist, a read/write will grab it
  and the queue will be unplugged again. This effectively disables
  elevator merging efforts completely. Note -- even though wakeups
  of wait_for_request are now not a 1-1 mapping, wake-one semantics
  are maintained.

o Fix sg indeterminate request completion time, due to scsi_insert_*
  not providing guarentee of immediate queue run.

o Fix off by one ide-dma setup error

o Bump max request size from 64KB to 1MB, let low level drivers set
  their own limits (eg IDE has 128KB hw limit). No need to limit
  nice SCSI hardware, since during the data phase is where we get
  full throttle.

o Remove silly s/390 double request get error

It's against 2.4.0-test12-pre7, and can be found here:

*.kernel.org/pub/linux/kernel/axboe/patches/2.4.0-test12-pre7/blk-12.bz2

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
