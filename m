Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTIWXbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 19:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTIWXbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 19:31:21 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:28678 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262028AbTIWXbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 19:31:19 -0400
Date: Wed, 24 Sep 2003 01:29:59 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923232959.GA9734@alpha.home.local>
References: <20030922194833.GA2732@velociraptor.random> <20030923042855.GF589@alpha.home.local> <20030923124951.GB23111@velociraptor.random> <20030923140647.GB3113@alpha.home.local> <20030923144435.GC23111@velociraptor.random> <3F706046.1000306@euronext.nl> <20030923160600.GA4161@alpha.home.local> <20030923162319.GA1269@velociraptor.random> <20030923190219.GA5997@alpha.home.local> <20030923223457.GA16314@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923223457.GA16314@velociraptor.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 12:34:57AM +0200, Andrea Arcangeli wrote:
 
> I know your patch was just very good for many people, but not for
> everyone. I really didn't want to say your patch didn't make any good,
> I acknowledge it was just very good.

It's not about it to be good or not, but be useful. There's a difference.
When two things are good and do nearly the same, you get the best of them and
that's all. When two things are useful and nearly identical, there's a huge
potential that one is useful to some people, and the other one to other people.
I'm certain I would use your patch on my desktop PC (if it doesn't break
kmsgdump as it seems, though), because it will allow me to easily extend my
log buffer when I get repetitive oopses. But most probably not on remote
systems.

> I definitely agree my patch (btw, I posted the last one that had a few
> bugs too) needs fixing to release the 64k of ram, and to allow a smaller
> bufsize too (the latter will happen automatically while addressing the
> former)

That doesn't matter, I'm fairly certain you will fix these issues, they are
details since the patch is at its early stage.

> The fact you don't want to touch the lilo.conf doesn't sound to me.
> Especially with lilo (not grub) you've to run lilo anyways every time
> you replace the kernel, so a simple script adding the parameter in every
> lilo.conf sounds very easy to provide (you can add it in all kernels,
> the old ones will ignore it).

Yes it's the real reason, and I think that others will second me on this one.
You're seeing the benefit of *changing* the value on a kernel compile once.
I see the benefit of *deploying* a same kernel to a lot of remote hosts while
touching the fewest possible files. Sending a pre-configured kernel and running
lilo is already a lot.

I've had private discussions off-list with a few other people who don't agree
on the *obligation* to enter a new option on the command line because they will
not be able to dynamically generate their boot files anymore and will have to
add a config option to them just for this. Believe me, when you remotely and
blindly upgrade systems with commands such as : 

   for host in to_update/*; do update $host && mv $host up_to_date/ ; done

*not* having to touch a boot file is really recomforting. It's not funny 
to remotely run 'ed' scripts on lilo.conf when you know that there's 
nobody to replace the box if you fail because one of the file had once been
hand-edited and is slightly different. May be you'll say "well, simply prepare
all your lilo.conf, check them all then send them". If you think this, it's
because you obviously never felt your heart accelerate and beat very loud
during these operations and cannot understand why some people prefer to keep
these delicate upgrades as trivial as possible. When I said to you that I use
root=/dev/root and boot=/dev/mbr on all these hosts, it's exactly not to have
to touch these sensible files.

One of us told me that he will have to rebuild his BASE package just to
integrate this change, and deploy it to 1200 hosts around the world. When I see
how I worry for a few tens, I think he'd better revert your patch and stay on
the previous one. Think that some of these people are still running 2.2 because
they don't trust 2.4 enough to risk a remote upgrade.

Andrea, I won't blame you for not understanding that some people are afraid of
doing certain operations remotely. Perhaps you'll think that I'm totally
stupid. That's not a problem for me. I just wanted to let you know that this
sort of changes will be a regression for a few of us (mainly the few who've
been using the previous patch).

As I told you the first time, if I had the choice for a dynamic buffer
resizement, I'd be all for a sysctl so that I wouldn't need to touch any boot
file, and that would allow to resize a live system without needing a reboot.
Then, simply pre-initialize a 64kB buffer so that no boot message gets lost,
and the init scripts adjust the size to what is needed.

I repeat my proposal. I agree to spend a few of my time to work with you in
this direction, because I know it is a useful feature. But please don't make
it more difficult for people who already have a hard time.

Thanks,
Willy

