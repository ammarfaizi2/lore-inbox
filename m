Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbVKBS2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVKBS2m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbVKBS2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:28:42 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:34463 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965168AbVKBS2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:28:42 -0500
Date: Wed, 2 Nov 2005 10:28:34 -0800
From: Paul Jackson <pj@sgi.com>
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: rdunlap@xenotime.net, linux-kernel@vger.kernel.org, Simon.Derr@bull.net,
       Sylvain.Jeaugey@bull.net
Subject: Re: cpuset - question
Message-Id: <20051102102834.0a038576.pj@sgi.com>
In-Reply-To: <6278d2220511020935g6f88d15bp5f1e3bc692c55fe8@mail.gmail.com>
References: <6278d2220511020236l26f74eecp11910e59fd1c432d@mail.gmail.com>
	<Pine.LNX.4.58.0511020825450.6456@shark.he.net>
	<6278d2220511020935g6f88d15bp5f1e3bc692c55fe8@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy asked:
> Just for info, why is this in /dev at all, instead of, say,
> /sys ??

Daniel added:
> I'm not sure of the true answer; it is likely that CPUSETS was
> designed in the 2.4 timeframe and compatibility was preferred over the
> clean sysfs interface.

No .. cpusets was a fresh design for Linux 2.6.  The two primary
authors were Simon Derr of Bull and myself of SGI.  So far as I
know, Bull did not have Linux 2.4 precedents.  SGI had both Linux
2.4 precedents and Irix precedents.  I chose not to propose either
of these SGI precedent API's for the Linux mainline kernel.

Simon proposed the primary interface for the /dev/cpuset, and I gladly
joined him as his design was superior.  Simon had this file system
mounted under /proc, and Christoph Hellwig (our primary reviewer -
thanks!) objected, recommending /dev/cpuset as the mount point instead.

In Christoph's own words on May 13, 2004:

 - don't mount the filesystem in procfs.  the whole point of a new
   fs is to move away from the procfs mess!  /dev/cpuset/ sounds like
   a saner mtpnt.

In any case, there are two aspects to this question.  Should the
cpuset hierarchy be a separate virtual file system of its own, or part
of the sysfs file system?  Then, if it is separate, where should it
be mounted.

The separate file system for the cpuset hierarchy has been a
clear success, in my (no doubt biased) view.  It has its own rules
appropriate for the hierarchical cpu and node sets it is managing.
Even if we were starting this work now, I would enthusiastically
advocate having it as its own, separate file system.

Given that, the mount point becomes rather secondary in my view.

Christoph's proposal of /dev/cpuset, still seems reasonable and
adequate today.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
