Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129518AbQKMVgy>; Mon, 13 Nov 2000 16:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129380AbQKMVgp>; Mon, 13 Nov 2000 16:36:45 -0500
Received: from zeus.kernel.org ([209.10.41.242]:55311 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129230AbQKMVga>;
	Mon, 13 Nov 2000 16:36:30 -0500
Message-Id: <200011132031.OAA15635@kenobi.americas.sgi.com>
To: linux-kernel@vger.kernel.org
From: kohnke@sgi.com (Marlys Kohnke)
Subject: blocks read/written counters
Date: Mon, 13 Nov 2000 14:31:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     As part of the new resource counters I'm adding for our job
accounting feature, I'm trying to gather blocks read and written
on a per task basis (which will get rolled into a per job statistic
outside of the kernel).  I added task struct counters which get
incremented in drivers/block/ll_rw_blk.c in the drive_stat_acct() procedure, 
which is where the kernel stats are gathered for blocks read/written.

     What I noticed, though, was that some system daemons would be
the current task when going through drive_stat_acct() for writes, but 
usually it was kupdate.  In doing some searching, I now see that kupdate
is the kernel thread responsible to flush the dirty buffers out to disk.
I need to capture this blocks read/written information for user
processes, not kupdate. 

     We were able to get this block info on the Cray systems (which
have separate direct IO and buffered IO) and somewhat on the IRIX 
systems (where whichever process is running when the buffers get flushed 
is the process which gets charged for those buffers).  Apparently, this
information is useful for capacity planning and in cache thrashing
situations.  It's not used for billing purposes.

     Is there a reasonable way on Linux to get any blocks read and
written information on a per task basis?  Thanks for any help.

----
Marlys Kohnke			Silicon Graphics Inc.
kohnke@sgi.com			655F Lone Oak Drive
(651)683-5324			Eagan, MN 55121
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
