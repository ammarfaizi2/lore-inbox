Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261187AbSJCLev>; Thu, 3 Oct 2002 07:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262777AbSJCLev>; Thu, 3 Oct 2002 07:34:51 -0400
Received: from unthought.net ([212.97.129.24]:21220 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S261187AbSJCLeu>;
	Thu, 3 Oct 2002 07:34:50 -0400
Date: Thu, 3 Oct 2002 13:40:20 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: AARGH! Please help. IDE controller fsckup
Message-ID: <20021003114020.GD7350@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200210021516.46668.roy@karlsbakk.net> <20021003095316.GC7350@unthought.net> <200210031225.11283.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200210031225.11283.roy@karlsbakk.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 12:25:11PM +0200, Roy Sigurd Karlsbakk wrote:
> > > so - now - the CMD649 has suddenly begun to fail - losing contact with
> > > one or two drives, and I _really_ need to get what's on /data (RAID-5 on
> > > hd[efghijklmnop]) out. Problem is - the replacement controller I've got
> > > from the vendor works fine (turns up as controller 3 serving hd[mnop]).
> > > How can I revert this most easily to be able to boot again?
> >
> > Hindsight:  had you used persistent superblocks, this would not have
> > been a problem.  The kernel would know the correct ordering from the
> > superblocks, not the device names.
> 
> I have used presistent superblocks, but md0,1,2,3 will be differently ordered 
> if I change the disk order... At least I think so. It surely didn't work.

No. md0 would stay md0.  This is another effect of using superblocks,
and in fact this is also (ironically) more or less the only argument
*against* using them   :)

(Imagine inserting a disk which knows that it is disk 0 of md0 into some
machine that already has a perfectly fine md0 running)

> 
> > Solution 1: Write to the RAID mailing list and have one of the mdadm
> > gurus give you a one-liner to initialize the array with the proper
> > ordering.
> >
> > Solution 2: Edit your /etc/raidtab to reflect the new device naming and
> > run raidstart.
> 
> ok. but this won't be neccecary with persistent superblocks? right?

right

> 
> > If you start up the array with a bad ordering, no amount of magic is
> > going to bring back you data (after parity has been "reconstructed" on
> > various chunks of your existing data).
> 
> But ... with persistent superblock - is it possible to fsckup the raid?

You're root, it is indeed possible  :)

But you would not need to perform any of the special operations that you
need to now.

Persistent superblocks saves you from a number of "bad" situations you
can encounter with normal production systems (such as replacing a
controller or moving disks around).

One should be careful when moving disks with persistent superblocks
between systems though. You don't want the kernel to autodetect the
"wrong" md0 on boot   :)    I consider this problem nonexistent in the
production environment that I administer, but I know that some people
feel differently about it.  You should consider these pros and cons in
relation to your environment and make a decision based on that.

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
