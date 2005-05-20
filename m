Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVETVJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVETVJo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 17:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVETVJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 17:09:31 -0400
Received: from colo.lackof.org ([198.49.126.79]:11907 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261582AbVETVJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 17:09:20 -0400
Date: Fri, 20 May 2005 15:12:29 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, akpm@osdl.org,
       T-Bone@parisc-linux.org, varenet@parisc-linux.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: patch tulip-natsemi-dp83840a-phy-fix.patch added to -mm tree
Message-ID: <20050520211229.GA2411@colo.lackof.org>
References: <200505101955.j4AJtX9x032464@shell0.pdx.osdl.net> <42881C58.40001@pobox.com> <20050516050843.GA20107@colo.lackof.org> <4288CE51.1050703@pobox.com> <20050516222612.GD9282@colo.lackof.org> <428E3372.403@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428E3372.403@pobox.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 02:58:58PM -0400, Jeff Garzik wrote:
> Grant Grundler wrote:
> >After three years of using/maintaining the (trivial) tulip patch
> >in parisc-linux tree (and shipped with RH/SuSe ia64 releases),
> >I don't recall anyone complaining that udelays in tulip phy reset
> >caused them problems. Sorry, I'm unmotivated to revisit this.
> >Convince someone else to make tulip to use workqueues and I'll
> >resubmit a clean patch on top of that for the phy init sequences.
> 
> 
> Long delays are unacceptable in new drivers,

Agreed. But that didn't stop tg3 from having a 1.5 *SECOND*
spin delay during fiber phy init with interrupts off.
That is certainly a much newer driver than tulip.

(It's not obvious to me by code inspection which context
 tg3_setup_fiber_by_hand() gets called from now.)

> and we are working to remove them from older drivers.
>
> Lack of complaints is irrelevant -- its 
> a design requirement of all drivers.

It's totally relevant.
Complaints (bug reports) and patches drive change.  That's how both
commercial *and* non-commercial developers prioritize.

"Ingo and the real-time crowd" are a good example of a change
in priorities driven by non-commercial users.

> Ingo and the real-time crowd are fighting against every delay, because 
> every delay causes a spin, a blip in latency, an increase in CPU usage, 
> and a complete stoppage of ALL work on a uniprocessor machine.

Understood. But they were not the first ones. Donald Becker has a fairly
well known digust for use of CPU spin loops.  But we can't eliminate
*all* udelay just becuase of the way HW is designed and has bugs.
I think it would be reasonable to get rid of many udelay calls
(replace them with PCI read delay loops like Donald has advocated)
and get the rest into a context where it matters less.
I have no objection to people fixing those sorts of issues.


> Your patch is not a special case.  We have been communicating this 
> message on udelay/mdelay for -years-.  All your patch [as-is] does is 
> cause more work for someone else.

Not true. This patch brings the tulip driver into compliance with
published specs and makes the driver functional for parisc/mips/ia64 users.

> This also presents a problem that Andrew points out on occasion:
> what happens when a patch is useful, but the patch author isn't (for 
> whatever reason) doing the legwork necessary to get it into the mainline 
> kernel?

The "whatever reason" is clearly decided by the mainline kernel maintainer.
If we treat other people's labor as "free", then the right answer is
to drop the patch and wait for some subset of "we" to do the extra legwork.

Several people care if tulip phy init works right. OTOH, I'm only aware of
one person who specifically cares if tulip is holding the CPU hostage for
1 or 2 ms during the occasional phy init.

Is being a technology purist more important than moving forward with
what people care about?

> We certainly DON'T want to lose this patch, as the changes are 
> useful.

I think we also agree debugging the problem and providing a patch
that works is a worthy contribution.

We won't lose it. I maintain it in CVS on cvs.parisc-linux.org.

thanks,
grant
