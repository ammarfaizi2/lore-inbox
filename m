Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131500AbRBUDuL>; Tue, 20 Feb 2001 22:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131502AbRBUDuB>; Tue, 20 Feb 2001 22:50:01 -0500
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:42010 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S131500AbRBUDtm>; Tue, 20 Feb 2001 22:49:42 -0500
From: Colonel <klink@clouddancer.com>
To: roger.larsson@norran.net
Cc: ttsig@tuxyturvy.com, james@pcxperience.com, linux-kernel@vger.kernel.org
In-Reply-To: <0102210053570Y.00763@dox> (message from Roger Larsson on Wed, 21
	Feb 2001 00:53:57 +0100)
Subject: Re: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
Reply-To: klink@clouddancer.com
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com> <003701c09b75$59f56ff0$25040a0a@zeusinc.com> <20010220212149.5960E682A@mail.clouddancer.com> <0102210053570Y.00763@dox>
Message-Id: <20010221034936.49B42682A@mail.clouddancer.com>
Date: Tue, 20 Feb 2001 19:49:36 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   >    There seem to be several reports of reiserfs falling over when memory is
   >    low.  It seems to be undetermined if this problem is actually reiserfs
   > or MM related, but there are other threads on this list regarding similar
   > issues. This would explain why the same disk would work on a different
   > machine with more memory.  Any chance you could add memory to the box
   > temporarily just to see if it helps, this may help prove if this is the
   > problem or not.
   >
   >
   > Well, I didn't happen to start the thread, but your comments may
   > explain some "gee I wonder if it died" problems I just had with my
   > 2.4.1-pre2+reiser test box.  It only has 16M, so it's always low
   > memory (never been a real problem in the past however).  The test
   > situation is easily repeatable for me [1].  It's a 486 wall mount, so
   > it's easier to convert the fs than add memory, and it showed about
   > 200k free at the time of the sluggishness.  Previous 2.4.1 testing
   > with ext2 fs didn't show any sluggishness, but I also didn't happen to
   > run the test above either.  When I come back to the office later, I'll
   > convert the fs, repeat the test and pass on the results.
   >
   >
   > [1]  Since I decided to try to catch up on kernels, I had just grabbed
   > -ac18, cd to ~linux and run "rm -r *" via an ssh connection.  In a
   > second connection, I tried a simple "dmesg" and waited over a minute
   > for results (long enough to log in directly on the box and bring up
   > top) followed by loading emacs for ftp transfers from kernel.org,
   > which again 'went to sleep'.
   > -

   If these are freezes I had them too in 2.4.1, 2.4.2-pre1 fixed it for me.
   Really I think it was the patch in handle_mm_fault setting TASK_RUNNING.

   /RogerL

Ohoh, I see that I fat-fingered the kernel version.  The test box
kernel is 2.4.2-pre2 with Axboe's loop4 patch to the loopback fs.  It
runs a three partition drive, a small /boot in ext2, / as reiser and
swap.  I am verifying that the freeze is repeatable at the moment, and
so far I cannot cause free memory to drop to 200k and a short ice age
does not occur.  Unless I can get that to repeat, the effort will be
useless... the only real difference is swap, it was not initially
active and now it is.  Free memory never drops below 540k now, so I
would suspect a MM influence.  james@pcxperience.com didn't mention
the memory values in his initial post, but it would be interesting to
see if he simply leaves his machine alone if it recovers
(i.e. probable swap thrashing) and then determine if the freeze ever
re-occurs.  James seems to have better repeatability than I do.
Rebooting and retrying still doesn't result in a noticable freeze for
me.  Some other factor must have been involved that I didn't notice.
Still seems like MM over reiser tho.


PS for james:
>One thing I did notice was that the syncing of the raid 1 arrays went in
sequence, md0, md1, md2 instead of in parrallel.  I assume it is because
the machine just doesn't have the horsepower, etc. or is it that I have
multiple raid arrays on the same drives?

Same drives.
