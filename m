Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263712AbUDZCbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263712AbUDZCbp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 22:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUDZCbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 22:31:45 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:35731 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263712AbUDZCbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 22:31:42 -0400
Date: Mon, 26 Apr 2004 12:30:51 +1000
From: CaT <cat@zip.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm4 tmpfs, free and free memory reporting
Message-ID: <20040426023051.GD2011@zip.com.au>
References: <20040425130338.GB2011@zip.com.au> <Pine.LNX.4.44.0404251737200.13626-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404251737200.13626-100000@localhost.localdomain>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2004 at 05:50:58PM +0100, Hugh Dickins wrote:
> On Sun, 25 Apr 2004, CaT wrote:
> > I noticed that the OoM killer was being rather brutal to my tasks
> > even though free was reporting that I had 150meg of ram left. It wasn't
> > until much later that I realise that I have tmpfs being used as /tmp
> > and I checked that. Once I cleaned that up a big all was well. The
> > hassle was, the memory used by tmpfs was being reported as being used
> > by the cache. That may be so internally but shouldn't it be reported
> > as actually used ram as it cannot be dumped for processes like a normal
> > disk cache can and therefore cannot be considered to be 'free' ram.
> 
> If you have swap enabled (do you?) then tmpfs pages get written out

Not this time. I had written that in in the first version of the email
but then scrapped that and rewrote and forgot to put it in.

Basically the complaint was that tmpfs was being registered in cached
memory but it wasn't really cache. Now that I'm a bit more awake I
see that as not being that big a deal.

> If you don't have swap enabled, yes, there's nowhere else for it to
> go; but I'd say perhaps you were then unwise to allow so much of your
> memory to be used for tmpfs mounts - not been bumping up that nice
> size=50% have you ;-?

Yes. :) But I would've hit problems anyway as I completely forgot about 
tmpfs when I was trying to figure out why the oom killer was kicking in
and free was reporting high cache usage which would mean that that
ram is available for more permanent use rather then being used by something
that already has it allocated more or less permanently.

> But there's certainly scope for suspicion, as to whether the vmscan
> algorithms deal effectively with sending tmpfs to swap.  Should
> page_mapping_inuse be so reluctant to write out tmpfs swap?  Should

I wouldn't think so. If I haven't used something in my tmpfs mounts
for a while it should be gone to swap as I'd much rather the memory
be used for active caching and other more immediately useful bits.

> We've made no change in the face of those doubts because nobody was
> complaining of current behaviour; and it makes some sense to be a
> little reluctant to swap out tmpfs pages - it is supposed to be a
> ram-based filesystem, after all.  But if complaints do accumulate,
> let's look into changing some decisions there.

Well the above isn't a complaint but rathe rmore of a thought. ;) I
do some unimportant logging to tmpfs so that it's there when I need
it but doesn't actually need to survive a reboot. Chucking that to
swap sooner rather then later would be a good thing for me I reckon.

-- 
    Red herrings strewn hither and yon.
