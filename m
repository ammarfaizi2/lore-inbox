Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRBUOqs>; Wed, 21 Feb 2001 09:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129184AbRBUOqj>; Wed, 21 Feb 2001 09:46:39 -0500
Received: from www.pcxperience.com ([199.217.242.242]:32244 "EHLO
	gannon.zelda.pcxperience.com") by vger.kernel.org with ESMTP
	id <S129134AbRBUOq1>; Wed, 21 Feb 2001 09:46:27 -0500
Message-ID: <3A93D46E.73CAA2B8@pcxperience.com>
Date: Wed, 21 Feb 2001 08:45:02 -0600
From: "James A. Pattie" <james@pcxperience.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: klink@clouddancer.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com> <003701c09b75$59f56ff0$25040a0a@zeusinc.com> <20010220212149.5960E682A@mail.clouddancer.com> <0102210053570Y.00763@dox> <20010221034936.49B42682A@mail.clouddancer.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colonel wrote:

>    >    There seem to be several reports of reiserfs falling over when memory is
>    >    low.  It seems to be undetermined if this problem is actually reiserfs
>    > or MM related, but there are other threads on this list regarding similar
>    > issues. This would explain why the same disk would work on a different
>    > machine with more memory.  Any chance you could add memory to the box
>    > temporarily just to see if it helps, this may help prove if this is the
>    > problem or not.
>    >
>    >
>    > Well, I didn't happen to start the thread, but your comments may
>    > explain some "gee I wonder if it died" problems I just had with my
>    > 2.4.1-pre2+reiser test box.  It only has 16M, so it's always low
>    > memory (never been a real problem in the past however).  The test
>    > situation is easily repeatable for me [1].  It's a 486 wall mount, so
>    > it's easier to convert the fs than add memory, and it showed about
>    > 200k free at the time of the sluggishness.  Previous 2.4.1 testing
>    > with ext2 fs didn't show any sluggishness, but I also didn't happen to
>    > run the test above either.  When I come back to the office later, I'll
>    > convert the fs, repeat the test and pass on the results.
>    >
>    >
>    > [1]  Since I decided to try to catch up on kernels, I had just grabbed
>    > -ac18, cd to ~linux and run "rm -r *" via an ssh connection.  In a
>    > second connection, I tried a simple "dmesg" and waited over a minute
>    > for results (long enough to log in directly on the box and bring up
>    > top) followed by loading emacs for ftp transfers from kernel.org,
>    > which again 'went to sleep'.
>    > -
>
>    If these are freezes I had them too in 2.4.1, 2.4.2-pre1 fixed it for me.
>    Really I think it was the patch in handle_mm_fault setting TASK_RUNNING.
>
>    /RogerL
>
> Ohoh, I see that I fat-fingered the kernel version.  The test box
> kernel is 2.4.2-pre2 with Axboe's loop4 patch to the loopback fs.  It
> runs a three partition drive, a small /boot in ext2, / as reiser and
> swap.  I am verifying that the freeze is repeatable at the moment, and
> so far I cannot cause free memory to drop to 200k and a short ice age
> does not occur.  Unless I can get that to repeat, the effort will be
> useless... the only real difference is swap, it was not initially
> active and now it is.  Free memory never drops below 540k now, so I
> would suspect a MM influence.  james@pcxperience.com didn't mention
> the memory values in his initial post, but it would be interesting to
> see if he simply leaves his machine alone if it recovers
> (i.e. probable swap thrashing) and then determine if the freeze ever
> re-occurs.  James seems to have better repeatability than I do.
> Rebooting and retrying still doesn't result in a noticable freeze for
> me.  Some other factor must have been involved that I didn't notice.
> Still seems like MM over reiser tho.

When the machine stopped responding, the first time, I let it go over the weekend
(2 days+) and it still didn't recover.  I never saw a thrashing effect.  The
initial memory values were 2MB free memory, < 1MB cache.  I never really looked at
the cache values as I wasn't sure how they affected the system.  when the system
was untarring my tarball, the memory usage would get down < 500kb and swap would be
around a couple of megs usually.

>
>
> PS for james:
> >One thing I did notice was that the syncing of the raid 1 arrays went in
> sequence, md0, md1, md2 instead of in parrallel.  I assume it is because
> the machine just doesn't have the horsepower, etc. or is it that I have
> multiple raid arrays on the same drives?
>
> Same drives.

That's what I thought.

Thanks,


--
James A. Pattie
james@pcxperience.com

Linux  --  SysAdmin / Programmer
PC & Web Xperience, Inc.
http://www.pcxperience.com/



