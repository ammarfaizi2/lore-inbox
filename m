Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSLCNv5>; Tue, 3 Dec 2002 08:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261416AbSLCNv5>; Tue, 3 Dec 2002 08:51:57 -0500
Received: from [195.223.140.107] ([195.223.140.107]:4992 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261426AbSLCNv4>;
	Tue, 3 Dec 2002 08:51:56 -0500
Date: Tue, 3 Dec 2002 14:59:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Andrew Clayton <andrew@sol-1.demon.co.uk>,
       Javier Marcet <jmarcet@pobox.com>
Subject: Re: Exaggerated swap usage
Message-ID: <20021203135905.GK1205@dualathlon.random>
References: <200212030059.32018.m.c.p@wolk-project.de> <20021203005939.GF28164@dualathlon.random> <200212031112.14635.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212031112.14635.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 11:13:22AM +0100, Marc-Christian Petersen wrote:
> On Tuesday 03 December 2002 01:59, you wrote:
> 
> Hi Andrea,
> 
> > this is the interesting one. Did you run any unstable kernel/driver
> > software combination recently or maybe you got oopsed or crashes?
> nope, no oops, no crash, afaik no unstable kernel/drivers. Kernel is yours ;) 
> and drivers, hmm, just intel i815, eepro100. That happend after some hours of 
> uptime and just doing "rm -rf linux-old"
> 
> > journaling sometime gives a false sense of reliability, you've to keep
> > in mind that unless you know why you had to reboot w/o a clean unmount
> > you should always force an e2fsck -f/reiserfsck in single user mode at
> > the next boot, no matter of journaling. If the machine crashed because
> Yep, I always do a forced fsck in case of that.
> 
> > of a kernel oops or similar skipping the filesystemcheck at the very
> > next boot could left the fs corrupted for a long time until you notice
> > it possibly while running an unrelated kernel. So if you crashed
> > recently and you didn't run any e2fsck -f that could explain it. I doubt
> I run e2fsck -fy every time after a crash. Fortunately it doesn't happen so 
> often :-)

ok ;) I asked just in case.

> 
> > ...
> > don't know the details of the bug at the time of the next reboot so
> > normally an e2fsck -f is always required after a kernel crash, this
> > can't be automated simply because if the kernel is crashed we can't
> > write to the superblock to notify e2fsck about it, so at the next boot
> > e2fsck will always think replying the log was enough).
> yep. I tried to remove that 00_umount-against-unused-dirty-inodes-race fix and 
> after that (now 5 hours uptime) doing only copying and deleting, that ext3fs 
> error is away.
> 
> > Of course your problem could be explained by a bad cable or whatever
> > else hardware failure too. At the moment I doubt it's a problem in the
> > common code of my tree or mainline.
> seems it's a problem in the umount-against-unused-dirty-inodes-race fix or if 
> the fix "is the right way" the problem is located somewhere else what 
> triggers the problem of your patch.

can you reproduce in 2.4.20aa1 too?

Andrea
