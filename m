Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUJOBGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUJOBGw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUJOBGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:06:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27815 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267661AbUJOBGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:06:49 -0400
Date: Thu, 14 Oct 2004 20:17:21 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: per-process shared information
Message-ID: <20041014231721.GA9284@logos.cnet>
References: <20041013231042.GQ17849@dualathlon.random> <20041014214711.GF6899@logos.cnet> <20041014235845.GL17849@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014235845.GL17849@dualathlon.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 01:58:45AM +0200, Andrea Arcangeli wrote:
> On Thu, Oct 14, 2004 at 06:47:11PM -0300, Marcelo Tosatti wrote:
> > 
> > Hi Andrea!
> > 
> > No useful comments on the statm reporting issue.
> > 
> > > Ps. if somebody like Hugh volunteers implementing it, you're very
> > > welcome, just let me know (I'll eventually want to work on the oom
> > > handling too, which is pretty screwed right now, 
> > 
> > Yes, we've got reports of bad OOM killing behaviour (is that what you're
> > talking about?) 
> > 
> > One thing is the removal of "if (nr_swap_pages > 0) goto out" from oom_kill() 
> > causes problems (spurious oom kill). 
> > 
> > We need to throttle more, on page reclaiming progress I think.
> > 
> > Take a look at 
> > 
> > http://marc.theaimsgroup.com/?l=linux-mm&m=109587921204602&w=2
> > 
> > What else you're seeing?
> > 
> > > I've plenty of bugs
> > > open on that area and the lowmem zone protection needs a rewrite too to
> > > be set to a sane default value no matter the pages_lows etc..).
> > 
> > Nick has been working on that lately I think. What is the problem?
> 
> things went worse with the switch from 2.6.8 to 2.6.9-rc, so that's not
> the nr_swap_pages > 0, likely the latest changes introduced regressions
> instead of fixing them.

Just FYI - removing the "nr_swap_pages > 0" fixes the problem at
the URL I posted above.

But having it creates hard locks on Oracle workloads (wli removed 
that line) due to pinned memory.

> I'm seeing both hard deadlocks and suprious oom kills, and that all
> makes sense, I can see the bugs, it's just I need to fix them, my plan
> is to forward port some code from 2.4 which works fine, objrmap will make
> it even better.

Ok, very nice!

