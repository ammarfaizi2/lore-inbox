Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUCKUVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbUCKUVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:21:39 -0500
Received: from colin2.muc.de ([193.149.48.15]:32783 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261673AbUCKUVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:21:37 -0500
Date: 11 Mar 2004 21:21:36 +0100
Date: Thu, 11 Mar 2004 21:21:36 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040311202136.GA59610@colin2.muc.de>
References: <1ysXv-wm-11@gated-at.bofh.it> <m3lllzawlm.fsf@averell.firstfloor.org> <20040311112852.4f56cf34.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311112852.4f56cf34.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For SMT there is a patch from Intel pending that teaches x86-64
> > to set up the SMT scheduler. They said they got slightly better
> > benchmark results. The SMT setup seems to be racy though.
> 
> Am I correct in thinking that this patch provides the necessary hooks to
> integrate x86_4 into the new functionality which sched-domains provides, or
> is the Intel patch independent of sched-domains?

It sets up the sched-domains code to know about HyperThreading CPUs
on x86-64 too (basically same thing as the i386 code does with a 
few minor tweaks) 

So it's dependent on that. 

I will send it to you in separate mail.

> > Some kind of SMT scheduler is definitely needed, we have a serious
> > regression compared to 2.4 here right now. I'm not sure this 
> > is the right approach though, it seems to be far too complex.
> 
> Well that's discouraging.  I really do want to push this thing along a bit.
> 
> Yours is the only report of regression of which I am aware.  Is the reason
> understood?

I think the reason is that it doesn't do balance on clone/fork. The 
normal scheduler also doesn't do that, but for some reason it still does 
better on the benchmarks (but worse than the old 2.4 -aa/Intel O(1) HT 
scheduler)

> And is anyone developing alternative SMT enhancements?

I thought there was a patch from Ingo Molnar? ("shared runqueue") 
I must admit I never tried it, just remember seeing the patches.

Also I've been playing with the entitlement scheduler to fix 
some of the interactivity problems I have on UP, but it also
seems to still have problems.

-Andi
