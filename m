Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbULES6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbULES6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 13:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbULES6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 13:58:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39628 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261362AbULES6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 13:58:46 -0500
Date: Sun, 5 Dec 2004 19:58:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced CFQ #2
Message-ID: <20041205185844.GF6430@suse.de>
References: <20041204104921.GC10449@suse.de> <20041204163948.GA20486@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041204163948.GA20486@optonline.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04 2004, Jeff Sipek wrote:
> On Sat, Dec 04, 2004 at 11:49:21AM +0100, Jens Axboe wrote:
> > Hi,
> > 
> > Second version of the time sliced CFQ. Changes:
> > 
> > - Sync io has a fixed time slice like before, async io has both a time
> >   based and a request based slice limit. The queue slice is expired when
> >   one of these limits are reached.
> > 
> > - Fix a bug in invoking the request handler on a plugged queue.
> > 
> > - Drop the ->alloc_limit wakeup stuff, I'm not so sure it's a good idea
> >   and there are probably wakeup races buried there.
> > 
> > With the async rq slice limit, it behaves perfectly here for me with
> > readers competing with async writers. The main slice settings for a
> > queue are:
> > 
> > - slice_sync: How many msec a sync disk slice lasts
> > - slice_idle: How long a sync slice is allowed to idle
> > - slice_async: How many msec an async disk slice lasts
> > - slice_async_rq: How many requests an async disk slice lasts
> 
> This looks very nice. And from your previous post (with version #1) it
> would look like you made my attempt at io priorities easier. We'll see
> ;-)

It should be really easy to try some rudimentary prio io support - just
scale the time slice based on process priority. A few lines of code
change, and io priority now follows process cpu scheduler priority. To
work really well, the code probably needs a few more limits besides just
slice time.

-- 
Jens Axboe

