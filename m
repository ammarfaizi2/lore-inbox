Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUJOAGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUJOAGV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 20:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268035AbUJOAC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 20:02:29 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:34705 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268120AbUJNX60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 19:58:26 -0400
Date: Fri, 15 Oct 2004 01:58:45 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: per-process shared information
Message-ID: <20041014235845.GL17849@dualathlon.random>
References: <20041013231042.GQ17849@dualathlon.random> <20041014214711.GF6899@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014214711.GF6899@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 06:47:11PM -0300, Marcelo Tosatti wrote:
> 
> Hi Andrea!
> 
> No useful comments on the statm reporting issue.
> 
> > Ps. if somebody like Hugh volunteers implementing it, you're very
> > welcome, just let me know (I'll eventually want to work on the oom
> > handling too, which is pretty screwed right now, 
> 
> Yes, we've got reports of bad OOM killing behaviour (is that what you're
> talking about?) 
> 
> One thing is the removal of "if (nr_swap_pages > 0) goto out" from oom_kill() 
> causes problems (spurious oom kill). 
> 
> We need to throttle more, on page reclaiming progress I think.
> 
> Take a look at 
> 
> http://marc.theaimsgroup.com/?l=linux-mm&m=109587921204602&w=2
> 
> What else you're seeing?
> 
> > I've plenty of bugs
> > open on that area and the lowmem zone protection needs a rewrite too to
> > be set to a sane default value no matter the pages_lows etc..).
> 
> Nick has been working on that lately I think. What is the problem?

things went worse with the switch from 2.6.8 to 2.6.9-rc, so that's not
the nr_swap_pages > 0, likely the latest changes introduced regressions
instead of fixing them.

I'm seeing both hard deadlocks and suprious oom kills, and that all
makes sense, I can see the bugs, it's just I need to fix them, my plan
is to forward port some code from 2.4 which works fine, objrmap will make
it even better.
