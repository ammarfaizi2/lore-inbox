Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVEGQk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVEGQk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 12:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVEGQk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 12:40:56 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:15252 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261751AbVEGQkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 12:40:35 -0400
Date: Sat, 7 May 2005 22:19:41 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: sharada@in.ibm.com, torvalds@osdl.org, paulus@samba.org, anton@samba.org,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org, miltonm@bga.com
Subject: Re: [Fastboot] Re: [PATCH] ppc64: kexec support for ppc64
Message-ID: <20050507164941.GA3963@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <17019.3752.917407.742713@cargo.ozlabs.ibm.com> <20050506124158.GA2741@in.ibm.com> <20050506124409.GB2741@in.ibm.com> <20050506160546.388aeed4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506160546.388aeed4.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 04:05:46PM -0700, Andrew Morton wrote:
> R Sharada <sharada@in.ibm.com> wrote:
> >
> > This patch implements the kexec support for ppc64
> 
> Well that's pretty neat.   How well does this work?
> 
> I assume you'll be working on kdump-via-kexec for ppc64?
> 
> 
> This kdump/kexec stuff has been hanging around for far too long, IMO.  I'd
> like to think about what we can do to get things moving along a bit more.
> 
> I have two issues with it:
> 
> a) Vague feelings that the low-level ia32 changes may cause APIC/etc
>    breakage with some PCs.

Do you suspect impact during normal operation, or only upon kexec-on-panic ?
If its the former, then wider testing with CONFIG_KEXEC turned on is
really important.

> 
> b) Much more significantly: I still do not believe that it has been
>    demonstrated that the whole kdump-via-kexec scheme will have a
>    sufficiently high success rate for this to become Linux's way of doing
>    crashdumps.
> 
>    And it would not be good if in six months time we decide that the
>    practical problems in getting it all working sufficiently well are
>    insurmountable and we have to revert it all and start working on
>    something else.
> 
>    Recently I've seem a couple of "kdump worked for me" reports, which are
>    greatly appreciated, but I don't think they're statistically
>    significant.
> 
>    So am I right to have this concern?  If so, how can we settle this? 
>    (ie: who's going to do it?  ;))
> 

As Dipankar and Gerrit have mentioned from their prior experience and
as several of us learnt the hard way over years of effort working on
various different options for crash dumps for Linux, if anything stands
a chance of practical success for diverse platforms and devices so it
works for a wide community vs only specific sets of environments, it
is the kexec approach. A 100% successful dumping solution is theoretically
impossible to achieve with software alone; we could have endless debates
about where which solution fails, and never really get anywhere :(. More
than anything a *convergence* on one solution that we all focus on
improving is critical, to achieve as much success as we can. 

kdump is only going to be needed when the system panics, and not
during normal operation ... so I'd say that it is worth it *even* if
it doesn't have a proven high success rate yet. If it doesn't hurt
anything else, and whatever it gets us *whenever* it does work is useful,
I wouldn't really worry too much - we can't be worse off than we are
with kdump than without, can we ?

Even LKCD with all its imperfections and lower reliability compared
to the kdump approach, still is being used when it works ! In some
situations every little bit helps ... Even if we can't solve world
hunger.

As Werner has pointed out in the past for kexec and as Dipankar just
did as well, we have to accept that achieving high reliability is
a maturation process that is simply going to take time and wider
deployments. Which is only going to happen through adoption ...

All it needs is a big push to make it easy for people to use, because
without real usage even inclusion in mainline isn't going to help.

So I think we need the following 2 things for further progress:

(1) Ensure that there are no stability concerns for normal kernel operation.
    Are there any at the moment ? Anything that stops people from compiling
    with CONFIG_KEXEC by default ?

(2) Actively help people in the community to use it (*visibly*, so it makes
    it easier for those who haven't already used it to pick up).
    What Maneesh did for the timer problem is a good example, and more
    of such instances will go a long way. At the same time, I think it is
    going to be a hard for kdump developers alone to focus on 
    identifying and solving bugs in various kernel areas (Bugs that
    need a dump for analysis usually aren't the easiest of problems)
    *as well as* fixing kexec/kdump to work in increasing number of
    situations.  They'll need help ... and maybe some direction on what
    to prioritize.
    How do we make that happen ?

(3) Avoid any major churn in kexec/kdump during this phase that can
    impact stability or usability to make life easier for all.

> 
> Perhaps we could declare that kexec is sufficiently useful and mature in
> its own right and just merge up those bits while we work on kdump.  This
> also gives us a bit of pipelining: continue to test and stabilise kexec
> while kdump remains in development.

Several months back, I would likely have agreed with that.

Now, I'm not so sure. After the kdump redesign, a large part of the kdump
support is actually provided by kexec-on-panic which is an integral part
of kexec. The additional bits for dump capture alone may not be a whole
lot ... But, I'd let Maneesh/Vivek comment on that.

> 
> Opinions are sought...

Was this anywhere close to what you were looking for ?

Regards
Suparna

> _______________________________________________
> fastboot mailing list
> fastboot@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/fastboot


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

