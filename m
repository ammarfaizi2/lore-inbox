Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbULHGxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbULHGxv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 01:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbULHGxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 01:53:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26522 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261999AbULHGwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 01:52:54 -0500
Date: Wed, 8 Dec 2004 07:52:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208065200.GE3035@suse.de>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site> <20041208013732.GF16322@dualathlon.random> <1102470428.8095.29.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102470428.8095.29.camel@npiggin-nld.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08 2004, Nick Piggin wrote:
> > it gets fixed the benefit of "as" on the desktop will as well decrease
> > compared to cfq. The desktop is ok with "as" simply because it's
> > normally optimal to stop writes completely, since there are few apps
> > doing write journaling or heavy writes, and there's normally no
> > contigous read happening in the background. Desktop just needs a
> > temporary peak read max bandwidth when you click on openoffice or
> > similar app (and "as" provides it). But on a mixed server doing some
> > significant read and write (i.e.  somebody downloading the kernel from
> > kernel.org and installing it on some application server) I don't think
> > "as" is general purpose enough. Another example is the multiuser usage
> > with one user reading a big mbox folder in mutt, whole the other user
> > s exiting mutt at the same time. The one exiting will pratically have to
> > wait the first user to finish its read I/O. All I/O becomes sync when it
> > exceeds the max size of the writeback cache.
> > 
> 
> AS is surprisingly good when doing concurrent reads and buffered writes.
> The buffered writes don't get starved too badly. Basically, AS just
> ensures a reader will get the chance to play out its entire read batch
> before switching to another reader or a writer.

AS doesn't give a lot of bandwidth to the writes, about 10-20% only.
Tiem sliced cfq is more fair, you get closer to 50/50 in that case.

> Buffered writes don't suffer the same problem obviously because the
> disk can can easily be kept fed from cache. Any read vs buffered write
> starvation you see will mainly be due to the /sys tunables that give
> more priority to reads (which isn't a bad idea, generally).

Depends entirely on the work load, I don't think you can say something
like that in generel. For a desktop load, sure.

> > "as" is clearly the best for the common case of the very desktop usage
> > (i.e. machine 99.9% idle and without any I/O except when starting an app
> > or saving a file, and the user noticing delay only while waiting the
> > window to open up after he clicked the button).  But I believe cfq is
> > better for a general purpose usage where we cannot assume how the kernel
> > will be used.
> 
> Maybe. CFQ may be a bit closer to a traditional elevator behaviour,
> while AS uses some significantly different concepts which I guess
> aren't as well tested and optimised for.

You should read the new cfq code, there's isn't that much difference
when it comes to the plain act of ordering io or finding the next
request (I stole some code :-).

The data direction batching that AS does I don't see the point of.

-- 
Jens Axboe

