Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132742AbRDOSTV>; Sun, 15 Apr 2001 14:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132776AbRDOSTL>; Sun, 15 Apr 2001 14:19:11 -0400
Received: from linas.org ([207.170.121.1]:35062 "HELO backlot.linas.org")
	by vger.kernel.org with SMTP id <S132742AbRDOSTD>;
	Sun, 15 Apr 2001 14:19:03 -0400
To: jakob@ostenfeld.dk, linux-kernel@vger.kernel.org, miku@iki.fi,
        neilb@cse.unsw.edu.au
Subject: fsck, raid reconstruction & bad bad 2.4.3
Message-Id: <20010415181825.40FBB1BA03@backlot.linas.org>
Date: Sun, 15 Apr 2001 13:18:25 -0500 (CDT)
From: linas@backlot.linas.org (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I want to report a trio of raid-related problems.  The third one is 
very serious, and effectively prevents 2.4.3 from being usable (by me).

First problem:  In kernel-2.4.2 and earlier, if the machine is not cleanly
shut down, then upon reboot, RAID reconstruction is automatically started.
(For RAID-1, this more-or-less ammounts to copying the entire contents
of one disk partition on one disk to another).   The reconstruction
code seems to be clever: it will try to use the full bandwidth when
the system is idle, and it will throttle back when busy.  It will
only throttle back so far: it tries to maintain at least a minimum amount
of work going, in order to gaurentee forward progress even on a busy system.

The problem:  this dramatically slows fsck after an unclean shut-down.
You can hear the drives machine-gunning.  I haven't stop-watch timed it,
but its on the order of 5x slower to fsck a raid partition when there's
reconstruction going on, then when the raid thinks its clean.  This
makes unclean reboots quite painful.

(There is no config file to disable/alter this .. no work-around that I
know of ..)

--------
The second problem: oparallelizing fsck doesn't realize that different
/dev/md raid volumes are on the same physical disks, and thus tries
to parallelize .... again slowing things down.   There is a work-around,
modify /etc/fstab to set the rder of fsck's. However, I doubt the HOWTO
really gets into this ....  it would be nice to get fsck to 'do the
right thing'.

----------

Third problem:

I just tried boot 2.4.3 today.  (after an unclean shutdown)  fsck runs 
at a crawl on my RAID-1 volume.  It would take all day (!! literally) 
to fsck.  The disk-drive activity light flashes about once a second,
maybe once every two seconds.  (with a corresponding click from the
drive).    

On 2.4.2 kernels, the disk activity light is constantly on... and the
fsck proceeds apace. 

Whatever it is that changed in 2.4.3, it makes unclean reboots
impossible ...


--linas




