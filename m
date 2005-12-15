Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVLOQ01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVLOQ01 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVLOQ01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:26:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36541 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750797AbVLOQ00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:26:26 -0500
Date: Thu, 15 Dec 2005 17:26:01 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de,
       Sridhar Samudrala <sri@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/6] Critical Page Pool
Message-ID: <20051215162601.GJ2904@elf.ucw.cz>
References: <439FCECA.3060909@us.ibm.com> <20051214100841.GA18381@elf.ucw.cz> <43A0406C.8020108@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A0406C.8020108@us.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I don't see how this can ever work.
> > 
> > How can _userspace_ know about what allocations are critical to the
> > kernel?!
> 
> Well, it isn't userspace that is determining *which* allocations are
> critical to the kernel.  That is statically determined at compile time by
> using the flag __GFP_CRITICAL on specific *kernel* allocations.  Sridhar,
> cc'd on this mail, has a set of patches that sprinkle the __GFP_CRITICAL
> flag throughout the networking code to take advantage of this pool.
> Userspace is in charge of determining *when* we're in an emergency
> situation, and should thus use the critical pool, but not *which*

It still is not too reliable. If you userspace tool is swapped out
(etc), it may not get chance to wake up.

> > And as you noticed, it does not work for your original usage case,
> > because reserved memory pool would have to be "sum of all network
> > interface bandwidths * ammount of time expected to survive without
> > network" which is way too much.
> 
> Well, I never suggested it didn't work for my original usage case.  The
> discussion we had is that it would be incredibly difficult to 100%
> iron-clad guarantee that the pool would NEVER run out of pages.  But we can
> size the pool, especially given a decent workload approximation, so as to
> make failure far less likely.

Perhaps you should add file in Documentation/ explaining it is not
reliable?

> > If you want few emergency pages for some strange hack you are doing
> > (swapping over network?), just put swap into ramdisk and swapon() it
> > when you are in emergency, or use memory hotplug and plug few more
> > gigabytes into your machine. But don't go introducing infrastructure
> > that _can't_ be used right.
> 
> Well, that's basically the point of posting these patches as an RFC.  I'm
> not quite so delusional as to think they're going to get picked up right
> now.  I was, however, hoping for feedback to figure out how to design
> infrastructure that *can* be used right, as well as trying to find other
> potential users of such a feature.

Well, we don't usually take infrastructure that has no in-kernel
users, and example user would indeed be nice.
							Pavel
-- 
Thanks, Sharp!
