Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVLTA21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVLTA21 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 19:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVLTA21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 19:28:27 -0500
Received: from waste.org ([64.81.244.121]:37540 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750714AbVLTA21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 19:28:27 -0500
Date: Mon, 19 Dec 2005 18:27:59 -0600
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Light-weight dynamically extended stacks
Message-ID: <20051220002759.GE3356@waste.org>
References: <20051219001249.GD11856@waste.org> <20051219183604.GT23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219183604.GT23349@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 07:36:04PM +0100, Adrian Bunk wrote:
> On Sun, Dec 18, 2005 at 04:12:49PM -0800, Matt Mackall wrote:
> 
> > Perhaps the time for this has come and gone, but it occurred to me
> > that it should be relatively straightforward to make a form of
> > dynamically extended stacks that are appropriate to the kernel.
> > 
> > While we have a good handle on most of the worst stack offenders, we
> > can still run into trouble with pathological cases (say, symlink
> > recursion for XFS on a RAID built from loopback mounts over NFS
> > tunneled over IPSEC through GRE). So there's probably no
> > one-size-fits-all when it comes to stack size.
> 
> My count of bug reports for problems with in-kernel code with 4k stacks 
> after Neil's patch went into -mm is still at 0. That's amazing 
> considering how many people have claimed in this thread how unstable
> 4k stacks were...

I should have said up front that I don't know of any remaining
problems with 4k stacks and support switching to them. Remember, I
dusted off the 4k stack code, cleaned it up, and fixed up some of the
worst offenders in my -tiny tree well before Arjan pushed it to
mainline.

So why am I raising this idea now at all? Because I think Neil's patch
is too clever and too specific to block layer stacking and I'd rather
have a more general solution. Block is by no means the only part of
the system that allows nesting and pathological combinations surely
still exist. And will be introduced in the future.

Also note that my approach might make it reasonable to use one-page
stacks everywhere, not just on x86.

> If more than 3 kB of stack is used on i386 that's a bug.
> And we should fix bugs, not work around them.

One man's fix is another man's work-around.

-- 
Mathematics is the supreme nostalgia of our time.
