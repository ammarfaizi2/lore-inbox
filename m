Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbVKBSsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbVKBSsY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbVKBSsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:48:24 -0500
Received: from xenotime.net ([66.160.160.81]:47246 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965174AbVKBSsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:48:23 -0500
Date: Wed, 2 Nov 2005 10:48:18 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Paul Jackson <pj@sgi.com>
cc: Daniel J Blueman <daniel.blueman@gmail.com>, rdunlap@xenotime.net,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net,
       Sylvain.Jeaugey@bull.net, hch@infradead.org
Subject: Re: cpuset - question
In-Reply-To: <20051102102834.0a038576.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0511021033210.6456@shark.he.net>
References: <6278d2220511020236l26f74eecp11910e59fd1c432d@mail.gmail.com>
 <Pine.LNX.4.58.0511020825450.6456@shark.he.net>
 <6278d2220511020935g6f88d15bp5f1e3bc692c55fe8@mail.gmail.com>
 <20051102102834.0a038576.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Paul Jackson wrote:

> Randy asked:
> > Just for info, why is this in /dev at all, instead of, say,
> > /sys ??
>
> Daniel added:
> > I'm not sure of the true answer; it is likely that CPUSETS was
> > designed in the 2.4 timeframe and compatibility was preferred over the
> > clean sysfs interface.
>
> No .. cpusets was a fresh design for Linux 2.6.  The two primary
> authors were Simon Derr of Bull and myself of SGI.  So far as I
> know, Bull did not have Linux 2.4 precedents.  SGI had both Linux
> 2.4 precedents and Irix precedents.  I chose not to propose either
> of these SGI precedent API's for the Linux mainline kernel.
>
> Simon proposed the primary interface for the /dev/cpuset, and I gladly
> joined him as his design was superior.  Simon had this file system
> mounted under /proc, and Christoph Hellwig (our primary reviewer -
> thanks!) objected, recommending /dev/cpuset as the mount point instead.
>
> In Christoph's own words on May 13, 2004:
>
>  - don't mount the filesystem in procfs.  the whole point of a new
>    fs is to move away from the procfs mess!  /dev/cpuset/ sounds like
>    a saner mtpnt.
>
> In any case, there are two aspects to this question.  Should the
> cpuset hierarchy be a separate virtual file system of its own, or part
> of the sysfs file system?  Then, if it is separate, where should it
> be mounted.

OK.  My question was intended more to say "why /dev ?".
I don't mind cpusets using its own mini-fs.

> The separate file system for the cpuset hierarchy has been a
> clear success, in my (no doubt biased) view.  It has its own rules
> appropriate for the hierarchical cpu and node sets it is managing.
> Even if we were starting this work now, I would enthusiastically
> advocate having it as its own, separate file system.

OK, no problem.

> Given that, the mount point becomes rather secondary in my view.
>
> Christoph's proposal of /dev/cpuset, still seems reasonable and
> adequate today.

I guess it's too late to care about FHS?

Apparently FHS needs to be updated to know about /sys and other
virtual filesystems (other than /proc, which it knows about).
However, using /dev for a virtual fs location makes no sense
to me.  /dev is defined as a place for device (or "special")
files.  Nothing about virtual filesystems (unless we want to
call virtual filesystems "special files," but I think that
"special" in this sense has its own special meaning).

Anyway, we seem to be in a mode of less general review until
after the fact (the merge) instead of when it should happen
(except for Andrew) and more adding features.
And Yes, I'm in that boat too.  I try, but there aren't
enough hours in a day (and I don't want more hours/day).

Thanks for the explanation & history.

-- 
~Randy
