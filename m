Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269403AbUI3SlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269403AbUI3SlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269386AbUI3SlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:41:10 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:13509 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269403AbUI3Shk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:37:40 -0400
Subject: Re: [RFC PATCH] sched_domains: Make SD_NODE_INIT per-arch
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@suse.de>
In-Reply-To: <415BC0BC.6040902@yahoo.com.au>
References: <1096420339.15060.139.camel@arrakis>
	 <415BC0BC.6040902@yahoo.com.au>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1096569412.20097.13.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 30 Sep 2004 11:36:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 01:15, Nick Piggin wrote:
> Matthew Dobson wrote:
> > IA64 already has their own version of SD_NODE_INIT, tuned for their
> > extremely large machines.  I think that all arches would benefit from
> > having their own, arch-specific SD_NODE_INIT initializer, rather than
> > the one-size-fits-all variant we've got now.
> > 
> 
> I suppose the patch is pretty good (IIRC Martin liked the idea).
> I guess it will at least increase the incidence of copy+paste,
> if not getting people to think harder ;)

Thanks!  Martin does like the idea, and I think Andi Kleen likes the
idea of being able to tune sched_domains for x86_64, too.  Any comments,
Andi?

The patch is pretty simple.  I don't think it will increase any
copy+pasting because I don't believe anyone has modified SD_NODE_INIT at
all since it's been implemented, and certainly not for many kernel
releases.  I think part of the reason for that is that it is currently
impossible to tweak the values for your architecture of choice because
modifying the values now will change EVERYONE's sched_domains timings. 
Which is bad. :(  If anyone wants to tweak SD_NODE_INIT, they shouldn't
be copying+pasting those values to all architectures.  Besides, IA64
already gets their own SD_NODE_INIT to play with, why shouldn't everyone
else! ;)


> Can I be lame and ask that you keep this around until closer
> to 2.6.10? I have a few possible scheduler performance
> improvments that I'd like to get tested in -mm after 2.6.9
> and this would make things a bit harder :P
> 
> I don't think anyone is looking at getting any tweaks in before
> then...

I would like to try to get this in before then, unless this will really
make things difficult for you.  2.6.9 is looking to be a pickup point
for distros, so getting this patch in now (pre 2.6.9) means that distros
can add tiny patches to their builds to simply tweak individual
architecture values without having to diverge from mainline by
implementing this patch on their own.  It also means that any tuning
work that the distros do can easily be pushed back to mainline by
simpling sending a patch per architecture with new values.  It makes
those patches safe and minimizes conflicts.

Will this patch really make your scheduler improvements that much harder
to test/implement?  I don't think it should, unless your improvements
are tweaking the values in SD_NODE_INIT, since that is all this
touches...  Even after this patch, SD_NODE_INIT is still picked up in
include/linux/sched.h, so the changes required to cope with this patch
should be minimal...

-Matt

