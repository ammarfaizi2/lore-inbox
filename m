Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUINX14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUINX14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266733AbUINXZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:25:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3751 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266304AbUINXYx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:24:53 -0400
Date: Tue, 14 Sep 2004 18:41:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-ID: <20040914214158.GA363@logos.cnet>
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <1095186713.6309.15.camel@stantz.corp.sgi.com> <20040914201558.GA32254@logos.cnet> <41477661.9030204@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41477661.9030204@kolivas.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 08:53:21AM +1000, Con Kolivas wrote:
> Marcelo Tosatti wrote:
> >On Tue, Sep 14, 2004 at 11:31:53AM -0700, Florin Andrei wrote:
> >
> >>On Mon, 2004-09-06 at 16:27, Andrew Morton wrote:
> >>
> >>>Con Kolivas <kernel@kolivas.org> wrote:
> >>
> >>>>The change was not deliberate but there have been some other people 
> >>>>report significant changes in the swappiness behaviour as well (see 
> >>>>archives). It has usually been of the increased swapping variety 
> >>>>lately. It has been annoying enough to the bleeding edge desktop users 
> >>>>for a swag of out-of-tree hacks to start appearing (like mine).
> >>>
> >>>All of which is largely wasted effort.
> >>
> >>>From a highly-theoretical, ivory-tower perspective, maybe; i am not the
> >>one to pass judgement.
> >>>From a realistic, "fix it 'cause it's performing worse than MSDOS
> >>without a disk cache" perspective, definitely not true.
> >>
> >>I've found a situation where the vanilla kernel has a behaviour that
> >>makes no sense:
> >>
> >>http://marc.theaimsgroup.com/?l=linux-kernel&m=109237941331221&w=2
> >>http://marc.theaimsgroup.com/?l=linux-kernel&m=109237959719868&w=2
> >>http://marc.theaimsgroup.com/?l=linux-kernel&m=109238126314192&w=2
> >>
> >>A patch by Con Kolivas fixed it:
> >>
> >>http://marc.theaimsgroup.com/?l=linux-kernel&m=109410526607990&w=2
> >>
> >>I cannot offer more details, i have no time for experiments, i just need
> >>a system that works. The vanilla kernel does not.
> >
> >
> >Have you tried to decrease the value of /proc/sys/vm/swappiness 
> >to say 30 and see what you get?
> >
> >Andrew's point is that we should identify the problem - Con's patch
> >rewrites swapping policy.  
> 
> I already answered this. That hard swappiness patch does not really 
> rewrite swapping policy. It identifies exactly what has changed because 
> it does not count "distress in the swap tendency". Therefore if the 
> swappiness value is the same, the mapped ratio is the same (in the 
> workload) yet the vm is swappinig more, it is getting into more 
> "distress". The mapped ratio is the same but the "distress" is for some 
> reason much higher in later kernels, meaning the priority of our 
> scanning is getting more and more intense. This should help direct your 
> searches.

> These are the relevant lines of code _from mainline_:
> 
> distress = 100 >> zone->prev_priority
> mapped_ratio = (sc->nr_mapped * 100) / total_memory;
> swap_tendency = mapped_ratio / 2 + distress + vm_swappiness
> if (swap_tendency >= 100)
> -		reclaim_mapped = 1;
> 
> 
> That hard swappiness patch effectively made "distress == 0" always.

OK. 

So isnt it true that decreasing vm_swappiness should compensate 
distress and have the same effect of your patch? 

To be fair I'm just arguing, haven't really looked at the code.



