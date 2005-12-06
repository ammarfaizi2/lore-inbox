Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVLFMS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVLFMS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVLFMS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:18:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:402 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964969AbVLFMSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:18:55 -0500
Date: Tue, 6 Dec 2005 13:18:35 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051206121835.GN1770@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams> <200512052328.01999.rjw@sisk.pl> <1133832773.6360.38.camel@localhost> <20051206020626.GO22168@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206020626.GO22168@hexapodia.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Newer kernels write and read a bigger image, which makes the prompt show
> up somewhat later, but gives the benefit of putting me back in
> approximately the same place I left off with regards to working set.
> 
> I would like the best of both worlds - I want my suspend to go faster
> (so I want a smaller image), and I also want my working set paged back
> in after resume.
> 
> I'm assuming that the difference is that with Rafael's patches, clean
> pages that would have been evicted in the "freeing pages..." step are
> now being written out to the swsusp image.  If so, this is a waste - no
> point in having the data on disk twice.  (It would be nice to confirm
> this suspicion.)

Confirmed. But you are wrong; it is not a waste. The pages are nicely
linear in suspend image, while they would be all over the disk
otherwise. There can easily be factor 20 difference between linear
read and random read.

> Could we rework it to avoid writing clean pages out to the swsusp image,
> but keep a list of those pages and read them back in *after* having
> resumed?  Maybe do the /dev/initrd ('less +/once Documentation/initrd.txt'
> if you're not familiar with it) trick to make the list of pages available 
> to a userland helper.

I did not understand this one.

> Someone suggested the 'cat `grep / /proc/*/maps`' trick.  This kills the
> working set calculations that the kernel has so painstakingly built up,
> reading in all kinds of pages that were flushed with good reason, and
> also fails to get my Mercurial .d files back into cache, since they are
> not mapped by any long-running process.

Yes, that was very rough approximation.

Anyway, try limiting size of image to ~500MB, first. Should solve your
problem with very little work.
									Pavel
-- 
Thanks, Sharp!
