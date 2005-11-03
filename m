Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVKCIUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVKCIUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 03:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVKCIUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 03:20:32 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:26550 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750814AbVKCIUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 03:20:31 -0500
Date: Thu, 3 Nov 2005 09:20:14 +0100 (CET)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Paul Jackson <pj@sgi.com>
Cc: Daniel J Blueman <daniel.blueman@gmail.com>, rdunlap@xenotime.net,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net,
       Sylvain.Jeaugey@bull.net
Subject: Re: cpuset - question
In-Reply-To: <20051102102834.0a038576.pj@sgi.com>
Message-ID: <Pine.LNX.4.61.0511030915030.11189@openx3.frec.bull.fr>
References: <6278d2220511020236l26f74eecp11910e59fd1c432d@mail.gmail.com>
 <Pine.LNX.4.58.0511020825450.6456@shark.he.net>
 <6278d2220511020935g6f88d15bp5f1e3bc692c55fe8@mail.gmail.com>
 <20051102102834.0a038576.pj@sgi.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 03/11/2005 09:34:29,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 03/11/2005 09:34:32,
	Serialize complete at 03/11/2005 09:34:32
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
> 

There were also a few technical reasons.

The first was the desire to create cpusets with 'mkdir my_cpuset'.
But this was not a sufficient reason to have a new filesystem, so after my 
first version of the cpuset patch I reworked it to use sysfs.

However then I ran into a wall: sysfs does not support files larger than a 
page. And this was a showstopper as the size of the `tasks' file can be 
large.

So I had to drop sysfs.

	Simon.

