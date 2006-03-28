Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWC1HQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWC1HQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 02:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWC1HQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 02:16:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751178AbWC1HQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 02:16:35 -0500
Date: Mon, 27 Mar 2006 23:16:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: adrian@smop.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1 leaks in dvb playback
Message-Id: <20060327231630.76e97b83.akpm@osdl.org>
In-Reply-To: <20060328070220.GA29429@smop.co.uk>
References: <20060326211514.GA19287@wyvern.smop.co.uk>
	<20060327172356.7d4923d2.akpm@osdl.org>
	<20060328070220.GA29429@smop.co.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adrian <adrian@smop.co.uk> wrote:
>
> On Mon, Mar 27, 2006 at 17:23:56 -0800 (-0800), Andrew Morton wrote:
> > 
> > Do you mean that the problem has been present in -mm kernels since the
> > 2.6.14/15 timeframe, and not in mainline?
> 
> Correct.
> 
> > Strange.  Are you sure that they really leak?  Doing
> > 
> > 	echo 3 > /proc/sys/vm/drop_caches
> > 
> > doesn't make them go away?
> 
> dentry_cache drops a little bit, but the vast majority stays.
> sock_inode_cache I didn't notice drop.  If I don't reboot every
> 15/20mins the machine suddenly starts thrashing like mad and then
> effectively locks up :-(
> 
> Last night I tried reverting the dvb-core ringbuffer part of -mm1 and
> that didn't seem to help at all.  
> 
> I've just tried 2.6.16 with just the origin.patch from -mm1 and that
> has the same leak in it.   So it looks like I should have spotted this
> earlier before it was pushed into 2.6.16+  Just double checked and
> in 2.5.16 sock_inode_cache isn't even on the slabtop screen.
>
> I suppose that leads to a new question - what's the easiest way to
> start to break down origin.patch and do you know of any likely
> culprits?  I see Andi Kleen has seen dentry_cache leaking on x86_64
> (this machine is x86(_32) uni processor. 
> 

It's unlikely that the sock_inode_cache leak is related to the dcache leak,
but we won't know until we know...

As for breaking down origin.patch: that's all in Linus's tree now, so
git-bisect is the way to do that.

As for a culprit: don't know, sorry.  I'd be surprised if there were _any_
patches which were in 2.6.14-mmX all the way through to 2.6.16-rc6-mmx and
which suddenly got merged into 2.6.16-git.  Maybe someone was sitting on
something for that long in one of the git trees, but I'd be surprised.
