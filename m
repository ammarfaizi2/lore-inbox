Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268786AbUIXOms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268786AbUIXOms (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268799AbUIXOmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:42:47 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5021 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268786AbUIXOmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:42:44 -0400
Date: Fri, 24 Sep 2004 09:41:47 -0500
From: Robin Holt <holt@sgi.com>
To: Anton Blanchard <anton@samba.org>
Cc: Christoph Lameter <christoph@lameter.com>, Paul Jackson <pj@sgi.com>,
       simon.derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] 1/2 Additional cpuset features
Message-ID: <20040924144147.GA14367@lnx-holt.americas.sgi.com>
References: <Pine.LNX.4.58.0409101036090.2891@daphne.frec.bull.fr> <20040911010808.2b283c9a.pj@sgi.com> <Pine.LNX.4.58.0409231238350.11694@server.home> <20040923164139.506d65d3.pj@sgi.com> <Pine.LNX.4.58.0409231651550.17168@server.home> <20040924011751.GA20592@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924011751.GA20592@krispykreme>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 11:17:51AM +1000, Anton Blanchard wrote:
>  
> Hi,
> 
> > > But the jist of the matter is simple.  Just as we (SGI) did with
> > > cpumemsets and perfmon on 2.4 kernels, so should we do with cpusets and
> > > perfmon on 2.6 kernels.  And that is to perform this translation in
> > > perfmon code.  Is it only SGI's dplace that requires the cpuset-relative
> > > numbering?
> > 
> > pfmon, sched_setaffinity, dplace. And this is only what I saw today.
> > Might develop into a longer list. The 2.4 solutions were rather
> > complicated.
> 
> Are pfmon and dplace SGI specific? sched_affinity users already have to
> deal with potentially discontiguous cpu maps. Ive been teaching IBM
> applications about this fact as I find problems.
> 

pfmon comes from HP's perfmon package.  dplace is an SGI specific that is
being open sourced.  It allows very complex process placement within a
cpuset.  It uses process aggregates to migrate processes based upon stuff
like number of invocations of this name goes to this relative cpu.

Paul, aren't we going to adjust dplace so it uses the user libraries to
interpret the relative placement information provided in the application's
configuration file into kernel logical cpus before passing that into the
kernel module?

> > > The kernel-user boundary should stick to a single, system-wide, numbering
> > > of CPUs.
> > 
> > That leads to lots of complicated scripts doing logical -> physical
> > translation with the danger of access or attempting accesses to not
> > allowed CPUs. It may be easier to contain tasks into a range of cpus if
> > the CPUs in use are easily enumerable.
> 
> I would think you could write this in your userspace library.
> 
> > The patch would allow the use of the existing tools as if the machine
> > only had N cpus (as you said a soft partitioning of the machine). If
> > scripts are to be used with the current approach then they need to know
> > about all the CPUs in the system and perform the mapping. Its going to be
> > a nightmare to develop scripts that partition off a 512 cpu cluster
> > appropriately and that track the physical cpu numbers instead of the cpu
> > number within the cpuset.
> 
> What happens when an application (or user) looks in /proc/cpuinfo?
> And how does /sys/.../cpus match? Also what happens when you hotplug out 
> a cpu and your memory map becomes discontiguous? 
> 
> Anton
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
