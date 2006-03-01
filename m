Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751915AbWCAVTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbWCAVTU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWCAVTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:19:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28833 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751915AbWCAVTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:19:19 -0500
Date: Wed, 1 Mar 2006 13:19:10 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: clameter@engr.sgi.com, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Message-Id: <20060301131910.beb949be.pj@sgi.com>
In-Reply-To: <200603012159.42273.ak@suse.de>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
	<200603012021.59638.ak@suse.de>
	<20060301125358.29261ad9.pj@sgi.com>
	<200603012159.42273.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > No - having a single cpuset is the fastest path.  All tasks
> > are in that root cpuset in that case, and all nodes allowed.
> 
> Faster than no cpuset?

If CONFIG_CPUSET is enabled (which I thought was likely to become the
norm for most distros -- though you would know better than I if this is
likely) then:

	There is no such case as "no cpuset" !!

The minimal, fastest, case is one root cpuset holding all tasks.


> If something is a good default it shouldn't need user space
> configuration at all imho. Only the "weird" cases should.

So are you just saying we got the default backwards?

Well ... I left the default for memory spreading these
inode slab caches as it was - not spread (preferring
node local).

I did that because I did not have the awareness that this default
should be changed for most systems.  I tend to leave defaults as they
are, unless I have good reason to change them.

But for the SGI systems I care about, I'd prefer the default to be
spreading them.

If you think it would be better to change this default, now that the
mechanism is in place to do support spreading these slabs, then I could
certainly go along with that.

Then your systems would not have to do anything in user space, unless
they wanted to disable spreading these slabs (which of course they
could easily do using cpusets ;).

    Should we change the default to enable this spreading?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
