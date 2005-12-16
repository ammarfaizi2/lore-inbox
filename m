Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVLPV2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVLPV2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVLPV2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:28:17 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:27120 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932452AbVLPV2Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:28:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nvd5xpiVPJZLZPo2Mk2CaVFJ4GM1r+tag6sNO372aXH1//bbXI7H3znflhxzvfkFmQkX4q8KlKu3XuQ2E+2p3rTm/lxiEjemu+n9gKMq2wyUbl86H/f743FSb4sJqoSmygxIOK/luijPXwoVH8XvR1EwxZFxhkNaY1fZ5Ou/w7U=
Message-ID: <170fa0d20512161328n7e879b5ao29a4227e9c87491e@mail.gmail.com>
Date: Fri, 16 Dec 2005 16:28:15 -0500
From: Mike Snitzer <snitzer@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Cc: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <1134762379.2992.69.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051215212447.GR23349@stusta.de>
	 <20051215140013.7d4ffd5b.akpm@osdl.org>
	 <20051216141002.2b54e87d.diegocg@gmail.com>
	 <20051216140425.GY23349@stusta.de>
	 <20051216163503.289d491e.diegocg@gmail.com>
	 <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com>
	 <dnv0d3$4jl$1@sea.gmane.org>
	 <1134758219.2992.52.camel@laptopd505.fenrus.org>
	 <170fa0d20512161132g34c62593p39b109f07cf30b7d@mail.gmail.com>
	 <1134762379.2992.69.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan,

I'm aware that RedHat has been shipping FC and RHEL kernels with 4K
stacks for some time.  The recent 4K stack fixes pretty much establish
that RedHat's early adoption of 4K stacks was a "cowbody development"
no?  I don't think RedHat kept similar 4K stack fixes from upstream,
so a bit of luck maybe?  I do agree that at this point the 4K-only
proposal is NOT an overly rash decision given continued adequate
vetting in -mm.  But even then there may be untested workloads that
expose stack issues.  Which is perfectly fine if users have the option
to use _supported_ alternate configs.

I got the sense that you were trying to paint me as something of a
closet "ndiswrapper addict".  Amusing and all but my motivations for
requesting continued options on the stack size are rooted in concerns
that long call chains can and still do result when running kernel.org
and RHEL4 kernels under particular workloads.  An example workload
being cluster filesystems that in a single call chain historically
_could_ leverage iptables + RPC (tcp) + DM (LVM) + etc.

Given Neil Brown's fix for the block layer these stack-heavy workloads
that included DM in the call chain need to be revisited.  However, the
savings associated with those particular fixes still may not leave
sufficient breathing room.  The logic that all users must NOW provide
workloads which undermine 4K stack viability otherwise the 8K option
will be completely removed _seems_ quite irrational (even though we
are _supposedly_ just talking about doing so in -mm).

All of us appreciate the desire to have Linux be more efficient and 4K
stacks will get us that.  If it comes with the cost of instability
under more exotic workloads then the bad outweighs the perceived good
of imposed 4K stacks.  With RHEL4 it would seem we're past the point
of no-return for supported 8K stacks.  I'm merely advocating upstream
give users the 8K+IRQ stack _options_ and set the default to 4K.

Mike


On 12/16/05, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > You're using overly generalized assertions to try to convince others
>
> I'm no longer interested in arguing removing this thing. Too much
> whining by ndiswrapper addicts [1].
>
> > that the configurability of a particularly important (to some, albeit
> > not you) config option is unnecessary.  4K vs 8K is hardly a "trivial"
> > configuration option of the Linux kernel.
>
> Compared to many of the other changes that went in since 2.6.0? 4K
> stacks is a minor change. There's no config option for 4 level
> pagetables for example, and that's a far more invasive change in many
> ways.
>
> >  At this point in time it
> > has not been sufficiently demonstrated that 4K "just works".
>
> Excuse me?
> Fedora released 3 distributions with it enabled, and Red Hat uses it in
> an enterprise distribution. That's a whopping lot of users right there
> with a very wide range of workloads.
>
> >  kernel to get the desired safety?  IF upstream
> > kernel.org doesn't even provide the knobs to ensure safety at all
> > costs (and vendors like Redhat have people at the helm who are
> > advocating 4K stacks in the "Enterprise" Linux kernel configurations
> > of the world) how does one get a Linux kernel that provides a sizable
> > safety net that is _SUPPORTED_ for true enterprise-grade applications?
>
> eh I don't know if you paid attention, but Red Hat Enterprise Linux 4
> only has 4Kb stacks kernels... so that covers your supported true
> enterprise-grade application thing.
>
> > Simply put 4K vs 8K is not as trivial a decision as you'd have people believe.
>
> that's too simply put in fact, especially if you look at it
> historically. It's a bit of irony that part of the reason 4K stacks was
> developed was that the 2.4 kernels ran out of stack space for customers
> occasionally (just as example look at lkml this week, there was a report
> about such an overflow there as well). Remember that 4K+4K has more
> stack space than the 4K+2K as 2.4 kernels have. Sure 2.6 bumped this to
> 5.5k/2.5k roughly in the "8K" case, but fundamentally the change to
> 4k/4k isn't all that big even inside 2.6.
>
> You can go on and keep painting this as a cowboy development, but it
> really isn't....
>
>
>
> [1] Yes addicts; binary drivers are in many ways similar to heroin;
> they're really hard to get rid of for example and highly addictive, they
> also cause some people to act like junkies-in-withdrawl when their
> binary driver breaks, or when someone suggests breaking it.
>
>
