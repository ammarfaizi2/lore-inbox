Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbVLPWQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbVLPWQO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVLPWQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:16:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23231 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932523AbVLPWQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:16:13 -0500
Date: Fri, 16 Dec 2005 17:14:48 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Mike Snitzer <snitzer@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216221448.GP2821@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, Mike Snitzer <snitzer@gmail.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>,
	linux-kernel@vger.kernel.org
References: <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <dnv0d3$4jl$1@sea.gmane.org> <1134758219.2992.52.camel@laptopd505.fenrus.org> <170fa0d20512161132g34c62593p39b109f07cf30b7d@mail.gmail.com> <1134762379.2992.69.camel@laptopd505.fenrus.org> <170fa0d20512161328n7e879b5ao29a4227e9c87491e@mail.gmail.com> <20051216215054.GJ23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216215054.GJ23349@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 10:50:54PM +0100, Adrian Bunk wrote:
 > On Fri, Dec 16, 2005 at 04:28:15PM -0500, Mike Snitzer wrote:
 > >...
 > > Given Neil Brown's fix for the block layer these stack-heavy workloads
 > > that included DM in the call chain need to be revisited.  However, the
 > > savings associated with those particular fixes still may not leave
 > > sufficient breathing room.  The logic that all users must NOW provide
 > > workloads which undermine 4K stack viability otherwise the 8K option
 > > will be completely removed _seems_ quite irrational (even though we
 > > are _supposedly_ just talking about doing so in -mm).
 > > 
 > > All of us appreciate the desire to have Linux be more efficient and 4K
 > > stacks will get us that.  If it comes with the cost of instability
 > > under more exotic workloads then the bad outweighs the perceived good
 > > of imposed 4K stacks.  With RHEL4 it would seem we're past the point
 > > of no-return for supported 8K stacks.  I'm merely advocating upstream
 > > give users the 8K+IRQ stack _options_ and set the default to 4K.
 > 
 > My count of bug reports for problems with in-kernel code with 4k stacks 
 > after Neil's patch went into -mm is still at 0. That's amazing 
 > considering how many people have claimed in this thread how unstable
 > 4k stacks were...
 > 
 > Enabling 4k stacks unconditionally for all -mm users will give us a 
 > wider testing coverage and will tell us whether we have really fixed all 
 > bugs that become visible with 4k stacks or whether there are still bugs 
 > left.

As another anecdotal point, the number of oomkill/page alloc failure
related bugs that get filed against Fedora these days you can count
on one hand.  Before we switched over to 4K stacks, we were
getting regular reports from users having quite sane workloads on
capable machines getting jobs killed left and right.

Now the only cases we're seeing is usually loonies trying to
put silly amounts of RAM in 32bit systems, and the occasional
bug which turns out to be a slab leak or something similar.
(There's one oddball right now where someone sees his 5GB
 x86-64 run out of DMA zone, but that might 'go away' when
 we push out a kernel with the DMA32 zone).

		Dave

