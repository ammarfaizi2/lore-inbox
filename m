Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267568AbUG3Br1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267568AbUG3Br1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 21:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUG3Br1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 21:47:27 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:41128 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S267568AbUG3BrX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 21:47:23 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crash(s)?
Date: Thu, 29 Jul 2004 21:47:21 -0400
User-Agent: KMail/1.6.82
Cc: "Randy.Dunlap" <rddunlap@osdl.org>
References: <200407242156.40726.gene.heskett@verizon.net> <200407291822.47209.gene.heskett@verizon.net> <20040729151415.094c8d01.rddunlap@osdl.org>
In-Reply-To: <20040729151415.094c8d01.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407292147.21463.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [141.153.90.166] at Thu, 29 Jul 2004 20:47:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 July 2004 18:14, Randy.Dunlap wrote:
[...]
I've gone clear back to a 2.6.7 kernel because thats the newest one 
that has a diff when cmp'ing fs/dcache.c files to whats in 2.6.8-rc2.

I've had one Oops, virtually the same one, but it didn't kill the 
machine like it would have if I was running 2.6.8-rc2.
>| >and
>| >make path/to/<file containing prune_dcache>.s
>|
>| But this ones still being difficult.  Make does want to generate
>| it. At best it claims that dcache.o is uptodate. I don't figure
>| one file is worth much without the other, so whats wrong with my
>| syntax? [root@coyote fs]# make dcache.c>.s
>| [root@coyote fs]# less .s
>| Which contains "make: Nothing to be done for `dcache.c'."
>
>This should be (without < > brackets):
>
>make fs/dcache.s

Aha!  Voila!! It doesn't work in the "fs" subdir, but back out to the 
top of the src tree and it works just fine.  Duh...

Now, I must confess that what I'm looking at in those two files is 
the .s is the source assembly that would normally be fed to gas, and 
the objdump'ed version is the dissed object translated back to gas 
source.  If no mistakes, they should be pretty close to the same I'd 
think.  Am I on the right track?  Or full of it?

Here's the theory thats gradually formed in whats left of my mind:
--------------
5 things changed in the kernel soft when I changed the mobo.
1. The ide driver, from via686a to the nforce2 version.
2. The video driver, because the old card failed and took the mobo 
with it.
3. Ethernet driver is now forcedeth instead of rtl-8139too
4. A different alsa driver, from via8233 to intel-8x0
5. The 4Gb switch is turned on in the kernel now as theres a gig of 
ram on this board.
--------------

I can't do anything about the first 2, but I can do without the last 
200 megs of ram long enough to test that, and I can switch back to 
the rtl-8139too card for ethernet, and I can turn off alsasound.

In the meantime I turned a bunch of stuff the logs were complaining 
about off, like sgi_fam (what the heck is that?), some ups daemons 
for brands I don't have, that sort of thing, and have a tail running 
on the log.  So far, its clean since the restart of xinetd.  Another 
16 hours will tell most of the tale for this particular instant 
configuration.

One final question if I may:  What do I turn off (or on) in the video 
dept of the kernel so that my screen doesn't go black after vmlinuz 
is unpacked, and not come back on till "init" is run, at which point 
the screen comes back on in what looks to be exactly the same mode?

Anything that goes on in that time period must be read 
from /var/log/dmesg later if I want to see it.

>--
>~Randy

-- 
Cheers Randy, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
