Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270034AbTGLXxx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 19:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270036AbTGLXxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 19:53:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6382 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270034AbTGLXxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 19:53:52 -0400
Date: Sun, 13 Jul 2003 02:08:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, mroos@linux.ee,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect'
Message-ID: <20030713000832.GT843@suse.de>
References: <20030711140219.GB16433@suse.de> <E19bK8w-0004Ij-00@roos.tartu-labor> <20030712202352.GA7741@suse.de> <20030712151511.107c1f59.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712151511.107c1f59.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12 2003, Andrew Morton wrote:
> Dave Jones <davej@codemonkey.org.uk> wrote:
> >
> > ..
> > 
> > Something seems amiss. The deprecated elvtune interface is the old -r/-w/-b command line.
> > I was lead to believe a new elvtune appeared which supports an option
> > for changing the elevator under 2.5, however a quick google doesn't turn
> > up any such patched elvtune, so I'm somewhat puzzled.
> 
> No, we planned to do the selection via sysfs rather than ioctl.

Right

> >  > Maybe just suggest the sysfs interface at once and not mention
> >  > elvtune?
> > 
> > Changing the elevator type per device via sysfs does seem to make
> > sense, however /sys/block/<devicename>/queue/iosched/ doesn't yield
> > anything that would suggest this is possible (yet).  I think Jens
> > has patches for this?
> 
> But it never happened.  There are all sorts of nasties wrt actually

Well the code exists.

> making the switch.  Some related to request queueing, some to sysfs
> itself.

I don't recall any request queueing problems, it's pretty straight
forward to lock the queue down and prevent any new requests from
entering. sysfs problems is the only issue, and before Al does his magic
on that stuff, the patch just doesn't make sense. So it hasn't been
posted publically. With the sysfs disabled, I can switch io schedulers
on the fly quite easily.

> So yes, we should have runtime selection, and maybe sometime we will,
> but the lowness of the return-to-effort ratio means it won't happen
> soon.

Depends. If the sysfs stuff doesn't get fixed, then no it wont happen.

-- 
Jens Axboe

