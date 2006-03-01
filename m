Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751904AbWCAU7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbWCAU7v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWCAU7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:59:51 -0500
Received: from cantor2.suse.de ([195.135.220.15]:2467 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751904AbWCAU7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:59:51 -0500
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Date: Wed, 1 Mar 2006 21:59:41 +0100
User-Agent: KMail/1.9.1
Cc: clameter@engr.sgi.com, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com> <200603012021.59638.ak@suse.de> <20060301125358.29261ad9.pj@sgi.com>
In-Reply-To: <20060301125358.29261ad9.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603012159.42273.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 21:53, Paul Jackson wrote:
> > > I spent much time minimizing that overhead over the last few months, as
> > > a direct result of your recommendation to do so.
> > 
> > IIRC my recommendation only optimized the case of nobody using
> > cpuset if I remember correctly. 
> 
> As a result of your general concern with the performance impact
> of cpusets on the page allocation code path, I optimized each
> element of it, not just the one case covered by your specific
> recommendation.

Thanks for doing that work then.
 

> 
> > Using a single cpuset would already drop into the slow path, right?
> 
> No - having a single cpuset is the fastest path.  All tasks
> are in that root cpuset in that case, and all nodes allowed.

Faster than no cpuset?

> 
> > I'm not sure I want to get into the business
> > of explaining all the distributions how to set up cpusets ..
> 
> Good grief - I already quoted the 3 lines of boottime init script it
> would take - this can't require that much explaining, and your new
> sysctl can't get by with much less:

It would just be on by default - no user space configuration needed.

> And even from the perspective of maintaining Linux, this should be on
> autopilot.  Every file systems inode cache is marked, and if we do
> nothing, as more file system types are invented for Linux, they will
> predictably cut+paste the inode slab cache setup from an existing file
> system, and "just get it right."

If something is a good default it shouldn't need user space
configuration at all imho. Only the "weird" cases should.

> I just don't see that it serves any purpose, and I suspect that
> misunderstandings of the performance impact of cpusets are the
> primary source of motivation for such a sysctl.

No that was just one. The other was having good defaults
even on lightweight kernels.

-Andi
