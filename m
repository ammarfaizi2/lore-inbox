Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbSLCKGY>; Tue, 3 Dec 2002 05:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266191AbSLCKGY>; Tue, 3 Dec 2002 05:06:24 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:21192 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266186AbSLCKGX> convert rfc822-to-8bit; Tue, 3 Dec 2002 05:06:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Exaggerated swap usage
Date: Tue, 3 Dec 2002 11:13:22 +0100
User-Agent: KMail/1.4.3
References: <200212030059.32018.m.c.p@wolk-project.de> <20021203005939.GF28164@dualathlon.random>
In-Reply-To: <20021203005939.GF28164@dualathlon.random>
Cc: linux-kernel@vger.kernel.org, Andrew Clayton <andrew@sol-1.demon.co.uk>,
       Javier Marcet <jmarcet@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212031112.14635.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 December 2002 01:59, you wrote:

Hi Andrea,

> this is the interesting one. Did you run any unstable kernel/driver
> software combination recently or maybe you got oopsed or crashes?
nope, no oops, no crash, afaik no unstable kernel/drivers. Kernel is yours ;) 
and drivers, hmm, just intel i815, eepro100. That happend after some hours of 
uptime and just doing "rm -rf linux-old"

> journaling sometime gives a false sense of reliability, you've to keep
> in mind that unless you know why you had to reboot w/o a clean unmount
> you should always force an e2fsck -f/reiserfsck in single user mode at
> the next boot, no matter of journaling. If the machine crashed because
Yep, I always do a forced fsck in case of that.

> of a kernel oops or similar skipping the filesystemcheck at the very
> next boot could left the fs corrupted for a long time until you notice
> it possibly while running an unrelated kernel. So if you crashed
> recently and you didn't run any e2fsck -f that could explain it. I doubt
I run e2fsck -fy every time after a crash. Fortunately it doesn't happen so 
often :-)

> ...
> don't know the details of the bug at the time of the next reboot so
> normally an e2fsck -f is always required after a kernel crash, this
> can't be automated simply because if the kernel is crashed we can't
> write to the superblock to notify e2fsck about it, so at the next boot
> e2fsck will always think replying the log was enough).
yep. I tried to remove that 00_umount-against-unused-dirty-inodes-race fix and 
after that (now 5 hours uptime) doing only copying and deleting, that ext3fs 
error is away.

> Of course your problem could be explained by a bad cable or whatever
> else hardware failure too. At the moment I doubt it's a problem in the
> common code of my tree or mainline.
seems it's a problem in the umount-against-unused-dirty-inodes-race fix or if 
the fix "is the right way" the problem is located somewhere else what 
triggers the problem of your patch.

ciao, Marc


