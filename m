Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVEFXlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVEFXlh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVEFXlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:41:31 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:44997 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261392AbVEFXkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:40:21 -0400
To: Andrew Morton <akpm@osdl.org>
cc: sharada@in.ibm.com, paulus@samba.org, torvalds@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org, miltonm@bga.com, fastboot@lists.osdl.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] ppc64: kexec support for ppc64 
In-reply-to: Your message of Fri, 06 May 2005 16:05:46 PDT.
             <20050506160546.388aeed4.akpm@osdl.org> 
Date: Fri, 06 May 2005 16:40:08 -0700
Message-Id: <E1DUCQS-0005Sq-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 06 May 2005 16:05:46 PDT, Andrew Morton wrote:
> R Sharada <sharada@in.ibm.com> wrote:
> >
> > This patch implements the kexec support for ppc64
> 
> Well that's pretty neat.   How well does this work?
> 
> I assume you'll be working on kdump-via-kexec for ppc64?
> 
> This kdump/kexec stuff has been hanging around for far too long, IMO.  I'd
> like to think about what we can do to get things moving along a bit more.
 
 Agreed!

> I have two issues with it:
> 
> a) Vague feelings that the low-level ia32 changes may cause APIC/etc
>    breakage with some PCs.
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
> Perhaps we could declare that kexec is sufficiently useful and mature in
> its own right and just merge up those bits while we work on kdump.  This
> also gives us a bit of pipelining: continue to test and stabilise kexec
> while kdump remains in development.
> 
> Opinions are sought...

 I'm in favor of getting as much of kexec moving towards wider integration
 and testing as possible.  We won't catch your issue on ia32 without
 wider testing on ia32 boxen - and I think it is stable enough that
 that type of testing should drive it towards full stability sooner.

 On your second issue, kdump-via-kexec is *way* better than all the
 alternatives.  We have a lot of distro/customer experience with
 the alternatives and, well, they all suck, badly.  Kexec has some
 tough issues with some of the low level interactions and ensuring
 that control can get transferred to the new kernel but those are
 relatively minor compared to the "copy all my innards out out from a 
 broken kernel" approach.

 You recently mentioned the pain of a single bug in an -mm tree taking
 three painful days to track down.  With the current dump solutions, we
 often spend *weeks* trying to get to a root cause where the customer
 is begging that we get their business running again.  As a result, some
 otherwise relatively simple-to-fix, hard-to-find problems aren't getting
 diagnosed for weeks or even months, if ever.  Getting a crash dump
 allows us to pore over these problems without keeping a real user's
 machine out of production, and without hoping that the problem might
 happen again in the future.

 Also, the major distros have widly varying solutions in this space;
 writing supporting tools and patching bugs is being done multiple times,
 being done only for the distros, and not improving mainline at all.
 Convergence here would help us focus more efforts on mainline instead
 of replicating efforts on distros that don't benefit mainline and
 are constantly being re-implemented (e.g. a big waste of resources
 that could be better applied to making everyone's lives better).

 Kexec offers as much assurance as is possible of being able to get a
 crash dump quickly.  The only thing better would be a firmware implemented
 memory dumper, which just isn't an option on most common platforms.

 If it takes a little list or test matrix of platforms tested over the
 short term to help verify what machines work, we might be able to set
 something like that up as well.

 gerrit
