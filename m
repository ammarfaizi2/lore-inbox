Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265819AbSLCAwY>; Mon, 2 Dec 2002 19:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSLCAwY>; Mon, 2 Dec 2002 19:52:24 -0500
Received: from [195.223.140.107] ([195.223.140.107]:16815 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265819AbSLCAwX>;
	Mon, 2 Dec 2002 19:52:23 -0500
Date: Tue, 3 Dec 2002 01:59:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Andrew Clayton <andrew@sol-1.demon.co.uk>,
       Javier Marcet <jmarcet@pobox.com>
Subject: Re: Exaggerated swap usage
Message-ID: <20021203005939.GF28164@dualathlon.random>
References: <200212030059.32018.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212030059.32018.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 12:59:32AM +0100, Marc-Christian Petersen wrote:
> ext3_free_blocks: Freeing blocks not in datazone - block = 1530182

this is the interesting one. Did you run any unstable kernel/driver
software combination recently or maybe you got oopsed or crashes?

journaling sometime gives a false sense of reliability, you've to keep
in mind that unless you know why you had to reboot w/o a clean unmount
you should always force an e2fsck -f/reiserfsck in single user mode at
the next boot, no matter of journaling. If the machine crashed because
of a kernel oops or similar skipping the filesystemcheck at the very
next boot could left the fs corrupted for a long time until you notice
it possibly while running an unrelated kernel. So if you crashed
recently and you didn't run any e2fsck -f that could explain it. I doubt
there are corruption issues in my current tree (and even the UP deadlock
that I fixed couldn't explain the corruption, in this case [the UP
deadlock] I'm sure because I know what kind of side effect _this_ bug could
generate, for any other crash you cannot tell if e2fsck -f is needed
until/unless you know the details of the bug, and most of the time you
don't know the details of the bug at the time of the next reboot so
normally an e2fsck -f is always required after a kernel crash, this
can't be automated simply because if the kernel is crashed we can't
write to the superblock to notify e2fsck about it, so at the next boot
e2fsck will always think replying the log was enough).

Of course your problem could be explained by a bad cable or whatever
else hardware failure too. At the moment I doubt it's a problem in the
common code of my tree or mainline.

Andrea
