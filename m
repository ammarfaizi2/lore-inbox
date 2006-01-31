Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWAaQe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWAaQe3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWAaQe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:34:28 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:48801 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751079AbWAaQe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:34:27 -0500
Date: Tue, 31 Jan 2006 11:34:25 -0500
To: Al Boldi <a1426z@gawab.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Bryan Henderson <hbryan@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <20060131163425.GD18972@csclub.uwaterloo.ca>
References: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com> <200601301621.24051.a1426z@gawab.com> <8F530CA8-1AC8-4AE5-8F1E-DC6518BD7D42@mac.com> <200601311856.17569.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601311856.17569.a1426z@gawab.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 06:56:17PM +0300, Al Boldi wrote:
> Faulty, because we are currently running a legacy solution to workaround an 
> 8,16,(32) arch bits address space limitation, which does not exist in 
> 64bits+ archs for most purposes.
> 
> Trying to defend the current way would be similar to rejecting the move from 
> 16bit to 32bit. Do you remember that time?  One of the arguments used was:  
> the current way works pretty well so far.
> 
> The advice here would be:  wake up and smell the coffee.
> 
> There is a lot to gain, for one there is no more swapping w/ all its related 
> side-effects.  You're dealing with memory only.  You can also run your fs 
> inside memory, like tmpfs, which is definitely faster.  And there may be 
> lots of other advantages, due to the simplified architecture applied.

Of course there is swapping.  The cpu only executes thigns from physical
memory, so at some point you have to load stuff from disk to physical
memory.  That seems amazingly much like the definition of swapping too.
Sometimes you call it loading.  Not much difference really.  If
something else is occupying physical memory so there isn't room, it has
to be put somewhere, which if it is just caching some physical disk
space, you just dump it, but if it is some giant chunk of data you are
currently generating, then it needs to go to some other place that
handles temporary data that doesn't already have a palce in the
filesystem.  Unless you have infinite physical memory, at some point you
will have to move temporary data from physical memory to somewhere else.
That is swapping no matter how you view the system's address space.
Making it be called something else doesn't change the facts.
Applications don't currently care if they are swapped to disk or in
physical memory.  That is handled by the OS and is transparent to the
application.

> If you didn't understand it's meaning.  The shortest path meaning accessing 
> hw w/o running workarounds; using 64bits+ to fly over past limitations.

THe OS still has to map the address space to where it physically exists.
Mapping all disk space into the address space may actually be a lot less
efficient than using the filesystem interface for a block device.

> Uhh?
> The point here is: Even if there were 64bit archs available in the past, this 
> did not mean that moving into native 64bits would be commercially viable, 
> due to its unavailability on the mass-market.
> 
> So with 64bits widely available now, and to let Linux spread its wings and 
> really fly, how could tmpfs merged w/ swap be tweaked to provide direct 
> mapped access into this linear address space?

Applications can mmap files if they want to.  Your idea seems likely to
make the OS much more complex, and waste a lot of resources on mapping
disk space to the address space, and from the applications point of view
it doesn't seem to make any difference at all.  It might be a fun idea
for some academic research OS somewhere to go work out the kinks and see
if it has any efficiency at all in real use.  Given Linux runs on lots
of architectures, trying to make it work completely differently on 64bit
systems doesn't make that much sense really, especially when there is no
apparent benefit to the change.

Len Sorensen
