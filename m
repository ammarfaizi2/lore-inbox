Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVCaAa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVCaAa2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbVCaAa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:30:27 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:58329 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262521AbVCaA3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:29:39 -0500
Date: Wed, 30 Mar 2005 16:25:17 -0800
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: Paul Jackson <pj@engr.sgi.com>, gh@us.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [patch 0/8] CKRM:   Core patch set
Message-ID: <20050331002517.GB7048@chandralinux.beaverton.ibm.com>
References: <E1DGTK2-0007gO-00@w-gerrit.beaverton.ibm.com> <20050329220530.4a5639c8.pj@engr.sgi.com> <20050330225505.7a443227.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050330225505.7a443227.diegocg@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 10:55:05PM +0200, Diego Calleja wrote:
> El Tue, 29 Mar 2005 22:05:30 -0800,
> Paul Jackson <pj@engr.sgi.com> escribió:
> 
> 
> > worth having.  I for one am a CKRM skeptic, so won't be much help to you
> > in that quest.  Good luck.
> > 
> > I don't see any performance numbers, either on small systems, or
> > scalability on large systems.  Certainly this patch does not fall under
> > the "obviously no performance impact" exclusion.
> 
> I'm one of those people who also thinks that CKRM tries to do too much things, and
> although my opinion doesn't counts a lot, I'll try to explain myself anyway :)
> 
> One of the things I personally don't like about CKRM its how it handles "CPU resources".
> The goal of CKRM seems to be "control how much % a process can get get", but the
> amount of concepts created to achieve that is too huge and too complex. For the
> "CPU resources", I think that there're much simpler and better solutions. For example,
> instead what CRKM proposes I propose a simpler concept: "attaching" GIDs to a 
> niceness level.
> 
> Say, we "attach" group foo to nice level -5. All users who belong to group foo will have
> permissions to renice themselves to nice -5. If instead of that, group foo has been
> attached at nice level 15, all processes from users who belong to foo will be run at 15,
> and they won't be able to renice themselves even to the default priority (0)
> 
> This should be very easy to implement, and what's more important, it'd probably have
> zero performance impact at runtime - CRKM touches hot paths in the scheduler
> I think, this would just touch a few non-critical places - because we'd just use a existing
> concept.

Your design is nice and simple to take the priority based scheduling
to the next level.

Whereas what CKRM provides is resource management and monitoring, which
is more than prioritizing group of users for scheduling.

It allows one to manage/monitor different groups of applications(that
are related or non-related).

With CKRM, you can provide resource control support for features
like UML and virtual servers to make them more controllable 
domains(term domain used loosely) in terms of resource management.

> 
> Sure, this can't guarantee that a group will get reserved exactly 57% of  the CPU, but I
> think that such level of detail is unnecesary - instead we let the kernel uses the
> standard internal mechanisms to do the dirty job based in the distinction between
> standard nice levels. (And we could get that level of detail just by modifying the
> scheduler algorithm and adding a range of -50...0...50 nice levels ;)
> 
> For the CPU resources, we already have nice levels. The existing algorithms can already
> handle priorities with them. CKRM alternative seems to be to add a second scheduling
> algorithm which in super-hot paths like the ones from sched.c are, it will probably have a

One clarification: CKRM is the infrastruture, What you are referring 
is the CPU controller(whish is a module to mange the resource CPU), which
can be replaced by a simplistic one(like the one you propose) or turned
off if needed.

That is one of the advantage the architecture provides, it removed resource
specific details from the core functionality CKRM provided, so that it
remains flexible(in choosing the resources you want to control) and
expandable easily(to support additional resources).

> performance impact. In my very humble opinion, I think we should reuse existing UNIX
> concepts and combine them to achieve some of the goals CKRM tries to achieve in
> a much simpler (unixy ;) way.
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by Demarc:
> A global provider of Threat Management Solutions.
> Download our HomeAdmin security software for free today!
> http://www.demarc.com/info/Sentarus/hamr30
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
> 

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
