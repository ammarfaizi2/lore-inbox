Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVC3HEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVC3HEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 02:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVC3HEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 02:04:13 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36840 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261784AbVC3HDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 02:03:48 -0500
To: Paul Jackson <pj@engr.sgi.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, kashyapv@us.ibm.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch 0/8] CKRM: Core patch set 
In-reply-to: Your message of Tue, 29 Mar 2005 22:05:30 PST.
             <20050329220530.4a5639c8.pj@engr.sgi.com> 
Date: Tue, 29 Mar 2005 23:03:42 -0800
Message-Id: <E1DGXEs-0003KX-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Mar 2005 22:05:30 PST, Paul Jackson wrote:
> gerrit wrote:
> > This is the core patch set for CKRM
> 
> Welcome.
 
 Hi Paul.

> Newcomers to CKRM might want to start reading these patches with "[patch
> 8/8] CKRM:  Documentation".  Starting with patch 0/8 or 1/8 will be
> difficult, at least if you're as dimm witted as I am.
> 
> Even the documentation included in patch 8/8 is missing the motivation
> and context essential to understanding this patch set.  It might have
> helped if the Introduction text at http://ckrm.sourceforge.net/ had been
> included in some form, as part of patch 0/8.  I'm just a little penguin
> here (lkml), but from what I can tell by watching how things work,
> you're going to have to "make the case" -- explain what this is, how
> it's put togeher, and why it's needed.  This is a sizable patch, in
> lines of code, in hooks in critical places, and in amount of "new
> concepts."  I presume (unless you've managed to bribe or blackmail some
> big penguin) you're going to have convince some others that this is
> worth having.  I for one am a CKRM skeptic, so won't be much help to you
> in that quest.  Good luck.
 
 Good point on including the pointer to the web site.  As you probably
 noticed, there is a history of the design, papers presented, etc.
 Also, Jonathan Corbet did a nice write up from the discussion at the
 2004 Kernel summit which is archived here: http://lwn.net/Articles/94573/
 which may be of use.

 The OLS and LinuxTag papers are archived at the site that you pointed
 to and there will be a tutorial on configuring, using and writing
 controllers for CKRM at OLS this year.  You may also want to see the
 previous postings of this code to LKML for more background.

 In short, CKRM provides very basic desktop to server workload management
 capabilities similar to those provided by most of the old fashioned
 operating systems.  The code provides a fairly simple mechanism for
 adding controllers for any resource type and the code is currently
 widely deployed by PlanetLab, a part of Novell/SuSE's distro, and
 the capabilities are requested by a fair number of Linux users and
 customers.

> I don't see any performance numbers, either on small systems, or
> scalability on large systems.  Certainly this patch does not fall under
> the "obviously no performance impact" exclusion.

 Fair point.  We have been running some of the smaller benchmarks but
 have not yet had a chance to do any kind of performance comparison
 based on the current code.  However, when configured out, it will
 have zero impact.  We do have some performance analysis of the code
 with CONFIG_CKRM set to y but no rules configured planned for the
 very near future.
 
> A couple of nits:
> 
>  1) Instead of disabling routines with #defines:
>          #define numtasks_put_ref(core_class)  do {} while (0)
>     one can do it with static inlines, preserving more compiler
>     checking.
 
 Yeah - that works well in some cases but it turns out to not do so
 well when an argument to a function refers to a structure element
 which is not configured in.  In that case, the compiler emits a
 reference to an undefined structure value in the case of the static
 inline, where otherwise the entire set of code is pre-processed
 away.  I think we've gone through the code and used the correct
 balance of static inlines and #define constructs as appropriate.
 If we've missed any, I'm more than willing to accept a patch to
 correct a specific instance.

>  2) I take it that the following constitutes the 'documentation'
>     for what is in /proc/<pid>/delay.  Perhaps I missed something.
> 
> 	+	res  = sprintf(buffer,"%u %llu %llu %u %llu %u %llu\n",
> 	+		       (unsigned int) get_delay(task,runs),
> 	+		       (uint64_t) get_delay(task,runcpu_total),
> 	+		       (uint64_t) get_delay(task,waitcpu_total),
> 	+		       (unsigned int) get_delay(task,num_iowaits),
> 	+		       (uint64_t) get_delay(task,iowait_total),
> 	+		       (unsigned int) get_delay(task,num_memwaits),
> 	+		       (uint64_t) get_delay(task,mem_iowait_total)
 
 The code is the documentation?  :)

 There is probably some documentation on /proc/<pid>/ in general and
 we'll see if we can get it updated appropriately.  Vivek?

>  3) Typo in init/Kconfig "atleast":
> 
>     If you say Y here, enable the Resource Class File System and atleast

 Got it - thanks!  Someone liked the new word "atleast" - at least
 three occurences removed.

 Oh - and uniformly updated diffstats - I probably missed some when
 I was playing with quilt originally.

gerrit
