Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132798AbRDOT7c>; Sun, 15 Apr 2001 15:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132799AbRDOT7W>; Sun, 15 Apr 2001 15:59:22 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:47377 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S132798AbRDOT7J>; Sun, 15 Apr 2001 15:59:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: fsck, raid reconstruction & bad bad 2.4.3
In-Reply-To: <9bcoph$1vj$1@ns1.clouddancer.com>
In-Reply-To: <20010415181825.40FBB1BA03@backlot.linas.org> <9bcoph$1vj$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010415195903.1D0F7683B@mail.clouddancer.com>
Date: Sun, 15 Apr 2001 12:59:03 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In list.kernel, linas wrote:
>
>First problem:  In kernel-2.4.2 and earlier, if the machine is not cleanly
>shut down, then upon reboot, RAID reconstruction is automatically started.
>(For RAID-1, this more-or-less ammounts to copying the entire contents
>of one disk partition on one disk to another).   The reconstruction
>code seems to be clever: it will try to use the full bandwidth when
>the system is idle, and it will throttle back when busy.  It will
>only throttle back so far: it tries to maintain at least a minimum amount
>of work going, in order to gaurentee forward progress even on a busy system.

And it works great!

>The problem:  this dramatically slows fsck after an unclean shut-down.
>You can hear the drives machine-gunning.  I haven't stop-watch timed it,
>but its on the order of 5x slower to fsck a raid partition when there's
>reconstruction going on, then when the raid thinks its clean.  This
>makes unclean reboots quite painful.

Since the alternative is to sit there and do NOTHING until the
reconstruction is complete, ala Solaris 2.5, it's WONDERFUL the way it
is.  This change was extensively discussed on the raid mailing list a
couple of years ago.  You can look it up for review.

>(There is no config file to disable/alter this .. no work-around that I
>know of ..)

You can't be serious.  Go sit down and think about what's going on.


>--------
>The second problem: oparallelizing fsck doesn't realize that different
>/dev/md raid volumes are on the same physical disks, and thus tries
>to parallelize .... again slowing things down.   There is a work-around,
>modify /etc/fstab to set the rder of fsck's. However, I doubt the HOWTO
>really gets into this ....  it would be nice to get fsck to 'do the
>right thing'.

You probably have your fstab incorrectly setup.

<snip>
#> In particular, how does fsck deal with md devices? It parallelizes
#> itself for multiple disks, but if the volumes are all actually striped 
#> over the same disks, fsck will perform better if it's serial.
#
#The "pass" field in /etc/fstab is for exactly this: fsck -a will
#serialise devices with different pass numbers.  Pass==1 is for root,
#pass==2 is for normal devices which fsck knows how to serialise.  If you
#want to force serialisation on md devices, use larger pass numbers.
</snip>

Do a little work, it won't hurt you.  Fsck should not (and may not be
able to) decode metadevice structures.


Your third part was ignored, given the above.
