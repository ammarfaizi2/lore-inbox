Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWBOUMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWBOUMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWBOUMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:12:43 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:23301 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751050AbWBOUMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:12:43 -0500
Date: Wed, 15 Feb 2006 21:11:43 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Yoss <bartek@milc.com.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.4.33-pre1?
Message-ID: <20060215201143.GL11380@w.ods.org>
References: <20060213214651.GA27844@milc.com.pl> <20060214000529.GJ11380@w.ods.org> <20060214082136.GA9993@milc.com.pl> <20060214214349.GA298@w.ods.org> <20060215090130.GA3343@milc.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215090130.GA3343@milc.com.pl>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
On Wed, Feb 15, 2006 at 10:01:30AM +0100, Yoss wrote:
 								 
> > Have you noticed the difference ? So the memory is not wasted at all. It's
> > just reported as 'used'.
> 
> I see. I also noticed that I simply cannot tell what for is this memory
> used. Is this better for me to enlarge cache_mem in squid for about
> 100MB and have less *_cache or is better to have more *_cache? :)

If squid is the main usage of your server, then I guess it should be better
to reserve some memory for it by increasing its cache_mem instead of seeing
this memory wasted as cache for useless files.

> > > > If you don't believe me, simply allocate 1 GB in a process, then free it.
> > > If that what you said is rigth, day after tomorow I'll have the same
> > > situation - only thing I have changed is kernel. So we'll see. :)
> > 
> > If you encounter it, simply run the tool below with a size in kB. Warning!
> > a wrong parameter associated with improper ulimit will hang your system !
> > Ask it to allocate what you *know* you can free (eg: the swapfree space).
> 
> I don't matter is this memory used for cache or free. I just want to be
> sure that it is not leaking :)

I don't remember when "standard" 2.4 was last seen leaking. By "standard",
I mean without fancy drivers and filesystems. For instance, look at my
outgoing dns+mail+http relay (pentium 133 + 96 MB RAM) :

ns# uptime
  9:05pm  up 466 days, 15:10,  1 user,  load average: 0.04, 0.01, 0.00
          ^^^^^^^^^^^
ns# free
             total       used       free     shared    buffers     cached
Mem:         94180      91820       2360          0      11080       5700
-/+ buffers/cache:      75040      19140
Swap:       524656      27108     497548
ns# uname -rv
2.4.18-wt4 #1 Mon Apr 1 13:57:42 CEST 2002
^^^^^^                                ^^^^
Last built in 2002, nearly 4 years ago. After 466 days uptime, I suspect
I would have noticed it if there were such important leaking ;-)

> Bart?omiej Butyn aka Yoss
> Nie ma tego z?ego co by na gorsze nie wysz?o.

Cheers,
Willy

